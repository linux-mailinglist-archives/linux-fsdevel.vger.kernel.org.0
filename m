Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D30933DDE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbhCPTo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbhCPToW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:44:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD18DC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:21 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id n9so22352228pgi.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODJiWJ3Wy16MBWPH/OnBJ1HXlU+a5X9xcdG8fXTHrSk=;
        b=bRyG+Au/wiDppJgxVCZE8FFpwYZeBYvle5OITPi4RlDm4dUNjZs0r3Nb6YAnz48b5n
         a7GQezbZX4xntcsJZvf9+8vyD1lT5iqVVDwbYZEF/gKbzBVbDyWMJUsDHnHTDvd97lnk
         9uQ7OGqixQg7K6Gc1k0URquk/f3o9WBn315PmGg34zTbJuYqenZ6HergJBkJ7O1cWl8w
         ga4ygVz2FgAl3SeHL70OeozVsQZcU5BtDle1iUKX1bTRSSqywpupGhhBDzGCAoPzUeDh
         /HswDRP3kp3RfN7QhJYw9i3R4ZkuVxF3QqZTx0cZdvRIIRIO9uQkA6Uh23AToc3G5t9d
         OxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODJiWJ3Wy16MBWPH/OnBJ1HXlU+a5X9xcdG8fXTHrSk=;
        b=Sq4es+3mAU4fK3L7poYxAaJ00fDbO5NO1EL1YGPKXwArhPIdtF0BIyX77PY2R3gm+y
         9OZZym3gvOFDIsvcOrUUNvBwDXJ0cmVGR914LROEmjF+lDyNZO8fiaMut/VBQrfmkDLF
         T2Kb9o+v0utvliAgOK/velYBMsf5KAN4E+4HhOFB9Z7xzEZcDC7XFP6+KwKkLsSRx3jk
         Cr+xv9+kSboJJDK+LlafP6iIsqbkw+aJllvivdP8TfSGHWYZ9XKsFSCFXeOC+uZyCQWu
         blzX3pUc3ejH4bbuXpQa9GHtu/TBVPlSLCYu42yuaeGepgQMH7mveSwHDzChhbEJmxlM
         yTfQ==
X-Gm-Message-State: AOAM532KMatNhjRglERG8lqkV/L0Og2lT8PBANI8PK6IkBNCCyWG2NLo
        AQRxE16ES7H5d5DYj7SDyWiOXTlHHz5Jgg==
X-Google-Smtp-Source: ABdhPJxzP5x/8N+oUauITZua+wsFjt5mGiPThczxV77lBUq+Z7Wc2STAd5hZZJC241bl90Xhq/UuVw==
X-Received: by 2002:a63:4f59:: with SMTP id p25mr1104170pgl.335.1615923861406;
        Tue, 16 Mar 2021 12:44:21 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:20 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 1/5] btrfs: add send stream v2 definitions
Date:   Tue, 16 Mar 2021 12:43:50 -0700
Message-Id: <1bbc7fbf0efb06a0d91cb029c1a5ab5f4525c71c.1615922753.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
index 3bcbf2bcb869..d07570588a16 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7267,7 +7267,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
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
index 5df73001aad4..93aa0932234e 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -770,6 +770,19 @@ struct btrfs_ioctl_received_subvol_args {
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
2.30.2

