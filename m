Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F651628F45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 02:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiKOBbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 20:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKOBbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:31:02 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D2962FE
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h14so11949074pjv.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao3r4ObshVMOTeg9d8XwDGgMsxE9xyLmCjV3U83plkg=;
        b=IxLXf8uPVQk2uek4l4A7Ma0r42OMSFEwWJMY5GlhrmXuYw0hkvYTCABeUXdwgEXbCb
         wLzxihAxsr7f8jNGmHPWcwKK3BEc7Xftau4qy1yM4n/b/hpkaFN4Xpwqgq6SMXQHZfrN
         ubvwH07dPUs7gOIV7qduBQBGyEVmJniTH41HFk6l1fLGWWLwncjtzijD0aITz5mJ6eXb
         VrR2KLhazGSAr4LfAf9MEePPX4GtNvjlXLq2DnDcOB9+22JRgjEIxoYa0ag2l49pdx1d
         44ajQMaCRuhBigGiwG4dJyFBMpc/woEXbf9XCmxISbGm9yf0Q7dzeT2Rm/7LmGw8sMaF
         YH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao3r4ObshVMOTeg9d8XwDGgMsxE9xyLmCjV3U83plkg=;
        b=1Rbqo1Q+9FOrPF7TC5jbSDKNII9K7atQKC33C6a1Wi3R1I7417qBT/cffmc0BpJocO
         d4XWFYil/hgyj4vo4Hyk+caMqDkGinuOwz2l11BP3BDg3iRYIwXwUSR4Nrm5jRV/6X4+
         nWlOuG2qk5kyn9Ds+czq0XtaP7Gyh+/DnJthl0gw6UO+YTkfS8cgP//alvTF/MYU9NIW
         X9TVO/1pY26/Igr65iT3BHFPKaAx3JqyZYrnYsujZ3MzutFSXmprUDAvKMCtHus0tQ3W
         nA0hTC/DWtEaKeIOY2r8ZBFCLjHqTsX1GO56M7l2EpdsCrYhyfJkkPSaoj3mS7+1bsaP
         OuYA==
X-Gm-Message-State: ANoB5plTJPQyMn/ClWJZ4vUEmbaRhoxw2cVB+ytfttO1ZQfwp/IQGvsG
        l4xOhMu1TtM20oG5yz6r328M5j33sXuYxA==
X-Google-Smtp-Source: AA0mqf6VWZhWw2NouJCG7fUJ8iXNFP6L9tR8d5A3cPmJ34Q2RxBmQHkFWBn4GqNEAHrcyqUTwhQqEw==
X-Received: by 2002:a17:902:cf4c:b0:185:4703:9f5f with SMTP id e12-20020a170902cf4c00b0018547039f5fmr1762037plg.156.1668475850539;
        Mon, 14 Nov 2022 17:30:50 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b00186f608c543sm8304789plf.304.2022.11.14.17.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:30:48 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-00EKG3-Cw; Tue, 15 Nov 2022 12:30:45 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-001VpU-1B;
        Tue, 15 Nov 2022 12:30:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 5/9] xfs: buffered write failure should not truncate the page cache
Date:   Tue, 15 Nov 2022 12:30:39 +1100
Message-Id: <20221115013043.360610-6-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115013043.360610-1-david@fromorbit.com>
References: <20221115013043.360610-1-david@fromorbit.com>
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
---
 fs/xfs/xfs_iomap.c | 151 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 10 deletions(-)

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
-- 
2.37.2

