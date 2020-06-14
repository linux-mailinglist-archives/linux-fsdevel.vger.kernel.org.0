Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8F1F89A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jun 2020 18:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgFNQ04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgFNQ0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 12:26:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F57EC05BD43;
        Sun, 14 Jun 2020 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FBrl4ugPRoXqesloMxkA/RUdd2QTtkIhYi/oDtcA+pI=; b=BFZhmc9kch9DtqFlRZY6kAVze0
        ptdNqXcCHmIzUSLc7FZSe4umBFI8Pt6SiK3Q6nFOXMw5x/CQJYpkQemlzbaf4uFbEMtB9HzpGd2rM
        208bESHaF40xc/6lK0r8OXHZ2fUEjpNfsUnhSHqF8S8VX1tbIkM8ebmCjPeOyVVYtqRYwhb2GkXcU
        tbOe0xlNP2sYNXvCqhw//9pV0RJutqE8P0syXpHyw5+fCvpKNr7pFem9UKv4/7DkKpbR0LL0pJmxk
        SXFMDkCTnn3NXkXNLtSxRyCQCvj+tPBjXiFZPW9ABI9CMbRFgSbDjdu6YIqzc8bpTKZF4hbuCejXk
        NpWMhZBA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkVT8-0002sm-R5; Sun, 14 Jun 2020 16:26:50 +0000
Date:   Sun, 14 Jun 2020 09:26:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC v6 00/51] Large pages in the page cache
Message-ID: <20200614162650.GP8681@bombadil.infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:12:54PM -0700, Matthew Wilcox wrote:
> Another fortnight, another dump of my current large pages work.

The generic/127 test has pointed out to me that range writeback is
broken by this patchset.  Here's how (may not be exactly what's going on,
but it's close):

page cache allocates an order-2 page covering indices 40-43.
bytes are written, page is dirtied
test then calls fallocate(FALLOC_FL_COLLAPSE_RANGE) for a range which
starts in page 41.
XFS calls filemap_write_and_wait_range() which calls
__filemap_fdatawrite_range() which calls
do_writepages() which calls
iomap_writepages() which calls
write_cache_pages() which calls
tag_pages_for_writeback() which calls
xas_for_each_marked() starting at page 41.  Which doesn't find page
  41 because when we dirtied pages 40-43, we only marked index 40 as
  being dirty.

Annoyingly, the XArray actually handles this just fine ... if we were
using multi-order entries, we'd find it.  But we're still storing 2^N
entries for an order N page.

I can see two ways to fix this.  One is to bite the bullet and do the
conversion of the page cache to use multi-order entries.  The second
is to set and clear the marks on all entries.  I'm concerned about the
performance of the latter solution.  Not so bad for order-2 pages, but for
an order-9 page we have 520 bits to set, spread over 9 non-consecutive
cachelines.  Also, I'm unenthusiastic about writing code that I want to
throw away as quickly as possible.

So unless somebody has a really good alternative idea, I'm going to
convert the page cache over to multi-order entries.  This will have
several positive effects:

 - Get DAX and regular page cache using the xarray in a more similar way
 - Saves about 4.5kB of memory for every 2MB page in tmpfs/shmem
 - Prep work for converting hugetlbfs to use the page cache the same
   way as tmpfs
