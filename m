Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92EB6475C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2019 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfFPQIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jun 2019 12:08:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727351AbfFPQIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jun 2019 12:08:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5GG6S4a091457
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2019 12:08:21 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t5e1qenu1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2019 12:08:21 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Sun, 16 Jun 2019 17:08:20 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Jun 2019 17:08:17 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5GG8G6Z30671286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jun 2019 16:08:16 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F2646E050;
        Sun, 16 Jun 2019 16:08:16 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ADD76E04C;
        Sun, 16 Jun 2019 16:08:12 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.1.181])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 16 Jun 2019 16:08:12 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, jaegeuk@kernel.org,
        yuchao0@huawei.com, hch@infradead.org
Subject: [PATCH V3 5/7] ext4: Wire up ext4_readpage[s] to use mpage_readpage[s]
Date:   Sun, 16 Jun 2019 21:38:11 +0530
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190616160813.24464-1-chandan@linux.ibm.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061616-0016-0000-0000-000009C2E1EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011273; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01218855; UDB=6.00641061; IPR=6.00999987;
 MB=3.00027334; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-16 16:08:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061616-0017-0000-0000-000043ABD0C4
Message-Id: <20190616160813.24464-6-chandan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906160155
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that do_mpage_readpage() is "post read process" aware, this commit
gets ext4_readpage[s] to use mpage_readpage[s] and deletes ext4's
readpage.c since the associated functionality is not required anymore.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/ext4/Makefile   |   2 +-
 fs/ext4/inode.c    |   5 +-
 fs/ext4/readpage.c | 286 ---------------------------------------------
 3 files changed, 3 insertions(+), 290 deletions(-)
 delete mode 100644 fs/ext4/readpage.c

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 8fdfcd3c3e04..7c38803a808d 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_EXT4_FS) += ext4.o
 ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 		extents_status.o file.o fsmap.o fsync.o hash.o ialloc.o \
 		indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
-		mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
+		mmp.o move_extent.o namei.o page-io.o resize.o \
 		super.o symlink.o sysfs.o xattr.o xattr_trusted.o xattr_user.o
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f65357735a1a..60010b76b566 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3363,8 +3363,7 @@ static int ext4_readpage(struct file *file, struct page *page)
 		ret = ext4_readpage_inline(inode, page);
 
 	if (ret == -EAGAIN)
-		return ext4_mpage_readpages(page->mapping, NULL, page, 1,
-						false);
+		return mpage_readpage(page, ext4_get_block);
 
 	return ret;
 }
@@ -3379,7 +3378,7 @@ ext4_readpages(struct file *file, struct address_space *mapping,
 	if (ext4_has_inline_data(inode))
 		return 0;
 
-	return ext4_mpage_readpages(mapping, pages, NULL, nr_pages, true);
+	return mpage_readpages(mapping, pages, nr_pages, ext4_get_block);
 }
 
 static void ext4_invalidatepage(struct page *page, unsigned int offset,
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
deleted file mode 100644
index 652796b95545..000000000000
--- a/fs/ext4/readpage.c
+++ /dev/null
@@ -1,286 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/fs/ext4/readpage.c
- *
- * Copyright (C) 2002, Linus Torvalds.
- * Copyright (C) 2015, Google, Inc.
- *
- * This was originally taken from fs/mpage.c
- *
- * The intent is the ext4_mpage_readpages() function here is intended
- * to replace mpage_readpages() in the general case, not just for
- * encrypted files.  It has some limitations (see below), where it
- * will fall back to read_block_full_page(), but these limitations
- * should only be hit when page_size != block_size.
- *
- * This will allow us to attach a callback function to support ext4
- * encryption.
- *
- * If anything unusual happens, such as:
- *
- * - encountering a page which has buffers
- * - encountering a page which has a non-hole after a hole
- * - encountering a page with non-contiguous blocks
- *
- * then this code just gives up and calls the buffer_head-based read function.
- * It does handle a page which has holes at the end - that is a common case:
- * the end-of-file on blocksize < PAGE_SIZE setups.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/mm.h>
-#include <linux/kdev_t.h>
-#include <linux/gfp.h>
-#include <linux/bio.h>
-#include <linux/fs.h>
-#include <linux/buffer_head.h>
-#include <linux/blkdev.h>
-#include <linux/highmem.h>
-#include <linux/prefetch.h>
-#include <linux/mpage.h>
-#include <linux/writeback.h>
-#include <linux/backing-dev.h>
-#include <linux/pagevec.h>
-#include <linux/cleancache.h>
-#include <linux/read_callbacks.h>
-
-#include "ext4.h"
-
-static inline bool ext4_bio_encrypted(struct bio *bio)
-{
-#ifdef CONFIG_FS_ENCRYPTION
-	return unlikely(bio->bi_private != NULL);
-#else
-	return false;
-#endif
-}
-
-/*
- * I/O completion handler for multipage BIOs.
- *
- * The mpage code never puts partial pages into a BIO (except for end-of-file).
- * If a page does not map to a contiguous run of blocks then it simply falls
- * back to block_read_full_page().
- *
- * Why is this?  If a page's completion depends on a number of different BIOs
- * which can complete in any order (or at the same time) then determining the
- * status of that page is hard.  See end_buffer_async_read() for the details.
- * There is no point in duplicating all that complexity.
- */
-static void mpage_end_io(struct bio *bio)
-{
-	struct bio_vec *bv;
-	struct bvec_iter_all iter_all;
-
-	if (read_callbacks_end_bio(bio))
-		return;
-
-	bio_for_each_segment_all(bv, bio, iter_all) {
-		struct page *page = bv->bv_page;
-
-		if (!bio->bi_status) {
-			SetPageUptodate(page);
-		} else {
-			ClearPageUptodate(page);
-			SetPageError(page);
-		}
-		unlock_page(page);
-	}
-
-	bio_put(bio);
-}
-
-int ext4_mpage_readpages(struct address_space *mapping,
-			 struct list_head *pages, struct page *page,
-			 unsigned nr_pages, bool is_readahead)
-{
-	struct bio *bio = NULL;
-	sector_t last_block_in_bio = 0;
-
-	struct inode *inode = mapping->host;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
-	const unsigned blocksize = 1 << blkbits;
-	sector_t block_in_file;
-	sector_t last_block;
-	sector_t last_block_in_file;
-	sector_t blocks[MAX_BUF_PER_PAGE];
-	unsigned page_block;
-	struct block_device *bdev = inode->i_sb->s_bdev;
-	int length;
-	unsigned relative_block = 0;
-	struct ext4_map_blocks map;
-
-	map.m_pblk = 0;
-	map.m_lblk = 0;
-	map.m_len = 0;
-	map.m_flags = 0;
-
-	for (; nr_pages; nr_pages--) {
-		int fully_mapped = 1;
-		unsigned first_hole = blocks_per_page;
-
-		if (pages) {
-			page = lru_to_page(pages);
-
-			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping, page->index,
-				  readahead_gfp_mask(mapping)))
-				goto next_page;
-		}
-
-		if (page_has_buffers(page))
-			goto confused;
-
-		block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
-		last_block = block_in_file + nr_pages * blocks_per_page;
-		last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
-		if (last_block > last_block_in_file)
-			last_block = last_block_in_file;
-		page_block = 0;
-
-		/*
-		 * Map blocks using the previous result first.
-		 */
-		if ((map.m_flags & EXT4_MAP_MAPPED) &&
-		    block_in_file > map.m_lblk &&
-		    block_in_file < (map.m_lblk + map.m_len)) {
-			unsigned map_offset = block_in_file - map.m_lblk;
-			unsigned last = map.m_len - map_offset;
-
-			for (relative_block = 0; ; relative_block++) {
-				if (relative_block == last) {
-					/* needed? */
-					map.m_flags &= ~EXT4_MAP_MAPPED;
-					break;
-				}
-				if (page_block == blocks_per_page)
-					break;
-				blocks[page_block] = map.m_pblk + map_offset +
-					relative_block;
-				page_block++;
-				block_in_file++;
-			}
-		}
-
-		/*
-		 * Then do more ext4_map_blocks() calls until we are
-		 * done with this page.
-		 */
-		while (page_block < blocks_per_page) {
-			if (block_in_file < last_block) {
-				map.m_lblk = block_in_file;
-				map.m_len = last_block - block_in_file;
-
-				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
-				set_error_page:
-					SetPageError(page);
-					zero_user_segment(page, 0,
-							  PAGE_SIZE);
-					unlock_page(page);
-					goto next_page;
-				}
-			}
-			if ((map.m_flags & EXT4_MAP_MAPPED) == 0) {
-				fully_mapped = 0;
-				if (first_hole == blocks_per_page)
-					first_hole = page_block;
-				page_block++;
-				block_in_file++;
-				continue;
-			}
-			if (first_hole != blocks_per_page)
-				goto confused;		/* hole -> non-hole */
-
-			/* Contiguous blocks? */
-			if (page_block && blocks[page_block-1] != map.m_pblk-1)
-				goto confused;
-			for (relative_block = 0; ; relative_block++) {
-				if (relative_block == map.m_len) {
-					/* needed? */
-					map.m_flags &= ~EXT4_MAP_MAPPED;
-					break;
-				} else if (page_block == blocks_per_page)
-					break;
-				blocks[page_block] = map.m_pblk+relative_block;
-				page_block++;
-				block_in_file++;
-			}
-		}
-		if (first_hole != blocks_per_page) {
-			zero_user_segment(page, first_hole << blkbits,
-					  PAGE_SIZE);
-			if (first_hole == 0) {
-				SetPageUptodate(page);
-				unlock_page(page);
-				goto next_page;
-			}
-		} else if (fully_mapped) {
-			SetPageMappedToDisk(page);
-		}
-		if (fully_mapped && blocks_per_page == 1 &&
-		    !PageUptodate(page) && cleancache_get_page(page) == 0) {
-			SetPageUptodate(page);
-			goto confused;
-		}
-
-		/*
-		 * This page will go to BIO.  Do we need to send this
-		 * BIO off first?
-		 */
-		if (bio && (last_block_in_bio != blocks[0] - 1)) {
-		submit_and_realloc:
-			submit_bio(bio);
-			bio = NULL;
-		}
-		if (bio == NULL) {
-			bio = bio_alloc(GFP_KERNEL,
-				min_t(int, nr_pages, BIO_MAX_PAGES));
-			if (!bio)
-				goto set_error_page;
-
-			if (read_callbacks_setup(inode, bio, NULL)) {
-				bio_put(bio);
-				goto set_error_page;
-			}
-
-			bio_set_dev(bio, bdev);
-			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
-			bio->bi_end_io = mpage_end_io;
-			bio_set_op_attrs(bio, REQ_OP_READ,
-						is_readahead ? REQ_RAHEAD : 0);
-		}
-
-		length = first_hole << blkbits;
-		if (bio_add_page(bio, page, length, 0) < length)
-			goto submit_and_realloc;
-
-		if (((map.m_flags & EXT4_MAP_BOUNDARY) &&
-		     (relative_block == map.m_len)) ||
-		    (first_hole != blocks_per_page)) {
-			submit_bio(bio);
-			bio = NULL;
-		} else
-			last_block_in_bio = blocks[blocks_per_page - 1];
-		goto next_page;
-	confused:
-		if (bio) {
-			submit_bio(bio);
-			bio = NULL;
-		}
-		if (!PageUptodate(page))
-			block_read_full_page(page, ext4_get_block);
-		else
-			unlock_page(page);
-	next_page:
-		if (pages)
-			put_page(page);
-	}
-	BUG_ON(pages && !list_empty(pages));
-	if (bio)
-		submit_bio(bio);
-	return 0;
-}
-- 
2.19.1

