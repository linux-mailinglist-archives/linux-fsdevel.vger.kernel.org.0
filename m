Return-Path: <linux-fsdevel+bounces-73002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 862ECD0753F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 07:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB4A0301267B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 06:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E229DB8F;
	Fri,  9 Jan 2026 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TFX4X7Fx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F3273803;
	Fri,  9 Jan 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938911; cv=none; b=Ofii1ufLVQWU/l4zIgurypYq/c9CPYY8lN9Suu8d4AoUPBMjdqiO32BCKYCAszVz2SlVr7gTwxO/D+WEkbUV1jxNM2GwCOvV3MGS+FT0AZRs/7YoQwsrSL9DW+gvmJgIi2IdrGuCMgnRLkCQPN/4662YIqL6ZAw1fL7beNrZ3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938911; c=relaxed/simple;
	bh=ZDkdYmRenwf2/ahK6XWnQCRDBYk9OAY+48SIqNHnLUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md1+Pkvk0452Bqxv6s74dWXB2+GzX2uphZJsMNS2poRgeQTOTM119hR5AxPKdMkZJkWXoUlUnzGlV9xEblQNG+VlW/NrD2n5FugU8bhlqww1BqO5XqWAcRzWV4qIVUME+kpPH+QOPLHF56bgDMYtS/Ph660Um1dOI2rYig8XdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TFX4X7Fx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KR1uwigR+MBTXhuRop6ZaVSGaITX2KW9Iuq87Vf3d+M=; b=TFX4X7Fx7gaVL6a9AwLZsJayer
	lR6bz+U3cFedDeMThIiEO61hC4MxKKc3YbTXOWKPt96Ys43H6KK+DiyRSAvy7RDuGX0TWhOGevrzW
	SLxbVR152uZ39z++eG2kIKziTji7tciDOu5auTkkk28nKAdTHyMCdY94Q6wx8CTL9UKpYm4sXfW3g
	l5KVWJ/wrvx1c4C9BePr82P9oNV3eMszbeVm3DuCvnE/ZFyi404n4hUI6GS4cZLD6p/PElfWe17n5
	zYRcFk4yEYMkw4o8rU0dB4sZPlUSRqPPCdX8WNTR+UpuL71mnBEB458eBTq3dx/UrH4jHa5o87enj
	iNsliQbQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve5fg-00000001WUJ-44UB;
	Fri, 09 Jan 2026 06:08:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 3/9] blk-crypto: add a bio_crypt_ctx() helper
Date: Fri,  9 Jan 2026 07:07:43 +0100
Message-ID: <20260109060813.2226714-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109060813.2226714-1-hch@lst.de>
References: <20260109060813.2226714-1-hch@lst.de>
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


