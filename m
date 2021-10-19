Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42BE433D93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhJSRin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhJSRim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:38:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC62C06161C;
        Tue, 19 Oct 2021 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iGktxexAEoG0emyXHElZXYDAND8qNTZfv5O/CYCJ99M=; b=reoRGClF8bgKnA4JfMds3a3Hk4
        F2Pw57daKcHkrJC/utVAOKj6/ffru3WejLS70ia63Jc/XgzvNRRt+3+BS2w7EykDmIAmURAP7ZRxf
        2sshYFfVypDem9ztYzNIcuQNOPGY9GTZOMwe3ygpfxPUJbu37K9g19kEcM9zerZFrC3VZRy4x4QJ/
        SzmwRdqlJSegU6xWF5+d1GcBbOiqy89AZzMV71fIHRkhk0eT2DKXyGYD8p4L6p72bWL6oHZqDSa+B
        F8fDo+8rTMjZHAaBJUqnpKvkTwYmKt3a3lukma9ymwlIa3Oh/tDk+gdIc7tMt+rjKAycjHsTtuoTD
        +PKI2Rww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mct0F-00BtoI-SE; Tue, 19 Oct 2021 17:34:34 +0000
Date:   Tue, 19 Oct 2021 18:34:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
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
Message-ID: <YW8Bm77gZgVG2ga4@casper.infradead.org>
References: <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW25EDqynlKU14hx@moria.home.lan>
 <YW3dByBWM0dSRw/X@cmpxchg.org>
 <YW7uN2p8CihCDsln@moria.home.lan>
 <20211019170603.GA15424@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019170603.GA15424@hsiangkao-HP-ZHAN-66-Pro-G1>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 01:06:04AM +0800, Gao Xiang wrote:
> On Tue, Oct 19, 2021 at 12:11:35PM -0400, Kent Overstreet wrote:
> > Other things that need to be fixed:
> > 
> >  - page->lru is used by the old .readpages interface for the list of pages we're
> >    doing reads to; Matthew converted most filesystems to his new and improved
> >    .readahead which thankfully no longer uses page->lru, but there's still a few
> >    filesystems that need to be converted - it looks like cifs and erofs, not
> >    sure what's going on with fs/cachefiles/. We need help from the maintainers
> >    of those filesystems to get that conversion done, this is holding up future
> >    cleanups.
> 
> The reason why using page->lru for non-LRU pages was just because the
> page struct is already there and it's an effective way to organize
> variable temporary pages without any extra memory overhead other than
> page structure itself. Another benefits is that such non-LRU pages can
> be immediately picked from the list and added into page cache without
> any pain (thus ->lru can be reused for real lru usage).
> 
> In order to maximize the performance (so that pages can be shared in
> the same read request flexibly without extra overhead rather than
> memory allocation/free from/to the buddy allocator) and minimise extra
> footprint, this way was used. I'm pretty fine to transfer into some
> other way instead if some similar field can be used in this way.
> 
> Yet if no such field anymore, I'm also very glad to write a patch to
> get rid of such usage, but I wish it could be merged _only_ with the
> real final transformation together otherwise it still takes the extra
> memory of the old page structure and sacrifices the overall performance
> to end users (..thus has no benefits at all.)

I haven't dived in to clean up erofs because I don't have a way to test
it, and I haven't taken the time to understand exactly what it's doing.

The old ->readpages interface gave you pages linked together on ->lru
and this code seems to have been written in that era, when you would
add pages to the page cache yourself.

In the new scheme, the pages get added to the page cache for you, and
then you take care of filling them (and marking them uptodate if the
read succeeds).  There's now readahead_expand() which you can call to add
extra pages to the cache if the readahead request isn't compressed-block
aligned.  Of course, it may not succeed if we're out of memory or there
were already pages in the cache.

It looks like this will be quite a large change to how erofs handles
compressed blocks, but if you're open to taking this on, I'd be very happy.
