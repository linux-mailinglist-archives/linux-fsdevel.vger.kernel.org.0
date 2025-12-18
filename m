Return-Path: <linux-fsdevel+bounces-71628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E19ECCAE6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C75F301C8A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372612F0C76;
	Thu, 18 Dec 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEJcM6ua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A50185955
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046878; cv=none; b=P0Z2JfEh49PM2umYXjTaY73uXY2uSbOBVqKLT4LT2BND0wQP1IZ/7IqAsAGoY+ygydZVLli14a+wWWovWBzsqiWqG9NUekLVSxpa5OEgimuTq4kiE+ON/HIQ8vQn5s/3J9OyZ4saUB0TGiHHSjn4b1KpqcRrbl9ybxqLHNq4J84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046878; c=relaxed/simple;
	bh=2bl1I2nGDFhxzgXjKcGi7d1dbtnWWYC+yqHyoAr/ZWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akgqrGuwvaGFv3cE1zqwFb+e4P2xY2HXEfVGVr8g55aB/xeGSQymopR0r06XobxSO9iDQvUFToDTyCEHq9iJAW0sUqkwl87VpEcDhskhFxFYvAUbf4fD1OlvNN690tXL6YIErPJTeXYm/P4ekCYvIyGCwUIRFbqSv6oxnj7Nl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEJcM6ua; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0bb2f093aso3874595ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046875; x=1766651675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGm2YYLVF+NHRLQ/f0+pGaC5F7muCq47qD8Hd3HU+QA=;
        b=GEJcM6ua7JcIZfyS+akR9z4NCe8NDwlxgfy3saKTTlB0z85tNZGoKquzUDIBK3CRii
         yJ01XSfXdY64Xqm/CEZ4ao3IlTgdZamqU8xGJrHfr6GfFzWbdX1TpxY8LbpJFR1crsKO
         di+P1xHECMfhaQ8X147zNDqG8EGXM151sTSEZWpf5B3pdLRkdl+yTVN4bHN6DEuwxdms
         bxPWhVBBGKeuslLnjalFOGM3f1t4NCk0tbKfRTXMbrOXA5M4mU+eW6pAPzajiYxcA/ub
         VqOrQtWMlgJC8kq3Atx73j/HzHGVkBtYt8z1R1/jQALWim3kV7CudlqH9npwr6TxT8sS
         wDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046875; x=1766651675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zGm2YYLVF+NHRLQ/f0+pGaC5F7muCq47qD8Hd3HU+QA=;
        b=XopK7LlDENFwQ+E0zKF7YmzEt3bV25fB9tVt9nM3YiR2M1uGjHCrb8ech4xRcGviGe
         iH8zMTq3ZVrdk+9zvuKVOloISFbYxX0JZBekwKETkrrDD5yPYYMj1OyPinYTYPXJmnvp
         1WIrKSdizNP2zr3Qeg34qgQuli2obvwyfJQM2lJ+eJQdZd3e/6xiaKQ6SfflwLEhAcrD
         EvAM5xHVJ954mhMJVbTDNHLOw+So0BiIVYYF3yEEObdcPvN3yU+CD+KemHy+RFXY2N1+
         EZExgRctQK1ej4jNYu2zjktAMIqykZS8rv/9yn3+r5pAfLodMABQbgkV8NdWnjcLstk5
         LYVg==
X-Forwarded-Encrypted: i=1; AJvYcCX6qxKyFdL7wrU7zPDpd/JRATvjCG1+TqIJ1wZWvd4Cs1i0d2qH16nt/8Xn8S+BUPS80AT8o8yaRNQZ9/cW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz78Ilx32JMKZQoItepQWdxb52j5PWPwoKAV5q1LsdAGaBZRnIt
	/qOqAXuNKswdmtk8QnpJIgVgtL2PIiihn6Jy/FqlHTuUnHu3pmekC/UdTLQC6K1F4OA=
X-Gm-Gg: AY/fxX7pbKg6xBzecE6uIp+bjUsUG2zjYMhexRfosq7zLvVhMYzy2JsOffvijfYQxBo
	Fal7P4EhznZ6BBEKPEuILlPOHsySsSbfm4YKzyUEhFbuTqQXOqWGXXBt9WQZGddryGZd2YtHBCH
	B9V4mXqBKwUjP8gUPCmnnrw3dEztHMCQ3kti/ZH2+++Dvc8+GJsK2MmXjvA4TB9KpFx7yJXjii6
	n4FcJb0p5rCWw05piCRlLmSG2TGaTmQoqQcmqXxRCTYj46Qh9+Lq8piVkJl/StxxKSRnOSQSE2N
	456mg23Yr64GpEFSwRr9TMcHRzgVJRyqG4OcsQ1NzwWRgPfxYzSzWHWtZ+53OrBPPWBc9tdtD7D
	TQImI6oa3zxcGf4zYZs/Ppe/q16GpvwR2nu5G7sZ3/cY4AT6MFNTBXfyKEZlRYtYsoMfvtC8q2Y
	+E4OAZp0wEVGVZroQ4DA==
X-Google-Smtp-Source: AGHT+IG01Zh5Sj8Wpw60Y9qnB2rGkNf0VkStAE7zfoKr8x5fg0qT0m6qdMdO4p0UwgOn+i6lxzt3pg==
X-Received: by 2002:a17:902:c94c:b0:2a0:d4e3:7181 with SMTP id d9443c01a7336-2a0d4e37ae0mr164872185ad.49.1766046875310;
        Thu, 18 Dec 2025 00:34:35 -0800 (PST)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926cecsm17272995ad.74.2025.12.18.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:34:35 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/25] io_uring/kbuf: refactor io_buf_pbuf_register() logic into generic helpers
Date: Thu, 18 Dec 2025 00:32:55 -0800
Message-ID: <20251218083319.3485503-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the logic in io_register_pbuf_ring() into generic helpers:
- io_validate_buf_reg(): Validate user input and buffer registration
  parameters
- io_alloc_new_buffer_list(): Allocate and initialize a new buffer
  list for the given buffer group ID
- io_setup_pbuf_ring(): Sets up the physical buffer ring region and
  handles memory mapping for provided buffer rings

This is a preparatory change for upcoming kernel-managed buffer ring
support which will need to reuse some of these helpers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/kbuf.c | 123 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 41 deletions(-)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 796d131107dd..100367bb510b 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -596,55 +596,71 @@ int io_manage_buffers_legacy(struct io_kiocb *req, unsigned int issue_flags)
 	return IOU_COMPLETE;
 }
 
-int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
+static int io_validate_buf_reg(struct io_uring_buf_reg *reg,
+			       unsigned int permitted_flags)
 {
-	struct io_uring_buf_reg reg;
-	struct io_buffer_list *bl;
-	struct io_uring_region_desc rd;
-	struct io_uring_buf_ring *br;
-	unsigned long mmap_offset;
-	unsigned long ring_size;
-	int ret;
-
-	lockdep_assert_held(&ctx->uring_lock);
-
-	if (copy_from_user(&reg, arg, sizeof(reg)))
-		return -EFAULT;
-	if (!mem_is_zero(reg.resv, sizeof(reg.resv)))
+	if (!mem_is_zero(reg->resv, sizeof(reg->resv)))
 		return -EINVAL;
-	if (reg.flags & ~(IOU_PBUF_RING_MMAP | IOU_PBUF_RING_INC))
+	if (reg->flags & ~permitted_flags)
 		return -EINVAL;
-	if (!is_power_of_2(reg.ring_entries))
+	if (!is_power_of_2(reg->ring_entries))
 		return -EINVAL;
 	/* cannot disambiguate full vs empty due to head/tail size */
-	if (reg.ring_entries >= 65536)
+	if (reg->ring_entries >= 65536)
 		return -EINVAL;
+	return 0;
+}
 
-	bl = io_buffer_get_list(ctx, reg.bgid);
-	if (bl) {
+static int io_alloc_new_buffer_list(struct io_ring_ctx *ctx,
+				    struct io_uring_buf_reg *reg,
+				    struct io_buffer_list **bl)
+{
+	struct io_buffer_list *list;
+
+	list = io_buffer_get_list(ctx, reg->bgid);
+	if (list) {
 		/* if mapped buffer ring OR classic exists, don't allow */
-		if (bl->flags & IOBL_BUF_RING || !list_empty(&bl->buf_list))
+		if (list->flags & IOBL_BUF_RING || !list_empty(&list->buf_list))
 			return -EEXIST;
-		io_destroy_bl(ctx, bl);
+		io_destroy_bl(ctx, list);
 	}
 
-	bl = kzalloc(sizeof(*bl), GFP_KERNEL_ACCOUNT);
-	if (!bl)
+	list = kzalloc(sizeof(*list), GFP_KERNEL_ACCOUNT);
+	if (!list)
 		return -ENOMEM;
 
-	mmap_offset = (unsigned long)reg.bgid << IORING_OFF_PBUF_SHIFT;
-	ring_size = flex_array_size(br, bufs, reg.ring_entries);
+	list->nr_entries = reg->ring_entries;
+	list->mask = reg->ring_entries - 1;
+	list->flags = IOBL_BUF_RING;
+
+	*bl = list;
+
+	return 0;
+}
+
+static int io_setup_pbuf_ring(struct io_ring_ctx *ctx,
+			      struct io_uring_buf_reg *reg,
+			      struct io_buffer_list *bl)
+{
+	struct io_uring_region_desc rd;
+	unsigned long mmap_offset;
+	unsigned long ring_size;
+	int ret;
+
+	mmap_offset = (unsigned long)reg->bgid << IORING_OFF_PBUF_SHIFT;
+	ring_size = flex_array_size(bl->buf_ring, bufs, reg->ring_entries);
 
 	memset(&rd, 0, sizeof(rd));
 	rd.size = PAGE_ALIGN(ring_size);
-	if (!(reg.flags & IOU_PBUF_RING_MMAP)) {
-		rd.user_addr = reg.ring_addr;
+	if (!(reg->flags & IOU_PBUF_RING_MMAP)) {
+		rd.user_addr = reg->ring_addr;
 		rd.flags |= IORING_MEM_REGION_TYPE_USER;
 	}
+
 	ret = io_create_region(ctx, &bl->region, &rd, mmap_offset);
 	if (ret)
-		goto fail;
-	br = io_region_get_ptr(&bl->region);
+		return ret;
+	bl->buf_ring = io_region_get_ptr(&bl->region);
 
 #ifdef SHM_COLOUR
 	/*
@@ -656,25 +672,50 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 	 * should use IOU_PBUF_RING_MMAP instead, and liburing will handle
 	 * this transparently.
 	 */
-	if (!(reg.flags & IOU_PBUF_RING_MMAP) &&
-	    ((reg.ring_addr | (unsigned long)br) & (SHM_COLOUR - 1))) {
-		ret = -EINVAL;
-		goto fail;
+	if (!(reg->flags & IOU_PBUF_RING_MMAP) &&
+	    ((reg->ring_addr | (unsigned long)bl->buf_ring) &
+	     (SHM_COLOUR - 1))) {
+		io_free_region(ctx->user, &bl->region);
+		return -EINVAL;
 	}
 #endif
 
-	bl->nr_entries = reg.ring_entries;
-	bl->mask = reg.ring_entries - 1;
-	bl->flags |= IOBL_BUF_RING;
-	bl->buf_ring = br;
+	return 0;
+}
+
+int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
+{
+	unsigned int permitted_flags;
+	struct io_uring_buf_reg reg;
+	struct io_buffer_list *bl;
+	int ret;
+
+	lockdep_assert_held(&ctx->uring_lock);
+
+	if (copy_from_user(&reg, arg, sizeof(reg)))
+		return -EFAULT;
+
+	permitted_flags = IOU_PBUF_RING_MMAP | IOU_PBUF_RING_INC;
+	ret = io_validate_buf_reg(&reg, permitted_flags);
+	if (ret)
+		return ret;
+
+	ret = io_alloc_new_buffer_list(ctx, &reg, &bl);
+	if (ret)
+		return ret;
+
+	ret = io_setup_pbuf_ring(ctx, &reg, bl);
+	if (ret) {
+		kfree(bl);
+		return ret;
+	}
+
 	if (reg.flags & IOU_PBUF_RING_INC)
 		bl->flags |= IOBL_INC;
+
 	io_buffer_add_list(ctx, bl, reg.bgid);
+
 	return 0;
-fail:
-	io_free_region(ctx->user, &bl->region);
-	kfree(bl);
-	return ret;
 }
 
 int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
-- 
2.47.3


