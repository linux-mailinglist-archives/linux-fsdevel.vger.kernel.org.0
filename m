Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8B974154B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjF1Pdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjF1PdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:33:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC0D26AB;
        Wed, 28 Jun 2023 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qx+gJ458aK+w8h5IAu2/xFThKmZn2rfF87JLskCyXl0=; b=39SuDBgZxbpLbHeTACnruu8DVF
        tJFuJedPZV/h4Ihz7hI1C3gco2ksH3sU8ZVho3+zYJUSbBZsR8DPeRIRW9zA44iWqQ231csSe+069
        OPCQUPtrmpCTuQN+vTP0+6WW2A/R8EwQFSl6UfAOfWAVMEH7C6BPc4Y6nBR0J6pcXMJwiwu9cVNAw
        Gm7UWIdxso3rdXM6yqPqZya6iTHSJ/MWmtn6R+64q+f4Uy9Pihvp5qeUSG2b2oNtXg13gSriqDT7P
        FZ0Ptofn4RPob5Z4AWKILypIb/xUBaf0Q8LVenz+HM6TXBmY8QjNT+1hqKAho7U7C1Di6wrGb9S3w
        za3mrXDg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEXA4-00G0F8-0r;
        Wed, 28 Jun 2023 15:32:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/23] btrfs: refactor the zoned device handling in cow_file_range
Date:   Wed, 28 Jun 2023 17:31:41 +0200
Message-Id: <20230628153144.22834-21-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handling of the done_offset to cow_file_range is a bit confusing, as
it is not updated at all when the function succeeds, and the -EAGAIN
status is used bother for the case where we need to wait for a zone
finish and the one where the allocation was partially successful.

Change the calling convention so that done_offset is always updated,
and 0 is returned if some allocation was successful (partial allocation
can still only happen for zoned devices), and waiting for a zone
finish is done internally in cow_file_range instead of the caller.

Also write a big fat comment explaining the logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 58 ++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 556f63e8496ff8..2a4b62398ee7a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1364,7 +1364,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * compressed extent.
 			 */
 			unlock_page(locked_page);
-			return 1;
+			ret = 1;
+			goto done;
 		} else if (ret < 0) {
 			goto out_unlock;
 		}
@@ -1395,6 +1396,31 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
 					   min_alloc_size, 0, alloc_hint,
 					   &ins, 1, 1);
+		if (ret == -EAGAIN) {
+			/*
+			 * btrfs_reserve_extent only returns -EAGAIN for zoned
+			 * file systems, which is an indication that there are
+			 * no active zones to allocate from at the moment.
+			 *
+			 * If this is the first loop iteration, wait for at
+			 * least one zone to finish before retrying the
+			 * allocation.  Otherwise ask the caller to write out
+			 * the already allocated blocks before coming back to
+			 * us, or return -ENOSPC if it can't handle retries.
+			 */
+			ASSERT(btrfs_is_zoned(fs_info));
+			if (start == orig_start) {
+				wait_on_bit_io(&inode->root->fs_info->flags,
+					       BTRFS_FS_NEED_ZONE_FINISH,
+					       TASK_UNINTERRUPTIBLE);
+				continue;
+			}
+			if (done_offset) {
+				*done_offset = start - 1;
+				return 0;
+			}
+			ret = -ENOSPC;
+		}
 		if (ret < 0)
 			goto out_unlock;
 		cur_alloc_size = ins.offset;
@@ -1478,6 +1504,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_unlock;
 	}
+done:
+	if (done_offset)
+		*done_offset = end;
 	return ret;
 
 out_drop_extent_cache:
@@ -1486,21 +1515,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_unlock:
-	/*
-	 * If done_offset is non-NULL and ret == -EAGAIN, we expect the
-	 * caller to write out the successfully allocated region and retry.
-	 */
-	if (done_offset && ret == -EAGAIN) {
-		if (orig_start < start)
-			*done_offset = start - 1;
-		else
-			*done_offset = start;
-		return ret;
-	} else if (ret == -EAGAIN) {
-		/* Convert to -ENOSPC since the caller cannot retry. */
-		ret = -ENOSPC;
-	}
-
 	/*
 	 * Now, we have three regions to clean up:
 	 *
@@ -1711,19 +1725,9 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 	while (start <= end) {
 		ret = cow_file_range(inode, locked_page, start, end,
 				     &done_offset, CFR_KEEP_LOCKED);
-		if (ret && ret != -EAGAIN)
+		if (ret)
 			return ret;
 
-		if (ret == 0)
-			done_offset = end;
-
-		if (done_offset == start) {
-			wait_on_bit_io(&inode->root->fs_info->flags,
-				       BTRFS_FS_NEED_ZONE_FINISH,
-				       TASK_UNINTERRUPTIBLE);
-			continue;
-		}
-
 		if (!locked_page_done) {
 			__set_page_dirty_nobuffers(locked_page);
 			account_page_redirty(locked_page);
-- 
2.39.2

