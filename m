Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40A83B6636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhF1P4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 11:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbhF1P4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:56:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD89C058B05;
        Mon, 28 Jun 2021 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7p3ZErU459kzXpwH69SdGsHIsa2wrWdtYOXOZ1fJP8c=; b=JhRzUPgcCrJIWJsK3FwDl0OlPC
        X+8ZgMfTejZ3tHRU44TZQdOdnLkKkTdmSZvTZ8K0oFpaMQFONI6TjeIjj+ZBbqZfz/ehfbrk9s88m
        +QFPdPYbMAqlrHAhxkgggEuA9q7JD87ntSum7R8qJ22YbMvQ46Rp3S5wrzRZNvjXLJmFBmrXIqNDD
        bExBPBzhsDVegpzJnTcncBgRMPniX/b5zSsCRqe4VG4lpBVH6AKs0CKHY/ARoyI3KuxVkTquY0J01
        WCmwt/ewf58/duMqTFgzOidkw0gjQMIiclqJzKDbCwBwK304VeCqX19HaGG9SLwvTjBvs64hDcDom
        Ve7nkdZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxtQ3-003BkT-Qc; Mon, 28 Jun 2021 15:43:41 +0000
Date:   Mon, 28 Jun 2021 16:43:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 27/46] mm/writeback: Add __folio_mark_dirty()
Message-ID: <YNnuI9bi5ycgoXfA@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-28-willy@infradead.org>
 <YNL+cHDPMfvvXMUh@infradead.org>
 <YNTQ6o0kxESisBri@casper.infradead.org>
 <YNlmLjhf+nZLKKRo@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNlmLjhf+nZLKKRo@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 07:03:26AM +0100, Christoph Hellwig wrote:
> On Thu, Jun 24, 2021 at 07:37:30PM +0100, Matthew Wilcox wrote:
> > On Wed, Jun 23, 2021 at 11:27:12AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jun 22, 2021 at 01:15:32PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > Turn __set_page_dirty() into a wrapper around __folio_mark_dirty() (which
> > > > can directly cast from page to folio because we know that set_page_dirty()
> > > > calls filesystems with the head page).  Convert account_page_dirtied()
> > > > into folio_account_dirtied() and account the number of pages in the folio.
> > > 
> > > Is it really worth micro-optimizing a transitional function like that?
> > > I'd rather eat the overhead of the compound_page() call over adding hacky
> > > casts like this.
> > 
> > Fair enough.  There's only three calls to it and one of them goes away
> > this series.
> 
> The other option would be a helper that asserts a page is not a tail
> page and then do the cast to document the assumptions.

btw, every call to folio_flags() checks !PageTail:

        struct page *page = &folio->page;

        VM_BUG_ON_PGFLAGS(PageTail(page), page);

now, that's not going to be turned on for regular builds, but it does
give us a _lot_ of runtime assertions that somebody hasn't cast a tail
page to a folio.
