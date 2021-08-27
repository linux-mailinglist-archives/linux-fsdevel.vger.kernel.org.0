Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9073F98B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245060AbhH0MHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 08:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhH0MHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 08:07:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BD3C061757;
        Fri, 27 Aug 2021 05:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qyXblKfzKi0M/ZBTjKDzsBk5pEo6TqTVKlmSZn0GpDg=; b=pEZAjqyUYEjAckJA/23zaJLAf/
        bWCTtj4BqKKt0B2KcE7INS7Lsg4hxcA7XE3jzCZFCfMx9l61IIkuNcEvTo+Z+rZwZc15l6OWNUPKN
        CIORkmRhnjj4QegdpMEEY8bDm9JJrUei4QbPaqQ+EfPD6zSiO251ROVuqgkkUEoHxq9uVJh2JkPGT
        hSxCGNPmG6A57KluamQE1Ua9CoKJSOENpEUDSVAnqE+6coWR7cV+Fl1qQyO7PiKENtH4kzunfR239
        AVMDF+jP2mNXWRKdJY8f1J16hG/rK4JpUBG6GVytF/Bc7L8LkRomHPJlGhhzt2VGKBjUWiOrkzmga
        1Tle5evQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJac7-00EW7t-BM; Fri, 27 Aug 2021 12:05:47 +0000
Date:   Fri, 27 Aug 2021 13:05:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSjVE8aX98C1vm3j@casper.infradead.org>
References: <YSZeKfHxOkEAri1q@cmpxchg.org>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <2101397.1629968286@warthog.procyon.org.uk>
 <YSi4bZ7myEMNBtlY@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSi4bZ7myEMNBtlY@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:03:25AM -0400, Johannes Weiner wrote:
> At the current stage of conversion, folio is a more clearly delineated
> API of what can be safely used from the FS for the interaction with
> the page cache and memory management. And it looks still flexible to
> make all sorts of changes, including how it's backed by
> memory. Compared with the page, where parts of the API are for the FS,
> but there are tons of members, functions, constants, and restrictions
> due to the page's role inside MM core code. Things you shouldn't be
> using, things you shouldn't be assuming from the fs side, but it's
> hard to tell which is which, because struct page is a lot of things.
> 
> However, the MM narrative for folios is that they're an abstraction
> for regular vs compound pages. This is rather generic. Conceptually,
> it applies very broadly and deeply to MM core code: anonymous memory
> handling, reclaim, swapping, even the slab allocator uses them. If we
> follow through on this concept from the MM side - and that seems to be
> the plan - it's inevitable that the folio API will grow more
> MM-internal members, methods, as well as restrictions again in the
> process. Except for the tail page bits, I don't see too much in struct
> page that would not conceptually fit into this version of the folio.

So the superhypermegaultra ambitious version of this does something
like:

struct slab_page {
	unsigned long flags;
	union {
		struct list_head slab_list;
		struct {
		...
		};
	};
	struct kmem_cache *slab_cache;
	void *freelist;
	void *s_mem;
	unsigned int active;
	atomic_t _refcount;
	unsigned long memcg_data;
};

struct folio {
	... more or less as now ...
};

struct net_page {
	unsigned long flags;
	unsigned long pp_magic;
	struct page_pool *pp;
	unsigned long _pp_mapping_pad;
	unsigned long dma_addr[2];
	atomic_t _mapcount;
	atomic_t _refcount;
	unsigned long memcg_data;
};

struct page {
	union {
		struct folio folio;
		struct slab_page slab;
		struct net_page pool;
		...
	};
};

and then functions which only take one specific type of page use that
type.  And the compiler will tell you that you can't pass a net_page
to a slab function, or vice versa.

This is a lot more churn, and I'm far from convinced that it's worth
doing.  There's also the tricky "This page is mappable to userspace"
kind of functions, which (for example) includes vmalloc and net_page
as well as folios and random driver allocations, but shouldn't include
slab or page table pages.  They're especially tricky because mapping to
userspace comes with rules around the use of the ->mapping field as well
as ->_mapcount.
