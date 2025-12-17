Return-Path: <linux-fsdevel+bounces-71511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21DCC6249
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 07:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF3A307A857
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 06:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA662D6621;
	Wed, 17 Dec 2025 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x82hr+Ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E582D3EF5;
	Wed, 17 Dec 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951678; cv=none; b=BWlXIFVxUVIlQSMfxfONqB/7lorlrNTkciiYiU8XClmqTsgk7aWtEQfrDuS6PmSbGDo+SH8JXSbrBO3mg7KXgQ8vljnRCruuQ3s8sd7waRUg3/thwMN0Py+yMvaUYMsy3upNN0MhSwG6Oon4gYXNRKO1BO9OW5Mhxc8QA/m5BA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951678; c=relaxed/simple;
	bh=3C69r7wA13NdVzcBUo0o9loMrQk7urzw3+VTXMu81nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3v+kH72B2K53uMdNt+KlzFhL8WmqF5lQU6XOX0fjCqjoMPF30p2ZgHPgWDEszOuQRIcT1cexp09KwcRBGT9FP99Q5eLRghia7UPyRiqOq6+KVKGDIg9GcImaQNfVHsmIN9IkKxqkIrEqzkOBoDcbhbAJQzUyfWgtymzYnOg5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x82hr+Ln; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=psRHrhze/3ptSn5bWe85tmv5zrMTUHgEF2tcqcVJlxU=; b=x82hr+LnryZGsaXM2SvnX7Zxsz
	UVPT2WFtIbk9ek9UZm08uSHzOY4Tif4LSUju7PN5PdnfyGiCNBbsAEEWwI2KJNOVJVG1N3w6NqoHz
	G2bRIbiMV1hTq7VHGoK5ccZDuOkvYY8Z++bf+s19cXCT/Ozh5CZED+p8MaAWePGn/oxcyZzTXqD26
	Uinv0vPzPJ+ucD2wRW7O9OpL/8a9n4zH6OOxvSjMgVRhBeo2pcC0xBda9ia9jPxDavpCQID7FnsXZ
	hxmYMnMYv2vsPS9fN/2hSJkT20TJQS5dmzpplhEJKkJ2BwpCrN+tlK01+l0YIp1/R9s5FqkYGkE2P
	BeHgYdqg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVkhX-00000006DDV-3yFB;
	Wed, 17 Dec 2025 06:07:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 3/9] blk-crypto: add a bio_crypt_ctx() helper
Date: Wed, 17 Dec 2025 07:06:46 +0100
Message-ID: <20251217060740.923397-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217060740.923397-1-hch@lst.de>
References: <20251217060740.923397-1-hch@lst.de>
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


