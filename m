Return-Path: <linux-fsdevel+bounces-19596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E58C7BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 20:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766A6283813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079E156F24;
	Thu, 16 May 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="anPjU8zL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7C156642;
	Thu, 16 May 2024 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715883416; cv=none; b=FLVsLq2fHNsMbIYtaBL7W6vqIXTvdb91Buhd4F9qNcvOwSRwAXXb8i0/uGNXlJKf2DnP+r5GCEpNR+cDDqFSukwgkvsj6PSSAHo4qGLuK/zs3YQD+MuFUhGzipdfVHvF5+e3znd9GCmR2hj5OvLL8zLlC/Xn0QnZXlCW+ZTJ574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715883416; c=relaxed/simple;
	bh=IaEjMgOVijGUZoGyXC7Q6OgPYaSmUBlPNgF4/dQAhoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8ZrcLgr5+7fRpYa0o/rydNbDCk0OwrbI85e0AB3u4KC9lYBicxq3p/n52scwudkwkC17aHbRToEUo+snsHoWSQEc/6R10jQ8/55upDUrru5bulOCDLDXaCYnqejDNxJ41AsH/qJe/EFkq7Xm4Yvzw7rGBHAcS3H3+moRP4Kj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=anPjU8zL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Y/edxhwNxm+fnNhJDhofEY2JZfiUKbns0R5IrxVHBQ0=; b=anPjU8zL5WYWX4jBhpypmYYAdb
	fZ/Ywc4jDb1syTNzS6y2yn7wgzguG9yRkt1KckNb+eXmjVs6W+kCo/B1MvTyQkAeMO5nd7uK5Nldu
	jaFjppwCxjJyFWxPZwCIXKv02tdkELcdVRQ8cSGSK9pyWEjQSWr0hPuhlI5FxPON9xq8Xm+fZJ8SJ
	xHrxps2wBsp4M433u5NUF3eortZ/QtTlfflYxeWFhafWdA/FE742KWcbcWEpAx76qW0ihbNXk7wJA
	cwAWFgsdooM0hK2kLt78Dkr6bPb8qYNpeRsvCheOaGCBEiHLPvZ/srL5D39RANa1PtWp5WrP0w7Kl
	L91EaeHg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7fet-0000000C5A9-32Ko;
	Thu, 16 May 2024 18:16:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/2] ext4: Reduce stack usage in ext4_mpage_readpages()
Date: Thu, 16 May 2024 19:16:50 +0100
Message-ID: <20240516181651.2879778-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
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
index 21e8f0aebb3c..fe29fb23a1d0 100644
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
@@ -308,7 +307,9 @@ int ext4_mpage_readpages(struct inode *inode,
 				goto confused;		/* hole -> non-hole */
 
 			/* Contiguous blocks? */
-			if (page_block && blocks[page_block-1] != map.m_pblk-1)
+			if (!page_block)
+			       	first_block = map.m_pblk;
+			else if (first_block + page_block != map.m_pblk)
 				goto confused;
 			for (relative_block = 0; ; relative_block++) {
 				if (relative_block == map.m_len) {
@@ -317,7 +318,6 @@ int ext4_mpage_readpages(struct inode *inode,
 					break;
 				} else if (page_block == blocks_per_page)
 					break;
-				blocks[page_block] = map.m_pblk+relative_block;
 				page_block++;
 				block_in_file++;
 			}
@@ -340,7 +340,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		 * This folio will go to BIO.  Do we need to send this
 		 * BIO off first?
 		 */
-		if (bio && (last_block_in_bio != blocks[0] - 1 ||
+		if (bio && (last_block_in_bio != first_block - 1 ||
 			    !fscrypt_mergeable_bio(bio, inode, next_block))) {
 		submit_and_realloc:
 			submit_bio(bio);
@@ -356,7 +356,7 @@ int ext4_mpage_readpages(struct inode *inode,
 			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
 						  GFP_KERNEL);
 			ext4_set_bio_post_read_ctx(bio, inode, folio->index);
-			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
+			bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
 			if (rac)
 				bio->bi_opf |= REQ_RAHEAD;
@@ -372,7 +372,7 @@ int ext4_mpage_readpages(struct inode *inode,
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


