Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFC76243E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiKJONi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiKJONe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4286DCD1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668089561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Ux0Kqna/qXUsHD5Gh3Ugbi8sSSVQd7KnYLI13e7kJA=;
        b=QfVpV3iaNHtYMUt/vZSl3M5gWYwBTMPD6myU7Qp43gDKBdJ0umbQkZ1YtpogFqQdW9JoSj
        RVMsTSXp1f/trxZluRfKy1BTslyXxZHouTZu0rrGdldmCIsNzMEpp5bMs/+YQFdB3M/rou
        AaHXKrw0m9I9pUOyw583D4CstQ+je00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-yVjsB3gpPOmMztob50aSCg-1; Thu, 10 Nov 2022 09:12:39 -0500
X-MC-Unique: yVjsB3gpPOmMztob50aSCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2573687A380;
        Thu, 10 Nov 2022 14:12:39 +0000 (UTC)
Received: from localhost (unknown [10.39.208.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4DE120290AE;
        Thu, 10 Nov 2022 14:12:38 +0000 (UTC)
From:   Niels de Vos <ndevos@redhat.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>,
        Niels de Vos <ndevos@redhat.com>
Subject: [RFC 1/4] fscrypt: introduce USE_FS_ENCRYPTION
Date:   Thu, 10 Nov 2022 15:12:22 +0100
Message-Id: <20221110141225.2308856-2-ndevos@redhat.com>
In-Reply-To: <20221110141225.2308856-1-ndevos@redhat.com>
References: <20221110141225.2308856-1-ndevos@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new USE_FS_ENCRYPTION define is added so that filesystems can
opt-out of supporting fscrypt, while other filesystems have fscrypt
enabled.

Signed-off-by: Niels de Vos <ndevos@redhat.com>
---
 fs/crypto/fscrypt_private.h | 2 ++
 fs/ext4/ext4.h              | 4 ++++
 fs/f2fs/f2fs.h              | 4 ++++
 fs/ubifs/ubifs.h            | 3 +++
 include/linux/fscrypt.h     | 6 +++---
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index d5f68a0c5d15..f8dc3aab80b3 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -11,6 +11,8 @@
 #ifndef _FSCRYPT_PRIVATE_H
 #define _FSCRYPT_PRIVATE_H
 
+#define USE_FS_ENCRYPTION
+
 #include <linux/fscrypt.h>
 #include <linux/siphash.h>
 #include <crypto/hash.h>
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8d5453852f98..23c2ceaa074d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -41,7 +41,11 @@
 #include <linux/compat.h>
 #endif
 
+#ifdef CONFIG_FS_ENCRYPTION
+#define USE_FS_ENCRYPTION
+#endif
 #include <linux/fscrypt.h>
+
 #include <linux/fsverity.h>
 
 #include <linux/compiler.h>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6355a5683b7..194844029633 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -26,7 +26,11 @@
 #include <linux/part_stat.h>
 #include <crypto/hash.h>
 
+#ifdef CONFIG_FS_ENCRYPTION
+#define USE_FS_ENCRYPTION
+#endif
 #include <linux/fscrypt.h>
+
 #include <linux/fsverity.h>
 
 struct pagevec;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 478bbbb5382f..3ef0e9ef5015 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -33,6 +33,9 @@
 #include <crypto/hash.h>
 #include <crypto/algapi.h>
 
+#ifdef CONFIG_FS_ENCRYPTION
+#define USE_FS_ENCRYPTION
+#endif
 #include <linux/fscrypt.h>
 
 #include "ubifs-media.h"
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 4f5f8a651213..403a686619f8 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -57,7 +57,7 @@ struct fscrypt_name {
 /* Maximum value for the third parameter of fscrypt_operations.set_context(). */
 #define FSCRYPT_SET_CONTEXT_MAX_SIZE	40
 
-#ifdef CONFIG_FS_ENCRYPTION
+#if defined(CONFIG_FS_ENCRYPTION) && defined(USE_FS_ENCRYPTION)
 
 /*
  * If set, the fscrypt bounce page pool won't be allocated (unless another
@@ -379,7 +379,7 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 {
 	sb->s_cop = s_cop;
 }
-#else  /* !CONFIG_FS_ENCRYPTION */
+#else  /* !CONFIG_FS_ENCRYPTION || !USE_FS_ENCRYPTION */
 
 static inline struct fscrypt_info *fscrypt_get_info(const struct inode *inode)
 {
@@ -743,7 +743,7 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 {
 }
 
-#endif	/* !CONFIG_FS_ENCRYPTION */
+#endif	/* !CONFIG_FS_ENCRYPTION || !USE_FS_ENCRYPTION */
 
 /* inline_crypt.c */
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
-- 
2.37.3

