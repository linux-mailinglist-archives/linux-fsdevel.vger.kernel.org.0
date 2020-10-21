Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564BC29464E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 03:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439839AbgJUB0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 21:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411127AbgJUB0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 21:26:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F12C0613CE
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 18:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8+DsgjTXhuE0aBWL3ircZHfQncOPhdktt3A/RofKQJ4=; b=N/cyk/PKBEJ9YDV5WS8J3O6nJS
        5T+zWf+JGQDwsxnLlnFWPHjZ71IKi6ZelvLj4UDtJDlXb0VJUZt4f3SyGsZFwQhpf3TNFu1t78uj8
        UiJvsIuCg41UtWd1k8en3RizGjmUeep6Vs+K4VcRYucmoz+vmHBhXtxOE6mf1DiORy3NdQRxPGqLW
        e3HjnV4GTIk0GaK6Ph+Rdfs66Uzcm2zzb3ZaaGxf3l4BJDWyN40iQ5tOYvFqVcJK+nQJw3ok2LIrG
        p9n3nZ4C4by3QPABG+1UZK3waQKeGYA7wbXAj8CJy2BsV/ySmAACEPi4LvAgNt87kmqXFyesfX/jq
        m5hlYwxA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kV2ta-00045B-LD; Wed, 21 Oct 2020 01:26:30 +0000
Date:   Wed, 21 Oct 2020 02:26:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: [RFC] find_get_heads_contig
Message-ID: <20201021012630.GG20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I was going to convert find_get_pages_contig() to only return head pages,
but I want to change the API to take a pagevec like the other find_*
functions have or will have.  And it'd be nice if the name of the function
reminded callers that it only returns head pages.  So comments on this?

diff --git a/mm/filemap.c b/mm/filemap.c
index 31ba06409dfa..b7dd2523fe79 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2093,6 +2093,58 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 }
 EXPORT_SYMBOL(find_get_pages_contig);
 
+/**
+ * find_get_heads_contig - Return head pages for a contiguous byte range.
+ * @mapping: The address_space to search.
+ * @start: The starting page index.
+ * @end: The final page index (inclusive).
+ * @pvec: Where the resulting pages are placed.
+ *
+ * find_get_heads_contig() will return a batch of head pages from
+ * @mapping.  Pages are returned with an incremented refcount.  Only the
+ * head page of a THP is returned.  In contrast to find_get_entries(),
+ * pages which are partially outside the range are returned.  The head
+ * pages have ascending indices.  The indices may not be consecutive,
+ * but the bytes represented by the pages are contiguous.  If there is
+ * no page at @start, no pages will be returned.
+ *
+ * Return: The number of pages which were found.
+ */
+unsigned find_get_heads_contig(struct address_space *mapping, pgoff_t start,
+		pgoff_t end, struct pagevec *pvec)
+{
+	XA_STATE(xas, &mapping->i_pages, start);
+	struct page *page;
+
+	rcu_read_lock();
+	for (page = xas_load(&xas); page; page = xas_next(&xas)) {
+		if (xas.xa_index > end)
+			break;
+		if (xas_retry(&xas, page) || xa_is_sibling(page))
+			continue;
+		if (xa_is_value(page))
+			break;
+
+		if (!page_cache_get_speculative(page))
+			goto retry;
+
+		/* Has the page moved or been split? */
+		if (unlikely(page != xas_reload(&xas)))
+			goto put_page;
+
+		if (!pagevec_add(pvec, page))
+			break;
+		continue;
+put_page:
+		put_page(page);
+retry:
+		xas_reset(&xas);
+	}
+	rcu_read_unlock();
+	return pagevec_count(pvec);
+}
+EXPORT_SYMBOL(find_get_heads_contig);
+
 /**
  * find_get_pages_range_tag - Find and return head pages matching @tag.
  * @mapping:	the address_space to search
