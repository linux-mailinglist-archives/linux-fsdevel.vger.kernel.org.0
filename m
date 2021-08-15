Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8223EC6E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 05:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhHODch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 23:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbhHODcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 23:32:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4086DC061764;
        Sat, 14 Aug 2021 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=myN/3ktl6FFXkebMKIg+oytfpFhkg7CNnOU5Il6HFzs=; b=m9c9/qWRcdjSRQ6g5Wh/GFTqBw
        ybJTWwwMKF4g5qPy3pOZjSzNxPMwGljYeaCc5M2l8cJfSXPIgjXmTQe+uVlCjpeHCRpKUXNIPBB1r
        NtbB8JCeOQBQQ1yrISnvDQQlWTdnQ9ksC+GQspSuQTEvpq+bb1Lw7kDXn30cXgTUEGxxtxyZTRNTc
        jWl9mlYIRdEY6DBk8vvQWuMAHRTRjrSu8SBMR2a9LN+QjAfHEfRMf+zoCbAcdNpHJGrqwK0HUfj6E
        6w4/jZQJ9/5Ecn71NDO4qfoz0uD1vyRPRcVuh1dBWdolAr6jw9r7WDVDWY7YWY2qjV/W+9t4g1utp
        258jXAGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mF6rU-00HN19-HY; Sun, 15 Aug 2021 03:31:11 +0000
Date:   Sun, 15 Aug 2021 04:31:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 071/138] mm/writeback: Add filemap_dirty_folio()
Message-ID: <YRiKdCEDHKZ4T0JY@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-72-willy@infradead.org>
 <e393b874-eb35-7b78-8919-838a8149d259@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e393b874-eb35-7b78-8919-838a8149d259@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 06:07:05PM +0200, Vlastimil Babka wrote:
> On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> > Reimplement __set_page_dirty_nobuffers() as a wrapper around
> > filemap_dirty_folio().
> 
> I assume it becomes obvious later why the new "mapping" parameter instead of
> taking it from the folio, but maybe the changelog should say it here?

---

mm/writeback: Add filemap_dirty_folio()

Reimplement __set_page_dirty_nobuffers() as a wrapper around
filemap_dirty_folio().  Eventually folio_mark_dirty() will pass
the folio's mapping to the address space's ->dirty_folio()
operation, so add the parameter to filemap_dirty_folio() now.

---

Nobody seems quite sure whether it's possible to truncate (or otherwise
remove) a page from a file while it's being marked as dirty.  viz:

int set_page_dirty(struct page *page)
{
        struct address_space *mapping = page_mapping(page);
        if (likely(mapping)) {
...
                return mapping->a_ops->set_page_dirty(page);
}

so ->set_page_dirty can only be called if page has a mapping (obviously,
otherwise we wouldn't know whose ->set_page_dirty to call).  But then
in __set_page_dirty_nobuffers(), we check to see if mapping has
become unset:

        if (!TestSetPageDirty(page)) {
                struct address_space *mapping = page_mapping(page);

                if (!mapping) {
                        unlock_page_memcg(page);
                        return 1;
                }

Confusingly, the comment to __set_page_dirty_nobuffers says:

 * The caller must ensure this doesn't race with truncation.  Most will simply
 * hold the page lock, but e.g. zap_pte_range() calls with the page mapped and
 * the pte lock held, which also locks out truncation.

I believe this is left-over from commit 2d6d7f982846 in 2015.

Anyway, passing mapping as a parameter is something we already do for
just about every other address_space operation, and we already called
page_mapping() to get it, so why make the callee call it again?  Not to
mention people get confused about whether to call page_mapping() or just
look at page->mapping.  Changing the ->set_page_dirty() operation to
->dirty_folio() is something I've postponed until the 5.17/5.18 timeframe,
but we might as well pass the parameter to filemap_dirty_folio() now.
