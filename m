Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73226A77C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 16:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgIOOrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgIOOqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:46:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0DBC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pvxPl3HMLtqp3Ita2+v6bCXfIBBom5wkdDBr6Wsn0mM=; b=O86Hezwah1ytOAHiGG0zpZyV/V
        4lrPgIO6SJtkHq6kmd7kNsR1fatlQXypVRK3HD4lo9IVVvMVzCSphDA9T1hLLFatXKxYOR4Nq8rJG
        pw1GlZHz4PaCyGPHyR/SmomFbpQ1OpsV9tXkgyNLj3GIMk2ydVvTFQ4nDpx9ehlQo9JLKfJpPcDNJ
        Vl8fzeT9612TG/jmPiTTTRzFrBb2U2eWEBfA9+4Rpf7gp6Z0MqpWUWU7um0SYV1+15AOpWPpl0WMI
        TJhCEyIPLdRqMgmYaZ8Ppn8UD90AcO6RchLFMfNjrAJpgCPO798999pO23K9mr67f/FD95XqYoYDy
        8CfrDWnA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kICDq-00076u-15; Tue, 15 Sep 2020 14:46:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bill O'Donnell <billodo@redhat.com>
Subject: [PATCH] fs: Support THPs in vfs_dedupe_file_range
Date:   Tue, 15 Sep 2020 15:46:16 +0100
Message-Id: <20200915144616.27288-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 5db58b8c78d0..c4d5eb47a21e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1906,6 +1906,8 @@ static struct page *vfs_dedupe_get_page(struct inode *inode, loff_t offset)
  */
 static void vfs_lock_two_pages(struct page *page1, struct page *page2)
 {
+	page1 = thp_head(page1);
+	page2 = thp_head(page2);
 	/* Always lock in order of increasing index. */
 	if (page1->index > page2->index)
 		swap(page1, page2);
@@ -1918,6 +1920,8 @@ static void vfs_lock_two_pages(struct page *page1, struct page *page2)
 /* Unlock two pages, being careful not to unlock the same page twice. */
 static void vfs_unlock_two_pages(struct page *page1, struct page *page2)
 {
+	page1 = thp_head(page1);
+	page2 = thp_head(page2);
 	unlock_page(page1);
 	if (page1 != page2)
 		unlock_page(page2);
@@ -1972,8 +1976,8 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
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

