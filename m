Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2033E1F7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 01:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbhHEXsh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 19:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhHEXsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:48:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8081C0613D5;
        Thu,  5 Aug 2021 16:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H3DXaH0DYq/AU+2Gphrkn9Lwf3WnAckLZe9TrSof2hk=; b=abtQMLOoZXkVPjuUhEHDqRyq8B
        KaXEaoLL1BbXX3emsso4LunhdcKMhxkxFYrvD42OWevUVXBkxay+rvTGncsdtcRnfeBGk8FEEJ82g
        7/1GwpkJ5N+N8oeYGnLfSHWILFgbWRZWolqBrSWognGRqvZRQXjAioMsIt7VqwR/5y0set0rb2Sl8
        h9eiGCC6w7qRlR//cfZPoHad3zUxLgvZHKF63EjM+zKlK/T0Bdbw8efLJ0qrWM7BwE0fJDaDjccp8
        JIHfTwF5MfItHb3bT+6SzPp1jD/VaVUH71EQLFXh7i5EzMqMKWZH/pY+tCRYFBtVdRh4Xsh6Krd+Y
        hXAscibg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBn5L-007d2p-Uz; Thu, 05 Aug 2021 23:47:39 +0000
Date:   Fri, 6 Aug 2021 00:47:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jeff Layton <jlayton@redhat.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Canvassing for network filesystem write size vs page size
Message-ID: <YQx4lx7vEbvmfBnE@casper.infradead.org>
References: <YQv+iwmhhZJ+/ndc@casper.infradead.org>
 <YQvpDP/tdkG4MMGs@casper.infradead.org>
 <YQvbiCubotHz6cN7@casper.infradead.org>
 <1017390.1628158757@warthog.procyon.org.uk>
 <1170464.1628168823@warthog.procyon.org.uk>
 <1186271.1628174281@warthog.procyon.org.uk>
 <1219713.1628181333@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1219713.1628181333@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 05, 2021 at 05:35:33PM +0100, David Howells wrote:
> With Willy's upcoming folio changes, from a filesystem point of view, we're
> going to be looking at folios instead of pages, where:
> 
>  - a folio is a contiguous collection of pages;
> 
>  - each page in the folio might be standard PAGE_SIZE page (4K or 64K, say) or
>    a huge pages (say 2M each);

This is not a great way to explain folios.

If you're familiar with compound pages, a folio is a new type for
either a base page or the head page of a compound page; nothing more
and nothing less.

If you're not familiar with compound pages, a folio contains 2^n
contiguous pages.  They are treated as a single unit.

>  - a folio has one dirty flag and one writeback flag that applies to all
>    constituent pages;
> 
>  - a complete folio currently is limited to PMD_SIZE or order 8, but could
>    theoretically go up to about 2GiB before various integer fields have to be
>    modified (not to mention the memory allocator).

Filesystems should not make an assumption about this ... I suspect
the optimum page size scales with I/O bandwidth; taking PCI bandwidth
as a reasonable proxy, it's doubled five times in twenty years.

> Willy is arguing that network filesystems should, except in certain very
> special situations (eg. O_SYNC), only write whole folios (limited to EOF).

I did also say that the write could be limited by, eg, a byte-range
lease on the file.  If the client doesn't have permission to write
a byte range, then it doesn't need to write it back.

