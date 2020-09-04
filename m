Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675B825DF15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgIDQGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgIDQFw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:52 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95FCF20796;
        Fri,  4 Sep 2020 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235552;
        bh=VZIr6WoW5h/Ep1Qz7hm5b5kAoPWHmgsepZzE6jPlRKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5KT8U0R22nJH2oipT1dev7MM+UNv1a60ixGKwTHn/OXP9PVQqyQWpkgu9Nce5mKP
         PXTDZDrm3yzSH2s/SMhMrGbd4XUwMzK/0ljxNeElxfZ938Y/DjaisUUCxI1+EX++tk
         H8jnIL55+9NcCqzKh5W3XuUpVf+C7xnABB9uHpBE=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 16/18] ceph: add support to readdir for encrypted filenames
Date:   Fri,  4 Sep 2020 12:05:35 -0400
Message-Id: <20200904160537.76663-17-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add helper functions for buffer management and for decrypting filenames
returned by the MDS. Wire those into the readdir codepaths.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 47 +++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 47 +++++++++++++++++++++++++++++
 fs/ceph/dir.c    | 77 ++++++++++++++++++++++++++++++++++++++++--------
 fs/ceph/inode.c  | 30 +++++++++++++++++--
 4 files changed, 186 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f4849f8b32df..8e6eb0ca0777 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -2,6 +2,7 @@
 #include <linux/ceph/ceph_debug.h>
 #include <linux/xattr.h>
 #include <linux/fscrypt.h>
+#include <linux/base64_fname.h>
 
 #include "super.h"
 #include "crypto.h"
@@ -130,3 +131,49 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 		ceph_pagelist_release(pagelist);
 	return ret;
 }
+
+int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
+			struct fscrypt_str *tname, struct fscrypt_str *oname)
+{
+	int ret, declen;
+	u32 save_len;
+	struct fscrypt_str myname = FSTR_INIT(NULL, 0);
+
+	if (!IS_ENCRYPTED(parent)) {
+		oname->name = name;
+		oname->len = len;
+		return 0;
+	}
+
+	ret = fscrypt_get_encryption_info(parent);
+	if (ret)
+		return ret;
+
+	if (tname) {
+		save_len = tname->len;
+	} else {
+		int err;
+
+		save_len = 0;
+		err = fscrypt_fname_alloc_buffer(NAME_MAX, &myname);
+		if (err)
+			return err;
+		tname = &myname;
+	}
+
+	declen = base64_decode_fname(name, len, tname->name);
+	if (declen < 0 || declen > NAME_MAX) {
+		ret = -EIO;
+		goto out;
+	}
+
+	tname->len = declen;
+
+	ret = fscrypt_fname_disk_to_usr(parent, 0, 0, tname, oname);
+
+	if (save_len)
+		tname->len = save_len;
+out:
+	fscrypt_fname_free_buffer(&myname);
+	return ret;
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 1b11e9af165e..88c672ccdcf8 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -6,6 +6,8 @@
 #ifndef _CEPH_CRYPTO_H
 #define _CEPH_CRYPTO_H
 
+#include <linux/fscrypt.h>
+
 #ifdef CONFIG_FS_ENCRYPTION
 
 #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
@@ -16,6 +18,29 @@ int ceph_fscrypt_set_ops(struct super_block *sb);
 int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 
+static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
+{
+	if (!IS_ENCRYPTED(parent))
+		return 0;
+	return fscrypt_fname_alloc_buffer(NAME_MAX, fname);
+}
+
+static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
+{
+	if (IS_ENCRYPTED(parent))
+		fscrypt_fname_free_buffer(fname);
+}
+
+static inline int ceph_get_encryption_info(struct inode *inode)
+{
+	if (!IS_ENCRYPTED(inode))
+		return 0;
+	return fscrypt_get_encryption_info(inode);
+}
+
+int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
+			struct fscrypt_str *tname, struct fscrypt_str *oname);
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 #define DUMMY_ENCRYPTION_ENABLED(fsc) (0)
@@ -31,6 +56,28 @@ static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *
 	return 0;
 }
 
+static inline int ceph_fname_alloc_buffer(struct inode *parent, struct fscrypt_str *fname)
+{
+	return 0;
+}
+
+static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_str *fname)
+{
+}
+
+static inline int ceph_get_encryption_info(struct inode *inode)
+{
+	return 0;
+}
+
+static inline int ceph_fname_to_usr(struct inode *inode, char *name, u32 len,
+			struct fscrypt_str *tname, struct fscrypt_str *oname)
+{
+	oname->name = dname;
+	oname->len = dlen;
+	return 0;
+}
+
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index cc85933413b9..0ba17c592fe1 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -6,9 +6,11 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/xattr.h>
+#include <linux/base64_fname.h>
 
 #include "super.h"
 #include "mds_client.h"
+#include "crypto.h"
 
 /*
  * Directory operations: readdir, lookup, create, link, unlink,
@@ -168,6 +170,27 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 	return dentry ? : ERR_PTR(-EAGAIN);
 }
 
+static bool fscrypt_key_status_change(struct dentry *dentry)
+{
+	struct inode *dir;
+	bool encrypted_name, have_key;
+
+	lockdep_assert_held(&dentry->d_lock);
+
+	dir = d_inode(dentry->d_parent);
+	if (!IS_ENCRYPTED(dir))
+		return false;
+
+	encrypted_name = dentry->d_flags & DCACHE_ENCRYPTED_NAME;
+	have_key = fscrypt_has_encryption_key(dir);
+
+	if (encrypted_name == have_key)
+		ceph_dir_clear_complete(dir);
+
+	dout("%s encrypted_name=%d have_key=%d\n", __func__, encrypted_name, have_key);
+	return encrypted_name == have_key;
+}
+
 /*
  * When possible, we try to satisfy a readdir by peeking at the
  * dcache.  We make this work by carefully ordering dentries on
@@ -238,11 +261,11 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 			goto out;
 		}
 
-		spin_lock(&dentry->d_lock);
 		di = ceph_dentry(dentry);
 		if (d_unhashed(dentry) ||
 		    d_really_is_negative(dentry) ||
-		    di->lease_shared_gen != shared_gen) {
+		    di->lease_shared_gen != shared_gen ||
+		    fscrypt_key_status_change(dentry)) {
 			spin_unlock(&dentry->d_lock);
 			dput(dentry);
 			err = -EAGAIN;
@@ -314,6 +337,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	int err;
 	unsigned frag = -1;
 	struct ceph_mds_reply_info_parsed *rinfo;
+	struct fscrypt_str tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 
 	dout("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
 	if (dfi->file_info.flags & CEPH_F_ATEND)
@@ -341,6 +366,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = 2;
 	}
 
+	err = ceph_get_encryption_info(inode);
+	if (err)
+		goto out;
+
 	spin_lock(&ci->i_ceph_lock);
 	/* request Fx cap. if have Fx, we don't need to release Fs cap
 	 * for later create/unlink. */
@@ -361,6 +390,14 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		spin_unlock(&ci->i_ceph_lock);
 	}
 
+	err = ceph_fname_alloc_buffer(inode, &tname);
+	if (err < 0)
+		goto out;
+
+	err = ceph_fname_alloc_buffer(inode, &oname);
+	if (err < 0)
+		goto out;
+
 	/* proceed with a normal readdir */
 more:
 	/* do we have the correct frag content buffered? */
@@ -388,12 +425,14 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		dout("readdir fetching %llx.%llx frag %x offset '%s'\n",
 		     ceph_vinop(inode), frag, dfi->last_name);
 		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
-		if (IS_ERR(req))
-			return PTR_ERR(req);
+		if (IS_ERR(req)) {
+			err = PTR_ERR(req);
+			goto out;
+		}
 		err = ceph_alloc_readdir_reply_buffer(req, inode);
 		if (err) {
 			ceph_mdsc_put_request(req);
-			return err;
+			goto out;
 		}
 		/* hints to request -> mds selection code */
 		req->r_direct_mode = USE_AUTH_MDS;
@@ -406,7 +445,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			req->r_path2 = kstrdup(dfi->last_name, GFP_KERNEL);
 			if (!req->r_path2) {
 				ceph_mdsc_put_request(req);
-				return -ENOMEM;
+				err = -ENOMEM;
+				goto out;
 			}
 		} else if (is_hash_order(ctx->pos)) {
 			req->r_args.readdir.offset_hash =
@@ -427,7 +467,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err < 0) {
 			ceph_mdsc_put_request(req);
-			return err;
+			goto out;
 		}
 		dout("readdir got and parsed readdir result=%d on "
 		     "frag %x, end=%d, complete=%d, hash_order=%d\n",
@@ -480,7 +520,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			err = note_last_dentry(dfi, rde->name, rde->name_len,
 					       next_offset);
 			if (err)
-				return err;
+				goto out;
 		} else if (req->r_reply_info.dir_end) {
 			dfi->next_offset = 2;
 			/* keep last name */
@@ -508,8 +548,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	}
 	for (; i < rinfo->dir_nr; i++) {
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
+		u32 olen = oname.len;
 
 		BUG_ON(rde->offset < ctx->pos);
+		BUG_ON(!rde->inode.in);
 
 		ctx->pos = rde->offset;
 		dout("readdir (%d/%d) -> %llx '%.*s' %p\n",
@@ -518,12 +560,20 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 
 		BUG_ON(!rde->inode.in);
 
-		if (!dir_emit(ctx, rde->name, rde->name_len,
+		err = ceph_fname_to_usr(inode, rde->name, rde->name_len, &tname, &oname);
+		if (err)
+			goto out;
+
+		if (!dir_emit(ctx, oname.name, oname.len,
 			      ceph_present_ino(inode->i_sb, le64_to_cpu(rde->inode.in->ino)),
 			      le32_to_cpu(rde->inode.in->mode) >> 12)) {
 			dout("filldir stopping us...\n");
-			return 0;
+			err = 0;
+			goto out;
 		}
+
+		/* Reset the lengths to their original allocated vals */
+		oname.len = olen;
 		ctx->pos++;
 	}
 
@@ -578,9 +628,12 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 					dfi->dir_ordered_count);
 		spin_unlock(&ci->i_ceph_lock);
 	}
-
+	err = 0;
 	dout("readdir %p file %p done.\n", inode, file);
-	return 0;
+out:
+	ceph_fname_free_buffer(inode, &tname);
+	ceph_fname_free_buffer(inode, &oname);
+	return err;
 }
 
 static void reset_readdir(struct ceph_dir_file_info *dfi)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c1c1fe2547f9..7d66f41a6592 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1648,7 +1648,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			     struct ceph_mds_session *session)
 {
 	struct dentry *parent = req->r_dentry;
-	struct ceph_inode_info *ci = ceph_inode(d_inode(parent));
+	struct inode *inode = d_inode(parent);
+	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct qstr dname;
 	struct dentry *dn;
@@ -1659,6 +1660,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	u32 last_hash = 0;
 	u32 fpos_offset;
 	struct ceph_readdir_cache_control cache_ctl = {};
+	struct fscrypt_str tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 
 	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
 		return readdir_prepopulate_inodes_only(req, session);
@@ -1710,14 +1713,28 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	cache_ctl.index = req->r_readdir_cache_idx;
 	fpos_offset = req->r_readdir_offset;
 
+	err = ceph_fname_alloc_buffer(inode, &tname);
+	if (err < 0)
+		goto out;
+
+	err = ceph_fname_alloc_buffer(inode, &oname);
+	if (err < 0)
+		goto out;
+
 	/* FIXME: release caps/leases if error occurs */
 	for (i = 0; i < rinfo->dir_nr; i++) {
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 		struct ceph_vino tvino;
+		u32 olen = oname.len;
 
-		dname.name = rde->name;
-		dname.len = rde->name_len;
+		err = ceph_fname_to_usr(inode, rde->name, rde->name_len, &tname, &oname);
+		if (err)
+			goto out;
+
+		dname.name = oname.name;
+		dname.len = oname.len;
 		dname.hash = full_name_hash(parent, dname.name, dname.len);
+		oname.len = olen;
 
 		tvino.ino = le64_to_cpu(rde->inode.in->ino);
 		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
@@ -1748,6 +1765,11 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 				err = -ENOMEM;
 				goto out;
 			}
+			if (IS_ENCRYPTED(inode) && !fscrypt_has_encryption_key(inode)) {
+				spin_lock(&dn->d_lock);
+				dn->d_flags |= DCACHE_ENCRYPTED_NAME;
+				spin_unlock(&dn->d_lock);
+			}
 		} else if (d_really_is_positive(dn) &&
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
@@ -1838,6 +1860,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		req->r_readdir_cache_idx = cache_ctl.index;
 	}
 	ceph_readdir_cache_release(&cache_ctl);
+	ceph_fname_free_buffer(inode, &tname);
+	ceph_fname_free_buffer(inode, &oname);
 	dout("readdir_prepopulate done\n");
 	return err;
 }
-- 
2.26.2

