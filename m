Return-Path: <linux-fsdevel+bounces-70498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92CC9D67C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C58D534935C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDCB1B425C;
	Wed,  3 Dec 2025 00:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOz9APZb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924D3A1B5
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722197; cv=none; b=Igh02wx3GBRLt3whDsx81pcJ2vqUJVD2nllCxnqDkoVJ1IVXgCH5CPia1hp4+nhSChTcLJRbesq6SqsESZ1BhQN3rj5gI1ZwFPCurvZ8fb4+9wTU7M5Z084pTE02LrJ6B2loMPD2K4X5pbDEFnLjSTdNDlBjrZrqy597fI6xII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722197; c=relaxed/simple;
	bh=H5pJXYdw73uQ5PTaZNSv/4cwVivoCphGDwNbQ2xew7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbpbmIDYlmQr2/VgRnioI0RbCgKb3jQzbnUkhPGOwOpHLF6BXA/VHvJj7gLlMf486Dso9hldwr0SlRcDfuDbalvVGXsigo4EqfZxAAXnJjMJrW7z8tuyBgdMfDP4jvw8ywCxt4odyC7y7Wocy/E0tycLPwGEfF7OD5FSz30nf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOz9APZb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-298144fb9bcso60108945ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722195; x=1765326995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Xvljb0o7dTuqJqMJUVJlAvbjlhXpEbahfBZkU4Ln8E=;
        b=HOz9APZbg/pzqJaiRIYIvmlFY8yOZvlXZOGCFQhN4Zzv8iDYLzrauurpncRc2i4uhl
         RtPJsMGm7jjojyuQB12zSpuE1xS3UD5f8/ZIvEPq2MGO2nkBgQs07auj4KeyT+ldP62H
         ePnjhgXOJbV3wqtorYEfsTCQGh7RiL/NZnEe+LpcyUHa9lbSvXdFFinKtZQRw3uIkjUO
         hEtNRqzBzcG0n8dSaouT5VoRerVlJSpLUYVFVtq0wro21IJkH6iW7G+dxJFZ/h0Bw/FU
         z6UUtM0Sc7nEL1cSHji+Y6b1/HN7k3Z2BJ2CuIeN/suxJ+RAcwHgx/I/CRBr31U+j/s0
         REnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722195; x=1765326995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Xvljb0o7dTuqJqMJUVJlAvbjlhXpEbahfBZkU4Ln8E=;
        b=YyOCPvsyaR8xL9codgNl4j7Tle++2bInUVXiHeEM5jjLOl0qjfiIe6DXFWIIV0FHyg
         pjbUJN+WhmqEx0gLRNiQzJyToa1VCZdXroveUrFRCI1aQJto2O8UwIA/CRBAI62aT5dk
         c/a/FoiAbYAo/kuF/vI3fYPKIaKwH79Z54iJ+9zD103VfVh57P920oGWqmylEldN+uNM
         EkD18+OLfyVrS/LkFMMCKJDTzgekCPqV0a7GK+3IgVIK0E3eX9Bflg/PD/Jk5gfC12z8
         5wUEmuvMfTs7JbMa6cVti70evylxMg60SMw8F5Yze6NUqihfOHlciT73Mt0Bq0HQBhwm
         w51w==
X-Forwarded-Encrypted: i=1; AJvYcCWAQbZW+2iwDLU8Aar0b0C9vOnwwpxhKtzqrU+5Ff8QJJR+AKUcoa6OwyM27UFXV2/TZqoO0hhl6aVpxJ3t@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0K31zek2YhrXrJUUxoFtXm1fc0FBHYk+x/Xr/bBsEKH02tLO
	rRApJB0WopOo9os5Ysnur7SJD509sCpOxZtwr1bXWuWiwRYoq1vFj/lx
X-Gm-Gg: ASbGncvxXUIj/mlSZJZ9n3vYVczbURLPFaMNmzeGLN7WdwegfES7LAQe6SJjFcY2+Iy
	ZIRZFvkrelrhjAMx5E4PMAjz4XQPRhXwaEAtewyJyirOT3LQlZIBk9WyRdfrLLb3dq/1zF39R7I
	V4EPDqaYJp2kS4AaSuzXSHJ+hFZthbJbo28nw7snYA9lQP2VF71SjTwvY6XGGEbY9xONjnE2Cjq
	ZTq73drtadvcZ9LA6+9rJ4xKYWq/rvT13GqhCy+p3rejDU/ZyNckdZAdfGbyK/whQNqnhDrmu0K
	RPhKu9ljsVjAX71A5mrnjrG4Z8UF/C3cuRx63grz0DCZHcX+f+E1BLMLmrqtCCyvQdlD/REHW0+
	yXkCfI1rKivO/Jde5ASnEjV1XPwvubK8NELZs2f540/KSxMnkA2AP6FK2MGkzAlboODkfX00VfK
	2/jZZQjSYiP5HJnl1wXw==
X-Google-Smtp-Source: AGHT+IHWZ6Ck8karVZGDo6ybg1Y6osGDql86Shy79Jo+tQo6/F4ZJJCHFP6rE1gRu9c1Tire4Kk8Rg==
X-Received: by 2002:a17:90b:28c8:b0:33e:2934:6e11 with SMTP id 98e67ed59e1d1-349125ffb46mr713689a91.11.1764722194762;
        Tue, 02 Dec 2025 16:36:34 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34912a0af01sm124596a91.6.2025.12.02.16.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:34 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 04/30] io_uring/kbuf: add mmap support for kernel-managed buffer rings
Date: Tue,  2 Dec 2025 16:34:59 -0800
Message-ID: <20251203003526.2889477-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203003526.2889477-1-joannelkoong@gmail.com>
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
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
index 1668718ac8fd..619bba43dda3 100644
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
index a46b027882f8..1832ef923e99 100644
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


