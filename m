Return-Path: <linux-fsdevel+bounces-70502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C1C9D69B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B31834AF8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792BA2153EA;
	Wed,  3 Dec 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECzkRAF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909423184A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722203; cv=none; b=PekN6bpy9QDiYdkREUOt/Yo9zQZG9pXXuUWUtJcmoGfO7Kfhm0J7nxWsZUuaCP189Wq10Gmp/81NmUveIBKw7B6iL4Z6GpgK0WqC4Zzu28BEpcea+7ph0CwzpUT56L1pjuZPZRawOWXDujtwZ/ATF5fOyqzI8fvXo85D9pX9y70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722203; c=relaxed/simple;
	bh=9RyemEm3xlDvo1zuttIsC6bydxv6sxwCp3aNwuaC0sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOeQYPRmXF3tRr+6xGT0b20Gzavgo4JTSVAyfEOjZQMJOpsqDfpcHnPGP9K3/ZeaTPBT+BTYV+3hlwgjrZP+N+wJNc7qUPgEX7vKbSjeIcNltq6Mzsq0mT0NE88LWwl+r/dy2FQJgsTu8wgw5/O6NH4zf2tFu9ASqYMZecppGmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECzkRAF/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29555b384acso68414725ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722202; x=1765327002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnYyEzTSEPVl4kDponzZw4cGyFS7cP/hmTM+WADvqAs=;
        b=ECzkRAF/GTmg80KlsRHVO+Y1QtsT1Xj3E+3sKSRu9eKIs+BVc/4BpXlhQ3uEDv7Ct2
         tJtpgS5HhoN/tjU1D7mFDTt8RqLyJqa7EoULR0pZZPmKW8L2GjZ8vDJpjUK2qcuBkTDO
         0ISszCvMEZ3YwIJX64AO1BPt+FsaJCC26+wbT53kao/sIb5BVmeNg16OU5sky7A+K5C7
         TaXT9g7baUHd+nNHkM+P1TzDCKZjq3FDGZS2U7wJgQIZgYVWNCQUrgss/LbKvfPFkTNh
         ud6AoQdT/fOxI05/uzofSs9oMITrL6HsyZZMtYU4tHF0RcHAVh22JTUUSk/Pae5vnW4Q
         02BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722202; x=1765327002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XnYyEzTSEPVl4kDponzZw4cGyFS7cP/hmTM+WADvqAs=;
        b=VZTgw+woXFOilOko5B5e9O+YDy2YtMPIaxQpyHTEGknYGejTGpEF19hqTuPbtC+ROg
         VlTw+fYQNdTpfwtgkdV9tSojf4mVNTT+NGpP8jAZHHPZnGCfQ73SNPRAaID9xIxc3NQF
         97BNflLKWGOO4rhwTrPX8WpjtSu67dny9xV8Z3AWwQLodJfGhjnhrue/SuI1nmRP71Bn
         Pu1LcgL1tcRjsNnbGxne/04gGkG8S7jBYjC3bC3BkqkpKcUs1va/QbNUDe5AGqAJm47a
         aGTPw2ULCZm1cYxNnt02sM+HYdx7rRkSalTY/23lrtMK3Z+0CCvN67Up4XYiKmLRKjeo
         cuJw==
X-Forwarded-Encrypted: i=1; AJvYcCVr2Q6cHZtxJOK2U2QtOSUr9GbnIrXWGXSDPEyTk5mUy+R5xaqNEVejgNOaDvJLMXvTtYnrTAqCoriPXgYD@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEnT3WpEXQTx5pcF7AJRoGjHa2o2dFFPsR+tUt90frnVWP9Pb
	XizjopCyRn2dxhDU9/faAdLdwmcSolNqz7KZEMe4fuGnUv8N+ut2LKZDvbcgkQ==
X-Gm-Gg: ASbGncvCsejo9QFYlQDvRyfaD0bxDtkLfzcB2OHLSaNViHNCsZ8d9w66LkeD/FQ3sVL
	9gxXUr+/7QSml5uooucLdGBUHVscy1rlfZXirdk8pYinM741jMIbI45kI9TG6vxgCbNG3CW4BVz
	4dCHNITBqaAvaHm4WBNjwmz+cphfSjZCyF4H6JB4/1t3xv+wNB8wseN90LMjQjzniiq06D7Si3C
	PxNQjyGQJNyb8q69CuGYIImnMkZcuX+VNoOHi6vkHmJ6SAOcEsCbDVE7HPGC9QqMSdVGrmYXLJf
	tJwDbVGWgonhZ7OAFLUtsPAZyk1SXtNjZqNhCCx7Xf3awA5oZ78KAh3kg0WN2MI+ldkuThi8Duy
	9FNkKT2otMf19uvrt2xFPX0SGx6/A4uDaeJWHjXMnnIJOPLTSrO1rVbFMOM19IuCAik9XUO+b4t
	g63DNBXGKRNoVg/KLk
X-Google-Smtp-Source: AGHT+IEYCenSCuDNaBs0yLpejZ7XuLQ+z5/+esIlGpOR9el8oQZ0YbzBwDMOmjrUoigOr4hSbRx31w==
X-Received: by 2002:a17:903:1a30:b0:298:8a9:766a with SMTP id d9443c01a7336-29d683e6e7amr5342125ad.53.1764722201645;
        Tue, 02 Dec 2025 16:36:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40acbbsm169826115ad.11.2025.12.02.16.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:41 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 08/30] io_uring/kbuf: add recycling for pinned kernel managed buffer rings
Date: Tue,  2 Dec 2025 16:35:03 -0800
Message-ID: <20251203003526.2889477-9-joannelkoong@gmail.com>
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

Add an interface for buffers to be recycled back into a pinned
kernel-managed buffer ring. This requires the caller to synchronize
recycling and selecting.

This is a preparatory patch for fuse io-uring, which requires buffers to
be recycled without contending for the uring mutex, as the buffer may
need to be selected/recycled in an atomic context.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/buf.h | 10 ++++++++++
 io_uring/kbuf.c              | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
index c997c01c24c4..839c5a0b3bf3 100644
--- a/include/linux/io_uring/buf.h
+++ b/include/linux/io_uring/buf.h
@@ -12,6 +12,10 @@ int io_uring_buf_ring_unpin(struct io_ring_ctx *ctx, unsigned buf_group,
 
 int io_uring_buf_table_pin(struct io_ring_ctx *ctx, unsigned issue_flags);
 int io_uring_buf_table_unpin(struct io_ring_ctx *ctx, unsigned issue_flags);
+
+int io_uring_kmbuf_recycle_pinned(struct io_kiocb *req,
+				  struct io_buffer_list *bl, u64 addr,
+				  unsigned int len, unsigned int bid);
 #else
 static inline int io_uring_buf_ring_pin(struct io_ring_ctx *ctx,
 					unsigned buf_group,
@@ -36,6 +40,12 @@ static inline int io_uring_buf_table_unpin(struct io_ring_ctx *ctx,
 {
 	return -EOPNOTSUPP;
 }
+int io_uring_kmbuf_recycle_pinned(struct io_kiocb *req,
+				  struct io_buffer_list *bl, u64 addr,
+				  unsigned int len, unsigned int bid)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IO_URING */
 
 #endif /* _LINUX_IO_URING_BUF_H */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index ddda1338e652..82a4c550633d 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -102,6 +102,39 @@ void io_kbuf_drop_legacy(struct io_kiocb *req)
 	req->kbuf = NULL;
 }
 
+/* The caller is responsible for synchronizing recycling and selection */
+int io_uring_kmbuf_recycle_pinned(struct io_kiocb *req,
+				  struct io_buffer_list *bl, u64 addr,
+				  unsigned int len, unsigned int bid)
+{
+	struct io_uring_buf *buf;
+	struct io_uring_buf_ring *br;
+
+	if (WARN_ON_ONCE(req->flags & REQ_F_BUFFERS_COMMIT) ||
+	    WARN_ON_ONCE(!(bl->flags & IOBL_PINNED)) ||
+	    WARN_ON_ONCE(!(bl->flags & IOBL_BUF_RING)) ||
+	    WARN_ON_ONCE(!(bl->flags & IOBL_KERNEL_MANAGED)))
+		return -EINVAL;
+
+	br = bl->buf_ring;
+
+	if (WARN_ON_ONCE((br->tail - bl->head) >= bl->nr_entries))
+		return -EINVAL;
+
+	buf = &br->bufs[(br->tail) & bl->mask];
+
+	buf->addr = addr;
+	buf->len = len;
+	buf->bid = bid;
+
+	req->flags &= ~REQ_F_BUFFER_RING;
+
+	br->tail++;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(io_uring_kmbuf_recycle_pinned);
+
 bool io_kbuf_recycle_legacy(struct io_kiocb *req, unsigned issue_flags)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-- 
2.47.3


