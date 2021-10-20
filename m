Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA7435148
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 19:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhJTRbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhJTRbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:31:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6780AC06161C;
        Wed, 20 Oct 2021 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2j0OkvRwF5BVDtZ9M6bIK+b+BCFxIxg1XmoiRh7ewBA=; b=ua/XQ9oU8XbbXQIXxSprskj1uQ
        gyN/V4q80GLHf6RXs3osc2ii3oplGC5gcj7/CNFCrbVc65tKzQ7lC5vRwnxBlVgfxZBC2Q7adlTqp
        9k/YlzgpjoR2obS6HeHNz2F4osZIBhx3hlEo7g7aKMcD2q5GChO6O0z9hVsR+1LdEe5G+HIkUjCMZ
        5d9twredgZVF2pwB5Rj9hprVgBUkTaCd8ZzMFSZENLmWD4UXBO8Nk0uVYqbpHq/Ro+cQLirvUQ9Ev
        /43jtLS1vXu0/ZVbxwsTup/iYlYCVK+QMi6+sN9zmQL2boAttS69mNgq3bfiiP8v1me3ZTv8mIG+r
        CRt2nnLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdFM6-00Cj4B-04; Wed, 20 Oct 2021 17:26:49 +0000
Date:   Wed, 20 Oct 2021 18:26:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXBRPSjPUYnoQU+M@casper.infradead.org>
References: <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
 <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:50:58AM +0200, David Hildenbrand wrote:
> For the records: I was happy to see the slab refactoring, although I
> raised some points regarding how to access properties that belong into
> the "struct page".

I thought the slab discussion was quite productive.  Unfortunately,
none of our six (!) slab maintainers had anything to say about it.  So I
think it's pointless to proceed unless one of them weighs in and says
"I'd be interested in merging something along these lines once these
problems are addressed".

> As raised elsewhere, I'd also be more comfortable
> seeing small incremental changes/cleanups that are consistent even
> without having decided on an ultimate end-goal -- this includes folios.
> I'd be happy to see file-backed THP gaining their own, dedicated type
> first ("struct $whatever"), before generalizing it to folios.

I am genuinely confused by this.

Folios are non-tail pages.  That's all.  There's no "ultimate end-goal".
It's just a new type that lets the compiler (and humans!) know that this
isn't a tail page.

Some people want to take this further, and split off special types from
struct page.  I think that's a great idea.  I'm even willing to help.
But there are all kinds of places in the kernel where we handle generic
pages of almost any type, and so regardless of how much we end up
splitting off from struct page, we're still going to want the concept
of folio.

I get that in some parts of the MM, we can just assume that any struct
page is a non-tail page.  But that's not the case in the filemap APIs;
they're pretty much all defined to return the precise page which contains
the specific byte.  I think that's a mistake, and I'm working to fix it.
But until it is all fixed [1], having a type which says "this is not a
tail page" is, frankly, essential.

[1] which is a gargantuan job because I'm not just dealing with
mm/filemap.c, but also with ~90 filesystems and things sufficiently like
filesystems to have an address_space_operations of their own, including
graphics drivers.
