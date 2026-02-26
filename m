Return-Path: <linux-fsdevel+bounces-78513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC+wIzleoGleiwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:52:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 326401A7FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C8A0307FCBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 14:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C33ECBD9;
	Thu, 26 Feb 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WD2hAWDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498643D648A;
	Thu, 26 Feb 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117406; cv=none; b=pYLP+M2inwOCvJs/kSrQrnAkLVvjgXQJm35as9UPEAODsdlpCm4Pl6EG+jzx2byG1L//DvrE8911zruLF9HcgbkxGLstykAEJH4gXxnSGh9OF/B9WVWUzdvb1Wl/2qrelvWeP+p9JRRdSpgjIdQfnbuyK8Vu/T5yzbpM3MEodVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117406; c=relaxed/simple;
	bh=a9kiXdjvq6UfW10zPhPKudv8Hrk8JkrGAR66A9U4GtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZhqgSdcXaNyQORn2+vwH7/+mDRC255pE+WFJwfL41C77M4doBDXg6f1nHZCgh7i5YDVZVLezKY7+EFjhwYf+oKyAtHMRuaTa9DqVaYZ2Iz0ejWNODfm4rXnrwI/MC6cgiX1t5INbqdwgIii00yYhZqaGU8S0ttWVfZ8XLXGqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WD2hAWDX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jMlyxtcz6WIjnQqyapNMfaGWmhwuknHMBJcb1rjwf+c=; b=WD2hAWDXyrq6jM+bGywnN2rfW4
	2X6F6uoBNS+rQjXGEH23BY8m3xNcl5KiITvhsv9sAybOjUjCG1+4zGoMxl71B5RHRgrM3orgSogZb
	fh0MoF0MYfrgcnbvxr5d/2LJCeSS7TT8D3bnvHpAlG/jVLxZgL6EERM8dpz0zi9866XWqTprHUV4/
	TRatB/2ouEJkZwp2P5j0BG5HZ3K/SVopDgu7PaXJC/Y87ixHim2pHekA1gKiXwKsVr8/WRYsGqhKZ
	teJTJmy2rZXiOrb6C+ueQmeHn6XHixbHB3OUnBElk4LLVT27ev+zx8jVIvtn2iKzl978UbRngDPu1
	ymT5TGlQ==;
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvcgg-00000006Ncc-3UsG;
	Thu, 26 Feb 2026 14:49:58 +0000
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
Date: Thu, 26 Feb 2026 06:49:34 -0800
Message-ID: <20260226144954.142278-15-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-78513-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:mid,lst.de:email,infradead.org:dkim]
X-Rspamd-Queue-Id: 326401A7FBB
X-Rspamd-Action: no action

Replace the next_block variable that is in units of file system blocks
and incorretly uses the sector_t type with a byte offset, as that is
what both users want.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/readpage.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index fbfa4d830d9a..c94240c91282 100644
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
+		block_in_file = EXT4_PG_TO_LBLK(inode, folio->index);
+		pos = (loff_t)block_in_file << blkbits;
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


