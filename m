Return-Path: <linux-fsdevel+bounces-70511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F4C9D6D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66B6A34B07E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A1825524D;
	Wed,  3 Dec 2025 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG5kav/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033191B425C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722220; cv=none; b=SDG3JX7lvT2CM1fCshfU/NAPjK1N+LuzmggaOn04OX2AKnhrcvCBzsrEi7BdtE2zJumJguX7ld525T231Yo2AInPt0/4Vs6DA8IYh3eQ+RPoAR9FUNzOeF+/szkJdOoCe4Iy91jzV/pNIsWDtMLsWJujC3i5W1R9d3JKqNd5Ybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722220; c=relaxed/simple;
	bh=7StnbW/TqmHUc1vg9s38n043pYlTzeZZxclo5H0fKUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coFYcwrRTVOwhLac93LsG+dMR7adAJOh1yPQzgZYYi+eFae/b+qjyXxTenQ0RMr85hL90sZuEdxlUYpisChlgm84nARgdr7ck7/Kt+Fcnz2RGYZupVxDkou9gnqDszMyo9gjEHNGtWL08tFKxIa2948YOX5z5OjrOQR+BV5fccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG5kav/y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-295548467c7so70901395ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722218; x=1765327018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+ttqcfQ3T5zSOFv2YhovKb1gWr/JPYacZE2ZQZbU7Y=;
        b=WG5kav/ywz0DiDVAsvWBTFcoSZZ40FNMd1iyFGkYx6uL9amvehY7/6ZRx2QwUdaIR0
         kKBb2hD9D/OMSR/y7f2NSZmqO2s3rIYoUWg4u8bKhtil1q5U1UNFBGkwYrr49uClmkks
         AhSbDRmnxY087sNQ8yzytzUylUtxJWPRjtp69BnPVat0OIdWOiC7a7PlPb/mQkhGYEcC
         NPYIyr9+L2ig2ZZcakLeC7a6ZacvwuS8lLLqxK+gQcZIIemhEdxNKn8tzpcKiyGdNvm+
         JdL4BmenQo1a/Eq4TfQ/gQasmmCWRc/YIxAfVT6EpzPRO6h7+qQNjJTUT3phZlGLHeY9
         uqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722218; x=1765327018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+ttqcfQ3T5zSOFv2YhovKb1gWr/JPYacZE2ZQZbU7Y=;
        b=kGobtOZGyEJxPrXChJ1eMTdrPtB2yxkMfbyeqlAMbFuOPuLmzacvQ6ZDONUSybhUxO
         ueRH3LuQgOeC9rJw09ci1sDkGbZP3GkQeCQnAE2E8EC7M+ypfPE7JXvbyntL51wT8ZB5
         5c7T1cSLaE46lKowt+T6f2DT0+EJP2Ysg2vYVRWwTtwfFA/g2ORHAwyiC1Accvbd00D9
         TiqAAZ5iXDiebLEdb4TU4UeZPyIn2hnX6b58jpdnY/O3iKR9qtOVI8uJYGqlU6Ty9rKU
         fQGvWOD/4l7ni24RvO/xgohRjK7/XCSXWm3NFDCfYT7bx4bOpxnO0sd8y3Ms9SKQRz8l
         0gFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbE4gckGsCeJoFOrIGAwl75WJlvLGjtJS/oT8r6JTo8J5D/9CRqdAxISega37BCpZaFX2NxEA7h24DEMjH@vger.kernel.org
X-Gm-Message-State: AOJu0YygP9I0zcaVpW1JB1MaCCfpFo9YIB/unmBjLeHqui1GHxtawYID
	3rYirR3HtkPSCR6m6kgKNmQM9clw7WBy7RJTtTo11CMZLz2Zo2PjL26i
X-Gm-Gg: ASbGncuRHj+Dy+3a6G/hyCCO6dP7SSGYg2a7lUO3t/t7/36+yl7Q5z/XsiP/13vMm4L
	Z/U5JK+QZ7ej7gdhoU75Kf92yoDlGjQOXeSfeeThw+ezXNwRwBiMvNEqx463pciAS+gq9O92qAw
	1qyc2NLiOohVjUqem4y1uxidC/uHF3jsiSgYex9QhuyZUm1zeDK0JpnvHDZgKLVWwglCeTQvr5B
	MyKM7WlAxYez9N7bvr9mCzQ1QggqbZMdNBMA/Eu8bVplheGeu2oRPzTs4XovuAKeEQsDL8H0LLc
	y9ue6YNSktFlqc8S63YYrfzx2vN8q6Rt6+GBeeB2AEE7uS7LFntvgm+/wVJFyeYvaArc3lXV/X6
	9RSAiF89ZFZGuETrPWy54nqpucLngQXCZr+TdS/N8ijEo6H5GRsUA5C/uzS20BM7kurSzSFOZOU
	pq2hvX1fyYkETp9+ws5g==
X-Google-Smtp-Source: AGHT+IGJU3HgWRI9UHKPjckJ3JBE+66C1T7M/Dkm7JlcooakJDntbx5JY2gxwKnBnmyKaum49h0T4g==
X-Received: by 2002:a17:902:f60e:b0:297:d4a5:6500 with SMTP id d9443c01a7336-29d68391c85mr5750825ad.26.1764722218273;
        Tue, 02 Dec 2025 16:36:58 -0800 (PST)
Received: from localhost ([2a03:2880:ff:15::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb471c6sm163749065ad.79.2025.12.02.16.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:58 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 17/30] fuse: refactor io-uring header copying from ring
Date: Tue,  2 Dec 2025 16:35:12 -0800
Message-ID: <20251203003526.2889477-18-joannelkoong@gmail.com>
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

Move header copying from ring logic into a new copy_header_from_ring()
function. This consolidates error handling.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7962a9876031..e8ee51bfa5fc 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -587,6 +587,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
+static __always_inline int copy_header_from_ring(void *header,
+						 const void __user *ring,
+						 size_t header_size)
+{
+	if (copy_from_user(header, ring, header_size)) {
+		pr_info_ratelimited("Copying header from ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -597,10 +609,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_out,
-			     sizeof(ring_in_out));
+	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
+				    sizeof(ring_in_out));
 	if (err)
-		return -EFAULT;
+		return err;
 
 	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
 			  &iter);
@@ -794,10 +806,10 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_from_user(&req->out.h, &ent->headers->in_out,
-			     sizeof(req->out.h));
+	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+				    sizeof(req->out.h));
 	if (err) {
-		req->out.h.error = -EFAULT;
+		req->out.h.error = err;
 		goto out;
 	}
 
-- 
2.47.3


