Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55976243EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKJONk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKJONf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:13:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1EA6CA33
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668089565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mBXMF4B6CEl+n3vdku7YjkCRNE2TryZTPl46Y2nSdE=;
        b=MzzrIatceiv87YN1UnC+yjvArrvl1wbqt6gzV91JfiThc2QJAw6JFhxqwG0F94QKYLz3g7
        gty4FnsKGNwoEIl6OdSwD9KldFlzw2ZbITUagQQpoWPF4vaXaI/P7abCbkDaygjx1JQz3F
        vHf3SCbGyeeTfBEpgZpCJ5cT8A8FxiA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-ijXj1jSpOyO2ErL4-Ht8OQ-1; Thu, 10 Nov 2022 09:12:43 -0500
X-MC-Unique: ijXj1jSpOyO2ErL4-Ht8OQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 545582999B4A;
        Thu, 10 Nov 2022 14:12:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB351492B0F;
        Thu, 10 Nov 2022 14:12:42 +0000 (UTC)
From:   Niels de Vos <ndevos@redhat.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>,
        Niels de Vos <ndevos@redhat.com>
Subject: [RFC 3/4] fs: make fscrypt support a f2fs config option
Date:   Thu, 10 Nov 2022 15:12:24 +0100
Message-Id: <20221110141225.2308856-4-ndevos@redhat.com>
In-Reply-To: <20221110141225.2308856-1-ndevos@redhat.com>
References: <20221110141225.2308856-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add CONFIG_F2FS_FS_ENCRYPTION as a config option, which depends on the
global CONFIG_FS_ENCRYPTION setting. This makes it possible to opt-out
of fscrypt for f2fs, while enabling it for others.

Signed-off-by: Niels de Vos <ndevos@redhat.com>
---
 fs/crypto/Kconfig |  1 +
 fs/f2fs/Kconfig   | 15 +++++++++++++--
 fs/f2fs/data.c    |  2 +-
 fs/f2fs/dir.c     |  6 +++---
 fs/f2fs/f2fs.h    |  6 +++---
 fs/f2fs/super.c   |  6 +++---
 fs/f2fs/sysfs.c   |  8 ++++----
 7 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 7e1267deee51..a809847e820d 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -7,6 +7,7 @@ config FS_ENCRYPTION
 	select CRYPTO_LIB_SHA256
 	select KEYS
 	imply EXT4_FS_ENCRYPTION
+	imply F2FS_FS_ENCRYPTION
 	help
 	  Enable encryption of files and directories.  This
 	  feature is similar to ecryptfs, but it is more memory
diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 03ef087537c7..801ade82d5c6 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -5,8 +5,6 @@ config F2FS_FS
 	select NLS
 	select CRYPTO
 	select CRYPTO_CRC32
-	select F2FS_FS_XATTR if FS_ENCRYPTION
-	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
 	select FS_IOMAP
 	select LZ4_COMPRESS if F2FS_FS_LZ4
 	select LZ4_DECOMPRESS if F2FS_FS_LZ4
@@ -76,6 +74,19 @@ config F2FS_FS_SECURITY
 
 	  If you are not using a security module, say N.
 
+config F2FS_FS_ENCRYPTION
+	bool "F2FS with support for filesystem encryption"
+	depends on F2FS_FS
+	depends on FS_ENCRYPTION
+	select F2FS_FS_XATTR
+	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
+	help
+	  Enable encryption of files and directories. This feature is similar
+	  to ecryptfs, but it is more memory efficient since it avoids caching
+          the encrypted and decrypted pages in the page cache.
+
+	  If unsure, say N.
+
 config F2FS_CHECK_FS
 	bool "F2FS consistency checking feature"
 	depends on F2FS_FS
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a71e818cd67b..446d2eba964e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -94,7 +94,7 @@ static enum count_type __read_io_type(struct page *page)
 
 /* postprocessing steps for read bios */
 enum bio_post_read_step {
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	STEP_DECRYPT	= 1 << 0,
 #else
 	STEP_DECRYPT	= 0,	/* compile out the decryption-related code */
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 21960a899b6a..206580b312fb 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -114,7 +114,7 @@ static int __f2fs_setup_filename(const struct inode *dir,
 
 	fname->usr_fname = crypt_name->usr_fname;
 	fname->disk_name = crypt_name->disk_name;
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	fname->crypto_buf = crypt_name->crypto_buf;
 #endif
 	if (crypt_name->is_nokey_name) {
@@ -171,7 +171,7 @@ int f2fs_prepare_lookup(struct inode *dir, struct dentry *dentry,
 
 void f2fs_free_filename(struct f2fs_filename *fname)
 {
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	kfree(fname->crypto_buf.name);
 	fname->crypto_buf.name = NULL;
 #endif
@@ -276,7 +276,7 @@ static inline int f2fs_match_name(const struct inode *dir,
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	f.crypto_buf = fname->crypto_buf;
 #endif
 	return fscrypt_match_name(&f, de_name, de_name_len);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 194844029633..fd0da8ce6108 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -26,7 +26,7 @@
 #include <linux/part_stat.h>
 #include <crypto/hash.h>
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 #define USE_FS_ENCRYPTION
 #endif
 #include <linux/fscrypt.h>
@@ -507,7 +507,7 @@ struct f2fs_filename {
 	/* The dirhash of this filename */
 	f2fs_hash_t hash;
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	/*
 	 * For lookups in encrypted directories: either the buffer backing
 	 * disk_name, or a buffer that holds the decoded no-key name.
@@ -4194,7 +4194,7 @@ static inline bool f2fs_encrypted_file(struct inode *inode)
 
 static inline void f2fs_set_encrypted_inode(struct inode *inode)
 {
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	file_set_encrypt(inode);
 	f2fs_set_inode_flags(inode);
 #endif
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3834ead04620..224f80bb7eed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -503,7 +503,7 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 		&F2FS_OPTION(sbi).dummy_enc_policy;
 	int err;
 
-	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION)) {
+	if (!IS_ENABLED(CONFIG_F2FS_FS_ENCRYPTION)) {
 		f2fs_warn(sbi, "test_dummy_encryption option not supported");
 		return -EINVAL;
 	}
@@ -2997,7 +2997,7 @@ static const struct super_operations f2fs_sops = {
 	.remount_fs	= f2fs_remount,
 };
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 static int f2fs_get_context(struct inode *inode, void *ctx, size_t len)
 {
 	return f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
@@ -4157,7 +4157,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #endif
 
 	sb->s_op = &f2fs_sops;
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	sb->s_cop = &f2fs_cryptops;
 #endif
 #ifdef CONFIG_FS_VERITY
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..65e135a84d57 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -848,13 +848,13 @@ F2FS_GENERAL_RO_ATTR(moved_blocks_foreground);
 F2FS_GENERAL_RO_ATTR(avg_vblocks);
 #endif
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption);
 F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2);
 #if IS_ENABLED(CONFIG_UNICODE)
 F2FS_FEATURE_RO_ATTR(encrypted_casefold);
 #endif
-#endif /* CONFIG_FS_ENCRYPTION */
+#endif /* CONFIG_F2FS_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_FEATURE_RO_ATTR(block_zoned);
 F2FS_RO_ATTR(F2FS_SBI, f2fs_sb_info, unusable_blocks_per_sec,
@@ -1000,13 +1000,13 @@ static struct attribute *f2fs_attrs[] = {
 ATTRIBUTE_GROUPS(f2fs);
 
 static struct attribute *f2fs_feat_attrs[] = {
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	ATTR_LIST(encryption),
 	ATTR_LIST(test_dummy_encryption_v2),
 #if IS_ENABLED(CONFIG_UNICODE)
 	ATTR_LIST(encrypted_casefold),
 #endif
-#endif /* CONFIG_FS_ENCRYPTION */
+#endif /* CONFIG_F2FS_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 	ATTR_LIST(block_zoned),
 #endif
-- 
2.37.3

