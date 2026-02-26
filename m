Return-Path: <linux-fsdevel+bounces-78514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALaIB1dfoGmmiwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:57:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4461A81AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E815B3196DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946043ECBE0;
	Thu, 26 Feb 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JP1VyVt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BC37B407;
	Thu, 26 Feb 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117406; cv=none; b=hI9wF8bjzAI8/Fg83i6sQcK+NiNyTSEgybIsScZf9azZ9J4g4IKF4c01XUIqHPqhcRSsk6jfwdwHDW4BremXGM7xJpCSApetbrxt+79lCjfwoMHl1V+P+wu+unJjdO3pv6DCVqGtkPP+cthTCGr8IxBP4Ng5liLB9mhywKDs5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117406; c=relaxed/simple;
	bh=+wHiVyfSOQVJKi++Q69ibDVdlloP+2QKxdOPc8jjpuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF7gzXN8Fan0eqgK0hCHUdnxlzLErFNGMDYfHdQ4Ty43x6dlOTbJAq6olmaVBfNTo2hhEA71LSb2vfu9x0jYsJN6PzDOROZO7O83g4b5DVNGLDk1sA2zH0ET4eHHjx/bTGlt06BnCsJbG3bi5fbOldUklX04xe8FjglDI4O7ePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JP1VyVt3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9T8HNQ5u5iYA6DgMe/kaeMoku+2OmLLlwAsb6+NA9LM=; b=JP1VyVt3zwEEQbAowV64xybWA3
	OgUVIFMKZzw6LY26jZrodv4pBs2w4X6qFDcBLhiFWXue+S0WEVep7B+e/SUEiDqpCoNsHqHXmhvG9
	T5lavSkohaBVNsJqoe29FBNxUp1yXJ2G5Pi7ch4qdt6+Qa8uawg0kDnbmPtawAPdQHvRkjhvGvO0d
	sS/v0YYh+lyagDjmMQWLyrCtH9xEIGKfR2kFDMZMJdmTNENb7OMUqc2m42UeO4dtVR6iwK9yK2awV
	VBnfqB8K1zuLVx1d1yeADn2u9RQhoK4K94jxGZD6fi1oD+39ogV8buk/egyR2EFkKndSh0H3zvBMm
	0apa/NEw==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcge-00000006Nad-1NUx;
	Thu, 26 Feb 2026 14:49:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/14] ext4, fscrypt: merge fscrypt_mergeable_bio_bh into io_submit_need_new_bio
Date: Thu, 26 Feb 2026 06:49:24 -0800
Message-ID: <20260226144954.142278-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226144954.142278-1-hch@lst.de>
References: <20260226144954.142278-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78514-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,lst.de:mid,lst.de:email]
X-Rspamd-Queue-Id: 9A4461A81AD
X-Rspamd-Action: no action

ext4 already has the inode and folio and can't have a NULL
folio->mapping in this path. Open code fscrypt_mergeable_bio_bh in
io_submit_need_new_bio based on these simplifying assumptions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/crypto/inline_crypt.c | 23 -----------------------
 fs/ext4/page-io.c        |  8 ++++++--
 include/linux/fscrypt.h  |  9 ---------
 3 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index c0852b920dbc..0da53956a9b1 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -406,29 +406,6 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
 
-/**
- * fscrypt_mergeable_bio_bh() - test whether data can be added to a bio
- * @bio: the bio being built up
- * @next_bh: the next buffer_head for which I/O will be submitted
- *
- * Same as fscrypt_mergeable_bio(), except this takes a buffer_head instead of
- * an inode and block number directly.
- *
- * Return: true iff the I/O is mergeable
- */
-bool fscrypt_mergeable_bio_bh(struct bio *bio,
-			      const struct buffer_head *next_bh)
-{
-	const struct inode *inode;
-	u64 next_lblk;
-
-	if (!bh_get_inode_and_lblk_num(next_bh, &inode, &next_lblk))
-		return !bio->bi_crypt_context;
-
-	return fscrypt_mergeable_bio(bio, inode, next_lblk);
-}
-EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
-
 /**
  * fscrypt_dio_supported() - check whether DIO (direct I/O) is supported on an
  *			     inode, as far as encryption is concerned
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 88226979c503..3db3c19a29e5 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -441,11 +441,15 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 }
 
 static bool io_submit_need_new_bio(struct ext4_io_submit *io,
+				   struct inode *inode,
+				   struct folio *io_folio,
 				   struct buffer_head *bh)
 {
 	if (bh->b_blocknr != io->io_next_block)
 		return true;
-	if (!fscrypt_mergeable_bio_bh(io->io_bio, bh))
+	if (!fscrypt_mergeable_bio(io->io_bio, inode,
+			(folio_pos(io_folio) + bh_offset(bh)) >>
+			 inode->i_blkbits))
 		return true;
 	return false;
 }
@@ -456,7 +460,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 			     struct folio *io_folio,
 			     struct buffer_head *bh)
 {
-	if (io->io_bio && io_submit_need_new_bio(io, bh)) {
+	if (io->io_bio && io_submit_need_new_bio(io, inode, io_folio, bh)) {
 submit_and_retry:
 		ext4_io_submit(io);
 	}
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 516aba5b858b..6af3c1907adc 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -876,9 +876,6 @@ void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 			   u64 next_lblk);
 
-bool fscrypt_mergeable_bio_bh(struct bio *bio,
-			      const struct buffer_head *next_bh);
-
 bool fscrypt_dio_supported(struct inode *inode);
 
 u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks);
@@ -906,12 +903,6 @@ static inline bool fscrypt_mergeable_bio(struct bio *bio,
 	return true;
 }
 
-static inline bool fscrypt_mergeable_bio_bh(struct bio *bio,
-					    const struct buffer_head *next_bh)
-{
-	return true;
-}
-
 static inline bool fscrypt_dio_supported(struct inode *inode)
 {
 	return !fscrypt_needs_contents_encryption(inode);
-- 
2.47.3


