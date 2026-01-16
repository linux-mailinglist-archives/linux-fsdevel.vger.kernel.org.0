Return-Path: <linux-fsdevel+bounces-74270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8414AD38A38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE8053069624
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609532470D;
	Fri, 16 Jan 2026 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWuc3P1S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C48322C7F
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606303; cv=none; b=M2OZWiVNni3pzr7uPA8WlrPILdAKG6GpWR+U2B2jXKVLMSDToy5dPQOCS2ETWeAXMyYA9ths+A+IVPU5fGMLS4h3QDM25L+/d2m4LuPmJ4NciyCtMsggkF3cMdfw5Vx4ih5dbuSu/psv/sHsdwmuS2gc5WASoc6S99/p03hI6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606303; c=relaxed/simple;
	bh=L+fNvAuWzVOwU6hFcEwwEhrc55dKOo60Dyz7osbvO8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/pN+S3qaLeSgcJLPvaQojuY5icYQh7S4uM1SA4ZahwqqwEiNeIs6TZ6nmM/+eIu/SoMB8sWmN0UiHjCcrJ4KW5Hj3jvUdxdXnYhkzFi2pCM43IWMF6/AZCYKrvBoa/4zZSJyY2xlmMnEAUHY/cVLE+2IfMjo165Zpih8UwLI3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWuc3P1S; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81c72659e6bso2369685b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768606301; x=1769211101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qSpk0vc/AA3StwpyL4JEU/ZXjIsZUwsiClOeude5D8=;
        b=WWuc3P1S8UMbJxIGePn6Z3sq1yp6BZkivuXjLps0DJuuvX9LX5E6avDUwebKu0hq2a
         UsHFIVkjLy5TNXAReY+KrmKR4wL/mvobFKNmAlinFDyh5RxD4nShNae7WMBXtg3V6S/f
         MmUkDi8ocQMC/FBBoVpqPxG3675LgOI4rpjHRm36NyGiMB/fAoP+qudD10OMpRSB0t89
         8pdxWI3qxeJBniLrzOElEP0APyZ0o/7ynGqUSvjE0SxPEPifgs2d+RVyrXjLRXRccY7U
         UfXwS+zgHBMMPI0+JbYY4Bam5tvd60EUNKs6Ojsm7NdRTK8AAlQZF/Z+0cP8v+S+hq2v
         mfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768606301; x=1769211101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qSpk0vc/AA3StwpyL4JEU/ZXjIsZUwsiClOeude5D8=;
        b=I4WD403G0qiMYFp2B6mL3LSQRraMCaG0uqnp1RC3zupRjbOUySeTS5jAm0YH1S34kX
         lnu64p8Yjd4oGIDPNY68CYy2cmpxuO+d2nbA1kF6UZN46MRz2zvuQopKFW6a+xhGJtFy
         60hMW6fxi6n/r8UhfpvrGocsaz5g2d+ozX8r+Xz71cpaounWMC5dI/7HzqQh8lGumR3m
         Om0gws4WUlRUxPXAuQXLUgOIJkqgwVCUs+zufcNpXtS4XxPu3x/yemTRA3qgpLgav55s
         H8ugiK+R0vO8Q0OlJxH3Qo7k4ZWGfOfr/dRvphAUpE2XWOiX0IzJURI54LZN2ZTVsqbP
         bkxw==
X-Forwarded-Encrypted: i=1; AJvYcCWt3yaz3iHFe1RD/ILNKb7cVYCPgCmT2ixhldOSCwLbGhOlMsmCaVPV9pIvg+wXPnMAsAa0siCTNpnkqyAr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpb7bjYla+MpTtCz2K7jVP5wzDI5+SzniEpiiB30ogJrR5iRPI
	tQs8Z9qt0GXrveY9dYEBDJeoYvHE8fEBiPQp8T2lzMW0z4npJTtINYzs
X-Gm-Gg: AY/fxX5nvbXIkKbXzvoHYTUAGB4k9sk0CH3Zngj1JqgUnmHj194P1fPVl4MJdCt2LLI
	BvBE9JCiS+fvTmnrIMs0WIoCudc4CL5vf+SmzQ1TlHYYYGQ6Bro4YIV2L2Kg3ytTwbUyWudf4k/
	jwJRsJyt9GMeZcY3QBvoQy6OXH45FLOENRahojKZgKog3eACJvuCSRlwSSpbzkRF7kieeJB6fec
	bfCgnZZAtEn5XF6DG7ehxi1hEmZnGhi4xLkGl+oTwO6LpVos36dIIJiJzx+iMhjcq3rWzo2mNff
	bMMlSpvV9T6VmVBCCgs0Me2EsDi7r5zhlhKoOXTgiOHwdKOYjNP2OSajC/9Z1lL+wUwPcYt4Mhu
	/AWYhJVhB4XvvoJywzdUWVfCHeeia0p7ggcw1r38QryY+uTOlUjsScbY5es1RhtqtXezwe51x64
	MfVgaQPUz53zBUBMg7Dbf5TP7Yb4k=
X-Received: by 2002:a05:6a00:1f0c:b0:7e8:4433:8f9a with SMTP id d2e1a72fcca58-81fa036ad99mr4275518b3a.34.1768606301638;
        Fri, 16 Jan 2026 15:31:41 -0800 (PST)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277a22sm2930201b3a.32.2026.01.16.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:31:40 -0800 (PST)
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
Subject: [PATCH v4 21/25] io_uring/rsrc: split io_buffer_register_request() logic
Date: Fri, 16 Jan 2026 15:30:40 -0800
Message-ID: <20260116233044.1532965-22-joannelkoong@gmail.com>
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

Split the main initialization logic in io_buffer_register_request() into
a helper function.

This is a preparatory patch for supporting kernel-populated buffers in
fuse io-uring, which will be reusing this logic.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 84 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 33 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 2aac2778e5c1..63ddadca116b 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -936,64 +936,82 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
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
+
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
+	/*
+	 * blk_rq_nr_phys_segments() may overestimate the number of bvecs
+	 * but avoids needing to iterate over the bvecs
+	 */
+	unsigned int nr_bvecs = blk_rq_nr_phys_segments(rq);
+	unsigned int total_bytes = blk_rq_bytes(rq);
+	int ret = 0;
 
+	io_ring_submit_lock(ctx, issue_flags);
+
+	imu = io_kernel_buffer_init(ctx, nr_bvecs, total_bytes, rq_data_dir(rq),
+				    release, rq, index);
+	if (IS_ERR(imu)) {
+		ret = PTR_ERR(imu);
+		goto unlock;
+	}
+
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


