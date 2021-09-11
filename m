Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6940748B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 03:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhIKCAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 22:00:52 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19026 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCAw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 22:00:52 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H5wn33HHtzbmBD;
        Sat, 11 Sep 2021 09:55:35 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 09:59:38 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 11 Sep
 2021 09:59:37 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>
CC:     <viro@ZenIV.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>
Subject: [PATCH] kernfs: fix the race in the creation of negative dentry
Date:   Sat, 11 Sep 2021 10:13:42 +0800
Message-ID: <20210911021342.3280687-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When doing stress test for module insertion and removal,
the following phenomenon was found:

  $ lsmod
  Module                  Size  Used by
  libkmod: kmod_module_get_holders: could not open \
           '/sys/module/nbd/holders': No such file or directory
  nbd                       -2  -2
  $ cat /proc/modules
  nbd 110592 0 - Live 0xffffffffc0298000
  $ ls -1 /sys/module |grep nbd
  ls: cannot access 'nbd': No such file or directory
  nbd

It seems the kernfs node of module has been activated and is returned to
ls command through kernfs_fop_readdir(), but the sysfs dentry is negative.
Further investigation found that there is race between kernfs dir creation
and dentry lookup as shown below:

CPU 0                          CPU 1

                        kernfs_add_one

                        down_write(&kernfs_rwsem)
                        // insert nbd into rbtree
                        // update the parent's revision
                        kernfs_link_sibling()
                        up_write(&kernfs_rwsem)

kernfs_iop_lookup

down_read(&kernfs_rwsem)
// find nbd in rbtree, but it is deactivated
kn = kernfs_find_ns()
  // return false
  kernfs_active()
  // a negative is created
  d_splice_alias(NULL, dentry)
up_read(&kernfs_rwsem)

                        // activate after negative dentry is created
                        kernfs_activate()

// return 0 because parent's
// revision is stable now
kernfs_dop_revalidate()

The race will create a negative dentry for a kernfs node which
is newly-added and activated. To fix it, there are two cases
to be handled:

(1) kernfs root without KERNFS_ROOT_CREATE_DEACTIVATED
kernfs_rwsem can be always hold during kernfs_link_sibling()
and kernfs_activate() in kernfs_add_one(), so kernfs_iop_lookup()
will find an active kernfs node.

(2) kernfs root with KERNFS_ROOT_CREATE_DEACTIVATED
kernfs_activate() is called separatedly, and we can invalidate
the dentry subtree with kn as root by increasing the revision of
its parent. But we can invalidate in a finer granularity by
only invalidating the negative dentry of the newly-activated
kn node.

So factor out a helper kernfs_activate_locked() to activate
kernfs subtree lockless and invalidate the negative dentries
if requested. Creation under kernfs root with CREATED_DEACTIVATED
doesn't need invalidation because kernfs_rwsem is always hold,
and kernfs root w/o CREATED_DEACTIVATED needs to invalidate
the maybe-created negative dentries.

kernfs_inc_rev() in kernfs_link_sibling() is kept because
kernfs_rename_ns() needs it to invalidate the negative dentry
of the target kernfs which is newly created by rename.

Fixes: c7e7c04274b1 ("kernfs: use VFS negative dentry caching")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/kernfs/dir.c | 52 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ba581429bf7b..2f1ab8bad575 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,6 +17,8 @@
 
 #include "kernfs-internal.h"
 
+static void kernfs_activate_locked(struct kernfs_node *kn, bool invalidate);
+
 DECLARE_RWSEM(kernfs_rwsem);
 static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
@@ -753,8 +755,6 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&kernfs_rwsem);
-
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
 	 * If not activated here, the kernfs user is responsible for
@@ -763,8 +763,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	 * trigger deactivation.
 	 */
 	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_CREATE_DEACTIVATED))
-		kernfs_activate(kn);
-	return 0;
+		kernfs_activate_locked(kn, false);
 
 out_unlock:
 	up_write(&kernfs_rwsem);
@@ -942,8 +941,11 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	root->kn = kn;
 	init_waitqueue_head(&root->deactivate_waitq);
 
-	if (!(root->flags & KERNFS_ROOT_CREATE_DEACTIVATED))
-		kernfs_activate(kn);
+	if (!(root->flags & KERNFS_ROOT_CREATE_DEACTIVATED)) {
+		down_write(&kernfs_rwsem);
+		kernfs_activate_locked(kn, false);
+		up_write(&kernfs_rwsem);
+	}
 
 	return root;
 }
@@ -1262,8 +1264,11 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 }
 
 /**
- * kernfs_activate - activate a node which started deactivated
+ * kernfs_activate_locked - activate a node which started deactivated
  * @kn: kernfs_node whose subtree is to be activated
+ * @invalidate: whether or not to increase the revision of parent node
+ *              for each newly-activated child node. The increase will
+ *              invalidate negative dentries created under the parent node.
  *
  * If the root has KERNFS_ROOT_CREATE_DEACTIVATED set, a newly created node
  * needs to be explicitly activated.  A node which hasn't been activated
@@ -1271,15 +1276,15 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
  * removal.  This is useful to construct atomic init sequences where
  * creation of multiple nodes should either succeed or fail atomically.
  *
+ * The caller must have acquired kernfs_rwsem.
+ *
  * The caller is responsible for ensuring that this function is not called
  * after kernfs_remove*() is invoked on @kn.
  */
-void kernfs_activate(struct kernfs_node *kn)
+static void kernfs_activate_locked(struct kernfs_node *kn, bool invalidate)
 {
 	struct kernfs_node *pos;
 
-	down_write(&kernfs_rwsem);
-
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
 		if (pos->flags & KERNFS_ACTIVATED)
@@ -1290,8 +1295,35 @@ void kernfs_activate(struct kernfs_node *kn)
 
 		atomic_sub(KN_DEACTIVATED_BIAS, &pos->active);
 		pos->flags |= KERNFS_ACTIVATED;
+
+		/*
+		 * Invalidate the negative dentry created after pos is
+		 * inserted into sibling rbtree but before it is
+		 * activated.
+		 */
+		if (invalidate && pos->parent)
+			kernfs_inc_rev(pos->parent);
 	}
+}
 
+/**
+ * kernfs_activate - activate a node which started deactivated
+ * @kn: kernfs_node whose subtree is to be activated
+ *
+ * Currently it is only used by kernfs root which has
+ * FS_ROOT_CREATE_DEACTIVATED set. Because the addition and the activation
+ * of children nodes are not atomic (not always hold kernfs_rwsem),
+ * negative dentry may be created for one child node after its addition
+ * but before its activation, so passing invalidate as true to
+ * @kernfs_activate_locked() to invalidate these negative dentries.
+ *
+ * The caller is responsible for ensuring that this function is not called
+ * after kernfs_remove*() is invoked on @kn.
+ */
+void kernfs_activate(struct kernfs_node *kn)
+{
+	down_write(&kernfs_rwsem);
+	kernfs_activate_locked(kn, true);
 	up_write(&kernfs_rwsem);
 }
 
-- 
2.29.2

