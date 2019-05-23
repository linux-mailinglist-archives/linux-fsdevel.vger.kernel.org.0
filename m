Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5F2827F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbfEWQQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:16:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfEWQQ6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:16:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E588128B5;
        Thu, 23 May 2019 16:16:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9164668369;
        Thu, 23 May 2019 16:16:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/23] nfs: lift setting mount_info from nfs_xdev_mount()
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:16:52 +0100
Message-ID: <155862821282.26654.17943634417357032949.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 23 May 2019 16:16:57 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Do it in nfs_do_submount() instead.  As a side benefit, nfs_clone_data
doesn't need ->fh and ->fattr anymore.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/internal.h  |    3 +--
 fs/nfs/namespace.c |   35 +++++++++++++++++++++--------------
 fs/nfs/super.c     |   25 ++++---------------------
 3 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ce00e61b9b2a..496a0e03f2b2 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -42,8 +42,6 @@ static inline int nfs_attr_use_mounted_on_fileid(struct nfs_fattr *fattr)
 struct nfs_clone_mount {
 	const struct super_block *sb;
 	const struct dentry *dentry;
-	struct nfs_fh *fh;
-	struct nfs_fattr *fattr;
 	char *hostname;
 	char *mnt_path;
 	struct sockaddr *addr;
@@ -412,6 +410,7 @@ struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
 		const char *, struct nfs_mount_info *);
 void nfs_kill_super(struct super_block *);
 void nfs_fill_super(struct super_block *, struct nfs_mount_info *);
+void nfs_clone_super(struct super_block *, struct nfs_mount_info *);
 
 extern struct rpc_stat nfs_rpcstat;
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 15f099a24c29..9622575682da 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -18,6 +18,7 @@
 #include <linux/vfs.h>
 #include <linux/sunrpc/gss_api.h>
 #include "internal.h"
+#include "nfs.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
@@ -209,16 +210,6 @@ void nfs_release_automount_timer(void)
 		cancel_delayed_work(&nfs_automount_task);
 }
 
-/*
- * Clone a mountpoint of the appropriate type
- */
-static struct vfsmount *nfs_do_clone_mount(struct nfs_server *server,
-					   const char *devname,
-					   struct nfs_clone_mount *mountdata)
-{
-	return vfs_submount(mountdata->dentry, &nfs_xdev_fs_type, devname, mountdata);
-}
-
 /**
  * nfs_do_submount - set up mountpoint when crossing a filesystem boundary
  * @dentry: parent directory
@@ -230,13 +221,20 @@ static struct vfsmount *nfs_do_clone_mount(struct nfs_server *server,
 struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 				 struct nfs_fattr *fattr, rpc_authflavor_t authflavor)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct nfs_clone_mount mountdata = {
-		.sb = dentry->d_sb,
+		.sb = sb,
 		.dentry = dentry,
-		.fh = fh,
-		.fattr = fattr,
 		.authflavor = authflavor,
 	};
+	struct nfs_mount_info mount_info = {
+		.fill_super = nfs_clone_super,
+		.set_security = nfs_clone_sb_security,
+		.cloned = &mountdata,
+		.mntfh = fh,
+	};
+	struct nfs_subversion *nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod;
+	struct nfs_server *server;
 	struct vfsmount *mnt;
 	char *page = (char *) __get_free_page(GFP_USER);
 	char *devname;
@@ -244,12 +242,21 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 	if (page == NULL)
 		return ERR_PTR(-ENOMEM);
 
+	server = nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
+						fattr, authflavor);
+	if (IS_ERR(server))
+		return ERR_CAST(server);
+
+	mount_info.server = server;
+
 	devname = nfs_devname(dentry, page, PAGE_SIZE);
 	if (IS_ERR(devname))
 		mnt = ERR_CAST(devname);
 	else
-		mnt = nfs_do_clone_mount(NFS_SB(dentry->d_sb), devname, &mountdata);
+		mnt = vfs_submount(dentry, &nfs_xdev_fs_type, devname, &mount_info);
 
+	if (mount_info.server)
+		nfs_free_server(mount_info.server);
 	free_page((unsigned long)page);
 	return mnt;
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 485604fa2ae3..f0a8f1da394b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2363,7 +2363,7 @@ EXPORT_SYMBOL_GPL(nfs_fill_super);
 /*
  * Finish setting up a cloned NFS2/3/4 superblock
  */
-static void nfs_clone_super(struct super_block *sb,
+void nfs_clone_super(struct super_block *sb,
 			    struct nfs_mount_info *mount_info)
 {
 	const struct super_block *old_sb = mount_info->cloned->sb;
@@ -2748,27 +2748,10 @@ static struct dentry *
 nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 		const char *dev_name, void *raw_data)
 {
-	struct nfs_clone_mount *data = raw_data;
-	struct nfs_mount_info mount_info = {
-		.fill_super = nfs_clone_super,
-		.set_security = nfs_clone_sb_security,
-		.cloned = data,
-	};
-	struct dentry *mntroot = ERR_PTR(-ENOMEM);
-	struct nfs_subversion *nfs_mod = NFS_SB(data->sb)->nfs_client->cl_nfs_mod;
-
-	dprintk("--> nfs_xdev_mount()\n");
+	struct nfs_mount_info *info = raw_data;
+	struct nfs_subversion *nfs_mod = NFS_SB(info->cloned->sb)->nfs_client->cl_nfs_mod;
 
-	mount_info.mntfh = mount_info.cloned->fh;
-
-	/* create a new volume representation */
-	mount_info.server = nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), data->fh, data->fattr, data->authflavor);
-
-	mntroot = nfs_fs_mount_common(flags, dev_name, &mount_info, nfs_mod);
-
-	dprintk("<-- nfs_xdev_mount() = %ld\n",
-			IS_ERR(mntroot) ? PTR_ERR(mntroot) : 0L);
-	return mntroot;
+	return nfs_fs_mount_common(flags, dev_name, info, nfs_mod);
 }
 
 #if IS_ENABLED(CONFIG_NFS_V4)

