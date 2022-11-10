Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39676243EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKJONu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKJONm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F736CA3B
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668089565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38ue1jY8VU+EcrxuQImyzYXXhrd8yNBwxAlm16CtPHM=;
        b=dgDKwerAelKEPx6sazjPpI2OoUNN9DHRzrUPR1+OYLpCiyWeGszgM/f6ajKo0CV+RO9S2P
        WcfWe08PWpC4I8m15cJL7K5l4FfaLmjcFPuUJ9eZVs8EcuAw+VdblXupM/G7mMNu15IvsY
        QN55RRb9AImOOO1n3dav/NCA6rwifeo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-MGHg6gf5PcqXN6diWwUnxQ-1; Thu, 10 Nov 2022 09:12:41 -0500
X-MC-Unique: MGHg6gf5PcqXN6diWwUnxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61F40858F17;
        Thu, 10 Nov 2022 14:12:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DF34492B0F;
        Thu, 10 Nov 2022 14:12:40 +0000 (UTC)
From:   Niels de Vos <ndevos@redhat.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>,
        Niels de Vos <ndevos@redhat.com>
Subject: [RFC 2/4] fs: make fscrypt support an ext4 config option
Date:   Thu, 10 Nov 2022 15:12:23 +0100
Message-Id: <20221110141225.2308856-3-ndevos@redhat.com>
In-Reply-To: <20221110141225.2308856-1-ndevos@redhat.com>
References: <20221110141225.2308856-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add CONFIG_EXT4_FS_ENCRYPTION as a config option, which depends on the
global CONFIG_FS_ENCRYPTION setting. This makes it possible to opt-out
of fscrypt for ext4 filesystems, while enabling it for others.

Signed-off-by: Niels de Vos <ndevos@redhat.com>
---
 Documentation/filesystems/fscrypt.rst |  2 +-
 fs/crypto/Kconfig                     |  1 +
 fs/ext4/Kconfig                       | 13 ++++++++++++-
 fs/ext4/Makefile                      |  2 +-
 fs/ext4/ext4.h                        | 10 +++++-----
 fs/ext4/inode.c                       |  6 +++---
 fs/ext4/namei.c                       |  6 +++---
 fs/ext4/super.c                       |  6 +++---
 fs/ext4/sysfs.c                       |  8 ++++----
 9 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 5ba5817c17c2..66e3e2afb4a4 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -574,7 +574,7 @@ FS_IOC_SET_ENCRYPTION_POLICY can fail with the following errors:
 - ``EOPNOTSUPP``: the kernel was not configured with encryption
   support for filesystems, or the filesystem superblock has not
   had encryption enabled on it.  (For example, to use encryption on an
-  ext4 filesystem, CONFIG_FS_ENCRYPTION must be enabled in the
+  ext4 filesystem, CONFIG_EXT4_FS_ENCRYPTION must be enabled in the
   kernel config, and the superblock must have had the "encrypt"
   feature flag enabled using ``tune2fs -O encrypt`` or ``mkfs.ext4 -O
   encrypt``.)
diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index 2d0c8922f635..7e1267deee51 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -6,6 +6,7 @@ config FS_ENCRYPTION
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_SHA256
 	select KEYS
+	imply EXT4_FS_ENCRYPTION
 	help
 	  Enable encryption of files and directories.  This
 	  feature is similar to ecryptfs, but it is more memory
diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 86699c8cab28..3108ec1cd046 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -33,7 +33,6 @@ config EXT4_FS
 	select CRYPTO
 	select CRYPTO_CRC32C
 	select FS_IOMAP
-	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
 	help
 	  This is the next generation of the ext3 filesystem.
 
@@ -92,6 +91,18 @@ config EXT4_FS_SECURITY
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
 
+config EXT4_FS_ENCRYPTION
+	bool "Ext4 with support for filesystem encryption"
+	depends on EXT4_FS
+	depends on FS_ENCRYPTION
+	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
+	help
+	  Enable encryption of files and directories. This feature is similar
+	  to ecryptfs, but it is more memory efficient since it avoids caching
+          the encrypted and decrypted pages in the page cache.
+
+	  If unsure, say N.
+
 config EXT4_DEBUG
 	bool "Ext4 debugging support"
 	depends on EXT4_FS
diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 72206a292676..ed4a8232bccf 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -17,4 +17,4 @@ ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
 ext4-inode-test-objs			+= inode-test.o
 obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
-ext4-$(CONFIG_FS_ENCRYPTION)		+= crypto.o
+ext4-$(CONFIG_EXT4_FS_ENCRYPTION)	+= crypto.o
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 23c2ceaa074d..a38c50ae742e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -41,7 +41,7 @@
 #include <linux/compat.h>
 #endif
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 #define USE_FS_ENCRYPTION
 #endif
 #include <linux/fscrypt.h>
@@ -2495,7 +2495,7 @@ struct ext4_filename {
 	const struct qstr *usr_fname;
 	struct fscrypt_str disk_name;
 	struct dx_hash_info hinfo;
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 	struct fscrypt_str crypto_buf;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
@@ -2741,7 +2741,7 @@ extern int ext4_fname_setup_ci_filename(struct inode *dir,
 #endif
 
 /* ext4 encryption related stuff goes here crypto.c */
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 extern const struct fscrypt_operations ext4_cryptops;
 
 int ext4_fname_setup_filename(struct inode *dir, const struct qstr *iname,
@@ -2754,7 +2754,7 @@ void ext4_fname_free_filename(struct ext4_filename *fname);
 
 int ext4_ioctl_get_encryption_pwsalt(struct file *filp, void __user *arg);
 
-#else /* !CONFIG_FS_ENCRYPTION */
+#else /* !CONFIG_EXT4_FS_ENCRYPTION */
 static inline int ext4_fname_setup_filename(struct inode *dir,
 					    const struct qstr *iname,
 					    int lookup,
@@ -2792,7 +2792,7 @@ static inline int ext4_ioctl_get_encryption_pwsalt(struct file *filp,
 {
 	return -EOPNOTSUPP;
 }
-#endif /* !CONFIG_FS_ENCRYPTION */
+#endif /* !CONFIG_EXT4_FS_ENCRYPTION */
 
 /* dir.c */
 extern int __ext4_check_dir_entry(const char *, unsigned int, struct inode *,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..087dd42ddd42 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1049,7 +1049,7 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 	return ret;
 }
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 				  get_block_t *get_block)
 {
@@ -1215,7 +1215,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	/* In case writeback began while the page was unlocked */
 	wait_for_stable_page(page);
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 	if (ext4_should_dioread_nolock(inode))
 		ret = ext4_block_write_begin(page, pos, len,
 					     ext4_get_block_unwritten);
@@ -2999,7 +2999,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	/* In case writeback began while the page was unlocked */
 	wait_for_stable_page(page);
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 	ret = ext4_block_write_begin(page, pos, len,
 				     ext4_da_get_block_prep);
 #else
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c08c0aba1883..0f61b231ecf6 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -663,7 +663,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 		{
 			if (show_names)
 			{
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 				int len;
 				char *name;
 				struct fscrypt_str fname_crypto_str =
@@ -1475,7 +1475,7 @@ static bool ext4_match(struct inode *parent,
 
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 	f.crypto_buf = fname->crypto_buf;
 #endif
 
@@ -1765,7 +1765,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 	ext4_lblk_t block;
 	int retval;
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 	*res_dir = NULL;
 #endif
 	frame = dx_probe(fname, dir, NULL, frames);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7cdd2138c897..ef3c7c71ecca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2000,7 +2000,7 @@ static int ext4_parse_test_dummy_encryption(const struct fs_parameter *param,
 {
 	int err;
 
-	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION)) {
+	if (!IS_ENABLED(CONFIG_EXT4_FS_ENCRYPTION)) {
 		ext4_msg(NULL, KERN_WARNING,
 			 "test_dummy_encryption option not supported");
 		return -EINVAL;
@@ -2122,7 +2122,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx_set_mount_flag(ctx, EXT4_MF_FS_ABORTED);
 		return 0;
 	case Opt_inlinecrypt:
-#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+#if defined(CONFIG_EXT4_FS_ENCRYPTION) && defined(CONFIG_FS_ENCRYPTION_INLINE_CRYPT)
 		ctx_set_flags(ctx, SB_INLINECRYPT);
 #else
 		ext4_msg(NULL, KERN_ERR, "inline encryption not supported");
@@ -5241,7 +5241,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_op = &ext4_sops;
 	sb->s_export_op = &ext4_export_ops;
 	sb->s_xattr = ext4_xattr_handlers;
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 	sb->s_cop = &ext4_cryptops;
 #endif
 #ifdef CONFIG_FS_VERITY
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index d233c24ea342..148f992dc1a0 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -305,7 +305,7 @@ ATTRIBUTE_GROUPS(ext4);
 EXT4_ATTR_FEATURE(lazy_itable_init);
 EXT4_ATTR_FEATURE(batched_discard);
 EXT4_ATTR_FEATURE(meta_bg_resize);
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 EXT4_ATTR_FEATURE(encryption);
 EXT4_ATTR_FEATURE(test_dummy_encryption_v2);
 #endif
@@ -317,7 +317,7 @@ EXT4_ATTR_FEATURE(verity);
 #endif
 EXT4_ATTR_FEATURE(metadata_csum_seed);
 EXT4_ATTR_FEATURE(fast_commit);
-#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
+#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_EXT4_FS_ENCRYPTION)
 EXT4_ATTR_FEATURE(encrypted_casefold);
 #endif
 
@@ -325,7 +325,7 @@ static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(lazy_itable_init),
 	ATTR_LIST(batched_discard),
 	ATTR_LIST(meta_bg_resize),
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_EXT4_FS_ENCRYPTION
 	ATTR_LIST(encryption),
 	ATTR_LIST(test_dummy_encryption_v2),
 #endif
@@ -337,7 +337,7 @@ static struct attribute *ext4_feat_attrs[] = {
 #endif
 	ATTR_LIST(metadata_csum_seed),
 	ATTR_LIST(fast_commit),
-#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_FS_ENCRYPTION)
+#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_EXT4_FS_ENCRYPTION)
 	ATTR_LIST(encrypted_casefold),
 #endif
 	NULL,
-- 
2.37.3

