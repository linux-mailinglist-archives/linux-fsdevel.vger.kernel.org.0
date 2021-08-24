Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1392C3F6A0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhHXTpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhHXTpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:45:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C193C061757;
        Tue, 24 Aug 2021 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wL9XExZZG1TjksJGBynBNCX9BmWUtYjN+lbigwmHn0M=; b=ctfpWYct8aBG8uE1bVigySp0tj
        a/BQYXNynG1K0N5Ig16VGjwpoqmfbn60XxsV6i9qkXUbt9OCb/hM9vBHjG1y9P9150xXKupNh8UZ3
        M9rxGEMJtLNPG1JLtra6dG80IK2peqsS+W5fnnre+Y51Qsa9EiUjSo/uuTxtzEQGFJmxiQRbX6TD1
        jaBeHeqE/UasCU9/KYYu2nUuHtZZYV57sjDdVf7daHTHEJFCl7yLFMTUZqJUtZ3Nxs1Z1lSBSqIIJ
        R/mO3BccSg29FAFlPeQVvjEAEOB70kDdQyCweZMHpshHg48qJDmR2+gey5eZlKw23Kodtqy8t+Xwj
        8X161GaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIcL3-00BUm5-GQ; Tue, 24 Aug 2021 19:44:14 +0000
Date:   Tue, 24 Aug 2021 20:44:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSVMAS2pQVq+xma7@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 02:32:56PM -0400, Johannes Weiner wrote:
> The folio doc says "It is at least as large as %PAGE_SIZE";
> folio_order() says "A folio is composed of 2^order pages";
> page_folio(), folio_pfn(), folio_nr_pages all encode a N:1
> relationship. And yes, the name implies it too.
> 
> This is in direct conflict with what I'm talking about, where base
> page granularity could become coarser than file cache granularity.

That doesn't make any sense.  A page is the fundamental unit of the
mm.  Why would we want to increase the granularity of page allocation
and not increase the granularity of the file cache?

> Are we going to bump struct page to 2M soon? I don't know. Here is
> what I do know about 4k pages, though:
> 
> - It's a lot of transactional overhead to manage tens of gigs of
>   memory in 4k pages. We're reclaiming, paging and swapping more than
>   ever before in our DCs, because flash provides in abundance the
>   low-latency IOPS required for that, and parking cold/warm workload
>   memory on cheap flash saves expensive RAM. But we're continously
>   scanning thousands of pages per second to do this. There was also
>   the RWF_UNCACHED thread around reclaim CPU overhead at the higher
>   end of buffered IO rates. There is the fact that we have a pending
>   proposal from Google to replace rmap because it's too CPU-intense
>   when paging into compressed memory pools.

This seems like an argument for folios, not against them.  If user
memory (both anon and file) is being allocated in larger chunks, there
are fewer pages to scan, less book-keeping to do, and all you're paying
for that is I/O bandwidth.

> - It's a lot of internal fragmentation. Compaction is becoming the
>   default method for allocating the majority of memory in our
>   servers. This is a latency concern during page faults, and a
>   predictability concern when we defer it to khugepaged collapsing.

Again, the more memory that we allocate in higher-order chunks, the
better this situation becomes.

> - struct page is statically eating gigs of expensive memory on every
>   single machine, when only some of our workloads would require this
>   level of granularity for some of their memory. And that's *after*
>   we're fighting over every bit in that structure.

That, folios does not help with.  I have post-folio ideas about how
to address that, but I can't realistically start working on them
until folios are upstream.
