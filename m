Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725153624BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 17:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhDPP44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbhDPP4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:56:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B6C061574;
        Fri, 16 Apr 2021 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0elJsKfBr0LULfuIg7oQtlPnnvqGhJmcDzk9w2kOzoY=; b=aSXpNqkcQLeVYDKEpFoTqnJVgH
        WGXVjW/RjyhC6LMIIHI8xLO2fqYXAzI7xNGUkSkKl3Ztg0Fd9QFzWvc5TU8IWeqxobqYdOfRzvFh9
        FoYQSpx/v279Ah5FYiwfCI70nuQcbp1ml871nKqhXnOcv548gDMqy3OTXqvL+7fopzOaxa6kY42MY
        YilDboSJKiwUC6YGiezebdKOhAQGXq+zGxz3a0L7RSaLR5D3bdn1kC0l8tas7T9cx7ty8mF5GwIgU
        Lv0zQxGbAQaFH2JdEqcfX+RuQ3ZqsGiWfQCA1Ry+B3Ptn7emDBUSInT4i+TFY2wk5javu0vmiYde0
        5xt+M/AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXQoO-00A9P7-AQ; Fri, 16 Apr 2021 15:55:50 +0000
Date:   Fri, 16 Apr 2021 16:55:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 02/28] mm: Introduce struct folio
Message-ID: <20210416155516.GM2531743@casper.infradead.org>
References: <20210409185105.188284-1-willy@infradead.org>
 <20210409185105.188284-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409185105.188284-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:50:39PM +0100, Matthew Wilcox (Oracle) wrote:
> A struct folio is a new abstraction to replace the venerable struct page.
> A function which takes a struct folio argument declares that it will
> operate on the entire (possibly compound) page, not just PAGE_SIZE bytes.
> In return, the caller guarantees that the pointer it is passing does
> not point to a tail page.
> +++ b/include/linux/mm_types.h
[...]
> +static inline struct folio *page_folio(struct page *page)
> +{
> +	unsigned long head = READ_ONCE(page->compound_head);
> +
> +	if (unlikely(head & 1))
> +		return (struct folio *)(head - 1);
> +	return (struct folio *)page;
> +}

I'm looking at changing this for the next revision, and basing it on
my recent patch to make compound_head() const-preserving:

+#define page_folio(page)       _Generic((page),                        \
+       const struct page *:    (const struct folio *)_compound_head(page), \
+       struct page *:          (struct folio *)_compound_head(page))

I've also noticed an awkward pattern occurring that I think this makes
less awkward:

+/**
+ * folio_page - Return a page from a folio.
+ * @folio: The folio.
+ * @n: The page number to return.
+ *
+ * @n is relative to the start of the folio.  It should be between
+ * 0 and folio_nr_pages(@folio) - 1, but this is not checked for.
+ */
+#define folio_page(folio, n)   nth_page(&(folio)->page, n)

That lets me simplify folio_next():

+static inline struct folio *folio_next(struct folio *folio)
+{
+       return (struct folio *)folio_page(folio, folio_nr_pages(folio));
+}

(it occurs to me this should also be const-preserving, but it's not clear
that's needed yet)
