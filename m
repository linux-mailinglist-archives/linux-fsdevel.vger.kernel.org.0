Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF73300E4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbhAVUy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730941AbhAVUwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:52:22 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15460C0698C6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:23 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 30so4615757pgr.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuS+bqDRqimJQtw+CUfBlHJuFVwwMnHAqeTtllhBo5o=;
        b=F05HqoGWac6z+Vge5IUSRo/6x7Z5kNzAEMl13kxlj1HFCsDymJpLiS1dJVOj/4ZVyS
         Ym5h+7gvpIu1uwrvzL3bqF0CXsnfpP0Bm3+5SyIP/n9HcqznrofQty8mia38pkzgyltL
         wv3QU/6Cm9xKRs4n1y8FR/rPHMZn2RRYpo0qhXNIA47H2A1v8ETYsjvtaalqZtgafmvm
         k77oFG6XdibFdhUKIAYIAW2LhK8zIl6lfsWJjToTtnDM1UMOYokRhuCExnhcSSPTN4pv
         tFWq0luCAHjzwD99E9+02lgnXLMpxZYWceHTKAkp/PZRhEbw/0oI8BF+BSjxzO8YQ37C
         4Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuS+bqDRqimJQtw+CUfBlHJuFVwwMnHAqeTtllhBo5o=;
        b=aI4Xr7eIk7iqsoiPeQ7SasLeJ6tVxID0Z3xxY5fx66/EcNi5TI2bUecJbF1zNuM9Fj
         aBaX1q3Sl2kxfQax3M7J1C2puBh9WIQHWhPrFbNEzb80Tbr9f3Wsi5irvwf1ASzNCYxU
         4ovzKHPNMrjqb0gs/RpS2Bzt0OFL+tddKeTdvs2awE+w1vJsXh2UlTz9bHyaG0vHDoYv
         3behrFoAAi7U0TVHrOFlQ8xlJeVCPuDveOs/sDZKwGEw2ipW0pXVBBI+GMPtQix3hEn2
         rixWgvn/kX81bDAU4pY6StgzrcTwLB55HFssMuHyuEWsEP100EV0QakeZ6BfSol7tGF0
         wGKw==
X-Gm-Message-State: AOAM531Qq7Ji+n77dUw60ob+ACRr4Edzblpfnm4mDhk8F0ZbDOYmwFD0
        P7GkqFDxxKdDQGAAjq8OxQ0vxg==
X-Google-Smtp-Source: ABdhPJzxNSBEXm8T/NSdQpk2RIiNIamZcCB8nMx4SGqTY+bBicDYXpfL4gXObpa2JPuOXhCGhyr2wA==
X-Received: by 2002:a62:2bd4:0:b029:1ae:4d9f:60da with SMTP id r203-20020a622bd40000b02901ae4d9f60damr6793220pfr.20.1611348502594;
        Fri, 22 Jan 2021 12:48:22 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:21 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 02/11] btrfs-progs: receive: dynamically allocate sctx->read_buf
Date:   Fri, 22 Jan 2021 12:47:45 -0800
Message-Id: <1bb29f037059aa09b4d61349f59d862cbfb44a1b.1611347859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <boris@bur.io>

In send stream v2, write commands can now be an arbitrary size. For that
reason, we can no longer allocate a fixed array in sctx for read_cmd.
Instead, read_cmd dynamically allocates sctx->read_buf. To avoid
needless reallocations, we reuse read_buf between read_cmd calls by also
keeping track of the size of the allocated buffer in sctx->read_buf_sz.

We do the first allocation of the old default size at the start of
processing the stream, and we only reallocate if we encounter a command
that needs a larger buffer.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 55 ++++++++++++++++++++++++++++----------------
 send.h               |  2 +-
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index cd5aa311..3d3585c3 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -35,11 +35,11 @@ struct btrfs_send_attribute {
 };
 
 struct btrfs_send_stream {
-	char read_buf[BTRFS_SEND_BUF_SIZE];
+	char *read_buf;
+	size_t read_buf_sz;
 	int fd;
 
 	int cmd;
-	struct btrfs_cmd_header *cmd_hdr;
 	struct btrfs_send_attribute cmd_attrs[BTRFS_SEND_A_MAX + 1];
 	u32 version;
 
@@ -111,11 +111,12 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 	u32 pos;
 	u32 crc;
 	u32 crc2;
+	struct btrfs_cmd_header *cmd_hdr;
+	size_t buf_len;
 
 	memset(sctx->cmd_attrs, 0, sizeof(sctx->cmd_attrs));
 
-	ASSERT(sizeof(*sctx->cmd_hdr) <= sizeof(sctx->read_buf));
-	ret = read_buf(sctx, sctx->read_buf, sizeof(*sctx->cmd_hdr));
+	ret = read_buf(sctx, sctx->read_buf, sizeof(*cmd_hdr));
 	if (ret < 0)
 		goto out;
 	if (ret) {
@@ -124,18 +125,22 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		goto out;
 	}
 
-	sctx->cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
-	cmd = le16_to_cpu(sctx->cmd_hdr->cmd);
-	cmd_len = le32_to_cpu(sctx->cmd_hdr->len);
-
-	if (cmd_len + sizeof(*sctx->cmd_hdr) >= sizeof(sctx->read_buf)) {
-		ret = -EINVAL;
-		error("command length %u too big for buffer %zu",
-				cmd_len, sizeof(sctx->read_buf));
-		goto out;
+	cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
+	cmd_len = le32_to_cpu(cmd_hdr->len);
+	cmd = le16_to_cpu(cmd_hdr->cmd);
+	buf_len = sizeof(*cmd_hdr) + cmd_len;
+	if (sctx->read_buf_sz < buf_len) {
+		sctx->read_buf = realloc(sctx->read_buf, buf_len);
+		if (!sctx->read_buf) {
+			ret = -ENOMEM;
+			error("failed to reallocate read buffer for cmd");
+			goto out;
+		}
+		sctx->read_buf_sz = buf_len;
+		/* We need to reset cmd_hdr after realloc of sctx->read_buf */
+		cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
 	}
-
-	data = sctx->read_buf + sizeof(*sctx->cmd_hdr);
+	data = sctx->read_buf + sizeof(*cmd_hdr);
 	ret = read_buf(sctx, data, cmd_len);
 	if (ret < 0)
 		goto out;
@@ -145,11 +150,12 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		goto out;
 	}
 
-	crc = le32_to_cpu(sctx->cmd_hdr->crc);
-	sctx->cmd_hdr->crc = 0;
+	crc = le32_to_cpu(cmd_hdr->crc);
+	/* in send, crc is computed with header crc = 0, replicate that */
+	cmd_hdr->crc = 0;
 
 	crc2 = crc32c(0, (unsigned char*)sctx->read_buf,
-			sizeof(*sctx->cmd_hdr) + cmd_len);
+			sizeof(*cmd_hdr) + cmd_len);
 
 	if (crc != crc2) {
 		ret = -EINVAL;
@@ -524,19 +530,28 @@ int btrfs_read_and_process_send_stream(int fd,
 		goto out;
 	}
 
+	sctx.read_buf = malloc(BTRFS_SEND_BUF_SIZE_V1);
+	if (!sctx.read_buf) {
+		ret = -ENOMEM;
+		error("unable to allocate send stream read buffer");
+		goto out;
+	}
+	sctx.read_buf_sz = BTRFS_SEND_BUF_SIZE_V1;
+
 	while (1) {
 		ret = read_and_process_cmd(&sctx);
 		if (ret < 0) {
 			last_err = ret;
 			errors++;
 			if (max_errors > 0 && errors >= max_errors)
-				goto out;
+				break;
 		} else if (ret > 0) {
 			if (!honor_end_cmd)
 				ret = 0;
-			goto out;
+			break;
 		}
 	}
+	free(sctx.read_buf);
 
 out:
 	if (last_err && !ret)
diff --git a/send.h b/send.h
index 8dd865ec..228928a0 100644
--- a/send.h
+++ b/send.h
@@ -33,7 +33,7 @@ extern "C" {
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 #define BTRFS_SEND_STREAM_VERSION 1
 
-#define BTRFS_SEND_BUF_SIZE SZ_64K
+#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
 #define BTRFS_SEND_READ_SIZE (1024 * 48)
 
 enum btrfs_tlv_type {
-- 
2.30.0

