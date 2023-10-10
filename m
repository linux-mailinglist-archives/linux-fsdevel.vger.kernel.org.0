Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5EC7C0327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjJJSIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjJJSIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:08:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D83194
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ue9Ky4dslnBeYc2Bd+KE4/eZdEViH3G2390HRVXyM2k=; b=CpFr2Wzbk31eJjZxLkYJYJ3n6O
        I5daE4oBzdJr1DHtCQPeRb2cdePtT8wSbUJxgAxkkWvEuN+C0Ns1dTUjkt20uOngsXcOzWA7VbrFh
        dh5zW0xkIkzQLtfInEtVvQ7wrwEpXe2M3j1/gpJc04Y1Bl5infjNbFLzbPxZS5WT0r6IfZQ187ZzB
        MKIo7YqPT/QIyrl+5rYF477gTM3cgfzuVS8xhqksDB8g0ueLilFhmW18go0BKkclARDbGEd5kbR6H
        7SAoBzpySB86je1B8sJ981V/qWtDbydGLQ7d5501XjdyMMTwGbWJ+lciF3aeW+JV8SDgqY7wrNplz
        l1wQXrGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqH9T-0062Dc-Aa; Tue, 10 Oct 2023 18:08:15 +0000
Date:   Tue, 10 Oct 2023 19:08:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 08/39] mm/swap: Add folio_mark_accessed()
Message-ID: <ZSWTD1sgbM/LUKch@casper.infradead.org>
References: <20210715200030.899216-9-willy@infradead.org>
 <ZSLMFXrDFhzI5ieI@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSLMFXrDFhzI5ieI@memverge.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 08, 2023 at 11:34:45AM -0400, Gregory Price wrote:
> On Thu, 15 Jul 2021 20:59:59 +0100, Matthew Wilcox wrote
> > +void mark_page_accessed(struct page *page)
> > +{
> > +	folio_mark_accessed(page_folio(page));
> > +}
> > +EXPORT_SYMBOL(mark_page_accessed);
> ... snip ...
> >
> > @@ -430,36 +430,34 @@ static void __lru_cache_activate_page(struct page *page)
> >   * When a newly allocated page is not yet visible, so safe for non-atomic ops,
> >   * __SetPageReferenced(page) may be substituted for mark_page_accessed(page).
> >   */
> > -void mark_page_accessed(struct page *page)
> > +void folio_mark_accessed(struct folio *folio)
> >  {
> > -	page = compound_head(page);
> > -
> > -	if (!PageReferenced(page)) {
> > -		SetPageReferenced(page);
> > -	} else if (PageUnevictable(page)) {
> > +	if (!folio_test_referenced(folio)) {
> > +		folio_set_referenced(folio);
> > +	} else if (folio_test_unevictable(folio)) {
> 
> Hi Matthew,
> 
> My colleagues and I have been testing some page-tracking algorithms and
> we tried using the reference bit by using /proc/pid/clear_clears,
> /proc/pid/pagemap, and /proc/kpageflags.
> 
> I'm not 100% of the issue, but we're finding some inconsistencies when
> tracking page reference bits, and this seems to be at least one of the
> patches we saw that might be in the mix.
> 
> >From reading up on folios, it seems like this change prevents each
> individual page in a folio from being marked referenced, and instead
> prefers to simply mark the entire folio containing the page as accessed.
> 
> When looking at the proc/ interface, it seems like it is still
> referencing the page and not using the folio for a page (see below).
> 
> Our current suspicion is that since only the folio head gets marked
> referenced, any pages inside the folio that aren't the head will
> basically never be marked referenced, leading to an inconsistent view.
> 
> I'm curious your thoughts on whether (or neither):
> 
> a) Should we update kpageflags_read to use page_folio() and get the
>    folio flags for the head page
> 
> or
> 
> b) the above change to mark_page_accessed() should mark both the
>    individual page flags to accessed as well as the folio head accessed.

Hi Greg, thanks for reaching out.

The referenced bit has been tracked on what is now known as a per-folio
basis since commit 8cb38fabb6bc in 2016.  That is, if you tried to
SetPageReferenced / ClearPageReferenced / test PageReferenced on a tail
page, it would redirect to the head page in order to set/clear/test
the bit in the head page's flags field.

That's not to say that all the code which sets/checks/tests this
really understands that!  We've definitely found bugs during the folio
work where code has mistakenly assumed that operations on a tail
page actually affect that page rather than the whole allocation.

There's also code which is now being exposed to compound pages for the
first time, and is not holding up well.

I hope that's helpful in finding the bug you're chasing.

> Thanks for your time.
> Gregory Price
> 
> 
> (relevant fs/proc/page.c code:)
> 
> 
> static ssize_t kpageflags_read(struct file *file, char __user *buf,
>                              size_t count, loff_t *ppos)
> {
> ... snip ...
>                 ppage = pfn_to_online_page(pfn);
> 
>                 if (put_user(stable_page_flags(ppage), out)) {
>                         ret = -EFAULT;
>                         break;
>                 }
> ... snip ...
> }
> 
> 
> u64 stable_page_flags(struct page *page)
> {
> ... snip ...
>         k = page->flags;
> ... snip ...
> }
