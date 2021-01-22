Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F275F300E2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbhAVUwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbhAVUv2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:51:28 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2EC061A32
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:50 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i5so4637011pgo.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghXEwRnY4PzM061MuP1pb0fdrgOGpzAMsrN3mJnwO7s=;
        b=HmKnFQK/jJswgAFkT3ZJROdh4Z3YOkNDeYIlJscI+HpQrxnHekiCujkaBybSZNHIzw
         RGuBL1jy59/TNYcdp1CYLHfRoKSIWOOx2pRnuM2WNcC2XgrjEMf6z/YlHQhSqWeCy9lM
         TiFHc6p9dHvK2IF22pQv1BXpzMD1f1gznY+nZ/2P+Y18J2dOQk1w20FS6tgajzVPtK3O
         8tw0Vu6yC7W9sCTnV9rA305AokqC43te5I5dbMRjsf4Bn/QhiYUlcrdm+E/4nTnDzIHo
         QvbNSq6nFfct+U0SKCfrAgp77UoozLJRct+jEEcFN8wtSqO/s5jLogjhhlExg02oUP0o
         BciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghXEwRnY4PzM061MuP1pb0fdrgOGpzAMsrN3mJnwO7s=;
        b=Nlg0IGLbX7vhqxJfXnxeIux6sZK1VtApYQzu/tLbMrv0uAGtQvMJW6fj5465wQ5fAl
         SHdRqRxZ+DZt05f4U0sNyui/6Q69wLb/yPq0TI1G5vvhhzA25ByD5+prWqLbPVPcMLB7
         IGrpSQcO65opIEEktKW9B24SpJ7YmnQQSi48zzR8THnvv2LgkZs+tJ0n/Z4cSEuDXzoK
         Nts+Xz1Go7bK9mL75rT444usNaPQWD2u5hbdWN5gRkjVopuQY2z6E5LwH6UwMASXT5bp
         uuDQ3xtzcUcNO9COhDUKi6T6/4KOiijEGLdzq4DbXcKdzh3vTgqpgBS0jfxBYcjMkQhl
         OmHA==
X-Gm-Message-State: AOAM530YQof8IdQq8wNaSaB30XNPQeI+n+qElwriaCefwCE17f2F+75v
        /O+N31VwXNWuKptJU5fqXMI816qagbwfQQ==
X-Google-Smtp-Source: ABdhPJwd4LKDpGluZiqDxWsIEyKvGh7+x2LDFrwLw+VW2djYzxaDCyreVtnZQmD7XMSynIiDfLMzrA==
X-Received: by 2002:a62:7b90:0:b029:1be:9e89:1db5 with SMTP id w138-20020a627b900000b02901be9e891db5mr452126pfc.35.1611348468907;
        Fri, 22 Jan 2021 12:47:48 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:47 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 12/15] btrfs: send: write larger chunks when using stream v2
Date:   Fri, 22 Jan 2021 12:46:59 -0800
Message-Id: <984c54fe2526fe8a6fad01ae7c28a0efccb2c99d.1611346574.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346574.git.osandov@fb.com>
References: <cover.1611346574.git.osandov@fb.com>
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

