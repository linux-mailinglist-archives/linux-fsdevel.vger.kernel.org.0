Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC232B84B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgKRTTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgKRTTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:09 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C38C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:09 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id i8so2029828pfk.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPW+Dna2wRVVrHRfE5h6s7X411Swfso/95bBBe/E3W4=;
        b=TvyNk7QzgpB5yJSoGrRZyBM+BmM6MmaPBeXY299u5a8Mh7WaxRNh2OGWJ3Tv7G9UHR
         fNUkvb3o5FbhTBrcRzcu2vAolfe8OTgh+wxhYHppJyE8DE97mM5bUxTUca0W+ehVYkV4
         yRSJP+qzJnkaYY/x7EKcuYeEu4HatNT1EyNY1PaF5gz/T0iy22vkiRUYkaNtmILkge5t
         AixXUekNT00Kn24cj1AhQ4wKN96Ey4l9f1Hs1UZpS7li3JRNououXp4ZWGfPHDU453oB
         h+pzRJ2w7lGCYpV7E8CRuU8BCpyDQc3N2A295lWiqHro8Tcfr6ccIxgznNWDJnS1Ofgz
         cmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPW+Dna2wRVVrHRfE5h6s7X411Swfso/95bBBe/E3W4=;
        b=cWcF8EwnlOycJ13EiYqxq1cKzD2ZR5V8w3pibe5bZ8xZtQFG49paJlIMGSn6fdP3yX
         dVyC7AbbivKVNdKdIwdGtzRK0AvDvVw/V0/Vfe5UeHYlLYuuyNpyNAnN31zK7NdmfpA6
         URpyd911D9JQGD+LcQ4ntf0T7r9CHy1H6nCpy/YirX2077n6ydmmCeB3r6w7kKRt6njN
         Gz6LSZDD9ROykhllCHmUGS27O3SRU0cfyS5+4t3CQvpWVnSsGErip5ewtrtodWUnYsf7
         7QvrIgDl4pz8gjnJEtFL7xlu1Il+LgEpycTBtiv4ZrXS7sMU1g7bnMbs/Pk9zcqqjYlQ
         g3Qg==
X-Gm-Message-State: AOAM533f5WCFZAz1oMzlhgbgRsCl7fpnGxqGd4+PhtSuzAQEbymDw6x1
        oqqFfCJG39GqGR5SVy0wDRsNPx2sToSkSw==
X-Google-Smtp-Source: ABdhPJwmZL45UiAH7bJUkojbwqQ/1KAcPRf9x0k4WefT4RTlv7Z6ssxk4zGch9SrbClsJ1FTsUgW2g==
X-Received: by 2002:a63:3c10:: with SMTP id j16mr9524663pga.140.1605727148644;
        Wed, 18 Nov 2020 11:19:08 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:07 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/5] btrfs: add send stream v2 definitions
Date:   Wed, 18 Nov 2020 11:18:43 -0800
Message-Id: <e94e635352ae4ef5c20d8e0a09ddfacc7d9322ad.1605723600.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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
index d719a2755a40..3cd090c3ffda 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7255,7 +7255,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
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
2.29.2

