Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F224CF9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgHUHko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgHUHk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4235EC061388
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so627629pgf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WFgjJ3rZW2t7bP/7ZGExcYanOQgvJvNl08xr/OUhp8=;
        b=dSg2e+H2NFSciBdWMN+2zt/ZVTY+R/pe0F+3RGzZK41krLC+OjGma5ZjnKJyfc3nZE
         Ztr9zGKRsIn8jIb4exSJiIiZkHITbW36ekN401fQengv4nO2CrTBv8NrN411ivDKZihR
         om7XiqZXRJU4UFpspAWhOFyjWYtvoPl+RShLOe9ucOOJ7ZVFZrgN9FKYUWCCzX3otcu3
         irpkJIWAh0ZPgkR087E9sjjlLvKX5HQfYRMNmUOY/R+PWjxM4o2cvkdOIIY7tn76llsL
         18Pm6SlITDGkWEF1oMdpXTL3YR5kLMJxh0/++yrWGvcJGmWNxSyFNqWQVnJPUSVsynFO
         yHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WFgjJ3rZW2t7bP/7ZGExcYanOQgvJvNl08xr/OUhp8=;
        b=k+qpRFLyglEFu53LfkG1Ev5G6kppPeHt2Jp9Vlgs+RaERzxVDU6sOgE356BcJW81HI
         9m/If0TJbWnbLPFpPKdItLJXPL4xo7FuK7vG2PzlAeoYt4EBkbTgqZ0gJWlJoqb/GYoa
         6gDJr2EGhYyMCSC/K4YbGga+jAqhy8mvIaFCdQQSGVGVYggkHyAT6LizcLFUfiAs2oyG
         n3jNjiNM4C9/uQNnCKCHbvkRRLlm1jnUzICHuBfgUdLf9LnSLRf8SpMIlheaFU81IX7k
         yzTLeiMepKoLye5JvhITuGhFgm0gEj779miqFgS0w/2EGDjdHudKBMhak2CbJk0316+B
         8LIQ==
X-Gm-Message-State: AOAM532V0SppyixcNVRe3jnly/Vi4qZzWhoPqqk8vn+lUX1PCwdgu6PJ
        NBRMAKg9wEjCzIACCvAhKFTTGQ==
X-Google-Smtp-Source: ABdhPJxKlmIXI+kh+VsqvVebfzvPnWqxe1vtPxCacXLgvBfG6sEyFX0MiDh0Ot2V48zgw7hzbioy1w==
X-Received: by 2002:a63:5559:: with SMTP id f25mr1407868pgm.369.1597995625667;
        Fri, 21 Aug 2020 00:40:25 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:23 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] btrfs: add send stream v2 definitions
Date:   Fri, 21 Aug 2020 00:39:55 -0700
Message-Id: <c3c83c0889781ab3e44bb02373b86979b4426bc8.1597994106.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c            |  2 +-
 fs/btrfs/send.h            | 30 +++++++++++++++++++++++++++++-
 include/uapi/linux/btrfs.h | 13 +++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 37ce21361782..e25c3391fc02 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7136,7 +7136,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
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
index 2c39d15a2beb..51e69f28d22d 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -769,6 +769,19 @@ struct btrfs_ioctl_received_subvol_args {
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
2.28.0

