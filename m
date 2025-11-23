Return-Path: <linux-fsdevel+bounces-69584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 462ABC7E881
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D973D3446DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 22:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8626D27FD43;
	Sun, 23 Nov 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpmGMvm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372327FB2A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938307; cv=none; b=RJ/RIKWdG0CN6e1zATZ2WDG+zKE8CX+i8UUFfH9BMK7Y50NkGimVz0cj+aDcWO1eJWndv8LUS4Dmdz+7Se9lCoN4c7/35DKe0YjekWS7Nm8Hh7xifrbLlW4pn7ISWJLAyeQlBE92mb04wt3mESB9ZSyEfzRG5krxM2qm8KbmLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938307; c=relaxed/simple;
	bh=biIYoLFZIunfY+RjkNduyhE0he3gpQJOgrFilhAOH4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD9gTcVI+gQMDhAjIswLC58sEbsfHgqE3RNdjKmUpphPgNM5dT0kQVXsc8Ai3qCg5qlcdj6HHezB28uuxtFnbLvr5HvolD+yAcWWMhj7f0O6oEgDKxs0ZHRDe0XmAIsA3ZverP5crYQth1VNeJ58U52aWGRREgZ32XQwr/q2PUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpmGMvm3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b31507ed8so3157885f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938304; x=1764543104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb2Dznv7cN1HWvl69eUL3qKJ9duXd8EJVDjyGYBP64I=;
        b=WpmGMvm3Tt0Y2XyUxUpwW2d5teUAZCtS8tXckR5X/RDdFiEfJCS4kG6UaJnYUThtom
         hVeXn8TIJ9meTxceBvBKwkHciPinGwCqfv3wjWwIf+m88DPx3FN4hpvukifhHXo98Zgf
         Z5WVvQboSs4e2gH8x979VuM5bzCFt6GmbE24Kvbr4tFLnXRGk/0iExyengLb2OvbRPVc
         TDwO+nPjaWdkwTGWQsEJozk5nUZ1UUcVRUS05QTkW3lCmRFGs3QFAmSHXsGZmUKgcjnC
         LGqCFndJS+bJKiRwz7ujKWxSlhm7A/S03RXh/ctR3jiEVpK1SkHNGZ36PnMNEchv4zDe
         naPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938304; x=1764543104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eb2Dznv7cN1HWvl69eUL3qKJ9duXd8EJVDjyGYBP64I=;
        b=BxiiUyWct9m3hjcNpk5Wsq78f4rfl6BcIjrjGjF+3i8sZ2PkaqgtEqGXQK0cbgjFyA
         j7wVSr4a90/gawUSVH2nroQsFltPmc538wR8a+DqjKr1/kj0kTISxELViO3IoKOBzo1A
         7RDeKz2b2TDIKzNrxDkgNvR9FSpJ6FvzBxzba1mFrQZaV4w0abCN+0VoIREAcAjzFyuT
         bXZZ17EsR1OyGWGZXyqeEWApnArZHDfCi7AX02v7wl830QVTn1CHPdiUaRDjpn30AoJd
         b0eNEwgL/xPWycAdvcjGnJHYgpw3fLF3eOG1gvmPhGpHxHhtBBpj8exBKHEPLr4F9M0X
         0Oww==
X-Forwarded-Encrypted: i=1; AJvYcCXn8CxbBd2N/o0iSCfQBuaFgmUlQq+sHIfPi2uKcMAK7+KfWEnI6FLES/rLRjsiFGcBEdJ+7GecUm1bLF2M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5BOwPeKYNpC600lez238lNnPBCcg7ozng9weFKV3O+jeVua1D
	2RC9HJWMnvkfl8Z8h/yhMeO/iEgAr3Q9ZWh9TU3mAvsx3Ngsug3g6VHO
X-Gm-Gg: ASbGnctmOmJNAGrtAqto25H4Vjp8rG7wD739b5rh1lcElCyXLQfezzg6qdgZsGuOmK4
	ac+e+96aqd5Bu1NrlF+Igw/o5dPkaMPs6Mm7/eC/nTQdURYwScrN9r3hCggnRVYqJS79evubdML
	if2q2mp9UboypVs9E12X/hfwI8c34AxFoMT8sx//V5zL1a32d0zYrzxesw+6JJTPlOgaCPUrMPq
	ZLlA4i5RLNykWgwHP3YPTrVRJ5CRx2ZgNNxDHY7OtrKIk5qDznq8Q0wpARn0KgykE1rPkZ5du0H
	AW+A69aUcHC67OU8zmKLfNTipHvZgSn+BWirMnf8U8NguoGSi6yx1eKLVqa3dLjsHe7pp6o0dF5
	wGNCuJH8bziYm0E0IgkC1akxJETg4AH0YD2TtBhr05fAz0+F4lfy+2hyX8+kaChMkMY4n4l22Xs
	471dEElZ8QiFfnWQ==
X-Google-Smtp-Source: AGHT+IED8z7T9BZIQ3+G6TZGcukyRm9aG9PTE7rjzPMs+94mQ+eXcoj3xDrYuPfTG51yWGc4ynh5VQ==
X-Received: by 2002:a05:6000:601:b0:42b:5592:ebd1 with SMTP id ffacd0b85a97d-42cc19f0b39mr11000772f8f.0.1763938304146;
        Sun, 23 Nov 2025 14:51:44 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:43 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 02/11] iov_iter: introduce iter type for pre-registered dma
Date: Sun, 23 Nov 2025 22:51:22 +0000
Message-ID: <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new iterator type backed by a pre mapped dmabuf represented
by struct dma_token. The token is specific to the file for which it was
created, and the user must avoid the token and the iterator to any other
file. This limitation will be softened in the future.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 10 ++++++++++
 lib/iov_iter.c      | 30 ++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5b127043a151..1b22594ca35b 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,6 +29,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMA_TOKEN,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +72,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct dma_token *dma_token;
 			};
 			size_t count;
 		};
@@ -155,6 +157,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dma_token(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMA_TOKEN;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -300,6 +307,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
+			struct dma_token *token,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2fe66a6b8789..26fa8f8f13c0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -563,7 +563,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
+	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
+	    unlikely(iov_iter_is_dma_token(i))) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
@@ -619,7 +620,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
+	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
+	    iov_iter_is_dma_token(i)) {
 		BUG(); /* We should never go beyond the start of the specified
 			* range since we might then be straying into pages that
 			* aren't pinned.
@@ -763,6 +765,21 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
+			struct dma_token *token,
+			loff_t off, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMA_TOKEN,
+		.data_source = direction,
+		.dma_token = token,
+		.iov_offset = 0,
+		.count = count,
+		.iov_offset = off,
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -829,7 +846,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	if (likely(iter_is_ubuf(i))) {
+	if (likely(iter_is_ubuf(i)) || iov_iter_is_dma_token(i)) {
 		size_t size = i->count;
 		if (size)
 			return ((unsigned long)i->ubuf + i->iov_offset) | size;
@@ -860,7 +877,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dma_token(i))
 		return 0;
 
 	if (WARN_ON(!iter_is_iovec(i)))
@@ -1457,11 +1474,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dma_token(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dma_token(i))
 		return;
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
-- 
2.52.0


