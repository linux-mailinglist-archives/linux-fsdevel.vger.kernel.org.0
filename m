Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108E84150CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 21:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbhIVT6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 15:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIVT6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:58:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0016EC061574;
        Wed, 22 Sep 2021 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=UFM1KH+zbmE6JPHyyEk8OWK9O00VbDZsAf/P5r/PwVA=; b=sjUW1wCfS/qcUgj52Pj6I8ML4e
        nti+AqFV5uc4gcg3ZIS4UomxPfwQLkYv6gUZJPsprODAOa9sj/DfTZeZjGuhUx4t9sms/ZlLGNJ/U
        hf/SIOlOYcbUbZnco1mlRwaYp1ZOrEK5NmzkmLbjCVv1h0tyOkYal1v62Kiq0EqYofRyy7ASSxEw2
        GcOvnOyN1vtscgV9r0xs0bVOU5mbl7Ciu1cK0/Jhi/Bu9k2F6YVVbeExrJifv0piQDzM8YOa4Cdx8
        uDW+cz7MB4O0dcAVmzfmX9+bTjNq95nlnrG6ilIOfy6MZ2/Dnl4ANCe3aXZBw09fNXfkOaxNFq1DJ
        RMx+KGJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT8Jn-0055RS-4s; Wed, 22 Sep 2021 19:54:31 +0000
Date:   Wed, 22 Sep 2021 20:54:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YUuJ4xHxG9dQadda@casper.infradead.org>
References: <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YUtPvGm2RztJdSf1@moria.home.lan>
 <YUtZL0e2eBIQpLPE@casper.infradead.org>
 <A8B68BA5-E90E-4AFF-A14A-211BBC4CDECE@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A8B68BA5-E90E-4AFF-A14A-211BBC4CDECE@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 04:56:16PM +0000, Chris Mason wrote:
> 
> > On Sep 22, 2021, at 12:26 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Wed, Sep 22, 2021 at 11:46:04AM -0400, Kent Overstreet wrote:
> >> On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> >>> On Tue, Sep 21, 2021 at 05:22:54PM -0400, Kent Overstreet wrote:
> >>>> - it's become apparent that there haven't been any real objections to the code
> >>>>   that was queued up for 5.15. There _are_ very real discussions and points of
> >>>>   contention still to be decided and resolved for the work beyond file backed
> >>>>   pages, but those discussions were what derailed the more modest, and more
> >>>>   badly needed, work that affects everyone in filesystem land
> >>> 
> >>> Unfortunately, I think this is a result of me wanting to discuss a way
> >>> forward rather than a way back.
> >>> 
> >>> To clarify: I do very much object to the code as currently queued up,
> >>> and not just to a vague future direction.
> >>> 
> >>> The patches add and convert a lot of complicated code to provision for
> >>> a future we do not agree on. The indirections it adds, and the hybrid
> >>> state it leaves the tree in, make it directly more difficult to work
> >>> with and understand the MM code base. Stuff that isn't needed for
> >>> exposing folios to the filesystems.
> >>> 
> >>> As Willy has repeatedly expressed a take-it-or-leave-it attitude in
> >>> response to my feedback, I'm not excited about merging this now and
> >>> potentially leaving quite a bit of cleanup work to others if the
> >>> downstream discussion don't go to his liking.
> > 
> > We're at a take-it-or-leave-it point for this pull request.  The time
> > for discussion was *MONTHS* ago.
> > 
> 
> I’ll admit I’m not impartial, but my fundamental goal is moving the patches forward.  Given folios will need long term maintenance, engagement, and iteration throughout mm/, take-it-or-leave-it pulls seem like a recipe for future conflict, and more importantly, bugs.
> 
> I’d much rather work it out now.

That's the nature of a pull request.  It's binary -- either it's pulled or
it's rejected.  Well, except that Linus has opted for silence, leaving
me in limbo.  I have no idea what he's thinking.  I don't know if he
agrees with Johannes.  I don't know what needs to change for Linus to
like this series enough to pull it (either now or in the 5.16 merge
window).  And that makes me frustrated.  This is over a year of work
from me and others, and it's being held up over concerns which seem to
me to be entirely insubstantial (the name "folio"?  really?  and even
my change to use "pageset" was met with silence from Linus.)

I agree with Kent & Johannes that struct page is a mess.  I agree that
cleaning it up will bring many benefits.  I've even started a design
document here:

https://kernelnewbies.org/MemoryTypes

I do see some advantages to splitting out anon memory descriptors from
file memory descriptors, but there is also plenty of code which handles
both types in the same way.  I see the requests to continue to use
struct page to mean a "memory descriptor which is either anon or file",
but I really think that's the wrong approach.  A struct page should
represent /a page/ of memory.  Otherwise we're just confusing people.
I know it's a confusion we've had since compound pages were introduced,
what, 25+ years ago, but that expediency has overstayed its welcome.

The continued silence from Linus is really driving me to despair.
I'm sorry I've been so curt with some of the requests.  I really am
willing to change things; I wasn't planning on doing anything with slab
until Kent prodded me to do it.  But equally, I strongly believe that
everything I've done here is a step towards the things that everybody
wants, and I'm frustrated that it's being perceived as a step away,
or even to the side of what people want.

So ... if any of you have Linus' ear.  Maybe you're at a conference with
him later this week.  Please, just get him to tell me what I need to do
to make him happy with this patchset.
