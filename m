Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64592605B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 22:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIGUhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 16:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgIGUhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:37:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F53C061573;
        Mon,  7 Sep 2020 13:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rgfnIrHnaAEI6RXa4m3uPfmsWUpeORTndps4hZE1Wow=; b=BP+h+jIeaZhfpoJYvQtJPTIn1g
        rP9UigoetxvDNdDyxvc0RcEkLodhk+1xHLgHQhX1UkgMAu+xiuMye/3xSUCKzL2F1qLGPHfdOaM7G
        7X32qBBWaysEGewE797mvwFa5It54OilLN3WRBs+MYmzVbDMzVB4eND8tPb6KlIgE3YxesEVce6VT
        +BUsSaBH4+fLVM9CA45kWOB5YeOWJjdQsUtT924BDvBhnMBNNT0G9j3r7r/KJIieoQffKeTgp3/Lm
        zEVbJkuq9UXNdImvpKXUZRMIBPwT0CmUV2dwo7t4BGhuYgPOqd/Am/2ndMe0EXyr0jEbKGc51Mf0Q
        d2qkUBsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFNsz-00013I-0f; Mon, 07 Sep 2020 20:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] iomap: Mark read blocks uptodate in write_begin
Date:   Mon,  7 Sep 2020 21:37:07 +0100
Message-Id: <20200907203707.3964-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200907203707.3964-1-willy@infradead.org>
References: <20200907203707.3964-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When bringing (portions of) a page uptodate, we were marking blocks that
were zeroed as being uptodate, but not blocks that were read from storage.

Like the previous commit, this problem was found with generic/127 and
a kernel which failed readahead I/Os.  This bug causes writes to be
silently lost when working with flaky storage.

Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c95454784df4..897ab9a26a74 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -574,7 +574,6 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 	loff_t block_start = pos & ~(block_size - 1);
 	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
 	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
-	int status;
 
 	if (PageUptodate(page))
 		return 0;
@@ -595,14 +594,13 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
 			if (WARN_ON_ONCE(flags & IOMAP_WRITE_F_UNSHARE))
 				return -EIO;
 			zero_user_segments(page, poff, from, to, poff + plen);
-			iomap_set_range_uptodate(page, poff, plen);
-			continue;
+		} else {
+			int status = iomap_read_page_sync(block_start, page,
+					poff, plen, srcmap);
+			if (status)
+				return status;
 		}
-
-		status = iomap_read_page_sync(block_start, page, poff, plen,
-				srcmap);
-		if (status)
-			return status;
+		iomap_set_range_uptodate(page, poff, plen);
 	} while ((block_start += plen) < block_end);
 
 	return 0;
-- 
2.28.0

