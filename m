Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3165A33DDEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbhCPTp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbhCPTo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:44:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2713C061762
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id o10so23320324pgg.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOL5MgHRlLkP/DtxUyn1kne09oPNy8G9adsPGvwRfpY=;
        b=u7zJ2DDu0IRC0GKiWd5Mp/C7dS+BO5LdEp9g4tY5aRJoLwtLS2wrMC2Tu2En6X6fvs
         r5Mm/ZhMkrZb41EayJ9aTB9Mj85glO9gyvc5Ny+G6aju4maL091zPG23qH5ev07HAL4L
         nzvgmQGA6iluEFbLMpu1cBTJfqRju/MP5ZUC0fR4maA2YxY3YNO6UOfPjIjTydoN0bj0
         7MZZK1SvBPpvPPSA5hoBRkB55PcGpYnQ0VTFSD/N84X5Ci/Hy0RxRXVMomWdM+EzN1oX
         HroDq9ZavMGs2S7GAZydPF0xxat4wbK9lLJCjvLvGHsAv2yI0fXIIMgwm/A7SEz/yhcQ
         Q3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOL5MgHRlLkP/DtxUyn1kne09oPNy8G9adsPGvwRfpY=;
        b=oxBj6+g0sQx9e8+5/NPgYCILgB9l/l8CxsyWBPL5EGuj4eS7sSZIKFziPcTPEcHSa+
         uanvMpAkwWTCSAR51Cp846zP+GbKSycA+OXoI6gFURd41yzs5tOrFrjD+rBefZ1Nif5X
         ADBNJ+44E2tzOoNmPXQwzRYS4rEvrOglsMQxIO2weoys2cm5ZXaUBzsZV+lUN5XV/DUQ
         a5aHCtcAvYb3sZkPSAgziWzwwv9FIooeciUJbH3vNAdcqQmuVAUMkODeT1CR+tSJ2rKS
         gjQjzJqCgYMjDrD8uWa9GuW8NM0sLT0Oq3UzKkJR1KlkdzkrTUn6bvngVYM6UVkUUtRk
         uZYg==
X-Gm-Message-State: AOAM530/CuofyvwjecljNND5vGWW125PqAz4nJwGvrTpuPdJA1qcKKtd
        eTJUVbHi0VQ7hp+UoGAEmw9EJg==
X-Google-Smtp-Source: ABdhPJxbjEM/9hHOs9YMix5gmrnFG1kOu5qsBdvP2JMlN4+0ZzbP9lSuuPYdozPklEg4AKHtL/dL1Q==
X-Received: by 2002:a63:494b:: with SMTP id y11mr1098136pgk.99.1615923865320;
        Tue, 16 Mar 2021 12:44:25 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:24 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 02/11] btrfs-progs: receive: dynamically allocate sctx->read_buf
Date:   Tue, 16 Mar 2021 12:43:52 -0700
Message-Id: <8afac86324d1499f46f44f4487b7a1bd63429b8c.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
2.30.2

