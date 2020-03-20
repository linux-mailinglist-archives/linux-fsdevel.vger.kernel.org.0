Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 015BC18D140
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCTOkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 10:40:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgCTOkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vD1Vg/bGwDX0c3uBrlZdY6IfeDsuGImhXEIib437kIM=; b=lUcgDeTXVmVT8d8A+8fJSSHE1p
        q4y925fnhrhV3iJkvOe4cpDLXn6choSTzLIuS38YOVTDN7whr5DD2b1scCNJG5+Dg35wLLqE3zPZ3
        XZR/fWfoPZPzAa2q6bFLrxLBFI8Qg34vLDTfdZQaa3HvmHhH02O79/MBNAyKk/TwCNoKs+4oVsvKS
        o8syQUn775VPcQwUY5NcDcrIhojI+UZBSVgswVcDCRMmILU73o/ws4BWfFfHiE+3sloAUL3aW+53a
        2UIQpQaAyfqFCnT8bYcSwmUxqBjo1LYC3H8w0D2O3lC8Bgx9UZG1BV8aV6qa6K/HPHnl1vdSF7Ipy
        DtrfbBzg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFIoq-0001DY-14; Fri, 20 Mar 2020 14:40:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] iomap: Submit the BIO at the end of each extent
Date:   Fri, 20 Mar 2020 07:40:14 -0700
Message-Id: <20200320144014.3276-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By definition, an extent covers a range of consecutive blocks, so
it would be quite rare to be able to just add pages to the BIO from
a previous range.  The only case we can think of is a mapped extent
followed by a hole extent, followed by another mapped extent which has
been allocated immediately after the first extent.  We believe this to
be an unlikely layout for a filesystem to choose and, since the queue
is plugged, those two BIOs would be merged by the block layer.

The reason we care is that ext2/ext4 choose to lay out blocks 0-11
consecutively, followed by the indirect block, and we want to merge those
two BIOs.  If we don't submit the data BIO before asking the filesystem
for the next extent, then the indirect BIO will be submitted first,
and waited for, leading to inefficient I/O patterns.  Buffer heads solve
this with the BH_boundary flag, but iomap doesn't need that as long as
we submit the bio here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f080f542911b..417115bfaf6b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -420,6 +420,16 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 				ctx, iomap, srcmap);
 	}
 
+	/*
+	 * Submitting the bio here leads to better I/O patterns for
+	 * filesystems which need to do metadata reads to find the
+	 * next extent.
+	 */
+	if (ctx->bio) {
+		submit_bio(ctx->bio);
+		ctx->bio = NULL;
+	}
+
 	return done;
 }
 
@@ -449,8 +459,6 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 	}
 	ret = 0;
 done:
-	if (ctx.bio)
-		submit_bio(ctx.bio);
 	if (ctx.cur_page) {
 		if (!ctx.cur_page_in_bio)
 			unlock_page(ctx.cur_page);
-- 
2.25.1

