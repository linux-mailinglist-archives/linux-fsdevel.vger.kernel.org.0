Return-Path: <linux-fsdevel+bounces-74250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A23D38A0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE1C9300647B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E4B315775;
	Fri, 16 Jan 2026 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doUCLszW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC16235063
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606266; cv=none; b=HPO3MEw3OpxY9rwmLaRd1xWHJaO+6GzDHYsZq7/JygLts0XpUY2af+N4Lwq2p2T+Xun3GbDgFR5seyMAs2U1FJLa2P47GxU7FS6cspTN8FVgrpOx1DQsY157FzNMHHC1bnkkOxu2TnXyOpFByAaYgrJAW2bpFfJXJaOVbB/zybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606266; c=relaxed/simple;
	bh=2bl1I2nGDFhxzgXjKcGi7d1dbtnWWYC+yqHyoAr/ZWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usHJEwU/b0oFS66U/gbkS9Yh8B33iYv4HCTpjHhbRlATu3Djhm30iUUgKexldFZEYhPkYPaTFKQETmkJeZuz5c/N770ce3hkCJFiFj8zwb3m19gQv36PKx3aO4LUr/V3PPJtvs8G60S5sJrZcb6jSXdkVqgg8Fp513yjOn7zOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doUCLszW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso17804455ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606264; x=1769211064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGm2YYLVF+NHRLQ/f0+pGaC5F7muCq47qD8Hd3HU+QA=;
        b=doUCLszWg5IuU57jrTKvzQhLdLa2I7HhUgF5fSydurWS0kzygPjXLWu0o4gGj4bOlv
         /H0eSAZu3Sanx1CiI0ALb+1YkhOnYaWN3gIDVppaBcG3VNWVuhODKGdRphsnbniuaob3
         h4rhGr/WuRZw/8tIALBNSG/0I45BDJQ9LazU1WQGQH9BJybYtQzCOv8Az68uLLgvdebM
         YHGWKx7ggwarMBaTiBQD3QVJus+q9Ykb5u4SLE5Lc0oBN0x0wmeygoB+P5UtUltdCszU
         2rZ9Uni6EHy0V6TOv9Xyhn2victg0nHdOrJTmPysGeMBRr3a4JBpvQLIjbMmrNWaRes2
         25iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606264; x=1769211064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zGm2YYLVF+NHRLQ/f0+pGaC5F7muCq47qD8Hd3HU+QA=;
        b=jeFYsVMmRn7n+Ok4erA1JR0rJgsgGuf86dD/LSF2yc4xhU3ULxYPujZtOkDOuGh141
         P6n8UoeW+TA68CBPqWWpofMmMOKn5aC6Bar4WCQSr8qb0yIxBo+9VZuo3YzXE5gvZ7Mf
         5xBRZVxeEqDw75cUWwQwTDlJL5YxCH//R5gzCfDHv/dzwjFgjz1ZpvpCe2+n83/VAMGS
         ky5+5wcsLLMPhZHVFFwq2sx1wed5cbGCZnzzG6l4J6w05Ul3zXFgrHrwt+MIL7NnEmYT
         JlfyW2uGezi889dGqT49QORN73UyQyd/8wzA8fhkLVaq/MHkAia7PI9sByOKLSJPU0oB
         N67g==
X-Forwarded-Encrypted: i=1; AJvYcCW6i48pN+qkyvUuJy1iqbKGWMNuHYNSrznFPNiaz+L9lpKLhaYGWcxIZSDcef3zqGbEFVTguAkACB2f+ZH7@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMMijTOlh+s9u0gIIvzpGcyBv4uslEMLTnDmG7ViqauAf6Lic
	/XLRfjR5WeuICtHB8J8W+vW3xrRnVnxnopAClR969rFa4/pCAMTMfoLQ
X-Gm-Gg: AY/fxX7k7OVnUqEPyU1rl71ev7r9TrP+8cYTiYMF+L5FjEHqLnKOyCgJFhU4y+6X/9F
	xO6Iu1lbwB330Z3tVsZ/q3BTtpfK++iYge46nRfOhVsI7k/i3BlsB/WCO9NYDOfg7kbp7c08CCH
	fiOrF6UUL2C6K4GX82az8K0kBX33YrCV6GnERHPSHiQnxDRDm8DaDd6/LZXU9AENSF1QBzMwmYy
	cWdZgmrrqC08dM2xuVMKvcl+7xcVoBobYesm5L/2/ZY/YJhKj4k4KUthCeCCDLOZXqSMpyZcr6K
	att6MfLS1C164Z65smdElVRF+kNj40mRk3qVQPYznNkbxhCwmpVk4P7KN/3V8pDo4v47G/narTR
	GjDKDHBt01f/ETKA1Q/PDyW1wra3cfqwXTUVGq17UB0VocNkV4V4OWoOzt/xO9OSS9d5bLIv2ek
	jSFyTTF6awJ4OQMhrX
X-Received: by 2002:a17:902:ebcb:b0:24b:270e:56c7 with SMTP id d9443c01a7336-2a7175299admr50042895ad.7.1768606264046;
        Fri, 16 Jan 2026 15:31:04 -0800 (PST)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190aa333sm30285985ad.5.2026.01.16.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:03 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	miklos@szeredi.hu
Cc: bschubert@ddn.com,
	csander@purestorage.com,
	krisman@suse.de,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com,
	xiaobing.li@samsung.com,
	safinaskar@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 01/25] io_uring/kbuf: refactor io_buf_pbuf_register() logic into generic helpers
Date: Fri, 16 Jan 2026 15:30:20 -0800
Message-ID: <20260116233044.1532965-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116233044.1532965-1-joannelkoong@gmail.com>
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
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


