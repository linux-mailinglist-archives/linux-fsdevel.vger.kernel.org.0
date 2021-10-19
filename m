Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF0433DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhJSR4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234939AbhJSR4q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5328860F57;
        Tue, 19 Oct 2021 17:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634666073;
        bh=0lmHBiMAYwQI6ZLGGLhhIuhQ0S+abmoZURDHJhYO9DE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxBiacY1zC4MphhR5iKglY+9y5xo38OaiVqWRhG40SjtxcNvYiFUV52YxQ20WiKeU
         wjhebfLkt4veySjZg7gP3hEJsJtsCymcp1asP5F8l2sHwCHMOoS0pHok8lD51j5pYE
         U1aB58E8NZtIwCOPQWtnGKgLBb9+ajDlzgucylgz0BkBgn/K/+L/5GSe+Oi/ITmkNf
         FLrQ7hD62IYXvvi++fBwsTfoKBoJNQW6Yy8JXg9M9LSRRdTS5tUPC20hx8250NeTNV
         4MNuv/iD4bq4vSZ3ZD2op3k61ZVbgWIdaq4ip/tI0orZDJZ9GgfdVWWTVT3fDhL9UI
         20j8dCjUWZmTA==
Date:   Wed, 20 Oct 2021 01:54:20 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Splitting struct page into multiple types - Was: re: Folio
 discussion recap -
Message-ID: <20211019175419.GA22532@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW25EDqynlKU14hx@moria.home.lan>
 <YW3dByBWM0dSRw/X@cmpxchg.org>
 <YW7uN2p8CihCDsln@moria.home.lan>
 <20211019170603.GA15424@hsiangkao-HP-ZHAN-66-Pro-G1>
 <YW8Bm77gZgVG2ga4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW8Bm77gZgVG2ga4@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Tue, Oct 19, 2021 at 06:34:19PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 20, 2021 at 01:06:04AM +0800, Gao Xiang wrote:
> > On Tue, Oct 19, 2021 at 12:11:35PM -0400, Kent Overstreet wrote:
> > > Other things that need to be fixed:
> > > 
> > >  - page->lru is used by the old .readpages interface for the list of pages we're
> > >    doing reads to; Matthew converted most filesystems to his new and improved
> > >    .readahead which thankfully no longer uses page->lru, but there's still a few
> > >    filesystems that need to be converted - it looks like cifs and erofs, not
> > >    sure what's going on with fs/cachefiles/. We need help from the maintainers
> > >    of those filesystems to get that conversion done, this is holding up future
> > >    cleanups.
> > 
> > The reason why using page->lru for non-LRU pages was just because the
> > page struct is already there and it's an effective way to organize
> > variable temporary pages without any extra memory overhead other than
> > page structure itself. Another benefits is that such non-LRU pages can
> > be immediately picked from the list and added into page cache without
> > any pain (thus ->lru can be reused for real lru usage).
> > 
> > In order to maximize the performance (so that pages can be shared in
> > the same read request flexibly without extra overhead rather than
> > memory allocation/free from/to the buddy allocator) and minimise extra
> > footprint, this way was used. I'm pretty fine to transfer into some
> > other way instead if some similar field can be used in this way.
> > 
> > Yet if no such field anymore, I'm also very glad to write a patch to
> > get rid of such usage, but I wish it could be merged _only_ with the
> > real final transformation together otherwise it still takes the extra
> > memory of the old page structure and sacrifices the overall performance
> > to end users (..thus has no benefits at all.)
> 
> I haven't dived in to clean up erofs because I don't have a way to test
> it, and I haven't taken the time to understand exactly what it's doing.

Actually I don't think it's an actual clean up due to the current page
structure design.

> 
> The old ->readpages interface gave you pages linked together on ->lru
> and this code seems to have been written in that era, when you would
> add pages to the page cache yourself.
> 
> In the new scheme, the pages get added to the page cache for you, and
> then you take care of filling them (and marking them uptodate if the
> read succeeds).  There's now readahead_expand() which you can call to add
> extra pages to the cache if the readahead request isn't compressed-block
> aligned.  Of course, it may not succeed if we're out of memory or there
> were already pages in the cache.

Hmmm, these temporary pages in the list may be (re)used later for page
cache,

or just used for temporary compressed pages for some I/O or lz4
decompression buffer (technically called lz77 sliding window) to
temporarily contain some decompressed data in the same read request
(due to some pages are already mapped and we cannot expose the
decompression process to userspace or some other reasons). All are
in the recycle way.

These temporary pages may finally go into some file page cache or
recycle for several temporary uses for many time and finally free to
the buddy allocator.

> 
> It looks like this will be quite a large change to how erofs handles
> compressed blocks, but if you're open to taking this on, I'd be very happy.

For ->lru, it's quite small, but it sacrifices the performance. Yet I'm
very glad to do if some decision of this ->lru field is determined.

Thanks,
Gao Xiang
