Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F41614249
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 01:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKAAeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 20:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKAAeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:34:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EAF1583D
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 17:34:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i3so12084075pfc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 17:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpYORrtHPEFkdqKAbT3ik18Ay5BZZZbilDStDtNjXS8=;
        b=61c904ATR7ihnICXDiY7DEoT0knpUcuEM9TKOou3O4466QVWdIbsTUVngQkvubsPDO
         M3Iv8gwMu6bHf81ZdtPGxzFbq1mFZB2G8tCEZ6iiNMYr6EygMRVKVz2p1lRbJxnbRUsr
         FsfJhYepQjsQowj5NUJQFn+/tllCIcGYE1koACso5b+lKk9Vs1m89ogeG9Psx1Wp21sq
         3KmKSoC9hhKCbbBuL5DpCqLGErmY03TJaSEjkhHnAWjzxsAbLPfKhWwAQYU2wrIT5L89
         tSu8aaVwLcYS+jnHMIP5I7cXZUnM13M43pzceerhkcYunsDzlt6RqZepotmBXMJryMvR
         wz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpYORrtHPEFkdqKAbT3ik18Ay5BZZZbilDStDtNjXS8=;
        b=13uXbQ+JusoKvZDidbaLmWPzrfKx3IJhkJB3mUyKdzsuU4ErmCKYKzCjw2JbAjXGe1
         D6LGD6GnhfdcgUBDzx+uT/1S7yHmEpl9zp53myzyDbBl3XZC0ig38gR3FzajGG/bwTnE
         3sef/KDbTaM61ydqrXx/x8MU/cR69w/dD/fOEiD/Djk1FDq8lx5F2CSTlzNhnjvPfkNT
         Rj5efkTidjB7xmW12Fn35RWKZ4KlB77owO4kVKhx6NtfiE80jBglHsHGsZ55LGOFmgcH
         /b537CqxknsyNWJ8hHyFk0bcqW3XCZYvpo/Xee3qKavHW3SU18SQz5zhBaVa9JlnFL9A
         O87A==
X-Gm-Message-State: ACrzQf3MxAVl/aXx+EQHk8+P2Nwf4lz+DxnyvXRs95PcgF12SlPyL83d
        PHO1ssFXmycAPquf0myf2gEB3BjCV9KinQ==
X-Google-Smtp-Source: AMsMyM4aCmFhq+ySHVIkk6+EXgD7HL2pSuSBBmcslufMmYLwVPJdsei/QPpBdPSkaOv1iDMck1TyNw==
X-Received: by 2002:a05:6a02:186:b0:439:49a3:479b with SMTP id bj6-20020a056a02018600b0043949a3479bmr15024664pgb.171.1667262858203;
        Mon, 31 Oct 2022 17:34:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b0017dd8c8009esm5003862plj.4.2022.10.31.17.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:34:17 -0700 (PDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1opfEN-008muJ-4m; Tue, 01 Nov 2022 11:34:15 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1opfEN-00G7da-0N;
        Tue, 01 Nov 2022 11:34:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] xfs: punching delalloc extents on write failure is racy
Date:   Tue,  1 Nov 2022 11:34:07 +1100
Message-Id: <20221101003412.3842572-3-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221101003412.3842572-1-david@fromorbit.com>
References: <20221101003412.3842572-1-david@fromorbit.com>
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

