Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB415B0165
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfIKQSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:18:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbfIKQQX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:16:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA2FD8980E2;
        Wed, 11 Sep 2019 16:16:22 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C40419C70;
        Wed, 11 Sep 2019 16:16:22 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 06B5620A3B; Wed, 11 Sep 2019 12:16:22 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/26] nfs: stash server into struct nfs_mount_info
Date:   Wed, 11 Sep 2019 12:15:57 -0400
Message-Id: <20190911161621.19832-3-smayhew@redhat.com>
In-Reply-To: <20190911161621.19832-1-smayhew@redhat.com>
References: <20190911161621.19832-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 11 Sep 2019 16:16:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  |  3 ++-
 fs/nfs/nfs4super.c | 10 ++++------
 fs/nfs/super.c     | 19 ++++++++-----------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a2346a2f8361..c132e683e1c9 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -150,6 +150,7 @@ struct nfs_mount_info {
 	int (*set_security)(struct super_block *, struct dentry *, struct nfs_mount_info *);
 	struct nfs_parsed_mount_data *parsed;
 	struct nfs_clone_mount *cloned;
+	struct nfs_server *server;
 	struct nfs_fh *mntfh;
 };
 
@@ -405,7 +406,7 @@ struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *,
 			struct nfs_subversion *);
 int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
-struct dentry *nfs_fs_mount_common(struct nfs_server *, int, const char *,
+struct dentry *nfs_fs_mount_common(int, const char *,
 				   struct nfs_mount_info *, struct nfs_subversion *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
 struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index baece9857bcf..4591d6618efa 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -109,13 +109,12 @@ nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 		  const char *dev_name, void *info)
 {
 	struct nfs_mount_info *mount_info = info;
-	struct nfs_server *server;
 
 	mount_info->set_security = nfs_set_sb_security;
 
 	/* Get a volume representation */
-	server = nfs4_create_server(mount_info, &nfs_v4);
-	return nfs_fs_mount_common(server, flags, dev_name, mount_info, &nfs_v4);
+	mount_info->server = nfs4_create_server(mount_info, &nfs_v4);
+	return nfs_fs_mount_common(flags, dev_name, mount_info, &nfs_v4);
 }
 
 static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type,
@@ -260,7 +259,6 @@ nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
 		.set_security = nfs_clone_sb_security,
 		.cloned = raw_data,
 	};
-	struct nfs_server *server;
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
 
 	dprintk("--> nfs4_referral_get_sb()\n");
@@ -270,8 +268,8 @@ nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
 		goto out;
 
 	/* create a new volume representation */
-	server = nfs4_create_referral_server(mount_info.cloned, mount_info.mntfh);
-	mntroot = nfs_fs_mount_common(server, flags, dev_name, &mount_info, &nfs_v4);
+	mount_info.server = nfs4_create_referral_server(mount_info.cloned, mount_info.mntfh);
+	mntroot = nfs_fs_mount_common(flags, dev_name, &mount_info, &nfs_v4);
 out:
 	nfs_free_fhandle(mount_info.mntfh);
 	return mntroot;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 467d7a636f0b..10544ef8de57 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1896,14 +1896,12 @@ struct dentry *nfs_try_mount(int flags, const char *dev_name,
 			     struct nfs_mount_info *mount_info,
 			     struct nfs_subversion *nfs_mod)
 {
-	struct nfs_server *server;
-
 	if (mount_info->parsed->need_mount)
-		server = nfs_try_mount_request(mount_info, nfs_mod);
+		mount_info->server = nfs_try_mount_request(mount_info, nfs_mod);
 	else
-		server = nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
+		mount_info->server = nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
 
-	return nfs_fs_mount_common(server, flags, dev_name, mount_info, nfs_mod);
+	return nfs_fs_mount_common(flags, dev_name, mount_info, nfs_mod);
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
 
@@ -2624,20 +2622,21 @@ int nfs_clone_sb_security(struct super_block *s, struct dentry *mntroot,
 }
 EXPORT_SYMBOL_GPL(nfs_clone_sb_security);
 
-struct dentry *nfs_fs_mount_common(struct nfs_server *server,
-				   int flags, const char *dev_name,
+struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 				   struct nfs_mount_info *mount_info,
 				   struct nfs_subversion *nfs_mod)
 {
 	struct super_block *s;
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
 	int (*compare_super)(struct super_block *, void *) = nfs_compare_super;
+	struct nfs_server *server = mount_info->server;
 	struct nfs_sb_mountdata sb_mntdata = {
 		.mntflags = flags,
 		.server = server,
 	};
 	int error;
 
+	mount_info->server = NULL;
 	if (IS_ERR(server))
 		return ERR_CAST(server);
 
@@ -2778,7 +2777,6 @@ nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 		.set_security = nfs_clone_sb_security,
 		.cloned = data,
 	};
-	struct nfs_server *server;
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
 	struct nfs_subversion *nfs_mod = NFS_SB(data->sb)->nfs_client->cl_nfs_mod;
 
@@ -2787,10 +2785,9 @@ nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 	mount_info.mntfh = mount_info.cloned->fh;
 
 	/* create a new volume representation */
-	server = nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), data->fh, data->fattr, data->authflavor);
+	mount_info.server = nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), data->fh, data->fattr, data->authflavor);
 
-	mntroot = nfs_fs_mount_common(server, flags,
-				dev_name, &mount_info, nfs_mod);
+	mntroot = nfs_fs_mount_common(flags, dev_name, &mount_info, nfs_mod);
 
 	dprintk("<-- nfs_xdev_mount() = %ld\n",
 			IS_ERR(mntroot) ? PTR_ERR(mntroot) : 0L);
-- 
2.17.2

