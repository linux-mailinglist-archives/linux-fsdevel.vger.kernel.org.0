Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821897ACFBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjIYF7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 01:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjIYF7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:59:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759B7DF;
        Sun, 24 Sep 2023 22:58:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7002C433CC;
        Mon, 25 Sep 2023 05:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695621539;
        bh=cz+gERetg21kponi71Jesmq5RBOAugZisOFCZXrnPoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOIWr4FQuLTUSVe5DbQnUf8DYvsA6dOLF9Z8hgHs6YuXdu2eRspUt+JKXDxnUaiUc
         8yMz1HAIqzuWfvAUNZ8eDM2pWxaSDQZO7eredhZ2tgvTx1x/avI2dukZCuiFPUD+i6
         SqqWxscoEtpz3c4VmWJwC8/LwksgCYIjTDTy6KEAptztbp0+QAaSjQYN9c4dIkAVhM
         zg5Fj17CjuNI3ensjc0Fk+X74jvFedal048aEJ5xpM8xAOaYodPiCV1BkXm65WjjHB
         PZoi7kMfEj6WHgQ5z2Z6RTGyb/7n9yLpB2ryYMDCWqAcFUGG3SBUU8REcCIr+aXCk9
         rOW3vF+8eGmWg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 2/5] fscrypt: make the bounce page pool opt-in instead of opt-out
Date:   Sun, 24 Sep 2023 22:54:48 -0700
Message-ID: <20230925055451.59499-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925055451.59499-1-ebiggers@kernel.org>
References: <20230925055451.59499-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Replace FS_CFLG_OWN_PAGES with a bit flag 'needs_bounce_pages' which has
the opposite meaning.  I.e., filesystems now opt into the bounce page
pool instead of opt out.  Make fscrypt_alloc_bounce_page() check that
the bounce page pool has been initialized.

I believe the opt-in makes more sense, since nothing else in
fscrypt_operations is opt-out, and these days filesystems can choose to
use blk-crypto which doesn't need the fscrypt bounce page pool.  Also, I
happen to be planning to add two more flags, and I wanted to fix the
"FS_CFLG_" name anyway as it wasn't prefixed with "FSCRYPT_".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ceph/crypto.c        |  1 +
 fs/crypto/crypto.c      |  9 ++++++++-
 fs/ext4/crypto.c        |  1 +
 fs/f2fs/super.c         |  1 +
 fs/ubifs/crypto.c       |  1 -
 include/linux/fscrypt.h | 20 +++++++++++---------
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index e4d5cd56a80b9..cc63f1e6fdef6 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -126,20 +126,21 @@ static bool ceph_crypt_empty_dir(struct inode *inode)
 
 	return ci->i_rsubdirs + ci->i_rfiles == 1;
 }
 
 static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
 {
 	return ceph_sb_to_client(sb)->fsc_dummy_enc_policy.policy;
 }
 
 static struct fscrypt_operations ceph_fscrypt_ops = {
+	.needs_bounce_pages	= 1,
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
 	.get_dummy_policy	= ceph_get_dummy_policy,
 	.empty_dir		= ceph_crypt_empty_dir,
 };
 
 void ceph_fscrypt_set_ops(struct super_block *sb)
 {
 	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
 }
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 6a837e4b80dcb..aed0c5ea75781 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -42,20 +42,27 @@ static DEFINE_MUTEX(fscrypt_init_mutex);
 struct kmem_cache *fscrypt_info_cachep;
 
 void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 {
 	queue_work(fscrypt_read_workqueue, work);
 }
 EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
 
 struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags)
 {
+	if (WARN_ON_ONCE(!fscrypt_bounce_page_pool)) {
+		/*
+		 * Oops, the filesystem called a function that uses the bounce
+		 * page pool, but it didn't set needs_bounce_pages.
+		 */
+		return NULL;
+	}
 	return mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
 }
 
 /**
  * fscrypt_free_bounce_page() - free a ciphertext bounce page
  * @bounce_page: the bounce page to free, or NULL
  *
  * Free a bounce page that was allocated by fscrypt_encrypt_pagecache_blocks(),
  * or by fscrypt_alloc_bounce_page() directly.
  */
@@ -318,21 +325,21 @@ EXPORT_SYMBOL(fscrypt_decrypt_block_inplace);
 int fscrypt_initialize(struct super_block *sb)
 {
 	int err = 0;
 	mempool_t *pool;
 
 	/* pairs with smp_store_release() below */
 	if (likely(smp_load_acquire(&fscrypt_bounce_page_pool)))
 		return 0;
 
 	/* No need to allocate a bounce page pool if this FS won't use it. */
-	if (sb->s_cop->flags & FS_CFLG_OWN_PAGES)
+	if (!sb->s_cop->needs_bounce_pages)
 		return 0;
 
 	mutex_lock(&fscrypt_init_mutex);
 	if (fscrypt_bounce_page_pool)
 		goto out_unlock;
 
 	err = -ENOMEM;
 	pool = mempool_create_page_pool(num_prealloc_crypto_pages, 0);
 	if (!pool)
 		goto out_unlock;
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 99a4769a53f63..5cd7bcfae46b2 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -233,18 +233,19 @@ static bool ext4_has_stable_inodes(struct super_block *sb)
 }
 
 static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
 				       int *ino_bits_ret, int *lblk_bits_ret)
 {
 	*ino_bits_ret = 8 * sizeof(EXT4_SB(sb)->s_es->s_inodes_count);
 	*lblk_bits_ret = 8 * sizeof(ext4_lblk_t);
 }
 
 const struct fscrypt_operations ext4_cryptops = {
+	.needs_bounce_pages	= 1,
 	.legacy_key_prefix	= "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
 	.get_dummy_policy	= ext4_get_dummy_policy,
 	.empty_dir		= ext4_empty_dir,
 	.has_stable_inodes	= ext4_has_stable_inodes,
 	.get_ino_and_lblk_bits	= ext4_get_ino_and_lblk_bits,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f60062b558fd1..55aa0ed531f22 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3224,20 +3224,21 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 	if (!devs)
 		return ERR_PTR(-ENOMEM);
 
 	for (i = 0; i < sbi->s_ndevs; i++)
 		devs[i] = FDEV(i).bdev;
 	*num_devs = sbi->s_ndevs;
 	return devs;
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
+	.needs_bounce_pages	= 1,
 	.legacy_key_prefix	= "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
 	.get_dummy_policy	= f2fs_get_dummy_policy,
 	.empty_dir		= f2fs_empty_dir,
 	.has_stable_inodes	= f2fs_has_stable_inodes,
 	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
 	.get_devices		= f2fs_get_devices,
 };
 #endif
diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index 1be3e11da3b3e..921f9033d0d2d 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -81,16 +81,15 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 	if (err) {
 		ubifs_err(c, "fscrypt_decrypt_block_inplace() failed: %d", err);
 		return err;
 	}
 	*out_len = clen;
 
 	return 0;
 }
 
 const struct fscrypt_operations ubifs_crypt_operations = {
-	.flags			= FS_CFLG_OWN_PAGES,
 	.legacy_key_prefix	= "ubifs:",
 	.get_context		= ubifs_crypt_get_context,
 	.set_context		= ubifs_crypt_set_context,
 	.empty_dir		= ubifs_crypt_empty_dir,
 };
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index b0037566ce308..4505078e89b7e 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -52,32 +52,34 @@ struct fscrypt_name {
 #define FSTR_INIT(n, l)		{ .name = n, .len = l }
 #define FSTR_TO_QSTR(f)		QSTR_INIT((f)->name, (f)->len)
 #define fname_name(p)		((p)->disk_name.name)
 #define fname_len(p)		((p)->disk_name.len)
 
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
 #ifdef CONFIG_FS_ENCRYPTION
 
-/*
- * If set, the fscrypt bounce page pool won't be allocated (unless another
- * filesystem needs it).  Set this if the filesystem always uses its own bounce
- * pages for writes and therefore won't need the fscrypt bounce page pool.
- */
-#define FS_CFLG_OWN_PAGES (1U << 1)
-
 /* Crypto operations for filesystems */
 struct fscrypt_operations {
 
-	/* Set of optional flags; see above for allowed flags */
-	unsigned int flags;
+	/*
+	 * If set, then fs/crypto/ will allocate a global bounce page pool the
+	 * first time an encryption key is set up for a file.  The bounce page
+	 * pool is required by the following functions:
+	 *
+	 * - fscrypt_encrypt_pagecache_blocks()
+	 * - fscrypt_zeroout_range() for files not using inline crypto
+	 *
+	 * If the filesystem doesn't use those, it doesn't need to set this.
+	 */
+	unsigned int needs_bounce_pages : 1;
 
 	/*
 	 * This field exists only for backwards compatibility reasons and should
 	 * only be set by the filesystems that are setting it already.  It
 	 * contains the filesystem-specific key description prefix that is
 	 * accepted for "logon" keys for v1 fscrypt policies.  This
 	 * functionality is deprecated in favor of the generic prefix
 	 * "fscrypt:", which itself is deprecated in favor of the filesystem
 	 * keyring ioctls such as FS_IOC_ADD_ENCRYPTION_KEY.  Filesystems that
 	 * are newly adding fscrypt support should not set this field.
-- 
2.42.0

