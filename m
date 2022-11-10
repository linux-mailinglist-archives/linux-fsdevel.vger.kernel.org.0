Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD56243FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiKJOOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiKJOO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D856DCE1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668089568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJWwfh7LX7eiz2P4HljirE5EYpLzzlQouMCEDG93yHg=;
        b=AcvChltQQRFv1+9xCg7Vb21cMJfuoty9ePcMulZ4l2xZNs30OrnE4p2uAJTfQHDCvTbRnI
        as1lboat7IH6UR7VlT7JXOw1IzTm6MyLJBac+OFySKIKbQpaMTbXAo3b3KHvpxjmLlhsi7
        T7qigaOl0HrpU8EFXHGHLxLzVveuZVQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-SHVtPAOxNNeXXb0eEdHBDw-1; Thu, 10 Nov 2022 09:12:45 -0500
X-MC-Unique: SHVtPAOxNNeXXb0eEdHBDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF4FB2999B44;
        Thu, 10 Nov 2022 14:12:44 +0000 (UTC)
Received: from localhost (unknown [10.39.208.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAE10112131B;
        Thu, 10 Nov 2022 14:12:44 +0000 (UTC)
From:   Niels de Vos <ndevos@redhat.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>,
        Niels de Vos <ndevos@redhat.com>
Subject: [RFC 4/4] fs: make fscrypt support a UBIFS config option
Date:   Thu, 10 Nov 2022 15:12:25 +0100
Message-Id: <20221110141225.2308856-5-ndevos@redhat.com>
In-Reply-To: <20221110141225.2308856-1-ndevos@redhat.com>
References: <20221110141225.2308856-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add CONFIG_UBIFS_FS_ENCRYPTION as a config option, which depends on the
global CONFIG_FS_ENCRYPTION setting. This makes it possible to opt-out
of fscrypt for UBIFS, while enabling it for others.

Signed-off-by: Niels de Vos <ndevos@redhat.com>
---
 fs/crypto/Kconfig |  1 +
 fs/ubifs/Kconfig  | 14 ++++++++++++--
 fs/ubifs/Makefile |  2 +-
 fs/ubifs/sb.c     |  4 ++--
 fs/ubifs/ubifs.h  |  6 +++---
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index a809847e820d..2aef21786449 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -8,6 +8,7 @@ config FS_ENCRYPTION
 	select KEYS
 	imply EXT4_FS_ENCRYPTION
 	imply F2FS_FS_ENCRYPTION
+	imply UBIFS_FS_ENCRYPTION
 	help
 	  Enable encryption of files and directories.  This
 	  feature is similar to ecryptfs, but it is more memory
diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
index 45d3d207fb99..886056777d68 100644
--- a/fs/ubifs/Kconfig
+++ b/fs/ubifs/Kconfig
@@ -11,8 +11,6 @@ config UBIFS_FS
 	select CRYPTO_DEFLATE if UBIFS_FS_ZLIB
 	select CRYPTO_ZSTD if UBIFS_FS_ZSTD
 	select CRYPTO_HASH_INFO
-	select UBIFS_FS_XATTR if FS_ENCRYPTION
-	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
 	depends on MTD_UBI
 	help
 	  UBIFS is a file system for flash devices which works on top of UBI.
@@ -98,4 +96,16 @@ config UBIFS_FS_AUTHENTICATION
 	  sha256, these are not selected automatically since there are many
 	  different options.
 
+config UBIFS_FS_ENCRYPTION
+	bool "UBIFS with support for filesystem encryption"
+	depends on FS_ENCRYPTION
+	select UBIFS_FS_XATTR
+	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
+	help
+	  Enable encryption of files and directories. This feature is similar
+	  to ecryptfs, but it is more memory efficient since it avoids caching
+          the encrypted and decrypted pages in the page cache.
+
+	  If unsure, say N.
+
 endif # UBIFS_FS
diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
index 314c80b24a76..df49a573f8bd 100644
--- a/fs/ubifs/Makefile
+++ b/fs/ubifs/Makefile
@@ -6,6 +6,6 @@ ubifs-y += tnc.o master.o scan.o replay.o log.o commit.o gc.o orphan.o
 ubifs-y += budget.o find.o tnc_commit.o compress.o lpt.o lprops.o
 ubifs-y += recovery.o ioctl.o lpt_commit.o tnc_misc.o debug.o
 ubifs-y += misc.o sysfs.o
-ubifs-$(CONFIG_FS_ENCRYPTION) += crypto.o
+ubifs-$(CONFIG_UBIFS_FS_ENCRYPTION) += crypto.o
 ubifs-$(CONFIG_UBIFS_FS_XATTR) += xattr.o
 ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index e7693b94e5b5..1eb2a9be1177 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -746,7 +746,7 @@ int ubifs_read_superblock(struct ubifs_info *c)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION) && c->encrypted) {
+	if (!IS_ENABLED(CONFIG_UBIFS_FS_ENCRYPTION) && c->encrypted) {
 		ubifs_err(c, "file system contains encrypted files but UBIFS"
 			     " was built without crypto support.");
 		err = -EINVAL;
@@ -932,7 +932,7 @@ int ubifs_enable_encryption(struct ubifs_info *c)
 	int err;
 	struct ubifs_sb_node *sup = c->sup_node;
 
-	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
+	if (!IS_ENABLED(CONFIG_UBIFS_FS_ENCRYPTION))
 		return -EOPNOTSUPP;
 
 	if (c->encrypted)
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 3ef0e9ef5015..e20f3284f504 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -33,7 +33,7 @@
 #include <crypto/hash.h>
 #include <crypto/algapi.h>
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_UBIFS_FS_ENCRYPTION
 #define USE_FS_ENCRYPTION
 #endif
 #include <linux/fscrypt.h>
@@ -134,7 +134,7 @@
  */
 #define WORST_COMPR_FACTOR 2
 
-#ifdef CONFIG_FS_ENCRYPTION
+#ifdef CONFIG_UBIFS_FS_ENCRYPTION
 #define UBIFS_CIPHER_BLOCK_SIZE FSCRYPT_CONTENTS_ALIGNMENT
 #else
 #define UBIFS_CIPHER_BLOCK_SIZE 0
@@ -2114,7 +2114,7 @@ void ubifs_sysfs_unregister(struct ubifs_info *c);
 #include "misc.h"
 #include "key.h"
 
-#ifndef CONFIG_FS_ENCRYPTION
+#ifndef CONFIG_UBIFS_FS_ENCRYPTION
 static inline int ubifs_encrypt(const struct inode *inode,
 				struct ubifs_data_node *dn,
 				unsigned int in_len, unsigned int *out_len,
-- 
2.37.3

