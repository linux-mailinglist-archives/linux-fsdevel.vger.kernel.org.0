Return-Path: <linux-fsdevel+bounces-70504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29454C9D6A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89CBE4E4E9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0623D7E6;
	Wed,  3 Dec 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTtzBa7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE123E320
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722207; cv=none; b=lQO2H/0Y7D2Y5L9ifAPuXt/UHjsODq/LMvmDflrbDTrBDVBR4ImiiI125K+tFN9C3IUHMIwjlpKDlWo7gSk5akSGUjgLRy3lJEs5okTRO8Wv/l/DH8HBEGhbYTK/2KYY0yobALbglF+Mrx0adVyg+gXtbrPrX8GYidJmbe/QW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722207; c=relaxed/simple;
	bh=JeZ4PnbcXkAe0cXmwfgERZlf11yTWQRHwJFaB/D/uYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNpFXq0WEQ3VKfXhjMRzlKHGO2jbQGmsLi34oyAd8Y9bwhOJOlwWyfsEh7lCgtljmII7eqkQRpFlVlfh/zH7w9PVT9/gyv6481azOfANrWqe9yeV20sC2598SHmVx48nRB7Y4x3ZEHFcr3ztaNBWikbwiPNUHby/eU/scb99MgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTtzBa7M; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297d4ac44fbso2097965ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764722206; x=1765327006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhOeHkxPrbMQ325EQN88eJBPNWjEdCqlX1NTe94cSAg=;
        b=FTtzBa7MQSiODxbJ2KOlGCaFp2gRQxZHKt6KZZRa/nJUvaSGdTXxYaP4pkJmd4z17E
         lxeEV0jdYn0lyWqEJgtGNfYmXDG5uDNiss8Y7hMhUVQFDnsM1SqNy0S9c2NmasRs1Cln
         D24h5wi8Nv2LndjNRR2FMQr+kJb4LswaoxBUm2IND7NdTxgXRyL2EuARrPjRxKBfGpSF
         /vY1q8jTVEvHWS+I4j5vpJJ9bxl912wEXFeknFGcsyEw8W2UYsWR1ufWSt5e+E+kgWMP
         RhWPfAEc23QjQNFX/Ch8li5MWOAWaZoEESaZxclJtZ3ELTxvoxdkdXSg1vrXVcjkvBzP
         Qvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764722206; x=1765327006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhOeHkxPrbMQ325EQN88eJBPNWjEdCqlX1NTe94cSAg=;
        b=kSEvW0BDKhWUVn68R7vzKlJJauirpJ8nP81pbtlhGBkyNjjZPOQvokIKCkYLWJQU3X
         gp7vnBQjQNvbNJC97HPCRuntzcInXwP4GU1Uwo820ZNOhv00iSE2kNpzhMSzvpuBeMNr
         sJbiGLTX9QzBAk1CGHbfSCaXcPBMl5ENDhFHxyKs1IT0Voi7YP1VE6qbRsrIjjgniLLz
         nKx/enoHTVtMAj3mwla2dQowLJvBZuy3ZDqRw4Uk/d7EbQkFDMrtWeu/TlG5YzAVXWZz
         8Qkyo30YDGsQ6A5fx0qe3GUFMXngZMuDqSm9YG+Ate7pxjJkSfTAgmjXstGFP7UWbYVX
         EVDw==
X-Forwarded-Encrypted: i=1; AJvYcCXamF5c337T4Y6a4Cd90p81FXFZ1f01RS4f7OiHBhx7ohPsypjyDdQrqvXJbPEl9M22iILYZV+98S3GmidX@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7XDCNnZla23ZFw6JyOv8HegydKzyeEz6IPPZ9GVHM9pDgUkn
	6bZ56C6pqsHUCQvVuz50mB9eny2kCYhaN2DDOWaZxa1W5qyw32ysfswR
X-Gm-Gg: ASbGncsfh0Q0DBEYPkx2Jep4GG8nJKM4XqkkmJo+jp0tJUikk3+Dh/KnSjq805GbW+Y
	sWAQBhsNVZt2SmJLF7NZ9iCpDEBfD7d2MvHuzNUzCjjSOOtnoLtKnB1GCofP4E90L9iwhJ0a6rF
	538xkia5igmFbeySlAcEHP9be9LZRFbqkcu4zL9i/HUa3V7GblSDvU9Y78gmrT3LUSA1GShV9rB
	/a6cCpsiLsUYALUkI47eCCsWJBt4ujq5vtwa5MKP0svRA26aUIbDPt4pHynvHfpBnV6y7QzGG6i
	WFKLGD5GfxAYLAmkbKdrkMoR/Ry3XA2p+XlC3uTvklHQth91BRkUkl4TJB21Vtosmx1X87xuz8g
	bJcdmvMflztT2DK80Uz+Ed8aTZjvh/WJ4pogdqpRnIdPoIPhiiEXxBM6wWRfHSggQZgGXj0QQh2
	Jl0XGWfYIuPFzw4icz
X-Google-Smtp-Source: AGHT+IFm66sV0bCwR9D2cpB1eAqwDxIT+UzLH5S+F1k9kNLhunb2p23f/etFoavE3TH34UOHIQXMGg==
X-Received: by 2002:a17:903:b8d:b0:269:7840:de24 with SMTP id d9443c01a7336-29d5a5cff47mr44466035ad.21.1764722205742;
        Tue, 02 Dec 2025 16:36:45 -0800 (PST)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34910ba58a9sm623645a91.8.2025.12.02.16.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 16:36:45 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	axboe@kernel.dk
Cc: bschubert@ddn.com,
	asml.silence@gmail.com,
	io-uring@vger.kernel.org,
	csander@purestorage.com,
	xiaobing.li@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 10/30] io_uring/kbuf: add io_uring_is_kmbuf_ring()
Date: Tue,  2 Dec 2025 16:35:05 -0800
Message-ID: <20251203003526.2889477-11-joannelkoong@gmail.com>
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

Add a function io_uring_is_kmbuf_ring() that returns true if there is a
kernel-managed buffer ring at the specified buffer group.

This is a preparatory patch for upcoming fuse kernel-managed buffer
support, which needs to ensure the buffer ring registered by the server
is a kernel-managed buffer ring.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring/buf.h |  9 +++++++++
 io_uring/kbuf.c              | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
index 839c5a0b3bf3..90ab5cde7d11 100644
--- a/include/linux/io_uring/buf.h
+++ b/include/linux/io_uring/buf.h
@@ -16,6 +16,9 @@ int io_uring_buf_table_unpin(struct io_ring_ctx *ctx, unsigned issue_flags);
 int io_uring_kmbuf_recycle_pinned(struct io_kiocb *req,
 				  struct io_buffer_list *bl, u64 addr,
 				  unsigned int len, unsigned int bid);
+
+bool io_uring_is_kmbuf_ring(struct io_ring_ctx *ctx, unsigned int buf_group,
+			    unsigned int issue_flags);
 #else
 static inline int io_uring_buf_ring_pin(struct io_ring_ctx *ctx,
 					unsigned buf_group,
@@ -46,6 +49,12 @@ int io_uring_kmbuf_recycle_pinned(struct io_kiocb *req,
 {
 	return -EOPNOTSUPP;
 }
+static inline bool io_uring_is_kmbuf_ring(struct io_ring_ctx *ctx,
+					  unsigned int buf_group,
+					  unsigned int issue_flags)
+{
+	return false;
+}
 #endif /* CONFIG_IO_URING */
 
 #endif /* _LINUX_IO_URING_BUF_H */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 82a4c550633d..8a94de6e530f 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -945,3 +945,22 @@ int io_register_kmbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 
 	return 0;
 }
+
+bool io_uring_is_kmbuf_ring(struct io_ring_ctx *ctx, unsigned int buf_group,
+			    unsigned int issue_flags)
+{
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
+EXPORT_SYMBOL_GPL(io_uring_is_kmbuf_ring);
-- 
2.47.3


