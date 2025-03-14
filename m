Return-Path: <linux-fsdevel+bounces-43995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2CEA6082A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD0D189F634
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 04:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25213B2B8;
	Fri, 14 Mar 2025 04:57:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945BC34545;
	Fri, 14 Mar 2025 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928234; cv=none; b=rNngQSH0JTZ8/H0piMNdm2sRhoDQcXUy4njnYYKxkAb020Gmj1VZU2FEasmmdy3SVrhSUFFAK+FUiJkgt/FjI730yVuGtwYg10RvnltyTF2FlV2jJCKhAX4H5RkAiPwAeKVU7sAkCyE5VoZHltwQKfkjpPHKy8miLTGwUNB7+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928234; c=relaxed/simple;
	bh=pJMgeHFGHRX+0ofP3+P9Vi6llfSVTrBK7pociVBNG7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEEWc0+mgxO+XJYL/oCtAwTojpAFyZy1/te5Bg3kRUbeEvwi9dRo8CnIk8z51beWvxeKJnmkpnUC5MP7aLzFu/bzM0HVTU+RN6PKbZqDx0nL16dY8RrAtBhD68SLs2lVRTrC2CY1EaV2ayFPDsyopGAT+Ducb+M7ioO2DRj2v8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsx6a-00E3w9-GC;
	Fri, 14 Mar 2025 04:57:08 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/8] Use try_lookup_noperm() instead of d_hash_and_lookup() outside of VFS
Date: Fri, 14 Mar 2025 11:34:13 +1100
Message-ID: <20250314045655.603377-8-neil@brown.name>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314045655.603377-1-neil@brown.name>
References: <20250314045655.603377-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_lookup_noperm() and d_hash_and_lookup() are nearly identical.  The
former does some validation of the name wile the latter doesn't.
Outside of the VFS that validation is likely valuable, and having only
one exported function for this task is certainly a good idea.

So make d_hash_and_lookup() local to VFS files and change all other
callers to try_lookup_noperm().  Note that the arguments are swapped.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 11 +++++++++++
 fs/dcache.c                           |  1 -
 fs/efivarfs/super.c                   |  8 ++++----
 fs/internal.h                         |  1 +
 fs/proc/base.c                        |  2 +-
 fs/smb/client/readdir.c               |  3 ++-
 fs/xfs/scrub/orphanage.c              |  4 ++--
 include/linux/dcache.h                |  1 -
 net/sunrpc/rpc_pipe.c                 | 12 ++++++------
 security/selinux/selinuxfs.c          |  4 ++--
 10 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 49a7be912e5f..672cd427d1e4 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1226,3 +1226,14 @@ checked that the caller has 'X' permission on the parent.  They must
 ONLY be used internally by a filesystem on itself when it knows that
 permissions are irrelevant or in a context where permission checks have
 already been performed such as after vfs_path_parent_lookup()
+
+---
+
+** mandatory**
+
+d_hash_and_lookup() is no longer exported or available outside the VFS.
+Use try_lookup_noperm() instead.  This adds name validation and takes
+arguments in the opposite order but is otherwise identical.
+
+Using try_lookup_noperm() will require linux/namei.h to be included.
+
diff --git a/fs/dcache.c b/fs/dcache.c
index 726a5be2747b..17f8e0b7f04f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2395,7 +2395,6 @@ struct dentry *d_hash_and_lookup(struct dentry *dir, struct qstr *name)
 	}
 	return d_lookup(dir, name);
 }
-EXPORT_SYMBOL(d_hash_and_lookup);
 
 /*
  * When a file is deleted, we have two options:
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 09fcf731e65d..c16206581b2d 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -219,7 +219,7 @@ bool efivarfs_variable_is_present(efi_char16_t *variable_name,
 
 	qstr.name = name;
 	qstr.len = strlen(name);
-	dentry = d_hash_and_lookup(sb->s_root, &qstr);
+	dentry = try_lookup_noperm(&qstr, sb->s_root);
 	kfree(name);
 	if (!IS_ERR_OR_NULL(dentry))
 		dput(dentry);
@@ -402,8 +402,8 @@ static bool efivarfs_actor(struct dir_context *ctx, const char *name, int len,
 {
 	unsigned long size;
 	struct efivarfs_ctx *ectx = container_of(ctx, struct efivarfs_ctx, ctx);
-	struct qstr qstr = { .name = name, .len = len };
-	struct dentry *dentry = d_hash_and_lookup(ectx->sb->s_root, &qstr);
+	struct qstr qstr = QSTR_INIT(name, len);
+	struct dentry *dentry = try_lookup_noperm(&qstr, ectx->sb->s_root);
 	struct inode *inode;
 	struct efivar_entry *entry;
 	int err;
@@ -451,7 +451,7 @@ static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,
 
 	qstr.name = name;
 	qstr.len = strlen(name);
-	dentry = d_hash_and_lookup(sb->s_root, &qstr);
+	dentry = try_lookup_noperm(&qstr, sb->s_root);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out;
diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..c21534a23196 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -66,6 +66,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
+struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
 
 /*
  * namespace.c
diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..7d36c7567c31 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2124,7 +2124,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	unsigned type = DT_UNKNOWN;
 	ino_t ino = 1;
 
-	child = d_hash_and_lookup(dir, &qname);
+	child = try_lookup_noperm(&qname, dir);
 	if (!child) {
 		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 		child = d_alloc_parallel(dir, &qname, &wq);
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 50f96259d9ad..7329ec532bcf 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -9,6 +9,7 @@
  *
  */
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
@@ -78,7 +79,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 
 	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
 
-	dentry = d_hash_and_lookup(parent, name);
+	dentry = try_lookup_noperm(name, parent);
 	if (!dentry) {
 		/*
 		 * If we know that the inode will need to be revalidated
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 987af5b2bb82..f42ffad5a7b9 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -444,7 +444,7 @@ xrep_adoption_check_dcache(
 	if (!d_orphanage)
 		return 0;
 
-	d_child = d_hash_and_lookup(d_orphanage, &qname);
+	d_child = try_lookup_noperm(&qname, d_orphanage);
 	if (d_child) {
 		trace_xrep_adoption_check_child(sc->mp, d_child);
 
@@ -481,7 +481,7 @@ xrep_adoption_zap_dcache(
 	if (!d_orphanage)
 		return;
 
-	d_child = d_hash_and_lookup(d_orphanage, &qname);
+	d_child = try_lookup_noperm(&qname, d_orphanage);
 	while (d_child != NULL) {
 		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 1f01f4e734c5..cf37ae54955d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -288,7 +288,6 @@ extern void d_exchange(struct dentry *, struct dentry *);
 extern struct dentry *d_ancestor(struct dentry *, struct dentry *);
 
 extern struct dentry *d_lookup(const struct dentry *, const struct qstr *);
-extern struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
 
 static inline unsigned d_count(const struct dentry *dentry)
 {
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index eadc00410ebc..98f78cd55905 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -631,7 +631,7 @@ static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
 					  const char *name)
 {
 	struct qstr q = QSTR(name);
-	struct dentry *dentry = d_hash_and_lookup(parent, &q);
+	struct dentry *dentry = try_lookup_noperm(&q, parent);
 	if (!dentry) {
 		dentry = d_alloc(parent, &q);
 		if (!dentry)
@@ -658,7 +658,7 @@ static void __rpc_depopulate(struct dentry *parent,
 	for (i = start; i < eof; i++) {
 		name.name = files[i].name;
 		name.len = strlen(files[i].name);
-		dentry = d_hash_and_lookup(parent, &name);
+		dentry = try_lookup_noperm(&name, parent);
 
 		if (dentry == NULL)
 			continue;
@@ -1190,7 +1190,7 @@ static const struct rpc_filelist files[] = {
 struct dentry *rpc_d_lookup_sb(const struct super_block *sb,
 			       const unsigned char *dir_name)
 {
-	return d_hash_and_lookup(sb->s_root, &QSTR(dir_name));
+	return try_lookup_noperm(&QSTR(dir_name), sb->s_root);
 }
 EXPORT_SYMBOL_GPL(rpc_d_lookup_sb);
 
@@ -1301,7 +1301,7 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	struct dentry *pipe_dentry = NULL;
 
 	/* We should never get this far if "gssd" doesn't exist */
-	gssd_dentry = d_hash_and_lookup(root, &QSTR(files[RPCAUTH_gssd].name));
+	gssd_dentry = try_lookup_noperm(&QSTR(files[RPCAUTH_gssd].name), root);
 	if (!gssd_dentry)
 		return ERR_PTR(-ENOENT);
 
@@ -1311,8 +1311,8 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 		goto out;
 	}
 
-	clnt_dentry = d_hash_and_lookup(gssd_dentry,
-					&QSTR(gssd_dummy_clnt_dir[0].name));
+	clnt_dentry = try_lookup_noperm(&QSTR(gssd_dummy_clnt_dir[0].name),
+					  gssd_dentry);
 	if (!clnt_dentry) {
 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
 		pipe_dentry = ERR_PTR(-ENOENT);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 47480eb2189b..e67a8ce4b64c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2158,8 +2158,8 @@ static int __init init_sel_fs(void)
 		return err;
 	}
 
-	selinux_null.dentry = d_hash_and_lookup(selinux_null.mnt->mnt_root,
-						&null_name);
+	selinux_null.dentry = try_lookup_noperm(&null_name,
+						  selinux_null.mnt->mnt_root);
 	if (IS_ERR(selinux_null.dentry)) {
 		pr_err("selinuxfs:  could not lookup null!\n");
 		err = PTR_ERR(selinux_null.dentry);
-- 
2.48.1


