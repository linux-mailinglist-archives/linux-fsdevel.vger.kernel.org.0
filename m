Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F306161AFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgBQSts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:49:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgBQSqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TRd7Ps5bWxlwa3OWn+vpade7IP4m4k5O05zkXvvMr5Y=; b=KoRhZEZYO5r+aVQxWky2Sj5cKV
        x5KBRIm9HCvfLDRhcpo8BUshp6Yq45beYscHHQdrq+ozwaUlWGWSSBKc50p/2rxrcZknOWpduMgh4
        xti2jXe2tmFQgy25MwHLfu5E0Fezg/REcQJUwOvzgiH+Lp1MafCFPWO4LTpJ9BSxXFIQHqmqBHFOl
        4wIYMJ/6quo6hrkQKaq/0UogZI/X/vzR2t6osdUETyioAtrQegqbLstedpDQB5HdRdJ9OLJofEZ2c
        i3h+QbctO+ZRIYJgDEdD1xU6PVDrLqT0z+SIF3TRqfiy0Tb5zunZiVX4aOH6WZ0LMoDpDsSPlhkij
        pVaN5kew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lPM-0005Dk-G5; Mon, 17 Feb 2020 18:46:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
Date:   Mon, 17 Feb 2020 10:46:11 -0800
Message-Id: <20200217184613.19668-31-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By putting the 'have we reached the end of the page' condition at the end
of the loop instead of the beginning, we can remove the 'submit the last
page' code from iomap_readpages().  Also check that iomap_readpage_actor()
didn't return 0, which would lead to an endless loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cb3511eb152a..44303f370b2d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -400,15 +400,9 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iomap_readpage_ctx *ctx = data;
-	loff_t done, ret;
+	loff_t ret, done = 0;
 
-	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
-			if (!ctx->cur_page_in_bio)
-				unlock_page(ctx->cur_page);
-			put_page(ctx->cur_page);
-			ctx->cur_page = NULL;
-		}
+	while (done < length) {
 		if (!ctx->cur_page) {
 			ctx->cur_page = iomap_next_page(inode, ctx->pages,
 					pos, length, &done);
@@ -418,6 +412,15 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
 				ctx, iomap, srcmap);
+		if (WARN_ON(ret == 0))
+			break;
+		done += ret;
+		if (offset_in_page(pos + done) == 0) {
+			if (!ctx->cur_page_in_bio)
+				unlock_page(ctx->cur_page);
+			put_page(ctx->cur_page);
+			ctx->cur_page = NULL;
+		}
 	}
 
 	return done;
@@ -451,11 +454,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
 done:
 	if (ctx.bio)
 		submit_bio(ctx.bio);
-	if (ctx.cur_page) {
-		if (!ctx.cur_page_in_bio)
-			unlock_page(ctx.cur_page);
-		put_page(ctx.cur_page);
-	}
+	BUG_ON(ctx.cur_page);
 
 	/*
 	 * Check that we didn't lose a page due to the arcance calling
-- 
2.25.0

