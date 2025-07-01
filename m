Return-Path: <linux-fsdevel+bounces-53513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6FAEFA34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078701C012D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CD7277006;
	Tue,  1 Jul 2025 13:21:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5DA757EA;
	Tue,  1 Jul 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376063; cv=none; b=YCUfkngB/ttLr54L9yzI0i4IRUY4QFh/z4ojf2b/Klzasu7ldF9VlzKTQTDunUFPm7iFIv3474n37L//g1C6oKiwwhjomiVSsB5cE7E8tXbOYtZ4IQxCtDOiR5LPx0OpjPKzlFvv/7fVIygOp0JNPRdkLQ1FFoa+iO8GprLSw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376063; c=relaxed/simple;
	bh=OV5rV1yeBFvh08AXAiy+qNBlEV2EciJ3wZtfVB5PD6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An8DPJ+AhTHlm4OXzc1zC1Fh5zsxuHbKwCdlgh+A66GSoLgTgo1mfY2jW0hnRB7XlLTzFJOe8318YvUau95VwBQiUUK0k0gTuvIqxPWyxigHZUzAiF7KWEU6lzk3RaIlPKtFbg/vQW9Cpj/hQwnWsY4PWzQdQ7orAjnxYfvKBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bWkDq0q3lzKHN4f;
	Tue,  1 Jul 2025 21:20:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7ED431A121F;
	Tue,  1 Jul 2025 21:20:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP3 (Coremail) with SMTP id _Ch0CgAXeCWu4GNoXmJGAQ--.26904S5;
	Tue, 01 Jul 2025 21:20:57 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	sashal@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 01/10] ext4: process folios writeback in bytes
Date: Tue,  1 Jul 2025 21:06:26 +0800
Message-ID: <20250701130635.4079595-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAXeCWu4GNoXmJGAQ--.26904S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1rWF4DZFWxuFWkGr4UArb_yoWfGw17pF
	WUKF909r4kX3yjgFn3ZFZrZr10k34xAr48tFy3WanIqF1Ykr18KFyjqFyqvFy5KrZ2vrWx
	XF4Yyry8WF1xJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUfKs8UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since ext4 supports large folios, processing writebacks in pages is no
longer appropriate, it can be modified to process writebacks in bytes.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c             | 70 +++++++++++++++++++------------------
 include/trace/events/ext4.h | 13 ++++---
 2 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd..ba81df0d87dd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1667,11 +1667,12 @@ struct mpage_da_data {
 	unsigned int can_map:1;	/* Can writepages call map blocks? */
 
 	/* These are internal state of ext4_do_writepages() */
-	pgoff_t first_page;	/* The first page to write */
-	pgoff_t next_page;	/* Current page to examine */
-	pgoff_t last_page;	/* Last page to examine */
+	loff_t start_pos;	/* The start pos to write */
+	loff_t next_pos;	/* Current pos to examine */
+	loff_t end_pos;		/* Last pos to examine */
+
 	/*
-	 * Extent to map - this can be after first_page because that can be
+	 * Extent to map - this can be after start_pos because that can be
 	 * fully mapped. We somewhat abuse m_flags to store whether the extent
 	 * is delalloc or unwritten.
 	 */
@@ -1691,38 +1692,38 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 	struct inode *inode = mpd->inode;
 	struct address_space *mapping = inode->i_mapping;
 
-	/* This is necessary when next_page == 0. */
-	if (mpd->first_page >= mpd->next_page)
+	/* This is necessary when next_pos == 0. */
+	if (mpd->start_pos >= mpd->next_pos)
 		return;
 
 	mpd->scanned_until_end = 0;
-	index = mpd->first_page;
-	end   = mpd->next_page - 1;
 	if (invalidate) {
 		ext4_lblk_t start, last;
-		start = index << (PAGE_SHIFT - inode->i_blkbits);
-		last = end << (PAGE_SHIFT - inode->i_blkbits);
+		start = EXT4_B_TO_LBLK(inode, mpd->start_pos);
+		last = mpd->next_pos >> inode->i_blkbits;
 
 		/*
 		 * avoid racing with extent status tree scans made by
 		 * ext4_insert_delayed_block()
 		 */
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ext4_es_remove_extent(inode, start, last - start + 1);
+		ext4_es_remove_extent(inode, start, last - start);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 
 	folio_batch_init(&fbatch);
-	while (index <= end) {
-		nr = filemap_get_folios(mapping, &index, end, &fbatch);
+	index = mpd->start_pos >> PAGE_SHIFT;
+	end = mpd->next_pos >> PAGE_SHIFT;
+	while (index < end) {
+		nr = filemap_get_folios(mapping, &index, end - 1, &fbatch);
 		if (nr == 0)
 			break;
 		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			if (folio->index < mpd->first_page)
+			if (folio_pos(folio) < mpd->start_pos)
 				continue;
-			if (folio_next_index(folio) - 1 > end)
+			if (folio_next_index(folio) > end)
 				continue;
 			BUG_ON(!folio_test_locked(folio));
 			BUG_ON(folio_test_writeback(folio));
@@ -2024,7 +2025,7 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 
 static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
 {
-	mpd->first_page += folio_nr_pages(folio);
+	mpd->start_pos += folio_size(folio);
 	folio_unlock(folio);
 }
 
@@ -2034,7 +2035,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	loff_t size;
 	int err;
 
-	BUG_ON(folio->index != mpd->first_page);
+	WARN_ON_ONCE(folio_pos(folio) != mpd->start_pos);
 	folio_clear_dirty_for_io(folio);
 	/*
 	 * We have to be very careful here!  Nothing protects writeback path
@@ -2446,7 +2447,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	 * Update on-disk size after IO is submitted.  Races with
 	 * truncate are avoided by checking i_size under i_data_sem.
 	 */
-	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
+	disksize = mpd->start_pos;
 	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
 		int err2;
 		loff_t i_size;
@@ -2549,8 +2550,8 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	struct address_space *mapping = mpd->inode->i_mapping;
 	struct folio_batch fbatch;
 	unsigned int nr_folios;
-	pgoff_t index = mpd->first_page;
-	pgoff_t end = mpd->last_page;
+	pgoff_t index = mpd->start_pos >> PAGE_SHIFT;
+	pgoff_t end = mpd->end_pos >> PAGE_SHIFT;
 	xa_mark_t tag;
 	int i, err = 0;
 	int blkbits = mpd->inode->i_blkbits;
@@ -2565,7 +2566,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 		tag = PAGECACHE_TAG_DIRTY;
 
 	mpd->map.m_len = 0;
-	mpd->next_page = index;
+	mpd->next_pos = mpd->start_pos;
 	if (ext4_should_journal_data(mpd->inode)) {
 		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
 					    bpp);
@@ -2596,7 +2597,8 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 				goto out;
 
 			/* If we can't merge this page, we are done. */
-			if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
+			if (mpd->map.m_len > 0 &&
+			    mpd->next_pos != folio_pos(folio))
 				goto out;
 
 			if (handle) {
@@ -2642,8 +2644,8 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			}
 
 			if (mpd->map.m_len == 0)
-				mpd->first_page = folio->index;
-			mpd->next_page = folio_next_index(folio);
+				mpd->start_pos = folio_pos(folio);
+			mpd->next_pos = folio_pos(folio) + folio_size(folio);
 			/*
 			 * Writeout when we cannot modify metadata is simple.
 			 * Just submit the page. For data=journal mode we
@@ -2786,18 +2788,18 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		writeback_index = mapping->writeback_index;
 		if (writeback_index)
 			cycled = 0;
-		mpd->first_page = writeback_index;
-		mpd->last_page = -1;
+		mpd->start_pos = writeback_index << PAGE_SHIFT;
+		mpd->end_pos = -1;
 	} else {
-		mpd->first_page = wbc->range_start >> PAGE_SHIFT;
-		mpd->last_page = wbc->range_end >> PAGE_SHIFT;
+		mpd->start_pos = wbc->range_start;
+		mpd->end_pos = wbc->range_end;
 	}
 
 	ext4_io_submit_init(&mpd->io_submit, wbc);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, mpd->first_page,
-					mpd->last_page);
+		tag_pages_for_writeback(mapping, mpd->start_pos >> PAGE_SHIFT,
+					mpd->end_pos >> PAGE_SHIFT);
 	blk_start_plug(&plug);
 
 	/*
@@ -2857,7 +2859,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		}
 		mpd->do_map = 1;
 
-		trace_ext4_da_write_pages(inode, mpd->first_page, wbc);
+		trace_ext4_da_write_pages(inode, mpd->start_pos, wbc);
 		ret = mpage_prepare_extent_to_map(mpd);
 		if (!ret && mpd->map.m_len)
 			ret = mpage_map_and_submit_extent(handle, mpd,
@@ -2914,8 +2916,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	blk_finish_plug(&plug);
 	if (!ret && !cycled && wbc->nr_to_write > 0) {
 		cycled = 1;
-		mpd->last_page = writeback_index - 1;
-		mpd->first_page = 0;
+		mpd->end_pos = (writeback_index << PAGE_SHIFT) - 1;
+		mpd->start_pos = 0;
 		goto retry;
 	}
 
@@ -2925,7 +2927,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		 * Set the writeback_index so that range_cyclic
 		 * mode will write it back later
 		 */
-		mapping->writeback_index = mpd->first_page;
+		mapping->writeback_index = mpd->start_pos >> PAGE_SHIFT;
 
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641e68..62d52997b5c6 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -483,15 +483,15 @@ TRACE_EVENT(ext4_writepages,
 );
 
 TRACE_EVENT(ext4_da_write_pages,
-	TP_PROTO(struct inode *inode, pgoff_t first_page,
+	TP_PROTO(struct inode *inode, loff_t start_pos,
 		 struct writeback_control *wbc),
 
-	TP_ARGS(inode, first_page, wbc),
+	TP_ARGS(inode, start_pos, wbc),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
-		__field(      pgoff_t,	first_page		)
+		__field(       loff_t,	start_pos		)
 		__field(	 long,	nr_to_write		)
 		__field(	  int,	sync_mode		)
 	),
@@ -499,15 +499,14 @@ TRACE_EVENT(ext4_da_write_pages,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->ino		= inode->i_ino;
-		__entry->first_page	= first_page;
+		__entry->start_pos	= start_pos;
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->sync_mode	= wbc->sync_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu first_page %lu nr_to_write %ld "
-		  "sync_mode %d",
+	TP_printk("dev %d,%d ino %lu start_pos 0x%llx nr_to_write %ld sync_mode %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->first_page,
+		  (unsigned long) __entry->ino, __entry->start_pos,
 		  __entry->nr_to_write, __entry->sync_mode)
 );
 
-- 
2.46.1


