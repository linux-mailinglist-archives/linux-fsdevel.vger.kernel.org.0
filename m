Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC451F5C83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgFJUOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbgFJUNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD01C0085C6;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2hV4r5m+TkSlkdyqQBMdETJhjIoOoHgfZkbofMON82Y=; b=Ls7VeNeXB1UfVNMNYLfV2oi1dO
        T91HRkOKlYRXqP9eRJ1Eiz1pGfQSUAGume/MeHGML1a1tNdUCrBeWIt430Gw7vWFyOeTvg/y1BkEe
        2iCIPcIeuwjLlYAo4hAc+u4Vmf18qTQKrZBkFkHT+2pWWp2tU+JZ26wh8m7dQJZHzOor6klOEldC+
        XEGnpxT4gwO+XkJ7ITi1Uj9ym/NmAsKDq8t70DSz0M5Xth9HqUbiBl2j8SLgI7eEckUW0KP1XWj/J
        uQeOL2JIIxPCDH9V3lEwS5S0s6HbHOWdpO5khzTEj11V9jxKR1xpfo7AqsAeO+VwvHz5KYXxUYM9f
        g0ROXf+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003YM-9t; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 49/51] mm: Allow PageReadahead to be set on head pages
Date:   Wed, 10 Jun 2020 13:13:43 -0700
Message-Id: <20200610201345.13273-50-willy@infradead.org>
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

Adjust the callers to only call PageReadahead on the head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  4 ++--
 mm/filemap.c               | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 979460df4768..a3110d675cd0 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -377,8 +377,8 @@ PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 	TESTCLEARFLAG(Reclaim, reclaim, PF_NO_TAIL)
-PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
-	TESTCLEARFLAG(Readahead, reclaim, PF_NO_COMPOUND)
+PAGEFLAG(Readahead, reclaim, PF_ONLY_HEAD)
+	TESTCLEARFLAG(Readahead, reclaim, PF_ONLY_HEAD)
 
 #ifdef CONFIG_HIGHMEM
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 869b970fe1ab..7a746b486237 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2064,9 +2064,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			if (unlikely(page == NULL))
 				goto no_cached_page;
 		}
-		if (PageReadahead(page)) {
+		if (PageReadahead(thp_head(page))) {
 			page_cache_async_readahead(mapping,
-					ra, filp, page,
+					ra, filp, thp_head(page),
 					index, last_index - index);
 		}
 		if (!PageUptodate(page)) {
@@ -2452,10 +2452,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 		return fpin;
 	if (ra->mmap_miss > 0)
 		ra->mmap_miss--;
-	if (PageReadahead(page)) {
+	if (PageReadahead(thp_head(page))) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_readahead(mapping, ra, file,
-					   page, offset, ra->ra_pages);
+				thp_head(page), offset, ra->ra_pages);
 	}
 	return fpin;
 }
@@ -2637,11 +2637,11 @@ void filemap_map_pages(struct vm_fault *vmf,
 		/* Has the page moved or been split? */
 		if (unlikely(page != xas_reload(&xas)))
 			goto skip;
+		if (PageReadahead(page))
+			goto skip;
 		page = find_subpage(page, xas.xa_index);
 
-		if (!PageUptodate(page) ||
-				PageReadahead(page) ||
-				PageHWPoison(page))
+		if (!PageUptodate(page) || PageHWPoison(page))
 			goto skip;
 		if (!trylock_page(page))
 			goto skip;
-- 
2.26.2

