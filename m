Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855641D4ED3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEONRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgEONRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAAAC05BD0E;
        Fri, 15 May 2020 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TfKJJimoKlvRsCM0paiVClt+UpHKBMIygN+uHMldA9w=; b=nrbQmsnyDrNzpDeCvgGAQ6d9Zr
        N7w9Tc/yqPDrXRlMvfBajD4Gf8y0bJljDa9818uaX/Bfih9si5rm/N2jnX9m0RIg8Me5l1905nTlB
        HJOm/DJ5lNs9+gounmGcw4AhzzTOsOTgeYlqZF7mevzEtzkc7Ae/QL4qU5M4pu8v/v7v49VKAGuMe
        dK/fOlcjhomGUZS1iKLmJS+qQtvT8QUdvBt+G5YMFqrjb35E8D+d20E28FcVp8cFncxjbIgG46dKS
        ZqfTX0DaTO8eG8lB/T818szUf6+sV68HnMvEp5gEnkRCtbgSTdRox+VqpZsQBPwdUCLGXexUM25ir
        mN/MKKvw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005pi-Ts; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 34/36] mm: Allow PageReadahead to be set on head pages
Date:   Fri, 15 May 2020 06:16:54 -0700
Message-Id: <20200515131656.12890-35-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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
 mm/filemap.c               | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

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
index 56eb086acef8..f3f03705c025 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2067,7 +2067,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			if (unlikely(page == NULL))
 				goto no_cached_page;
 		}
-		if (PageReadahead(page)) {
+		if (PageReadahead(compound_head(page))) {
 			page_cache_async_readahead(mapping,
 					ra, filp, page,
 					index, last_index - index);
@@ -2454,7 +2454,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 		return fpin;
 	if (ra->mmap_miss > 0)
 		ra->mmap_miss--;
-	if (PageReadahead(page)) {
+	if (PageReadahead(compound_head(page))) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_async_readahead(mapping, ra, file,
 					   page, offset, ra->ra_pages);
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

