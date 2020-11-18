Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4259E2B84B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgKRTTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgKRTTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:16 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CDDC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:16 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 5so1527695plj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26N9VK0p5cJDz5jy+y4kzcNpExO8G7FO7M93wxXu0UU=;
        b=tSKDlvfhTgTzL5lokM5AI2dcEugmR/E9HDpNCOTivrWdxD/qz4lK0H37LL+0rK7ZIC
         FctY+zpUH3tLvRQcOuG3k8JbbMWl0D6Pgc+Epr4rKcHfE5nJ1KHxjpjelPt9Xm+F2o4v
         qa7fVlKEzWV9QVQexhqatvev+UC2CuLhYpG2NZ4VY6f00TPG7aJpGcX1GlQBc64X5abY
         uwaYFhnR2/A4Gn53cg2jt97U45Ckl4Cg4shzqx0h0cwNu0zDEEALT7NCGlTnHMWo0eJy
         45ZgBDiE229Zg0PoWrjuVS/iopvJoSYUTy7zL936nnvi8v1TTeCkIi2jnJViEB5cCEj8
         OdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26N9VK0p5cJDz5jy+y4kzcNpExO8G7FO7M93wxXu0UU=;
        b=Azu7moTF30boGWDMG64+kBtVqT4s4pN1c/l+ns/zZsfMJn0Q4l06Rr7ZZ2stPoYo3t
         irkhcKXN9atmSBt9IbbyEHu6iP95+2gVsdxy/f8es9vl5CjVNy/JircqE01dJI1m+v5U
         oSb5EH6hpNwE0oAe824laVvQWUUfXxUkl4iccJgFkvdUdBSgBPe6n8y2QNRqQKWrcMA+
         BAt/B1ZAi4fWrtl+TO6I0jEmrVInsfQQoCHhvhHkeCs7UZkk4rrkhOOA4daZsBtJphLs
         S2dv7TgNyGR/ZhqSbiwbjVZ+HSlgU81mY2FU3GLBopnNiXcjqrlZ1bkZepVmfoozSLMi
         9M0A==
X-Gm-Message-State: AOAM531bm5UsLjjfWtcpbtaMEfKfRu/1MdPK2iqZdv5krU1i1YcS9KtC
        hX1psKPtxhXmYg/NetOL3eDrmA==
X-Google-Smtp-Source: ABdhPJwOzZpCBLIh+2XGUvA4XyTM1PJb6t6LcUd1nFPlredd6XVqU325+opbjlvlVe5hyiElPyY1Iw==
X-Received: by 2002:a17:902:eb42:b029:d6:ba60:ba41 with SMTP id i2-20020a170902eb42b02900d6ba60ba41mr5653407pli.0.1605727155762;
        Wed, 18 Nov 2020 11:19:15 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:14 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/5] btrfs: send: write larger chunks when using stream v2
Date:   Wed, 18 Nov 2020 11:18:46 -0800
Message-Id: <ea4b519738e34068c3558000555b5e8f2d40c3b5.1605723600.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The length field of the send stream TLV header is 16 bits. This means
that the maximum amount of data that can be sent for one write is 64k
minus one. However, encoded writes must be able to send the maximum
compressed extent (128k) in one command. To support this, send stream
version 2 encodes the DATA attribute differently: it has no length
field, and the length is implicitly up to the end of containing command
(which has a 32-bit length field). Although this is necessary for
encoded writes, normal writes can benefit from it, too.

For v2, let's bump up the send buffer to the maximum compressed extent
size plus 16k for the other metadata (144k total). Since this will most
likely be vmalloc'd (and always will be after the next commit), we round
it up to the next page since we might as well use the rest of the page
on systems with >16k pages.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3cd090c3ffda..822458e6ffae 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4918,14 +4918,27 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
 static int put_data_header(struct send_ctx *sctx, u32 len)
 {
-	struct btrfs_tlv_header *hdr;
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
+		/*
+		 * In v2, the data attribute header doesn't include a length; it
+		 * is implicitly to the end of the command.
+		 */
+		if (sctx->send_max_size - sctx->send_size < 2 + len)
+			return -EOVERFLOW;
+		put_unaligned_le16(BTRFS_SEND_A_DATA,
+				   sctx->send_buf + sctx->send_size);
+		sctx->send_size += 2;
+	} else {
+		struct btrfs_tlv_header *hdr;
 
-	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
-		return -EOVERFLOW;
-	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
-	put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
-	put_unaligned_le16(len, &hdr->tlv_len);
-	sctx->send_size += sizeof(*hdr);
+		if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
+			return -EOVERFLOW;
+		hdr = (struct btrfs_tlv_header *)(sctx->send_buf +
+						  sctx->send_size);
+		put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
+		put_unaligned_le16(len, &hdr->tlv_len);
+		sctx->send_size += sizeof(*hdr);
+	}
 	return 0;
 }
 
@@ -7255,7 +7268,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 	sctx->clone_roots_cnt = arg->clone_sources_count;
 
-	sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
+		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED,
+					    PAGE_SIZE);
+	} else {
+		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+	}
 	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
-- 
2.29.2

