Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559FE1E7321
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbgE2C77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407351AbgE2C6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9FEC00863C;
        Thu, 28 May 2020 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sjbbGWMjSgWHZyHkjp/1VVoOVZ08G0XZnmhgrYW2VkE=; b=uHMycAXQ1DKV6JZYGX+3LHfGUx
        hk/1DLnzYmHc0EgCaK+oN8EaKfZIheI+wwBtpxgB5G82PNFd81Zli41Bupjw36HJkQaNMz2hHyy3F
        tf6BQSo9Zugq2DCYPYwyW1cMXnqEkphahlKpl7WoZmK7F+mFtBe0WS6loLGyM5zNlrqPlWdOu4tJX
        EEBSt8Bed6cyzO16uXqRvR4VWd0cxvIa9Rsp+4G3Y/vF1KzXdmwWbxmfpVB+3V1WRkHbIVYeqCMpk
        5SVtLTNtFGa2G7R52XqXgyrj8PEr8XbOmChO+x/MPeXbLMSZTM/fNEQgh7PLbn+ZXEEf0ddLkd4Ww
        OiZpeUKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE4-0008Tw-0j; Fri, 29 May 2020 02:58:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 37/39] mm: Allow PageReadahead to be set on head pages
Date:   Thu, 28 May 2020 19:58:22 -0700
Message-Id: <20200529025824.32296-38-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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
index 56eb086acef8..7d38eb9c2229 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2067,9 +2067,9 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			if (unlikely(page == NULL))
 				goto no_cached_page;
 		}
-		if (PageReadahead(page)) {
+		if (PageReadahead(compound_head(page))) {
 			page_cache_async_readahead(mapping,
-					ra, filp, page,
+					ra, filp, compound_head(page),
 					index, last_index - index);
 		}
 		if (!PageUptodate(page)) {
@@ -2454,10 +2454,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 		return fpin;
 	if (ra->mmap_miss > 0)
 		ra->mmap_miss--;
-	if (PageReadahead(page)) {
+	if (PageReadahead(compound_head(page))) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_readahead(mapping, ra, file,
-					   page, offset, ra->ra_pages);
+				compound_head(page), offset, ra->ra_pages);
 	}
 	return fpin;
 }
@@ -2640,11 +2640,11 @@ void filemap_map_pages(struct vm_fault *vmf,
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

