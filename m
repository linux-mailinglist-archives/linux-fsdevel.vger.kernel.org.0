Return-Path: <linux-fsdevel+bounces-70519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF915C9D6F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C873A2F98
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005522B8CB;
	Wed,  3 Dec 2025 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwkBkaK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388172609CC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722233; cv=none; b=kgq05YV3Zt5brJYzPySuu+ZvfEfEw4Sli7FZzRZ0iTkete6J4xDKQaP9KPTXdQXLrayuqPDsBW+G0AoY13sJPJdV+XSi8Aa7IW59eDPHOQknNnstuuYEjA1F1dLo71sXXs6gl6ahUknRj/sK+oX5Ms8ocGjs2CEUbPnveOPSnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722233; c=relaxed/simple;
	bh=5eK+SWDhLpes0WgGB1yI6ykRUTk3qSxid1pNxzxrdno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GomjHhDYLzxQ87JN9om8xjdLYyH1BM+B1OcJm8Xsu7F5bA+W0j+XSSrFW15mw76amchvUMmqMLxJ0nDCPLApcUPZN1ieIpHqD8g1vaJrNq0Ie7Tb5QBziBYVdG79dmm1QrcXy911xSpQh7jbWXT+63kb+2346txs1LXJw1oiF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwkBkaK/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so5206574b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722231; x=1765327031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fkt73EuxuNJ1I8X/QObEo4LIp+wArdiuU4gz5REkdY=;
        b=fwkBkaK/000u7HQDmpTR7ywpGKVS9dUWCDwoUb1qG7Ms8rnspZojaHK/8jVEIcTGRE
         vURV8UV+oEHAuGOmHepN5LzyF3s7egDTQH/NZPLOZae0dHQU5EmZgH3/c6ruKjoVnYBK
         ZwtjxwT9tLML3lNv/gM3AWT5RD9KXAkPUTAHI+Qg1PjG2JdwqxEWBYfUdhqdSUJB9ZFw
         oOWugR2/QJnDAMfM+jc8980F4ExRAUwABkjoiEEleWT7LTG7HUU+eXOeRye4e384HHkm
         CXZ4OJOj0LE74/Lu1UhkE9r79w4Ry9oWhkv8SJW/TNDvrGP/yo1OFKjZV/wog20tvuHX
         EWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722231; x=1765327031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fkt73EuxuNJ1I8X/QObEo4LIp+wArdiuU4gz5REkdY=;
        b=aBcmCqcpUvT1tzZasyPqzxXIk/rlvLJIe55OFvUBCitxSRzxgDH/dJ9uY0raelwP74
         tSXgcR4MqXiYwKNMmeuvOeXopAn6wSmQPrOM9v+jNTB2JtPZaeeboMBfwM9AeFkfSKjn
         Bw5gVFG3uJpHFxxhhh0ypNUO1+k90yuIUPo8iSkdqiW80h1La0nll9INZqr0HBFW7clk
         UqITNbhBQ8ie50HZ3+zqEnGRIbh4gLWvbGBsSMAEtWP/gAfv3PCMhQq1ozT+qFLTawAt
         nZt+XczY3h1DPDSPXos9hgDPJ76ISBIYdjVI3JKpROcHFtBG0NkRx6vLT04QSl7OTb19
         /tpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0gdYvcWO9lNZjPgqhs698jD8PP569B/ehBofJYzik1RrRfwNe3KqQdkiPgNB5jClVuMZDvE/2aHpKKmil@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jJJQKZ9Qy9IuqljcsxQe9JiVu1ir+BWN8hPs9XNmr2jMuliG
	NDDfomKkOsnBiQn5DV1GBUKjAnujekOt4dTUsAySkdc6ekg/MOcq/LLiQglGeg==
X-Gm-Gg: ASbGncvEyCqj+uYRkziGhv4GRkGnaDkasYZ0j3OyoqPDPQsmRjSxM1qDSD+qsQ3KNz+
	MQmdbE2V7f7LBsqwp22ZIMUUx9l/JrQUDGWUMInmnkRaVt/dKIfxktPiKkEEDVyWcnkArumWVVx
	DaTe8HsrQEZyvofTjn68UiBZK5SO7jPGtxRy+00qSTjix5ReU04b/yK+NLiRoi2ll/QeByFsHny
	DZr6FjBkIiMwKQQNrWrFKrQfvNl7pVffNzHGZz8P9+dIkC4UXbCHS5j95bx4r3s94Sn0TmOVO4Y
	AdoaiBKHPrnkAuFCem18ixcWE1t87PZO2q4G88IgLP24EAA8s2p4c9FdyMeynpwhpXtps3Cu3jt
	pzusN/F+jZgiND8iljnPnoAQAdTg097uoUgR5Fz+77xRxeQd28HvddP082Uq0SE8O3voQYuyMYO
	oc75qARZzbEPx1G7qZNw==
X-Google-Smtp-Source: AGHT+IHsUjpd9arGX5qpZZvMlUiCyED7iIxHnWQ4Tx8waqmADtkAEa6xww+qAmpWCN5C9ImJmGTNUg==
X-Received: by 2002:a05:6a20:7484:b0:35c:dfd6:6acb with SMTP id adf61e73a8af0-363f5e2541dmr794785637.30.1764722231473;
        Tue, 02 Dec 2025 16:37:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3dfcsm18129387b3a.40.2025.12.02.16.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:37:11 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 25/30] io_uring/rsrc: add io_buffer_register_bvec()
Date: Tue,  2 Dec 2025 16:35:20 -0800
Message-ID: <20251203003526.2889477-26-joannelkoong@gmail.com>
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

Add io_buffer_register_bvec() for registering a bvec array.

This is a preparatory patch for fuse-over-io-uring zero-copy.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/buf.h | 14 ++++++++++++++
 io_uring/rsrc.c              | 25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
index 2b49c01fe2f5..ff6b81bb95e5 100644
--- a/include/linux/io_uring/buf.h
+++ b/include/linux/io_uring/buf.h
@@ -23,6 +23,11 @@ bool io_uring_is_kmbuf_ring(struct io_ring_ctx *ctx, unsigned int buf_group,
 struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 				       struct io_buffer_list *bl,
 				       unsigned int issue_flags);
+
+int io_buffer_register_bvec(struct io_ring_ctx *ctx, struct bio_vec *bvs,
+			    unsigned int nr_bvecs, unsigned int total_bytes,
+			    u8 dir, unsigned int index,
+			    unsigned int issue_flags);
 #else
 static inline int io_uring_buf_ring_pin(struct io_ring_ctx *ctx,
 					unsigned buf_group,
@@ -70,6 +75,15 @@ static inline struct io_br_sel io_ring_buffer_select(struct io_kiocb *req,
 
 	return sel;
 }
+static inline int io_buffer_register_bvec(struct io_ring_ctx *ctx,
+					  struct bio_vec *bvs,
+					  unsigned int nr_bvecs,
+					  unsigned int total_bytes, u8 dir,
+					  unsigned int index,
+					  unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IO_URING */
 
 #endif /* _LINUX_IO_URING_BUF_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index a5605c35d857..7358f153d136 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1020,6 +1020,31 @@ int io_buffer_register_request(struct io_ring_ctx *ctx, struct request *rq,
 	return ret;
 }
 
+int io_buffer_register_bvec(struct io_ring_ctx *ctx, struct bio_vec *bvs,
+			    unsigned int nr_bvecs, unsigned int total_bytes,
+			    u8 dir, unsigned int index,
+			    unsigned int issue_flags)
+{
+	struct io_rsrc_data *data = &ctx->buf_table;
+	struct bio_vec *bvec;
+	int ret, i;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	ret = io_buffer_init(ctx, nr_bvecs, total_bytes, dir, NULL, NULL,
+			     index);
+	if (ret)
+		goto unlock;
+
+	bvec = data->nodes[index]->buf->bvec;
+	for (i = 0; i < nr_bvecs; i++)
+		bvec[i] = bvs[i];
+
+unlock:
+	io_ring_submit_unlock(ctx, issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
+
 int io_buffer_unregister(struct io_ring_ctx *ctx, unsigned int index,
 			 unsigned int issue_flags)
 {
-- 
2.47.3


