Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C2933DD84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbhCPT3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:29:12 -0400
Received: from casper.infradead.org ([90.155.50.34]:59198 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbhCPT2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:28:32 -0400
X-Greylist: delayed 1253 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 15:28:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a+0vOSKhaFyvZ89GWuo3huxCDtu4K+x/0Wx25fIk42U=; b=jt05dHVt86rt/fg//Nd6cO5DVR
        1G3IYjzp8NmtC3ioV47ZhvEwsVO11uGSJs4d6RoCIe/BcJ/xaLebCaSFyAaRPStsmz5aU3Z0/tTjC
        i2D7OiygMf3930tWOiLJfa4OdaVC2y2beYtlioE8Uk6T6FlNM29ZnQ8CELwXsvZbjeDKpcF11lhjh
        fxWoakrSFVJne6ZMS7JRWMDDO0gZO7qnjt44rLaOVOowDrCMDY6XwMEq7NZ3RYp/xCyc/iArZ07hH
        6dhLiP7mVnkIYcFu7Y/+Bu3gq9ijgn43hiplbkX3GbtJmVLUTJ4dq2oS7nwTEqPpCsU1+5QgJ/TDr
        8DraJk1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMF23-000UZR-6Y; Tue, 16 Mar 2021 19:07:08 +0000
Date:   Tue, 16 Mar 2021 19:07:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for
 PG_private_2/PG_fscache
Message-ID: <20210316190707.GD3420@casper.infradead.org>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
 <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:54:49PM +0000, David Howells wrote:
> Add a function, unlock_page_private_2(), to unlock PG_private_2 analogous
> to that of PG_lock.  Add a kerneldoc banner to that indicating the example
> usage case.

This isn't a problem with this patch per se, but I'm concerned about
private2 and expected page refcounts.

static inline int is_page_cache_freeable(struct page *page)
{
        /*
         * A freeable page cache page is referenced only by the caller
         * that isolated the page, the page cache and optional buffer
         * heads at page->private.
         */
        int page_cache_pins = thp_nr_pages(page);
        return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
}

static inline int page_has_private(struct page *page)
{
        return !!(page->flags & PAGE_FLAGS_PRIVATE);
}

#define PAGE_FLAGS_PRIVATE                              \
        (1UL << PG_private | 1UL << PG_private_2)

So ... a page with both flags cleared should have a refcount of N.
A page with one or both flags set should have a refcount of N+1.

How is a poor filesystem supposed to make that true?  Also btrfs has this
problem since it uses private_2 for its own purposes.

