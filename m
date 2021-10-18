Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE043265A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhJRSbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 14:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRSbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:31:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EECC06161C;
        Mon, 18 Oct 2021 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VnNwRJtiXe14wnbKtzHf3of5QNSFxh+kQaEm/VsmJj8=; b=QTNXq4KklhG9HJMZpTZUmgjm0f
        7bRWPoml17tvYl+TPaHvo3ofF1xg/onLNsrQGOwt1jMMALDSdGqXMxspDSGj777jrIsZO4c12ybo/
        U3xSqmNXBL16yYzdjQD+sYd6mU72Tc4Ew27Mpn5b4/fELfTv9CQ0t6r6IG8mtpI9ocmQwJOHl+cXT
        m/Mh7f7iNb4NIozCMol6Mij2SXg1ya82M387ykrLQ4zhHOq29w8+cQro0pnmbwY0+cy0Ffp6BNfom
        LexZSYaP/Ed9JFfHRYHtD3sUyunIseqLbLwn8ZdBJgE/1xKxT2gf9ejISnmmTuIcDRM6YO50PN1Cf
        GRz52caQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcXMr-00BBHL-CG; Mon, 18 Oct 2021 18:28:29 +0000
Date:   Mon, 18 Oct 2021 19:28:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YW28vaoW7qNeX3GP@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW2lKcqwBZGDCz6T@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 12:47:37PM -0400, Johannes Weiner wrote:
> On Sat, Oct 16, 2021 at 04:28:23AM +0100, Matthew Wilcox wrote:
> > On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> > >       mm/memcg: Add folio_memcg() and related functions
> > >       mm/memcg: Convert commit_charge() to take a folio
> > >       mm/memcg: Convert mem_cgroup_charge() to take a folio
> > >       mm/memcg: Convert uncharge_page() to uncharge_folio()
> > >       mm/memcg: Convert mem_cgroup_uncharge() to take a folio
> > >       mm/memcg: Convert mem_cgroup_migrate() to take folios
> > >       mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to folio
> > >       mm/memcg: Add folio_memcg_lock() and folio_memcg_unlock()
> > >       mm/memcg: Convert mem_cgroup_move_account() to use a folio
> > >       mm/memcg: Add folio_lruvec()
> > >       mm/memcg: Add folio_lruvec_lock() and similar functions
> > >       mm/memcg: Add folio_lruvec_relock_irq() and folio_lruvec_relock_irqsave()
> > >       mm/workingset: Convert workingset_activation to take a folio	
> > > 
> > > 		This is all anon+file stuff, not needed for filesystem
> > > 		folios.
> > 
> > No, that's not true.  A number of these functions are called from
> > filesystem code. mem_cgroup_track_foreign_dirty() is only called
> > from filesystem code. We at the very least need wrappers like
> > folio_cgroup_charge(), and folio_memcg_lock().
> 
> Well, a handful of exceptions don't refute the broader point.
> 
> No objection from me to convert mem_cgroup_track_foreign_dirty().
> 
> No objection to add a mem_cgroup_charge_folio(). But I insist on the
> subsystem prefix, because that's in line with how we're charging a
> whole bunch of other different things (swap, skmem, etc.). It'll also
> match a mem_cgroup_charge_anon() if we agree to an anon type.

I don't care about the name; I'll change that.  I still don't get when
you want mem_cgroup_foo() and when you want memcg_foo()

> > > 		As per the other email, no conceptual entry point for
> > > 		tail pages into either subsystem, so no ambiguity
> > > 		around the necessity of any compound_head() calls,
> > > 		directly or indirectly. It's easy to rule out
> > > 		wholesale, so there is no justification for
> > > 		incrementally annotating every single use of the page.
> > 
> > The justification is that we can remove all those hidden calls to
> > compound_head().  Hundreds of bytes of text spread throughout this file.
> 
> I find this line of argument highly disingenuous.
> 
> No new type is necessary to remove these calls inside MM code. Migrate
> them into the callsites and remove the 99.9% very obviously bogus
> ones. The process is the same whether you switch to a new type or not.
> 
> (I'll send more patches like the PageSlab() ones to that effect. It's
> easy. The only reason nobody has bothered removing those until now is
> that nobody reported regressions when they were added.)

That kind of change is actively dangerous.  Today, you can call
PageSlab() on a tail page, and it returns true.  After your patch,
it returns false.  Sure, there's a debug check in there that's enabled
on about 0.1% of all kernel builds, but I bet most people won't notice.

We're not able to catch these kinds of mistakes at review time:
https://lore.kernel.org/linux-mm/20211001024105.3217339-1-willy@infradead.org/

which means it escaped the eagle eyes of (at least):
    Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
    Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
    Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
    Cc: Christoph Lameter <cl@linux.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

I don't say that to shame these people.  We need the compiler's help
here.  If we're removing the ability to ask for whether a tail page
belongs to the slab allocator, we have to have the compiler warn us.

I have a feeling your patch also breaks tools/vm/page-types.c

> But typesafety is an entirely different argument. And to reiterate the
> main point of contention on these patches: there is no concensus among
> MM people how (or whether) we want MM-internal typesafety for pages.

I don't think there will ever be consensus as long as you don't take
the concerns of other MM developers seriously.  On Friday's call, several
people working on using large pages for anon memory told you that using
folios for anon memory would make their lives easier, and you didn't care.

> Personally, I think we do, but I don't think head vs tail is the most
> important or the most error-prone aspect of the many identities struct
> page can have. In most cases it's not even in the top 5 of questions I
> have about the page when I see it in a random MM context (outside of
> the very few places that do virt_to_page or pfn_to_page). Therefor
> "folio" is not a very poignant way to name the object that is passed
> around in most MM code. struct anon_page and struct file_page would be
> way more descriptive and would imply the head/tail aspect.

I get it that you want to split out anon pages from other types of
pages.  I'm not against there being a

struct anon_folio
{
	struct folio f;
};

which marks functions or regions of functions that only deal with anon
memory.  But we need _a_ type which represents "the head page of a
compound page or an order-0 page".  And that's what folio is.

Maybe we also want struct file_folio.  I don't see the need for it
myself, but maybe I'm wrong.

> Anyway, the email you are responding to was an offer to split the
> uncontroversial "large pages backing filesystems" part from the
> controversial "MM-internal typesafety" discussion. Several people in
> both the fs space and the mm space have now asked to do this to move
> ahead. Since you have stated in another subthread that you "want to
> get back to working on large pages in the page cache," and you never
> wanted to get involved that deeply in the struct page subtyping
> efforts, it's not clear to me why you are not taking this offer.

I am.  This email was written after trying to do just this.  I dropped
the patches you were opposed to and looked at the result.  It's not good.


You seem wedded to this idea that "folios are just for file backed
memory", and that's not my proposal at all.  folios are for everything.
Maybe we specialise out other types of memory later, or during, or
instead of converting something to use folios, but folios are an utterly
generic concept.
