Return-Path: <linux-fsdevel+bounces-69583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9010EC7E887
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AA73A52DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C2227F171;
	Sun, 23 Nov 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftiNcTx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7652641CA
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938305; cv=none; b=NKn5rpKDtp3Gh++LmraqVaQNwZURMDbVTI/6v+5JRLQ6eNYH8PsU9ShMd+nj2BObIKtcjyPu1QS+D4ZuWhkheErNsTsEi/luSytGuDY4q6GhK9EEHUiPwXQmNiwXryRP3C3OOYs+owooHhDOD1H0w4wZAJJQg97P5VXtrDYZVAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938305; c=relaxed/simple;
	bh=TaA27OxA1hBFyRB5sQEZB6XkCgdFpDueoKtHtp+vFGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjBZDDw24ZL5cXvQlrGzEdZfA+bVSFZkJstQyg/lPX2fQkBZlEdI752gwa6KqEBwBVeGcZwGGJmeiDUHQmwufYHqT44QB8+y9DyNn+5oE7VOyxQ3VoBzdN+rTh6kbqPKae51aw8UaC6QAKewUya2KmeU5pki/E8n9Z2FZickLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftiNcTx1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42bb288c219so3269564f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938301; x=1764543101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR8DhyhbmfM3XR45v/DX3VtwAUQ7pza2V3aAfSC4t8o=;
        b=ftiNcTx13YdP4WuIFjBYEQY9qh3Zw5EizPLOwUI0Oo29LmHJH65J9m5pF9tilsgK4R
         Rahz3xxfxLMMQwK14JXW532fLPTYPEwkK3ER1iCLC6qfx/26ECwO0Rv2iU494tZ7Nj+n
         kNNDxSdI9r705Qgcb7Msyeau1ATIy0ChwWxeIzgVQRW8cVAikB/9IKpzTRZmBmDB6vW6
         fkxIN2vlVHGp7KWT88WoGGAU7COpoAKtaSOaDVh5PRcaok/AAmVbDQqger9TwVxKz6/X
         Xn6IB6EtTFeqJLZ6w5szBwq5njjyzULzOsqBp2lw4WThiqTSW1xjDSUFxEnTbVJOKv58
         oC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938301; x=1764543101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PR8DhyhbmfM3XR45v/DX3VtwAUQ7pza2V3aAfSC4t8o=;
        b=Da7n+Ey528aCSu/TF1V6UFUMss2+yuQ7+ON+aLk5x2G7FetMa6CVdk/7ujE8PI9k2K
         4/B6ZBtg/HR0s6RX5t2a/s1CIOU6Qf42T+BSoTq5s6aqk6laI2ELe4ODtRNSgqFjKHyU
         yvyuwrOZZfpH+2raIY4xCsx2Zw4cLmEDUrh0FT9oR3mmFSi6a4Qz2bsFuKnt9ripKlRd
         TREPxGXy0gqc0fJVb4RBxTLCkPxS93i0kK1zQ+iM84C92ECDL8KF0RJj5cGRr06xjQjn
         uWlN2U/+AXqaExjt/Ts1O6w1wLoOkGOFzP8VQC5A5JqK902eoK++A2mj8iLr5rYVoMYE
         EjzA==
X-Forwarded-Encrypted: i=1; AJvYcCW6j2VCU7gmQbroWGofFGzp/4HA8F4dpo8//ElEItDT81Zn1Hnw3ScgQqVilKKm7d9f981kE/DqgkdOla1H@vger.kernel.org
X-Gm-Message-State: AOJu0YweXMSrbo80VI28zUMXo5vTkcLfbSn1hOIDSkgluhIQcRKUvodt
	+oISWABQRDn890iZRX2l5+eck2ID9eMjTHDrzkkKNKCAr0b63am9uBXv
X-Gm-Gg: ASbGncsFwxSRPnlfAtIP68/FcYMEkgi2EvCuNB1p2XZPRtUN1vqvUSlS7lDzr4j0AUp
	kKnXhgqVBsfCDh5PdEwANoiYtBYQj9g9Z89i50iVQhBOmsHrgflesX6eLavhEL9b8M1qMEzulz3
	4GKPSiJU005FCCBm9iOJXo1Hrk95B5PPgMKk53Z4Sgw6aB6DuDStHAkZ4qBfhERbZdMfgU5haeR
	V/oRIOE12BP1bGknIhfLRgkTsvMHYIlps69p5tclnM+Z07/D29EUnc/uH3diJxm/JxvpudKtBwW
	+jJKHkQIU1qcByMpoTnZaB2JRZJUk8W4HIwl58+IFsC230Yx6WY1vGLZSIQK/yokIUZbuJU6TOv
	GgSx7L7L+eLzDI5X/sGSJWc/kpaOLix2dV4wJjOt1SNEa1yvxSC8b0+EF3FRKxg1sQpbsyDOZGx
	9jrul9K1GY6Q6JlA==
X-Google-Smtp-Source: AGHT+IF2fkOx1psmIiI8t6n1UVP6WxxL86e2rgF4bc5zvWBkXEsJkKhYvtgfzcrreOJ89mrZR3pH7Q==
X-Received: by 2002:a05:6000:40da:b0:42b:47da:c316 with SMTP id ffacd0b85a97d-42cc1cc30c2mr10114899f8f.26.1763938301503;
        Sun, 23 Nov 2025 14:51:41 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:40 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
Date: Sun, 23 Nov 2025 22:51:21 +0000
Message-ID: <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a file callback that maps a dmabuf for the given file and returns
an opaque token of type struct dma_token representing the mapping. The
implementation details are hidden from the caller, and the implementors
are normally expected to extend the structure.

The callback callers will be able to pass the token with an IO request,
which implemented in following patches as a new iterator type. The user
should release the token once it's not needed by calling the provided
release callback via appropriate helpers.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/dma_token.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/fs.h        |  4 ++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/linux/dma_token.h

diff --git a/include/linux/dma_token.h b/include/linux/dma_token.h
new file mode 100644
index 000000000000..9194b34282c2
--- /dev/null
+++ b/include/linux/dma_token.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_DMA_TOKEN_H
+#define _LINUX_DMA_TOKEN_H
+
+#include <linux/dma-buf.h>
+
+struct dma_token_params {
+	struct dma_buf			*dmabuf;
+	enum dma_data_direction		dir;
+};
+
+struct dma_token {
+	void (*release)(struct dma_token *);
+};
+
+static inline void dma_token_release(struct dma_token *token)
+{
+	token->release(token);
+}
+
+static inline struct dma_token *
+dma_token_create(struct file *file, struct dma_token_params *params)
+{
+	struct dma_token *res;
+
+	if (!file->f_op->dma_map)
+		return ERR_PTR(-EOPNOTSUPP);
+	res = file->f_op->dma_map(file, params);
+
+	WARN_ON_ONCE(!IS_ERR(res) && !res->release);
+
+	return res;
+}
+
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..0ce9a53fabec 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2262,6 +2262,8 @@ struct dir_context {
 struct iov_iter;
 struct io_uring_cmd;
 struct offset_ctx;
+struct dma_token;
+struct dma_token_params;
 
 typedef unsigned int __bitwise fop_flags_t;
 
@@ -2309,6 +2311,8 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	struct dma_token *(*dma_map)(struct file *,
+				     struct dma_token_params *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.52.0


