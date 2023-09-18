Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533FC7A5619
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjIRXMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:12:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29199;
        Mon, 18 Sep 2023 16:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A4FC433C7;
        Mon, 18 Sep 2023 23:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695078731;
        bh=mESWbYZ+5fFLjoX7bRpHcoHkMIc1+TPSSsaojhOfaps=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LpzTwK48vQNQkJFmolVasj/fv9FvzzAn0azjUN4WkUcF8z90g7vp9ckX0JAR/Wj8t
         89RBrL9yWfNrgvJHaOu9jUPYYIeZHxljoudf7qKB15ys62jT86HMvXxcLH+fCIwHcK
         TTm6ynV8BFSidB9GeAYqfuF28xSTMk0W5qFtmaTOsn2sR62iCzw52qUX3HrtDW5ukj
         TYt7Vw4pJJ/P8RS9KjOp4bdicpbZ0CL/X6xrWi5FqE3gS6rnMQ5+/aiJpNxykA3nQo
         qm7snKSe2swCYBPWd4J8O1HQUIh8S4VHoQ4chdszhTih8q84oxmygGnvxedTA6+U6r
         R/K+MbXa3sz0Q==
Subject: [PATCH 2/2] iomap: convert iomap_unshare_iter to use large folios
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     ritesh.list@gmail.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, willy@infradead.org
Date:   Mon, 18 Sep 2023 16:12:11 -0700
Message-ID: <169507873100.772278.2320683121600245730.stgit@frogsfrogsfrogs>
In-Reply-To: <169507871947.772278.5767091361086740046.stgit@frogsfrogsfrogs>
References: <169507871947.772278.5767091361086740046.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Convert iomap_unshare_iter to create large folios if possible, since the
write and zeroing paths already do that.  I think this got missed in the
conversion of the write paths that landed in 6.6-rc1.

Cc: ritesh.list@gmail.com, willy@infradead.org
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0350830fc989..db889bdfd327 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1263,7 +1263,6 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
-	long status = 0;
 	loff_t written = 0;
 
 	/* don't bother with blocks that are not shared to start with */
@@ -1274,9 +1273,10 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		return length;
 
 	do {
-		unsigned long offset = offset_in_page(pos);
-		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct folio *folio;
+		int status;
+		size_t offset;
+		size_t bytes = min_t(u64, SIZE_MAX, length);
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status))
@@ -1284,18 +1284,22 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		if (iter->iomap.flags & IOMAP_F_STALE)
 			break;
 
-		status = iomap_write_end(iter, pos, bytes, bytes, folio);
-		if (WARN_ON_ONCE(status == 0))
+		offset = offset_in_folio(folio, pos);
+		if (bytes > folio_size(folio) - offset)
+			bytes = folio_size(folio) - offset;
+
+		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
 		cond_resched();
 
-		pos += status;
-		written += status;
-		length -= status;
+		pos += bytes;
+		written += bytes;
+		length -= bytes;
 
 		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
-	} while (length);
+	} while (length > 0);
 
 	return written;
 }

