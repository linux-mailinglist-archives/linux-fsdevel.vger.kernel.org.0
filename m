Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1960623228
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKISQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKISQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:16:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD632275E2;
        Wed,  9 Nov 2022 10:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E5B61C3C;
        Wed,  9 Nov 2022 18:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B232EC433D6;
        Wed,  9 Nov 2022 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017767;
        bh=AoVf6jOZ7obtljtTuw9O16bBYvbPSn5kp27aOGL2jes=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LTEFchE9b05QPhsnaBcbriNEbjz6+7geK1QJCWH0iN4a2cEb3mPc0XQnVO0L2FmnT
         7dfIGUwslW9aoNPllBu6SF825jf3aQgW09YtglPKq8wtoGJz7E3gJYkD59PTplcYh+
         x3byJaEGc2AcQXjMkhfGiPKcMuteC3v6rFuQfl84HymAfcdqhwSsTYAX2wRxRW1DHq
         ZjDa8n7CRhTJolRnTFB9Jqv9QA93ovXON5+0JynELk5FQuaKIBY8YIjnXb/KtcUvQe
         FPt7JOTSvGaOOkJ1u5xcKtPimTPk+sob+WQkuIcrowncRtYQev8J8nRu/1a9mFJwET
         auOkMmq4YT6FA==
Subject: [PATCH 04/14] xfs: buffered write failure should not truncate the
 page cache
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org
Date:   Wed, 09 Nov 2022 10:16:07 -0800
Message-ID: <166801776726.3992140.478044755009071447.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

xfs_buffered_write_iomap_end() currently invalidates the page cache
over the unused range of the delalloc extent it allocated. While the
write allocated the delalloc extent, it does not own it exclusively
as the write does not hold any locks that prevent either writeback
or mmap page faults from changing the state of either the page cache
or the extent state backing this range.

Whilst xfs_bmap_punch_delalloc_range() already handles races in
extent conversion - it will only punch out delalloc extents and it
ignores any other type of extent - the page cache truncate does not
discriminate between data written by this write or some other task.
As a result, truncating the page cache can result in data corruption
if the write races with mmap modifications to the file over the same
range.

generic/346 exercises this workload, and if we randomly fail writes
(as will happen when iomap gets stale iomap detection later in the
patchset), it will randomly corrupt the file data because it removes
data written by mmap() in the same page as the write() that failed.

Hence we do not want to punch out the page cache over the range of
the extent we failed to write to - what we actually need to do is
detect the ranges that have dirty data in cache over them and *not
punch them out*.

TO do this, we have to walk the page cache over the range of the
delalloc extent we want to remove. This is made complex by the fact
we have to handle partially up-to-date folios correctly and this can
happen even when the FSB size == PAGE_SIZE because we now support
multi-page folios in the page cache.

Because we are only interested in discovering the edges of data
ranges in the page cache (i.e. hole-data boundaries) we can make use
of mapping_seek_hole_data() to find those transitions in the page
cache. As we hold the invalidate_lock, we know that the boundaries
are not going to change while we walk the range. This interface is
also byte-based and is sub-page block aware, so we can find the data
ranges in the cache based on byte offsets rather than page, folio or
fs block sized chunks. This greatly simplifies the logic of finding
dirty cached ranges in the page cache.

Once we've identified a range that contains cached data, we can then
iterate the range folio by folio. This allows us to determine if the
data is dirty and hence perform the correct delalloc extent punching
operations. The seek interface we use to iterate data ranges will
give us sub-folio start/end granularity, so we may end up looking up
the same folio multiple times as the seek interface iterates across
each discontiguous data region in the folio.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c |  151 +++++++++++++++++++++++++++++++++++++++++++++++++---
 mm/filemap.c       |    1 
 2 files changed, 142 insertions(+), 10 deletions(-)


diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 7bb55dbc19d3..2d48fcc7bd6f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1134,6 +1134,146 @@ xfs_buffered_write_delalloc_punch(
 				end_fsb - start_fsb);
 }
 
+/*
+ * Scan the data range passed to us for dirty page cache folios. If we find a
+ * dirty folio, punch out the preceeding range and update the offset from which
+ * the next punch will start from.
+ *
+ * We can punch out clean pages because they either contain data that has been
+ * written back - in which case the delalloc punch over that range is a no-op -
+ * or they have been read faults in which case they contain zeroes and we can
+ * remove the delalloc backing range and any new writes to those pages will do
+ * the normal hole filling operation...
+ *
+ * This makes the logic simple: we only need to keep the delalloc extents only
+ * over the dirty ranges of the page cache.
+ */
+static int
+xfs_buffered_write_delalloc_scan(
+	struct inode		*inode,
+	loff_t			*punch_start_byte,
+	loff_t			start_byte,
+	loff_t			end_byte)
+{
+	loff_t			offset = start_byte;
+
+	while (offset < end_byte) {
+		struct folio	*folio;
+
+		/* grab locked page */
+		folio = filemap_lock_folio(inode->i_mapping, offset >> PAGE_SHIFT);
+		if (!folio) {
+			offset = ALIGN_DOWN(offset, PAGE_SIZE) + PAGE_SIZE;
+			continue;
+		}
+
+		/* if dirty, punch up to offset */
+		if (folio_test_dirty(folio)) {
+			if (offset > *punch_start_byte) {
+				int	error;
+
+				error = xfs_buffered_write_delalloc_punch(inode,
+						*punch_start_byte, offset);
+				if (error) {
+					folio_unlock(folio);
+					folio_put(folio);
+					return error;
+				}
+			}
+
+			/*
+			 * Make sure the next punch start is correctly bound to
+			 * the end of this data range, not the end of the folio.
+			 */
+			*punch_start_byte = min_t(loff_t, end_byte,
+					folio_next_index(folio) << PAGE_SHIFT);
+		}
+
+		/* move offset to start of next folio in range */
+		offset = folio_next_index(folio) << PAGE_SHIFT;
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+	return 0;
+}
+
+/*
+ * Punch out all the delalloc blocks in the range given except for those that
+ * have dirty data still pending in the page cache - those are going to be
+ * written and so must still retain the delalloc backing for writeback.
+ *
+ * As we are scanning the page cache for data, we don't need to reimplement the
+ * wheel - mapping_seek_hole_data() does exactly what we need to identify the
+ * start and end of data ranges correctly even for sub-folio block sizes. This
+ * byte range based iteration is especially convenient because it means we don't
+ * have to care about variable size folios, nor where the start or end of the
+ * data range lies within a folio, if they lie within the same folio or even if
+ * there are multiple discontiguous data ranges within the folio.
+ */
+static int
+xfs_buffered_write_delalloc_release(
+	struct inode		*inode,
+	loff_t			start_byte,
+	loff_t			end_byte)
+{
+	loff_t			punch_start_byte = start_byte;
+	int			error = 0;
+
+	/*
+	 * Lock the mapping to avoid races with page faults re-instantiating
+	 * folios and dirtying them via ->page_mkwrite whilst we walk the
+	 * cache and perform delalloc extent removal. Failing to do this can
+	 * leave dirty pages with no space reservation in the cache.
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+	while (start_byte < end_byte) {
+		loff_t		data_end;
+
+		start_byte = mapping_seek_hole_data(inode->i_mapping,
+				start_byte, end_byte, SEEK_DATA);
+		/*
+		 * If there is no more data to scan, all that is left is to
+		 * punch out the remaining range.
+		 */
+		if (start_byte == -ENXIO || start_byte == end_byte)
+			break;
+		if (start_byte < 0) {
+			error = start_byte;
+			goto out_unlock;
+		}
+		ASSERT(start_byte >= punch_start_byte);
+		ASSERT(start_byte < end_byte);
+
+		/*
+		 * We find the end of this contiguous cached data range by
+		 * seeking from start_byte to the beginning of the next hole.
+		 */
+		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
+				end_byte, SEEK_HOLE);
+		if (data_end < 0) {
+			error = data_end;
+			goto out_unlock;
+		}
+		ASSERT(data_end > start_byte);
+		ASSERT(data_end <= end_byte);
+
+		error = xfs_buffered_write_delalloc_scan(inode,
+				&punch_start_byte, start_byte, data_end);
+		if (error)
+			goto out_unlock;
+
+		/* The next data search starts at the end of this one. */
+		start_byte = data_end;
+	}
+
+	if (punch_start_byte < end_byte)
+		error = xfs_buffered_write_delalloc_punch(inode,
+				punch_start_byte, end_byte);
+out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return error;
+}
+
 static int
 xfs_buffered_write_iomap_end(
 	struct inode		*inode,
@@ -1179,16 +1319,7 @@ xfs_buffered_write_iomap_end(
 	if (start_byte >= end_byte)
 		return 0;
 
-	/*
-	 * Lock the mapping to avoid races with page faults re-instantiating
-	 * folios and dirtying them via ->page_mkwrite between the page cache
-	 * truncation and the delalloc extent removal. Failing to do this can
-	 * leave dirty pages with no space reservation in the cache.
-	 */
-	filemap_invalidate_lock(inode->i_mapping);
-	truncate_pagecache_range(inode, start_byte, end_byte - 1);
-	error = xfs_buffered_write_delalloc_punch(inode, start_byte, end_byte);
-	filemap_invalidate_unlock(inode->i_mapping);
+	error = xfs_buffered_write_delalloc_release(inode, start_byte, end_byte);
 	if (error && !xfs_is_shutdown(mp)) {
 		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
 			__func__, XFS_I(inode)->i_ino);
diff --git a/mm/filemap.c b/mm/filemap.c
index 08341616ae7a..e95239a418de 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2925,6 +2925,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 		return end;
 	return start;
 }
+EXPORT_SYMBOL(mapping_seek_hole_data);
 
 #ifdef CONFIG_MMU
 #define MMAP_LOTSAMISS  (100)

