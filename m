Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965C96C25DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 00:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCTXm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 19:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCTXmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED03668D;
        Mon, 20 Mar 2023 16:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CFC61811;
        Mon, 20 Mar 2023 23:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4FCC433D2;
        Mon, 20 Mar 2023 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679355636;
        bh=g7mhOvFG+/kg/Y16MNEcyeKefaDdauSz4l/uJyKEdiI=;
        h=From:To:Cc:Subject:Date:From;
        b=gYeHatUeXstLOxstDvUNn3MdQv44uldXscn4z/4oM0ZIu7FS2vEuuDHiGs8d5q3Xs
         +CUaQU+PqZlz79OTCS4yNVl0D4c0GyChXm3Ic+N1Emu1UuPuh+4SOrdjlcasdZvhPV
         Js9Qu0B6OcP9MOLrkGjyL90LwN7uITx+CKuNjouQ+nPYZuQrcwtk1um59qbv9KziVJ
         1LrA33LF9JTdxXt2vfwPT9I4o7ty9r2J587enhrXuPevRnYtpDyuOvInfoRtU8oQdN
         WpuhH18TYjXiqhE5gW00QMTYaVCFnxEhDy76KIYv/3ScXQWRecJBdv2HWmrXiouIOw
         vWZC5/oyKHQ3w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fscrypt: use WARN_ON_ONCE instead of WARN_ON
Date:   Mon, 20 Mar 2023 16:39:43 -0700
Message-Id: <20230320233943.73600-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

As per Linus's suggestion
(https://lore.kernel.org/r/CAHk-=whefxRGyNGzCzG6BVeM=5vnvgb-XhSeFJVxJyAxAF8XRA@mail.gmail.com),
use WARN_ON_ONCE instead of WARN_ON.  This barely adds any extra
overhead, and it makes it so that if any of these ever becomes reachable
(they shouldn't, but that's the point), the logs can't be flooded.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/bio.c             |  6 +++---
 fs/crypto/fname.c           |  4 ++--
 fs/crypto/fscrypt_private.h |  4 ++--
 fs/crypto/hkdf.c            |  4 ++--
 fs/crypto/hooks.c           |  2 +-
 fs/crypto/keyring.c         | 14 +++++++-------
 fs/crypto/keysetup.c        | 12 ++++++------
 fs/crypto/policy.c          |  4 ++--
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index d57d0a020f71c..62e1a3dd83574 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -69,7 +69,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 					pblk << (blockbits - SECTOR_SHIFT);
 		}
 		ret = bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
-		if (WARN_ON(ret != bytes_this_page)) {
+		if (WARN_ON_ONCE(ret != bytes_this_page)) {
 			err = -EIO;
 			goto out;
 		}
@@ -147,7 +147,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			break;
 	}
 	nr_pages = i;
-	if (WARN_ON(nr_pages <= 0))
+	if (WARN_ON_ONCE(nr_pages <= 0))
 		return -EINVAL;
 
 	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
@@ -170,7 +170,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			offset += blocksize;
 			if (offset == PAGE_SIZE || len == 0) {
 				ret = bio_add_page(bio, pages[i++], offset, 0);
-				if (WARN_ON(ret != offset)) {
+				if (WARN_ON_ONCE(ret != offset)) {
 					err = -EIO;
 					goto out;
 				}
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 12bd61d20f694..6eae3f12ad503 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -110,7 +110,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
 	 * Copy the filename to the output buffer for encrypting in-place and
 	 * pad it with the needed number of NUL bytes.
 	 */
-	if (WARN_ON(olen < iname->len))
+	if (WARN_ON_ONCE(olen < iname->len))
 		return -ENOBUFS;
 	memcpy(out, iname->name, iname->len);
 	memset(out + iname->len, 0, olen - iname->len);
@@ -570,7 +570,7 @@ u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
 {
 	const struct fscrypt_info *ci = dir->i_crypt_info;
 
-	WARN_ON(!ci->ci_dirhash_key_initialized);
+	WARN_ON_ONCE(!ci->ci_dirhash_key_initialized);
 
 	return siphash(name->name, name->len, &ci->ci_dirhash_key);
 }
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 0fec2dfc36ebe..05310aa741fd6 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -101,7 +101,7 @@ static inline const u8 *fscrypt_context_nonce(const union fscrypt_context *ctx)
 	case FSCRYPT_CONTEXT_V2:
 		return ctx->v2.nonce;
 	}
-	WARN_ON(1);
+	WARN_ON_ONCE(1);
 	return NULL;
 }
 
@@ -386,7 +386,7 @@ fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 				 const u8 *raw_key,
 				 const struct fscrypt_info *ci)
 {
-	WARN_ON(1);
+	WARN_ON_ONCE(1);
 	return -EOPNOTSUPP;
 }
 
diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
index 7607d18b35fc0..5a384dad2c72f 100644
--- a/fs/crypto/hkdf.c
+++ b/fs/crypto/hkdf.c
@@ -79,7 +79,7 @@ int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
 		return PTR_ERR(hmac_tfm);
 	}
 
-	if (WARN_ON(crypto_shash_digestsize(hmac_tfm) != sizeof(prk))) {
+	if (WARN_ON_ONCE(crypto_shash_digestsize(hmac_tfm) != sizeof(prk))) {
 		err = -EINVAL;
 		goto err_free_tfm;
 	}
@@ -125,7 +125,7 @@ int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 	u8 counter = 1;
 	u8 tmp[HKDF_HASHLEN];
 
-	if (WARN_ON(okmlen > 255 * HKDF_HASHLEN))
+	if (WARN_ON_ONCE(okmlen > 255 * HKDF_HASHLEN))
 		return -EINVAL;
 
 	desc->tfm = hkdf->hmac_tfm;
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 9151934c50866..9e786ae66a134 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -345,7 +345,7 @@ const char *fscrypt_get_symlink(struct inode *inode, const void *caddr,
 	int err;
 
 	/* This is for encrypted symlinks only */
-	if (WARN_ON(!IS_ENCRYPTED(inode)))
+	if (WARN_ON_ONCE(!IS_ENCRYPTED(inode)))
 		return ERR_PTR(-EINVAL);
 
 	/* If the decrypted target is already cached, just return it. */
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 13d336a6cc5da..7cbb1fd872acc 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -73,7 +73,7 @@ void fscrypt_put_master_key(struct fscrypt_master_key *mk)
 	 * fscrypt_master_key struct itself after an RCU grace period ensures
 	 * that concurrent keyring lookups can no longer find it.
 	 */
-	WARN_ON(refcount_read(&mk->mk_active_refs) != 0);
+	WARN_ON_ONCE(refcount_read(&mk->mk_active_refs) != 0);
 	key_put(mk->mk_users);
 	mk->mk_users = NULL;
 	call_rcu(&mk->mk_rcu_head, fscrypt_free_master_key);
@@ -92,7 +92,7 @@ void fscrypt_put_master_key_activeref(struct super_block *sb,
 	 * destroying any subkeys embedded in it.
 	 */
 
-	if (WARN_ON(!sb->s_master_keys))
+	if (WARN_ON_ONCE(!sb->s_master_keys))
 		return;
 	spin_lock(&sb->s_master_keys->lock);
 	hlist_del_rcu(&mk->mk_node);
@@ -102,8 +102,8 @@ void fscrypt_put_master_key_activeref(struct super_block *sb,
 	 * ->mk_active_refs == 0 implies that ->mk_secret is not present and
 	 * that ->mk_decrypted_inodes is empty.
 	 */
-	WARN_ON(is_master_key_secret_present(&mk->mk_secret));
-	WARN_ON(!list_empty(&mk->mk_decrypted_inodes));
+	WARN_ON_ONCE(is_master_key_secret_present(&mk->mk_secret));
+	WARN_ON_ONCE(!list_empty(&mk->mk_decrypted_inodes));
 
 	for (i = 0; i <= FSCRYPT_MODE_MAX; i++) {
 		fscrypt_destroy_prepared_key(
@@ -237,9 +237,9 @@ void fscrypt_destroy_keyring(struct super_block *sb)
 			 * with ->mk_secret.  There should be no structural refs
 			 * beyond the one associated with the active ref.
 			 */
-			WARN_ON(refcount_read(&mk->mk_active_refs) != 1);
-			WARN_ON(refcount_read(&mk->mk_struct_refs) != 1);
-			WARN_ON(!is_master_key_secret_present(&mk->mk_secret));
+			WARN_ON_ONCE(refcount_read(&mk->mk_active_refs) != 1);
+			WARN_ON_ONCE(refcount_read(&mk->mk_struct_refs) != 1);
+			WARN_ON_ONCE(!is_master_key_secret_present(&mk->mk_secret));
 			wipe_master_key_secret(&mk->mk_secret);
 			fscrypt_put_master_key_activeref(sb, mk);
 		}
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index aa94fba9d17e7..84cdae3063280 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -125,7 +125,7 @@ fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
 		pr_info("fscrypt: %s using implementation \"%s\"\n",
 			mode->friendly_name, crypto_skcipher_driver_name(tfm));
 	}
-	if (WARN_ON(crypto_skcipher_ivsize(tfm) != mode->ivsize)) {
+	if (WARN_ON_ONCE(crypto_skcipher_ivsize(tfm) != mode->ivsize)) {
 		err = -EINVAL;
 		goto err_free_tfm;
 	}
@@ -199,7 +199,7 @@ static int setup_per_mode_enc_key(struct fscrypt_info *ci,
 	unsigned int hkdf_infolen = 0;
 	int err;
 
-	if (WARN_ON(mode_num > FSCRYPT_MODE_MAX))
+	if (WARN_ON_ONCE(mode_num > FSCRYPT_MODE_MAX))
 		return -EINVAL;
 
 	prep_key = &keys[mode_num];
@@ -282,8 +282,8 @@ int fscrypt_derive_dirhash_key(struct fscrypt_info *ci,
 void fscrypt_hash_inode_number(struct fscrypt_info *ci,
 			       const struct fscrypt_master_key *mk)
 {
-	WARN_ON(ci->ci_inode->i_ino == 0);
-	WARN_ON(!mk->mk_ino_hash_key_initialized);
+	WARN_ON_ONCE(ci->ci_inode->i_ino == 0);
+	WARN_ON_ONCE(!mk->mk_ino_hash_key_initialized);
 
 	ci->ci_hashed_ino = (u32)siphash_1u64(ci->ci_inode->i_ino,
 					      &mk->mk_ino_hash_key);
@@ -503,7 +503,7 @@ static int setup_file_encryption_key(struct fscrypt_info *ci,
 		err = fscrypt_setup_v2_file_key(ci, mk, need_dirhash_key);
 		break;
 	default:
-		WARN_ON(1);
+		WARN_ON_ONCE(1);
 		err = -EINVAL;
 		break;
 	}
@@ -577,7 +577,7 @@ fscrypt_setup_encryption_info(struct inode *inode,
 		res = PTR_ERR(mode);
 		goto out;
 	}
-	WARN_ON(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
+	WARN_ON_ONCE(mode->ivsize > FSCRYPT_MAX_IV_SIZE);
 	crypt_info->ci_mode = mode;
 
 	res = setup_file_encryption_key(crypt_info, need_dirhash_key, &mk);
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 3b5fcb6402eae..f4456ecb3f877 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -48,7 +48,7 @@ int fscrypt_policy_to_key_spec(const union fscrypt_policy *policy,
 		       FSCRYPT_KEY_IDENTIFIER_SIZE);
 		return 0;
 	default:
-		WARN_ON(1);
+		WARN_ON_ONCE(1);
 		return -EINVAL;
 	}
 }
@@ -463,7 +463,7 @@ static int set_encryption_policy(struct inode *inode,
 				     current->comm, current->pid);
 		break;
 	default:
-		WARN_ON(1);
+		WARN_ON_ONCE(1);
 		return -EINVAL;
 	}
 

base-commit: 704d0e7a9b7d3bfb8630f0ab735ea5330597baf7
-- 
2.40.0

