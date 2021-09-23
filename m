Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02174165F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 21:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbhIWTes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242931AbhIWTer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:34:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F483C061757;
        Thu, 23 Sep 2021 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s2m42Pnh/OCa97K3LyDzI/qGU+7pTD/Al5MsXgv5gjs=; b=KfkeN1svBuK0TE/SyNKHVijDdC
        cD9lPeno103ShVnu4p24zTNZMWW3wSNYntjzSQLy2ITyRaebAYcaLgJLSH4qY89DQeGVuv/630b1h
        yM6owWZfWiJ+JJ49ManwEvZdMKASGoSUoi9UZp9H6e/sYrQWcioAz0QNXbbSJi3A3A7VRBAhcLwUo
        wuOye8coOuJ8fE02OwaiDlNXixegXZweQzkayStoqnbhbN2kenE2oGLBjUtvA6jSaVcqs/Ms/ZEg8
        LrrjAHobeM5tv38jl8uepcx/456RNWRn0ZqVWS6AsWfK3uC/pSASAFTG527fVsbVLqxkiKgzsA/kj
        x2CnOhuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTURR-006Cg7-F4; Thu, 23 Sep 2021 19:31:44 +0000
Date:   Thu, 23 Sep 2021 20:31:33 +0100
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
Message-ID: <YUzWFboMEpEDqK1Z@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YUwTuaZlzx2WLXcG@moria.home.lan>
 <YUzAzl5iCdfUBJqe@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUzAzl5iCdfUBJqe@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 02:00:46PM -0400, Johannes Weiner wrote:
> On Thu, Sep 23, 2021 at 01:42:17AM -0400, Kent Overstreet wrote:
> > I think something we need is an alternate view - anon_folio, perhaps - and an
> > idea of what that would look like. Because you've been saying you don't think
> > file pages and anymous pages are similar enough to be the same time - so if
> > they're not, how's the code that works on both types of pages going to change to
> > accomadate that?
> > 
> > Do we have if (file_folio) else if (anon_folio) both doing the same thing, but
> > operating on different types? Some sort of subclassing going on?
> 
> Yeah, with subclassing and a generic type for shared code. I outlined
> that earlier in the thread:
> 
> https://lore.kernel.org/all/YUo20TzAlqz8Tceg@cmpxchg.org/
> 
> So you have anon_page and file_page being subclasses of page - similar
> to how filesystems have subclasses that inherit from struct inode - to
> help refactor what is generic, what isn't, and highlight what should be.

I'm with you there.  I don't understand anon pages well enough to know
whether splitting them out from file pages is good or bad.  I had assumed
that if it were worth doing, they would have gained their own named
members in the page union, but perhaps that didn't happen in order to
keep the complexity of the union down?

> Whether we do anon_page and file_page inheriting from struct page, or
> anon_folio and file_folio inheriting from struct folio - either would
> work of course. Again I think it comes down to the value proposition
> of folio as a means to clean up compound pages inside the MM code.
> It's pretty uncontroversial that we want PAGE_SIZE assumptions gone
> from the filesystems, networking, drivers and other random code. The
> argument for MM code is a different one. We seem to be discussing the
> folio abstraction as a binary thing for the Linux kernel, rather than
> a selectively applied tool, and I think it prevents us from doing
> proper one-by-one cost/benefit analyses on the areas of application.

I wasn't originally planning on doing nearly as much as Kent has
opened me up to.  Slab seems like a clear win to split out.  Page
tables seem like they will be too.  I'd like to get to these structs:

struct page {
    unsigned long flags;
    unsigned long compound_head;
    union {
        struct { /* First tail page only */
            unsigned char compound_dtor;
            unsigned char compound_order;
            atomic_t compound_mapcount;
            unsigned int compound_nr;
        };
        struct { /* Second tail page only */
            atomic_t hpage_pinned_refcount;
            struct list_head deferred_list;
        };
        unsigned long padding1[5];
    };
    unsigned int padding2[2];
#ifdef CONFIG_MEMCG
    unsigned long padding3;
#endif
#ifdef WANT_PAGE_VIRTUAL
    void *virtual;
#endif
#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
    int _last_cpupid;
#endif
};

struct slab {
... slab specific stuff here ...
};

struct page_table {
... pgtable stuff here ...
};

struct folio {
    unsigned long flags;
    union {
        struct {
            struct list_head lru;
            struct address_space *mapping;
            pgoff_t index;
            void *private;
        };
        struct {
... net pool here ...
        };
        struct {
... zone device here ...
        };
    };
    atomic_t _mapcount;
    atomic_t _refcount;
#ifdef CONFIG_MEMCG
    unsigned long memcg_data;
#endif
};

ie a 'struct page' contains no information on its own.  You have to
go to the compound_head page (cast to the appropriate type) to find
the information.  What Kent is proposing is exciting, but I think
further off.

> > I was agreeing with you that slab/network pools etc. shouldn't be folios - that
> > folios shouldn't be a replacement for compound pages. But I think we're going to
> > need a serious alternative proposal for anonymous pages if you're still against
> > them becoming folios, especially because according to Kirill they're already
> > working on that (and you have to admit transhuge pages did introduce a mess that
> > they will help with...)
> 
> I think we need a better analysis of that mess and a concept where
> tailpages are and should be, if that is the justification for the MM
> conversion.
> 
> The motivation is that we have a ton of compound_head() calls in
> places we don't need them. No argument there, I think.
> 
> But the explanation for going with whitelisting - the most invasive
> approach possible (and which leaves more than one person "unenthused"
> about that part of the patches) - is that it's difficult and error
> prone to identify which ones are necessary and which ones are not. And
> maybe that we'll continue to have a widespread hybrid existence of
> head and tail pages that will continue to require clarification.
> 
> But that seems to be an article of faith. It's implied by the
> approach, but this may or may not be the case.
> 
> I certainly think it used to be messier in the past. But strides have
> been made already to narrow the channels through which tail pages can
> actually enter the code. Certainly we can rule out entire MM
> subsystems and simply declare their compound_head() usage unnecessary
> with little risk or ambiguity.
> 
> Then the question becomes which ones are legit. Whether anybody
> outside the page allocator ever needs to *see* a tailpage struct page
> to begin with. (Arguably that bit in __split_huge_page_tail() could be
> a page allocator function; the pte handling is pfn-based except for
> the mapcount management which could be encapsulated; the collapse code
> uses vm_normal_page() but follows it quickly by compound_head() - and
> arguably a tailpage generally isn't a "normal" vm page, so a new
> pfn_to_normal_page() could encapsulate the compound_head()). Because
> if not, seeing struct page in MM code isn't nearly as ambiguous as is
> being implied. You would never have to worry about it - unless you are
> in fact the page allocator.
> 
> So if this problem could be solved by making tail pages an
> encapsulated page_alloc thing, and chasing down the rest of
> find_subpage() callers (which needs to happen anyway), I don't think a
> wholesale folio conversion of this subsystem would be justified.
> 
> A more in-depth analyses of where and how we need to deal with
> tailpages - laying out the data structures that hold them and code
> entry points for them - would go a long way for making the case for
> folios. And might convince reluctant people to get behind the effort.

OK.  So filesystems still need to deal with pages in some places.  One
place is at the bottom of the filesystem where memory gets packaged into
BIOs or SKBs to eventually participate in DMA:

struct bio_vec {
        struct page     *bv_page;
        unsigned int    bv_len;
        unsigned int    bv_offset;
};

That could become a folio (or Christoph's preferred option, a
phys_addr_t), but this is really an entirely different role for struct
page; it's just carrying the address of some memory for I/O to happen to.
Nobody looks at the contents of the struct page until it goes back to
the filesystem, at which point it clears the writeback bit or marks
it uptodate.

The other place that definitely still needs to be a struct page is

struct vm_fault {
...
        struct page *page;              /* ->fault handlers should return a
                                         * page here, unless VM_FAULT_NOPAGE
                                         * is set (which is also implied by
                                         * VM_FAULT_ERROR).
                                         */
...
};

Most filesystems use filemap_fault(), which handles this, but this affects
device drivers too.  We can't return a folio here because we need to
know which page corresponds to the address that took the fault.  We can
deduce it for filesystems, because we know how folios are allocated for
the page cache, but device drivers can map memory absolutely arbitrarily,
so there's no way to reconstruct that information.

Again, this could be a physical address (or a pfn), but we have it as a
page because it's locked and we're going to unlock it after mapping it.
So this is actually a place where we'll need to get a page from the
filesystem, convert to a folio and call folio operations on it.  This
is one of the reasons that lock_page() / unlock_page() contain the
embedded compound_head() today.
