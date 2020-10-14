Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317DA28DD04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgJNJVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730978AbgJNJUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F2C0F26E7;
        Tue, 13 Oct 2020 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=j56S9O9WrvJwFfp3jWhAG41igcUKnP5ChYtNlOLmqVw=; b=h2D+PCR8Gha6OcbuOB2GBMzhS0
        gRUjdmkK723DckDKVFPqjMcduPz3oe6xBGPe5GSehH75/txbO92mgjSmEse+8HPoa2Yq379BRn+hZ
        pTGxv+R0ZsvJe6iqLMcrvzPfj30EaZi7NAk9yJqHDDHsJW2C1HFyOFN5z4lXPAdxU+et8/LLMvC6b
        /Mcy8Ya+xrko0fZggbRRzFLko98VDFJ5rvW3WBoyCPnCBSLvGbxKNWi6UOaopBgHMIYUCwZPjFE/E
        OTp/mwMIFyH6YptVXd+l1UgFZZeH/fgsHWihD/tk74FyBPkxdDeHXUbstUHmpZ28aisEklqjgGMLy
        4oG3MciA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX55-0005i3-Ff; Wed, 14 Oct 2020 03:03:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 01/14] fs: Support THPs in vfs_dedupe_file_range
Date:   Wed, 14 Oct 2020 04:03:44 +0100
Message-Id: <20201014030357.21898-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201014030357.21898-1-willy@infradead.org>
References: <20201014030357.21898-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We may get tail pages returned from vfs_dedupe_get_page().  If we do,
we have to call page_mapping() instead of dereferencing page->mapping
directly.  We may also deadlock trying to lock the page twice if they're
subpages of the same THP, so compare the head pages instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/read_write.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 19f5c4bf75aa..ead675fef582 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1604,6 +1604,8 @@ static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
  */
 static void vfs_lock_two_pages(struct page *page1, struct page *page2)
 {
+	page1 = thp_head(page1);
+	page2 = thp_head(page2);
 	/* Always lock in order of increasing index. */
 	if (page1->index > page2->index)
 		swap(page1, page2);
@@ -1616,6 +1618,8 @@ static void vfs_lock_two_pages(struct page *page1, struct page *page2)
 /* Unlock two pages, being careful not to unlock the same page twice. */
 static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
 {
+	page1 = thp_head(page1);
+	page2 = thp_head(page2);
 	unlock_page(page1);
 	if (page1 != page2)
 		unlock_page(page2);
@@ -1670,8 +1674,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		 * someone is invalidating pages on us and we lose.
 		 */
 		if (!PageUptodate(src_page) || !PageUptodate(dest_page) ||
-		    src_page->mapping != src->i_mapping ||
-		    dest_page->mapping != dest->i_mapping) {
+		    page_mapping(src_page) != src->i_mapping ||
+		    page_mapping(dest_page) != dest->i_mapping) {
 			same = false;
 			goto unlock;
 		}
-- 
2.28.0

