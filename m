Return-Path: <linux-fsdevel+bounces-71642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DBBCCB001
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DAFC30DF9F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F203F33374F;
	Thu, 18 Dec 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0KugK9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4995332EC6
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046900; cv=none; b=grqv8CKjn+XdEoxNE6fgvMAlofN0jXkHWA9dfFT7PKGraEaunRd3YCHYktqpqvI8rUYUSFMTn8yiX+EIVoNbgSOopssf0QCgpn+QDYapw3qGpVgoJtIRA4UjkgC5hT+e+rYXquhXyVzzjiM30aqUC1MBZ0oSRhGs+IpzXvR1LsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046900; c=relaxed/simple;
	bh=7StnbW/TqmHUc1vg9s38n043pYlTzeZZxclo5H0fKUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeTm1EMXVTq1j9R4ZkNT4zqhfHtl80HXOhtVB9BmF7rWJT14njjoFsifLB6qLJaBpix/WUTNi/B+t/icbBuuq2KAO+D5TDmGn7POjc6gxP2e4JnxYAWHKG9WZE0IhmA8OYKxo6CKe57l2lhSTrixqz2qrjGzYkyUY3Hyq3oBKRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0KugK9t; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7f651586be1so184780b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046898; x=1766651698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+ttqcfQ3T5zSOFv2YhovKb1gWr/JPYacZE2ZQZbU7Y=;
        b=N0KugK9tOdYGzUHsOwqr9DmP+SWLO8WWZVowDrU9sLHBy4wwhha3ACwkBzW/KAPTdD
         gfPxQ6sxKQkzwybE1QQd+ZHl7htnQvGQj5evvAgm4jwzITsl9RtR6jy8YB13DejdWPL3
         puoQRLlQe61Dacjyq/QxZeufWvoyXuPBjqV6tf/6KstlxyQVGPUGI4NZROMpBju6GGD0
         7FbCMAAYLapERdixGyZrH3mQSWxAcI1u6hAyp0YGxJVzZkMI22BR/NP2ecZYhdlpRXiJ
         X7hy9AXOhWvUyamfuGbWKuv5cE5rGp5aVxJe8CPOGbETqEwW+SzdCUaqUSmKo5Nn/6CP
         ws+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046898; x=1766651698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+ttqcfQ3T5zSOFv2YhovKb1gWr/JPYacZE2ZQZbU7Y=;
        b=L2IGwVYpKzhblNdaoLSLZ+r1wsPVetz3ay0U8UXfoK1L+NYHAAiAU1wADipxIdTPeQ
         1pEE2blJvxfJwVpFYlPb635JVH0rP9lCb9LWMfoeAFmh+Pm7i+U9XYPg5DcR40CcrUeE
         Ytg4EJ8Zetc/95WtFW5VjjaDeSeiQPED6n6HdeVp6I8xj8tvPfUlq1feZwNP8UP4tuvm
         8aiF/l42IXgVIQvrF8w/B7sTkFn0uqHFGz3XxE40cZ12f75kxYnihpbbEwmdQkrsEmcP
         rIIZmwtKlw9qMIGXMqo+28P3NnBuK7DgP3YuzwsyzcgsNA9mGcTFxDC8b6UpbvE56i/V
         2smg==
X-Forwarded-Encrypted: i=1; AJvYcCU20q8gXQFrfdsivrKUDdMQ6z2/x6S+FjtrZsAPNNniRD64EgYZRBs+ZWHdvm3Z2Y4ECMrOmgEa+Di6Na+W@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JfM7c2BXRiPrQaJxomXFvMtmwJrWZCr8eczQ+QxjShJQgbpG
	Yc+Bd+uuzX0JRWQdnTSRguaxAxoF8ezOdGTBmyY5kV233d997ev4XYBS
X-Gm-Gg: AY/fxX4ppdylrpZmuQZQCHsIG59cMh/6Il716ow1UMuahpcb5fNZvl1q90sKwh4y8OQ
	A3YffQrww5HlkS7JDUFC6AiHw1pG+64uYGPJRTSqlNkmmemnYBnMHhOS5T5jA1BbPbDBiNlycEQ
	mKFvyzmSJHbCtOyVNePuIIri/KfUjrvRPVIpWFi7kvLB6kqEX8F90ROYUOkuS2jcewJO1xSGIDT
	f1Tc4h5MZr9pqKgrSYewDD5ru7BFgJnzKrxS9aBVKR21phQtQg4iAilxN5adpTuorskh5XVnqKX
	AJcEsDJgxDFKAwsNb51N3u1rMz61fz8KlPDcbqn7FxCG2ZgQytj/90Obz9rHoNJqDDgAmMdyjJn
	FuMw1dsdYq5e1kYuKXHkM3mkjvrmA06wyAmPhF1eOQfFU2bYjumsCG+0te+fQCla+qhNGUpEUf0
	fEUlJ3KOuc+YS2BoXe7A==
X-Google-Smtp-Source: AGHT+IGflvUvbRqj691OgeeRGG+UleojOkhVANr5XQtfBQ+hxT+uGIMoTJKgwed4n3+IKkNOnet/Rw==
X-Received: by 2002:aa7:9384:0:b0:7a9:acdf:e8f8 with SMTP id d2e1a72fcca58-7fe0b73a260mr1581948b3a.4.1766046898286;
        Thu, 18 Dec 2025 00:34:58 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe121222bcsm1844070b3a.19.2025.12.18.00.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:34:58 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 15/25] fuse: refactor io-uring header copying from ring
Date: Thu, 18 Dec 2025 00:33:09 -0800
Message-ID: <20251218083319.3485503-16-joannelkoong@gmail.com>
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


