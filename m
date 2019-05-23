Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C3728285
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfEWQRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:17:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfEWQRN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:17:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65A4CAC2E5;
        Thu, 23 May 2019 16:17:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC72359474;
        Thu, 23 May 2019 16:17:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/23] nfs: don't bother passing nfs_subversion to
 ->try_mount() and nfs_fs_mount_common()
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:17:10 +0100
Message-ID: <155862823013.26654.3191093337797115762.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 23 May 2019 16:17:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/internal.h       |    6 ++----
 fs/nfs/nfs4_fs.h        |    2 +-
 fs/nfs/nfs4super.c      |    5 ++---
 fs/nfs/super.c          |   19 ++++++++-----------
 include/linux/nfs_xdr.h |    3 +--
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 62af450bb91a..47ed7e4b4171 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -400,12 +400,10 @@ extern struct file_system_type nfs_xdev_fs_type;
 extern struct file_system_type nfs4_referral_fs_type;
 #endif
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
-struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *,
-			struct nfs_subversion *);
+struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
 int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
-struct dentry *nfs_fs_mount_common(int, const char *,
-				   struct nfs_mount_info *, struct nfs_subversion *);
+struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mount_info *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
 struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
 		const char *, struct nfs_mount_info *);
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 8a38a254f516..0bd8a5fc140b 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -516,7 +516,7 @@ extern const nfs4_stateid invalid_stateid;
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
-struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *, struct nfs_subversion *);
+struct dentry *nfs4_try_mount(int, const char *, struct nfs_mount_info *);
 extern bool nfs4_disable_idmapping;
 extern unsigned short max_session_slots;
 extern unsigned short max_session_cb_slots;
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 25253c235fba..4a57fe53cf32 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -97,7 +97,7 @@ static struct dentry *
 nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 		  const char *dev_name, void *info)
 {
-	return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
+	return nfs_fs_mount_common(flags, dev_name, info);
 }
 
 struct nfs_referral_count {
@@ -215,8 +215,7 @@ static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
 }
 
 struct dentry *nfs4_try_mount(int flags, const char *dev_name,
-			      struct nfs_mount_info *mount_info,
-			      struct nfs_subversion *nfs_mod)
+			      struct nfs_mount_info *mount_info)
 {
 	struct nfs_parsed_mount_data *data = mount_info->parsed;
 	struct dentry *res;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index c76b4fe73fab..a713b70bfec4 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1871,15 +1871,15 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 }
 
 struct dentry *nfs_try_mount(int flags, const char *dev_name,
-			     struct nfs_mount_info *mount_info,
-			     struct nfs_subversion *nfs_mod)
+			     struct nfs_mount_info *mount_info)
 {
+	struct nfs_subversion *nfs_mod = mount_info->nfs_mod;
 	if (mount_info->parsed->need_mount)
 		mount_info->server = nfs_try_mount_request(mount_info, nfs_mod);
 	else
 		mount_info->server = nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
 
-	return nfs_fs_mount_common(flags, dev_name, mount_info, nfs_mod);
+	return nfs_fs_mount_common(flags, dev_name, mount_info);
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
 
@@ -2600,8 +2600,7 @@ int nfs_clone_sb_security(struct super_block *s, struct dentry *mntroot,
 EXPORT_SYMBOL_GPL(nfs_clone_sb_security);
 
 struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
-				   struct nfs_mount_info *mount_info,
-				   struct nfs_subversion *nfs_mod)
+				   struct nfs_mount_info *mount_info)
 {
 	struct super_block *s;
 	struct dentry *mntroot = ERR_PTR(-ENOMEM);
@@ -2629,7 +2628,8 @@ struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 			sb_mntdata.mntflags |= SB_SYNCHRONOUS;
 
 	/* Get a superblock - note that we may end up sharing one that already exists */
-	s = sget(nfs_mod->nfs_fs, compare_super, nfs_set_super, flags, &sb_mntdata);
+	s = sget(mount_info->nfs_mod->nfs_fs, compare_super, nfs_set_super,
+		 flags, &sb_mntdata);
 	if (IS_ERR(s)) {
 		mntroot = ERR_CAST(s);
 		goto out_err_nosb;
@@ -2715,7 +2715,7 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 	}
 	mount_info.nfs_mod = nfs_mod;
 
-	mntroot = nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info, nfs_mod);
+	mntroot = nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info);
 
 	put_nfs_version(nfs_mod);
 out:
@@ -2749,10 +2749,7 @@ static struct dentry *
 nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 		const char *dev_name, void *raw_data)
 {
-	struct nfs_mount_info *info = raw_data;
-	struct nfs_subversion *nfs_mod = NFS_SB(info->cloned->sb)->nfs_client->cl_nfs_mod;
-
-	return nfs_fs_mount_common(flags, dev_name, info, nfs_mod);
+	return nfs_fs_mount_common(flags, dev_name, raw_data);
 }
 
 #if IS_ENABLED(CONFIG_NFS_V4)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9b8324ec08f3..4fdf4a523185 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1638,8 +1638,7 @@ struct nfs_rpc_ops {
 			    struct nfs_fsinfo *);
 	struct vfsmount *(*submount) (struct nfs_server *, struct dentry *,
 				      struct nfs_fh *, struct nfs_fattr *);
-	struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *,
-				     struct nfs_subversion *);
+	struct dentry *(*try_mount) (int, const char *, struct nfs_mount_info *);
 	int	(*getattr) (struct nfs_server *, struct nfs_fh *,
 			    struct nfs_fattr *, struct nfs4_label *,
 			    struct inode *);

