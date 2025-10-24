Return-Path: <linux-fsdevel+bounces-65541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1867C077C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5251C47BE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304633FE17;
	Fri, 24 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JUgSOuc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366172D3A75;
	Fri, 24 Oct 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325709; cv=none; b=gifrwJmuaxjv3Zein/dendS3TMBLlnueYSqpyN+nbTmlkOB4nczm8jZCZz10UNotAhrFW8XSBRJ+JTy65ANkrlWJy+vrq87kz1AV5BDCwaHJFENAXOwgL+zq1kUUxkCzeuUW7TgWXYHKh/iv4YqcY9okyL20dtAygHLtVdotWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325709; c=relaxed/simple;
	bh=mCYn53VfExT8n8elWENifNoolj01lEhmpWvHCHpyJNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAQ55lKt+rSMJI6xmNGa8qm7H6J3d2c3o/nMu2qyEGeRGlRYZe4r53qjvtwaRk15fJaYDDTVTsPhzcO92sQ04kUWKTjP9SnR7GoFFUrdxlMJ6Jtq2UI9KpvsKH0clYxjFYHZNe6o8gt1bYhNqiduqFQ8LjMZXCBz5gcdafh358E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JUgSOuc2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BKcbcmW2X9mJy+P/+GCwbvPWwki81TPMXj8xgawrl+4=; b=JUgSOuc2VW4cBZZBKFc/5rFbUD
	SWF34dYiDgmLhdqtBLMiqX4hiYuRyv8I6kvr5/1n5ACUPHgq1RRqZxqstVwyvMcFKUlu/reSP7QK8
	Bb1gIMVjVVUqBtt8m9DD5cr19ZZOPfbsTilbKDEmm2utbdkt00zp8+SA+v2ILBaDcv8wDn8M+F1ye
	UWPAMXRB0L9G+w1ks1jkp8TA0UoWmLbi/MMKiC2SZofpQId2CMWcYRxQTcfywZU/0Q30TK0dAxrCK
	DwUuU03MDtmEZxDC29V/guG9x2Rl5qCpJJj6Vt06QJnFQwhlxdOE/ejv2zsMlgBVPTNpw6zRXf6O7
	b9ADFwtw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH6-00000005zL3-1d5v;
	Fri, 24 Oct 2025 17:08:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 02/10] btrfs: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:10 +0100
Message-ID: <20251024170822.1427218-3-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024170822.1427218-1-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs defined its own variant of folio_next_pos() called folio_end().
This is an ambiguous name as 'end' might be exclusive or inclusive.
Switch to the new folio_next_pos().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Chris Mason <clm@fb.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
---
 fs/btrfs/compression.h  |  4 ++--
 fs/btrfs/defrag.c       |  7 ++++---
 fs/btrfs/extent_io.c    | 16 ++++++++--------
 fs/btrfs/file.c         |  9 +++++----
 fs/btrfs/inode.c        | 11 ++++++-----
 fs/btrfs/misc.h         |  5 -----
 fs/btrfs/ordered-data.c |  2 +-
 fs/btrfs/subpage.c      |  5 +++--
 8 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index eba188a9e3bb..aee1fd21cdd6 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -85,8 +85,8 @@ static inline u32 btrfs_calc_input_length(struct folio *folio, u64 range_end, u6
 {
 	/* @cur must be inside the folio. */
 	ASSERT(folio_pos(folio) <= cur);
-	ASSERT(cur < folio_end(folio));
-	return min(range_end, folio_end(folio)) - cur;
+	ASSERT(cur < folio_next_pos(folio));
+	return umin(range_end, folio_next_pos(folio)) - cur;
 }
 
 int btrfs_alloc_compress_wsm(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 7b277934f66f..8fb353feacc9 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -886,7 +886,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 	}
 
 	lock_start = folio_pos(folio);
-	lock_end = folio_end(folio) - 1;
+	lock_end = folio_next_pos(folio) - 1;
 	/* Wait for any existing ordered extent in the range */
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
@@ -1178,7 +1178,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 
 		if (!folio)
 			break;
-		if (start >= folio_end(folio) || start + len <= folio_pos(folio))
+		if (start >= folio_next_pos(folio) ||
+		    start + len <= folio_pos(folio))
 			continue;
 		btrfs_folio_clamp_clear_checked(fs_info, folio, start, len);
 		btrfs_folio_clamp_set_dirty(fs_info, folio, start, len);
@@ -1219,7 +1220,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 			folios[i] = NULL;
 			goto free_folios;
 		}
-		cur = folio_end(folios[i]);
+		cur = folio_next_pos(folios[i]);
 	}
 	for (int i = 0; i < nr_pages; i++) {
 		if (!folios[i])
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 755ec6dfd51c..ac1550739eb3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -333,7 +333,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 				goto out;
 			}
 			range_start = max_t(u64, folio_pos(folio), start);
-			range_len = min_t(u64, folio_end(folio), end + 1) - range_start;
+			range_len = min_t(u64, folio_next_pos(folio), end + 1) - range_start;
 			btrfs_folio_set_lock(fs_info, folio, range_start, range_len);
 
 			processed_end = range_start + range_len - 1;
@@ -387,7 +387,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	ASSERT(orig_end > orig_start);
 
 	/* The range should at least cover part of the folio */
-	ASSERT(!(orig_start >= folio_end(locked_folio) ||
+	ASSERT(!(orig_start >= folio_next_pos(locked_folio) ||
 		 orig_end <= folio_pos(locked_folio)));
 again:
 	/* step one, find a bunch of delalloc bytes starting at start */
@@ -493,7 +493,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
 	ASSERT(folio_pos(folio) <= start &&
-	       start + len <= folio_end(folio));
+	       start + len <= folio_next_pos(folio));
 
 	if (uptodate && btrfs_verify_folio(folio, start, len))
 		btrfs_folio_set_uptodate(fs_info, folio, start, len);
@@ -1201,7 +1201,7 @@ static bool can_skip_one_ordered_range(struct btrfs_inode *inode,
 	 * finished our folio read and unlocked the folio.
 	 */
 	if (btrfs_folio_test_dirty(fs_info, folio, cur, blocksize)) {
-		u64 range_len = min(folio_end(folio),
+		u64 range_len = umin(folio_next_pos(folio),
 				    ordered->file_offset + ordered->num_bytes) - cur;
 
 		ret = true;
@@ -1223,7 +1223,7 @@ static bool can_skip_one_ordered_range(struct btrfs_inode *inode,
 	 * So we return true and update @next_ret to the OE/folio boundary.
 	 */
 	if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
-		u64 range_len = min(folio_end(folio),
+		u64 range_len = umin(folio_next_pos(folio),
 				    ordered->file_offset + ordered->num_bytes) - cur;
 
 		/*
@@ -2215,7 +2215,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
-		u32 range_len = min_t(u64, folio_end(folio),
+		u32 range_len = min_t(u64, folio_next_pos(folio),
 				      eb->start + eb->len) - range_start;
 
 		folio_lock(folio);
@@ -2619,7 +2619,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 			continue;
 		}
 
-		cur_end = min_t(u64, folio_end(folio) - 1, end);
+		cur_end = min_t(u64, folio_next_pos(folio) - 1, end);
 		cur_len = cur_end + 1 - cur;
 
 		ASSERT(folio_test_locked(folio));
@@ -3860,7 +3860,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
-		u32 range_len = min_t(u64, folio_end(folio),
+		u32 range_len = min_t(u64, folio_next_pos(folio),
 				      eb->start + eb->len) - range_start;
 
 		bio_add_folio_nofail(&bbio->bio, folio, range_len,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7efd1f8a1912..977931cfa71e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -89,7 +89,8 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio, loff_t pos
 	num_bytes = round_up(write_bytes + pos - start_pos,
 			     fs_info->sectorsize);
 	ASSERT(num_bytes <= U32_MAX);
-	ASSERT(folio_pos(folio) <= pos && folio_end(folio) >= pos + write_bytes);
+	ASSERT(folio_pos(folio) <= pos &&
+	       folio_next_pos(folio) >= pos + write_bytes);
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
@@ -799,7 +800,7 @@ static int prepare_uptodate_folio(struct inode *inode, struct folio *folio, u64
 				  u64 len)
 {
 	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
-	u64 clamp_end = min_t(u64, pos + len, folio_end(folio));
+	u64 clamp_end = min_t(u64, pos + len, folio_next_pos(folio));
 	const u32 blocksize = inode_to_fs_info(inode)->sectorsize;
 	int ret = 0;
 
@@ -1254,8 +1255,8 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 	 * The reserved range goes beyond the current folio, shrink the reserved
 	 * space to the folio boundary.
 	 */
-	if (reserved_start + reserved_len > folio_end(folio)) {
-		const u64 last_block = folio_end(folio);
+	if (reserved_start + reserved_len > folio_next_pos(folio)) {
+		const u64 last_block = folio_next_pos(folio);
 
 		shrink_reserved_space(inode, *data_reserved, reserved_start,
 				      reserved_len, last_block - reserved_start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b1b3a0553ee..b7b498fffa4f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -409,7 +409,7 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 			continue;
 		}
 
-		index = folio_end(folio) >> PAGE_SHIFT;
+		index = folio_next_index(folio);
 		/*
 		 * Here we just clear all Ordered bits for every page in the
 		 * range, then btrfs_mark_ordered_io_finished() will handle
@@ -2336,7 +2336,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 	 * The range must cover part of the @locked_folio, or a return of 1
 	 * can confuse the caller.
 	 */
-	ASSERT(!(end <= folio_pos(locked_folio) || start >= folio_end(locked_folio)));
+	ASSERT(!(end <= folio_pos(locked_folio) ||
+		 start >= folio_next_pos(locked_folio)));
 
 	if (should_nocow(inode, start, end)) {
 		ret = run_delalloc_nocow(inode, locked_folio, start, end);
@@ -2743,7 +2744,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	struct btrfs_inode *inode = fixup->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 page_start = folio_pos(folio);
-	u64 page_end = folio_end(folio) - 1;
+	u64 page_end = folio_next_pos(folio) - 1;
 	int ret = 0;
 	bool free_delalloc_space = true;
 
@@ -4855,7 +4856,7 @@ static int truncate_block_zero_beyond_eof(struct btrfs_inode *inode, u64 start)
 	 */
 
 	zero_start = max_t(u64, folio_pos(folio), start);
-	zero_end = folio_end(folio);
+	zero_end = folio_next_pos(folio);
 	folio_zero_range(folio, zero_start - folio_pos(folio),
 			 zero_end - zero_start);
 
@@ -5038,7 +5039,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
 		 * not reach disk, it still affects our page caches.
 		 */
 		zero_start = max_t(u64, folio_pos(folio), start);
-		zero_end = min_t(u64, folio_end(folio) - 1, end);
+		zero_end = min_t(u64, folio_next_pos(folio) - 1, end);
 	} else {
 		zero_start = max_t(u64, block_start, start);
 		zero_end = min_t(u64, block_end, end);
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 60f9b000d644..17b71e1285e5 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -209,9 +209,4 @@ static inline bool bitmap_test_range_all_zero(const unsigned long *addr,
 	return (found_set == start + nbits);
 }
 
-static inline u64 folio_end(struct folio *folio)
-{
-	return folio_pos(folio) + folio_size(folio);
-}
-
 #endif
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 2829f20d7bb5..7fedebbee558 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -359,7 +359,7 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	if (folio) {
 		ASSERT(folio->mapping);
 		ASSERT(folio_pos(folio) <= file_offset);
-		ASSERT(file_offset + len <= folio_end(folio));
+		ASSERT(file_offset + len <= folio_next_pos(folio));
 
 		/*
 		 * Ordered flag indicates whether we still have
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 5ca8d4db6722..a7ba868e9372 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -186,7 +186,8 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	 * unmapped page like dummy extent buffer pages.
 	 */
 	if (folio->mapping)
-		ASSERT(folio_pos(folio) <= start && start + len <= folio_end(folio),
+		ASSERT(folio_pos(folio) <= start &&
+		       start + len <= folio_next_pos(folio),
 		       "start=%llu len=%u folio_pos=%llu folio_size=%zu",
 		       start, len, folio_pos(folio), folio_size(folio));
 }
@@ -217,7 +218,7 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 	if (folio_pos(folio) >= orig_start + orig_len)
 		*len = 0;
 	else
-		*len = min_t(u64, folio_end(folio), orig_start + orig_len) - *start;
+		*len = min_t(u64, folio_next_pos(folio), orig_start + orig_len) - *start;
 }
 
 static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
-- 
2.47.2


