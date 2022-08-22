Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6E559C824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 21:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiHVTKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 15:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiHVTKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995424F674;
        Mon, 22 Aug 2022 12:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9436C611CA;
        Mon, 22 Aug 2022 19:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB61FC433D6;
        Mon, 22 Aug 2022 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661195351;
        bh=FU3u6qa3Id0JTrIkCSG3A1Y9KETL1u6wCBMj2K++PEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fX4Mpem+OujhDDl3JK6bZz/q6qFlWTIIoJVHFS5inG4vWMhmvTDd3Jz3FyqQrxEPT
         pERgcxLgwJCSN63laQ0OtrTnqWvP2yLaCDIYSZbSgYWJe0osx8wGj7YnAc10WlED2J
         tAhTw4YNkmp7vRZ0K2lYDYOc6voiGALNCN8wrgqH6dTIt8y8MyLgA7iav5/kqrqsvH
         EWpm6H+h6Sp3Thm8PWtXeD/v4+HJ69DLw+SZVEA/Hw+w97YUJ02HEKUC3kLFibX5ik
         MazVRVnnQ5EiGjVxFKGB7jcMhef1XWSHe/fZExR/6VQYySdZZDGMM3xmWPHO09MDN+
         Abm1tgbU0fIjw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/3] fscrypt: stop holding extra request_queue references
Date:   Mon, 22 Aug 2022 12:08:11 -0700
Message-Id: <20220822190812.54581-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822190812.54581-1-ebiggers@kernel.org>
References: <20220822190812.54581-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the fscrypt_master_key lifetime has been reworked to not be
subject to the quirks of the keyrings subsystem, blk_crypto_evict_key()
no longer gets called after the filesystem has already been unmounted.
Therefore, there is no longer any need to hold extra references to the
filesystem's request_queue(s).  (And these references didn't always do
their intended job anyway, as pinning a request_queue doesn't
necessarily pin the corresponding blk_crypto_profile.)

Stop taking these extra references.  Instead, just pass the super_block
to fscrypt_destroy_inline_crypt_key(), and use it to get the list of
block devices the key needs to be evicted from.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 11 +++--
 fs/crypto/inline_crypt.c    | 83 ++++++++++++++++---------------------
 fs/crypto/keyring.c         |  9 ++--
 fs/crypto/keysetup.c        |  8 ++--
 fs/crypto/keysetup_v1.c     |  4 +-
 5 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index 0e2d3b0af0f79e..dcc005e3491453 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -184,7 +184,7 @@ struct fscrypt_symlink_data {
 struct fscrypt_prepared_key {
 	struct crypto_skcipher *tfm;
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
-	struct fscrypt_blk_crypto_key *blk_key;
+	struct blk_crypto_key *blk_key;
 #endif
 };
 
@@ -344,7 +344,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 				     const u8 *raw_key,
 				     const struct fscrypt_info *ci);
 
-void fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key);
+void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
+				      struct fscrypt_prepared_key *prep_key);
 
 /*
  * Check whether the crypto transform or blk-crypto key has been allocated in
@@ -390,7 +391,8 @@ fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 }
 
 static inline void
-fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key)
+fscrypt_destroy_inline_crypt_key(struct super_block *sb,
+				 struct fscrypt_prepared_key *prep_key)
 {
 }
 
@@ -600,7 +602,8 @@ extern struct fscrypt_mode fscrypt_modes[];
 int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
 			const u8 *raw_key, const struct fscrypt_info *ci);
 
-void fscrypt_destroy_prepared_key(struct fscrypt_prepared_key *prep_key);
+void fscrypt_destroy_prepared_key(struct super_block *sb,
+				  struct fscrypt_prepared_key *prep_key);
 
 int fscrypt_set_per_file_enc_key(struct fscrypt_info *ci, const u8 *raw_key);
 
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 90f3e68f166e39..a3225fe2291361 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -21,12 +21,6 @@
 
 #include "fscrypt_private.h"
 
-struct fscrypt_blk_crypto_key {
-	struct blk_crypto_key base;
-	int num_devs;
-	struct request_queue *devs[];
-};
-
 static int fscrypt_get_num_devices(struct super_block *sb)
 {
 	if (sb->s_cop->get_num_devices)
@@ -162,47 +156,37 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	const struct inode *inode = ci->ci_inode;
 	struct super_block *sb = inode->i_sb;
 	enum blk_crypto_mode_num crypto_mode = ci->ci_mode->blk_crypto_mode;
-	int num_devs = fscrypt_get_num_devices(sb);
-	int queue_refs = 0;
-	struct fscrypt_blk_crypto_key *blk_key;
+	struct blk_crypto_key *blk_key;
+	int num_devs;
+	struct request_queue **devs = NULL;
 	int err;
 	int i;
 
-	blk_key = kzalloc(struct_size(blk_key, devs, num_devs), GFP_KERNEL);
+	blk_key = kmalloc(sizeof(*blk_key), GFP_KERNEL);
 	if (!blk_key)
 		return -ENOMEM;
 
-	blk_key->num_devs = num_devs;
-	fscrypt_get_devices(sb, num_devs, blk_key->devs);
-
-	err = blk_crypto_init_key(&blk_key->base, raw_key, crypto_mode,
+	err = blk_crypto_init_key(blk_key, raw_key, crypto_mode,
 				  fscrypt_get_dun_bytes(ci), sb->s_blocksize);
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
-		goto fail;
+		goto out;
 	}
 
-	/*
-	 * We have to start using blk-crypto on all the filesystem's devices.
-	 * We also have to save all the request_queue's for later so that the
-	 * key can be evicted from them.  This is needed because some keys
-	 * aren't destroyed until after the filesystem was already unmounted
-	 * (namely, the per-mode keys in struct fscrypt_master_key).
-	 */
+	/* Start using blk-crypto on all the filesystem's block devices. */
+	num_devs = fscrypt_get_num_devices(sb);
+	devs = kmalloc_array(num_devs, sizeof(*devs), GFP_KERNEL);
+	if (!devs) {
+		err = -ENOMEM;
+		goto out;
+	}
+	fscrypt_get_devices(sb, num_devs, devs);
 	for (i = 0; i < num_devs; i++) {
-		if (!blk_get_queue(blk_key->devs[i])) {
-			fscrypt_err(inode, "couldn't get request_queue");
-			err = -EAGAIN;
-			goto fail;
-		}
-		queue_refs++;
-
-		err = blk_crypto_start_using_key(&blk_key->base,
-						 blk_key->devs[i]);
+		err = blk_crypto_start_using_key(blk_key, devs[i]);
 		if (err) {
 			fscrypt_err(inode,
 				    "error %d starting to use blk-crypto", err);
-			goto fail;
+			goto out;
 		}
 	}
 	/*
@@ -212,27 +196,32 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	 * possible for per-mode keys, not for per-file keys.
 	 */
 	smp_store_release(&prep_key->blk_key, blk_key);
-	return 0;
-
-fail:
-	for (i = 0; i < queue_refs; i++)
-		blk_put_queue(blk_key->devs[i]);
+	blk_key = NULL;
+	err = 0;
+out:
+	kfree(devs);
 	kfree_sensitive(blk_key);
 	return err;
 }
 
-void fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key)
+void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
+				      struct fscrypt_prepared_key *prep_key)
 {
-	struct fscrypt_blk_crypto_key *blk_key = prep_key->blk_key;
+	struct blk_crypto_key *blk_key = prep_key->blk_key;
+	int num_devs;
+	struct request_queue **devs;
 	int i;
 
-	if (blk_key) {
-		for (i = 0; i < blk_key->num_devs; i++) {
-			blk_crypto_evict_key(blk_key->devs[i], &blk_key->base);
-			blk_put_queue(blk_key->devs[i]);
-		}
-		kfree_sensitive(blk_key);
+	/* Evict the key from all the filesystem's block devices. */
+	num_devs = fscrypt_get_num_devices(sb);
+	devs = kmalloc_array(num_devs, sizeof(*devs), GFP_KERNEL);
+	if (devs) {
+		fscrypt_get_devices(sb, num_devs, devs);
+		for (i = 0; i < num_devs; i++)
+			blk_crypto_evict_key(devs[i], blk_key);
+		kfree(devs);
 	}
+	kfree_sensitive(blk_key);
 }
 
 bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
@@ -282,7 +271,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 	ci = inode->i_crypt_info;
 
 	fscrypt_generate_dun(ci, first_lblk, dun);
-	bio_crypt_set_ctx(bio, &ci->ci_enc_key.blk_key->base, dun, gfp_mask);
+	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
 
@@ -369,7 +358,7 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 	 * uses the same pointer.  I.e., there's currently no need to support
 	 * merging requests where the keys are the same but the pointers differ.
 	 */
-	if (bc->bc_key != &inode->i_crypt_info->ci_enc_key.blk_key->base)
+	if (bc->bc_key != inode->i_crypt_info->ci_enc_key.blk_key)
 		return false;
 
 	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 9b98d6a576e6a0..1cca09aa43f8b3 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -105,9 +105,12 @@ void fscrypt_put_master_key_activeref(struct fscrypt_master_key *mk)
 	WARN_ON(!list_empty(&mk->mk_decrypted_inodes));
 
 	for (i = 0; i <= FSCRYPT_MODE_MAX; i++) {
-		fscrypt_destroy_prepared_key(&mk->mk_direct_keys[i]);
-		fscrypt_destroy_prepared_key(&mk->mk_iv_ino_lblk_64_keys[i]);
-		fscrypt_destroy_prepared_key(&mk->mk_iv_ino_lblk_32_keys[i]);
+		fscrypt_destroy_prepared_key(
+				sb, &mk->mk_direct_keys[i]);
+		fscrypt_destroy_prepared_key(
+				sb, &mk->mk_iv_ino_lblk_64_keys[i]);
+		fscrypt_destroy_prepared_key(
+				sb, &mk->mk_iv_ino_lblk_32_keys[i]);
 	}
 	memzero_explicit(&mk->mk_ino_hash_key,
 			 sizeof(mk->mk_ino_hash_key));
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index e037a7b8e9e42b..f7407071a95242 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -154,10 +154,11 @@ int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
 }
 
 /* Destroy a crypto transform object and/or blk-crypto key. */
-void fscrypt_destroy_prepared_key(struct fscrypt_prepared_key *prep_key)
+void fscrypt_destroy_prepared_key(struct super_block *sb,
+				  struct fscrypt_prepared_key *prep_key)
 {
 	crypto_free_skcipher(prep_key->tfm);
-	fscrypt_destroy_inline_crypt_key(prep_key);
+	fscrypt_destroy_inline_crypt_key(sb, prep_key);
 	memzero_explicit(prep_key, sizeof(*prep_key));
 }
 
@@ -494,7 +495,8 @@ static void put_crypt_info(struct fscrypt_info *ci)
 	if (ci->ci_direct_key)
 		fscrypt_put_direct_key(ci->ci_direct_key);
 	else if (ci->ci_owns_key)
-		fscrypt_destroy_prepared_key(&ci->ci_enc_key);
+		fscrypt_destroy_prepared_key(ci->ci_inode->i_sb,
+					     &ci->ci_enc_key);
 
 	mk = ci->ci_master_key;
 	if (mk) {
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 2762c53504323f..75dabd9b27f9b6 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -143,6 +143,7 @@ find_and_lock_process_key(const char *prefix,
 
 /* Master key referenced by DIRECT_KEY policy */
 struct fscrypt_direct_key {
+	struct super_block		*dk_sb;
 	struct hlist_node		dk_node;
 	refcount_t			dk_refcount;
 	const struct fscrypt_mode	*dk_mode;
@@ -154,7 +155,7 @@ struct fscrypt_direct_key {
 static void free_direct_key(struct fscrypt_direct_key *dk)
 {
 	if (dk) {
-		fscrypt_destroy_prepared_key(&dk->dk_key);
+		fscrypt_destroy_prepared_key(dk->dk_sb, &dk->dk_key);
 		kfree_sensitive(dk);
 	}
 }
@@ -231,6 +232,7 @@ fscrypt_get_direct_key(const struct fscrypt_info *ci, const u8 *raw_key)
 	dk = kzalloc(sizeof(*dk), GFP_KERNEL);
 	if (!dk)
 		return ERR_PTR(-ENOMEM);
+	dk->dk_sb = ci->ci_inode->i_sb;
 	refcount_set(&dk->dk_refcount, 1);
 	dk->dk_mode = ci->ci_mode;
 	err = fscrypt_prepare_key(&dk->dk_key, raw_key, ci);
-- 
2.37.2

