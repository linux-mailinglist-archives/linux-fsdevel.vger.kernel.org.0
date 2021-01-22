Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927BE300E3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbhAVUym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbhAVUwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:52:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA71C0698C8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c22so4589593pgg.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghXEwRnY4PzM061MuP1pb0fdrgOGpzAMsrN3mJnwO7s=;
        b=TesEIPxJqm2jRVCECOtON/HbVrrqYz+HYPrdiBvlxZDr5aAPoF4LQJiIOOC7yhST2o
         fSrBOLfe20bD0coaM2TJECVIVab5iPU9Kdr8azhlmYCcInQHwyaPULVLuGGCODC9yQ9e
         QMi5TojCOkmpNQgrrEBZUE9AHJqlSumQXR2zwYCc4+ZpRWFXeoXfn5duW0AjLAKi9+ey
         5WszJ39/BsGmpvBXcuy6OqjA//cYQtxxjcTJZFZnsIy3cYCX5C65kfGF9KgjEzV1XKia
         4ssjHucAGgV1zfjYRG8If0GfSAzSFsWZ1yO46v7T0p3n4H7fjt28TubG2TotUa2Uu4j8
         RRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghXEwRnY4PzM061MuP1pb0fdrgOGpzAMsrN3mJnwO7s=;
        b=smqR3uI0ADU14nSP9Bh9VHK6Y+iB2mdOIfQ8vEzhELjoio4ujIxpSp2QIG2qyupHkC
         9dGOd1jY9BThMM6/5bOU/7mCOxYY+wCCA589Gkyk9vG8jjk1xvTKDUpxhSbRUN/pV40X
         MLIXLEVyZhLE3QZX8Lv8fLwMjLqYVm/TcVKpaRwi7WjrZAC1ARGhfsp+Uo9bIxQBv+rK
         p1jF0Y+H7t3kkVDhg9tSchvCcL99N49V47Edg53LEQApGRQdlC4oUMPDLDqMyCL59dla
         E2qnqBCcc+2TA+Losc/fCss4B0/yNRawZlHVOYCFsugeKojiAIzXU2wiirRny39d0dQH
         NnbA==
X-Gm-Message-State: AOAM5336IAg4HfqrPYiPDGvgKIviRsWGVAQfyo3SFvb/Tb+W+mha6liI
        vG0gJBFkgDK6gZHA3jiGql63kQ==
X-Google-Smtp-Source: ABdhPJxnhP+RKtuv5+Ko43Q3BdvHZwuXId2no5zWBdzy0+VpIlnmKl/f3RaWbKK2kmI3x+Wkh7yqXg==
X-Received: by 2002:a62:f202:0:b029:1bc:a634:8e9c with SMTP id m2-20020a62f2020000b02901bca6348e9cmr1831028pfh.49.1611348504764;
        Fri, 22 Jan 2021 12:48:24 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:23 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 2/5] btrfs: send: write larger chunks when using stream v2
Date:   Fri, 22 Jan 2021 12:47:46 -0800
Message-Id: <b66f99260a0562922e72dd71e7c78a2c22725beb.1611347187.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
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
index d07570588a16..98948568017c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4915,14 +4915,27 @@ static inline u64 max_send_read_size(const struct send_ctx *sctx)
 
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
 
@@ -7267,7 +7280,12 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
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
2.30.0

