Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93D3FE0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbhIARCl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbhIARCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46477C061796
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so177914pjz.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJ3grqp4nZ7wGPdZ2nxzn5A4XX3AwCCKjVM0qIJ0vyc=;
        b=wWEOMoDfe19olklaIAMDTbIvFI05QJUtq06S9QYbG1p2oeSP+oGeqCApajuTkhtbKb
         2VN3zSqjIzj6zLlD61dUwaNus9Ij2jxZhrarhqsrADqKKdIZDy9OkkaEMF4Z7WG0qgWp
         G/TZyDguezh3aLmxMW/RhZjtXTYHRn/piYkJKE2FyA2g8moNX88EylhE3SwE7koErNyy
         rSN8Q4PVvlbNtJ9e1YaK40lW5qHpDM7v9F/vw+cuNFFn3QLQj0oph+zDcXM1HREaXvoE
         bLdRI99BSjT4WGq5uvwBRpd7x3ZtUifL5AhgsNfN6P6XDWrL9kwzmHVFkW60ziKdi4P8
         T0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJ3grqp4nZ7wGPdZ2nxzn5A4XX3AwCCKjVM0qIJ0vyc=;
        b=CukrYUt12Xui3uF+Zq8DpbVdk/EPTqrgqjP+ds3D2nLXtdd+gB7n7WAFrjhMfv9eYa
         vLcZsZ6XWjyugpaNL9VtWpTJDIMcTaKU549Ecde8QfZP186j2hWHOg1LWlHOkfCyBduL
         216MwJRGd1/DBcqPWKHAqtJ7B+l93ns68onyTgxu6zGJsAobdPuRlFdcMqc1IBsIpOeO
         p8bhaJgmrBD+EsvW9rHpRhG8ex+y2wJ+kHFlMv5GlF+5ItX2Aun0ai/c2Pe+kaK2lZh2
         MTbGm12brQsPw/Z5NdUKF+g+8JyzmaqhBssmqwSr29U4u0badq5kdBpKp4LM+fUDrG+g
         S36Q==
X-Gm-Message-State: AOAM5323lXrJD48n38YF21gUCY9X0u+0oNOoc8OFSB0A4EymMhD1Vv5h
        MUcNNjrTB0jas70PJSyGmkUbZw==
X-Google-Smtp-Source: ABdhPJxzyPsWEc8sihv7IRV41QqV9wSkEIA8n8Xl6Ph+QxveOHvJGw/Lr6inlZax6Wd4EcATnRE8qQ==
X-Received: by 2002:a17:902:b193:b029:11a:a179:453a with SMTP id s19-20020a170902b193b029011aa179453amr481641plr.69.1630515700706;
        Wed, 01 Sep 2021 10:01:40 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:40 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 10/14] btrfs: add send stream v2 definitions
Date:   Wed,  1 Sep 2021 10:01:05 -0700
Message-Id: <ed4dc1c414a6662831e7443335065cb37dddad91.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This adds the definitions of the new commands for send stream version 2
and their respective attributes: fallocate, FS_IOC_SETFLAGS (a.k.a.
chattr), and encoded writes. It also documents two changes to the send
stream format in v2: the receiver shouldn't assume a maximum command
size, and the DATA attribute is encoded differently to allow for writes
larger than 64k. These will be implemented in subsequent changes, and
then the ioctl will accept the new flags.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            |  2 +-
 fs/btrfs/send.h            | 30 +++++++++++++++++++++++++++++-
 include/uapi/linux/btrfs.h | 13 +++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index afdcbe7844e0..2ec07943f173 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7287,7 +7287,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
-	sctx->send_max_size = BTRFS_SEND_BUF_SIZE;
+	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
 	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index de91488b7cd0..9f4f7b96b1eb 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -12,7 +12,11 @@
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 #define BTRFS_SEND_STREAM_VERSION 1
 
-#define BTRFS_SEND_BUF_SIZE SZ_64K
+/*
+ * In send stream v1, no command is larger than 64k. In send stream v2, no limit
+ * should be assumed.
+ */
+#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
 
 enum btrfs_tlv_type {
 	BTRFS_TLV_U8,
@@ -76,6 +80,13 @@ enum btrfs_send_cmd {
 
 	BTRFS_SEND_C_END,
 	BTRFS_SEND_C_UPDATE_EXTENT,
+
+	/* The following commands were added in send stream v2. */
+
+	BTRFS_SEND_C_FALLOCATE,
+	BTRFS_SEND_C_SETFLAGS,
+	BTRFS_SEND_C_ENCODED_WRITE,
+
 	__BTRFS_SEND_C_MAX,
 };
 #define BTRFS_SEND_C_MAX (__BTRFS_SEND_C_MAX - 1)
@@ -106,6 +117,11 @@ enum {
 	BTRFS_SEND_A_PATH_LINK,
 
 	BTRFS_SEND_A_FILE_OFFSET,
+	/*
+	 * In send stream v2, this attribute is special: it must be the last
+	 * attribute in a command, its header contains only the type, and its
+	 * length is implicitly the remaining length of the command.
+	 */
 	BTRFS_SEND_A_DATA,
 
 	BTRFS_SEND_A_CLONE_UUID,
@@ -114,6 +130,18 @@ enum {
 	BTRFS_SEND_A_CLONE_OFFSET,
 	BTRFS_SEND_A_CLONE_LEN,
 
+	/* The following attributes were added in send stream v2. */
+
+	BTRFS_SEND_A_FALLOCATE_MODE,
+
+	BTRFS_SEND_A_SETFLAGS_FLAGS,
+
+	BTRFS_SEND_A_UNENCODED_FILE_LEN,
+	BTRFS_SEND_A_UNENCODED_LEN,
+	BTRFS_SEND_A_UNENCODED_OFFSET,
+	BTRFS_SEND_A_COMPRESSION,
+	BTRFS_SEND_A_ENCRYPTION,
+
 	__BTRFS_SEND_A_MAX,
 };
 #define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 95da52955894..4f875f355e83 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -771,6 +771,19 @@ struct btrfs_ioctl_received_subvol_args {
  */
 #define BTRFS_SEND_FLAG_OMIT_END_CMD		0x4
 
+/*
+ * Use version 2 of the send stream, which adds new commands and supports larger
+ * writes.
+ */
+#define BTRFS_SEND_FLAG_STREAM_V2		0x8
+
+/*
+ * Send compressed data using the ENCODED_WRITE command instead of decompressing
+ * the data and sending it with the WRITE command. This requires
+ * BTRFS_SEND_FLAG_STREAM_V2.
+ */
+#define BTRFS_SEND_FLAG_COMPRESSED		0x10
+
 #define BTRFS_SEND_FLAG_MASK \
 	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
 	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
-- 
2.33.0

