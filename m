Return-Path: <linux-fsdevel+bounces-71631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B87BCCAF38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8267430A6B22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C2932ABDC;
	Thu, 18 Dec 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faYP3IJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3AB328628
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046883; cv=none; b=fTjIVyGXOovjgs1rmCWB7aXZJVXrX/cJVZ/nwRABfWcv6oE7s7tqen4uUK7MFRssmSsEaiqFaRA73++AvqoOrAqu5CAuOMci60qa3ZkMk5C0HJtAwiH2kUjY2LxpRKcJfG4CLOk9tvGSkv2SS8/kSwS3UzV7taTu9TttWoxVrjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046883; c=relaxed/simple;
	bh=5Kov8wpZd0ytsN8OxO1bOpepbaoUM/rZsgxUR7YqRJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDc6XIWQ9l6DwAQrdPmh3Z48/7WqPsgcIo7AZU1Q8gDYl42tUP+jlNTrDkWRcI+K8HlonSuLFF92UDpSs37gwv9cjCI1lEeVXWt+7GUbuIpu4M1t0fwRQUTgpdlRrsZ435ZlJd7rXhwMpqGBJwO2LOxxgIduicnRbh1ay4P2lNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faYP3IJm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0834769f0so3351475ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046880; x=1766651680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24/5SYXxAnigyvk1urWYtAuTM+F5TFG1BNssa8BP+9s=;
        b=faYP3IJmVjtIPU4Kw90p3j1x1iksaBNBUlOPVpGSqad1NR+iu6o2vdjWG7lCulUKIN
         sWIpqcaT+nOerzwAnOUPu1S3zf5vvaXQUNWsVhwO91bZ4+o4xCAMqSNZ3FXmuM6wsY4N
         s76M+UqklgW2kTkTBwTqMD5sHgiAfIK8lpJNelH4tH3uqeqCTL5gydu/Tjd600RnpmVG
         jQwxecVRARR3iMY1mTuop1b/Z2DmGlMiMCvoaeMoohOD8xV4Fu01n4K2DwpmivPFkJl3
         N/SpoHHBPT0s4Opg2av2+wIuHQIBID7k17HAFlPcSfZlQhwuLOm6igaIh0taT8rt6u2N
         W4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046880; x=1766651680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24/5SYXxAnigyvk1urWYtAuTM+F5TFG1BNssa8BP+9s=;
        b=m03CSMQ7j/C059dsURvKqZBFeY60dm9H5ZLAIKDFlZE226bwE6jLmxHYprxsjajavW
         YMOumCl7QA9ZXxY7NFfZRAOZAr62PBRlUPW4Btxukr6ghmx6I+EIK76Uyanf9rLV6WnE
         PHcVBEhbLaxI5PLQuQG12xUsXsgFrdsFU6ZqsyBuW686SkOalOQAFWGcy+RjjodW4nav
         WjlixF29uFgtLR8969qi7r1ErGiNtG+GIqwFSBCftXMswfrRzleDcYsvMYPLw5651uiE
         0UYG9ndMjsGSKLqSKN8txBiignQCXaBnGO4oQI+aSoAAu0ob85wbuUxzNmsf4PhOrZ1B
         LntA==
X-Forwarded-Encrypted: i=1; AJvYcCVGhnTBeJBH2ftX7AjJipngxwIM/HZhb3QIJmVhGvNFd2i2J/C5N6lJ2Ppi98/8tzFE7Tf3S1kF9zLMHBEk@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNx7MoAfah/qcb77OCr5JGtEtum0Y3fzZ5elgSbScNeylqIMx
	gehjy9m80OD+bT68mFkYdwcaFsR53llYIT6/8TgfjFAKfS8RNV+ggATy
X-Gm-Gg: AY/fxX5PAx+oj9Fs2K9tst1DM2h4vL0fNExReV7dJrkX8PDfNDQ5Xp9aGpHGJWd51lH
	GP4l8ywc5qJwE3DvY5EBW2oDqed4FYj8jP+Sk1Cjja/d1qZm4oZpzVz+Xp8snWssMdf4cuhidJT
	vHLl35Jq8pW34e8juvlT4IHFy0BHE0IQA3vWsijuRGTQQP68K7491zT8rA+0OmbOou8e+C51Avd
	mKPWgP4WDaZ22+NkqRZbFxgffI8CGDuqz7ZbghYp1iAZ1ni+XPqznPd9gMbi5Occ7+6TYdcDaj6
	qdVjBl116kgoIq0guZOBgfofQYiGLHxcr1/vpQhw6pDqUxFX1QFtMuiXPgy7hZ0Zwm2co1ApCHw
	eoej210dxBF3+k9M4VjRBsgCPxgk2Ux5Cpmcg+iuncfXW9HBHTH0vURm3l+wnIWmH7tocKP+Fjv
	ZCFlMk13B8kTg1SNoIgQ==
X-Google-Smtp-Source: AGHT+IFWf5nYc0y0xW2Vxq0ulBkomYWgJ+wY+WULkNWMJE0tTUAevbxxDQJJ/wsieX0lWBk+wUVXQA==
X-Received: by 2002:a17:903:3d10:b0:2a0:bae5:b580 with SMTP id d9443c01a7336-2a0bae5b6famr136989885ad.3.1766046880058;
        Thu, 18 Dec 2025 00:34:40 -0800 (PST)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c71esm17397655ad.1.2025.12.18.00.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:34:39 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/25] io_uring/kbuf: add mmap support for kernel-managed buffer rings
Date: Thu, 18 Dec 2025 00:32:58 -0800
Message-ID: <20251218083319.3485503-5-joannelkoong@gmail.com>
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

Add support for mmapping kernel-managed buffer rings (kmbuf) to
userspace, allowing applications to access the kernel-allocated buffers.

Similar to application-provided buffer rings (pbuf), kmbuf rings use the
buffer group ID encoded in the mmap offset to identify which buffer ring
to map. The implementation follows the same pattern as pbuf rings.

New mmap offset constants are introduced:
  - IORING_OFF_KMBUF_RING (0x88000000): Base offset for kmbuf mappings
  - IORING_OFF_KMBUF_SHIFT (16): Shift value to encode buffer group ID

The mmap offset is calculated during registration, encoding the bgid
shifted by IORING_OFF_KMBUF_SHIFT. The io_buf_get_region() helper
retrieves the appropriate region.

This allows userspace to mmap the kernel-allocated buffer region and
access the buffers directly.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/uapi/linux/io_uring.h |  2 ++
 io_uring/kbuf.c               | 11 +++++++++--
 io_uring/kbuf.h               |  5 +++--
 io_uring/memmap.c             |  5 ++++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 589755a4e2b4..96e936503ef6 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -533,6 +533,8 @@ struct io_uring_cqe {
 #define IORING_OFF_SQES			0x10000000ULL
 #define IORING_OFF_PBUF_RING		0x80000000ULL
 #define IORING_OFF_PBUF_SHIFT		16
+#define IORING_OFF_KMBUF_RING		0x88000000ULL
+#define IORING_OFF_KMBUF_SHIFT		16
 #define IORING_OFF_MMAP_MASK		0xf8000000ULL
 
 /*
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 9dff21783f68..65102aaadd15 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -766,16 +766,23 @@ int io_register_pbuf_status(struct io_ring_ctx *ctx, void __user *arg)
 	return 0;
 }
 
-struct io_mapped_region *io_pbuf_get_region(struct io_ring_ctx *ctx,
-					    unsigned int bgid)
+struct io_mapped_region *io_buf_get_region(struct io_ring_ctx *ctx,
+					   unsigned int bgid,
+					   bool kernel_managed)
 {
 	struct io_buffer_list *bl;
+	bool is_kernel_managed;
 
 	lockdep_assert_held(&ctx->mmap_lock);
 
 	bl = xa_load(&ctx->io_bl_xa, bgid);
 	if (!bl || !(bl->flags & IOBL_BUF_RING))
 		return NULL;
+
+	is_kernel_managed = !!(bl->flags & IOBL_KERNEL_MANAGED);
+	if (is_kernel_managed != kernel_managed)
+		return NULL;
+
 	return &bl->region;
 }
 
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 62c80a1ebf03..11d165888b8e 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -88,8 +88,9 @@ unsigned int __io_put_kbufs(struct io_kiocb *req, struct io_buffer_list *bl,
 bool io_kbuf_commit(struct io_kiocb *req,
 		    struct io_buffer_list *bl, int len, int nr);
 
-struct io_mapped_region *io_pbuf_get_region(struct io_ring_ctx *ctx,
-					    unsigned int bgid);
+struct io_mapped_region *io_buf_get_region(struct io_ring_ctx *ctx,
+					   unsigned int bgid,
+					   bool kernel_managed);
 
 static inline bool io_kbuf_recycle_ring(struct io_kiocb *req,
 					struct io_buffer_list *bl)
diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 4573eed3b072..5b4065a8f183 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -357,7 +357,10 @@ static struct io_mapped_region *io_mmap_get_region(struct io_ring_ctx *ctx,
 		return &ctx->sq_region;
 	case IORING_OFF_PBUF_RING:
 		id = (offset & ~IORING_OFF_MMAP_MASK) >> IORING_OFF_PBUF_SHIFT;
-		return io_pbuf_get_region(ctx, id);
+		return io_buf_get_region(ctx, id, false);
+	case IORING_OFF_KMBUF_RING:
+		id = (offset & ~IORING_OFF_MMAP_MASK) >> IORING_OFF_KMBUF_SHIFT;
+		return io_buf_get_region(ctx, id, true);
 	case IORING_MAP_OFF_PARAM_REGION:
 		return &ctx->param_region;
 	case IORING_MAP_OFF_ZCRX_REGION:
-- 
2.47.3


