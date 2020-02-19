Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9374916507A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBSVBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:01:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgBSVBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=erFAlFt7URKao+s7h4ENpLN+DsCi0u0lEGbwZPr/bFo=; b=Ez8O6Ork4eM5HUZAaYjx52rH2y
        4lieoM83EpQuWgejFeMJRSD3vAz098TXGV3I4kOGIMPFYhkczKgk6r9ev9aYcBhMFWPV6Su87WcUF
        WzSqnxWhPQiSIvNFy5wvbWQhLCuGo9rdjXrglVVZc7aTNjzUc/1VxOBxvY8ksQWBNs/tDWxUValZ1
        zNq6IQcJoXKrO93oWsp6x6tqa7v5Isrcub5czeYkk+HLGrOV9JhvQ0pR1hBiIFm6SO1MVW4+xqzj5
        +lcM2cyaeBfGc9H2MieqJ+y/i/uohPEyQx9bwMAqtRJz0AdumNavA7uQpYKgL2AAcn9oHSYzFN/fi
        bCsNsoYg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4WSv-0008VK-Gt; Wed, 19 Feb 2020 21:01:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v7 21/24] iomap: Restructure iomap_readpages_actor
Date:   Wed, 19 Feb 2020 13:01:00 -0800
Message-Id: <20200219210103.32400-22-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
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
 fs/iomap/buffered-io.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cb3511eb152a..31899e6cb0f8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -400,15 +400,9 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 		void *data, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iomap_readpage_ctx *ctx = data;
-	loff_t done, ret;
-
-	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
-			if (!ctx->cur_page_in_bio)
-				unlock_page(ctx->cur_page);
-			put_page(ctx->cur_page);
-			ctx->cur_page = NULL;
-		}
+	loff_t ret, done = 0;
+
+	while (done < length) {
 		if (!ctx->cur_page) {
 			ctx->cur_page = iomap_next_page(inode, ctx->pages,
 					pos, length, &done);
@@ -418,6 +412,20 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
 				ctx, iomap, srcmap);
+		done += ret;
+
+		/* Keep working on a partial page */
+		if (ret && offset_in_page(pos + done))
+			continue;
+
+		if (!ctx->cur_page_in_bio)
+			unlock_page(ctx->cur_page);
+		put_page(ctx->cur_page);
+		ctx->cur_page = NULL;
+
+		/* Don't loop forever if we made no progress */
+		if (WARN_ON(!ret))
+			break;
 	}
 
 	return done;
@@ -451,11 +459,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
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

