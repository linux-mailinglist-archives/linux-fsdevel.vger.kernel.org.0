Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF8433CF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhJSRId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhJSRIc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:08:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E3396113B;
        Tue, 19 Oct 2021 17:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634663179;
        bh=IND+vmJTvpD3wGDfo3MrtiZeVOyq5schvPDxZ56+lYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJCJtbJXGH1Wu7VSlDOUMrX73wQ7typCnvAXyrUM6IIJ6/VGEiI2RNcd1AZSPNf2O
         e4V3DXM41XWSm199u7ihLcHQiQ2eCwBhKYyCw65iq5NWS7JtycbDYlpNkN+vJkGD0s
         DjaZVNCJldCECuF5fxJpo2rXRhtjiHnCqLywcDv1BUPsSA7axQrSxBChN6CzIpU0vp
         o0rl7CysmQovrNlCi0p6mA5A4PfwDb5Sd08R8MF9EfGeAW/3vI++BumbZOBh7Cz+qe
         U1Z2mnqVhrIxctauT7m7qM+SnZ5JGuHvo1+vsKyVpcFS2/iCLDYiKpAu9EhabA/0Ly
         f6rVfxJZ09zpQ==
Date:   Wed, 20 Oct 2021 01:06:04 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Splitting struct page into multiple types - Was: re: Folio
 discussion recap -
Message-ID: <20211019170603.GA15424@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW25EDqynlKU14hx@moria.home.lan>
 <YW3dByBWM0dSRw/X@cmpxchg.org>
 <YW7uN2p8CihCDsln@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW7uN2p8CihCDsln@moria.home.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 12:11:35PM -0400, Kent Overstreet wrote:
> On Mon, Oct 18, 2021 at 04:45:59PM -0400, Johannes Weiner wrote:
> > On Mon, Oct 18, 2021 at 02:12:32PM -0400, Kent Overstreet wrote:
> > > On Mon, Oct 18, 2021 at 12:47:37PM -0400, Johannes Weiner wrote:
> > > > I find this line of argument highly disingenuous.
> > > > 
> > > > No new type is necessary to remove these calls inside MM code. Migrate
> > > > them into the callsites and remove the 99.9% very obviously bogus
> > > > ones. The process is the same whether you switch to a new type or not.
> > > 
> > > Conversely, I don't see "leave all LRU code as struct page, and ignore anonymous
> > > pages" to be a serious counterargument. I got that you really don't want
> > > anonymous pages to be folios from the call Friday, but I haven't been getting
> > > anything that looks like a serious counterproposal from you.
> > > 
> > > Think about what our goal is: we want to get to a world where our types describe
> > > unambigiuously how our data is used. That means working towards
> > >  - getting rid of type punning
> > >  - struct fields that are only used for a single purpose
> > 
> > How is a common type inheritance model with a generic page type and
> > subclasses not a counter proposal?
> > 
> > And one which actually accomplishes those two things you're saying, as
> > opposed to a shared folio where even 'struct address_space *mapping'
> > is a total lie type-wise?
> > 
> > Plus, really, what's the *alternative* to doing that anyway? How are
> > we going to implement code that operates on folios and other subtypes
> > of the page alike? And deal with attributes and properties that are
> > shared among them all? Willy's original answer to that was that folio
> > is just *going* to be all these things - file, anon, slab, network,
> > rando driver stuff. But since that wasn't very popular, would not get
> > rid of type punning and overloaded members, would get rid of
> > efficiently allocating descriptor memory etc.- what *is* the
> > alternative now to common properties between split out subtypes?
> > 
> > I'm not *against* what you and Willy are saying. I have *genuinely
> > zero idea what* you are saying.
> 
> So we were starting to talk more concretely last night about the splitting of
> struct page into multiple types, and what that means for page->lru.
> 
> The basic process I've had in mind for splitting struct page up into multiple
> types is: create a new type for each struct in the union-of-structs, change code
> to refer to that type instead of struct page, then - importantly - delete those
> members from the union-of-structs in struct page.
> 
> E.g. for struct slab, after Willy's struct slab patches, we want to delete that
> stuff from struct page - otherwise we've introduced new type punning where code
> can refer to the same members via struct page and struct slab, and it's also
> completely necessary in order to separately allocate these new structs and slim
> down struct page.
> 
> Roughly what I've been envisioning for folios is that the struct in the
> union-of-structs with lru, mapping & index - that's what turns into folios.
> 
> Note that we have a bunch of code using page->lru, page->mapping, and
> page->index that really shouldn't be. The buddy allocator uses page->lru for
> freelists, and it shouldn't be, but there's a straightforward solution for that:
> we need to create a new struct in the union-of-structs for free pages, and
> confine the buddy allocator to that (it'll be a nice cleanup, right now it's
> overloading both page->lru and page->private which makes no sense, and it'll
> give us a nice place to stick some other things).
> 
> Other things that need to be fixed:
> 
>  - page->lru is used by the old .readpages interface for the list of pages we're
>    doing reads to; Matthew converted most filesystems to his new and improved
>    .readahead which thankfully no longer uses page->lru, but there's still a few
>    filesystems that need to be converted - it looks like cifs and erofs, not
>    sure what's going on with fs/cachefiles/. We need help from the maintainers
>    of those filesystems to get that conversion done, this is holding up future
>    cleanups.

The reason why using page->lru for non-LRU pages was just because the
page struct is already there and it's an effective way to organize
variable temporary pages without any extra memory overhead other than
page structure itself. Another benefits is that such non-LRU pages can
be immediately picked from the list and added into page cache without
any pain (thus ->lru can be reused for real lru usage).

In order to maximize the performance (so that pages can be shared in
the same read request flexibly without extra overhead rather than
memory allocation/free from/to the buddy allocator) and minimise extra
footprint, this way was used. I'm pretty fine to transfer into some
other way instead if some similar field can be used in this way.

Yet if no such field anymore, I'm also very glad to write a patch to
get rid of such usage, but I wish it could be merged _only_ with the
real final transformation together otherwise it still takes the extra
memory of the old page structure and sacrifices the overall performance
to end users (..thus has no benefits at all.)

Thanks,
Gao Xiang
