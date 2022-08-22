Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8AD59BF70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiHVMZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiHVMZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:25:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A4E0F;
        Mon, 22 Aug 2022 05:25:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC56F68AA6; Mon, 22 Aug 2022 14:25:27 +0200 (CEST)
Date:   Mon, 22 Aug 2022 14:25:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] fscrypt: rework filesystem-level keyring
Message-ID: <20220822122527.GA14620@lst.de>
References: <20220820190210.169734-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820190210.169734-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 20, 2022 at 12:02:08PM -0700, Eric Biggers wrote:
> This series reworks the filesystem-level keyring to not use the keyrings
> subsystem as part of its internal implementation (except for ->mk_users,
> which remains unchanged for now).  This fixes several issues, described
> in the first patch.  This is also a prerequisite for removing the direct
> use of struct request_queue from filesystem code, as discussed at
> https://lore.kernel.org/linux-fscrypt/20220721125929.1866403-1-hch@lst.de/T/#u

Nice, this looks great to me. Something like the patch below would be
good to include with this series for the current merge window, I can then
attack the block layer side for the release after that.

---
From e038171b286e2747cbc54e36a8d0e0d6b8a2071e Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 22 Aug 2022 14:08:52 +0200
Subject: fscrypt: work on block_device instead of request_queues

request_queues are a block layer implementation detail that should not
leak into file systems.  Change the fscrypt inline crypto code to
retrieve block devices instead of request_queues from the file system.
As part of that clean up the interaction with multi-device file systems
by returning both the number of devices and the actual device array
in a single method call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/inline_crypt.c | 73 ++++++++++++++++++++--------------------
 fs/f2fs/super.c          | 24 ++++++-------
 include/linux/fscrypt.h  | 21 ++++++------
 3 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index f75dcb403c365..88ca838fa1b25 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -21,20 +21,21 @@
 
 #include "fscrypt_private.h"
 
-static int fscrypt_get_num_devices(struct super_block *sb)
+static struct block_device **fscrypt_get_devices(struct super_block *sb,
+						 unsigned int *num_devs)
 {
-	if (sb->s_cop->get_num_devices)
-		return sb->s_cop->get_num_devices(sb);
-	return 1;
-}
+	struct block_device **devs;
 
-static void fscrypt_get_devices(struct super_block *sb, int num_devs,
-				struct block_device **devs)
-{
-	if (num_devs == 1)
-		devs[0] = sb->s_bdev;
-	else
-		sb->s_cop->get_devices(sb, devs);
+	if (sb->s_cop->get_devices) {
+		devs = sb->s_cop->get_devices(sb, num_devs);
+		if (devs)
+			return devs;
+	}
+	devs = kmalloc(sizeof(*devs), GFP_KERNEL);
+	if (!devs)
+		return ERR_PTR(-ENOMEM);
+	devs[0] = sb->s_bdev;
+	return devs;
 }
 
 static unsigned int fscrypt_get_dun_bytes(const struct fscrypt_info *ci)
@@ -76,6 +77,7 @@ static void fscrypt_log_blk_crypto_impl(struct fscrypt_mode *mode,
 
 	for (i = 0; i < num_devs; i++) {
 		struct request_queue *q = bdev_get_queue(devs[i]);
+
 		if (!IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) ||
 		    __blk_crypto_cfg_supported(q->crypto_profile, cfg)) {
 			if (!xchg(&mode->logged_blk_crypto_native, 1))
@@ -94,8 +96,8 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	const struct inode *inode = ci->ci_inode;
 	struct super_block *sb = inode->i_sb;
 	struct blk_crypto_config crypto_cfg;
-	int num_devs;
 	struct block_device **devs;
+	unsigned int num_devs;
 	int i;
 
 	/* The file must need contents encryption, not filenames encryption */
@@ -130,12 +132,10 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	crypto_cfg.crypto_mode = ci->ci_mode->blk_crypto_mode;
 	crypto_cfg.data_unit_size = sb->s_blocksize;
 	crypto_cfg.dun_bytes = fscrypt_get_dun_bytes(ci);
-	num_devs = fscrypt_get_num_devices(sb);
-	devs = kmalloc_array(num_devs, sizeof(*devs), GFP_KERNEL);
-	if (!devs)
-		return -ENOMEM;
-	fscrypt_get_devices(sb, num_devs, devs);
 
+	devs = fscrypt_get_devices(sb, &num_devs);
+	if (IS_ERR(devs))
+		return PTR_ERR(devs);
 	for (i = 0; i < num_devs; i++) {
 		if (!blk_crypto_config_supported(bdev_get_queue(devs[i]),
 						 &crypto_cfg))
@@ -159,8 +159,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	struct super_block *sb = inode->i_sb;
 	enum blk_crypto_mode_num crypto_mode = ci->ci_mode->blk_crypto_mode;
 	struct blk_crypto_key *blk_key;
-	int num_devs;
 	struct block_device **devs = NULL;
+	unsigned int num_devs;
 	int err;
 	int i;
 
@@ -176,22 +176,25 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	}
 
 	/* Start using blk-crypto on all the filesystem's block devices. */
-	num_devs = fscrypt_get_num_devices(sb);
-	devs = kmalloc_array(num_devs, sizeof(*devs), GFP_KERNEL);
-	if (!devs) {
-		err = -ENOMEM;
+	devs = fscrypt_get_devices(sb, &num_devs);
+	if (IS_ERR(devs)) {
+		err = PTR_ERR(devs);
 		goto out;
 	}
-	fscrypt_get_devices(sb, num_devs, devs);
 	for (i = 0; i < num_devs; i++) {
 		err = blk_crypto_start_using_key(blk_key,
 						 bdev_get_queue(devs[i]));
-		if (err) {
-			fscrypt_err(inode,
-				    "error %d starting to use blk-crypto", err);
-			goto out;
-		}
+		if (err)
+			break;
 	}
+	kfree(devs);
+
+	if (err) {
+		fscrypt_err(inode,
+			    "error %d starting to use blk-crypto", err);
+		goto out;
+	}
+
 	/*
 	 * Pairs with the smp_load_acquire() in fscrypt_is_key_prepared().
 	 * I.e., here we publish ->blk_key with a RELEASE barrier so that
@@ -199,10 +202,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 	 * possible for per-mode keys, not for per-file keys.
 	 */
 	smp_store_release(&prep_key->blk_key, blk_key);
-	blk_key = NULL;
-	err = 0;
+	return 0;
 out:
-	kfree(devs);
 	kfree_sensitive(blk_key);
 	return err;
 }
@@ -211,15 +212,13 @@ void fscrypt_destroy_inline_crypt_key(struct super_block *sb,
 				      struct fscrypt_prepared_key *prep_key)
 {
 	struct blk_crypto_key *blk_key = prep_key->blk_key;
-	int num_devs;
 	struct block_device **devs;
+	unsigned int num_devs;
 	int i;
 
 	/* Evict the key from all the filesystem's block devices. */
-	num_devs = fscrypt_get_num_devices(sb);
-	devs = kmalloc_array(num_devs, sizeof(*devs), GFP_KERNEL);
-	if (devs) {
-		fscrypt_get_devices(sb, num_devs, devs);
+	devs = fscrypt_get_devices(sb, &num_devs);
+	if (IS_ERR(devs)) {
 		for (i = 0; i < num_devs; i++)
 			blk_crypto_evict_key(bdev_get_queue(devs[i]), blk_key);
 		kfree(devs);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7dcac93e00eba..26817b5aeac78 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3039,23 +3039,24 @@ static void f2fs_get_ino_and_lblk_bits(struct super_block *sb,
 	*lblk_bits_ret = 8 * sizeof(block_t);
 }
 
-static int f2fs_get_num_devices(struct super_block *sb)
+static struct block_device **f2fs_get_devices(struct super_block *sb,
+					      unsigned int *num_devs)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct block_device **devs;
+	int i;
 
-	if (f2fs_is_multi_device(sbi))
-		return sbi->s_ndevs;
-	return 1;
-}
+	if (!f2fs_is_multi_device(sbi))
+		return NULL;
 
-static void f2fs_get_devices(struct super_block *sb,
-			     struct block_device **bdevs)
-{
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	int i;
+	devs = kmalloc_array(sbi->s_ndevs, sizeof(*devs), GFP_KERNEL);
+	if (!devs)
+		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < sbi->s_ndevs; i++)
-		bdevs[i] = FDEV(i).bdev;
+		devs[i] = FDEV(i).bdev;
+	*num_devs = sbi->s_ndevs;
+	return devs;
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
@@ -3066,7 +3067,6 @@ static const struct fscrypt_operations f2fs_cryptops = {
 	.empty_dir		= f2fs_empty_dir,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
 	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
-	.get_num_devices	= f2fs_get_num_devices,
 	.get_devices		= f2fs_get_devices,
 };
 #endif
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 5097dbd048a4a..ea6485cb0e351 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -161,23 +161,22 @@ struct fscrypt_operations {
 				      int *ino_bits_ret, int *lblk_bits_ret);
 
 	/*
-	 * Return the number of block devices to which the filesystem may write
-	 * encrypted file contents.
+	 * Return an array of pointers to the block devices to which the file
+	 * system may write encrypted file contents, NULL if the file system
+	 * only has a single device or an ERR_PTR() on error.
+	 *
+	 * On successful return, *num_devs is set to the number of devices in
+	 * the returned array.
 	 *
 	 * If the filesystem can use multiple block devices (other than block
 	 * devices that aren't used for encrypted file contents, such as
 	 * external journal devices), and wants to support inline encryption,
 	 * then it must implement this function.  Otherwise it's not needed.
+	 *
+	 * The returned array must be freed by the caller using kfree().
 	 */
-	int (*get_num_devices)(struct super_block *sb);
-
-	/*
-	 * If ->get_num_devices() returns a value greater than 1, then this
-	 * function is called to get the array of block devices that the
-	 * filesystem is using.
-	 */
-	void (*get_devices)(struct super_block *sb,
-			    struct block_device **bdev);
+	struct block_device **(*get_devices)(struct super_block *sb,
+					     unsigned int *num_devs);
 };
 
 static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)
-- 
2.30.2

