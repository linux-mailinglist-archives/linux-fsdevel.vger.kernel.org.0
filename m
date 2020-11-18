Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBFD2B84BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKRTTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgKRTTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:18 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4B0C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:18 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t21so1870943pgl.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zsxWF6lVDz+7AA3ZWvsvy5Wo7+pjmYoohRaGzOoct0=;
        b=fMZQHOtxQhH+Wm6oQayF/Jis6x8CMcwPmGIwI8unHPGZdxEVNgU4wmCUbheZf7k+Qs
         tVHAWpCOqeqNRIUY+MwW4e2wg1vf+nLmG2elJL6T6gogP69u/KqwDN7HJYoUV3dKcXPk
         ZLeWJFBHkup16/cVKeUktQS+XbU0FguStreRV7/+pBwNMuoQW2RivtqCmakePUfS3mP9
         omigH4NPnNBh9Ndb7T8MQXbTkTBTvNfsJxvAWl0+D343EQBGRsZymWMB5i8s2mvmvM12
         nAJPJhNm9wTZoRkVAepPHbjTUklp+Byk4ossFZRVftpgNzqOyp2xzHNXh8SkxEHb5OvM
         BZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zsxWF6lVDz+7AA3ZWvsvy5Wo7+pjmYoohRaGzOoct0=;
        b=ngNubyGDN7UDfzDKwT3YYGqLDPhMhSFXMmmHDyp2eytYGtR5tzjsJRYhY/9TNOOrYt
         p1XdjxGbE6PxU2o8lIq5yIt+QoAeEAvPxNfBP7mqL0ZPXVYZ/cyy0cqia8/Jj2ylYt7Z
         J01JkxWqWKRusv70+Wx+2Q8GX+mkwjZIjC3/SnwM1/dxW33Xw/iDD3ktEEbOpIc+p+U6
         RGo9AYndsYzNAORP/meo9kmHUI5Op5hsp3KS3plioO2cQQuEKRVQ+DAE7LvpheBccNNt
         CglZuELA0jZ0M7dXO22iMSMapbaud35xekOtWUKrzugAb5hH4dwHbppiXuwSRwLedJht
         4ELg==
X-Gm-Message-State: AOAM533OwDWQ27FeE2fPGYKqOTuUddHGwIPyVTdVUDhD3af/7wHtTGIY
        6pKx5vTs4ZHlnL8mOeI7wudi3w==
X-Google-Smtp-Source: ABdhPJzQACKgpEvQnGNJzbC9MgeDK/K2QmXPVpbgyKh4g6Zq+LKBixy7Ekh0P/zAGAtJVkLPSRDxFw==
X-Received: by 2002:a17:90a:154a:: with SMTP id y10mr535452pja.6.1605727158044;
        Wed, 18 Nov 2020 11:19:18 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:17 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/13] btrfs-progs: receive: dynamically allocate sctx->read_buf
Date:   Wed, 18 Nov 2020 11:18:47 -0800
Message-Id: <0621eb3c44c2057b35ceb1ce5c1270a4c9c8edc5.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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
index 3bd21d3f..51a6a94a 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -36,10 +36,10 @@ struct btrfs_send_attribute {
 
 struct btrfs_send_stream {
 	int fd;
-	char read_buf[BTRFS_SEND_BUF_SIZE];
+	char *read_buf;
+	size_t read_buf_sz;
 
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
2.29.2

