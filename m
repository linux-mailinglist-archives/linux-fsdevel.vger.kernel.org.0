Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC8432417
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhJRQtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhJRQtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:49:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0AAC061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 09:47:40 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w8so15834298qts.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 09:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vVoEj4FpzWuRYVTtT2kVLQ0v62okoy92JquXkv+faYA=;
        b=Qip6++a3Re69KqbZR+/U+8NTkmjdaQ4owDan2ygPuQ78S81aLt50MNyqVcYGXno1yF
         asDVCdQiA/CQJyvH2Mu8a2CwOjtuZZcVWK5UotuqSfTzhXpPNlRSYL9qAwXE/Lna9As0
         T4l7vgk4qqlhYOj0a/28ygNkHtOOjZv3bfQe46KlKO3twnb4viaNHoKn680d+xqoPk3g
         CSG4S+8nqc57m7yGbSFissjZGZDz5Vh0MWB77jU/OtKIdrAWahdPDLP89XtAWVc1qBQf
         8DQkh7kmDNiGyTrjVyLmZ9hHvt9aqU3x778soevA+k+CsZx7I2CdG1aeKOlHyG2sDu55
         ZXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVoEj4FpzWuRYVTtT2kVLQ0v62okoy92JquXkv+faYA=;
        b=FPed90EGEQedpdE3AThK2eFPKcFKJdvVfCK4rlcuQwWX78p+3eSzv/peonvt6M66V7
         oZSrv8E+t+JyMXeIWkyoxyx2YuproWP2lk0Mf67nAh0Ca3BGvad3fexfKYwKHY9XBNN9
         w82o46201Q9e2d8Hx9ueNyOAw5e4SfcLKLS06GV1T1nj6Lm1XF866ckrnqbHy65ev2Ra
         82a+YZKl87c1qhdyzu7xJtJwKSxhgQ5YfyMyWEly5KM8d/kmymwNJB93yPJ7+oRoOyZT
         QFvaHt1vjagzCZG1xI5Z5KpEQr3gMcWswxuVZY4P4naCRaEhRSVMoFTW458R6IWkR7hW
         FwaA==
X-Gm-Message-State: AOAM530LWkU2hEB1hNZLfjvsjqUgtkPwoK297drLgBTn5dXSqUZ2M4Ku
        7O1QkRizOAqrAXzlDrZmN3ACVg==
X-Google-Smtp-Source: ABdhPJxbJdXmCDvREwaQZoi0yXv1ItXbWsTxGWayc1K8F2bwirxfOIzTRON/xIYaquHbtTTdv84Odg==
X-Received: by 2002:ac8:7dc6:: with SMTP id c6mr24806897qte.333.1634575659455;
        Mon, 18 Oct 2021 09:47:39 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id f15sm6467222qtm.37.2021.10.18.09.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:47:38 -0700 (PDT)
Date:   Mon, 18 Oct 2021 12:47:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YW2lKcqwBZGDCz6T@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWpG1xlPbm7Jpf2b@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 16, 2021 at 04:28:23AM +0100, Matthew Wilcox wrote:
> On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
> >       mm/memcg: Add folio_memcg() and related functions
> >       mm/memcg: Convert commit_charge() to take a folio
> >       mm/memcg: Convert mem_cgroup_charge() to take a folio
> >       mm/memcg: Convert uncharge_page() to uncharge_folio()
> >       mm/memcg: Convert mem_cgroup_uncharge() to take a folio
> >       mm/memcg: Convert mem_cgroup_migrate() to take folios
> >       mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to folio
> >       mm/memcg: Add folio_memcg_lock() and folio_memcg_unlock()
> >       mm/memcg: Convert mem_cgroup_move_account() to use a folio
> >       mm/memcg: Add folio_lruvec()
> >       mm/memcg: Add folio_lruvec_lock() and similar functions
> >       mm/memcg: Add folio_lruvec_relock_irq() and folio_lruvec_relock_irqsave()
> >       mm/workingset: Convert workingset_activation to take a folio	
> > 
> > 		This is all anon+file stuff, not needed for filesystem
> > 		folios.
> 
> No, that's not true.  A number of these functions are called from
> filesystem code. mem_cgroup_track_foreign_dirty() is only called
> from filesystem code. We at the very least need wrappers like
> folio_cgroup_charge(), and folio_memcg_lock().

Well, a handful of exceptions don't refute the broader point.

No objection from me to convert mem_cgroup_track_foreign_dirty().

No objection to add a mem_cgroup_charge_folio(). But I insist on the
subsystem prefix, because that's in line with how we're charging a
whole bunch of other different things (swap, skmem, etc.). It'll also
match a mem_cgroup_charge_anon() if we agree to an anon type.

folio_memcg_lock() sounds good to me.

> > 		As per the other email, no conceptual entry point for
> > 		tail pages into either subsystem, so no ambiguity
> > 		around the necessity of any compound_head() calls,
> > 		directly or indirectly. It's easy to rule out
> > 		wholesale, so there is no justification for
> > 		incrementally annotating every single use of the page.
> 
> The justification is that we can remove all those hidden calls to
> compound_head().  Hundreds of bytes of text spread throughout this file.

I find this line of argument highly disingenuous.

No new type is necessary to remove these calls inside MM code. Migrate
them into the callsites and remove the 99.9% very obviously bogus
ones. The process is the same whether you switch to a new type or not.

(I'll send more patches like the PageSlab() ones to that effect. It's
easy. The only reason nobody has bothered removing those until now is
that nobody reported regressions when they were added.)

But typesafety is an entirely different argument. And to reiterate the
main point of contention on these patches: there is no concensus among
MM people how (or whether) we want MM-internal typesafety for pages.

Personally, I think we do, but I don't think head vs tail is the most
important or the most error-prone aspect of the many identities struct
page can have. In most cases it's not even in the top 5 of questions I
have about the page when I see it in a random MM context (outside of
the very few places that do virt_to_page or pfn_to_page). Therefor
"folio" is not a very poignant way to name the object that is passed
around in most MM code. struct anon_page and struct file_page would be
way more descriptive and would imply the head/tail aspect.

Anyway, the email you are responding to was an offer to split the
uncontroversial "large pages backing filesystems" part from the
controversial "MM-internal typesafety" discussion. Several people in
both the fs space and the mm space have now asked to do this to move
ahead. Since you have stated in another subthread that you "want to
get back to working on large pages in the page cache," and you never
wanted to get involved that deeply in the struct page subtyping
efforts, it's not clear to me why you are not taking this offer.

> >       mm: Add folio_young and folio_idle
> >       mm/swap: Add folio_activate()
> >       mm/swap: Add folio_mark_accessed()
> > 
> > 		This is anon+file aging stuff, not needed.
> 
> Again, very much needed.  Take a look at pagecache_get_page().  In Linus'
> tree today, it calls if (page_is_idle(page)) clear_page_idle(page);
> So either we need wrappers (which are needlessly complicated thanks to
> how page_is_idle() is defined) or we just convert it.

I'm not sure I understand the complication. That you'd have to do

	if (page_is_idle(folio->page))
		clear_page_idle(folio->page)

inside code in mm/?

It's either that, or

a) generic code shared with anon pages has to do:

	if (folio_is_idle(page->folio))
		clear_folio_idle(page->folio)

which is a weird, or

b) both types work with their own wrappers:

	if (page_is_idle(page))
		clear_page_idle(page)

	if (folio_is_idle(folio))
		clear_folio_idle(folio)

and it's not obvious at all that they are in fact tracking the same
state.

State which is exported to userspace through the "page_idle" feature.

Doing the folio->page translation in mm/-private code, and keeping
this a page interface, is by far the most preferable solution.

> >       mm/rmap: Add folio_mkclean()
> > 
> >       mm/migrate: Add folio_migrate_mapping()
> >       mm/migrate: Add folio_migrate_flags()
> >       mm/migrate: Add folio_migrate_copy()
> > 
> > 		More anon+file conversion, not needed.
> 
> As far as I can tell, anon never calls any of these three functions.
> anon calls migrate_page(), which calls migrate_page_move_mapping(),
> but several filesystems do call these individual functions.

In the current series, migrate_page_move_mapping() has been replaced,
and anon pages go through them:

int folio_migrate_mapping(struct address_space *mapping,
                struct folio *newfolio, struct folio *folio, int extra_count)
{
	[...]
        if (!mapping) {
                /* Anonymous page without mapping */
                if (folio_ref_count(folio) != expected_count)
                        return -EAGAIN;

                /* No turning back from here */
                newfolio->index = folio->index;
                newfolio->mapping = folio->mapping;
                if (folio_test_swapbacked(folio))
                        __folio_set_swapbacked(newfolio);

That's what I'm objecting to.

I'm not objecting to adding these to the filesystem interface as thin
folio->page wrappers that call the page implementation.

> >       mm/lru: Add folio_add_lru()
> > 
> > 		LRU code, not needed.
> 
> Again, we need folio_add_lru() for filemap.  This one's more
> tractable as a wrapper function.

Please don't quote selectively to the point of it being misleading.

The original block my statement applied to was this:

      mm: Add folio_evictable()
      mm/lru: Convert __pagevec_lru_add_fn to take a folio
      mm/lru: Add folio_add_lru()

which goes way behond just being filesystem-interfacing.

I have no objection to a cache interface function for adding a folio
to the LRU (a wrapper to encapsulate the folio->page transition).

However, like with the memcg code above, the API is called lru_cache:
we have had lru_cache_add_file() and lru_cache_add_anon() in the past,
so lru_cache_add_folio() seems more appropriate - especially as long
as we still have one for pages (and maybe later one for anon pages).

---

All that to say, adding folio as a new type for file headpages with
API functions like this:

	mem_cgroup_charge_folio()
	lru_cache_add_folio()

now THAT would be an incremental change to the kernel code.

And if that new type proves like a great idea, we can do the same for
anon - whether with a shared type or with separate types.

And if it does end up the same type, in the interfaces and in the
implementation, we can merge

	mem_cgroup_charge_page()	# generic bits
	mem_cgroup_charge_folio()	# file bits
	mem_cgroup_charge_anon()	# anon bits

back into a single function, just like we've done it already for the
anon and file variants of those functions that we have had before.

And if we then want to rename that function to something we agree is
more appropriate, we can do that as yet another step.

That would actually be incremental refactoring.
