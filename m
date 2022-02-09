Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5074AFE41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiBIUXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiBIUW3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F13E015649
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Bd3sC5yc8k3R1SWGFbX9Uzk1LCsJQ4cpM4t6tybLNUg=; b=fIT2d5g+aJ1FyPYrewmVPTU0fj
        cliKAqL8dAPOIfFmQ+gj7R3aJePTTTg+Ez0bkopBJd0kBVvbYvFWkL5FQMxsCkNPuaazOn6xfMAxx
        D1LYK4t0YmZC6nuBvzU1IxfVH5C4fICOWscEIHBgdbt3zquzfn+Fc9iiQdRA4WgP0r1Iu4r4eHqev
        UuK/0pG656WSG9JUcE7yvcv4pNYSoZUCUbBN3JOtDRgMIQtQ4h5mRdwuocjtfmlPJ0l/3pkgusNrD
        1f65yjxGc4X0wu+fOUsRwFDqAC1tdpClfknPt0jiv/qUfq2roCV6dlrZgxLgcNmXDkc+jj34lduYY
        AZp9V6XQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTu-008crN-8s; Wed, 09 Feb 2022 20:22:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 29/56] orangefs: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:48 +0000
Message-Id: <20220209202215.2055748-30-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a straightforward conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index e5e3e500ed46..26f163b13b16 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -46,7 +46,7 @@ static int orangefs_writepage_locked(struct page *page,
 		else
 			wlen = PAGE_SIZE;
 	}
-	/* Should've been handled in orangefs_invalidatepage. */
+	/* Should've been handled in orangefs_invalidate_folio. */
 	WARN_ON(off == len || off + wlen > len);
 
 	bv.bv_page = page;
@@ -415,47 +415,45 @@ static int orangefs_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
-static void orangefs_invalidatepage(struct page *page,
-				 unsigned int offset,
-				 unsigned int length)
+static void orangefs_invalidate_folio(struct folio *folio,
+				 size_t offset, size_t length)
 {
-	struct orangefs_write_range *wr;
-	wr = (struct orangefs_write_range *)page_private(page);
+	struct orangefs_write_range *wr = folio_get_private(folio);
 
 	if (offset == 0 && length == PAGE_SIZE) {
-		kfree(detach_page_private(page));
+		kfree(folio_detach_private(folio));
 		return;
 	/* write range entirely within invalidate range (or equal) */
-	} else if (page_offset(page) + offset <= wr->pos &&
-	    wr->pos + wr->len <= page_offset(page) + offset + length) {
-		kfree(detach_page_private(page));
+	} else if (folio_pos(folio) + offset <= wr->pos &&
+	    wr->pos + wr->len <= folio_pos(folio) + offset + length) {
+		kfree(folio_detach_private(folio));
 		/* XXX is this right? only caller in fs */
-		cancel_dirty_page(page);
+		folio_cancel_dirty(folio);
 		return;
 	/* invalidate range chops off end of write range */
-	} else if (wr->pos < page_offset(page) + offset &&
-	    wr->pos + wr->len <= page_offset(page) + offset + length &&
-	     page_offset(page) + offset < wr->pos + wr->len) {
+	} else if (wr->pos < folio_pos(folio) + offset &&
+	    wr->pos + wr->len <= folio_pos(folio) + offset + length &&
+	     folio_pos(folio) + offset < wr->pos + wr->len) {
 		size_t x;
-		x = wr->pos + wr->len - (page_offset(page) + offset);
+		x = wr->pos + wr->len - (folio_pos(folio) + offset);
 		WARN_ON(x > wr->len);
 		wr->len -= x;
 		wr->uid = current_fsuid();
 		wr->gid = current_fsgid();
 	/* invalidate range chops off beginning of write range */
-	} else if (page_offset(page) + offset <= wr->pos &&
-	    page_offset(page) + offset + length < wr->pos + wr->len &&
-	    wr->pos < page_offset(page) + offset + length) {
+	} else if (folio_pos(folio) + offset <= wr->pos &&
+	    folio_pos(folio) + offset + length < wr->pos + wr->len &&
+	    wr->pos < folio_pos(folio) + offset + length) {
 		size_t x;
-		x = page_offset(page) + offset + length - wr->pos;
+		x = folio_pos(folio) + offset + length - wr->pos;
 		WARN_ON(x > wr->len);
 		wr->pos += x;
 		wr->len -= x;
 		wr->uid = current_fsuid();
 		wr->gid = current_fsgid();
 	/* invalidate range entirely within write range (punch hole) */
-	} else if (wr->pos < page_offset(page) + offset &&
-	    page_offset(page) + offset + length < wr->pos + wr->len) {
+	} else if (wr->pos < folio_pos(folio) + offset &&
+	    folio_pos(folio) + offset + length < wr->pos + wr->len) {
 		/* XXX what do we do here... should not WARN_ON */
 		WARN_ON(1);
 		/* punch hole */
@@ -467,11 +465,11 @@ static void orangefs_invalidatepage(struct page *page,
 	/* non-overlapping ranges */
 	} else {
 		/* WARN if they do overlap */
-		if (!((page_offset(page) + offset + length <= wr->pos) ^
-		    (wr->pos + wr->len <= page_offset(page) + offset))) {
+		if (!((folio_pos(folio) + offset + length <= wr->pos) ^
+		    (wr->pos + wr->len <= folio_pos(folio) + offset))) {
 			WARN_ON(1);
-			printk("invalidate range offset %llu length %u\n",
-			    page_offset(page) + offset, length);
+			printk("invalidate range offset %llu length %zu\n",
+			    folio_pos(folio) + offset, length);
 			printk("write range offset %llu length %zu\n",
 			    wr->pos, wr->len);
 		}
@@ -483,7 +481,7 @@ static void orangefs_invalidatepage(struct page *page,
 	 * Thus the following runs if wr was modified above.
 	 */
 
-	orangefs_launder_page(page);
+	orangefs_launder_page(&folio->page);
 }
 
 static int orangefs_releasepage(struct page *page, gfp_t foo)
@@ -636,7 +634,7 @@ static const struct address_space_operations orangefs_address_operations = {
 	.set_page_dirty = __set_page_dirty_nobuffers,
 	.write_begin = orangefs_write_begin,
 	.write_end = orangefs_write_end,
-	.invalidatepage = orangefs_invalidatepage,
+	.invalidate_folio = orangefs_invalidate_folio,
 	.releasepage = orangefs_releasepage,
 	.freepage = orangefs_freepage,
 	.launder_page = orangefs_launder_page,
-- 
2.34.1

