Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FDC628F38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 02:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiKOBaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 20:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiKOBau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:30:50 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C10760C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:49 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z26so12741312pff.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpYORrtHPEFkdqKAbT3ik18Ay5BZZZbilDStDtNjXS8=;
        b=co43QgtTK4koY81+x7Mo6GXWhA8qafRWtVduLzA3bTAJl8WxeaRPbiJZNKYpZvtv98
         BBfXbZtdI9El//DFgPBA3E6qxVtEWYfRyAadPz9RFZwsBQoXz26JkDUb5MtjjcvgnuU6
         H/6MiKVkvnQSQKTvlNghrZ3Ag66qduR2ABeHfYCn0Fwdu88F4MOQpTC5TrSqp+lNGouq
         Rr5jP3OZu6Nfy3I0yadxa2fjIda663NaefuTlLmr5xVjGTCWQubF0+38igI0nlXOkxbY
         TMnuc3qwv9lmbKuaa+duJvVX8XPUiSWifr3CeWjxTrQ5A0LZYVpfELEUPY5QvTEi+zLN
         Bvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpYORrtHPEFkdqKAbT3ik18Ay5BZZZbilDStDtNjXS8=;
        b=apFHJX4QylsbCR/p15d+lgND5SFR4TgQCNNImGuwnIXxOYw4trvVq1ENXym2hqedxI
         0yLOVomCLH/bhsfx8MmSKHll9ETA0XZnzgfuctwu8C/A1UhXF1kFRuE9XwOL0KnXLtCe
         wJirfC+RBa8jgE7LGhM7XezCzJuyZWOFrrUB4zp60Xtt4N9yezmu4Ef8pyFkbGzrH2zJ
         FBhpNs6Rr5d2W8biGPQmwa7PcgjRgAxn6HdFUG5Puk9giFlPNJMq5AsshDaGTe0f1f48
         FbDGD1KEFaFc34AgH9hxt7pCiTRPFc5ktGthbtFPBlLf698wjugp1PjHbebSvZR8rmOg
         fktw==
X-Gm-Message-State: ANoB5pm9yRRdL3BgdxFbHcWdBmZX37S0wfC4RR+l54OYaIxChanqPYXm
        8iypKmZ+kLwfg9uMTdYf1Y3Daw==
X-Google-Smtp-Source: AA0mqf7cXllmyDaiPWcvaKRz/fwiRS4L+bWOPOhO9q5Y16NL3MgbOh3d+5jMiP3wDCY0eNsTVcQnmQ==
X-Received: by 2002:a63:3601:0:b0:46e:fa6d:497 with SMTP id d1-20020a633601000000b0046efa6d0497mr13560226pga.60.1668475848708;
        Mon, 14 Nov 2022 17:30:48 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b00186f608c543sm8304788plf.304.2022.11.14.17.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:30:47 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-00EKFw-B3; Tue, 15 Nov 2022 12:30:45 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-001VpM-10;
        Tue, 15 Nov 2022 12:30:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/9] xfs: punching delalloc extents on write failure is racy
Date:   Tue, 15 Nov 2022 12:30:37 +1100
Message-Id: <20221115013043.360610-4-david@fromorbit.com>
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

xfs_buffered_write_iomap_end() has a comment about the safety of
punching delalloc extents based holding the IOLOCK_EXCL. This
comment is wrong, and punching delalloc extents is not race free.

When we punch out a delalloc extent after a write failure in
xfs_buffered_write_iomap_end(), we punch out the page cache with
truncate_pagecache_range() before we punch out the delalloc extents.
At this point, we only hold the IOLOCK_EXCL, so there is nothing
stopping mmap() write faults racing with this cleanup operation,
reinstantiating a folio over the range we are about to punch and
hence requiring the delalloc extent to be kept.

If this race condition is hit, we can end up with a dirty page in
the page cache that has no delalloc extent or space reservation
backing it. This leads to bad things happening at writeback time.

To avoid this race condition, we need the page cache truncation to
be atomic w.r.t. the extent manipulation. We can do this by holding
the mapping->invalidate_lock exclusively across this operation -
this will prevent new pages from being inserted into the page cache
whilst we are removing the pages and the backing extent and space
reservation.

Taking the mapping->invalidate_lock exclusively in the buffered
write IO path is safe - it naturally nests inside the IOLOCK (see
truncate and fallocate paths). iomap_zero_range() can be called from
under the mapping->invalidate_lock (from the truncate path via
either xfs_zero_eof() or xfs_truncate_page(), but iomap_zero_iter()
will not instantiate new delalloc pages (because it skips holes) and
hence will not ever need to punch out delalloc extents on failure.

Fix the locking issue, and clean up the code logic a little to avoid
unnecessary work if we didn't allocate the delalloc extent or wrote
the entire region we allocated.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_iomap.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 5cea069a38b4..a2e45ea1b0cb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1147,6 +1147,10 @@ xfs_buffered_write_iomap_end(
 		written = 0;
 	}
 
+	/* If we didn't reserve the blocks, we're not allowed to punch them. */
+	if (!(iomap->flags & IOMAP_F_NEW))
+		return 0;
+
 	/*
 	 * start_fsb refers to the first unused block after a short write. If
 	 * nothing was written, round offset down to point at the first block in
@@ -1158,27 +1162,28 @@ xfs_buffered_write_iomap_end(
 		start_fsb = XFS_B_TO_FSB(mp, offset + written);
 	end_fsb = XFS_B_TO_FSB(mp, offset + length);
 
+	/* Nothing to do if we've written the entire delalloc extent */
+	if (start_fsb >= end_fsb)
+		return 0;
+
 	/*
-	 * Trim delalloc blocks if they were allocated by this write and we
-	 * didn't manage to write the whole range.
-	 *
-	 * We don't need to care about racing delalloc as we hold i_mutex
-	 * across the reserve/allocate/unreserve calls. If there are delalloc
-	 * blocks in the range, they are ours.
+	 * Lock the mapping to avoid races with page faults re-instantiating
+	 * folios and dirtying them via ->page_mkwrite between the page cache
+	 * truncation and the delalloc extent removal. Failing to do this can
+	 * leave dirty pages with no space reservation in the cache.
 	 */
-	if ((iomap->flags & IOMAP_F_NEW) && start_fsb < end_fsb) {
-		truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
-					 XFS_FSB_TO_B(mp, end_fsb) - 1);
-
-		error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-					       end_fsb - start_fsb);
-		if (error && !xfs_is_shutdown(mp)) {
-			xfs_alert(mp, "%s: unable to clean up ino %lld",
-				__func__, ip->i_ino);
-			return error;
-		}
+	filemap_invalidate_lock(inode->i_mapping);
+	truncate_pagecache_range(VFS_I(ip), XFS_FSB_TO_B(mp, start_fsb),
+				 XFS_FSB_TO_B(mp, end_fsb) - 1);
+
+	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
+				       end_fsb - start_fsb);
+	filemap_invalidate_unlock(inode->i_mapping);
+	if (error && !xfs_is_shutdown(mp)) {
+		xfs_alert(mp, "%s: unable to clean up ino %lld",
+			__func__, ip->i_ino);
+		return error;
 	}
-
 	return 0;
 }
 
-- 
2.37.2

