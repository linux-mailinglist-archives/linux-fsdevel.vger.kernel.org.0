Return-Path: <linux-fsdevel+bounces-4623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE80180167E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A9B1F21013
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64D43F8C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EMgJv7Rz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DE0D6C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:01 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-da819902678so984575276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468720; x=1702073520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr0WOCD8JTyY6NQSzSjvqDgXCX9+Pc+RemopiYnHZ9s=;
        b=EMgJv7RzWOkaW3V5gqpp7Av0u6QB5HG7wx8XrM+OXHRy1/gzLvkS40uFssA+pe5IkF
         6spHRD63oz8EIe06sKF5Itw0fk6cpLGRXk4DwIvWxPWWoYJ8ubyVOgAfOV+s3eWPLcjm
         s1WRGUjgFWly54xpb3ereD0jb8BHTNcPqiTbCkCwT1kgCACSOJAlHpAPbzC7P0VqZS9z
         iYyZ01cuhJ8Zh7ydg6VAdU7XF+bmbwPVd1JUIccb6BRuS6hSQ6xtQEuR28Dk6oHEnDzw
         15omEsVEDHqw/MLKbq42V+O/ccz56/lMrnia5zNbrmH996ncDz6qZza6eghgl3SoQc1R
         Y1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468720; x=1702073520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jr0WOCD8JTyY6NQSzSjvqDgXCX9+Pc+RemopiYnHZ9s=;
        b=X2c4u61ig3O5FlOYNtTyRMyD4QrDyxxpjp8ON2//Um5mVUKxqyFHJqmkqJqs+LwTPm
         N0cedjTxr87uuzqUbdEgiJ7Gb8CR/+rUmZJ/C/kqIaN8qb05gROxycgEZRhVgnFk3cMv
         peohWs6TZQWv59EaAfwFp+LHvwidStLaNjqdzYtkeOiun5WkudegZWStu30fE/tv3T2Z
         oO/lXSvzljfLD29ND2glxJcAeUCV/QM86y7PMWrQh8AwMtBD+4JdeinoEKTn1V3GJfUQ
         UApyYc8e5uo9ou+O48/+DGYLF/A55djS7h+Y0i/INXnD9TaOCayT7kGw9hSNvDYnZ3aN
         6PGg==
X-Gm-Message-State: AOJu0YwLOehygwnunKcKh2j6x5WWDHog5G4mPBw9XfH8jECdR6WYDrr9
	kPOMDZEV9A3JAtjSp0VmlTpZQeDRHG5LXTlHIrir0MJa
X-Google-Smtp-Source: AGHT+IEhrHy7Tm5uPu9BILnThmfOm6bm7iEQn0TQEskZgEeU7s3T8VFTvmzODLDzyQYWIWVxEUCcVQ==
X-Received: by 2002:a25:df4f:0:b0:db7:dacf:2f2b with SMTP id w76-20020a25df4f000000b00db7dacf2f2bmr166641ybg.114.1701468720183;
        Fri, 01 Dec 2023 14:12:00 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h9-20020a259749000000b00d677aec54ffsm607827ybo.60.2023.12.01.14.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:11:59 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 02/46] fscrypt: add per-extent encryption support
Date: Fri,  1 Dec 2023 17:10:59 -0500
Message-ID: <5e91532d4f6ddb10af8aac7f306186d6f1b9e917.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the code necessary for per-extent encryption.  We will store a
nonce for every extent we create, and then use the inode's policy and
the extents nonce to derive a per-extent key.

This is meant to be flexible, if we choose to expand the on-disk extent
information in the future we have a version number we can use to change
what exists on disk.

The file system indicates it wants to use per-extent encryption by
setting s_cop->set_extent_context.  This also requires the use of inline
block encryption.

The support is relatively straightforward, the only "extra" bit is we're
deriving a per-extent key to use for the encryption, the inode still
controls the policy and access to the master key.

Since extent based encryption uses a lot of keys, we're requiring the
use of inline block crypto if you use extent-based encryption.  This
enables us to take advantage of the built in pooling and reclamation of
the crypto structures that underpin all of the encryption.

The different encryption related options for fscrypt are too numerous to
support for extent based encryption.  Support for a few of these options
could possibly be added, but since they're niche options simply reject
them for file systems using extent based encryption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/crypto.c          |  10 ++-
 fs/crypto/fscrypt_private.h |  44 ++++++++++
 fs/crypto/inline_crypt.c    |  84 +++++++++++++++++++
 fs/crypto/keysetup.c        | 155 ++++++++++++++++++++++++++++++++++++
 fs/crypto/policy.c          |  59 ++++++++++++++
 include/linux/fscrypt.h     |  71 +++++++++++++++++
 6 files changed, 422 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 328470d40dec..18bd96b9db4e 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -40,6 +40,7 @@ static struct workqueue_struct *fscrypt_read_workqueue;
 static DEFINE_MUTEX(fscrypt_init_mutex);
 
 struct kmem_cache *fscrypt_inode_info_cachep;
+struct kmem_cache *fscrypt_extent_info_cachep;
 
 void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 {
@@ -414,12 +415,19 @@ static int __init fscrypt_init(void)
 	if (!fscrypt_inode_info_cachep)
 		goto fail_free_queue;
 
+	fscrypt_extent_info_cachep = KMEM_CACHE(fscrypt_extent_info,
+						SLAB_RECLAIM_ACCOUNT);
+	if (!fscrypt_extent_info_cachep)
+		goto fail_free_inode_info;
+
 	err = fscrypt_init_keyring();
 	if (err)
-		goto fail_free_inode_info;
+		goto fail_free_extent_info;
 
 	return 0;
 
+fail_free_extent_info:
+	kmem_cache_destroy(fscrypt_extent_info_cachep);
 fail_free_inode_info:
 	kmem_cache_destroy(fscrypt_inode_info_cachep);
 fail_free_queue:
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 1892356cf924..03c006e5c47d 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -30,6 +30,8 @@
 #define FSCRYPT_CONTEXT_V1	1
 #define FSCRYPT_CONTEXT_V2	2
 
+#define FSCRYPT_EXTENT_CONTEXT_V1	1
+
 /* Keep this in sync with include/uapi/linux/fscrypt.h */
 #define FSCRYPT_MODE_MAX	FSCRYPT_MODE_AES_256_HCTR2
 
@@ -53,6 +55,28 @@ struct fscrypt_context_v2 {
 	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
 };
 
+/*
+ * fscrypt_extent_context - the encryption context of an extent
+ *
+ * This is the on-disk information stored for an extent.  The policy and
+ * relevante information is stored in the inode, the per-extent information is
+ * simply the nonce that's used in as KDF input in conjunction with the inode
+ * context to derive a per-extent key for encryption.
+ *
+ * At this point the master_key_identifier exists only for possible future
+ * expansion.  This will allow for an inode to have extents with multiple master
+ * keys, although sharing the same encryption mode.  This would be for re-keying
+ * or for reflinking between two differently encrypted inodes.  For now the
+ * master_key_descriptor must match the inode's, and we'll be using the inode's
+ * for all key derivation.
+ */
+struct fscrypt_extent_context {
+	u8 version; /* FSCRYPT_EXTENT_CONTEXT_V2 */
+	u8 encryption_mode;
+	u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
+};
+
 /*
  * fscrypt_context - the encryption context of an inode
  *
@@ -288,6 +312,25 @@ struct fscrypt_inode_info {
 	u32 ci_hashed_ino;
 };
 
+/*
+ * fscrypt_extent_info - the "encryption key" for an extent.
+ *
+ * This contains the dervied key for the given extent and the nonce for the
+ * extent.
+ */
+struct fscrypt_extent_info {
+	refcount_t refs;
+
+	/* The derived key for this extent. */
+	struct fscrypt_prepared_key prep_key;
+
+	/* The super block that this extent belongs to. */
+	struct super_block *sb;
+
+	/* This is the extents nonce, loaded from the fscrypt_extent_context */
+	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
+};
+
 typedef enum {
 	FS_DECRYPT = 0,
 	FS_ENCRYPT,
@@ -295,6 +338,7 @@ typedef enum {
 
 /* crypto.c */
 extern struct kmem_cache *fscrypt_inode_info_cachep;
+extern struct kmem_cache *fscrypt_extent_info_cachep;
 int fscrypt_initialize(struct super_block *sb);
 int fscrypt_crypt_data_unit(const struct fscrypt_inode_info *ci,
 			    fscrypt_direction_t rw, u64 index,
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index b4002aea7cdb..4eeb75410ba8 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -279,6 +279,40 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
 
+/**
+ * fscrypt_set_bio_crypt_ctx() - prepare a file contents bio for inline crypto
+ * @bio: a bio which will eventually be submitted to the file
+ * @inode: the file's inode
+ * @ei: the extent's crypto info
+ * @first_lblk: the first file logical block number in the I/O
+ * @gfp_mask: memory allocation flags - these must be a waiting mask so that
+ *					bio_crypt_set_ctx can't fail.
+ *
+ * If the contents of the file should be encrypted (or decrypted) with inline
+ * encryption, then assign the appropriate encryption context to the bio.
+ *
+ * Normally the bio should be newly allocated (i.e. no pages added yet), as
+ * otherwise fscrypt_mergeable_bio() won't work as intended.
+ *
+ * The encryption context will be freed automatically when the bio is freed.
+ */
+void fscrypt_set_bio_crypt_ctx_from_extent(struct bio *bio,
+					   const struct inode *inode,
+					   const struct fscrypt_extent_info *ei,
+					   u64 first_lblk, gfp_t gfp_mask)
+{
+	const struct fscrypt_inode_info *ci;
+	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return;
+	ci = inode->i_crypt_info;
+
+	fscrypt_generate_dun(ci, first_lblk, dun);
+	bio_crypt_set_ctx(bio, ei->prep_key.blk_key, dun, gfp_mask);
+}
+EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_from_extent);
+
 /* Extract the inode and logical block number from a buffer_head. */
 static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
 				      const struct inode **inode_ret,
@@ -370,6 +404,56 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
 
+/**
+ * fscrypt_mergeable_extent_bio() - test whether data can be added to a bio
+ * @bio: the bio being built up
+ * @inode: the inode for the next part of the I/O
+ * @ei: the fscrypt_extent_info for this extent
+ * @next_lblk: the next file logical block number in the I/O
+ *
+ * When building a bio which may contain data which should undergo inline
+ * encryption (or decryption) via fscrypt, filesystems should call this function
+ * to ensure that the resulting bio contains only contiguous data unit numbers.
+ * This will return false if the next part of the I/O cannot be merged with the
+ * bio because either the encryption key would be different or the encryption
+ * data unit numbers would be discontiguous.
+ *
+ * fscrypt_set_bio_crypt_ctx_from_extent() must have already been called on the
+ * bio.
+ *
+ * This function isn't required in cases where crypto-mergeability is ensured in
+ * another way, such as I/O targeting only a single file (and thus a single key)
+ * combined with fscrypt_limit_io_blocks() to ensure DUN contiguity.
+ *
+ * Return: true iff the I/O is mergeable
+ */
+bool fscrypt_mergeable_extent_bio(struct bio *bio, const struct inode *inode,
+				  const struct fscrypt_extent_info *ei,
+				  u64 next_lblk)
+{
+	const struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+	u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
+
+	if (!ei)
+		return true;
+	if (!!bc != fscrypt_inode_uses_inline_crypto(inode))
+		return false;
+	if (!bc)
+		return true;
+
+	/*
+	 * Comparing the key pointers is good enough, as all I/O for each key
+	 * uses the same pointer.  I.e., there's currently no need to support
+	 * merging requests where the keys are the same but the pointers differ.
+	 */
+	if (bc->bc_key != ei->prep_key.blk_key)
+		return false;
+
+	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
+	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
+}
+EXPORT_SYMBOL_GPL(fscrypt_mergeable_extent_bio);
+
 /**
  * fscrypt_mergeable_bio_bh() - test whether data can be added to a bio
  * @bio: the bio being built up
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index d71f7c799e79..c19bf6239dcd 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -812,3 +812,158 @@ int fscrypt_drop_inode(struct inode *inode)
 	return !READ_ONCE(ci->ci_master_key->mk_present);
 }
 EXPORT_SYMBOL_GPL(fscrypt_drop_inode);
+
+static struct fscrypt_extent_info *
+setup_extent_info(struct inode *inode, const u8 nonce[FSCRYPT_FILE_NONCE_SIZE])
+{
+	struct fscrypt_extent_info *ei;
+	struct fscrypt_inode_info *ci;
+	struct fscrypt_master_key *mk;
+	u8 derived_key[FSCRYPT_MAX_KEY_SIZE];
+	int err;
+
+	ci = inode->i_crypt_info;
+	mk = ci->ci_master_key;
+	if (!mk)
+		return ERR_PTR(-ENOKEY);
+
+	ei = kmem_cache_zalloc(fscrypt_extent_info_cachep, GFP_KERNEL);
+	if (!ei)
+		return ERR_PTR(-ENOMEM);
+
+	refcount_set(&ei->refs, 1);
+	memcpy(ei->nonce, nonce, FSCRYPT_FILE_NONCE_SIZE);
+	ei->sb = inode->i_sb;
+
+	down_read(&mk->mk_sem);
+	/*
+	 * We specifically don't do is_master_key_secret_present() here because
+	 * if the inode is open and has a reference on the master key then it
+	 * should be available for us to use.
+	 */
+
+	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
+				  HKDF_CONTEXT_PER_FILE_ENC_KEY, ei->nonce,
+				  FSCRYPT_FILE_NONCE_SIZE, derived_key,
+				  ci->ci_mode->keysize);
+	if (err)
+		goto out_free;
+
+	err = fscrypt_prepare_inline_crypt_key(&ei->prep_key, derived_key, ci);
+	memzero_explicit(derived_key, ci->ci_mode->keysize);
+	if (err)
+		goto out_free;
+	up_read(&mk->mk_sem);
+	return ei;
+out_free:
+	up_read(&mk->mk_sem);
+	memzero_explicit(ei, sizeof(*ei));
+	kmem_cache_free(fscrypt_extent_info_cachep, ei);
+	return ERR_PTR(err);
+}
+
+/**
+ * fscrypt_prepare_new_extent() - prepare to create a new extent for a file
+ * @inode: the possibly-encrypted inode
+ *
+ * If the inode is encrypted, setup the fscrypt_extent_info for a new extent.
+ * This will include the nonce and the derived key necessary for the extent to
+ * be encrypted.  This is only meant to be used with inline crypto.
+ *
+ * This doesn't persist the new extents encryption context, this is done later
+ * by calling fscrypt_set_extent_context().
+ *
+ * Return: The newly allocated fscrypt_extent_info on success, -EOPNOTSUPP if
+ *	   we're not encrypted, or another -errno code
+ */
+struct fscrypt_extent_info *fscrypt_prepare_new_extent(struct inode *inode)
+{
+	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
+
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	get_random_bytes(nonce, FSCRYPT_FILE_NONCE_SIZE);
+	return setup_extent_info(inode, nonce);
+}
+EXPORT_SYMBOL_GPL(fscrypt_prepare_new_extent);
+
+/**
+ * fscrypt_load_extent_info() - create an fscrypt_extent_info from the context
+ * @inode: the inode
+ * @ctx: the context buffer
+ * @ctx_size: the size of the context buffer
+ *
+ * Create the file_extent_info and derive the key based on the
+ * fscrypt_extent_context buffer that is probided.
+ *
+ * Return: The newly allocated fscrypt_extent_info on success, -EOPNOTSUPP if
+ *	   we're not encrypted, or another -errno code
+ */
+struct fscrypt_extent_info *fscrypt_load_extent_info(struct inode *inode,
+						     u8 *ctx, size_t ctx_size)
+{
+	struct fscrypt_extent_context extent_ctx;
+	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+	const struct fscrypt_policy_v2 *policy = &ci->ci_policy.v2;
+
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return ERR_PTR(-EOPNOTSUPP);
+	if (ctx_size < sizeof(extent_ctx))
+		return ERR_PTR(-EINVAL);
+
+	memcpy(&extent_ctx, ctx, sizeof(extent_ctx));
+
+	/*
+	 * For now we need to validate that the master key for the inode matches
+	 * the extent.
+	 */
+	if (memcmp(extent_ctx.master_key_identifier,
+		   policy->master_key_identifier,
+		   sizeof(extent_ctx.master_key_identifier)))
+		return ERR_PTR(-EINVAL);
+
+	return setup_extent_info(inode, extent_ctx.nonce);
+}
+EXPORT_SYMBOL(fscrypt_load_extent_info);
+
+/**
+ * fscrypt_put_extent_info() - free the extent_info fscrypt data
+ * @ei: the extent_info being evicted
+ *
+ * Drop a reference and possibly free the fscrypt_extent_info.
+ *
+ * Note this will unload the key from the block layer, which takes the crypto
+ * profile semaphore to unload the key.  Make sure you're not dropping this in a
+ * context that can't sleep.
+ */
+void fscrypt_put_extent_info(struct fscrypt_extent_info *ei)
+{
+	if (!ei)
+		return;
+
+	if (!refcount_dec_and_test(&ei->refs))
+		return;
+
+	fscrypt_destroy_prepared_key(ei->sb, &ei->prep_key);
+	memzero_explicit(ei, sizeof(*ei));
+	kmem_cache_free(fscrypt_extent_info_cachep, ei);
+}
+EXPORT_SYMBOL_GPL(fscrypt_put_extent_info);
+
+/**
+ * fscrypt_get_extent_info() - get a ref on the fscrypt extent info
+ * @ei: the extent_info to get.
+ *
+ * Get a reference on the fscrypt_extent_info.
+ *
+ * Return: the ei with an extra ref, NULL if there was no ei passed in.
+ */
+struct fscrypt_extent_info *fscrypt_get_extent_info(struct fscrypt_extent_info *ei)
+{
+	if (!ei)
+		return NULL;
+	refcount_inc(&ei->refs);
+	return ei;
+}
+EXPORT_SYMBOL_GPL(fscrypt_get_extent_info);
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 701259991277..75a69f02f11d 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -209,6 +209,12 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
 		return false;
 	}
 
+	if (inode->i_sb->s_cop->has_per_extent_encryption) {
+		fscrypt_warn(inode,
+			     "v1 policies can't be used on file systems that use extent encryption");
+		return false;
+	}
+
 	return true;
 }
 
@@ -269,6 +275,12 @@ static bool fscrypt_supported_v2_policy(const struct fscrypt_policy_v2 *policy,
 		}
 	}
 
+	if ((inode->i_sb->s_cop->has_per_extent_encryption) && count) {
+		fscrypt_warn(inode,
+			     "Encryption flags aren't supported on file systems that use extent encryption");
+		return false;
+	}
+
 	if ((policy->flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY) &&
 	    !supported_direct_key_modes(inode, policy->contents_encryption_mode,
 					policy->filenames_encryption_mode))
@@ -789,6 +801,53 @@ int fscrypt_set_context(struct inode *inode, void *fs_data)
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_context);
 
+/**
+ * fscrypt_set_extent_context() - Set the fscrypt extent context of a new extent
+ * @inode: the inode this extent belongs to
+ * @ei: the fscrypt_extent_info for the given extent
+ * @buf: the buffer to copy the fscrypt extent context into
+ *
+ * This should be called after fscrypt_prepare_new_extent(), using the
+ * fscrypt_extent_info that was created at that point.
+ *
+ * Return: the size of the fscrypt_extent_context, errno if the inode has the
+ *	   wrong policy version.
+ */
+ssize_t fscrypt_set_extent_context(struct inode *inode,
+				   struct fscrypt_extent_info *ei, u8 *buf)
+{
+	struct fscrypt_extent_context *ctx = (struct fscrypt_extent_context *)buf;
+	const struct fscrypt_inode_info *ci = inode->i_crypt_info;
+
+	if (ci->ci_policy.version != 2)
+		return -EINVAL;
+
+	ctx->version = 1;
+	memcpy(ctx->master_key_identifier,
+	       ci->ci_policy.v2.master_key_identifier,
+	       sizeof(ctx->master_key_identifier));
+	memcpy(ctx->nonce, ei->nonce, FSCRYPT_FILE_NONCE_SIZE);
+	return sizeof(struct fscrypt_extent_context);
+}
+EXPORT_SYMBOL_GPL(fscrypt_set_extent_context);
+
+/**
+ * fscrypt_extent_context_size() - Return the size of the on-disk extent context
+ * @inode: the inode this extent belongs to.
+ *
+ * Return the size of the extent context for this inode.  Since there is only
+ * one extent context version currently this is just the size of the extent
+ * context if the inode is encrypted.
+ */
+size_t fscrypt_extent_context_size(struct inode *inode)
+{
+	if (!IS_ENCRYPTED(inode))
+		return 0;
+
+	return sizeof(struct fscrypt_extent_context);
+}
+EXPORT_SYMBOL_GPL(fscrypt_extent_context_size);
+
 /**
  * fscrypt_parse_test_dummy_encryption() - parse the test_dummy_encryption mount option
  * @param: the mount option
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 12f9e455d569..ea8fdc6f3b83 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -32,6 +32,7 @@
 
 union fscrypt_policy;
 struct fscrypt_inode_info;
+struct fscrypt_extent_info;
 struct fs_parameter;
 struct seq_file;
 
@@ -97,6 +98,14 @@ struct fscrypt_operations {
 	 */
 	unsigned int supports_subblock_data_units : 1;
 
+	/*
+	 * If set then extent based encryption will be used for this file
+	 * system, and fs/crypto/ will enforce limits on the policies that are
+	 * allowed to be chosen.  Currently this means only plain v2 policies
+	 * are supported.
+	 */
+	unsigned int has_per_extent_encryption : 1;
+
 	/*
 	 * This field exists only for backwards compatibility reasons and should
 	 * only be set by the filesystems that are setting it already.  It
@@ -308,6 +317,11 @@ int fscrypt_ioctl_get_nonce(struct file *filp, void __user *arg);
 int fscrypt_has_permitted_context(struct inode *parent, struct inode *child);
 int fscrypt_context_for_new_inode(void *ctx, struct inode *inode);
 int fscrypt_set_context(struct inode *inode, void *fs_data);
+ssize_t fscrypt_set_extent_context(struct inode *inode,
+				   struct fscrypt_extent_info *ei, u8 *buf);
+struct fscrypt_extent_info *fscrypt_load_extent_info(struct inode *inode,
+						     u8 *ctx, size_t ctx_size);
+size_t fscrypt_extent_context_size(struct inode *inode);
 
 struct fscrypt_dummy_policy {
 	const union fscrypt_policy *policy;
@@ -344,6 +358,9 @@ int fscrypt_prepare_new_inode(struct inode *dir, struct inode *inode,
 void fscrypt_put_encryption_info(struct inode *inode);
 void fscrypt_free_inode(struct inode *inode);
 int fscrypt_drop_inode(struct inode *inode);
+struct fscrypt_extent_info *fscrypt_prepare_new_extent(struct inode *inode);
+void fscrypt_put_extent_info(struct fscrypt_extent_info *ei);
+struct fscrypt_extent_info *fscrypt_get_extent_info(struct fscrypt_extent_info *ei);
 
 /* fname.c */
 int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
@@ -555,6 +572,24 @@ fscrypt_free_dummy_policy(struct fscrypt_dummy_policy *dummy_policy)
 {
 }
 
+static inline ssize_t
+fscrypt_set_extent_context(struct inode *inode, struct fscrypt_extent_info *ei,
+			   u8 *buf)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct fscrypt_extent_info *
+fscrypt_load_extent_info(struct inode *inode, u8 *ctx, size_t ctx_size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline size_t fscrypt_extent_context_size(struct inode *inode)
+{
+	return 0;
+}
+
 /* keyring.c */
 static inline void fscrypt_destroy_keyring(struct super_block *sb)
 {
@@ -607,6 +642,20 @@ static inline int fscrypt_drop_inode(struct inode *inode)
 	return 0;
 }
 
+static inline struct fscrypt_extent_info *
+fscrypt_prepare_new_extent(struct inode *inode)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void fscrypt_put_extent_info(struct fscrypt_extent_info *ei) { }
+
+static inline struct fscrypt_extent_info *
+fscrypt_get_extent_info(struct fscrypt_extent_info *ei)
+{
+	return ei;
+}
+
  /* fname.c */
 static inline int fscrypt_setup_filename(struct inode *dir,
 					 const struct qstr *iname,
@@ -788,6 +837,11 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 			       const struct inode *inode, u64 first_lblk,
 			       gfp_t gfp_mask);
 
+void fscrypt_set_bio_crypt_ctx_from_extent(struct bio *bio,
+					   const struct inode *inode,
+					   const struct fscrypt_extent_info *ei,
+					   u64 first_lblk, gfp_t gfp_mask);
+
 void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
 				  const struct buffer_head *first_bh,
 				  gfp_t gfp_mask);
@@ -798,6 +852,10 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 bool fscrypt_mergeable_bio_bh(struct bio *bio,
 			      const struct buffer_head *next_bh);
 
+bool fscrypt_mergeable_extent_bio(struct bio *bio, const struct inode *inode,
+				  const struct fscrypt_extent_info *ei,
+				  u64 next_lblk);
+
 bool fscrypt_dio_supported(struct inode *inode);
 
 u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks);
@@ -813,6 +871,11 @@ static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 					     const struct inode *inode,
 					     u64 first_lblk, gfp_t gfp_mask) { }
 
+static inline void fscrypt_set_bio_crypt_ctx_from_extent(struct bio *bio,
+					const struct inode *inode,
+					const struct fscrypt_extent_info *ei,
+					u64 first_lblk, gfp_t gfp_mask) { }
+
 static inline void fscrypt_set_bio_crypt_ctx_bh(
 					 struct bio *bio,
 					 const struct buffer_head *first_bh,
@@ -825,6 +888,14 @@ static inline bool fscrypt_mergeable_bio(struct bio *bio,
 	return true;
 }
 
+static inline bool fscrypt_mergeable_extent_bio(struct bio *bio,
+						const struct inode *inode,
+						const struct fscrypt_extent_info *ei,
+						u64 next_lblk)
+{
+	return true;
+}
+
 static inline bool fscrypt_mergeable_bio_bh(struct bio *bio,
 					    const struct buffer_head *next_bh)
 {
-- 
2.41.0


