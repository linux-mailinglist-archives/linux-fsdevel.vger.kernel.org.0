Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0621F5CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgFJUQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgFJUNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69677C00862F;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ugHC/UWmtHSn08iaOdB7fIiqwpchGhJFCvJwrf5/iGA=; b=tXkviFNu+Ol6AvIwDGb5N/BYqR
        L3m7YF30nlbbilanZVQIxQL3uS7W7tJ2Q6Q+VyoYnn4XWazp6KLwgwx/1zqEA67tMOi1ADizS6rJD
        l1jYAbsLPda4V48o/1J1XPeGDJDCOSYU78zkUudhBlIvknxNpDvBlxVhSR8bOuBYQ2L96A85SG1+0
        dSn6PpzrCu1rlIkwOFWeUVrfe/IOCkaIZyGnChgSM1BBxcvEAZb6MK+0Rqi7CItepKhmhVJI+ZFnd
        WuJ8eb95wBSyAD/7B1IK0kXQiPO/HDGv/kPjsNooACZ8DrlYWq5seVxIf/ts5ArNm53muftkM0iYd
        hom2gr1w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003Vc-8x; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 26/51] iomap: Convert iomap_write_end types
Date:   Wed, 10 Jun 2020 13:13:20 -0700
Message-Id: <20200610201345.13273-27-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

iomap_write_end cannot return an error, so switch it to return
size_t instead of int and remove the error checking from the callers.
Also convert the arguments to size_t from unsigned int, in case anyone
ever wants to support a page size larger than 2GB.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 555ec90e8b54..fffdf5906e99 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -692,9 +692,8 @@ iomap_set_page_dirty(struct page *page)
 }
 EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
 
-static int
-__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
-		unsigned copied, struct page *page)
+static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+		size_t copied, struct page *page)
 {
 	flush_dcache_page(page);
 
@@ -716,9 +715,8 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	return copied;
 }
 
-static int
-iomap_write_end_inline(struct inode *inode, struct page *page,
-		struct iomap *iomap, loff_t pos, unsigned copied)
+static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
+		struct iomap *iomap, loff_t pos, size_t copied)
 {
 	void *addr;
 
@@ -733,13 +731,14 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 	return copied;
 }
 
-static int
-iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
-		struct page *page, struct iomap *iomap, struct iomap *srcmap)
+/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
+static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
+		size_t copied, struct page *page, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
 	loff_t old_size = inode->i_size;
-	int ret;
+	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
 		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
@@ -820,11 +819,8 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		flush_dcache_page(page);
 
-		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
+		copied = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
-		if (unlikely(status < 0))
-			break;
-		copied = status;
 
 		cond_resched();
 
@@ -898,11 +894,8 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
 				srcmap);
-		if (unlikely(status <= 0)) {
-			if (WARN_ON_ONCE(status == 0))
-				return -EIO;
-			return status;
-		}
+		if (WARN_ON_ONCE(status == 0))
+			return -EIO;
 
 		cond_resched();
 
-- 
2.26.2

