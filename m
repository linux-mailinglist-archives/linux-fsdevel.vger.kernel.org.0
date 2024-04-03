Return-Path: <linux-fsdevel+bounces-15983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDF896683
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BE02869E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FDF5CDDA;
	Wed,  3 Apr 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="QewS3YWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E296FE38;
	Wed,  3 Apr 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129598; cv=none; b=tlGglh3BPfrkKLIjosbSb68gdjqiGojVdcSDCCnNL8V4lParZQ6mXMT+86R5zUZ2a40lG0xTy1jcH/nrCCVq68TaBuTAXJzsb/Yj9ByxKa2UJmFxk8uwarVHzG0Apxj+C+lwMs9hPE7/xawb5lEVgmWOYB1Z4+73IbdoXfdMs/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129598; c=relaxed/simple;
	bh=k2cIvdzLg3sljiZ/6znD/m3Ichqz9W7DWE80AeNEY2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxKKHiAhFUuQRGq4iUaRbR/jNjeFnfIvH20j2wbRcodTpaMcCehzQsT9n8dypztZVXY6xDiNKIDH6D2g43OlZp7Pl19i/x8RuvgLb7E/x/tvSRE/NSSFWbZYvtH328sbSlsdKcotw2q7Ubqgh+wag9u8yG2L3WKYC0invTthwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=QewS3YWB; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 85BD2807F9;
	Wed,  3 Apr 2024 03:33:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129596; bh=k2cIvdzLg3sljiZ/6znD/m3Ichqz9W7DWE80AeNEY2E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QewS3YWB1Udfrmc/U+d3uuM7Whmk18AUwovF8JVhddL2HNuIMXaUpIm41h3L4CYTs
	 5KScePZY2mnNQLA2JWbk7uAmVjO/Q0ocd2pjHbwWhNJ9WeQQ6ErauUPhc3TSpxHsZz
	 IzCe9DHOenanCyWyEZ7PBdaPAQOwz0o5/dwXJq9jHPTyz64Cm4WLLoL8mXGR5VAvFt
	 ieU26UGsxvoUwgp6smA3DzC2kFa+OUkmSZV2Dtt5LZ15W88v7JyshorRDs/anyn52b
	 qaT/UPkoL8UVb6bDkx5xa2Eliks4n2naoWdnSMU7ngNNU+5h23bqxiIVqnuLPee3y9
	 ighpvtsu8WGLA==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 05/13] btrfs: fiemap: return extent physical size
Date: Wed,  3 Apr 2024 03:22:46 -0400
Message-ID: <62391207f8d60060fddc18404af600c4b4f9b170.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fiemap allows returning extent physical size, make btrfs return
the appropriate extent's actual disk size.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/extent_io.c | 70 ++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e9df670ef7d2..b631f387cc3c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2506,7 +2506,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 struct btrfs_fiemap_entry {
 	u64 offset;
 	u64 phys;
-	u64 len;
+	u64 log_len;
+	u64 phys_len;
 	u32 flags;
 };
 
@@ -2564,7 +2565,8 @@ struct fiemap_cache {
 	/* Fields for the cached extent (unsubmitted, not ready, extent). */
 	u64 offset;
 	u64 phys;
-	u64 len;
+	u64 log_len;
+	u64 phys_len;
 	u32 flags;
 	bool cached;
 };
@@ -2577,8 +2579,8 @@ static int flush_fiemap_cache(struct fiemap_extent_info *fieinfo,
 		int ret;
 
 		ret = fiemap_fill_next_extent(fieinfo, entry->offset,
-					      entry->phys, entry->len, 0,
-					      entry->flags);
+					      entry->phys, entry->log_len,
+					      entry->phys_len, entry->flags);
 		/*
 		 * Ignore 1 (reached max entries) because we keep track of that
 		 * ourselves in emit_fiemap_extent().
@@ -2603,7 +2605,8 @@ static int flush_fiemap_cache(struct fiemap_extent_info *fieinfo,
  */
 static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 				struct fiemap_cache *cache,
-				u64 offset, u64 phys, u64 len, u32 flags)
+				u64 offset, u64 phys, u64 log_len,
+				u64 phys_len, u32 flags)
 {
 	struct btrfs_fiemap_entry *entry;
 	u64 cache_end;
@@ -2611,6 +2614,9 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	/* Set at the end of extent_fiemap(). */
 	ASSERT((flags & FIEMAP_EXTENT_LAST) == 0);
 
+	/* We always set the correct physical length. */
+	flags |= FIEMAP_EXTENT_HAS_PHYS_LEN;
+
 	if (!cache->cached)
 		goto assign;
 
@@ -2646,7 +2652,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	 * or equals to what we have in cache->offset. We deal with this as
 	 * described below.
 	 */
-	cache_end = cache->offset + cache->len;
+	cache_end = cache->offset + cache->log_len;
 	if (cache_end > offset) {
 		if (offset == cache->offset) {
 			/*
@@ -2670,10 +2676,10 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 			 * where a previously found file extent item was split
 			 * due to an ordered extent completing.
 			 */
-			cache->len = offset - cache->offset;
+			cache->log_len = offset - cache->offset;
 			goto emit;
 		} else {
-			const u64 range_end = offset + len;
+			const u64 range_end = offset + log_len;
 
 			/*
 			 * The offset of the file extent item we have just found
@@ -2706,11 +2712,13 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 			if (range_end <= cache_end)
 				return 0;
 
-			if (!(flags & (FIEMAP_EXTENT_DATA_COMPRESSED | FIEMAP_EXTENT_DELALLOC)))
+			if (!(flags & (FIEMAP_EXTENT_DATA_COMPRESSED | FIEMAP_EXTENT_DELALLOC))) {
 				phys += cache_end - offset;
+				phys_len -= cache_end - offset;
+			}
 
 			offset = cache_end;
-			len = range_end - cache_end;
+			log_len = range_end - cache_end;
 			goto emit;
 		}
 	}
@@ -2720,15 +2728,17 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	 * 1) Their logical addresses are continuous
 	 *
 	 * 2) Their physical addresses are continuous
-	 *    So truly compressed (physical size smaller than logical size)
-	 *    extents won't get merged with each other
 	 *
 	 * 3) Share same flags
+	 *
+	 * 4) Not compressed
 	 */
-	if (cache->offset + cache->len  == offset &&
-	    cache->phys + cache->len == phys  &&
-	    cache->flags == flags) {
-		cache->len += len;
+	if (cache->offset + cache->log_len  == offset &&
+	    cache->phys + cache->log_len == phys  &&
+	    cache->flags == flags &&
+	    !(flags & FIEMAP_EXTENT_DATA_COMPRESSED)) {
+		cache->log_len += log_len;
+		cache->phys_len += phys_len;
 		return 0;
 	}
 
@@ -2745,7 +2755,7 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 		 * to miss it.
 		 */
 		entry = &cache->entries[cache->entries_size - 1];
-		cache->next_search_offset = entry->offset + entry->len;
+		cache->next_search_offset = entry->offset + entry->log_len;
 		cache->cached = false;
 
 		return BTRFS_FIEMAP_FLUSH_CACHE;
@@ -2754,7 +2764,8 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	entry = &cache->entries[cache->entries_pos];
 	entry->offset = cache->offset;
 	entry->phys = cache->phys;
-	entry->len = cache->len;
+	entry->log_len = cache->log_len;
+	entry->phys_len = cache->phys_len;
 	entry->flags = cache->flags;
 	cache->entries_pos++;
 	cache->extents_mapped++;
@@ -2767,7 +2778,8 @@ static int emit_fiemap_extent(struct fiemap_extent_info *fieinfo,
 	cache->cached = true;
 	cache->offset = offset;
 	cache->phys = phys;
-	cache->len = len;
+	cache->log_len = log_len;
+	cache->phys_len = phys_len;
 	cache->flags = flags;
 
 	return 0;
@@ -2793,7 +2805,8 @@ static int emit_last_fiemap_cache(struct fiemap_extent_info *fieinfo,
 		return 0;
 
 	ret = fiemap_fill_next_extent(fieinfo, cache->offset, cache->phys,
-				      cache->len, 0, cache->flags);
+				      cache->log_len, cache->phys_len,
+				      cache->flags);
 	cache->cached = false;
 	if (ret > 0)
 		ret = 0;
@@ -2987,13 +3000,15 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 			}
 			ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
 						 disk_bytenr + extent_offset,
-						 prealloc_len, prealloc_flags);
+						 prealloc_len, prealloc_len,
+						 prealloc_flags);
 			if (ret)
 				return ret;
 			extent_offset += prealloc_len;
 		}
 
 		ret = emit_fiemap_extent(fieinfo, cache, delalloc_start, 0,
+					 delalloc_end + 1 - delalloc_start,
 					 delalloc_end + 1 - delalloc_start,
 					 FIEMAP_EXTENT_DELALLOC |
 					 FIEMAP_EXTENT_UNKNOWN);
@@ -3034,7 +3049,8 @@ static int fiemap_process_hole(struct btrfs_inode *inode,
 		}
 		ret = emit_fiemap_extent(fieinfo, cache, prealloc_start,
 					 disk_bytenr + extent_offset,
-					 prealloc_len, prealloc_flags);
+					 prealloc_len, prealloc_len,
+					 prealloc_flags);
 		if (ret)
 			return ret;
 	}
@@ -3180,6 +3196,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 extent_offset = 0;
 		u64 extent_gen;
 		u64 disk_bytenr = 0;
+		u64 disk_size = 0;
 		u64 flags = 0;
 		int extent_type;
 		u8 compression;
@@ -3242,7 +3259,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			flags |= FIEMAP_EXTENT_DATA_INLINE;
 			flags |= FIEMAP_EXTENT_NOT_ALIGNED;
 			ret = emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
-						 extent_len, flags);
+						 extent_len, extent_len, flags);
 		} else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 			ret = fiemap_process_hole(inode, fieinfo, &cache,
 						  &delalloc_cached_state,
@@ -3257,6 +3274,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						  backref_ctx, 0, 0, 0,
 						  key.offset, extent_end - 1);
 		} else {
+			disk_size = btrfs_file_extent_disk_num_bytes(leaf, ei);
 			/* We have a regular extent. */
 			if (fieinfo->fi_extents_max) {
 				ret = btrfs_is_data_extent_shared(inode,
@@ -3271,7 +3289,9 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 
 			ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
 						 disk_bytenr + extent_offset,
-						 extent_len, flags);
+						 extent_len,
+						 disk_size - extent_offset,
+						 flags);
 		}
 
 		if (ret < 0) {
@@ -3309,7 +3329,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		prev_extent_end = range_end;
 	}
 
-	if (cache.cached && cache.offset + cache.len >= last_extent_end) {
+	if (cache.cached && cache.offset + cache.log_len >= last_extent_end) {
 		const u64 i_size = i_size_read(&inode->vfs_inode);
 
 		if (prev_extent_end < i_size) {
-- 
2.43.0


