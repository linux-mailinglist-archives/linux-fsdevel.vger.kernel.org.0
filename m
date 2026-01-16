Return-Path: <linux-fsdevel+bounces-74255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE9D38A12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C27DB301D30A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4E326D4F;
	Fri, 16 Jan 2026 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COTU+o5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B83002D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606275; cv=none; b=frOHLYHEjQChwj81to5kJUfOrNP3c7fpfQimWekrZfIe1psf83lZ0bcFHcbGg0aA3uzw5R/u36SAUPNaIP3DIRhsDw0wMwnK1uR1lpcxCL0jjcFrg5JwirBo1qyCrXZamLqnnDqKVO48Cintmf3oV8gctbwga1ovIcCv2gLunhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606275; c=relaxed/simple;
	bh=k0eAhJDRXVC7dfOmvjoYjFkALeuOpZdfIZmyyrrTWS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRBuQU5Ec5MSz2iVkFHhez5WUnjWPWvvTQJ9pkdJ4Xp+XG3SqQlL9DztThOK8BSP5s5zX53g+0tFJKWwxwxPs4POZGnhhYFPcObxLkFxJYask27u7OFG7Gy8ZxDBxupOEPrvSSrb1YEWHf87uWGuZlTeLOVOtf9NrwAAya8+GCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COTU+o5r; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1462158a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606273; x=1769211073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZG58lf4bS9ax7y8bZNaH2oVovcBQ39ltWCqrr6mRY8=;
        b=COTU+o5rNYbCZ+ahZ8Z0zezYWBm4IplShYj+v0TlyTX6fLyEOxzVsUgTpygJ9EFTXt
         aJNpaB5blWS/26+DX/zdK9OPsaNJ7zRtJ9VuI7k0zlmi6JPKyBfw160KyPqdP6HxfDDL
         iOEfLh9ePUAwjll2V1I/PZhwx7yPzCQkPCNPIObi+XrwXeF6WXmFuv79OFBddEBL+OjR
         a+VdpNCf+tIl4JsszR25yNZ3kncE4uNLgQ+GvF2S6TahO3ktgGmP6+ioQtdGwC4F7ZBN
         RMLycHmXqB1gIE1vrrkSiVdr4wzOWBPs/iVkNDZtsx/p2aYdOJPRxxXIaTlu97YkvWk9
         owjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606274; x=1769211074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZG58lf4bS9ax7y8bZNaH2oVovcBQ39ltWCqrr6mRY8=;
        b=fN1G7S1IcS3BG2kYJ7N2EbX/ArzQs1SeIC5OXXFXZ9TcVYizxi/HijEjGJzClbDRvN
         UcfADqNwsKsiCBRHL9WuE3uQKTHPN9mljW03nvlbReAjWzjlx66Zo8NP2ml4TXzQCSt5
         FIhXSbTGK6o6DFhmEZuBDQqUb4K0Eq/IH3NrL29c8IPcA+mcyWzJFNNRqffq5Gm/r08L
         BJ64zfpU1ODigESvJHZBaKrIO2Zmz0MahImG/Y1uOyLOXqXvCstLWU73nsWu3ZaBjcJj
         4ICgVXC9K+G0bj6hGbxBfZUeCa33fJfU05iXS5yeCpiIMxqxxXkILnwTTtgX3AkXcV6G
         i5vA==
X-Forwarded-Encrypted: i=1; AJvYcCWuk/j66epnn+FN86heBzjnguPd5zu0UyfqSOAJzTspV1P/E5nrcSyeMTcUCpkOCMo9Pfl2oOxZ5E8UekEN@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFsiJR28hOEfTsaeo0ClyIRTDD+VfcXFoy3ltbjcioTR9d/OR
	Swj8rsz8whjQaTdl2o8VooxlFUHaZ8yWeLE9qIjl3L0fD2EqMfkbk7Ln
X-Gm-Gg: AY/fxX7EPZ7HwYt403me+MdI2uqXR35jfZtT43ZvMrWY6v6TFCIlQUd2HNxAew2NTS4
	21SFQaKfGGVf2bY6m8gFYPkuX8MYxmpGoFuQSKmsxsxFpEkzlzwZiotFPCxbMwYI7m0voreaiPz
	6y1fADgtPFWayRxUkjxpLenDRgpIqqomE4fjBBqR7idrgStDxNhTmoXYU8G/DIsUx6IcMPr8ZWm
	iWVM3E7Aua00szphFRygjLuBzjq38Q07WmZSnEGPyoUeOBdAS/9/OCAzwJMBUszeNfbI21dJKF0
	DRWzpoH+GLGCumLZrKLEIG0u+A208QhGLGQLjHyfXqvwxQNTWoK2O7VqSSmQ4wvGKrc1rbVt/oQ
	Ko1y1Im8RK1nGHWM1gI+e8HLRmZQ3OoGN/RmAEVSioWu1tIuo9+dw0RQEs5LMU41zvSXTlRiCGf
	pshTR+ZQ==
X-Received: by 2002:a05:6a20:258a:b0:334:a11e:6bed with SMTP id adf61e73a8af0-38e00c6a775mr4281888637.29.1768606273587;
        Fri, 16 Jan 2026 15:31:13 -0800 (PST)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf249bdcsm2832317a12.8.2026.01.16.15.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:13 -0800 (PST)
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
Subject: [PATCH v4 06/25] io_uring/kbuf: add buffer ring pinning/unpinning
Date: Fri, 16 Jan 2026 15:30:25 -0800
Message-ID: <20260116233044.1532965-7-joannelkoong@gmail.com>
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
 io_uring/kbuf.c              | 48 ++++++++++++++++++++++++++++++++++++
 io_uring/kbuf.h              |  5 ++++
 3 files changed, 70 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 375fd048c4cb..702b1903e6ee 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -84,6 +84,10 @@ struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
 bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 				 struct io_br_sel *sel, unsigned int issue_flags);
 
+int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group,
+			  unsigned issue_flags, struct io_buffer_list **bl);
+int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_group,
+			    unsigned issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -126,6 +130,19 @@ static inline bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 {
 	return true;
 }
+static inline int io_uring_buf_ring_pin(struct io_uring_cmd *cmd,
+					unsigned buf_group,
+					unsigned issue_flags,
+					struct io_buffer_list **bl)
+{
+	return -EOPNOTSUPP;
+}
+static inline int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd,
+					  unsigned buf_group,
+					  unsigned issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index d9bdb2be5f13..94ab23400721 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -9,6 +9,7 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
+#include <linux/io_uring/cmd.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -237,6 +238,51 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 	return sel;
 }
 
+int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group,
+			  unsigned issue_flags, struct io_buffer_list **bl)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_buffer_list *buffer_list;
+	int ret = -EINVAL;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	buffer_list = io_buffer_get_list(ctx, buf_group);
+	if (buffer_list && (buffer_list->flags & IOBL_BUF_RING)) {
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
+EXPORT_SYMBOL_GPL(io_uring_buf_ring_pin);
+
+int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_group,
+		       unsigned issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_buffer_list *bl;
+	int ret = -EINVAL;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+	if (bl && (bl->flags & IOBL_BUF_RING) && (bl->flags & IOBL_PINNED)) {
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
 
@@ -743,6 +789,8 @@ int io_unregister_buf_ring(struct io_ring_ctx *ctx, void __user *arg)
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


