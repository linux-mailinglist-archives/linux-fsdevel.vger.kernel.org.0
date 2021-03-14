Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFBC33A287
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Mar 2021 04:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhCNDra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 22:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNDqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 22:46:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B57EC061574;
        Sat, 13 Mar 2021 19:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rsh6jCNFDW62I46pymon/qQ3m83IP2jm4c/2Qh506rs=; b=KmPxVklJYMrBB0vCYJXilTkDtV
        a+8sElABo0UZnLxw6I1Kz7l/E8kOCU7LX15DWTf/TOP+Xy0nC2462yTFL+/cn5W+KxWICSbDtCqEE
        mnSlMEhO7qS0/eE97ssacZHU7WwxXbRbs6wNxrHVrDgJEquTZx5DbPsTwWpP+rNdUzN5xCtbFi9Pe
        3Qgnzis2mrRteFdCH4Pr73QajUBHMg8l4QbdeXkPaMDGFdOJuYmTeUVAXqh4odKrEJkyDvwPZe2/6
        AsQbFkFzUA4sMCgqWXP3fawCLmNgwQlg3GJj6dnMMI6yXPaGM1Q6VtX0qDGogeGOaiCjP2uDQ9h0u
        wcqzBkDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLHhQ-00FVAh-Kx; Sun, 14 Mar 2021 03:46:03 +0000
Date:   Sun, 14 Mar 2021 03:45:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 09/25] mm: Add folio_index, folio_page and
 folio_contains
Message-ID: <20210314034552.GN2577561@casper.infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-10-willy@infradead.org>
 <20210313123716.a4f9403e9f6ebbd719dac2a8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313123716.a4f9403e9f6ebbd719dac2a8@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 13, 2021 at 12:37:16PM -0800, Andrew Morton wrote:
> On Fri,  5 Mar 2021 04:18:45 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > folio_index() is the equivalent of page_index() for folios.  folio_page()
> > finds the page in a folio for a page cache index.  folio_contains()
> > tells you whether a folio contains a particular page cache index.
> > 
> 
> copy-paste changelog into each function's covering comment?

Certainly.

> > +static inline struct page *folio_page(struct folio *folio, pgoff_t index)
> > +{
> > +	index -= folio_index(folio);
> > +	VM_BUG_ON_FOLIO(index >= folio_nr_pages(folio), folio);
> > +	return &folio->page + index;
> > +}
> 
> One would expect folio_page() to be the reverse of page_folio(), only
> it isn't anything like that.

It is ... but only for files.  So maybe folio_file_page()?

