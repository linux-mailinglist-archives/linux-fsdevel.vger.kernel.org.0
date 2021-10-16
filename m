Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09CC43046E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Oct 2021 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbhJPTKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Oct 2021 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhJPTKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:10:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDFC061765;
        Sat, 16 Oct 2021 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YhoZ9iqL7Lt/48xizN3kGQkUKxxKpNWaP56fG+nsLtw=; b=BTa3EpFZlDI9sQ/CGo27JdqpF1
        zea4OMDz9wdbs9X9mVE4QLL98dKW7zwqVGoola+MsuQ6loexIWIr2vwszhQ+xXMepJafgIofVC4Wm
        XU9hch2D/PZigjKg/5WZmPn1fJXzgN3wPihZU7PTjKmRftbP05X3VJnq5KIP+1g7+O7Dtw/Tt7vjO
        bZX4kB4UNeDTt9sVG8/5YH33YZjCIiiTaQbDc8C5xYNKjac+cbe4uvkJ/tPQDLuFPCA6pm5ICEHmN
        X4hzdX17Q0a/TE87F4fdVRaaSv+xHD7as2g/wqDmzw01C3K/TlwPT9IKivuouEeTn9y/ljEnln2RI
        WQbXp/Jg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbp1w-009qFq-NC; Sat, 16 Oct 2021 19:07:46 +0000
Date:   Sat, 16 Oct 2021 20:07:40 +0100
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
Message-ID: <YWsi/ERcQzY765xj@casper.infradead.org>
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
>       mm/lru: Add folio LRU functions
> 
> 		The LRU code is used by anon and file and not needed
> 		for the filesystem API.
> 
> 		And as discussed, there is generally no ambiguity of
> 		tail pages on the LRU list.

One of the assumptions you're making is that the current code is suitable
for folios.  One of the things that happens in this patch is:

-       update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
+       update_lru_size(lruvec, lru, folio_zonenum(folio),
+                       folio_nr_pages(folio));

static inline long folio_nr_pages(struct folio *folio)
{
        return compound_nr(&folio->page);
}

vs

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
static inline int thp_nr_pages(struct page *page)
{
        VM_BUG_ON_PGFLAGS(PageTail(page), page);
        if (PageHead(page))
                return HPAGE_PMD_NR;
        return 1;
}
#else
static inline int thp_nr_pages(struct page *page)
{
        VM_BUG_ON_PGFLAGS(PageTail(page), page);
        return 1;
}
#endif

So if you want to leave all the LRU code using pages, all the uses of
thp_nr_pages() need to be converted to compound_nr().  Or maybe not all
of them; I don't know which ones might be safe to leave as thp_nr_pages().
That's one of the reasons I went with a whitelist approach.
