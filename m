Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBA0433BCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhJSQNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJSQNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:13:52 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F500C06161C;
        Tue, 19 Oct 2021 09:11:39 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id k19so247496qvm.13;
        Tue, 19 Oct 2021 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0aHRd3oPkl4zrOnf1WA/CMlBIEU+VgeSuT+Y2Httcnw=;
        b=WgYwgajlnztAloU8YVkEhAmzHbvcFdZYjzilyeu/xC6Yy6vWGqdq7osw5DTZIhVonJ
         KFmfmxRgUPN83GYJQelfYUrd+1yjUY+YFvpAuVZEpCC5nkD9iKcrG+mefcN9iR6DMiKe
         DPK6RJBkvhNOM2dfxOMOAMm6Jyws/l37Vr7am2FhMEW/sFMiHcERRJNoxYk+GBnL3ttl
         D48vxRFKQ+hn0Pti6ItfQH2PMR/TApBSrdyOQDc8vwa0aSdy3eaub675uz8meuefH8Zu
         iFPhq6iZjJEWXakilhPBPUXbYJcrtEgqWux0i1pbPUkafCShLtmsdJxWMDPsRL6URcxy
         2y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aHRd3oPkl4zrOnf1WA/CMlBIEU+VgeSuT+Y2Httcnw=;
        b=s81NXkNsWeyCH7ezfCJr/aM+EMNHUK8Dh628oK8+VW01/6HLzG2CTI4ND1p0t6iIA6
         S/XsLwL7qHtMB5y/GITSqjSpJzKT3Q+f9EfSh0CujYRhzy28rvFeDxU3QGB1Gj+Rvbbj
         nxQjGlNDe/NSuMaXopZ39nkCwcuKcw57LE/9cBjclz0+Mnu2gMM6hzubfC4KesyaSH3R
         MLISusPJyi6POOwPDdestRNKSn2u+y3qWVaZOXO3T3WaXtjvu9bEWlK8IxVu1nWffcx/
         R+nnIdyeYtqlTNyZteHo82XEpHcjSO5ngoniJC8+js1WcbmjSjeC/kvd3g9QFHj0Sapy
         jjZw==
X-Gm-Message-State: AOAM533MJTOs6edItGcBBuT6S2+A054+bwbddfZHZFUqAs1Z1/EjZbIS
        hSKQIg2upiMpeRXfEOEDsA==
X-Google-Smtp-Source: ABdhPJz9MwUAQERc98dyMH0lzT48iA/zBld+Inrqhlnk1GrKWyzTd8Vy6yrdgdXRJPepm9Zbqfu28Q==
X-Received: by 2002:a05:6214:400f:: with SMTP id kd15mr714805qvb.27.1634659898487;
        Tue, 19 Oct 2021 09:11:38 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id d186sm8037372qkg.25.2021.10.19.09.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 09:11:37 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:11:35 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Splitting struct page into multiple types - Was: re: Folio
 discussion recap -
Message-ID: <YW7uN2p8CihCDsln@moria.home.lan>
References: <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW25EDqynlKU14hx@moria.home.lan>
 <YW3dByBWM0dSRw/X@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW3dByBWM0dSRw/X@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 04:45:59PM -0400, Johannes Weiner wrote:
> On Mon, Oct 18, 2021 at 02:12:32PM -0400, Kent Overstreet wrote:
> > On Mon, Oct 18, 2021 at 12:47:37PM -0400, Johannes Weiner wrote:
> > > I find this line of argument highly disingenuous.
> > > 
> > > No new type is necessary to remove these calls inside MM code. Migrate
> > > them into the callsites and remove the 99.9% very obviously bogus
> > > ones. The process is the same whether you switch to a new type or not.
> > 
> > Conversely, I don't see "leave all LRU code as struct page, and ignore anonymous
> > pages" to be a serious counterargument. I got that you really don't want
> > anonymous pages to be folios from the call Friday, but I haven't been getting
> > anything that looks like a serious counterproposal from you.
> > 
> > Think about what our goal is: we want to get to a world where our types describe
> > unambigiuously how our data is used. That means working towards
> >  - getting rid of type punning
> >  - struct fields that are only used for a single purpose
> 
> How is a common type inheritance model with a generic page type and
> subclasses not a counter proposal?
> 
> And one which actually accomplishes those two things you're saying, as
> opposed to a shared folio where even 'struct address_space *mapping'
> is a total lie type-wise?
> 
> Plus, really, what's the *alternative* to doing that anyway? How are
> we going to implement code that operates on folios and other subtypes
> of the page alike? And deal with attributes and properties that are
> shared among them all? Willy's original answer to that was that folio
> is just *going* to be all these things - file, anon, slab, network,
> rando driver stuff. But since that wasn't very popular, would not get
> rid of type punning and overloaded members, would get rid of
> efficiently allocating descriptor memory etc.- what *is* the
> alternative now to common properties between split out subtypes?
> 
> I'm not *against* what you and Willy are saying. I have *genuinely
> zero idea what* you are saying.

So we were starting to talk more concretely last night about the splitting of
struct page into multiple types, and what that means for page->lru.

The basic process I've had in mind for splitting struct page up into multiple
types is: create a new type for each struct in the union-of-structs, change code
to refer to that type instead of struct page, then - importantly - delete those
members from the union-of-structs in struct page.

E.g. for struct slab, after Willy's struct slab patches, we want to delete that
stuff from struct page - otherwise we've introduced new type punning where code
can refer to the same members via struct page and struct slab, and it's also
completely necessary in order to separately allocate these new structs and slim
down struct page.

Roughly what I've been envisioning for folios is that the struct in the
union-of-structs with lru, mapping & index - that's what turns into folios.

Note that we have a bunch of code using page->lru, page->mapping, and
page->index that really shouldn't be. The buddy allocator uses page->lru for
freelists, and it shouldn't be, but there's a straightforward solution for that:
we need to create a new struct in the union-of-structs for free pages, and
confine the buddy allocator to that (it'll be a nice cleanup, right now it's
overloading both page->lru and page->private which makes no sense, and it'll
give us a nice place to stick some other things).

Other things that need to be fixed:

 - page->lru is used by the old .readpages interface for the list of pages we're
   doing reads to; Matthew converted most filesystems to his new and improved
   .readahead which thankfully no longer uses page->lru, but there's still a few
   filesystems that need to be converted - it looks like cifs and erofs, not
   sure what's going on with fs/cachefiles/. We need help from the maintainers
   of those filesystems to get that conversion done, this is holding up future
   cleanups.

 - page->mapping and page->index are used for entirely random purposes by some
   driver code - drivers/net/ethernet/sun/niu.c looks to be using page->mapping
   for a singly linked list (!).

 - unrelated, but worth noting: there's a fair amount of filesystem code that
   uses page->mapping and page->index and doesn't need to because it has it from
   context - it's both a performance improvement and a cleanup to change that
   code to not get it from the page.

Basically, we need to get to a point where each field in struct page is used for
one and just one thing, but that's going to take some time.

You've been noting that page->mapping is used for different things depending on
whether it's a file page or an anonymous page, and I agree that that's not ideal -
but it's one that I'm much less concerned about because a field being used for
two different things that are both core and related concepts in the kernel is
less bad than fields that are used as dumping grounds for whatever is
convenient - file & anon overloading page->mapping is just not the most pressing
issue to me.

Also, let's look at what file & anonymous pages share:
 - they're both mapped to userspace - they both need page->mapcount
 - they both share the lru code - they both need page->lru

page->lru is the real decider for me, because getting rid of non-lru uses of
that field looks very achievable to me, and once it's done it's one of the
fields we want to delete from struct page and move to struct folio.

If we leave the lru code using struct page, it creates a real problem for this
approach - it means we won't be able to delete the folio struct from the
union-of-structs in struct page. I'm not sure what our path forward would be.

That's my resistance to trying to separate file & anon at this point. I'm
definitely not saying we shouldn't separate file & anon in the future - I don't
have an opinion on whether or not it should be done, and if we do want to do
that I'd want to think about doing it by embedding a "struct lru_object" into
both file_folio and anon_folio and having the lru code refer that instead of
struct page - embedding an object is generally preferable to inheritence.

I want to say - and I don't think I've been clear enough about this - my
objection to trying to split up file & anonymous pages into separate types isn't
so much based on any deep philosophical reasons (I have some ideas for making
anonymous pages more like file pages that I would like to attempt, but I also
heard you when you said you'd tried to do that in the past and it hadn't worked
out) - my objection is because I think it would very much get in the way of
shorter term cleanups that are much more pressing. This is what I've been
referring to when I've been talking about following the union-of-structs in
splitting up struct page - I'm just trying to be practical.

Another relevant thing we've been talking about is consolidating the types of
pages that can be mapped into userspace. Right now we've got driver code mapping
all sorts of rando pages into userspace, and this isn't good - pages in theory
have this abstract interface that they implement, and pages mapped into
userspace have a bigger and more complicated interface - i.e.
a_ops.set_page_dirty; any page mapped into userspace can have this called on it
via the O_DIRECT read path, and possibly other things. Right now we have drivers
allocating vmalloc() memory and then mapping it into userspace, which is just
bizarre - what chunk of code really owns that page, and is implementing that
interface? vmalloc, or the driver?

What I'd like to see happen is for those to get switched to some sort of
internal device or inode, something that the driver owns and has an a_ops struct
- at this point they'd just be normal file pages. The reason drivers are mapping
vmalloc() memory into userspace is so they can get it into a contiguous kernel
side memory mapping, but they could also be doing that by calling vmap() on
existing pages - I think that would be much cleaner.

I have no idea if this approach works for network pool pages or how those would
be used, I haven't gotten that far - if someone can chime in about those that
would be great. But, the end goal I'm envisioning is a world where _only_ bog
standard file & anonymous pages are mapped to userspace - then _mapcount can be
deleted from struct page and only needs to live in struct folio.

Anyways, that's another thing to consider when thinking about whether file &
anonymous pages should be the same type.
