Return-Path: <linux-fsdevel+bounces-72433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6ACF712B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C191308360D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D030ACF1;
	Tue,  6 Jan 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kMFBKB7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42131307AC6;
	Tue,  6 Jan 2026 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685033; cv=none; b=EPMK+q3js6PolotqPZoviHRX7SsNPWAbq/xoP/GZPr9Ug1FTZlMmjnFllaeKi3e75cWbPtR/D4QhS+1OJryIOyrxNjthEmaENMqOCDRcM4QkTgvfAp5+nw31ei2ckx5hwiNi/uiMDGSqFLkhmn1dafgI1clTUZLinsgTtitvj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685033; c=relaxed/simple;
	bh=ZDkdYmRenwf2/ahK6XWnQCRDBYk9OAY+48SIqNHnLUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtLiFuuK/DcE/qHA49mT2aE01skv0Og2po7E4EDU4kfoCLaew+b4FdfKypbv2veB5jCBXyO62CZwPqclIqTW7BFIWkgV4wEngAL5AQJG8tJPCipN6eRKF0DUiAMuZzlC5Xg+IemqQpjtRvS8Ktfcvvj0KSBOclSvXmoPNcCc3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kMFBKB7e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KR1uwigR+MBTXhuRop6ZaVSGaITX2KW9Iuq87Vf3d+M=; b=kMFBKB7eCpoZtWHFAw2FrcMZK/
	KUYnY34tlaAiPBHLiPlK2irdQGn5CG3duURKeXbLIeJqnEmMKWTn0D9ccjY4GxQ0NHUGr+7UbJksC
	LYh/Psf2dBWooXsOk6eGI/8LvPxyM87f21NOZSFb6q8e6q3TK3Zc9dRnmUwvD4MnNaMElyKDIBQEK
	wG8PJgvvZ0lLp1i79Bti80Hb/8ENZUxGvcMUH17MSk9FriGDuDoH8IBVQa/KyptOwsfSPmsc4NWoG
	RY7WT3HRt4zGw8FndrzFnpOp25le+clB7Z2FSQG1dzAdU2BLn3/zs7efnQJCTM5NRiqhQ+H2GrvvN
	8MnxxPKQ==;
Received: from [213.208.157.59] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1cq-0000000CWfK-1pO4;
	Tue, 06 Jan 2026 07:37:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 3/9] blk-crypto: add a bio_crypt_ctx() helper
Date: Tue,  6 Jan 2026 08:36:26 +0100
Message-ID: <20260106073651.1607371-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106073651.1607371-1-hch@lst.de>
References: <20260106073651.1607371-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This returns the bio_crypt_ctx if CONFIG_BLK_INLINE_ENCRYPTION is enabled
and a crypto context is attached to the bio, else NULL.

The use case is to allow safely dereferencing the context in common code
without needed #ifdef CONFIG_BLK_INLINE_ENCRYPTION.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/blk-crypto.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 58b0c5254a67..eb80df19be68 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -132,6 +132,11 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
 	return bio->bi_crypt_context;
 }
 
+static inline struct bio_crypt_ctx *bio_crypt_ctx(struct bio *bio)
+{
+	return bio->bi_crypt_context;
+}
+
 void bio_crypt_set_ctx(struct bio *bio, const struct blk_crypto_key *key,
 		       const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 		       gfp_t gfp_mask);
@@ -169,6 +174,11 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
 	return false;
 }
 
+static inline struct bio_crypt_ctx *bio_crypt_ctx(struct bio *bio)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
-- 
2.47.3


