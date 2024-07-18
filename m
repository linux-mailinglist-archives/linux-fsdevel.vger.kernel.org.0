Return-Path: <linux-fsdevel+bounces-23970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B679370A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F165028263D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766D71465A9;
	Thu, 18 Jul 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a51ZezBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB112C7F9;
	Thu, 18 Jul 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721341816; cv=none; b=l4j8uT0D4lNfkA3Gim+kUTGjnuAmilPygBsR4a0g7e+FPfdi5ZvAyJ7GeYT/Z+7A7+TiuBhlzKVDX2nlqV6LTG0EJ3TQnQKRVehoHxV+JlNC1otXRCu22jwPmahyaMX0DNAABhB4F/u34+oonJgfGG6WYbsndEF3QO2MR6ds4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721341816; c=relaxed/simple;
	bh=o0NaNIeiAwoMK0tdlVRQ2XECLQ8sujzDe6q2yqShEqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUymsfvUX12rjbU7DWJEebRjmO9Rx3P0bTWp26ChQ/ZPDEMteHU7wceFyxRNy+VBRjYhZl7ZEEVNY5U3GLP7/9KwJopQLiJqIK1pGowWqX34ydQBjRvjhI4OjnwW8+wRiIE9RaTz1Txq+dCfN4eQuAQkLdiH/dYCiqvqjK3MvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a51ZezBO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=QBUu+Xp3I/nU2Djswqu3RCczuHPZt6WlvefziDrASGE=; b=a51ZezBOOalk0RUWtW8T+Gn0Wb
	neNFrSWCNLvZUGl9oFuPeQMDmhVt2oEG6WSytb/o/0PLxoBoeR2GMlkXbhKBx571jJHwj9j46EEOo
	chgqt2xbh0a+TzCdM/Ocno80Jq6lI/tri/H8KQbmVDICtPofDsMU9zDWiGWcCnkaPdPhvciYRPya+
	qmc0e+89HJVTHrY/TIo626GoOQiHNo92WguCm43E3PviPEFRQANaHpStmdIPYpRJSaR29Cx0gHpyB
	axCMF0CmUh6Znz4C+HyVxAxq28uYm9X8KvscSVHE0H0axgHa0EeReOtzZP4RtWxgLz36daqY2P6vi
	RgwnDqfA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUZdW-00000002O0M-3cnz;
	Thu, 18 Jul 2024 22:30:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 1/4] ext4: Reduce stack usage in ext4_mpage_readpages()
Date: Thu, 18 Jul 2024 23:29:59 +0100
Message-ID: <20240718223005.568869-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is very similar to do_mpage_readpage() and a similar
approach to that taken in commit 12ac5a65cb56 will work.  As in
do_mpage_readpage(), we only use this array for checking block contiguity
and we can do that more efficiently with a little arithmetic.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/readpage.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 8494492582ab..5d3a9dc9a32d 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -221,7 +221,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
-	sector_t blocks[MAX_BUF_PER_PAGE];
+	sector_t first_block;
 	unsigned page_block;
 	struct block_device *bdev = inode->i_sb->s_bdev;
 	int length;
@@ -263,6 +263,7 @@ int ext4_mpage_readpages(struct inode *inode,
 			unsigned map_offset = block_in_file - map.m_lblk;
 			unsigned last = map.m_len - map_offset;
 
+			first_block = map.m_pblk + map_offset;
 			for (relative_block = 0; ; relative_block++) {
 				if (relative_block == last) {
 					/* needed? */
@@ -271,8 +272,6 @@ int ext4_mpage_readpages(struct inode *inode,
 				}
 				if (page_block == blocks_per_page)
 					break;
-				blocks[page_block] = map.m_pblk + map_offset +
-					relative_block;
 				page_block++;
 				block_in_file++;
 			}
@@ -307,7 +306,9 @@ int ext4_mpage_readpages(struct inode *inode,
 				goto confused;		/* hole -> non-hole */
 
 			/* Contiguous blocks? */
-			if (page_block && blocks[page_block-1] != map.m_pblk-1)
+			if (!page_block)
+				first_block = map.m_pblk;
+			else if (first_block + page_block != map.m_pblk)
 				goto confused;
 			for (relative_block = 0; ; relative_block++) {
 				if (relative_block == map.m_len) {
@@ -316,7 +317,6 @@ int ext4_mpage_readpages(struct inode *inode,
 					break;
 				} else if (page_block == blocks_per_page)
 					break;
-				blocks[page_block] = map.m_pblk+relative_block;
 				page_block++;
 				block_in_file++;
 			}
@@ -339,7 +339,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		 * This folio will go to BIO.  Do we need to send this
 		 * BIO off first?
 		 */
-		if (bio && (last_block_in_bio != blocks[0] - 1 ||
+		if (bio && (last_block_in_bio != first_block - 1 ||
 			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
 		submit_and_realloc:
 			submit_bio(bio);
@@ -355,7 +355,7 @@ int ext4_mpage_readpages(struct inode *inode,
 			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
 						  GFP_KERNEL);
 			ext4_set_bio_post_read_ctx(bio, inode, folio->index);
-			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
+			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
 			if (rac)
 				bio->bi_opf |= REQ_RAHEAD;
@@ -371,7 +371,7 @@ int ext4_mpage_readpages(struct inode *inode,
 			submit_bio(bio);
 			bio = NULL;
 		} else
-			last_block_in_bio = blocks[blocks_per_page - 1];
+			last_block_in_bio = first_block + blocks_per_page - 1;
 		continue;
 	confused:
 		if (bio) {
-- 
2.43.0


