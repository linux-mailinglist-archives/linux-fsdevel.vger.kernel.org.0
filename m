Return-Path: <linux-fsdevel+bounces-78912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFJjMsKfpWmuCAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:33:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766A31DAE89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67FBB30CB12A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754D3FFAD6;
	Mon,  2 Mar 2026 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RPkSqP8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031D13FB060;
	Mon,  2 Mar 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461171; cv=none; b=q6jml0McRdbNX+4WKRlk/0WfdEobseoKQsWbLobACjyd8rt+M4syRfzoc8B/8bxuuEAl5sI+4+YgSpaWiKEgJnXiWPnPDPDxYUUGXVa9dHvTRQiyce6rhVdVQF3Ga0EZ7uLvTo3+TUy+4g2EuL2nDq+UFuXT+re1QFRZSOYoJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461171; c=relaxed/simple;
	bh=ycETKq43DpDTS6pqEAeAXW6xLcI9EA3r+aBtlSaWA4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXJZWUHJ7QibfZQ9I/T/Bs85GuTTi2RLGhB8CEh38VONOpWBMv6RHyYr2gYCCIkfbVX6WgbDVyEkuW3q70ioMxvC/A669X6CgHbVtvfU6rOFfZAIhJAOn3m2jCx9jNgno/K3jp2fk0TFXXjSgwgkvrI0yG/jrjloDOQvM4cGirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RPkSqP8d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=48teM5i6x6CJSM3TGQYT8hhQxdMcjJfXJZ8vD9qJOdY=; b=RPkSqP8dHSz24530yzuWpRqsGz
	ePeHTyYaqLuZRrEgzv1lL0ApgmPV2NZL34ErG9ihgs8AypsiazDD0vOSrubqi1QWuXWAhTWimSiuk
	TZ/A0UmKJTQOExo9/DO0fYCSN9+2hWeX819DxkAN/UZa/l/irMkUncTBtNtx/sngDmt4TNueewXQk
	rM8C0MHadezqEDMLmvyi1JPd6I2iibtRcsFkAFpPgUBe7CzNt86/kgYosxt9kZEcfZAH+Y1nZ01EW
	lIcS0IGbCBhtQBej5DNlsNDVoE13WRmmxU22OW21ZaCglh12Cht5Q4pPDCzNutU+gIfsM6TXgI6OP
	lKWqnUTQ==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx47N-0000000DDSL-2kqP;
	Mon, 02 Mar 2026 14:19:29 +0000
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
Date: Mon,  2 Mar 2026 06:18:10 -0800
Message-ID: <20260302141922.370070-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302141922.370070-1-hch@lst.de>
References: <20260302141922.370070-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 766A31DAE89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78912-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

fscrypt_set_bio_crypt_ctx_bh is only used by submit_bh_wbc now.  Move it
there and merge bh_get_inode_and_lblk_num into it.

Note that this does not add ifdefs for fscrypt as the compiler will
optimize away the dead code if it is not built in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c              | 21 ++++++++++++++++++-
 fs/crypto/inline_crypt.c | 45 ----------------------------------------
 include/linux/fscrypt.h  |  9 --------
 3 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 22b43642ba57..b6504ec7fa4c 100644
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
@@ -2800,7 +2818,8 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
-	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
+	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
+		buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
 
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


