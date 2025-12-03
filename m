Return-Path: <linux-fsdevel+bounces-70516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E866C9D6F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0933D34B03D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF322B594;
	Wed,  3 Dec 2025 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIbCe6/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC0422A4FC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722230; cv=none; b=aDYCSdw8+LghaPhYwsMi3BpxF/tajQM1wplszLumkotrDSGSkp8ljNWYOm8gWClDrPyTRQ55xyFCjAL1bPjJrQe0sby5G6f+42wSTL+TmdgrCZoH3GvJJyU0XSYgKk1cBFR/r8sKNCZzomWEmWclWrPXwrjyiIlSycLZzg0gYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722230; c=relaxed/simple;
	bh=Dx25h3qnu7ew3OFUNFY2J1netXwmriovnXf1iYGXQAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpQVz7edflNn9lZk0UhflrxlYrnI9Hppp+pvk5LoKW+ltzWkzJSg4OjpYIxwCcfdUw6G7AmYuU1nNgLq4sCTduyrsheeKADcmS2V0HiSO2vprFRYzhwV5HjF4dKDyHtxqqU71HdtIw/53mQa4L7ovWQfQY+4a6hFYcl+ychvGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIbCe6/9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so4245551b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722228; x=1765327028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIdUku4rBjvfs+wizq/smO3ocS8rb/JwYKIUM74TRjQ=;
        b=jIbCe6/9mvs7VhTKu27G8TAoU9Gu9+4R5wwb+XTy8Ly0G07iyQh5wDGVLMS0MLYjxC
         Q/ex6jLhGFYtdLLx8yZU3Zx+ZVlxNdorK/mC8ywYfsofeU8cCeiSim4vZb1OFqv9gogl
         Im5SJdG2CYPPxcplBQW5cOrRd8wwQQxjBo7drGnOrtctRgwBUsO5UVmrL2s9ctm/R7v5
         VWUDOxkOfuxcLrzMJEnALYEVyJC/hsY/BQhrhGtKI3+5RmJ9CvlPKsazuoQPlxa1sSC2
         FUH9tJmY3gC8qUPEQ4ZO2oCnSaMEN8HBTeEnvoo/6ppM89ftgPmkZiClKLW+Gld1fIok
         AfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722228; x=1765327028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIdUku4rBjvfs+wizq/smO3ocS8rb/JwYKIUM74TRjQ=;
        b=WqCikhMT5VmJedZ5tot+658DN7H1q+tWU6QKf5h6S/vrFjT9ll2CoE/eN0o9Hka5g9
         tS47JBg6OBKlj+lwpk3tdd/pSK/5JoZBW/9eSdXhtdtzrNA3GIXPM+GEEJIqkC6xCvUL
         hvZthcoPH3kYVvum3k4VjtT8Pe6tTopmTvQWf2WvTqctQ7/MeCIn5dEZBBEfLdS8nxlD
         vf8BNcT+9bSyxon3nAkMZo/Y4Ne9/qh/7/bttFA82TLBWYRNdUMv3S8Svr5hliOvA7D7
         MJz+NbnC2Jciw+7D/hMNeJvd7XSACAZbhKCKK8Wu6GJjh4zkIz3WSFFWUuwICdH+QNL9
         bgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7joYIFOahyt5nINXRUsF5XiQ6/m/Sr9ZbIzP/RIpWJxpKcp/RfKuqXmThtXAudpCK3/+bzMJ3oiZfhIRq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6c9KxbxbW4ZBZn3qFFSz0lu700dlBZTof38jYVF8lMFwf13zR
	lZFGZ+O0m0vHx3QcDn9gRRP4Rz31gEDeBoGF3yOnLM4IkPIB1yXufdM8
X-Gm-Gg: ASbGnctcX0paUb2VdpH3EiCKERCbuD/HjQE7pWCp0+as+bwLjr+H72f8ojoL1xhc0RU
	LriwtREvkKPPNBnuP4s+Kx//hQyo6zs+UjdpM2UZO4Nx36eZhJR0KZViRLElH2erKZhMvnOvs/c
	gI5tWBm5TdFu2gSI1kKg3+CzxihaNHI4paHOdqRXwl7MNSP6txyoetcvboQi7eIO9boO3X7RcYb
	U9GV2xeOE+JKOqtwfPDah2P0gwPePNdn/M65FsT7A3n6WSXJWnQhXVj6gTp7tazacrDH3PqSPpr
	URoHjkhd6oOAfsVVTO7OxzA2n+wZVs/Cg1qoY6DmaVM2VaBYbw74H2tbmQJFXz4M63oXeVuaLoS
	96VxXPlvIE0OtM5Jw/voXfXgLU3XH/FjyUY+p6jeYCLBs/5HhoKjhlgqfutgTyzfD83Pcvbv2CW
	Hlnk6b8deKPODa8kBR
X-Google-Smtp-Source: AGHT+IE6auAAGE2f4ZLl7pW0qxgTVrRLrFYp/xcdvbfLfBOMEj6TOzAL4zuRBQcasT88f/7+3OqbUg==
X-Received: by 2002:a05:6a00:813:b0:7a5:9cf5:b341 with SMTP id d2e1a72fcca58-7e00a2c7aa2mr476804b3a.7.1764722228179;
        Tue, 02 Dec 2025 16:37:08 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f17602csm18206891b3a.56.2025.12.02.16.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:37:07 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 23/30] io_uring/rsrc: split io_buffer_register_request() logic
Date: Tue,  2 Dec 2025 16:35:18 -0800
Message-ID: <20251203003526.2889477-24-joannelkoong@gmail.com>
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

Split the main initialization logic in io_buffer_register_request() into
a helper function.

This is a preparatory patch for supporting kernel-populated buffers in
fuse io-uring, which will be reusing this logic.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/rsrc.c | 80 +++++++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 59cafe63d187..18abba6f6b86 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -941,63 +941,79 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-int io_buffer_register_request(struct io_ring_ctx *ctx, struct request *rq,
-			       void (*release)(void *), unsigned int index,
-			       unsigned int issue_flags)
+static int io_buffer_init(struct io_ring_ctx *ctx, unsigned int nr_bvecs,
+			  unsigned int total_bytes, u8 dir,
+			  void (*release)(void *), void *priv,
+			  unsigned int index)
 {
 	struct io_rsrc_data *data = &ctx->buf_table;
-	struct req_iterator rq_iter;
 	struct io_mapped_ubuf *imu;
 	struct io_rsrc_node *node;
-	struct bio_vec bv;
-	unsigned int nr_bvecs = 0;
-	int ret = 0;
 
-	io_ring_submit_lock(ctx, issue_flags);
-	if (index >= data->nr) {
-		ret = -EINVAL;
-		goto unlock;
-	}
+	if (index >= data->nr)
+		return -EINVAL;
 	index = array_index_nospec(index, data->nr);
 
-	if (data->nodes[index]) {
-		ret = -EBUSY;
-		goto unlock;
-	}
+	if (data->nodes[index])
+		return -EBUSY;
 
 	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
-	if (!node) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!node)
+		return -ENOMEM;
 
-	/*
-	 * blk_rq_nr_phys_segments() may overestimate the number of bvecs
-	 * but avoids needing to iterate over the bvecs
-	 */
-	imu = io_alloc_imu(ctx, blk_rq_nr_phys_segments(rq));
+	imu = io_alloc_imu(ctx, nr_bvecs);
 	if (!imu) {
 		kfree(node);
-		ret = -ENOMEM;
-		goto unlock;
+		return -ENOMEM;
 	}
 
 	imu->ubuf = 0;
-	imu->len = blk_rq_bytes(rq);
+	imu->len = total_bytes;
 	imu->acct_pages = 0;
 	imu->folio_shift = PAGE_SHIFT;
+	imu->nr_bvecs = nr_bvecs;
 	refcount_set(&imu->refs, 1);
 	imu->release = release;
-	imu->priv = rq;
+	imu->priv = priv;
 	imu->is_kbuf = true;
-	imu->dir = 1 << rq_data_dir(rq);
+	imu->dir = 1 << dir;
+
+	node->buf = imu;
+	data->nodes[index] = node;
+
+	return 0;
+}
+
+int io_buffer_register_request(struct io_ring_ctx *ctx, struct request *rq,
+			       void (*release)(void *), unsigned int index,
+			       unsigned int issue_flags)
+{
+	struct req_iterator rq_iter;
+	struct io_mapped_ubuf *imu;
+	struct bio_vec bv;
+	unsigned int nr_bvecs;
+	unsigned int total_bytes;
+	int ret;
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	/*
+	 * blk_rq_nr_phys_segments() may overestimate the number of bvecs
+	 * but avoids needing to iterate over the bvecs
+	 */
+	nr_bvecs = blk_rq_nr_phys_segments(rq);
+	total_bytes = blk_rq_bytes(rq);
+	ret = io_buffer_init(ctx, nr_bvecs, total_bytes, rq_data_dir(rq), release, rq,
+			     index);
+	if (ret)
+		goto unlock;
 
+	imu = ctx->buf_table.nodes[index]->buf;
+	nr_bvecs = 0;
 	rq_for_each_bvec(bv, rq, rq_iter)
 		imu->bvec[nr_bvecs++] = bv;
 	imu->nr_bvecs = nr_bvecs;
 
-	node->buf = imu;
-	data->nodes[index] = node;
 unlock:
 	io_ring_submit_unlock(ctx, issue_flags);
 	return ret;
-- 
2.47.3


