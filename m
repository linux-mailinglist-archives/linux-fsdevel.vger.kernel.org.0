Return-Path: <linux-fsdevel+bounces-78509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLt7CkNfoGmMiwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:57:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD351A8181
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 392B33182292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57F3E9F71;
	Thu, 26 Feb 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ctTCM4rj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383F3B8BBB;
	Thu, 26 Feb 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117405; cv=none; b=QS9doaHtu7Qi4Uu0PkEennz55HwgpULyhPB6yzuxBS9Ve5+tnygfOUpQ4IfGdQDAv9qkQmb30FLmkbMlhZq7BXka4VGaFBtwWVonUN4+oz1Du3l7pz7j2WRVA5YwfmFxXxDsjqzlUb5Naf5BpZGw9LZZO8qv8z+cpo8OZAjZD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117405; c=relaxed/simple;
	bh=AsTIaSQu/1kXpFmFjWmkg7hJApX1I7id4O2ZcwElPBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFMwwpoTZ+yW5B2urNj2C2ZjAI9UpzZLtV/xjLnLzaRcsmNHcKoll9e7IEOWGSKmadtD3sCP+gb29H9RY+QNtAL5FrkyviR6J9HHXltQY1CSJpEoDLTXE2JmgVbtLKS2uQc7Qcg8Fd8OGwnudx2Fp2NLc00f4hFzkaVzzoXqjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ctTCM4rj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HYH7IXtg5WEXSc/Ro+lNu3MZ+FCmDyb9EfIJuB1zma0=; b=ctTCM4rjh2DaL15Bbtrr3BpL49
	2w/IMm24YHUwNlQ6hKBUWleFUOt16zIvoTUVYcjdxL4a6s1XamU4jvUbAGz9FtSoHRuKAs96MS2k3
	/YzEOPseHaBeC0Lh88HE0ApxFqCH1zwcEBwOK0ae4xKAxoNyCkWi+13Y3XyiRVQ/bn2heplBaqYju
	hVLHUe/l86DE+ULJgktaOnFzCQ/VSo1FR2Ted8g1EpkPEInckRXE2Q9qefasfNRUN8psjW0tRJy4O
	kaNXi+aMcT3wMHZcDoGjSgTGoDyVR0M8n7Phfka6TMIFGsdMzKZoQokiTLsLOFKDDN3e6N6hrbRvA
	bFoZQHIg==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcge-00000006Nam-2AUg;
	Thu, 26 Feb 2026 14:49:57 +0000
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
Subject: [PATCH 05/14] fscrypt: move fscrypt_set_bio_crypt_ctx_bh to buffer.c
Date: Thu, 26 Feb 2026 06:49:25 -0800
Message-ID: <20260226144954.142278-6-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-78509-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 7FD351A8181
X-Rspamd-Action: no action

fscrypt_set_bio_crypt_ctx_bh is only used by submit_bh_wbc now.  Move it
there and merge bh_get_inode_and_lblk_num into it.

Note that this does not add ifdefs for fscrypt as the compiler will
optimize away the dead code if it is not built in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c              | 20 +++++++++++++++++-
 fs/crypto/inline_crypt.c | 45 ----------------------------------------
 include/linux/fscrypt.h  |  9 --------
 3 files changed, 19 insertions(+), 55 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 22b43642ba57..e1e95463e06b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2774,6 +2774,24 @@ static void end_bio_bh_io_sync(struct bio *bio)
 	bio_put(bio);
 }
 
+static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
+				  gfp_t gfp_mask)
+{
+	const struct address_space *mapping = folio_mapping(bh->b_folio);
+	const struct inode *inode;
+	u64 lblk;
+
+	/*
+	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
+	 * for a non-pagecache page.  fscrypt doesn't care about these.
+	 */
+	if (!mapping)
+		return;
+	inode = mapping->host;
+	lblk = (folio_pos(bh->b_folio) + bh_offset(bh)) >> inode->i_blkbits;
+	fscrypt_set_bio_crypt_ctx(bio, inode, lblk, gfp_mask);
+}
+
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 			  enum rw_hint write_hint,
 			  struct writeback_control *wbc)
@@ -2800,7 +2818,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
-	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
+	buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_write_hint = write_hint;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 0da53956a9b1..702d13d138aa 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -314,51 +314,6 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx);
 
-/* Extract the inode and logical block number from a buffer_head. */
-static bool bh_get_inode_and_lblk_num(const struct buffer_head *bh,
-				      const struct inode **inode_ret,
-				      u64 *lblk_num_ret)
-{
-	struct folio *folio = bh->b_folio;
-	const struct address_space *mapping;
-	const struct inode *inode;
-
-	/*
-	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
-	 * for a non-pagecache page.  fscrypt doesn't care about these.
-	 */
-	mapping = folio_mapping(folio);
-	if (!mapping)
-		return false;
-	inode = mapping->host;
-
-	*inode_ret = inode;
-	*lblk_num_ret = (folio_pos(folio) + bh_offset(bh)) >> inode->i_blkbits;
-	return true;
-}
-
-/**
- * fscrypt_set_bio_crypt_ctx_bh() - prepare a file contents bio for inline
- *				    crypto
- * @bio: a bio which will eventually be submitted to the file
- * @first_bh: the first buffer_head for which I/O will be submitted
- * @gfp_mask: memory allocation flags
- *
- * Same as fscrypt_set_bio_crypt_ctx(), except this takes a buffer_head instead
- * of an inode and block number directly.
- */
-void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
-				  const struct buffer_head *first_bh,
-				  gfp_t gfp_mask)
-{
-	const struct inode *inode;
-	u64 first_lblk;
-
-	if (bh_get_inode_and_lblk_num(first_bh, &inode, &first_lblk))
-		fscrypt_set_bio_crypt_ctx(bio, inode, first_lblk, gfp_mask);
-}
-EXPORT_SYMBOL_GPL(fscrypt_set_bio_crypt_ctx_bh);
-
 /**
  * fscrypt_mergeable_bio() - test whether data can be added to a bio
  * @bio: the bio being built up
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 6af3c1907adc..26561b7994e0 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -869,10 +869,6 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 			       const struct inode *inode, u64 first_lblk,
 			       gfp_t gfp_mask);
 
-void fscrypt_set_bio_crypt_ctx_bh(struct bio *bio,
-				  const struct buffer_head *first_bh,
-				  gfp_t gfp_mask);
-
 bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 			   u64 next_lblk);
 
@@ -891,11 +887,6 @@ static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 					     const struct inode *inode,
 					     u64 first_lblk, gfp_t gfp_mask) { }
 
-static inline void fscrypt_set_bio_crypt_ctx_bh(
-					 struct bio *bio,
-					 const struct buffer_head *first_bh,
-					 gfp_t gfp_mask) { }
-
 static inline bool fscrypt_mergeable_bio(struct bio *bio,
 					 const struct inode *inode,
 					 u64 next_lblk)
-- 
2.47.3


