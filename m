Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9206A42FFE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Oct 2021 05:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbhJPDbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 23:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243566AbhJPDbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FEDC061570;
        Fri, 15 Oct 2021 20:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p9VpDiEUrsFV9wAfqCcRkrtUgE7eJEP8LO7f/FcU5gQ=; b=cuU4t3Z5hNPZpQuvb6l3XjExqV
        xf2Q2qb+xTFnAnQBCAKu0/My3ySZhqZTEm6iDKqcKG+GlCujIQgcig5itXgclG4J0ffN4nmwBdf1P
        MgIcpG1+bpfeP/xkr9e/CJaICX6Q7crIelLnsS05H/V3Bc8oe8E6JcWRtXFRYbahM4J+cmVEjhQO+
        nFokyJ4aRTprwaWxN7REqT1zsGCKoxVHBh8DRHJ5ncUBI8V73W9moM0pmWdI3YEcqVPIwOcGkhARt
        Knbv57UoZyGsGaHPIAT5EW/Z7ft1pOl7Isg7SuMKBK8FBDFELP7YioCws2F/PrlBOn++yiPkEI3iz
        EVXEEadg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbaMx-009SD8-SF; Sat, 16 Oct 2021 03:28:30 +0000
Date:   Sat, 16 Oct 2021 04:28:23 +0100
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
Message-ID: <YWpG1xlPbm7Jpf2b@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUtHCle/giwHvLN1@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 11:08:58AM -0400, Johannes Weiner wrote:
>       mm/memcg: Add folio_memcg() and related functions
>       mm/memcg: Convert commit_charge() to take a folio
>       mm/memcg: Convert mem_cgroup_charge() to take a folio
>       mm/memcg: Convert uncharge_page() to uncharge_folio()
>       mm/memcg: Convert mem_cgroup_uncharge() to take a folio
>       mm/memcg: Convert mem_cgroup_migrate() to take folios
>       mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to folio
>       mm/memcg: Add folio_memcg_lock() and folio_memcg_unlock()
>       mm/memcg: Convert mem_cgroup_move_account() to use a folio
>       mm/memcg: Add folio_lruvec()
>       mm/memcg: Add folio_lruvec_lock() and similar functions
>       mm/memcg: Add folio_lruvec_relock_irq() and folio_lruvec_relock_irqsave()
>       mm/workingset: Convert workingset_activation to take a folio	
> 
> 		This is all anon+file stuff, not needed for filesystem
> 		folios.

No, that's not true.  A number of these functions are called from
filesystem code.  mem_cgroup_track_foreign_dirty() is only
called from filesystem code.  We at the very least need wrappers
like folio_cgroup_charge(), and folio_memcg_lock().

> 		As per the other email, no conceptual entry point for
> 		tail pages into either subsystem, so no ambiguity
> 		around the necessity of any compound_head() calls,
> 		directly or indirectly. It's easy to rule out
> 		wholesale, so there is no justification for
> 		incrementally annotating every single use of the page.

The justification is that we can remove all those hidden calls to
compound_head().  Hundreds of bytes of text spread throughout this file.

>       mm: Add folio_young and folio_idle
>       mm/swap: Add folio_activate()
>       mm/swap: Add folio_mark_accessed()
> 
> 		This is anon+file aging stuff, not needed.

Again, very much needed.  Take a look at pagecache_get_page().  In Linus'
tree today, it calls if (page_is_idle(page)) clear_page_idle(page);
So either we need wrappers (which are needlessly complicated thanks to
how page_is_idle() is defined) or we just convert it.

>       mm/rmap: Add folio_mkclean()
> 
>       mm/migrate: Add folio_migrate_mapping()
>       mm/migrate: Add folio_migrate_flags()
>       mm/migrate: Add folio_migrate_copy()
> 
> 		More anon+file conversion, not needed.

As far as I can tell, anon never calls any of these three functions.
anon calls migrate_page(), which calls migrate_page_move_mapping(),
but several filesystems do call these individual functions.

>       mm/lru: Add folio_add_lru()
> 
> 		LRU code, not needed.

Again, we need folio_add_lru() for filemap.  This one's more
tractable as a wrapper function.

