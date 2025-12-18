Return-Path: <linux-fsdevel+bounces-71650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC35CCB02E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 09:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6451030443F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4F33554E;
	Thu, 18 Dec 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG6+e7tg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A3335545
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046913; cv=none; b=e/96mbnbSBJ3z9RDTIyjwGpEfyJ5PRLzg00H6VI8BIffd2MiiZrRojVA+G986AA8UiKhTdmgAdjzHSySHp+fPAI1NkwLAVwAE9UG3Ms2vSXJAmJQP9g1oClr0BmiCXkgwSAl7dQcL4JQHGThm9SN1JNxPSXGeqg7mU5wRitSKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046913; c=relaxed/simple;
	bh=B9APPXwi+eJBx+Ec0dRjt1miIrzkozSsJ6sKE8vwZ90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ei+TKNLm4faBUrqrmqHJfWu0sJBie40xdm4TYcGSP7/zr8OaMtmljiCKRaPMSMeFk3CbJyVffqf/nmGX5LZzxNgW7ediCFu0ro9GorIln34yXkniAge4E+0Zfs/rtKLHwl7zw5kZ8tPzTYJu10NlAPfKGco9mwHWRVwUgyOgTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG6+e7tg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d52768ccso5085795ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046911; x=1766651711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwBseqLH0uMsJxr1t7ix8hlpS0RKO5SEcBlVQRvGPv8=;
        b=JG6+e7tg5y8ZlKgFWcGdmINNF5vidFxLrqImALJAjCov96obtmoBB91MJndH7e64Gt
         5vG3pLF1VDYXEbj0jknu6xjKJhkRafN/uGJxC+/ORtJqNSrSdpTK37VeJj8Q4xZOiP5Q
         gEtPF7yUadY5CYvG2cS0OMjDrdr5BxoCGbZNP39vSYlrsL9Nbjz9inj8Wr8huTgx1rcl
         wWbgqjGSy1nwfRDLVCjmfKJqkPJn0dPw0w9JWwS6XvQt1rdvhAm1ncdNqcUappnXdZHy
         VX81YS00NNfSa0casnUFaGSdVcWWcvowA9F/HW0/CfF+HqIiIzn2a6ee1J0p7WkJVpAh
         AR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046911; x=1766651711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwBseqLH0uMsJxr1t7ix8hlpS0RKO5SEcBlVQRvGPv8=;
        b=rAUYwUSTA+dlB/6pFwFMuvfRBNBO82xTxKRk+hI3STGsYW46gAc+o+7g9+bqp0p76P
         eSiHcwpzSjopGRJYCCABuLVFyWhsA/gay/kPfCrR395XAejeUeRfuWw4uXjwTbJBOKQn
         y/sKlmxhJKDy4IM9Z+vwMfer7FtwlMZ0r7xlALDKpsthjofhZoStEph2fxQq9wEnUVj+
         VtXO2tRs6eDO5DQ8nxbscwbLWEE2XPEEJHz/ZXSAG1w4qyN+15PNtW8kls2KfOP+7tJn
         /vwWBeND7NIfG9K9b32GCXrb4wWpxF/Cdf7JV1tTegCa6OxUIMvMkDfSHEz2eg6JBosY
         IBxA==
X-Forwarded-Encrypted: i=1; AJvYcCXBTwxnsNIrN4lWtemxGATViWVoNKy5Dq3Cw4meQt6JZxU6/f6bSOciCnaa6q8VeQPC4AbPwK83nlwLIHdt@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNhncYMhjChvqEosDr6CgKYurcf7xKrjO+rus5g7XZxjkHh57
	MeQI42sRictkdf/gS9E01uZ9m+QI8RMtz7mN0wbUlK9LnnMNd5XyDlyF
X-Gm-Gg: AY/fxX69wtNP7VmBDeQekbo4BZiYWMuowtax+J5IliQoUgTT1q2y4yVibWmuVHXaHXI
	VzZ+IQC0UJHKK9yrkuDmXcPVwLBgwBnFbO5ox7iwm07yDJYGwAVZNvwPQp1wYOC6JPqX3z97/6z
	mOj9ysyYS572XkOOx6OLTwoNLS6oq9iN6I010T4Cpp21Uv1NiJQAChp6Is6f2+a4TYBa0lHLjJF
	YJnnXx4GJFgEJ3ULz0ippCVZRMMHe/L31UJJLhNRRMhsun5VmYLZXmFHHN2mGFq8OX8PBKL6R2y
	gz/IrdyWsu7RWY8Gs+mNOFu6AIjlbvXAEhdp+FL5s35YB/CW0UpYPNQ3QJqH4TIeac0mA/OPl8z
	HLpMFyrcnKL+Sd60Bf9f2x3HM9CGN1QeYx1EatWWlSR+OB7Q6gpcQ4ew/F+m7OBoXgqYpmJJRz9
	80tkoNzdr62QxN/PAKUg==
X-Google-Smtp-Source: AGHT+IHoVg2UB4W+wK1o/yVZ1iitUqVbh8LsXegUulBfxqq7MiSErTit7co6M4w9NH592cwABGRUjQ==
X-Received: by 2002:a17:90b:2fc8:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-34abd6c0333mr18535043a91.1.1766046911191;
        Thu, 18 Dec 2025 00:35:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e76ade944sm620643a91.1.2025.12.18.00.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:35:10 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 23/25] io_uring/rsrc: add io_buffer_register_bvec()
Date: Thu, 18 Dec 2025 00:33:17 -0800
Message-ID: <20251218083319.3485503-24-joannelkoong@gmail.com>
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

Add io_buffer_register_bvec() for registering a bvec array.

This is a preparatory patch for fuse-over-io-uring zero-copy.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/cmd.h | 12 ++++++++++++
 io_uring/rsrc.c              | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 06e4cfadb344..f5094eb1206a 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -106,6 +106,9 @@ int io_uring_cmd_is_kmbuf_ring(struct io_uring_cmd *ioucmd,
 int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
 			       void (*release)(void *), unsigned int index,
 			       unsigned int issue_flags);
+int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct bio_vec *bvs,
+			    unsigned int nr_bvecs, unsigned int total_bytes,
+			    u8 dir, unsigned int index, unsigned int issue_flags);
 int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
 			 unsigned int issue_flags);
 #else
@@ -199,6 +202,15 @@ static inline int io_buffer_register_request(struct io_uring_cmd *cmd,
 {
 	return -EOPNOTSUPP;
 }
+static inline int io_buffer_register_bvec(struct io_uring_cmd *cmd,
+					  struct bio_vec *bvs,
+					  unsigned int nr_bvecs,
+					  unsigned int total_bytes, u8 dir,
+					  unsigned int index,
+					  unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 static inline int io_buffer_unregister(struct io_uring_cmd *cmd,
 				       unsigned int index,
 				       unsigned int issue_flags)
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 5a708cecba4a..32126c06f4c9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1020,6 +1020,33 @@ int io_buffer_register_request(struct io_uring_cmd *cmd, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(io_buffer_register_request);
 
+int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct bio_vec *bvs,
+			    unsigned int nr_bvecs, unsigned int total_bytes,
+			    u8 dir, unsigned int index,
+			    unsigned int issue_flags)
+{
+	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
+	struct io_mapped_ubuf *imu;
+	struct bio_vec *bvec;
+	int i;
+
+	io_ring_submit_lock(ctx, issue_flags);
+	imu = io_kernel_buffer_init(ctx, nr_bvecs, total_bytes, dir, NULL,
+				    NULL, index);
+	if (IS_ERR(imu)) {
+		io_ring_submit_unlock(ctx, issue_flags);
+		return PTR_ERR(imu);
+	}
+
+	bvec = imu->bvec;
+	for (i = 0; i < nr_bvecs; i++)
+		bvec[i] = bvs[i];
+
+	io_ring_submit_unlock(ctx, issue_flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
+
 int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
 			 unsigned int issue_flags)
 {
-- 
2.47.3


