Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5512405FB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 00:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhIIWum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhIIWum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 18:50:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157AAC061574;
        Thu,  9 Sep 2021 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jwMx+Bdxcf4JuJYm9ph1dk1Qb2BQqM8i1EKgHVKfk0k=; b=cneqA+m0sw9ZoLdnmiIdv6GQDu
        pSH5gwmbpIffEtYXVV/MuuL5soL09Hgjtuu89rznwMFmAs7eXCwxCT74gQ9KpzmQQgJaka5CG5RVZ
        rfuvsocxxlGl0Znc86t9V4OUvWSnJzIN4GKcIZsPEJ0L3jYLxWG23ehVmOdF9e5Y0AjJbKCBU21t2
        ymbEu2Csp8iG50m+VV6ZPb/t3Q9bcJ/DUubcRFOVS9cqKDg/Z6mpbxozZLZm9bBFK3Jaqpah384xB
        eynMk9uFExGV70vbfdm/kqYhkTIeMXpLghjDg34uWUoOhUAs9sHyrfaV7IcR7omnHNYaji8rKi5li
        vpPcaKEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOSqD-00ARd4-Rk; Thu, 09 Sep 2021 22:48:29 +0000
Date:   Thu, 9 Sep 2021 23:48:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YTqPNXNMms1OLSXh@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YToBjZPEVN9Jmp38@infradead.org>
 <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
 <YTpPh2aaQMyHAi8m@cmpxchg.org>
 <YTpWBif8DCV5ovON@casper.infradead.org>
 <YTqEpTIbwRJmwCwL@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTqEpTIbwRJmwCwL@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Ugh.  I'm not dealing with this shit.  I'm supposed to be on holiday.
I've been checking in to see what needs to happen for folios to be
merged.  But now I'm just fucking done.  I shan't be checking my email
until September 19th.

Merge the folio branch, merge the pageset branch, or don't merge
anything.  I don't fucking care any more.

On Thu, Sep 09, 2021 at 06:03:17PM -0400, Johannes Weiner wrote:
> On Thu, Sep 09, 2021 at 07:44:22PM +0100, Matthew Wilcox wrote:
> > On Thu, Sep 09, 2021 at 02:16:39PM -0400, Johannes Weiner wrote:
> > > My objection is simply to one shared abstraction for both. There is
> > > ample evidence from years of hands-on production experience that
> > > compound pages aren't the way toward scalable and maintainable larger
> > > page sizes from the MM side. And it's anything but obvious or
> > > self-evident that just because struct page worked for both roles that
> > > the same is true for compound pages.
> > 
> > I object to this requirement.  The folio work has been going on for almost
> > a year now, and you come in AT THE END OF THE MERGE WINDOW to ask for it
> > to do something entirely different from what it's supposed to be doing.
> > If you'd asked for this six months ago -- maybe.  But now is completely
> > unreasonable.
> 
> I asked for exactly this exactly six months ago.
> 
> On March 22nd, I wrote this re: the filesystem interfacing:
> 
> : So I think transitioning away from ye olde page is a great idea. I
> : wonder this: have we mapped out the near future of the VM enough to
> : say that the folio is the right abstraction?
> :
> : What does 'folio' mean when it corresponds to either a single page or
> : some slab-type object with no dedicated page?
> :
> : If we go through with all the churn now anyway, IMO it makes at least
> : sense to ditch all association and conceptual proximity to the
> : hardware page or collections thereof. Simply say it's some length of
> : memory, and keep thing-to-page translations out of the public API from
> : the start. I mean, is there a good reason to keep this baggage?
> 
> It's not my fault you consistently dismissed and pushed past this
> question and then send a pull request anyway.
> 
> > I don't think it's a good thing to try to do.  I think that your "let's
> > use slab for this" idea is bonkers and doesn't work.
> 
> Based on what exactly?
> 
> You can't think it's that bonkers when you push for replicating
> slab-like grouping in the page allocator.
> 
> Anyway, it was never about how larger pages will pan out in MM. It was
> about keeping some flexibility around the backing memory for cache
> entries, given that this is still an unsolved problem. This is not a
> crazy or unreasonable request, it's the prudent thing to do given the
> amount of open-ended churn and disruptiveness of your patches.
> 
> It seems you're not interested in engaging in this argument. You
> prefer to go off on tangents and speculations about how the page
> allocator will work in the future, with seemingly little production
> experience about what does and doesn't work in real life; and at the
> same time dismiss the experience of people that deal with MM problems
> hands-on on millions of machines & thousands of workloads every day.
> 
> > And I really object to you getting in the way of my patchset which
> > has actual real-world performance advantages
> 
> So? You've gotten in the way of patches that removed unnecessary
> compound_head() call and would have immediately provided some of these
> same advantages without hurting anybody - because the folio will
> eventually solve them all anyway.
> 
> We all balance immediate payoff against what we think will be the
> right thing longer term.
> 
> Anyway, if you think I'm bonkers, just ignore me. If not, maybe lay
> off the rhetorics, engage in a good-faith discussion and actually
> address my feedback?
