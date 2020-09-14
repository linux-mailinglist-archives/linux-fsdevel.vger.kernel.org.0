Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C918269570
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgINTRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgINTRX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:23 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78F71208E4;
        Mon, 14 Sep 2020 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111038;
        bh=o3eFeTLsQ1ffdOk7Vk+hbU/rYNMA83Jo5MfcH3x9i18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+nz/6rRdKJuabWmnHQVjy5wT9DCBBcpjTK+6/rJil8/72J3/JYSQGMGMSErdQhzU
         yFwFIbH7mQ8/dQhEarS1FnCsgv7nbZPNCfPYHQlzNZfKnzg1m1PMa9aeOUyXxvEi6e
         zw3md5p6b+fR5xGLicAhxpV8bksCXTa9hgtnp4j8=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 14/16] ceph: add support to readdir for encrypted filenames
Date:   Mon, 14 Sep 2020 15:17:05 -0400
Message-Id: <20200914191707.380444-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
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
 fs/ceph/crypto.c | 47 +++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h | 35 +++++++++++++++++++++++++++++
 fs/ceph/dir.c    | 58 +++++++++++++++++++++++++++++++++++++++---------
 fs/ceph/inode.c  | 31 +++++++++++++++++++++++---
 4 files changed, 157 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f037a4939026..e3038c88c7a0 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -107,3 +107,50 @@ int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 		ceph_pagelist_release(pagelist);
 	return ret;
 }
+
+int ceph_fname_to_usr(struct inode *parent, char *name, u32 len,
+			struct fscrypt_str *tname, struct fscrypt_str *oname,
+			bool *is_nokey)
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
+	declen = fscrypt_base64_decode(name, len, tname->name);
+	if (declen < 0 || declen > NAME_MAX) {
+		ret = -EIO;
+		goto out;
+	}
+
+	tname->len = declen;
+
+	ret = fscrypt_fname_disk_to_usr(parent, 0, 0, tname, oname, is_nokey);
+
+	if (save_len)
+		tname->len = save_len;
+out:
+	fscrypt_fname_free_buffer(&myname);
+	return ret;
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index c1b6ec4b2961..df1a093848bb 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -6,6 +6,8 @@
 #ifndef _CEPH_CRYPTO_H
 #define _CEPH_CRYPTO_H
 
+#include <linux/fscrypt.h>
+
 #ifdef CONFIG_FS_ENCRYPTION
 
 #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
@@ -14,6 +16,22 @@ void ceph_fscrypt_set_ops(struct super_block *sb);
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
+int ceph_fname_to_usr(struct inode *parent, char *name, u32 len, struct fscrypt_str *tname,
+			struct fscrypt_str *oname, bool *is_nokey);
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline int ceph_fscrypt_set_ops(struct super_block *sb)
@@ -27,6 +45,23 @@ static inline int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *
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
+static inline int ceph_fname_to_usr(struct inode *inode, char *name, u32 len,
+			struct fscrypt_str *tname, struct fscrypt_str *oname, bool *is_nokey)
+{
+	oname->name = dname;
+	oname->len = dlen;
+	return 0;
+}
+
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b6e5d751024d..e9fdb9c07320 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -9,6 +9,7 @@
 
 #include "super.h"
 #include "mds_client.h"
+#include "crypto.h"
 
 /*
  * Directory operations: readdir, lookup, create, link, unlink,
@@ -241,7 +242,9 @@ static int __dcache_readdir(struct file *file,  struct dir_context *ctx,
 		di = ceph_dentry(dentry);
 		if (d_unhashed(dentry) ||
 		    d_really_is_negative(dentry) ||
-		    di->lease_shared_gen != shared_gen) {
+		    di->lease_shared_gen != shared_gen ||
+		    ((dentry->d_flags & DCACHE_ENCRYPTED_NAME) &&
+		     fscrypt_has_encryption_key(dir))) {
 			spin_unlock(&dentry->d_lock);
 			dput(dentry);
 			err = -EAGAIN;
@@ -313,6 +316,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	int err;
 	unsigned frag = -1;
 	struct ceph_mds_reply_info_parsed *rinfo;
+	struct fscrypt_str tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 
 	dout("readdir %p file %p pos %llx\n", inode, file, ctx->pos);
 	if (dfi->file_info.flags & CEPH_F_ATEND)
@@ -340,6 +345,12 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = 2;
 	}
 
+	if (IS_ENCRYPTED(inode)) {
+		err = fscrypt_get_encryption_info(inode);
+		if (err)
+			goto out;
+	}
+
 	spin_lock(&ci->i_ceph_lock);
 	/* request Fx cap. if have Fx, we don't need to release Fs cap
 	 * for later create/unlink. */
@@ -360,6 +371,14 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
@@ -387,12 +406,14 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
@@ -405,7 +426,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			req->r_path2 = kstrdup(dfi->last_name, GFP_KERNEL);
 			if (!req->r_path2) {
 				ceph_mdsc_put_request(req);
-				return -ENOMEM;
+				err = -ENOMEM;
+				goto out;
 			}
 		} else if (is_hash_order(ctx->pos)) {
 			req->r_args.readdir.offset_hash =
@@ -426,7 +448,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 		if (err < 0) {
 			ceph_mdsc_put_request(req);
-			return err;
+			goto out;
 		}
 		dout("readdir got and parsed readdir result=%d on "
 		     "frag %x, end=%d, complete=%d, hash_order=%d\n",
@@ -479,7 +501,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			err = note_last_dentry(dfi, rde->name, rde->name_len,
 					       next_offset);
 			if (err)
-				return err;
+				goto out;
 		} else if (req->r_reply_info.dir_end) {
 			dfi->next_offset = 2;
 			/* keep last name */
@@ -506,9 +528,12 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		}
 	}
 	for (; i < rinfo->dir_nr; i++) {
+		bool is_nokey = false;
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
+		u32 olen = oname.len;
 
 		BUG_ON(rde->offset < ctx->pos);
+		BUG_ON(!rde->inode.in);
 
 		ctx->pos = rde->offset;
 		dout("readdir (%d/%d) -> %llx '%.*s' %p\n",
@@ -517,12 +542,20 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 
 		BUG_ON(!rde->inode.in);
 
-		if (!dir_emit(ctx, rde->name, rde->name_len,
+		err = ceph_fname_to_usr(inode, rde->name, rde->name_len, &tname, &oname, &is_nokey);
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
 
@@ -577,9 +610,12 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
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
index 2fda08518312..c3a7a9f5603d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1653,7 +1653,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			     struct ceph_mds_session *session)
 {
 	struct dentry *parent = req->r_dentry;
-	struct ceph_inode_info *ci = ceph_inode(d_inode(parent));
+	struct inode *inode = d_inode(parent);
+	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct qstr dname;
 	struct dentry *dn;
@@ -1664,6 +1665,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 	u32 last_hash = 0;
 	u32 fpos_offset;
 	struct ceph_readdir_cache_control cache_ctl = {};
+	struct fscrypt_str tname = FSTR_INIT(NULL, 0);
+	struct fscrypt_str oname = FSTR_INIT(NULL, 0);
 
 	if (test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags))
 		return readdir_prepopulate_inodes_only(req, session);
@@ -1715,14 +1718,29 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
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
+		bool is_nokey = false;
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 		struct ceph_vino tvino;
+		u32 olen = oname.len;
 
-		dname.name = rde->name;
-		dname.len = rde->name_len;
+		err = ceph_fname_to_usr(inode, rde->name, rde->name_len, &tname, &oname, &is_nokey);
+		if (err)
+			goto out;
+
+		dname.name = oname.name;
+		dname.len = oname.len;
 		dname.hash = full_name_hash(parent, dname.name, dname.len);
+		oname.len = olen;
 
 		tvino.ino = le64_to_cpu(rde->inode.in->ino);
 		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
@@ -1753,6 +1771,11 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 				err = -ENOMEM;
 				goto out;
 			}
+			if (is_nokey) {
+				spin_lock(&dn->d_lock);
+				dn->d_flags |= DCACHE_ENCRYPTED_NAME;
+				spin_unlock(&dn->d_lock);
+			}
 		} else if (d_really_is_positive(dn) &&
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
@@ -1843,6 +1866,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
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

