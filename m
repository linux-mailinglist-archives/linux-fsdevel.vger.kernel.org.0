Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC01BB1D6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfIMMS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbfIMMRu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:17:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06267C06511C;
        Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF89460C63;
        Fri, 13 Sep 2019 12:17:49 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id CCA5020C2F; Fri, 13 Sep 2019 08:17:48 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/26] nfs: merge xdev and remote file_system_type
Date:   Fri, 13 Sep 2019 08:17:32 -0400
Message-Id: <20190913121748.25391-11-smayhew@redhat.com>
In-Reply-To: <20190913121748.25391-1-smayhew@redhat.com>
References: <20190913121748.25391-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

they are identical now...

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  2 +-
 fs/nfs/namespace.c |  2 +-
 fs/nfs/nfs4super.c | 22 +---------------------
 fs/nfs/super.c     | 14 ++++++++------
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 3334d0f3ecf9..ac3478827a83 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -396,7 +396,7 @@ extern int nfs_wait_atomic_killable(atomic_t *p, unsigned int mode);
 /* super.c */
 extern const struct super_operations nfs_sops;
 extern struct file_system_type nfs_fs_type;
-extern struct file_system_type nfs_xdev_fs_type;
+extern struct file_system_type nfs_prepared_fs_type;
 #if IS_ENABLED(CONFIG_NFS_V4)
 extern struct file_system_type nfs4_referral_fs_type;
 #endif
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 0d0587ed7d94..970f92a860ed 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -254,7 +254,7 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 	if (IS_ERR(devname))
 		mnt = ERR_CAST(devname);
 	else
-		mnt = vfs_submount(dentry, &nfs_xdev_fs_type, devname, &mount_info);
+		mnt = vfs_submount(dentry, &nfs_prepared_fs_type, devname, &mount_info);
 
 	if (mount_info.server)
 		nfs_free_server(mount_info.server);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 83bca2ea566c..5bca30f704e4 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -18,19 +18,9 @@
 
 static int nfs4_write_inode(struct inode *inode, struct writeback_control *wbc);
 static void nfs4_evict_inode(struct inode *inode);
-static struct dentry *nfs4_remote_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data);
 static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *raw_data);
 
-static struct file_system_type nfs4_remote_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs4",
-	.mount		= nfs4_remote_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-
 struct file_system_type nfs4_referral_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "nfs4",
@@ -91,16 +81,6 @@ static void nfs4_evict_inode(struct inode *inode)
 	nfs_clear_inode(inode);
 }
 
-/*
- * Get the superblock for the NFS4 root partition
- */
-static struct dentry *
-nfs4_remote_mount(struct file_system_type *fs_type, int flags,
-		  const char *dev_name, void *info)
-{
-	return nfs_fs_mount_common(flags, dev_name, info);
-}
-
 struct nfs_referral_count {
 	struct list_head list;
 	const struct task_struct *task;
@@ -194,7 +174,7 @@ static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
 	else
 		snprintf(root_devname, len, "%s:/", hostname);
 	info->server = server;
-	root_mnt = vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, info);
+	root_mnt = vfs_kern_mount(&nfs_prepared_fs_type, flags, root_devname, info);
 	if (info->server)
 		nfs_free_server(info->server);
 	info->server = NULL;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index ca6295945880..d80992d2b6fe 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -293,7 +293,7 @@ static match_table_t nfs_vers_tokens = {
 	{ Opt_vers_err, NULL }
 };
 
-static struct dentry *nfs_xdev_mount(struct file_system_type *fs_type,
+static struct dentry *nfs_prepared_mount(struct file_system_type *fs_type,
 		int flags, const char *dev_name, void *raw_data);
 
 struct file_system_type nfs_fs_type = {
@@ -306,13 +306,14 @@ struct file_system_type nfs_fs_type = {
 MODULE_ALIAS_FS("nfs");
 EXPORT_SYMBOL_GPL(nfs_fs_type);
 
-struct file_system_type nfs_xdev_fs_type = {
+struct file_system_type nfs_prepared_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "nfs",
-	.mount		= nfs_xdev_mount,
+	.mount		= nfs_prepared_mount,
 	.kill_sb	= nfs_kill_super,
 	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
 };
+EXPORT_SYMBOL_GPL(nfs_prepared_fs_type);
 
 const struct super_operations nfs_sops = {
 	.alloc_inode	= nfs_alloc_inode,
@@ -2766,11 +2767,12 @@ void nfs_kill_super(struct super_block *s)
 EXPORT_SYMBOL_GPL(nfs_kill_super);
 
 /*
- * Clone an NFS2/3/4 server record on xdev traversal (FSID-change)
+ * Internal use only: mount_info is already set up by caller.
+ * Used for mountpoint crossings and for nfs4 root.
  */
 static struct dentry *
-nfs_xdev_mount(struct file_system_type *fs_type, int flags,
-		const char *dev_name, void *raw_data)
+nfs_prepared_mount(struct file_system_type *fs_type, int flags,
+		   const char *dev_name, void *raw_data)
 {
 	return nfs_fs_mount_common(flags, dev_name, raw_data);
 }
-- 
2.17.2

