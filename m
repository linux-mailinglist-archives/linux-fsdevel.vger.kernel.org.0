Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32E4EDD0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiCaPgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbiCaPfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:35:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3B21C737;
        Thu, 31 Mar 2022 08:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E4FFB82172;
        Thu, 31 Mar 2022 15:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85010C340ED;
        Thu, 31 Mar 2022 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740718;
        bh=Q9mG+L2v6joZkZcAJJjCx/bH+1cQtafEyJR8fnHaR/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTCg98WWJ2zVn0KAZLnk+iw9Rjp4kUALbmJ7J9T81GNoZQoGmg1k3yWEyMU4YI2q+
         IZXSwbH7QnxZ1qkq6WMiQmzXhmzDPb2At/QwStmc3D4j0yUphF/UOOCtpQNSoECFrr
         SipDd25LPpfbEsyKOX1V/yWPSKDlrFW11bEjbx5WncWAdH+bIsp6/nnxat2KRiNgCz
         BqOdtBxcFJT7OqWQpw6Kav8Gdl+OOuIKeNIqFDr5eUJsmfolwrF+kIIbyJJEXpuO6J
         4Vc6pz6t+PZon2/x/YLCZZD4E6Iw3PJnaRelqA0xp/NBPP2GVt3BD/W/PoQhEHpe9X
         O3pnxqjp1WAmg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 28/54] ceph: add support to readdir for encrypted filenames
Date:   Thu, 31 Mar 2022 11:31:04 -0400
Message-Id: <20220331153130.41287-29-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Once we've decrypted the names in a readdir reply, we no longer need the
crypttext, so overwrite them in ceph_mds_reply_dir_entry with the
unencrypted names. Then in both ceph_readdir_prepopulate() and
ceph_readdir() we will use the dencrypted name directly.

[ jlayton: convert some BUG_ONs into error returns ]

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c     | 12 +++++--
 fs/ceph/crypto.h     |  1 +
 fs/ceph/dir.c        | 35 +++++++++++++++----
 fs/ceph/inode.c      | 12 ++++---
 fs/ceph/mds_client.c | 81 ++++++++++++++++++++++++++++++++++++++++----
 fs/ceph/mds_client.h |  4 +--
 6 files changed, 124 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7cf45d374c1b..c86cc4a7eaf6 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -142,7 +142,10 @@ int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name,
 	int ret;
 	u8 *cryptbuf;
 
-	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
+	if (!fscrypt_has_encryption_key(parent)) {
+		memcpy(buf, d_name->name, d_name->len);
+		return d_name->len;
+	}
 
 	/*
 	 * Convert cleartext d_name to ciphertext. If result is longer than
@@ -184,6 +187,8 @@ int ceph_encode_encrypted_dname(const struct inode *parent, struct qstr *d_name,
 
 int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
 {
+	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
+
 	return ceph_encode_encrypted_dname(parent, &dentry->d_name, buf);
 }
 
@@ -228,7 +233,10 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	 * generating a nokey name via fscrypt.
 	 */
 	if (!fscrypt_has_encryption_key(fname->dir)) {
-		memcpy(oname->name, fname->name, fname->name_len);
+		if (fname->no_copy)
+			oname->name = fname->name;
+		else
+			memcpy(oname->name, fname->name, fname->name_len);
 		oname->len = fname->name_len;
 		if (is_nokey)
 			*is_nokey = true;
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index e54150260eba..080905b0c73c 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -19,6 +19,7 @@ struct ceph_fname {
 	unsigned char	*ctext;		// binary crypttext (if any)
 	u32		name_len;	// length of name buffer
 	u32		ctext_len;	// length of crypttext
+	bool		no_copy;
 };
 
 struct ceph_fscrypt_auth {
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index caf2547c3fe1..5ce2a6384e55 100644
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
+		    ((dentry->d_flags & DCACHE_NOKEY_NAME) &&
+		     fscrypt_has_encryption_key(dir))) {
 			spin_unlock(&dentry->d_lock);
 			dput(dentry);
 			err = -EAGAIN;
@@ -340,6 +343,10 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = 2;
 	}
 
+	err = fscrypt_prepare_readdir(inode);
+	if (err)
+		return err;
+
 	spin_lock(&ci->i_ceph_lock);
 	/* request Fx cap. if have Fx, we don't need to release Fs cap
 	 * for later create/unlink. */
@@ -389,6 +396,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
+
 		err = ceph_alloc_readdir_reply_buffer(req, inode);
 		if (err) {
 			ceph_mdsc_put_request(req);
@@ -402,11 +410,20 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			req->r_inode_drop = CEPH_CAP_FILE_EXCL;
 		}
 		if (dfi->last_name) {
-			req->r_path2 = kstrdup(dfi->last_name, GFP_KERNEL);
+			struct qstr d_name = { .name = dfi->last_name,
+					       .len = strlen(dfi->last_name) };
+
+			req->r_path2 = kzalloc(NAME_MAX + 1, GFP_KERNEL);
 			if (!req->r_path2) {
 				ceph_mdsc_put_request(req);
 				return -ENOMEM;
 			}
+
+			err = ceph_encode_encrypted_dname(inode, &d_name, req->r_path2);
+			if (err < 0) {
+				ceph_mdsc_put_request(req);
+				return err;
+			}
 		} else if (is_hash_order(ctx->pos)) {
 			req->r_args.readdir.offset_hash =
 				cpu_to_le32(fpos_hash(ctx->pos));
@@ -511,15 +528,20 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	for (; i < rinfo->dir_nr; i++) {
 		struct ceph_mds_reply_dir_entry *rde = rinfo->dir_entries + i;
 
-		BUG_ON(rde->offset < ctx->pos);
+		if (rde->offset < ctx->pos) {
+			pr_warn("%s: rde->offset 0x%llx ctx->pos 0x%llx\n",
+				__func__, rde->offset, ctx->pos);
+			return -EIO;
+		}
+
+		if (WARN_ON_ONCE(!rde->inode.in))
+			return -EIO;
 
 		ctx->pos = rde->offset;
 		dout("readdir (%d/%d) -> %llx '%.*s' %p\n",
 		     i, rinfo->dir_nr, ctx->pos,
 		     rde->name_len, rde->name, &rde->inode.in);
 
-		BUG_ON(!rde->inode.in);
-
 		if (!dir_emit(ctx, rde->name, rde->name_len,
 			      ceph_present_ino(inode->i_sb, le64_to_cpu(rde->inode.in->ino)),
 			      le32_to_cpu(rde->inode.in->mode) >> 12)) {
@@ -532,6 +554,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			dout("filldir stopping us...\n");
 			return 0;
 		}
+
+		/* Reset the lengths to their original allocated vals */
 		ctx->pos++;
 	}
 
@@ -586,7 +610,6 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 					dfi->dir_ordered_count);
 		spin_unlock(&ci->i_ceph_lock);
 	}
-
 	dout("readdir %p file %p done.\n", inode, file);
 	return 0;
 }
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 684dfc3f006c..98ac1369b353 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1750,7 +1750,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 			     struct ceph_mds_session *session)
 {
 	struct dentry *parent = req->r_dentry;
-	struct ceph_inode_info *ci = ceph_inode(d_inode(parent));
+	struct inode *inode = d_inode(parent);
+	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct qstr dname;
 	struct dentry *dn;
@@ -1824,9 +1825,7 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		tvino.snap = le64_to_cpu(rde->inode.in->snapid);
 
 		if (rinfo->hash_order) {
-			u32 hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
-						 rde->name, rde->name_len);
-			hash = ceph_frag_value(hash);
+			u32 hash = ceph_frag_value(rde->raw_hash);
 			if (hash != last_hash)
 				fpos_offset = 2;
 			last_hash = hash;
@@ -1849,6 +1848,11 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 				err = -ENOMEM;
 				goto out;
 			}
+			if (rde->is_nokey) {
+				spin_lock(&dn->d_lock);
+				dn->d_flags |= DCACHE_NOKEY_NAME;
+				spin_unlock(&dn->d_lock);
+			}
 		} else if (d_really_is_positive(dn) &&
 			   (ceph_ino(d_inode(dn)) != tvino.ino ||
 			    ceph_snap(d_inode(dn)) != tvino.snap)) {
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0a7f18d4df73..50fe77768295 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -439,20 +439,87 @@ static int parse_reply_info_readdir(void **p, void *end,
 
 	info->dir_nr = num;
 	while (num) {
+		struct inode *inode = d_inode(req->r_dentry);
+		struct ceph_inode_info *ci = ceph_inode(inode);
 		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
+		struct fscrypt_str tname = FSTR_INIT(NULL, 0);
+		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
+		struct ceph_fname fname;
+		u32 altname_len, _name_len;
+		u8 *altname, *_name;
+
 		/* dentry */
-		ceph_decode_32_safe(p, end, rde->name_len, bad);
-		ceph_decode_need(p, end, rde->name_len, bad);
-		rde->name = *p;
-		*p += rde->name_len;
-		dout("parsed dir dname '%.*s'\n", rde->name_len, rde->name);
+		ceph_decode_32_safe(p, end, _name_len, bad);
+		ceph_decode_need(p, end, _name_len, bad);
+		_name = *p;
+		*p += _name_len;
+		dout("parsed dir dname '%.*s'\n", _name_len, _name);
+
+		if (info->hash_order)
+			rde->raw_hash = ceph_str_hash(ci->i_dir_layout.dl_dir_hash,
+						      _name, _name_len);
 
 		/* dentry lease */
 		err = parse_reply_info_lease(p, end, &rde->lease, features,
-					     &rde->altname_len, &rde->altname);
+					     &altname_len, &altname);
 		if (err)
 			goto out_bad;
 
+		/*
+		 * Try to dencrypt the dentry names and update them
+		 * in the ceph_mds_reply_dir_entry struct.
+		 */
+		fname.dir = inode;
+		fname.name = _name;
+		fname.name_len = _name_len;
+		fname.ctext = altname;
+		fname.ctext_len = altname_len;
+		/*
+		 * The _name_len maybe larger than altname_len, such as
+		 * when the human readable name length is in range of
+		 * (CEPH_NOHASH_NAME_MAX, CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE),
+		 * then the copy in ceph_fname_to_usr will corrupt the
+		 * data if there has no encryption key.
+		 *
+		 * Just set the no_copy flag and then if there has no
+		 * encryption key the oname.name will be assigned to
+		 * _name always.
+		 */
+		fname.no_copy = true;
+		if (altname_len == 0) {
+			/*
+			 * Set tname to _name, and this will be used
+			 * to do the base64_decode in-place. It's
+			 * safe because the decoded string should
+			 * always be shorter, which is 3/4 of origin
+			 * string.
+			 */
+			tname.name = _name;
+
+			/*
+			 * Set oname to _name too, and this will be
+			 * used to do the dencryption in-place.
+			 */
+			oname.name = _name;
+			oname.len = _name_len;
+		} else {
+			/*
+			 * This will do the decryption only in-place
+			 * from altname cryptext directly.
+			 */
+			oname.name = altname;
+			oname.len = altname_len;
+		}
+		rde->is_nokey = false;
+		err = ceph_fname_to_usr(&fname, &tname, &oname, &rde->is_nokey);
+		if (err) {
+			pr_err("%s unable to decode %.*s, got %d\n", __func__,
+			       _name_len, _name, err);
+			goto out_bad;
+		}
+		rde->name = oname.name;
+		rde->name_len = oname.len;
+
 		/* inode */
 		err = parse_reply_info_in(p, end, &rde->inode, features);
 		if (err < 0)
@@ -3501,7 +3568,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	if (err == 0) {
 		if (result == 0 && (req->r_op == CEPH_MDS_OP_READDIR ||
 				    req->r_op == CEPH_MDS_OP_LSSNAP))
-			ceph_readdir_prepopulate(req, req->r_session);
+			err = ceph_readdir_prepopulate(req, req->r_session);
 	}
 	current->journal_info = NULL;
 	mutex_unlock(&req->r_fill_mutex);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index cd719691a86d..046a9368c4a9 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -96,10 +96,10 @@ struct ceph_mds_reply_info_in {
 };
 
 struct ceph_mds_reply_dir_entry {
+	bool			      is_nokey;
 	char                          *name;
-	u8			      *altname;
 	u32                           name_len;
-	u32			      altname_len;
+	u32			      raw_hash;
 	struct ceph_mds_reply_lease   *lease;
 	struct ceph_mds_reply_info_in inode;
 	loff_t			      offset;
-- 
2.35.1

