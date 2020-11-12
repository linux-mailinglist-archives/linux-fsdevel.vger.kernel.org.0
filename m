Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18D2B1058
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgKLV1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgKLV0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:26:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF64C0613D1;
        Thu, 12 Nov 2020 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ah+jL08Aq18bIod4sv8CxA+v//JQ2UBcaOuSobFGpKI=; b=nVlL3wYePUt8Dxl8hv5Jy858mR
        KfnUJXQAbqmuNRSOc2Wn1AL/zijiJKxUK4dm9ehGYXWUcetiIjm4gTqS2HEzgKnCl/GKm4IgpH9fZ
        +qth5eo3uHiuKLv478z3B786bFIlbAuYz3Ti3LW9VSMVQVjfTLXNto0EoGyK44+Z6RMsSVfN6WKVA
        WR+2spWkhua55IIm/WPaNh9lRiepVEyh7G2MogS0TpDH0ZBIAz6Jgd17cnQ48PffXW5zan7NwFwxV
        IEn0Aen2RuIRXxq91fFNu15ExLsXws8sRBG+lqhZKSyF68oa3djk02RWqPmNDMXurkLWSMDWvHQYY
        i3tm/QKA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7B-0007GR-IN; Thu, 12 Nov 2020 21:26:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/16] mm/filemap: Rename find_get_entry to mapping_get_entry
Date:   Thu, 12 Nov 2020 21:26:30 +0000
Message-Id: <20201112212641.27837-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

find_get_entry doesn't "find" anything.  It returns the entry at
a particular index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 01603f021740..53073281f027 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1663,7 +1663,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 EXPORT_SYMBOL(page_cache_prev_miss);
 
 /*
- * find_get_entry - find and get a page cache entry
+ * mapping_get_entry - Get a page cache entry.
  * @mapping: the address_space to search
  * @index: The page cache index.
  *
@@ -1675,7 +1675,8 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  *
  * Return: The head page or shadow entry, %NULL if nothing is found.
  */
-static struct page *find_get_entry(struct address_space *mapping, pgoff_t index)
+static struct page *mapping_get_entry(struct address_space *mapping,
+		pgoff_t index)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct page *page;
@@ -1751,7 +1752,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	struct page *page;
 
 repeat:
-	page = find_get_entry(mapping, index);
+	page = mapping_get_entry(mapping, index);
 	if (xa_is_value(page)) {
 		if (fgp_flags & FGP_ENTRY)
 			return page;
-- 
2.28.0

