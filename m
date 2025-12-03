Return-Path: <linux-fsdevel+bounces-70500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642FDC9D68B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75633A3D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB9221FBA;
	Wed,  3 Dec 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVLyI5Qm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A37224B12
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722200; cv=none; b=udYT5zjVXWqqeit3NAe9A0xTUcF+WLnUtfpe0ClEINS8fKTOiqZ9V/IWRM+R2ofEq81j3bz3zBln3kmOYFfPSr7oaK/grpDmmkj0VkqV1Rp5BmJircnIAsdzQAFLzYqsREv9W4yIKIuGqnDcyTgR+S2uwaStc9X1PqZRWE6+HEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722200; c=relaxed/simple;
	bh=AHTn61fBmrmRmi9FoGK4ms2rCTBJw6qzcd7TRkLtpeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfIJ6xXzDEo3hiSADvbDyBAEEaoih3hvU1eT6sYPy+spU9lreR7VdNwEpQlqDxb2YYlnhB0kBdTghPqoOWKeEXlrpQFQY80F032nBcVHN18WImYG3Xqf1UnTvX6S0hsHsHLMa/O9PN0cFFn4b5r24idHFPZ8UvhCGCgsDFck4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVLyI5Qm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aad4823079so5461232b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722198; x=1765326998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjhbYsI9c7Tu1t4+LNuuFKc04qJ6bp8LwmpkuMD/Kpg=;
        b=YVLyI5QmMowh8TQnuBu/l1DRtUAvMlXXGqi0fr8gWiMsRK//33yC8o64TQzOVeUhYL
         2fGJlPLXP6+ShtxCs7wemKKS4lsIei1EFyNm8XfBvZgXuYR90C6EHryicFMXbm3pBXsK
         TexekHIh1SRGC6aGU2Mv98JceCkmcVOc0BuC1RUIqKKZ000kCfKMO0BXUGjfNRRqpodm
         MZSO4xaKrn2GAtjABz3n6xoSKXSBKAmAnLw3XePpEX1EyYrQcGRTXWEysDs29XCegaNb
         v46N1W7TEsd58UpHxTlfjk6Nrjq385BDhkvHrgYYxMW+C8abGV/qF9Hb/f5I2rNqEX5e
         HiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722198; x=1765326998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjhbYsI9c7Tu1t4+LNuuFKc04qJ6bp8LwmpkuMD/Kpg=;
        b=An7XaGUYmGBZ6LaeaonHHW25H3D1qEU/WzCyldQDQ0EWbD0ebcyer63q/kVF/sQJ+5
         6Ni6VR2NqPOS5LkPcP1JVRp6UCPh6bqyZsbbQI567UONV1ORcWcwgOdLKXLg+RpSrwUm
         Ma5z5ww1LNPpmHy1Y2sug0tVA9UNd/byAj8+2Hc/XuTgiuCT9tReWO3g2DaAjzY9gI21
         Vdq3EdNRg1105Oy05IdUaPcaAG/xv3SVGReVeP+c3d/DpQPL/UQIzBvMw8zyOv5juFFT
         LQtdigesIb2q1qHVkYdZqHX/s+MzliL3Ui8uksXs1Fl9VZsX5JJZKO6VNIEDMKMAW9lB
         FObw==
X-Forwarded-Encrypted: i=1; AJvYcCWtgUJNMHcfqIhoRlqv1aw0Qhx0f0ryLnKENsXIfZPtx6NthL9TvCIMzrZ/9UROv4pC002AJooJAm830mw8@vger.kernel.org
X-Gm-Message-State: AOJu0YwqnNcZecbkb9MmdyvfcK1QmrjmVqmGbMRJ2yyokkAm+DfUGaim
	F+/gTko52q0+FM4S57CJT9Mo/294GlqoXp2SdE4/uzYI4esZYlgJt0h8
X-Gm-Gg: ASbGncubuM/XKZ9QVRKhbU8DG7zCaY9JaJeIIaB2LTBM16fxnAeF9ZmachYvx2J0FMT
	lq/XRO0ACsBlJ1+qRBi0OEQ9Lv0xdLbd5rYnwfG4IJaGLaGKkhTpy5rlQrNT3NsK5UtRt2SGBZ1
	fxdIJzMbsIY42U9Z2HAM48YXaO1PSFqvKLDNckhjC784vtelnf+sykvZjW6PXA2YPbDqH9E2aVG
	V2d971IjaP+TBMtCP+3psPNFFqedgDJKgfJrEqvJC3XL+igOpCJkasshAYMBczyIN+J66IkSij2
	2zZmnykSqlVnBvJMfPHRPbq+sPLG7dAFkScNijnY+u6nvTAuFlkfX+sYABAywWaEezbi3HwXxIK
	yQBWDQN3JkyZvWrXpVwTx1dA7yOTaVwgcCYp3Wnv8Bw+S61oS0JwCl3111yMIBAmF7NMKFAOSkS
	yChgecXgHPwtIY4KtB8HwQ76q0sl4=
X-Google-Smtp-Source: AGHT+IHjCyBLsyEAF1TNXCKsD3GUhZ9eHW+S01q0eV4HFNoK5aXIPp3uNTkhtz837SfgIHDuwAd2WA==
X-Received: by 2002:a05:6a21:3296:b0:35f:b96d:af11 with SMTP id adf61e73a8af0-363f5cf42a9mr724089637.5.1764722198146;
        Tue, 02 Dec 2025 16:36:38 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be6ec21e044sm13468927a12.12.2025.12.02.16.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:37 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 06/30] io_uring/kbuf: add buffer ring pinning/unpinning
Date: Tue,  2 Dec 2025 16:35:01 -0800
Message-ID: <20251203003526.2889477-7-joannelkoong@gmail.com>
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

Add kernel APIs to pin and unpin buffer rings, preventing userspace from
unregistering a buffer ring while it is pinned by the kernel.

This provides a mechanism for kernel subsystems to safely access buffer
ring contents while ensuring the buffer ring remains valid. A pinned
buffer ring cannot be unregistered until explicitly unpinned. On the
userspace side, trying to unregister a pinned buffer will return -EBUSY.
Pinning an already-pinned bufring is acceptable and returns 0.

The API accepts a "struct io_ring_ctx *ctx" rather than a cmd pointer,
as the buffer ring may need to be unpinned in contexts where a cmd is
not readily available.

This is a preparatory change for upcoming fuse usage of kernel-managed
buffer rings. It is necessary for fuse to pin the buffer ring because
fuse may need to select a buffer in atomic contexts, which it can only
do so by using the underlying buffer list pointer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/buf.h | 28 +++++++++++++++++++++++
 io_uring/kbuf.c              | 43 ++++++++++++++++++++++++++++++++++++
 io_uring/kbuf.h              |  5 +++++
 3 files changed, 76 insertions(+)
 create mode 100644 include/linux/io_uring/buf.h

diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
new file mode 100644
index 000000000000..7a1cf197434d
--- /dev/null
+++ b/include/linux/io_uring/buf.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_IO_URING_BUF_H
+#define _LINUX_IO_URING_BUF_H
+
+#include <linux/io_uring_types.h>
+
+#if defined(CONFIG_IO_URING)
+int io_uring_buf_ring_pin(struct io_ring_ctx *ctx, unsigned buf_group,
+			  unsigned issue_flags, struct io_buffer_list **bl);
+int io_uring_buf_ring_unpin(struct io_ring_ctx *ctx, unsigned buf_group,
+			    unsigned issue_flags);
+#else
+static inline int io_uring_buf_ring_pin(struct io_ring_ctx *ctx,
+					unsigned buf_group,
+					unsigned issue_flags,
+					struct io_buffer_list **bl);
+{
+	return -EOPNOTSUPP;
+}
+static inline int io_uring_buf_ring_unpin(struct io_ring_ctx *ctx,
+					  unsigned buf_group,
+					  unsigned issue_flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_IO_URING */
+
+#endif /* _LINUX_IO_URING_BUF_H */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 00ab17a034b5..ddda1338e652 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -9,6 +9,7 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
+#include <linux/io_uring/buf.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -237,6 +238,46 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 	return sel;
 }
 
+int io_uring_buf_ring_pin(struct io_ring_ctx *ctx, unsigned buf_group,
+			  unsigned issue_flags, struct io_buffer_list **bl)
+{
+	struct io_buffer_list *buffer_list;
+	int ret = -EINVAL;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	buffer_list = io_buffer_get_list(ctx, buf_group);
+	if (likely(buffer_list) && (buffer_list->flags & IOBL_BUF_RING)) {
+		buffer_list->flags |= IOBL_PINNED;
+		ret = 0;
+		*bl = buffer_list;
+	}
+
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_buf_ring_pin);
+
+int io_uring_buf_ring_unpin(struct io_ring_ctx *ctx, unsigned buf_group,
+			    unsigned issue_flags)
+{
+	struct io_buffer_list *bl;
+	int ret = -EINVAL;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+	if (likely(bl) && (bl->flags & IOBL_BUF_RING) &&
+	    (bl->flags & IOBL_PINNED)) {
+		bl->flags &= ~IOBL_PINNED;
+		ret = 0;
+	}
+
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_buf_ring_unpin);
+
 /* cap it at a reasonable 256, will be one page even for 4K */
 #define PEEK_MAX_IMPORT		256
 
@@ -743,6 +784,8 @@ int io_unregister_buf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		return -ENOENT;
 	if (!(bl->flags & IOBL_BUF_RING))
 		return -EINVAL;
+	if (bl->flags & IOBL_PINNED)
+		return -EBUSY;
 
 	scoped_guard(mutex, &ctx->mmap_lock)
 		xa_erase(&ctx->io_bl_xa, bl->bgid);
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 11d165888b8e..781630c2cc10 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -12,6 +12,11 @@ enum {
 	IOBL_INC		= 2,
 	/* buffers are kernel managed */
 	IOBL_KERNEL_MANAGED	= 4,
+	/*
+	 * buffer ring is pinned and cannot be unregistered by userspace until
+	 * it has been unpinned
+	 */
+	IOBL_PINNED		= 8,
 };
 
 struct io_buffer_list {
-- 
2.47.3


