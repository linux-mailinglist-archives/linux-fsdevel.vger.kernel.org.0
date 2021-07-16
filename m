Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B383CB554
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhGPJk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 05:40:27 -0400
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:22594
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhGPJk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:40:26 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jul 2021 05:40:26 EDT
X-SMTP-MATCH: 0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATyZQ4a2U2q0zHeqTam8V0QqjBLIkLtp133?=
 =?us-ascii?q?Aq2lEZdPRUGvb3qynIpoV+6faUskd1ZJhOo7290cW7LU80lqQFg7X5X43SOz?=
 =?us-ascii?q?UO0VHAROoJ0WKL+UyHJ8SUzI5gPMlbHJSWcOeAbmSS9vya3DWF?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AdBwA6UPFg/y2ELHlQCh4BAQsSDEA?=
 =?us-ascii?q?JgUULAoN2bIQCRpATAQEBAQEBBowphW9fiikUgWgLAQEBAQEBAQEBSgQBAYR?=
 =?us-ascii?q?UAoJ8ASU0CQ4CBBUBAQEFAQEBAQEGAwGBDoV1QwEMAYV1BiMEUhAYDQIRBw4?=
 =?us-ascii?q?CAkcQBgEShVMlp2d/MxoCZYpDgRAqAYcIgmiDeiccfYEQgUgDgy2DfRpsgli?=
 =?us-ascii?q?CZASDGIEPNHyBD5UMAUaKGVudDIMunmQXlU8DkHWWCKcOghRNLgqDJFAZjjk?=
 =?us-ascii?q?Wjjo3LzgCBgoBAQMJgnKHIieCHgEB?=
X-IPAS-Result: =?us-ascii?q?A2AdBwA6UPFg/y2ELHlQCh4BAQsSDEAJgUULAoN2bIQCR?=
 =?us-ascii?q?pATAQEBAQEBBowphW9fiikUgWgLAQEBAQEBAQEBSgQBAYRUAoJ8ASU0CQ4CB?=
 =?us-ascii?q?BUBAQEFAQEBAQEGAwGBDoV1QwEMAYV1BiMEUhAYDQIRBw4CAkcQBgEShVMlp?=
 =?us-ascii?q?2d/MxoCZYpDgRAqAYcIgmiDeiccfYEQgUgDgy2DfRpsgliCZASDGIEPNHyBD?=
 =?us-ascii?q?5UMAUaKGVudDIMunmQXlU8DkHWWCKcOghRNLgqDJFAZjjkWjjo3LzgCBgoBA?=
 =?us-ascii?q?QMJgnKHIieCHgEB?=
X-IronPort-AV: E=Sophos;i="5.84,244,1620662400"; 
   d="scan'208";a="329873560"
Received: from unknown (HELO web.messagingengine.com) ([121.44.132.45])
  by icp-osb-irony-out9.iinet.net.au with ESMTP; 16 Jul 2021 17:28:19 +0800
Subject: [PATCH v8 1/5] kernfs: add a revision to identify directory node
 changes
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Jul 2021 17:28:18 +0800
Message-ID: <162642769895.63632.8356662784964509867.stgit@web.messagingengine.com>
In-Reply-To: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
References: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a revision counter to kernfs directory nodes so it can be used
to detect if a directory node has changed during negative dentry
revalidation.

There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
on all architectures and as far as I know that assumption holds.

So adding a revision counter to the struct kernfs_elem_dir variant of
the kernfs_node type union won't increase the size of the kernfs_node
struct. This is because struct kernfs_elem_dir is at least
sizeof(pointer) smaller than the largest union variant. It's tempting
to make the revision counter a u64 but that would increase the size of
kernfs_node on archs where sizeof(pointer) is smaller than the revision
counter.

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/dir.c             |    2 ++
 fs/kernfs/kernfs-internal.h |   19 +++++++++++++++++++
 include/linux/kernfs.h      |    5 +++++
 3 files changed, 26 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 33166ec90a11..b3d1bc0f317d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	/* successfully added, account subdir number */
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs++;
+	kernfs_inc_rev(kn->parent);
 
 	return 0;
 }
@@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs--;
+	kernfs_inc_rev(kn->parent);
 
 	rb_erase(&kn->rb, &kn->parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index ccc3b44f6306..c2ae58f3b202 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -81,6 +81,25 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 	return d_inode(dentry)->i_private;
 }
 
+static inline void kernfs_set_rev(struct kernfs_node *parent,
+				  struct dentry *dentry)
+{
+	dentry->d_time = parent->dir.rev;
+}
+
+static inline void kernfs_inc_rev(struct kernfs_node *parent)
+{
+	parent->dir.rev++;
+}
+
+static inline bool kernfs_dir_changed(struct kernfs_node *parent,
+				      struct dentry *dentry)
+{
+	if (parent->dir.rev != dentry->d_time)
+		return true;
+	return false;
+}
+
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9e8ca8743c26..d68b4ad09573 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -98,6 +98,11 @@ struct kernfs_elem_dir {
 	 * better directly in kernfs_node but is here to save space.
 	 */
 	struct kernfs_root	*root;
+	/*
+	 * Monotonic revision counter, used to identify if a directory
+	 * node has changed during negative dentry revalidation.
+	 */
+	unsigned long		rev;
 };
 
 struct kernfs_elem_symlink {


