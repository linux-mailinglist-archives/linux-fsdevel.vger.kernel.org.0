Return-Path: <linux-fsdevel+bounces-65806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A06C11B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 23:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58F96351DE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167232E15C;
	Mon, 27 Oct 2025 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoN3eeeL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5632E15B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604192; cv=none; b=P4+F46uA4eV4EnqXar96AXOTqCEgvz/nUAoqhpEJK30DaYoZ7XLYbVm6KfQ7VKk+5JQzl7pmjXzdTEOCzFSTO4wgx26NPpgpGYUPPZ55SDUTh8pKJtPdDfi2vG6NkPyHEZhr567RkYiBHi5guaYrujzVOtCC8026YKiPSh5JIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604192; c=relaxed/simple;
	bh=1E18qGvEdVDEk2lUFERAFuFP8ZQrwhZtxHG5TjAD79s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIFO/lBUb/SHc0Bukpgsn5liTrqsXJ/Z0e5/XBnBub+cts0Y1WI8vSAe3+lup4PmGwOeDQbzDxWblgaht/8mcyiSvFZcGNISoB2/yA/4a9VnhtVtzaCUtvH6BHAPBZvsVh0Kwsi0R3FP9g0EZSHdCTJiFLEQHQAel0s/p3Bq+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoN3eeeL; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b593def09e3so3169037a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604190; x=1762208990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0beltc7+RSlROfm77N8Sgc2Yv4Aur58ceDXgjV4dII=;
        b=EoN3eeeLKUwSIaaJuviSbFmA3nj/9xFVIufVPJbd++RZ1odoRXNLRXMb0RgQAUzKCX
         j9Xc25qydG2+XsvhmsSx2L+R4FskuGxusFnEO1M1H+JsjVznzeMpwkOk3icAlaZbUaMf
         FCRmR/Pwr23eW27bQ7eVgu3IeOvFtIRmOQs+d3PT+pU09M3Thtpw/5ECpuBcSb+KI5AV
         xMBGDv5306214+ywJc8iwUXl+6ODQkxplX7hLf//VqynrRgzL35emlVkIOW0Dfxmxt9Z
         8RLMyS4XtE+88IGqS2yD+rjUw8wx5fc5K9veF4AQRYriYtmJSnesjvYjcoUuaqUB7CjY
         PGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604190; x=1762208990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0beltc7+RSlROfm77N8Sgc2Yv4Aur58ceDXgjV4dII=;
        b=dEuH3i9waw0x4M3nbP70C6AsHM90xU+dVNNnZ1d5+3UwEh/EFf0xl/ejTBzyZM5xkM
         vhIog7HUPxNHeNBbyTYczMY9lrhWw+c7BWI9/oTwDs1LkXRdHn50shBiov3jpe/2kBkg
         lGkuFws2YR8UpJMVDKkKiC2bL/y08BP8aogCV9qbVAYK09uOharRGqWkWIhko7uEiyc4
         8NYmpeNam3aHgQyIzAemSu7XbTUv4wwAwa6UlxVxD4wfLwHhmbhaaE9gFTPyHvG1Xx8p
         uv9gh2Rt6ugPd8ceIaXSngjSsENzUpu9xXo5WVD0qOxLyYTJ6y2MqfzZ31O6pXx+ILPs
         Dg8g==
X-Gm-Message-State: AOJu0YzNqMXY7BV7SWFVr91bsyr7uVmQ1GfPAMh49XV4AzeUMNFoduYZ
	SjwCYhm2sAhfuXGVQW7wwPi17cNWhNF86fjX2f6gN6u8Tqir7SQ1GabT
X-Gm-Gg: ASbGncsWZbv9cQ2/No2SeuLue0j/TH8bkb8UxNu1lrmN0COVCHCZV6f7JKpF9odAZ+E
	j1jT/CUH+m8QCRZV2duis/nYH+QcqCMcTgCPinjzCGmn/e058GUfVVtb2ivSObelqEcK0JPciL6
	aPPXqEQe1apO9V+H8r8+Z7Gxxd+hRJjV7FdQUyqd5C1sbktI8v0SPR3iKMN0zGjs2vIvbrBSYGl
	viX4bCZqCEDfjbIwLMmQY0RRXz3SaWC6h+MCFYfzdwMYslwu0wt+LP697rMOXS9H2SrozUoLHjl
	k+4WKqWkt6kRE5f8BhQTwiFDtQjVUnd2bWPB26ntKlv/OANh7U83CtPEpU6xmMO7H1KfdTxonbP
	pjFuNeUUi65QA0gpH2grACd5yXC9zKfeN97PSgz6h76JfotO5UEDEyY+XXZYpHnLZxZGob+8r1v
	IPL3GxeIfTSRVXWIaQ2INBNZBpRgk=
X-Google-Smtp-Source: AGHT+IGea/IcFkG+vaNyLf95tzBj2KuTnXXoH/07XommnwBjRVX13r9SSjC9dhwtAj4nt1tMpgQ9JQ==
X-Received: by 2002:a17:903:304d:b0:25c:e895:6a75 with SMTP id d9443c01a7336-294cb3ecd57mr9577085ad.28.1761604190399;
        Mon, 27 Oct 2025 15:29:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm9803952a91.5.2025.10.27.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:29:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	xiaobing.li@samsung.com,
	csander@purestorage.com,
	kernel-team@meta.com
Subject: [PATCH v2 7/8] fuse: refactor setting up copy state for payload copying
Date: Mon, 27 Oct 2025 15:28:06 -0700
Message-ID: <20251027222808.2332692-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027222808.2332692-1-joannelkoong@gmail.com>
References: <20251027222808.2332692-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper function setup_fuse_copy_state() to contain the logic
for setting up the copy state for payload copying.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index c814b571494f..c6b22b14b354 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -630,6 +630,28 @@ static int copy_header_from_ring(struct fuse_ring_ent *ent,
 	return 0;
 }
 
+static int setup_fuse_copy_state(struct fuse_ring *ring, struct fuse_req *req,
+				 struct fuse_ring_ent* ent, int rw,
+				 struct iov_iter *iter,
+				 struct fuse_copy_state *cs)
+{
+	int err;
+
+	err = import_ubuf(rw, ent->user_payload, ring->max_payload_sz,
+			  iter);
+	if (err) {
+		pr_info_ratelimited("fuse: Import of user buffer failed\n");
+		return err;
+	}
+
+	fuse_copy_init(cs, rw == ITER_DEST, iter);
+
+	cs->is_uring = true;
+	cs->req = req;
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -645,15 +667,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
-	err = import_ubuf(ITER_SOURCE, ent->user_payload, ring->max_payload_sz,
-			  &iter);
+	err = setup_fuse_copy_state(ring, req, ent, ITER_SOURCE, &iter, &cs);
 	if (err)
 		return err;
 
-	fuse_copy_init(&cs, false, &iter);
-	cs.is_uring = true;
-	cs.req = req;
-
 	return fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
 }
 
@@ -674,15 +691,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		.commit_id = req->in.h.unique,
 	};
 
-	err = import_ubuf(ITER_DEST, ent->user_payload, ring->max_payload_sz, &iter);
-	if (err) {
-		pr_info_ratelimited("fuse: Import of user buffer failed\n");
+	err = setup_fuse_copy_state(ring, req, ent, ITER_DEST, &iter, &cs);
+	if (err)
 		return err;
-	}
-
-	fuse_copy_init(&cs, true, &iter);
-	cs.is_uring = true;
-	cs.req = req;
 
 	if (num_args > 0) {
 		/*
-- 
2.47.3


