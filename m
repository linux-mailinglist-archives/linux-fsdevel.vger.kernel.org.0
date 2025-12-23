Return-Path: <linux-fsdevel+bounces-71892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FCACD7806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1389302F6A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248820E005;
	Tue, 23 Dec 2025 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eywjdc+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B01FCF41
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450194; cv=none; b=hJO4lyG1+BNFAL9+7oTCLOp19VMR6AlTI4CBRV9JF3/Xr5cmGDY6GPgs7odGrybrdZU3Hi0rMDHEXH2J+OPMHVII90WFChxC8cdhHYTIIRdp8cjM04N7QOVLi5mFJvOxVRdCxiI3afGhGXeWSiFEhvwdp5neDhOHjdgGvPslqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450194; c=relaxed/simple;
	bh=COCl9guztAYVMXPNcIxud/nPzeYV7BuCDCN6RxQXm5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRnq27V+KJlXobHFeQgh4Xq/eG6zIFPrFs+f03DyPfdo8PvqrnSo9TalmrU2it9f9pB2Ao+O8GiOGYv/Ww28Ck0UHB5RbyC9sHu3GclKXf7J407/inel6KO8GkKrZ4wUNrk+v6Keif6OWIf55jTLBpOKuTNNsU7FGc2d828j0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eywjdc+6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-803474aaa8bso909303b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450192; x=1767054992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT5nPSLO1oVg+NeVf7zLLiO3vl6pIEMWqzS0JDdVpZI=;
        b=eywjdc+6FeS6iSy8j6vlqOaCQTFVlWvXcJGPhvpoCs5gQFH+z2QXjX+w+nl+r/sUoo
         BNhG+RSgnHMt/8nXUzF83PAdYFywKa2EQyKIFvHxeSLGhvvaKF+sscFaTP9GTPXY6sxe
         CK5r+61/vcCclQRuxhFEFIK1D2IBPjk71OLUr90viNCQgWRgekXOGEvRY3ED9FZjhapf
         U71zaKA9UoyCK8CPH+GpfihjViYLdP/m3CJQRptCjpGDW9I8aaWjaWKv8M0TmU3X8ZE2
         aHnOMo5asXs6VcTtuAPRaI3Xhvu21kBvQpQZpY+qQSlVmZlyHPXTP0VDf+bHYQig6RlD
         qvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450192; x=1767054992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xT5nPSLO1oVg+NeVf7zLLiO3vl6pIEMWqzS0JDdVpZI=;
        b=MRz5kiaeXtxWFUkj23tH7hwedDP7PYa42l9XRWgJLcM09e5n7Ni88AjI26WXqHQfVk
         t21MGsCi3JGczv1rVSj5uXhwm9XitKz2eLfwGF36fcjzdhnvdkQPqB4YLD9x0NSUxnyB
         JqyQIFAOiqh5dGBWHyx4MvRC/jVEaKj1f0rh/ReYcq22UfYE0Xv+0AoxtEItqeQHGoNl
         uGfeJjVaC607KgukwylKw0ydC+Fot2hGry8RUcPocjImNl4QJUJBmVC8nzM8ib7EFzuz
         z1+gxJxjNbZeGgGVNMxf2Yr50EiFNlK0+ZD1KxlKtTtDUWliXPRLBscYhQGtxmhNJ0YB
         NhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNBdOj44LJJyOHn/7LUYeBbmpf/1YCXFpYZiRp3rS8ZvM3ahVZCdvi/+lCSutjhYkdWH+CrmUX2R1ItHB4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9I8MwE8jBvktFP/kvrCTH/q3CcxjVwS3zhrjO2lBHpr0JZWpd
	eeijT7Tas7sxz/R5JH8o64Cy7YJhfo+GDG48e5hJ1E1JLcSk/jn03lY3
X-Gm-Gg: AY/fxX4IChhbHyOT5HCW+Efygj74+UyEutEDBArHwpcpoK5Z8PcOpkaunmaNNSrebNE
	khp0EH/UxztmatQK6DqXJARE8Rsk+iti4YA1u+ol4AdWApEBm7EwFOnXdcfrohHwxphjE0f/4+I
	Uv0cYHQah0eyAzShlq2O/pxYmgebIUWuwdFN38E+VdhmpYsQ9OOBbORQgIytt2kxvnMe0CSE3Bh
	RqcDX7412tVZBgDunX6KyDEUUk/o+B30cT6VNCFcMAxEdGwl9QA2BPT0r0vFf//K+8yGwvAF7Qg
	9oYqVmCPxhxbMIOAgriTzhUXoN99rBEzyh+ojJ3Xd4rSUbN+8s0Sl54FoEOsEKVSgWhhr0HGuKj
	ca+hp3OcQkmbp4U9kJUvdJF0AOworR/JrqSghi+tv0Cx+3p5FiXFq6Jsn5jcLMNWwxWMcJ7c/9/
	EPI0/dTluMMBzvZj+87Q==
X-Google-Smtp-Source: AGHT+IHkfl4KxM//D68VMFSelIB3fh1wAWEsD1B1SX5+dWlkRHJUlAyUxwZyHNyHClaAREfGB3DSfw==
X-Received: by 2002:a05:6a21:99a4:b0:364:783:8c0e with SMTP id adf61e73a8af0-3769dba8e23mr12566089637.11.1766450191605;
        Mon, 22 Dec 2025 16:36:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab836sm11629594b3a.36.2025.12.22.16.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:31 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 04/25] io_uring/kbuf: add mmap support for kernel-managed buffer rings
Date: Mon, 22 Dec 2025 16:35:01 -0800
Message-ID: <20251223003522.3055912-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223003522.3055912-1-joannelkoong@gmail.com>
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
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
index 8d253724754e..68469efe5552 100644
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


