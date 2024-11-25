Return-Path: <linux-fsdevel+bounces-35779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850BA9D84B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D23167384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB19D1AA7A2;
	Mon, 25 Nov 2024 11:46:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBA191F7A;
	Mon, 25 Nov 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535194; cv=none; b=R+y7eEc9PYFjhJ6vcYr+9PlhxhlgC2U5RYn8oiaB6urwvDf2x6hu2TeY9Tkkh4rWozQdjZHqE1EUKBrdXDUZQMZb2nOAIkBjRXffvTryIwNH26SiDPX/vGbIiJo/1w+MXAVcoCPqdYUjmGQ5tIHHB2smgZwZR7up8fwe97YanEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535194; c=relaxed/simple;
	bh=ZrquhWqppx0zkMcjlbReT7o51+YTL16rEUOas3S79JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avSeXP9V+Bz7j/IJhkSE27WFL+Bk0V8TnbQjGmoRKm27PuiY+LxEI5TKD38jAbX+pIygDaMJf3KC7Cwhr70IWe2kmGDJTT+fnwlv6Of02ZV/0p03N0UTUgfU9+hlPUGZVAGvgsb5PncpLVSKpH32fcXTxGXxOESVzofpZaATv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XxkS03Dgfz4f3n6H;
	Mon, 25 Nov 2024 19:46:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 154701A0568;
	Mon, 25 Nov 2024 19:46:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4eFY0RnNicrCw--.44046S6;
	Mon, 25 Nov 2024 19:46:27 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 2/9] ext4: make ext4_mpage_readpages() support large folios
Date: Mon, 25 Nov 2024 19:44:12 +0800
Message-ID: <20241125114419.903270-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
References: <20241125114419.903270-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4eFY0RnNicrCw--.44046S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXF48CF1DWF17Cw4kKw15Jwb_yoW5tFykp3
	yakFn5Gr4kW3s3uanrAF4DZr1Sg347CF48GFWfXr1fWFy7J34Sg3Z7Xas5X3W5trs7XFs5
	XFW3JryUJF1DXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUADGOUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

ext4_mpage_readpages() currently assumes that each folio is the size of
PAGE_SIZE. Modify it to atomically calculate the number of blocks per
folio and iterate through the blocks in each folio, which would allow
for support of larger folios.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/readpage.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 5d3a9dc9a32d..f329daf6e5c7 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -227,24 +227,30 @@ int ext4_mpage_readpages(struct inode *inode,
 	int length;
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
-	unsigned int nr_pages = rac ? readahead_count(rac) : 1;
+	unsigned int nr_pages, folio_pages;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
 	map.m_len = 0;
 	map.m_flags = 0;
 
-	for (; nr_pages; nr_pages--) {
+	nr_pages = rac ? readahead_count(rac) : folio_nr_pages(folio);
+	for (; nr_pages; nr_pages -= folio_pages) {
 		int fully_mapped = 1;
-		unsigned first_hole = blocks_per_page;
+		unsigned int first_hole;
+		unsigned int blocks_per_folio;
 
 		if (rac)
 			folio = readahead_folio(rac);
+
+		folio_pages = folio_nr_pages(folio);
 		prefetchw(&folio->flags);
 
 		if (folio_buffers(folio))
 			goto confused;
 
+		blocks_per_folio = folio_size(folio) >> blkbits;
+		first_hole = blocks_per_folio;
 		block_in_file = next_block =
 			(sector_t)folio->index << (PAGE_SHIFT - blkbits);
 		last_block = block_in_file + nr_pages * blocks_per_page;
@@ -270,7 +276,7 @@ int ext4_mpage_readpages(struct inode *inode,
 					map.m_flags &= ~EXT4_MAP_MAPPED;
 					break;
 				}
-				if (page_block == blocks_per_page)
+				if (page_block == blocks_per_folio)
 					break;
 				page_block++;
 				block_in_file++;
@@ -281,7 +287,7 @@ int ext4_mpage_readpages(struct inode *inode,
 		 * Then do more ext4_map_blocks() calls until we are
 		 * done with this folio.
 		 */
-		while (page_block < blocks_per_page) {
+		while (page_block < blocks_per_folio) {
 			if (block_in_file < last_block) {
 				map.m_lblk = block_in_file;
 				map.m_len = last_block - block_in_file;
@@ -296,13 +302,13 @@ int ext4_mpage_readpages(struct inode *inode,
 			}
 			if ((map.m_flags & EXT4_MAP_MAPPED) == 0) {
 				fully_mapped = 0;
-				if (first_hole == blocks_per_page)
+				if (first_hole == blocks_per_folio)
 					first_hole = page_block;
 				page_block++;
 				block_in_file++;
 				continue;
 			}
-			if (first_hole != blocks_per_page)
+			if (first_hole != blocks_per_folio)
 				goto confused;		/* hole -> non-hole */
 
 			/* Contiguous blocks? */
@@ -315,13 +321,13 @@ int ext4_mpage_readpages(struct inode *inode,
 					/* needed? */
 					map.m_flags &= ~EXT4_MAP_MAPPED;
 					break;
-				} else if (page_block == blocks_per_page)
+				} else if (page_block == blocks_per_folio)
 					break;
 				page_block++;
 				block_in_file++;
 			}
 		}
-		if (first_hole != blocks_per_page) {
+		if (first_hole != blocks_per_folio) {
 			folio_zero_segment(folio, first_hole << blkbits,
 					  folio_size(folio));
 			if (first_hole == 0) {
@@ -367,11 +373,11 @@ int ext4_mpage_readpages(struct inode *inode,
 
 		if (((map.m_flags & EXT4_MAP_BOUNDARY) &&
 		     (relative_block == map.m_len)) ||
-		    (first_hole != blocks_per_page)) {
+		    (first_hole != blocks_per_folio)) {
 			submit_bio(bio);
 			bio = NULL;
 		} else
-			last_block_in_bio = first_block + blocks_per_page - 1;
+			last_block_in_bio = first_block + blocks_per_folio - 1;
 		continue;
 	confused:
 		if (bio) {
-- 
2.46.1


