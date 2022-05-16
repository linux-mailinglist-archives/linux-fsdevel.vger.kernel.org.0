Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC28527C72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 05:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbiEPDhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 May 2022 23:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiEPDhN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 May 2022 23:37:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F67220E4;
        Sun, 15 May 2022 20:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29B95B80E6D;
        Mon, 16 May 2022 03:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26E8C385B8;
        Mon, 16 May 2022 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652672229;
        bh=ieVzGRCnG7/Hs96TdN+neqFFJ70o0yXplmMTTgyhMZw=;
        h=Date:From:To:Cc:Subject:From;
        b=T7CDPa4T86Eb07PDjrlTCp4pwqHdQuLpVwp1cGKS9NrvUE30oCsw2JxMhIix5yZhO
         6QBti/vTQskrh9SegVxJVYl0JqT7et92HlGQYrLxtRw1RQKtOmByok7vT6uFfdzz1X
         8KQcJUuWEVcBz6EgEmAC8ydwl8eZaWTy/2vQev/VwZECDD79KYcVUqJp5fgQs+xYJD
         filvr5tj/7jB1QaLNSOTetaOh0HcvjlNm0njZSmrbAy85/QlLt1rVGy9SKei0ng6TX
         F+EONuoXohUUANpHXq8ra/djhyDC9a3pM16Pm3b5g7akf9MTy6vQlwTc3u15+7w3c2
         Mb1KNx42c9lEw==
Date:   Sun, 15 May 2022 20:37:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] iomap: don't invalidate folios after writeback errors
Message-ID: <YoHG5cMwvx8PSddI@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

XFS has the unique behavior (as compared to the other Linux filesystems)
that on writeback errors it will completely invalidate the affected
folio and force the page cache to reread the contents from disk.  All
other filesystems leave the page mapped and up to date.

This is a rude awakening for user programs, since (in the case where
write fails but reread doesn't) file contents will appear to revert to
old disk contents with no notification other than an EIO on fsync.  This
might have been annoying back in the days when iomap dealt with one page
at a time, but with multipage folios, we can now throw away *megabytes*
worth of data for a single write error.

On *most* Linux filesystems, a program can respond to an EIO on write by
redirtying the entire file and scheduling it for writeback.  This isn't
foolproof, since the page that failed writeback is no longer dirty and
could be evicted, but programs that want to recover properly *also*
have to detect XFS and regenerate every write they've made to the file.

When running xfs/314 on arm64, I noticed a UAF bug when xfs_discard_folio
invalidates multipage folios that could be undergoing writeback.  If,
say, we have a 256K folio caching a mix of written and unwritten
extents, it's possible that we could start writeback of the first (say)
64K of the folio and then hit a writeback error on the next 64K.  We
then free the iop attached to the folio, which is really bad because
writeback completion on the first 64k will trip over the "blocks per
folio > 1 && !iop" assertion.

This can't be fixed by only invalidating the folio if writeback fails at
the start of the folio, since the folio is marked !uptodate, which trips
other assertions elsewhere.  Get rid of the whole behavior entirely.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |    1 -
 fs/xfs/xfs_aops.c      |    4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8fb9b2797fc5..94b53cbdefad 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1387,7 +1387,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (wpc->ops->discard_folio)
 			wpc->ops->discard_folio(folio, pos);
 		if (!count) {
-			folio_clear_uptodate(folio);
 			folio_unlock(folio);
 			goto done;
 		}
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 90b7f4d127de..f6216d0fb0c2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -464,7 +464,7 @@ xfs_discard_folio(
 	int			error;
 
 	if (xfs_is_shutdown(mp))
-		goto out_invalidate;
+		return;
 
 	xfs_alert_ratelimited(mp,
 		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
@@ -474,8 +474,6 @@ xfs_discard_folio(
 			i_blocks_per_folio(inode, folio) - pageoff_fsb);
 	if (error && !xfs_is_shutdown(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
-out_invalidate:
-	iomap_invalidate_folio(folio, offset, folio_size(folio) - offset);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
