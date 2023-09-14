Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5479FE07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjINIO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 04:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjINIOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:14:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF44C1BE6;
        Thu, 14 Sep 2023 01:14:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B881C433CB;
        Thu, 14 Sep 2023 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694679290;
        bh=cdkAH/oskwHvzF8j12szEYgbjRbtZUXjU97VQhihgfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Epb0jzo2Y5M8tvOFynD8JdYf2XrKhRdrms+dV1TRYHtgizjmhz7JQ2z3sjbrROjmI
         ow1Z3JjCpFx+DVF2BeXs0MoGhA/VLhRLfH9+eFkYxZnif/TXqNNrpM3WzlywwuutI3
         sk8Httf9+1G1RJzFnXV539Dj/L+L1GkhpuD+AxP1j0+HWIliJBoOEl89/mvdeOtE/P
         4FgSh8tipx0+JLG9paJ1ZTqLosdS16lFUdHYL3dRYiiNT49f4Xo5DwgF3YOUCa0k7M
         Kq1KF0errdmA7q9LyRZogmL2LZMrXmy3+nMLl9vdPhqPzzohVQm2CVqo5fk3FPWsrK
         ki9XXhnpX4tsQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 2/5] fscrypt: make the bounce page pool opt-in instead of opt-out
Date:   Thu, 14 Sep 2023 01:12:52 -0700
Message-ID: <20230914081255.193502-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914081255.193502-1-ebiggers@kernel.org>
References: <20230914081255.193502-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/ceph/crypto.c        |  1 +
 fs/crypto/crypto.c      |  9 ++++++++-
 fs/ext4/crypto.c        |  1 +
 fs/f2fs/super.c         |  1 +
 fs/ubifs/crypto.c       |  1 -
 include/linux/fscrypt.h | 19 ++++++++++---------
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index e4d5cd56a80b9..cc63f1e6fdef6 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -133,6 +133,7 @@ static const union fscrypt_policy *ceph_get_dummy_policy(struct super_block *sb)
 }
 
 static struct fscrypt_operations ceph_fscrypt_ops = {
+	.needs_bounce_pages	= 1,
 	.get_context		= ceph_crypt_get_context,
 	.set_context		= ceph_crypt_set_context,
 	.get_dummy_policy	= ceph_get_dummy_policy,
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
index 70e0d4917dd59..32290e5fa9abb 100644
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

