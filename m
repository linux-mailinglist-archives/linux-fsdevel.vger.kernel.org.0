Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321CD28289
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfEWQRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:17:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfEWQRV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:17:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30448916C0;
        Thu, 23 May 2019 16:17:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EFAA62516;
        Thu, 23 May 2019 16:17:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/23] nfs: merge xdev and remote file_system_type
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:17:18 +0100
Message-ID: <155862823863.26654.16960229891755463792.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 23 May 2019 16:17:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

they are identical now...

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/internal.h  |    2 +-
 fs/nfs/namespace.c |    2 +-
 fs/nfs/nfs4super.c |   22 +---------------------
 fs/nfs/super.c     |   14 ++++++++------
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 47ed7e4b4171..3acf786fce57 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -395,7 +395,7 @@ extern int nfs_wait_atomic_killable(atomic_t *p, unsigned int mode);
 /* super.c */
 extern const struct super_operations nfs_sops;
 extern struct file_system_type nfs_fs_type;
-extern struct file_system_type nfs_xdev_fs_type;
+extern struct file_system_type nfs_prepared_fs_type;
 #if IS_ENABLED(CONFIG_NFS_V4)
 extern struct file_system_type nfs4_referral_fs_type;
 #endif
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 476f4c0d5542..7cda42ae000a 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -253,7 +253,7 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 	if (IS_ERR(devname))
 		mnt = ERR_CAST(devname);
 	else
-		mnt = vfs_submount(dentry, &nfs_xdev_fs_type, devname, &mount_info);
+		mnt = vfs_submount(dentry, &nfs_prepared_fs_type, devname, &mount_info);
 
 	if (mount_info.server)
 		nfs_free_server(mount_info.server);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 4a57fe53cf32..32b602e87bb5 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -17,19 +17,9 @@
 
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
@@ -90,16 +80,6 @@ static void nfs4_evict_inode(struct inode *inode)
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
@@ -193,7 +173,7 @@ static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
 	else
 		snprintf(root_devname, len, "%s:/", hostname);
 	info->server = server;
-	root_mnt = vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, info);
+	root_mnt = vfs_kern_mount(&nfs_prepared_fs_type, flags, root_devname, info);
 	if (info->server)
 		nfs_free_server(info->server);
 	info->server = NULL;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index a713b70bfec4..e189d640fb4f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -287,7 +287,7 @@ static match_table_t nfs_vers_tokens = {
 	{ Opt_vers_err, NULL }
 };
 
-static struct dentry *nfs_xdev_mount(struct file_system_type *fs_type,
+static struct dentry *nfs_prepared_mount(struct file_system_type *fs_type,
 		int flags, const char *dev_name, void *raw_data);
 
 struct file_system_type nfs_fs_type = {
@@ -300,13 +300,14 @@ struct file_system_type nfs_fs_type = {
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
@@ -2743,11 +2744,12 @@ void nfs_kill_super(struct super_block *s)
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

