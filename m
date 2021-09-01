Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18C03FE0BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbhIARCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbhIARCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B65C0617A8
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so157452pjx.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGGi1GmoDHZTQUQdqRAQ8UwYqg4vSEtlDdhSaXm/Sio=;
        b=e3OoA8JMxqdBvmHoau03/McSGpVmQoVTeNc41DBK3aKx9CA93NZOkbHSS/DuuMl1XG
         8/TqcNa136hg41g0bq7g8z4bdYcptxXjitXztkmjkg/u9BmdlZnPSbkckYHybB+G4HZp
         qhUBei6K+O4oLDnEhDMKJ2EmXoUlmW6jjuywyzWl3HlFVzN3Kk3U7/8XrSNA8a7h4u6b
         4vGCP4UKM2vtX3ti61V5mIPSCMQcq/Z0uqkwqUSlNpaDAQJvwQ3nHKYDjy65Xj2o4/7d
         Wp3bYnjmiWC9oSJ+X83S3g7uWFs94CYSVKWeQyBVqBgqdi0a0KzUU562PwSH0QzYg+zT
         DPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGGi1GmoDHZTQUQdqRAQ8UwYqg4vSEtlDdhSaXm/Sio=;
        b=r2EeKtA6VXuFtlpLRocmBHW0OGSXnRNwWtcs+gy1nuSmU2Fq00GIiJmp3TXRWakGRq
         wUAwsR3thPp/ECp1+8QDHQONeCQmP7fF3V98DGhFAqHNC+ZwS45rfCah197EB8ZMEB4P
         Ccm9rCgHB0k4iQhAHXB1tdvqbIjo29u3fVqp+pLtwPB2dOcBfdBzY+7vbNO7IsRabdvN
         vq0m1ituiMSL0j8nbhkw80f5tQWK28cirISX62iLxb0EwCEKjIjUi2Z/ADs/7fXmCl3k
         ODntoXToLjkEchvvN2pnxARZyhFCBm6ZLGwD+RZmRz53UOMHSYJdvjnvXnTlq8Qi3r9u
         EKlw==
X-Gm-Message-State: AOAM532oPcbk9+/2bMz+LGOWazhUWGOoWn/gQB47PUcMFAJ6EHoVKWUX
        xj84keei56IvG7l3Lre6rNWZVw==
X-Google-Smtp-Source: ABdhPJyscfKw9koryfIQIau+qFdJdNPuokEbpEeJzQqGnsIkXJ2S0qYxpOPu2LiXtGmiDo92rSHblQ==
X-Received: by 2002:a17:90b:384a:: with SMTP id nl10mr371330pjb.65.1630515712642;
        Wed, 01 Sep 2021 10:01:52 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:52 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 02/10] btrfs-progs: receive: dynamically allocate sctx->read_buf
Date:   Wed,  1 Sep 2021 10:01:11 -0700
Message-Id: <01efd9dd3a70c1a765549b16d6aa5c4cec8a67e4.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
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
2.33.0

