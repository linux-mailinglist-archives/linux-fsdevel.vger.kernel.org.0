Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7A1634FE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 06:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiKWF6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 00:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiKWF6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:58:23 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D961D236E
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 21:58:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b21so15720769plc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 21:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tejXjCIgVV0gM1qLohf6PgRjN0dJqHcix2sbNkaC9iM=;
        b=pLcBhVPf5IK6YMy7+LQvg93Ryf+po3fMged2EzUMLGJTSk8E2rczmh7wb6eSjAvVc+
         Zg2L2mMYHChWa2h+pm8kpMOVFvM3OtHI1RJUZ1AWOAzkRXy+L2pqkI/K8t9LaOJ9ZjEP
         WJ97/yt78Y/Lx3rdVALP+hvYD8JSrnKsQqsHg0tXGFw4tZvdy7yzQwLaBymjeI46nY6Q
         Ke+KBe4sdJ88pNwE5kWVqaP+1rkVLSmqpL2bCsXLymT6zCvl+InzrwvMoq+ZLig2CC7u
         HaJ9JG713VQ3r2zISaSOem3WA8+77fl2jf9mhb0Zoz7p/SqNYsoV5c/N06J24PazhmMm
         BZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tejXjCIgVV0gM1qLohf6PgRjN0dJqHcix2sbNkaC9iM=;
        b=1cfuUiixJ0iBBOyFK6PxowKW8TChZNzvIgxHBAAiECCGub+CHK+lz6/7rOzUEv349e
         n0TARM1UMD2iTotPFBA8KBd3jOKko6js/YpbrKFyFl7D8sCKfrbY9rvb7Gq49VHqEL09
         YiOGGh708ePIsCb0ruRUtNOtcpk5wovhVNRa/s5PypIRWawrTcbSbTCf/mYX7K5iuXxD
         bkEtVeRHUxhdUdgbP13L0hrA6oZ6Io53KSdSV9inlZlUFxQHEcxUf0YF6LGPRJ7csosV
         D6FIUBMJXrX80YfkCafy8qlyz+OBTeSd1IasK8f9Ixwr9rgtXVtVEADrbZOsyD8mlXsM
         KZFQ==
X-Gm-Message-State: ANoB5pl/NiXyOmMBVHC16EjgLyac9H97jOcrA8cFYKxbIsf3K1vVuey5
        I8CDQobVLQcHKhaA5/tDWtdIagJaqnfySw==
X-Google-Smtp-Source: AA0mqf59Y14L9Ypbgd2LEpVEVLd7NNM13Mdv4SmSJFLxQGcA97OyazjZvvtI+BEyLO4SSTqHPnH99Q==
X-Received: by 2002:a17:902:e1cb:b0:189:6f3:63dd with SMTP id t11-20020a170902e1cb00b0018906f363ddmr7406544pla.168.1669183099937;
        Tue, 22 Nov 2022 21:58:19 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id fv19-20020a17090b0e9300b002130c269b6fsm573204pjb.1.2022.11.22.21.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 21:58:17 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oxily-00HYSd-GV; Wed, 23 Nov 2022 16:58:14 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oxily-003A2f-1W;
        Wed, 23 Nov 2022 16:58:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] iomap: buffered write failure should not truncate the page cache
Date:   Wed, 23 Nov 2022 16:58:08 +1100
Message-Id: <20221123055812.747923-6-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221123055812.747923-1-david@fromorbit.com>
References: <20221123055812.747923-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

iomap_file_buffered_write_punch_delalloc() currently invalidates the
page cache over the unused range of the delalloc extent that was
allocated. While the write allocated the delalloc extent, it does
not own it exclusively as the write does not hold any locks that
prevent either writeback or mmap page faults from changing the state
of either the page cache or the extent state backing this range.

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

To do this, we have to walk the page cache over the range of the
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 194 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 180 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 734b761a1e4a..29be510c3b15 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -832,6 +832,165 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
+/*
+ * Scan the data range passed to us for dirty page cache folios. If we find a
+ * dirty folio, punch out the preceeding range and update the offset from which
+ * the next punch will start from.
+ *
+ * We can punch out storage reservations under clean pages because they either
+ * contain data that has been written back - in which case the delalloc punch
+ * over that range is a no-op - or they have been read faults in which case they
+ * contain zeroes and we can remove the delalloc backing range and any new
+ * writes to those pages will do the normal hole filling operation...
+ *
+ * This makes the logic simple: we only need to keep the delalloc extents only
+ * over the dirty ranges of the page cache.
+ *
+ * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
+ * simplify range iterations.
+ */
+static int iomap_write_delalloc_scan(struct inode *inode,
+		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
+		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
+{
+	while (start_byte < end_byte) {
+		struct folio	*folio;
+
+		/* grab locked page */
+		folio = filemap_lock_folio(inode->i_mapping,
+				start_byte >> PAGE_SHIFT);
+		if (!folio) {
+			start_byte = ALIGN_DOWN(start_byte, PAGE_SIZE) +
+					PAGE_SIZE;
+			continue;
+		}
+
+		/* if dirty, punch up to offset */
+		if (folio_test_dirty(folio)) {
+			if (start_byte > *punch_start_byte) {
+				int	error;
+
+				error = punch(inode, *punch_start_byte,
+						start_byte - *punch_start_byte);
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
+		start_byte = folio_next_index(folio) << PAGE_SHIFT;
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
+ * byte range based iteration is especially convenient because it means we
+ * don't have to care about variable size folios, nor where the start or end of
+ * the data range lies within a folio, if they lie within the same folio or even
+ * if there are multiple discontiguous data ranges within the folio.
+ *
+ * It should be noted that mapping_seek_hole_data() is not aware of EOF, and so
+ * can return data ranges that exist in the cache beyond EOF. e.g. a page fault
+ * spanning EOF will initialise the post-EOF data to zeroes and mark it up to
+ * date. A write page fault can then mark it dirty. If we then fail a write()
+ * beyond EOF into that up to date cached range, we allocate a delalloc block
+ * beyond EOF and then have to punch it out. Because the range is up to date,
+ * mapping_seek_hole_data() will return it, and we will skip the punch because
+ * the folio is dirty. THis is incorrect - we always need to punch out delalloc
+ * beyond EOF in this case as writeback will never write back and covert that
+ * delalloc block beyond EOF. Hence we limit the cached data scan range to EOF,
+ * resulting in always punching out the range from the EOF to the end of the
+ * range the iomap spans.
+ *
+ * Intervals are of the form [start_byte, end_byte) (i.e. open ended) because it
+ * matches the intervals returned by mapping_seek_hole_data(). i.e. SEEK_DATA
+ * returns the start of a data range (start_byte), and SEEK_HOLE(start_byte)
+ * returns the end of the data range (data_end). Using closed intervals would
+ * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
+ * the code to subtle off-by-one bugs....
+ */
+static int iomap_write_delalloc_release(struct inode *inode,
+		loff_t start_byte, loff_t end_byte,
+		int (*punch)(struct inode *inode, loff_t pos, loff_t length))
+{
+	loff_t punch_start_byte = start_byte;
+	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
+	int error = 0;
+
+	/*
+	 * Lock the mapping to avoid races with page faults re-instantiating
+	 * folios and dirtying them via ->page_mkwrite whilst we walk the
+	 * cache and perform delalloc extent removal. Failing to do this can
+	 * leave dirty pages with no space reservation in the cache.
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+	while (start_byte < scan_end_byte) {
+		loff_t		data_end;
+
+		start_byte = mapping_seek_hole_data(inode->i_mapping,
+				start_byte, scan_end_byte, SEEK_DATA);
+		/*
+		 * If there is no more data to scan, all that is left is to
+		 * punch out the remaining range.
+		 */
+		if (start_byte == -ENXIO || start_byte == scan_end_byte)
+			break;
+		if (start_byte < 0) {
+			error = start_byte;
+			goto out_unlock;
+		}
+		WARN_ON_ONCE(start_byte < punch_start_byte);
+		WARN_ON_ONCE(start_byte > scan_end_byte);
+
+		/*
+		 * We find the end of this contiguous cached data range by
+		 * seeking from start_byte to the beginning of the next hole.
+		 */
+		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
+				scan_end_byte, SEEK_HOLE);
+		if (data_end < 0) {
+			error = data_end;
+			goto out_unlock;
+		}
+		WARN_ON_ONCE(data_end <= start_byte);
+		WARN_ON_ONCE(data_end > scan_end_byte);
+
+		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
+				start_byte, data_end, punch);
+		if (error)
+			goto out_unlock;
+
+		/* The next data search starts at the end of this one. */
+		start_byte = data_end;
+	}
+
+	if (punch_start_byte < end_byte)
+		error = punch(inode, punch_start_byte,
+				end_byte - punch_start_byte);
+out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return error;
+}
+
 /*
  * When a short write occurs, the filesystem may need to remove reserved space
  * that was allocated in ->iomap_begin from it's ->iomap_end method. For
@@ -842,8 +1001,25 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
  * allocated for this iomap.
  *
  * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
- * simplify range iterations, but converts them back to {offset,len} tuples for
- * the punch callback.
+ * simplify range iterations.
+ *
+ * The punch() callback *must* only punch delalloc extents in the range passed
+ * to it. It must skip over all other types of extents in the range and leave
+ * them completely unchanged. It must do this punch atomically with respect to
+ * other extent modifications.
+ *
+ * The punch() callback may be called with a folio locked to prevent writeback
+ * extent allocation racing at the edge of the range we are currently punching.
+ * The locked folio may or may not cover the range being punched, so it is not
+ * safe for the punch() callback to lock folios itself.
+ *
+ * Lock order is:
+ *
+ * inode->i_rwsem (shared or exclusive)
+ *   inode->i_mapping->invalidate_lock (exclusive)
+ *     folio_lock()
+ *       ->punch
+ *         internal filesystem allocation lock
  */
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length,
@@ -877,18 +1053,8 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
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
-	error = punch(inode, start_byte, end_byte - start_byte);
-	filemap_invalidate_unlock(inode->i_mapping);
-
-	return error;
+	return iomap_write_delalloc_release(inode, start_byte, end_byte,
+					punch);
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 
-- 
2.37.2

