Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC43B7924F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjIEQAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243917AbjIEBEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDDB1BE;
        Mon,  4 Sep 2023 18:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C48461197;
        Tue,  5 Sep 2023 01:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00CCC433C8;
        Tue,  5 Sep 2023 01:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693875866;
        bh=mA/Dvgn43PcLulCBha8yDFRXAbYYmz0W5UhWW5k2V0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqsUKpp+DESWe4xI4x4m+43TguAisfpiOWMlga8z5er8oM3F0oHOQNRAnTX5TBQg3
         UuV8aCgTuSbhnsofkbhOgSDf0l/QqCr45WJpwvrizqcDgOfltg8/pUM3ncdj3vm8yl
         9kS3Y1jc06DxH/qbMp2iyLyZXHd97llvlE6NM+FbNiX7cvB/vbctzzz926HgBKzJZS
         bbuT3LIkc6AyHdfhm2duWA3lHHBnTSQ9bwVfrbP7nFRm02mVBn4Lx+mnJmAa9O7y1w
         I2/0k/V5UIEUTO22Al89dZxI+miSnWEaIEPvzMHck9D8TGtuveZqlitVPKFBjyGXDX
         8T56f8ALmUVgQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] fscrypt: make the bounce page pool opt-in instead of opt-out
Date:   Mon,  4 Sep 2023 17:58:27 -0700
Message-ID: <20230905005830.365985-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905005830.365985-1-ebiggers@kernel.org>
References: <20230905005830.365985-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
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

I believe the opt in makes more sense, since nothing else in
fscrypt_operations is opt out, and these days filesystems can choose to
use blk-crypto which doesn't need the fscrypt bounce page pool.  Also, I
happen to be planning to add two more flags, and I wanted to fix the
"FS_CFLG_" name anyway as it wasn't prefixed with "FSCRYPT_".

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/crypto.c      |  9 ++++++++-
 fs/ext4/crypto.c        |  1 +
 fs/f2fs/super.c         |  1 +
 fs/ubifs/crypto.c       |  1 -
 include/linux/fscrypt.h | 19 ++++++++++---------
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 6a837e4b80dcb..803347a5d0a6d 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -49,6 +49,13 @@ EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
 
 struct page *fscrypt_alloc_bounce_page(gfp_t gfp_flags)
 {
+	if (WARN_ON_ONCE(!fscrypt_bounce_page_pool)) {
+		/*
+		 * Oops, the filesystem called a function that uses the bounce
+		 * page pool, but it forgot to set needs_bounce_pages.
+		 */
+		return NULL;
+	}
 	return mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
 }
 
@@ -325,7 +332,7 @@ int fscrypt_initialize(struct super_block *sb)
 		return 0;
 
 	/* No need to allocate a bounce page pool if this FS won't use it. */
-	if (sb->s_cop->flags & FS_CFLG_OWN_PAGES)
+	if (!sb->s_cop->needs_bounce_pages)
 		return 0;
 
 	mutex_lock(&fscrypt_init_mutex);
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index 8cdb7bbc655b0..a9221be67f2a7 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -240,6 +240,7 @@ static void ext4_get_ino_and_lblk_bits(struct super_block *sb,
 }
 
 const struct fscrypt_operations ext4_cryptops = {
+	.needs_bounce_pages	= 1,
 	.legacy_key_prefix_for_backcompat = "ext4:",
 	.get_context		= ext4_get_context,
 	.set_context		= ext4_set_context,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8de799a8bad04..276535af5bf3c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3231,6 +3231,7 @@ static struct block_device **f2fs_get_devices(struct super_block *sb,
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
+	.needs_bounce_pages	= 1,
 	.legacy_key_prefix_for_backcompat = "f2fs:",
 	.get_context		= f2fs_get_context,
 	.set_context		= f2fs_set_context,
diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index fab90f9a8eaff..f0ca403777d9a 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -88,7 +88,6 @@ int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 }
 
 const struct fscrypt_operations ubifs_crypt_operations = {
-	.flags			= FS_CFLG_OWN_PAGES,
 	.legacy_key_prefix_for_backcompat = "ubifs:",
 	.get_context		= ubifs_crypt_get_context,
 	.set_context		= ubifs_crypt_set_context,
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 85574282c7e52..ac684f688d488 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -59,18 +59,19 @@ struct fscrypt_name {
 
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
+	 * If set, then fs/crypto/ will allocate a global bounce page pool.  The
+	 * bounce page pool is required by the following functions:
+	 *
+	 * - fscrypt_encrypt_pagecache_blocks()
+	 * - fscrypt_zeroout_range() for files not using inline crypto
+	 *
+	 * If the filesystem doesn't use those, it doesn't need to set this.
+	 */
+	unsigned int needs_bounce_pages : 1;
 
 	/*
 	 * This field exists only for backwards compatibility reasons and should
-- 
2.42.0

