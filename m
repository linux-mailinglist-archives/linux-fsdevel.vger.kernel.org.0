Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC01040FDE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbhIQQbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbhIQQbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:31:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF31C061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 09:29:39 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c7so13683381qka.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2HsUkQ8fOhjXi15MPOztE8TxIV5X+XjzP3rW1H5zjpE=;
        b=fAhePr+69OVHmQY9xBibvJ55dFKWkjATxQFOb1dSZ4d1ppoo1W8a5gfDnc+V09uQ3L
         sqQtKrefilO7h1KhAKOJDJ3qbsSiGVDAEk/ZUaeOx0GiiFH7m+V179i7cmMGAU267z48
         CLmeRZfmsG20emvyvzXKokLaNqJ2Lh7SDXAahUfWvSR0svSH/+jKEovNftzE9YYPKJoN
         xZw2RKhE1fFetfJtvRegP/3m4eWGSCzrQ6gBPBCgvgZWiFA7ITWiDc1kJLSywrg85NsC
         tVOei5vByQSVEbivTPyRNcrRt6/WALKyQDqtf75vnimOfM11BFpZ2hEUlg0uiFI3fpu9
         113Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2HsUkQ8fOhjXi15MPOztE8TxIV5X+XjzP3rW1H5zjpE=;
        b=Duqe9Gby9GyFTlhCA741qbO93G6rxZQ3Gh7itFSppf6zudUtJWIwHQhIdZjhoHoMcm
         hk6PewGH5WQSy6pDOdWB8nsZ31J+lnGUg+mhixque9g7F9LhbVFwJkmlIheR4ohCcS6d
         wnTG+qbYo+/WvI6fNLban9aZtYO6hnHFB80/w0Sb7XZPhC+SHlGQ39kEznFYdWIJOHgB
         AZ7G9op3Wz9zedaaNQLgnHIeeKOpbdP5V8XGzfQwX08HCY3EslCoFCpxs1Ltl8H2g9RO
         ME59GPBXzhD7xSHPnE5bERnIOmFuZYlsGKq3cDfP0FcRM2RHLm3IORbPcs7aw8bidDx1
         0KVg==
X-Gm-Message-State: AOAM531OAFcUDiqmRsz6199Kx/68EDBDceetnLQ3DRYrA/ezR6vKghJ5
        qDE775lvornjXTwnaZZgJLpKSQ==
X-Google-Smtp-Source: ABdhPJzBDURl+kSs7t3ZrvSGWold3Z4S+tq7SXdrj56e46TPU+eR8IWCyZQyyrag5BvKMjDg4Hgs9g==
X-Received: by 2002:a05:620a:c05:: with SMTP id l5mr11460700qki.17.1631896179116;
        Fri, 17 Sep 2021 09:29:39 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id j6sm4284123qtp.97.2021.09.17.09.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:29:38 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:31:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUTC6O0w3j7i8iDm@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917052440.GJ1756565@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 03:24:40PM +1000, Dave Chinner wrote:
> On Thu, Sep 16, 2021 at 12:54:22PM -0400, Johannes Weiner wrote:
> > I agree with what I think the filesystems want: instead of an untyped,
> > variable-sized block of memory, I think we should have a typed page
> > cache desciptor.
> 
> I don't think that's what fs devs want at all. It's what you think
> fs devs want. If you'd been listening to us the same way that Willy
> has been for the past year, maybe you'd have a different opinion.

I was going off of Darrick's remarks about non-pagecache uses, Kent's
remarks Kent about simple and obvious core data structures, and yes
your suggestion of "cache page".

But I think you may have overinterpreted what I meant by cache
descriptor:

> Indeed, we don't actually need a new page cache abstraction.

I didn't suggest to change what the folio currently already is for the
page cache. I asked to keep anon pages out of it (and in the future
potentially other random stuff that is using compound pages).

It doesn't have any bearing on how it presents to you on the
filesystem side, other than that it isn't as overloaded as struct page
is with non-pagecache stuff.

A full-on disconnect between the cache entry descriptor and the page
is something that came up during speculation on how the MM will be
able to effectively raise the page size and meet scalability
requirements on modern hardware - and in that context I do appreciate
you providing background information on the chunk cache, which will be
valuable to inform *that* discussion.

But it isn't what I suggested as the immediate action to unblock the
folio merge.

> The fact that so many fs developers are pushing *hard* for folios is
> that it provides what we've been asking for individually over last
> few years.

I'm not sure filesystem people are pushing hard for non-pagecache
stuff to be in the folio.

> Willy has done a great job of working with the fs developers and
> getting feedback at every step of the process, and you see that in
> the amount of work that in progress that is already based on
> folios.

And that's great, but the folio is blocked on MM questions:

1. Is the folio a good descriptor for all uses of anon and file pages
   inside MM code way beyond the page cache layer YOU care about?

2. Are compound pages a scalable, future-proof allocation strategy?

For some people the answers are yes, for others they are a no.

For 1), the value proposition is to clean up the relatively recent
head/tail page confusion. And though everybody agrees that there is
value in that, it's a LOT of churn for what it does. Several people
have pointed this out, and AFAICS this is the most common reason for
people that have expressed doubt or hesitation over the patches.

In an attempt to address this, I pointed out the cleanup opportunities
that would open up by using separate anon and file folio types instead
of one type for both. Nothing more. No intermediate thing, no chunk
cache. Doesn't affect you. Just taking Willy's concept of type safety
and applying it to file and anon instead of page vs compound page.

- It wouldn't change anything for fs people from the current folio
  patchset (except maybe the name)

- It would accomplish the head/tail page cleanup the same way, since
  just like a folio, a "file folio" could also never be a tail page

- It would take the same solution folio prescribes to the compound
  page issue (explicit typing to get rid of useless checks, lookups
  and subtle bugs) and solve way more instances of this all over MM
  code, thereby hopefully boosting the value proposition and making
  *that part* of the patches a clearer win for the MM subsystem

This is a question directed at MM people, not filesystem people. It
doesn't pertain to you at all.

And if MM people agree or want to keep discussing it, the relatively
minor action item for the folio patch is the same: drop the partial
anon-to-folio conversion bits inside MM code for now and move on.

For 2), nobody knows the answer to this. Nobody. Anybody who claims to
do so is full of sh*t. Maybe compound pages work out, maybe they
don't. We can talk a million years about larger page sizes, how to
handle internal fragmentation, the difficulties of implementing a
chunk cache, but it's completely irrelevant because it's speculative.

We know there are multiple page sizes supported by the hardware and
the smallest supported one is no longer the most dominant one. We do
not know for sure yet how the MM is internally going to lay out its
type system so that the allocator, mmap, page reclaim etc. can be CPU
efficient and the descriptors be memory efficient.

Nobody's "grand plan" here is any more viable, tested or proven than
anybody else's.

My question for fs folks is simply this: as long as you can pass a
folio to kmap and mmap and it knows what to do with it, is there any
filesystem relevant requirement that the folio map to 1 or more
literal "struct page", and that folio_page(), folio_nr_pages() etc be
part of the public API? Or can we keep this translation layer private
to MM code? And will page_folio() be required for anything beyond the
transitional period away from pages?

Can we move things not used outside of MM into mm/internal.h, mark the
transitional bits of the public API as such, and move on?

The unproductive vitriol, personal attacks and dismissiveness over
relatively minor asks and RFCs from the subsystem that is the most
impacted by this patchset is just nuts.
