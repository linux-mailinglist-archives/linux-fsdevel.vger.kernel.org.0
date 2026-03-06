Return-Path: <linux-fsdevel+bounces-79553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO3lEOUgqmn2LgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:33:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B181F219D87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 01:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E8F300AB34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 00:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03F2D5936;
	Fri,  6 Mar 2026 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxeMGG98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A082D73BE
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757194; cv=none; b=HlS50ISDo2XPRcP5cm/C7tp+a4f9WEfvv0JKrTdG/VmzzYi973tIg1lj5XI6KVbkhq0GvIraZC8umyITmIgCaHGKRndp8lPZskRrit8v71mERMeUE+Z1xrT78dvqUOsda1wXh7Y7v/8kq0nI0FE31KfuMJ8ymmb0qR40KJMOyf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757194; c=relaxed/simple;
	bh=GrymZDT9pLtXsqqjazlOi5yMRDaQbd/loo7fZVtiQYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+P4/lQQmtmWJ/hRF3MHDrMQ7i7KuF/A/dJh9H67/QsVKR4yjpaHCcF5wA3HPDhulP4LlE8JUd4/UkELwlKXXz4brgsCBBP0+jMe8NU09FoTWQI5MomEllnKiXitb/BINW9EvgOxlKZAR9+0Xv6rl6COdg2gfV1cRQqvM56JYnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxeMGG98; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso23395085ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757191; x=1773361991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om5vgKmfeNLQBHE27BvGOiWbw/O97SAxX/nYgvgthhM=;
        b=SxeMGG982MjycL7jpBsv2rCjPquDi6mRVSCpNJg2g8wTYO9dvZRgHjMPMyjjvyagTk
         UMT/7l7a1dApREaEwj+BPm6c0sn7aY6FbwqGiHPX7vR0a4q6D90IxuBQtfrD+jCXR9KL
         xGC6l5qxifoPupYnGOmLixTgxF+6K2TsQmCuBbTGDwNGT7DekcSSejHfLdfQJozDQB93
         MYcKxeAfC8FxqmyQsHZIqEQSTG2Ye/OaRA/6ybIjFdiSsyEscJJ3Prz86278T8vFKTtQ
         I7mtIWGgn+Yub5a/orfBC/zjc6aSjN0mYvN6xlM13oBU3Sc82TCX2pGRo+7bcssZbLu8
         xkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757191; x=1773361991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Om5vgKmfeNLQBHE27BvGOiWbw/O97SAxX/nYgvgthhM=;
        b=Rt4/9jQxzL/M60E3d2182yW8MSqjJ26I3Ma2wv1NGn0FM0mxjp3X54+ljuBSgA2nsk
         BH1Bn41l01qubwvWb904is9VnoCAfkNxoSSM57EaDqD3dZ2gHfakiaPGTrvZNRdaPqxp
         AybAN8ZLl76dMtrUBHuMslq9RR7zUPjoIajYA3klxk0OCyOwvKqgwwAl16vOgKqeqIHk
         CYx8SK/zN3zK2k8ycRPbZvm3e6El8w42rMd9mSlvsM6agKKg1qMTmOiNMN7w1JLeqWei
         7BXFNoFIl3YHyHny9qmUqF40Btvuzf6XU9upNCwSHTglAOFlZoWa9WdjyhlPlvyuOvA8
         qlbw==
X-Forwarded-Encrypted: i=1; AJvYcCWECLauZtIwTaDNqBLOPvu4xFjoqWRjJagQ/8XLAM6PrMQlYhk8gKcnqdTqueJQcFXCNXAvDHrT7i1SANb0@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkrqRmdTF99IyxhXac+doUXHZU2XMYpXlKZnviRY1v6ZJMLuy
	iRqvKNeegtMd8/0rRRA1sW0alFASaJAnQIMbYWsL0XxRpXwlJ09j62Ki
X-Gm-Gg: ATEYQzzE1Y6YoRv16DdNJPHD3QfZn6cRakgMBJrqUIwep0nx8EdAS7c1WL2zzBVxyAH
	77+CfdCPjo06Rb6hkjNzc/wRlpOED1SA6zFgjVj112lgWBIa1kscwHWivHazHMwjJ8QnWMv9dkX
	7EO7tZHOJZZUHXM8zh1rgrZUfpGQZ5Z76DtJLX0lt0SUraM7zPs8df+0lOTjwSlGujwYiG5a06o
	81PzgXTH0pXYSGWMlxZbxHN23xoQas9j89sc6U8pbISe+z2z3qFJJ63q3JEglpi9PpnpCEiA1/V
	hXWnqzd/BRbjuJu1FrDafSRpAYMOLBM1Pj9Sc0A3nOYjbe7OJwN6tUi/5I2OHM1JK6NHmKCvG/I
	0VCz5mLMq/y0QqGaR1ZUk5ZdOGY9YkbdVdbsMw8tq/u/VbXvnR3VPVi1h9PfHtihvese4yVmZNh
	U3bXzkTQ/BRry+Tg+Z7Q==
X-Received: by 2002:a17:903:28c8:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2ae8252cf0fmr2066425ad.43.1772757190874;
        Thu, 05 Mar 2026 16:33:10 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae51bb9da6sm125105335ad.36.2026.03.05.16.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:33:10 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	asml.silence@gmail.com,
	bernd@bsbernd.com,
	csander@purestorage.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 3/8] io_uring/kbuf: add buffer ring pinning/unpinning
Date: Thu,  5 Mar 2026 16:32:19 -0800
Message-ID: <20260306003224.3620942-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306003224.3620942-1-joannelkoong@gmail.com>
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B181F219D87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79553-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,bsbernd.com,purestorage.com,suse.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
 include/linux/io_uring/cmd.h | 17 +++++++++++
 io_uring/kbuf.c              | 55 ++++++++++++++++++++++++++++++++++++
 io_uring/kbuf.h              |  5 ++++
 3 files changed, 77 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 331dcbefe72f..7ce36e143285 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -91,6 +91,10 @@ struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
 bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 				 struct io_br_sel *sel, unsigned int issue_flags);
 
+int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group,
+			  unsigned issue_flags, struct io_buffer_list **out_bl);
+int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_group,
+			    unsigned issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -133,6 +137,19 @@ static inline bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
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
index 13b80c667881..cb2d3bbdca67 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -9,6 +9,7 @@
 #include <linux/poll.h>
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
+#include <linux/io_uring/cmd.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -237,6 +238,58 @@ struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
 	return sel;
 }
 
+int io_uring_buf_ring_pin(struct io_uring_cmd *cmd, unsigned buf_group,
+			  unsigned issue_flags, struct io_buffer_list **out_bl)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_buffer_list *bl;
+	int ret = -EINVAL;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+	if (!bl || !(bl->flags & IOBL_BUF_RING))
+		goto err;
+
+	if (unlikely(bl->flags & IOBL_PINNED)) {
+		ret = -EALREADY;
+		goto err;
+	}
+
+	bl->flags |= IOBL_PINNED;
+	ret = 0;
+	*out_bl = bl;
+err:
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_buf_ring_pin);
+
+int io_uring_buf_ring_unpin(struct io_uring_cmd *cmd, unsigned buf_group,
+			    unsigned issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_buffer_list *bl;
+	unsigned int required_flags;
+	int ret = -EINVAL;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+	if (!bl)
+		goto err;
+
+	required_flags = IOBL_BUF_RING | IOBL_PINNED;
+	if ((bl->flags & required_flags) == required_flags) {
+		bl->flags &= ~IOBL_PINNED;
+		ret = 0;
+	}
+err:
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_buf_ring_unpin);
+
 /* cap it at a reasonable 256, will be one page even for 4K */
 #define PEEK_MAX_IMPORT		256
 
@@ -768,6 +821,8 @@ int io_unregister_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		return -ENOENT;
 	if (!(bl->flags & IOBL_BUF_RING))
 		return -EINVAL;
+	if (bl->flags & IOBL_PINNED)
+		return -EBUSY;
 
 	scoped_guard(mutex, &ctx->mmap_lock)
 		xa_erase(&ctx->io_bl_xa, bl->bgid);
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 38dd5fe6716e..006e8a73a117 100644
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


