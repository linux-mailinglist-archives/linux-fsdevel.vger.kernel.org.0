Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39D93CB55A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 11:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhGPJkl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 05:40:41 -0400
Received: from icp-osb-irony-out9.external.iinet.net.au ([203.59.1.226]:22594
        "EHLO icp-osb-irony-out9.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234143AbhGPJkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:40:39 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jul 2021 05:40:26 EDT
X-SMTP-MATCH: 0
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8kqwx6Mh05j+ysBcTuqjsMiBIKoaSvp037?=
 =?us-ascii?q?BL7SBMoHluGfBw+PrFoB1273LJYVUqOU3I++ruBEDoexq1yXcf2+cs1NmZMD?=
 =?us-ascii?q?UPOAOTXeJfBQiL+UyYJ8XUndQtt5uJecNFeaXN5d8Tt7ec3OE7e+xQpuVucc?=
 =?us-ascii?q?iT9ILjJ/IEd3APV51d?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AbBwA6UPFg/y2ELHlaHgEBCxIMQAm?=
 =?us-ascii?q?BRQsCgXSCAmyEAkaQEwEBAQEBAQaBQIpphW9fiimBfAsBAQEBAQEBAQFKBAE?=
 =?us-ascii?q?BhFQCgnwBJTQJDgIEFQEBAQUBAQEBAQYDAYEOhXVDAQwBhXUGIwRSEBgNAhg?=
 =?us-ascii?q?OAgJHEAYBEoVTJadnfzMaAmWKQ4EQKgGHCIJog3onHH2BEIFIA4EFgiiHW4J?=
 =?us-ascii?q?kBIIlcgEtYnsEJwoqJUArO5QmAUaIbYEsW50Mgy6eZBeDTJIDAxaQXy2McIh?=
 =?us-ascii?q?rghykcoIUTS4KgyRQGZ0JNy84AgYKAQEDCYJyiWcBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AbBwA6UPFg/y2ELHlaHgEBCxIMQAmBRQsCgXSCAmyEA?=
 =?us-ascii?q?kaQEwEBAQEBAQaBQIpphW9fiimBfAsBAQEBAQEBAQFKBAEBhFQCgnwBJTQJD?=
 =?us-ascii?q?gIEFQEBAQUBAQEBAQYDAYEOhXVDAQwBhXUGIwRSEBgNAhgOAgJHEAYBEoVTJ?=
 =?us-ascii?q?adnfzMaAmWKQ4EQKgGHCIJog3onHH2BEIFIA4EFgiiHW4JkBIIlcgEtYnsEJ?=
 =?us-ascii?q?woqJUArO5QmAUaIbYEsW50Mgy6eZBeDTJIDAxaQXy2McIhrghykcoIUTS4Kg?=
 =?us-ascii?q?yRQGZ0JNy84AgYKAQEDCYJyiWcBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,244,1620662400"; 
   d="scan'208";a="329873602"
Received: from unknown (HELO web.messagingengine.com) ([121.44.132.45])
  by icp-osb-irony-out9.iinet.net.au with ESMTP; 16 Jul 2021 17:28:34 +0800
Subject: [PATCH v8 4/5] kernfs: use i_lock to protect concurrent inode updates
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
Date:   Fri, 16 Jul 2021 17:28:34 +0800
Message-ID: <162642771474.63632.16295959115893904470.stgit@web.messagingengine.com>
In-Reply-To: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
References: <162642752894.63632.5596341704463755308.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode operations .permission() and .getattr() use the kernfs node
write lock but all that's needed is the read lock to protect against
partial updates of these kernfs node fields which are all done under
the write lock.

And .permission() is called frequently during path walks and can cause
quite a bit of contention between kernfs node operations and path
walks when the number of concurrent walks is high.

To change kernfs_iop_getattr() and kernfs_iop_permission() to take
the rw sem read lock instead of the write lock an additional lock is
needed to protect against multiple processes concurrently updating
the inode attributes and link count in kernfs_refresh_inode().

The inode i_lock seems like the sensible thing to use to protect these
inode attribute updates so use it in kernfs_refresh_inode().

The last hunk in the patch, applied to kernfs_fill_super(), is possibly
not needed but taking the lock was present originally. I prefer to
continue to take it to protect against a partial update of the source
kernfs fields during the call to kernfs_refresh_inode() made by
kernfs_get_inode().

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/inode.c |   18 ++++++++++++------
 fs/kernfs/mount.c |    4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index dad749f39518..c0eae1725435 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -185,11 +185,13 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
+	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
-
 	generic_fillattr(&init_user_ns, inode, stat);
+	spin_unlock(&inode->i_lock);
+	up_read(&kernfs_rwsem);
+
 	return 0;
 }
 
@@ -272,17 +274,21 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
 	struct kernfs_node *kn;
+	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
+	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	ret = generic_permission(&init_user_ns, inode, mask);
+	spin_unlock(&inode->i_lock);
+	up_read(&kernfs_rwsem);
 
-	return generic_permission(&init_user_ns, inode, mask);
+	return ret;
 }
 
 int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index baa4155ba2ed..f2f909d09f52 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -255,9 +255,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;


