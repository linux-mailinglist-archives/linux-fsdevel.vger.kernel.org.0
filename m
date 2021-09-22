Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080C0414E1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhIVQay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhIVQax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:30:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66BC061574;
        Wed, 22 Sep 2021 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/bg8mgxozFDsyBXWUCU4D/OveolCgwjbJqJNs7JQP/U=; b=fq8uuURZmuYEV+T6V8jh+sIKRT
        ZPzQVWXPFcxfKLNNntZnKahM60EK4OJCJX7/OIPx+S7y6wlL+0b4O9wI+JW6X3Jr513UYtFrsn+Fy
        R3VTvKuiy5tgk+kxvsN//YdoIv7wNdbl2PA+kny53pQWUVcgy7tNqtbWGgS6/PpZug+SsenI476B2
        Dua80cSWa5zukDcLCwIe7rWL+KCSoDtZUSR7RtrWwkEVx8XWSDjo4r3hg6Tdx4J+ssS6uiKH+++JT
        j79U87wYVCuKdYEVrNNE00xcHl2s1cz7cGFkmnc4fCx+B51ahjr5qElcjLn0CJ1jhfkSSM+Lw00VP
        jOC5Y8kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT54h-004wPq-HM; Wed, 22 Sep 2021 16:26:52 +0000
Date:   Wed, 22 Sep 2021 17:26:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YUtZL0e2eBIQpLPE@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YUtPvGm2RztJdSf1@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUtPvGm2RztJdSf1@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 11:46:04AM -0400, Kent Overstreet wrote:
> On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> > On Tue, Sep 21, 2021 at 05:22:54PM -0400, Kent Overstreet wrote:
> > >  - it's become apparent that there haven't been any real objections to the code
> > >    that was queued up for 5.15. There _are_ very real discussions and points of
> > >    contention still to be decided and resolved for the work beyond file backed
> > >    pages, but those discussions were what derailed the more modest, and more
> > >    badly needed, work that affects everyone in filesystem land
> > 
> > Unfortunately, I think this is a result of me wanting to discuss a way
> > forward rather than a way back.
> > 
> > To clarify: I do very much object to the code as currently queued up,
> > and not just to a vague future direction.
> > 
> > The patches add and convert a lot of complicated code to provision for
> > a future we do not agree on. The indirections it adds, and the hybrid
> > state it leaves the tree in, make it directly more difficult to work
> > with and understand the MM code base. Stuff that isn't needed for
> > exposing folios to the filesystems.
> > 
> > As Willy has repeatedly expressed a take-it-or-leave-it attitude in
> > response to my feedback, I'm not excited about merging this now and
> > potentially leaving quite a bit of cleanup work to others if the
> > downstream discussion don't go to his liking.

We're at a take-it-or-leave-it point for this pull request.  The time
for discussion was *MONTHS* ago.

> > Here is the roughly annotated pull request:
> 
> Thanks for breaking this out, Johannes.
> 
> So: mm/filemap.c and mm/page-writeback.c - I disagree about folios not really
> being needed there. Those files really belong more in fs/ than mm/, and the code
> in those files needs folios the most - especially filemap.c, a lot of those
> algorithms have to change from block based to extent based, making the analogy
> with filesystems.
> 
> I think it makes sense to drop the mm/lru stuff, as well as the mm/memcg,
> mm/migrate and mm/workingset and mm/swap stuff that you object to - that is, the
> code paths that are for both file + anonymous pages, unless Matthew has
> technical reasons why that would break the rest of the patch set.

Conceptually, it breaks the patch set.  Anywhere that we convert back
from a folio to a page, the guarantee of folios is weakened (and
possibly violated).  I don't think it makes sense from a practical point
of view either; it's re-adding compound_head() calls that just don't
need to be there.

> That discussion can still happen... and there's still the potential to get a lot
> more done if we're breaking open struct page and coming up with new types. I got
> Matthew on board with what you wanted, re: using the slab allocator for larger
> allocations

Wait, no, you didn't.  I think it's a terrible idea.  It's just completely
orthogonal to this patch set, so I don't want to talk about it.
