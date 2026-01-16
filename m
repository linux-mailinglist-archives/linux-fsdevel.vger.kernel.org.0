Return-Path: <linux-fsdevel+bounces-74254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6CD38A18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA2E93068BAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F7320A34;
	Fri, 16 Jan 2026 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig5LbdZM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F9322B90
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606273; cv=none; b=DO1oZhITa0JkbXY2Tp5yTSeKSIw7LDW0xJgHTvl6vzRP4lO8L+o/LA/+gzvAeOKm+WeRQjbPPs2Qws49PNTBPz8/tfn61H3FT4BgMmQX1K+4qr6dcak7niutf81bJwxChjoo6/j9J87FuM10PrCwe4rSA5iQ8Uae5hpc3e7abcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606273; c=relaxed/simple;
	bh=1W2QlU/drgTCR8vDo6sf+b6pICaRNHXTsmuWU7JfLLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeGpGvOuLiULmhhv+FxJcGpXdhfQmZPpuiM2x/J7Oc2QMs+aufxMC6Q0t6Daz/VJMi2OhatssN4snf+cI8/yst1hTFjTs84U+CYd24lJvnjQImTggl8WYrFB1ZNISsfCyAJJajxxIeoWyw3J/UTwmhRUyQmtcrfdttMojlqOI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig5LbdZM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1576442b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606271; x=1769211071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKHlE5apGJL1qOx1MKXlzZmVTshm144wxJdFcI1s+nU=;
        b=ig5LbdZMNzammQPrLRJw9Jgr1/U1rwSqoZCaDYE4uwvW8OEhxdaheqz2UN0iEJLwxH
         Ny8+WWL+aPOvVcCKV1l9MF04+ff8pqC2yITOcghfdG9aWVCgRct4yFXa7xVVCsTYug6f
         PGw7Se/qkADe7uNT1QSwg0+ny4Ew5WIaOTG6lfLHeR63hEK7FrZJcHkKd5ZEMm3IKfEl
         J2U7Sbej9sLYZ1S+uZzKI4U1k3OIUV8hSv2LW2JfnpuZg1eYF8NNWqM/ebulI1B3byZh
         FUHu4gJbP82pq1+07JkYLwqCc1KNiIwhPtXMdNMHMe7bcuWoYfc5Ihl7+9iYJ8/xMldM
         NOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606271; x=1769211071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKHlE5apGJL1qOx1MKXlzZmVTshm144wxJdFcI1s+nU=;
        b=j9YyhYv8ZG3EI8Y70nah3ZTVd5gik1H0DcUIBwnLLQvZwQ/BE4sDd6i3Gwy6mwwz8e
         Joq4qjKeZJWEIPPQTxLVLfX3MM9I37kAMDyZ7FGlMArePrUz/AB1LfRlWMW/fUZ5wAyV
         W/TwK886uxgKlnfZyJcI9MLhD+cqkueB8dsCgS8xlaoRzUUqstYGFlDM1pw6BNN/626h
         BzHNe3/i2jSQX1SQy10JnZ+fNRlkUGHJBFEzSqek+JNORM4YkywNvTsUulmaHuqoNPGh
         DcI+BxFrpduv8413sPu+uoGfI+ITKENVpdeNfACAFwcjXpEkYLk4SGN+RaXPdrvDLrrH
         waDw==
X-Forwarded-Encrypted: i=1; AJvYcCW7Myv6FOoj4+RM48Zsknih+FYObALm7p64taelQY3CSbfOZYb3u5GxCmaI4ydq4YyoXeCA455TcwHEzxiO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4RbczUUzBirbpxh8EW6LpZFqHOdYi7mN3MfUj5a+00u8v3ZQ
	tgGXlFtJQWanM9EnHcztkE9Up+wAptZyA3XQmVlko/+pL1eLtqYb4Qfe
X-Gm-Gg: AY/fxX4eMSYivQlDBnDTxTLhWFBbRUvpRpPIwd+PXn2Xm7QutaOwOgodiCa1ZJUKgWu
	VjUIq6KrVjXXkyr587OBcpHHSuL2VB8eHwCl60QUrPUIWjn1nB8olVJyB2ks1pU/6uzbHCi3BL8
	LOHCJZNNhDo9H8QFaALBrD6dmzTJaSUIqB/XvKkAnb4+XMJaz3BJEMPFY4p0RrWDBt6Mbk7G3MQ
	8jBGZhpVSJjB3/g3DhJX6EAOCmm5Dv964B8GNgQVU0YRRa2PnDvy8v6wws6XuW26Nu4FT9Kk8J6
	zykPvbJYiTsCexV2KozZ+3gAP9+FeZ+2YlGqRlpR1+uDsxUcFnXssSFSC2H35cCV3nKNRr3DFBC
	zgObSGRsRhxmtfmUQQAikieHO1x4cFqTaVRT1Lrh8V6xw4mT1YdthWjt/tmxhg9ewIFBvHwZ6gi
	80iALtJw==
X-Received: by 2002:a05:6a00:2496:b0:81d:a1b1:731b with SMTP id d2e1a72fcca58-81fa17923b9mr3129626b3a.19.1768606271368;
        Fri, 16 Jan 2026 15:31:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291d29sm2924245b3a.53.2026.01.16.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:11 -0800 (PST)
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
Subject: [PATCH v4 05/25] io_uring/kbuf: support kernel-managed buffer rings in buffer selection
Date: Fri, 16 Jan 2026 15:30:24 -0800
Message-ID: <20260116233044.1532965-6-joannelkoong@gmail.com>
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

Allow kernel-managed buffers to be selected. This requires modifying the
io_br_sel struct to separate the fields for address and val, since a
kernel address cannot be distinguished from a negative val when error
checking.

Auto-commit any selected kernel-managed buffer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring_types.h |  8 ++++----
 io_uring/kbuf.c                | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index a3e8ddc9b380..0b8880cdda8b 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -93,13 +93,13 @@ struct io_mapped_region {
  */
 struct io_br_sel {
 	struct io_buffer_list *buf_list;
-	/*
-	 * Some selection parts return the user address, others return an error.
-	 */
 	union {
+		/* for classic/ring provided buffers */
 		void __user *addr;
-		ssize_t val;
+		/* for kernel-managed buffers */
+		void *kaddr;
 	};
+	ssize_t val;
 };
 
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 68469efe5552..d9bdb2be5f13 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -155,7 +155,8 @@ static int io_provided_buffers_select(struct io_kiocb *req, size_t *len,
 	return 1;
 }
 
-static bool io_should_commit(struct io_kiocb *req, unsigned int issue_flags)
+static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list *bl,
+			     unsigned int issue_flags)
 {
 	/*
 	* If we came in unlocked, we have no choice but to consume the
@@ -170,7 +171,11 @@ static bool io_should_commit(struct io_kiocb *req, unsigned int issue_flags)
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return true;
 
-	/* uring_cmd commits kbuf upfront, no need to auto-commit */
+	/* kernel-managed buffers are auto-committed */
+	if (bl->flags & IOBL_KERNEL_MANAGED)
+		return true;
+
+	/* multishot uring_cmd commits kbuf upfront, no need to auto-commit */
 	if (!io_file_can_poll(req) && req->opcode != IORING_OP_URING_CMD)
 		return true;
 	return false;
@@ -200,9 +205,12 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->flags |= REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
 	req->buf_index = READ_ONCE(buf->bid);
 	sel.buf_list = bl;
-	sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
+	if (bl->flags & IOBL_KERNEL_MANAGED)
+		sel.kaddr = (void *)(uintptr_t)READ_ONCE(buf->addr);
+	else
+		sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
 
-	if (io_should_commit(req, issue_flags)) {
+	if (io_should_commit(req, bl, issue_flags)) {
 		io_kbuf_commit(req, sel.buf_list, *len, 1);
 		sel.buf_list = NULL;
 	}
-- 
2.47.3


