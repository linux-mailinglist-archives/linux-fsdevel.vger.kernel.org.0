Return-Path: <linux-fsdevel+bounces-78921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGDxAfOcpWlfFwYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:21:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C19381DAA72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A5E93033D60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD7A411601;
	Mon,  2 Mar 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K0b2ahEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FC407571;
	Mon,  2 Mar 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461180; cv=none; b=BsEntHhgcu2FBH4A6m/F5dfY3d8yUs8NbGp3os/f1tUXmDUl1DSy9htb1EoZkRFeC2gwv/st/naddlHmR696x2kEaukwJtWzllssvPZ3IdXMya7ER9o5auBZ4LL/hY4I6jaco4mwshFQZqB2NBaSKAETvlBHpZnbt69uEXYeRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461180; c=relaxed/simple;
	bh=GJ7xMQyJNm1BKHhuCssv2BRVwRQR+OZcUMneEqKOvWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChmFXhUoEx9NE7UpbZxPcDag3Fr2O3Vx1jcEURd3Gn/+8FvxF2gtzHjXK9nkCDlxrfGBuXDn9hq7tHvQNrlooF5QxThVSmLi3wYjOw+22GXDtbq8/O6g8a63eZwDd/PaNIo7c+vEgWGZrxVO4JdyHw6Oywm5DBWYt0c8bToQ7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K0b2ahEK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eLjGK7IWGAcBMQnMUjvBRs0k7XXMOQi2JJHsMlMBoE4=; b=K0b2ahEKH3jaHPbt9ekfLMUIom
	Lyl1rkQo08KVUDOJXLgZWWIZlbLqIiQTN2oatQaSLDd0z5c9gdLQRxqVYt5PZgAQ0rCB9YMVll5L6
	v5zHMTfAqlfLfwYkIDccIRIWmXMv518kqSc2V0blugQBv/UuzOpYbjBl9v8ZRtoIi9WJC0uaNgzLP
	eDY9683WvpZ73FiQX2eU2YkfIHzXNqgztuGzU737hk25GvHzBRQ+PQRo83nqBDv9l5SWoakCpwiLm
	0Q9yWuOh104dye070X5m6UPzIu1IZV1iJpQ3b7dqRUsqGdzk7TitZTeZnZPiOmizCFWrMDvi495JT
	JjLHd3xA==;
Received: from [2604:3d08:797f:2840::9d5f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx47W-0000000DDUR-3Lb6;
	Mon, 02 Mar 2026 14:19:38 +0000
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
Subject: [PATCH 14/14] ext4: use a byte granularity cursor in ext4_mpage_readpages
Date: Mon,  2 Mar 2026 06:18:19 -0800
Message-ID: <20260302141922.370070-15-hch@lst.de>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78921-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: C19381DAA72
X-Rspamd-Action: no action

Replace the next_block variable that is in units of file system blocks
and incorretly uses the sector_t type with a byte offset, as that is
what both users want.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/readpage.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index fbfa4d830d9a..6ec503bde00b 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -215,11 +215,11 @@ static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 	sector_t last_block_in_bio = 0;
 	const unsigned blkbits = inode->i_blkbits;
 	const unsigned blocksize = 1 << blkbits;
-	sector_t next_block;
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
 	sector_t first_block;
+	loff_t pos;
 	unsigned page_block;
 	struct block_device *bdev = inode->i_sb->s_bdev;
 	int length;
@@ -249,7 +249,8 @@ static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 
 		blocks_per_folio = folio_size(folio) >> blkbits;
 		first_hole = blocks_per_folio;
-		block_in_file = next_block = EXT4_PG_TO_LBLK(inode, folio->index);
+		pos = folio_pos(folio);
+		block_in_file = pos >> blkbits;
 		last_block = EXT4_PG_TO_LBLK(inode, folio->index + nr_pages);
 		last_block_in_file = (ext4_readpage_limit(inode) +
 				      blocksize - 1) >> blkbits;
@@ -342,8 +343,7 @@ static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		 * BIO off first?
 		 */
 		if (bio && (last_block_in_bio != first_block - 1 ||
-			    !fscrypt_mergeable_bio(bio, inode,
-				(loff_t)next_block << blkbits))) {
+			    !fscrypt_mergeable_bio(bio, inode, pos))) {
 		submit_and_realloc:
 			blk_crypto_submit_bio(bio);
 			bio = NULL;
@@ -355,8 +355,7 @@ static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 			 */
 			bio = bio_alloc(bdev, bio_max_segs(nr_pages),
 					REQ_OP_READ, GFP_KERNEL);
-			fscrypt_set_bio_crypt_ctx(bio, inode,
-					(loff_t)next_block << blkbits, GFP_KERNEL);
+			fscrypt_set_bio_crypt_ctx(bio, inode, pos, GFP_KERNEL);
 			ext4_set_bio_post_read_ctx(bio, inode, vi);
 			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
-- 
2.47.3


