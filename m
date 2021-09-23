Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6F415519
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 03:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhIWBXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 21:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbhIWBXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:23:06 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57736C061574;
        Wed, 22 Sep 2021 18:21:35 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 194so16284028qkj.11;
        Wed, 22 Sep 2021 18:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=w9LkJEpWBulKCuqXbddVVU+pNwq8BmQqZRxJCMFogUs=;
        b=M8pOe13runKaI2J8x6QY5/NPaqVwPKra+lAHfq2Z2KuPQlNhidIz2QTpcZMKZsYsF4
         AGIzMfrSs9rOjQshPafd7eT9/QTPQHo6MHAwZMYhg4WYBMnjb0HPYxwb6CfUi+Pwm99o
         kMl1tlswk1PmsTj7lOwEZx83S9ixtECe5lp1EyhbcQt33Q5z8Om+5IeneNY6xoqmbB7q
         KqcVk5KzvtiOelzTN+94MKmRwWcL8Eu2fwbTrnWjKrQB7Vs2XEZBJlm3KnWfUI585TYq
         jVjd9N7Ft7XikAPzdvLGuWFnB3kVlev+XqobkWlXKUe/OFxFujbyQ2smDlJF8jsZt9se
         AZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=w9LkJEpWBulKCuqXbddVVU+pNwq8BmQqZRxJCMFogUs=;
        b=v+c++dNNgy5xakPEgBl5rWbD1eVWuuaM5ekLiCX1hzw9tKkCISWF88C+q/NABo9R1O
         h3q5JRW5r+ckgiFwvfxnvnrtbnd1Yhq9Uyxwoncx8Qa8Uch34JJRydZSwXLB6m1CRt5M
         vu+4map5Y14CCpOUhohqnTxbIRwHnDiaBCYRfQged7PZxZecA2h8/o8rU2V9hDmLzAbC
         VaO1NIwqbmuIfC8AvbmujpMHfTRxZtdghZJYdliW9ViYDETeNnZDlAPi57F4t71bz6tk
         FMfam2ZvOZ3lSvfNX3nXLvcu3k0SStEIx7U8P/DcuPge7PSzCnictST045fHQ9ewx8+E
         UONg==
X-Gm-Message-State: AOAM5309UW+7/ShA0OUAUbaEHA+kqOOu7H/VTUMSqg4wHsnYaelsfa3s
        VC7P83qMQKA5OngaVcPTu5UL3gaADE68
X-Google-Smtp-Source: ABdhPJyY8hqVtxmhC6tJhSK+2V0GQrTmoBGu9WSx98Qe8vUHqFjDPQ/XPXE338dX6KutxROFTuJgTw==
X-Received: by 2002:a05:620a:bd4:: with SMTP id s20mr2440075qki.485.1632360093958;
        Wed, 22 Sep 2021 18:21:33 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t64sm3220631qkd.71.2021.09.22.18.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 18:21:33 -0700 (PDT)
Date:   Wed, 22 Sep 2021 21:21:31 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Struct page proposal
Message-ID: <YUvWm6G16+ib+Wnb@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One thing that's come out of the folios discussions with both Matthew and
Johannes is that we seem to be thinking along similar lines regarding our end
goals for struct page.

The fundamental reason for struct page is that we need memory to be self
describing, without any context - we need to be able to go from a generic
untyped struct page and figure out what it contains: handling physical memory
failure is the most prominent example, but migration and compaction are more
common. We need to be able to ask the thing that owns a page of memory "hey,
stop using this and move your stuff here".

Matthew's helpfully been coming up with a list of page types:
https://kernelnewbies.org/MemoryTypes

But struct page could be a lot smaller than it is now. I think we can get it
down to two pointers, which means it'll take up 0.4% of system memory. Both
Matthew and Johannes have ideas for getting it down even further - the main
thing to note is that virt_to_page() _should_ be an uncommon operation (most of
the places we're currently using it are completely unnecessary, look at all the
places we're using it on the zero page). Johannes is thinking two layer radix
tree, Matthew was thinking about using maple trees - personally, I think that
0.4% of system memory is plenty good enough.


Ok, but what do we do with the stuff currently in struct page?
-------------------------------------------------------------

The main thing to note is that since in normal operation most folios are going
to be describing many pages, not just one - and we'll be using _less_ memory
overall if we allocate them separately. That's cool.

Of course, for this to make sense, we'll have to get all the other stuff in
struct page moved into their own types, but file & anon pages are the big one,
and that's already being tackled.

Why two ulongs/pointers, instead of just one?
---------------------------------------------

Because one of the things we really want and don't have now is a clean division
between allocator and allocatee state. Allocator meaning either the buddy
allocator or slab, allocatee state would be the folio or the network pool state
or whatever actually called kmalloc() or alloc_pages().

Right now slab state sits in the same place in struct page where allocatee state
does, and the reason this is bad is that slab/slub are a hell of a lot faster
than the buddy allocator, and Johannes wants to move the boundary between slab
allocations and buddy allocator allocations up to like 64k. If we fix where slab
state lives, this will become completely trivial to do.

So if we have this:

struct page {
	unsigned long	allocator;
	unsigned long	allocatee;
};

The allocator field would be used for either a pointer to slab/slub's state, if
it's a slab page, or if it's a buddy allocator page it'd encode the order of the
allocation - like compound order today, and probably whether or not the
(compound group of) pages is free.

The allocatee field would be used for a type tagged (using the low bits of the
pointer) to one of:
 - struct folio
 - struct anon_folio, if that becomes a thing
 - struct network_pool_page
 - struct pte_page
 - struct zone_device_page

Then we can further refactor things until all the stuff that's currently crammed
in struct page lives in types where each struct field means one and precisely
one thing, and also where we can freely reshuffle and reorganize and add stuff
to the various types where we couldn't before because it'd make struct page
bigger.

Other notes & potential issues:
 - page->compound_dtor needs to die

 - page->rcu_head moves into the types that actually need it, no issues there

 - page->refcount has question marks around it. I think we can also just move it
   into the types that need it; with RCU derefing the pointer to the folio or
   whatever and grabing a ref on folio->refcount can happen under a RCU read
   lock - there's no real question about whether it's technically possible to
   get it out of struct page, and I think it would be cleaner overall that way.

   However, depending on how it's used from code paths that go from generic
   untyped pages, I could see it turning into more of a hassle than it's worth.
   More investigation is needed.

 - page->memcg_data - I don't know whether that one more properly belongs in
   struct page or in the page subtypes - I'd love it if Johannes could talk
   about that one.

 - page->flags - dealing with this is going to be a huge hassle but also where
   we'll find some of the biggest gains in overall sanity and readability of the
   code. Right now, PG_locked is super special and ad hoc and I have run into
   situations multiple times (and Johannes was in vehement agreement on this
   one) where I simply could not figure the behaviour of the current code re:
   who is responsible for locking pages without instrumenting the code with
   assertions.

   Meaning anything we do to create and enforce module boundaries between
   different chunks of code is going to suck, but the end result should be
   really worthwhile.

Matthew Wilcox and David Howells have been having conversations on IRC about
what to do about other page bits. It appears we should be able to kill a lot of
filesystem usage of both PG_private and PG_private_2 - filesystems in general
hang state off of page->private, soon to be folio->private, and PG_private in
current use just indicates whether page->private is nonzero - meaning it's
completely redundant.
