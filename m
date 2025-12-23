Return-Path: <linux-fsdevel+bounces-71894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8249CD77F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0C8B3009B5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ADD2B9A4;
	Tue, 23 Dec 2025 00:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db5aKKlv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BD51FCF41
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450197; cv=none; b=hU3+Wbv8c7tCnwK9365ffgRrueZni9fLWBjOQHkOD9Cvw9ZzlL1wA9EF7q1fZPv0Ceb6jrIoKIkzm3byLsv0wHxsCDCbTtqubGvjJ7NadQPNXKlW9laIG8uGe/InUXOTMVnFI5KvpTH56eAxO+Q+ouRg06ahRIOnKiNj2qhMMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450197; c=relaxed/simple;
	bh=HuX7Fp1kQvS5+9jqwRIESTuJ4c7EJm2lu8/5dMMcR/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNfzD+z3f2jZk7ELp5SDl7PP9indDmHRZttcLabuOAYl5fkdnsljVRgFlYYqFU+pJvZKvlItm3zrr+4xksp7pYnv9znasYBj5X2+zFQx08lwLDxa0m9v7Gyob6SOcCvpgWkbfuZYu3pktKHhs3fr6hDi0PgVw9Hjm0YjXkH6wpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db5aKKlv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a137692691so52087505ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450195; x=1767054995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05FjmTfkSMR2IxEZMf3kZcvKZ7phCksVi0KMcuf7LKQ=;
        b=Db5aKKlvwBZmOMUq/vFOQwc1aLJhRBLD7VX7Bv2FzmUS7XX6ESlal9pjY7PQmb5w4p
         e+gNSTkg1LgWg2Acw62K17xyLQ6TIcEJYzhQo1u8/cm/n1n8c19/cxrxlS9S2dHO1sbZ
         aVTn0S1FYqBMP5VYY65HjjQyQqUDVI3AYAzeikc+UwSL/U6T3bmZcEQ8H5y2tnhEzRlW
         0jBnZ91eN3UHGgq50pU31iaTGZMa/TwBQC3x4n953scVtEfEhZW5n9ga7p7eqHoTD6yj
         X5YC1RirTs5I1ca5u11qoOa+w3Z5/VEC9dIqN66pskhp3wUoIK9rSYuRm5Bl0j5eldhc
         LYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450195; x=1767054995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05FjmTfkSMR2IxEZMf3kZcvKZ7phCksVi0KMcuf7LKQ=;
        b=TF+c5iZb6rBSYweWm2flt/6z0enEo5ZQETQ3TOzzlVGHt1cpySuhP7DJ7VbCA/ercL
         XPYCob9N6aBLUUt62Phj2ZBd1i5j1WxGH4iH3HRZTLm4P2LaIdm0u7EXlSQsOaq5AhLG
         OPY3Xl6uJOPyDOTVnAmI8hBxSuKORYnWlanQ33P9lgyg8hj8CrDWPwRhjBLFsmNfq6Vp
         uMpvisA44hy1P1Db9TDyCmwiRWi4KJivEql9VD9KiJPwNXL9XPBOUXRRl0RbfO2wgaJA
         f0pBgKHLLR2KX1yY484cSMtQDXEZLcttDEDSdTQsmZ6ANUvqYL9AsmrSXKRy/KrTEcuy
         xApQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9V+c8LffzMecYqL60kj4GG0zJWh4we4wcM1JTafamqzq0qTX5Lh1MR8/F80gnWfuNechhmeSiuu0pV6rs@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7BnVv0NveJE0347JeHQZuKGqRHLV8cgLpWzJ+U3yy6whAN9y
	qiVzL+Um8bBL99Q0sdMfjctj4PqJ4kmzCDVvexmQDUcB3FI8g8oeEanO
X-Gm-Gg: AY/fxX7T3u6QD+WvSRDd7xOw6WIDhnk8uZrItL0w/xsYfQCA/ZmH/dj9JLq5IeO+n7H
	phvr5VEZCoT8dTweHsuE9xGy2PSd/tuD5zv6ERvw2Z1quN9jrfZu2kg/0fsYSx7xKD/bvkd2E++
	FURj/04T+kGXztjwni1Lfz1saPsVF+pKqTAjbxCWSHiav6Q41lt0WP/9yA2yPXXEUEcQrjfQSAF
	aBnFbpR2WyvGbmz8pJj90b+rdtX/LOluP0ZEMVaGQw5/1vSFevzTagzPVuZKyBUqysVhubWolBo
	yJOHARDvDXAmr5nlrwcDTjo83I3tU63w8AE+lwZAI3HHy7Ema5w+JxwJ/GQYmeQ58i6pZAjyAyQ
	OpguieYjoLFBU4vbAA8xe4jpp+87x0Pqp/lv/6jqj6X1oZN7Inm0iHq1AT9aD/6djvpN6pC7nsG
	WnGJg3xzyIxkQSEubIYA==
X-Google-Smtp-Source: AGHT+IEmGhlUTNg7urRDoZvMzlPQrU8SjSvVjEpf+MtwlwMSrACuurcsGMG8JMoB4Sd3EfH9n/DU9Q==
X-Received: by 2002:a17:903:234c:b0:2a0:b7d3:eec5 with SMTP id d9443c01a7336-2a2f2736de4mr117128745ad.33.1766450194977;
        Mon, 22 Dec 2025 16:36:34 -0800 (PST)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82a9asm109453205ad.30.2025.12.22.16.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:34 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 06/25] io_uring/kbuf: add buffer ring pinning/unpinning
Date: Mon, 22 Dec 2025 16:35:03 -0800
Message-ID: <20251223003522.3055912-7-joannelkoong@gmail.com>
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

Add kernel APIs to pin and unpin buffer rings, preventing userspace from
unregistering a buffer ring while it is pinned by the kernel.

This provides a mechanism for kernel subsystems to safely access buffer
ring contents while ensuring the buffer ring remains valid. A pinned
buffer ring cannot be unregistered until explicitly unpinned. On the
userspace side, trying to unregister a pinned buffer will return -EBUSY.

This is a preparatory change for upcoming fuse usage of kernel-managed
buffer rings. It is necessary for fuse to pin the buffer ring because
fuse may need to select a buffer in atomic contexts, which it can only
do so by using the underlying buffer list pointer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 17 +++++++++++++
 io_uring/kbuf.c              | 46 ++++++++++++++++++++++++++++++++++++
 io_uring/kbuf.h              | 10 ++++++++
 io_uring/uring_cmd.c         | 18 ++++++++++++++
 4 files changed, 91 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 375fd048c4cb..424f071f42e5 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -84,6 +84,10 @@ struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
 bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 				 struct io_br_sel *sel, unsigned int issue_flags);
 
+int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *ioucmd, unsigned buf_group,
+			      unsigned issue_flags, struct io_buffer_list **bl);
+int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *ioucmd, unsigned buf_group,
+				unsigned issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -126,6 +130,19 @@ static inline bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 {
 	return true;
 }
+static inline int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *ioucmd,
+					    unsigned buf_group,
+					    unsigned issue_flags,
+					    struct io_buffer_list **bl)
+{
+	return -EOPNOTSUPP;
+}
+static inline int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *ioucmd,
+					      unsigned buf_group,
+					      unsigned issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 8f63924bc9f7..03e05bab023a 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -238,6 +238,50 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 	return sel;
 }
 
+int io_kbuf_ring_pin(struct io_kiocb *req, unsigned buf_group,
+		     unsigned issue_flags, struct io_buffer_list **bl)
+{
+	struct io_buffer_list *buffer_list;
+	struct io_ring_ctx *ctx = req->ctx;
+	int ret = -EINVAL;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	buffer_list = io_buffer_get_list(ctx, buf_group);
+	if (likely(buffer_list) && likely(buffer_list->flags & IOBL_BUF_RING)) {
+		if (unlikely(buffer_list->flags & IOBL_PINNED)) {
+			ret = -EALREADY;
+		} else {
+			buffer_list->flags |= IOBL_PINNED;
+			ret = 0;
+			*bl = buffer_list;
+		}
+	}
+
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+
+int io_kbuf_ring_unpin(struct io_kiocb *req, unsigned buf_group,
+		       unsigned issue_flags)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_buffer_list *bl;
+	int ret = -EINVAL;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+	if (likely(bl) && likely(bl->flags & IOBL_BUF_RING) &&
+	    likely(bl->flags & IOBL_PINNED)) {
+		bl->flags &= ~IOBL_PINNED;
+		ret = 0;
+	}
+
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+
 /* cap it at a reasonable 256, will be one page even for 4K */
 #define PEEK_MAX_IMPORT		256
 
@@ -744,6 +788,8 @@ int io_unregister_buf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		return -ENOENT;
 	if (!(bl->flags & IOBL_BUF_RING))
 		return -EINVAL;
+	if (bl->flags & IOBL_PINNED)
+		return -EBUSY;
 
 	scoped_guard(mutex, &ctx->mmap_lock)
 		xa_erase(&ctx->io_bl_xa, bl->bgid);
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 11d165888b8e..c4368f35cf11 100644
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
@@ -136,4 +141,9 @@ static inline unsigned int io_put_kbufs(struct io_kiocb *req, int len,
 		return 0;
 	return __io_put_kbufs(req, bl, len, nbufs);
 }
+
+int io_kbuf_ring_pin(struct io_kiocb *req, unsigned buf_group,
+		     unsigned issue_flags, struct io_buffer_list **bl);
+int io_kbuf_ring_unpin(struct io_kiocb *req, unsigned buf_group,
+		       unsigned issue_flags);
 #endif
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 197474911f04..8ac79ead4158 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -398,3 +398,21 @@ bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 	return true;
 }
 EXPORT_SYMBOL_GPL(io_uring_mshot_cmd_post_cqe);
+
+int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *ioucmd, unsigned buf_group,
+			      unsigned issue_flags, struct io_buffer_list **bl)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	return io_kbuf_ring_pin(req, buf_group, issue_flags, bl);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_buf_ring_pin);
+
+int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *ioucmd, unsigned buf_group,
+				unsigned issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	return io_kbuf_ring_unpin(req, buf_group, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_buf_ring_unpin);
-- 
2.47.3


