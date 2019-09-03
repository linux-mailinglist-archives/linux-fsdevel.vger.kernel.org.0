Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F96A74D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 22:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfICUd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 16:33:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfICUcS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:32:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76AC687648;
        Tue,  3 Sep 2019 20:32:17 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 238DF5C207;
        Tue,  3 Sep 2019 20:32:17 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 8A3DB20BF9; Tue,  3 Sep 2019 16:32:15 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/26] nfs: lift setting mount_info from nfs_xdev_mount()
Date:   Tue,  3 Sep 2019 16:31:56 -0400
Message-Id: <20190903203215.9157-8-smayhew@redhat.com>
In-Reply-To: <20190903203215.9157-1-smayhew@redhat.com>
References: <20190903203215.9157-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 03 Sep 2019 20:32:17 +0000 (UTC)
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
 fs/nfs/internal.h  |  3 +--
 fs/nfs/namespace.c | 35 +++++++++++++++++++++--------------
 fs/nfs/super.c     | 25 ++++---------------------
 3 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index c132e683e1c9..eeb54b45875c 100644
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
@@ -413,6 +411,7 @@ struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
 		const char *, struct nfs_mount_info *);
 void nfs_kill_super(struct super_block *);
 void nfs_fill_super(struct super_block *, struct nfs_mount_info *);
+void nfs_clone_super(struct super_block *, struct nfs_mount_info *);
 
 extern struct rpc_stat nfs_rpcstat;
 
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 9287eb666322..7c78e6956639 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -19,6 +19,7 @@
 #include <linux/vfs.h>
 #include <linux/sunrpc/gss_api.h>
 #include "internal.h"
+#include "nfs.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
@@ -210,16 +211,6 @@ void nfs_release_automount_timer(void)
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
@@ -231,13 +222,20 @@ static struct vfsmount *nfs_do_clone_mount(struct nfs_server *server,
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
@@ -245,12 +243,21 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
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
index 10544ef8de57..7fc354207347 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2386,7 +2386,7 @@ EXPORT_SYMBOL_GPL(nfs_fill_super);
 /*
  * Finish setting up a cloned NFS2/3/4 superblock
  */
-static void nfs_clone_super(struct super_block *sb,
+void nfs_clone_super(struct super_block *sb,
 			    struct nfs_mount_info *mount_info)
 {
 	const struct super_block *old_sb = mount_info->cloned->sb;
@@ -2771,27 +2771,10 @@ static struct dentry *
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
-- 
2.17.2

