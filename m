Return-Path: <linux-fsdevel+bounces-71897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2EDCD7800
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 01:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 112F13022D0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7ED1DF736;
	Tue, 23 Dec 2025 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTBcRj6t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970471FAC34
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766450203; cv=none; b=DPCkTZ1Ygh5xtYKm/zT499Rw7XCBvxBU4pOOEm5mvaT1mo9YIQIuYHMTQ6ROudaYthtB3P+9jD4Nw8d3S6M9f67AjoKPg8iUTUV3tbcSi3PQoHNl0vU1/dW4bxUlcByGR7PRzmasL17UjKfFjC9bT6F2b520Kp8Vcjru8oGUMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766450203; c=relaxed/simple;
	bh=KrmCRoV8MjBhvjdAUb3SB6S5jStXwJA4oaI5/u6gnG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozvvGS+47m3op2ZqVUQQ3F0c2IRWkS5UCow1oB94TJz+5Gb2B9A3nZorBEullCtdCPVPn1fnTlBq2A7vcUZu7mvVZHl1zx0WTt/Txr4I9I7yQuAHQZZtkL+CcZGa6L5LIbpMBLM+OwfYDJWL0MusQBaFyZUZu01ETXODJoMAsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTBcRj6t; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so3527537b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 16:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766450201; x=1767055001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEJro4wMx5XRk0blywsxQ4/jyx6MajuIiss5j+0G4eU=;
        b=UTBcRj6tojRWY9Ohw88V4RT1sGyckFlss+e3Nrq4/SVr2aoqsZNf46pBqL/Unl5eg0
         D4nFTgT36E1++qC7PcsHygAw1cp4K5Q6z/LIA4ra0SuC1Dr6lpV4CT+/afi3O/xba3gY
         8gG3+OIM1uHaG2gCpBUqutjrI7eF2zMbZVAX4i0S8UsbDIq2mPH0PHw/a8HBTPZodOgL
         yq7nUcelPlcZjoxP0gMKJnbQi00pbTAB/bGmrMhvd8Ehgsjm0Myhj2lFVJ6/TAMXfWW5
         DwwbbtREFjJDY08Rmp15ZPEQherqiRuaooEFI86oOenmkl4DBXyUfcez5QwYukhienL9
         g7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766450201; x=1767055001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEJro4wMx5XRk0blywsxQ4/jyx6MajuIiss5j+0G4eU=;
        b=RAUWU2n7rkjpv5DKQBokrBR9KdentIeFkhKjkbzIm+AZAds1SHu38XoRat6Spj1ANh
         rWrbaVJRHdGqM1yZPt0J1+yoRo8smCGD9FzeW3Y6NsKmeJaAL0i1Ar/eF65b/ypHm3AM
         d995A+CcACEWriuwthgeF2lrzhNmt/ZxnzoA3U9q8OHJgyARQpvZq1scsjPcVH10b4yX
         vXykPZYxLIJgFlNdgchiH7Rrs+Xlh/XO6YYBo5FlN9wVMWJQ6CAWwJPOsBf0PV5kwF2L
         4BYJ67H6TvoFV2vjrUQGCPsA9xb9J5Au7IRyZlPl7yaOo7IUbIFjKqch/zewk0kwWAqB
         9vbw==
X-Forwarded-Encrypted: i=1; AJvYcCVDzABuaBYcAQx+wbUhisETQz6zTv6QFxmjaY3E9ngsfeSsr4r+/Wr7shgW2eYJLKb0fvpPAhIod5hlJKjF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzq9WB90RH5g17kNO84+KwIxa31yOCS5BmyPiVfqKIblSby5rG
	tTtNEw4X7Yz5ig3RjJlvTpRCSN/rPLviC9Yl09yZuGUCl4Sze51D2K6s
X-Gm-Gg: AY/fxX4ct2vqwIA6et6SPBpJe5aedwU7NKqsWCQZhPxmdbT6uydlNZo5hRS8ksp04uN
	L+xmlaogSgX0ZSSIVUTCr0Ni605/8ScKT6531MSRym4Mm92fFfIaiBlm7QiQxg7rADrjaygdeA8
	+T5wSl/Yqz+kqG2XJjxIIpwEv7o/MvRF1l1U+sB1wR0PUEoeSDFokPtjM5imdjJ0xTROBZscOY+
	loy+44xAVrPLwfbCPbqXHm0YIArkafgi/6hjBOwxLttXsFMoEucl0ICGuIpnUISPlirCJJSKALQ
	g4rm6np917Gs5WRJxmYJVJYtmb9CsLM3+JWr1FDqfB7vhYNCnLLlEsdNbLbXDKMnm4HOZjYejR8
	aoienTEGMctFFYSqZJTFhHqj+rohBV8lbgxQ5FYIXxd3eRVGgq4TRnospZ7RbgWFLKwcXWifFQ+
	eA1MtDhux3/PcGOcim1g==
X-Google-Smtp-Source: AGHT+IG8I2aNwNNcdmilTr57JlL+rm+iAJlvNF1HEXBSphs0JeDWfj3RAglRsRaCuJW+6ONn1MxRvg==
X-Received: by 2002:a05:6a20:394a:b0:35c:dfd6:6acb with SMTP id adf61e73a8af0-376a7af5089mr11950072637.30.1766450200919;
        Mon, 22 Dec 2025 16:36:40 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79a17fb2sm10146194a12.12.2025.12.22.16.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 16:36:40 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/25] io_uring/kbuf: add io_uring_cmd_is_kmbuf_ring()
Date: Mon, 22 Dec 2025 16:35:06 -0800
Message-ID: <20251223003522.3055912-10-joannelkoong@gmail.com>
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

io_uring_cmd_is_kmbuf_ring() returns true if there is a kernel-managed
buffer ring at the specified buffer group.

This is a preparatory patch for upcoming fuse kernel-managed buffer
support, which needs to ensure the buffer ring registered by the server
is a kernel-managed buffer ring.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h |  9 +++++++++
 io_uring/kbuf.c              | 19 +++++++++++++++++++
 io_uring/kbuf.h              |  2 ++
 io_uring/uring_cmd.c         |  9 +++++++++
 4 files changed, 39 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 2988592e045c..a94f1dbc89c7 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -99,6 +99,9 @@ int io_uring_cmd_kmbuffer_recycle(struct io_uring_cmd *cmd,
 				  unsigned int buf_group, u64 addr,
 				  unsigned int len, unsigned int bid,
 				  unsigned int issue_flags);
+
+int io_uring_cmd_is_kmbuf_ring(struct io_uring_cmd *ioucmd,
+			       unsigned int buf_group, unsigned int issue_flags);
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
@@ -176,6 +179,12 @@ static inline int io_uring_cmd_kmbuffer_recycle(struct io_uring_cmd *cmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_uring_cmd_is_kmbuf_ring(struct io_uring_cmd *ioucmd,
+					     unsigned int buf_group,
+					     unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req tw_req)
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index f12d000b71c5..0524b22e60a5 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -958,3 +958,22 @@ int io_register_kmbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 
 	return 0;
 }
+
+bool io_is_kmbuf_ring(struct io_kiocb *req, unsigned int buf_group,
+		      unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_buffer_list *bl;
+	bool is_kmbuf_ring = false;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	bl = io_buffer_get_list(ctx, buf_group);
+	if (likely(bl) && (bl->flags & IOBL_KERNEL_MANAGED)) {
+		WARN_ON_ONCE(!(bl->flags & IOBL_BUF_RING));
+		is_kmbuf_ring = true;
+	}
+
+	io_ring_submit_unlock(ctx, issue_flags);
+	return is_kmbuf_ring;
+}
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 4d8b7491628e..68c4c78fbb44 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -149,4 +149,6 @@ int io_kbuf_ring_unpin(struct io_kiocb *req, unsigned buf_group,
 int io_kmbuf_recycle(struct io_kiocb *req, unsigned int bgid, u64 addr,
 		     unsigned int len, unsigned int bid,
 		     unsigned int issue_flags);
+bool io_is_kmbuf_ring(struct io_kiocb *req, unsigned int buf_group,
+		      unsigned int issue_flags);
 #endif
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index ee95d1102505..4534710252da 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -448,3 +448,12 @@ int io_uring_cmd_kmbuffer_recycle(struct io_uring_cmd *ioucmd,
 	return io_kmbuf_recycle(req, buf_group, addr, len, bid, issue_flags);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_kmbuffer_recycle);
+
+int io_uring_cmd_is_kmbuf_ring(struct io_uring_cmd *ioucmd,
+			       unsigned int buf_group, unsigned int issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+
+	return io_is_kmbuf_ring(req, buf_group, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_is_kmbuf_ring);
-- 
2.47.3


