Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248F5483DE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 09:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiADIMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 03:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiADIMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:12:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F1C061761
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 00:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ZFNf44xEqkPioc2DQVEKQudWiDloTzRNMpXtQmnZ6k=; b=WqVEAn1UQ/q55As7DWBwh9m7Rl
        GoW6xb3gHKm1QtZoD5GRzwzhJ4oBDAODkV1sOJHTja/hXRkPmKelHBa4+zH95jPh4Akig1zpK7j+v
        3RM3r7pXkCWgInIVTYcU1WgLzaoWTpmFInATznL8SMjrlXH5DY1y2JCd8dMzx3wO+kGIl52lldGrY
        /PwASaeWNb3gN7MA6WYjfjA/Sase23YNcnnZqIKglQ3g2TqWM7oMnVcFyAFo9gWktuabVSFeMHDVO
        IML68gD5GXgQeM7NeJj0IkyBA9yN8yK9bk7hVodmJ7Yl+bc26uCzx240+K283oM2rCkmGlGB0qmo7
        60re6+zg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4evh-00DVFq-T3; Tue, 04 Jan 2022 08:12:25 +0000
Date:   Tue, 4 Jan 2022 08:12:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next 3/3] shmem: Fix "Unused swap" messages
Message-ID: <YdQBaYbQNC9laavZ@casper.infradead.org>
References: <49ae72d6-f5f-5cd-e480-e2212cb7af97@google.com>
 <YdMYCFIHA/wtcDVV@casper.infradead.org>
 <2da9d057-8111-5759-a0dc-d9dca9fb8c9f@google.com>
 <YdOlt5FJn9L+3sjM@casper.infradead.org>
 <2fb90c3-5285-56ca-65af-439c4527dbe4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb90c3-5285-56ca-65af-439c4527dbe4@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 03, 2022 at 08:43:13PM -0800, Hugh Dickins wrote:
> On Tue, 4 Jan 2022, Matthew Wilcox wrote:
> > So let me try again.  My concern was that we might be trying to store
> > a 2MB entry which had a non-NULL 'expected' entry which was found in a
> > 4k (ie single-index) slot within the 512 entries (as the first non-NULL
> > entry in that range), and we'd then store the 2MB entry into a
> > single-entry slot.
> 
> Thanks, that sounds much more like how I was imagining it.  And the
> two separate tests much more understandable than twice round a loop.
> 
> > Now, maybe that can't happen for higher-level reasons, and I don't need
> > to worry about it.  But I feel like we should check for that?  Anyway,
> > I think the right fix is this:
> 
> I don't object to (cheaply) excluding a possibility at the low level,
> even if there happen to be high level reasons why it cannot happen at
> present.
> 
> But I don't think your second xas_find_conflict() gives quite as much
> assurance as you're expecting of it.  Since xas_find_conflict() skips
> NULLs, the conflict test would pass if there were 511 NULLs and one
> 4k entry matching the expected entry, but a 2MB entry to be inserted
> (the "small and large folios" case in my earlier ramblings).
> 
> I think xas_find_conflict() is not really up to giving that assurance;
> and maybe better than a second call to xas_find_conflict(), might be
> a VM_BUG_ON earlier, to say that if 'expected' is non-NULL, then the
> range is PAGE_SIZE - or something more folio-friendly like that?
> That would give you the extra assurance you're looking for,
> wouldn't it?

I actually don't need that assurance.  The wretch who wrote the
documentation for xas_find_conflict() needs to be put on a diet of
bread and water, but the promise that it should make is that once it
returns NULL, the xa_state is restored to where it was before the first
call to xas_find_conflict().  So if you're trying to store a 2MB entry
and the only swap entry in the 2MB range is a 4KB entry, the xa_state
gets walked back up to point at the original 512-aligned entry and the
subsequent xas_store() will free the node containing the swap entry.

> For now and the known future, shmem only swaps PAGE_SIZE, out and in;
> maybe someone will want to change that one day, then xas_find_conflict()
> could be enhanced to know more of what's expected.

Good to know.

> > 
> > +++ b/mm/shmem.c
> > @@ -733,11 +733,12 @@ static int shmem_add_to_page_cache(struct page *page,
> >         cgroup_throttle_swaprate(page, gfp);
> > 
> >         do {
> > -               void *entry;
> >                 xas_lock_irq(&xas);
> > -               while ((entry = xas_find_conflict(&xas)) != NULL) {
> > -                       if (entry == expected)
> > -                               continue;
> > +               if (expected != xas_find_conflict(&xas)) {
> > +                       xas_set_err(&xas, -EEXIST);
> > +                       goto unlock;
> > +               }
> > +               if (expected && xas_find_conflict(&xas)) {
> >                         xas_set_err(&xas, -EEXIST);
> >                         goto unlock;
> >                 }
> 
> That also worried me because, if the second xas_find_conflict()
> is to make any sense, the first must have had a side-effect on xas:
> are those side-effects okay for the subsequent xas_store(&xas, page)?
> You'll know that they are, but it's not obvious to the reader.
> 
> > 
> > which says what I mean.  I certainly didn't intend to imply that I
> > was expecting to see 512 consecutive entries which were all identical,
> > which would be the idiomatic way to read the code that was there before.
> > I shouldn't've tried to be so concise.
> > 
> > (If you'd rather I write any of this differently, I'm more than happy
> > to change it)
> 
> No, I'm happy with the style of it, just discontented that the second
> xas_find_conflict() pretends to more than it provides (I think).
> 
> Hugh
