Return-Path: <linux-fsdevel+bounces-71647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF72CCAF92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B1F30194CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB2335086;
	Thu, 18 Dec 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8PLIKta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C4334C11
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046910; cv=none; b=E/C8H4dr5gKb0SOmlPlKl8x5OuWZ4n+RSjPb84mo+KxjblRsgw+Uw4ipn1b+GbmzDQhw7U6/camnOFEfjxvj0XxZienpDxPEWKIz8CFAwtW5vkudUNyT70dCu+wefK0Iae9mK0p1kQx/+B4mdKBoa/q50xJSCexGwZmIfpsfVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046910; c=relaxed/simple;
	bh=Djbalr2Frb4P3YduJN/LxOvBtYvOFO9wivgEqEOHizc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGI/Thpal0VGwNJL6C+Wg+KdLyvxy13pQqPbx/lzShpCAtVtr/Q14w4j2et2atUei6AsP32KnjUn9CqFZw6X67g56QxkxCx2GWFsOMArZzhIXWHeImPKEDFdkXoqbJF97HYxD57ta2+d+KvVjmSA7ODdSGy+s9s4cXlYx8CnbxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8PLIKta; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aab7623f42so500190b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046908; x=1766651708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzjSvxSUtJBpqqYtsLr2cB2XQQS7W26sUHOwgwQlj9M=;
        b=L8PLIKtaqBDQ2mt7sTXm4/DeNIp4GWe+scG8v/V5eU46Ra8lK1oUJKkh4UV0LSkGLm
         WTJ64N7elSDyfCyxXZ0Qc5JkIyavOdWaOow+nRcpolIeCYet7qzXVVTu95k4wnAs80/1
         geW3Pp3JUVGIxWByNjjn1cNJZsS0g2vdB5fz3uK97ZdsByZcY17hG+giCbOkNIJK/qoN
         PkLpdT6xnce1WJuQyd02sNcvz04rLVQwfLTMDnymKCcleRrtFYJLLOe2LSP8lU63TjGw
         sqZAms9Zo5fxbLxUemuJHByoU4ZG/wpb74HukfpMT+k/mmBMWFhR5RCPlcIaIiQIlmvm
         6bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046908; x=1766651708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uzjSvxSUtJBpqqYtsLr2cB2XQQS7W26sUHOwgwQlj9M=;
        b=KrXZNrZQ4kE40LliigxkOP0RhiIHAAhOXLrZkepklhbSgVdekfq9UREm3MY2NYZt7c
         KmtIuAM6k9pd1GUsU3BCy0JQ7uvpdtaMj4nywF0AIxITPUXUqLyqLAdYKoVmVubS+TUM
         PLR+L5f6CQATMzlyWWBsKQfltXReTvHQuLXgdYAtmqOoiI1G4AuEbalQzTuRJwH7cvmD
         TfnLR5F75sZwtTxbIPGbWvCuu9x6e2JQikbsh7T+wTTIvoRZ2K/RCp2wg0UYf8cOVN/R
         ew7jvrESWNTlpUYWlbeitcgcABEABPbrZF2ZsMaeawJQmkTSuqJZXiJ7VCIB8nTA6CLP
         P0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1owikz2gXS67KEEV5K0mdt5nv0XLFbvkkRVzuwU3jTbM1NL2fXBdfoW+acqzlBNWml6jK5F9FNS+DZ3IW@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdJuwh/CP5gQ90WLYaHyGGjOaiVejAdnCfHamLx9ykNDwwpxY
	M+fy30/OSY0XIEiCTAl4TiLH4XtD5uZpsmTYJw6Qv2zZCPIf7JhrXCws
X-Gm-Gg: AY/fxX5LJbLbWBf2qFp01Po5mDW1JQM6K5rjvBz1CSW97Y9tIrYQJgXClQM2VTtX3LR
	9j/KR4PCyyCPsTHKo0TEYp2U4m7TMLzMSDYwiQDDwAVcYc21HQBhiFWHfCGo+NiWZf67DaV8WL8
	5Ig8KQyDFC2jYInHrbC0g2zgVq4iHoeTs2FJGW7Qeifl21jtn08moIwTurEFbjmx4/sqHgBENdT
	g47ct8ZLi6WwQ2IbIen7xXt/A9OtVpI+u+ibjfZudEIj2TIiE/NPs8do6wkZKB1CwyXm1i6KOuj
	l4NFurMy1xwUQhnZQCdlGhHPcfrgzsn1E84jbP8PegAhrlepY0DNuE3mLC7+nl/eYxgOi663K7d
	nv8mD+8fVwQgEtqrNYCA+FOUYEchtgMlqvTzUxSH2xTmDVDR84qcqMo+5zW6ZTCUDxKU7BlfdYN
	c4m5x/Xgzh2pBUiqX1HA==
X-Google-Smtp-Source: AGHT+IEke/Uk1vAasnsb/vU3PY0FjXKrYqmQEqsohtclxzj6SUMhFSH15zQIhqngpwdWSfdNx//8rw==
X-Received: by 2002:a05:6a21:32a8:b0:361:3bdd:65f7 with SMTP id adf61e73a8af0-369adad124cmr20220731637.13.1766046908020;
        Thu, 18 Dec 2025 00:35:08 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1d2dc9e0d7sm1606009a12.9.2025.12.18.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:35:07 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 21/25] io_uring/rsrc: split io_buffer_register_request() logic
Date: Thu, 18 Dec 2025 00:33:15 -0800
Message-ID: <20251218083319.3485503-22-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218083319.3485503-1-joannelkoong@gmail.com>
References: <20251218083319.3485503-1-joannelkoong@gmail.com>
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
 io_uring/rsrc.c | 89 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index b25b418e5c11..5fe2695dafb6 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -936,67 +936,86 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
-			       void (*release)(void *), unsigned int index,
-			       unsigned int issue_flags)
+static struct io_mapped_ubuf *io_kernel_buffer_init(struct io_ring_ctx *ctx,
+						    unsigned int nr_bvecs,
+						    unsigned int total_bytes,
+						    u8 dir,
+						    void (*release)(void *),
+						    void *priv,
+						    unsigned int index)
 {
-	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
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
+		return ERR_PTR(-EINVAL);
 	index = array_index_nospec(index, data->nr);
 
-	if (data->nodes[index]) {
-		ret = -EBUSY;
-		goto unlock;
-	}
+	if (data->nodes[index])
+		return ERR_PTR(-EBUSY);
 
 	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
-	if (!node) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!node)
+		return ERR_PTR(-ENOMEM);
 
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
+		return ERR_PTR(-ENOMEM);
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
 
+	node->buf = imu;
+	data->nodes[index] = node;
+
+	return imu;
+}
+
+int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
+			       void (*release)(void *), unsigned int index,
+			       unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct req_iterator rq_iter;
+	struct io_mapped_ubuf *imu;
+	struct bio_vec bv;
+	unsigned int nr_bvecs;
+	unsigned int total_bytes;
+
+	/*
+	 * blk_rq_nr_phys_segments() may overestimate the number of bvecs
+	 * but avoids needing to iterate over the bvecs
+	 */
+	nr_bvecs = blk_rq_nr_phys_segments(rq);
+	total_bytes = blk_rq_bytes(rq);
+
+	io_ring_submit_lock(ctx, issue_flags);
+
+	imu = io_kernel_buffer_init(ctx, nr_bvecs, total_bytes, rq_data_dir(rq),
+				    release, rq, index);
+	if (IS_ERR(imu)) {
+		io_ring_submit_unlock(ctx, issue_flags);
+		return PTR_ERR(imu);
+	}
+
+	nr_bvecs = 0;
 	rq_for_each_bvec(bv, rq, rq_iter)
 		imu->bvec[nr_bvecs++] = bv;
 	imu->nr_bvecs = nr_bvecs;
 
-	node->buf = imu;
-	data->nodes[index] = node;
-unlock:
 	io_ring_submit_unlock(ctx, issue_flags);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(io_buffer_register_request);
 
-- 
2.47.3


