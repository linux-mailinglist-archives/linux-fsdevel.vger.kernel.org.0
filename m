Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79D33A99AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 13:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhFPL6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 07:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhFPL6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:58:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934F6C061574;
        Wed, 16 Jun 2021 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LEmL4MSSLLtvQqDbYrGd3H53NXZmD7Wlx6AM9cvbcpU=; b=h8s3zdc7eSQiPnzQtyZNylnz1D
        0Vma+P3TwOJtBJOZiGzg3HdImCvFSQrq7Vf8CSzCzn3xcOsUCsapDWVA5Vpt/jYdnUrD/fKHXrXNd
        1Epo+9OOELohVvt6To/5C/WBaEyR9vxcwPVJZF1Ypzi8QpPEycEiwhNTTxJNfZiS4mLYI0RfjuBYS
        xHgd0xQb7QegpJbr744r5+fHH6EWa2MrslDYPISIboS7+VoyTvYjupQnF7OkLwL8rUq1ZKAHGu8dO
        3qBYaSktb3JGT0kyGVCovho3Yfc9E5liDxOxFSR7lTqtC0W3FFel48wVUeWvxVsLXkg4cAfwfnHCx
        irzQJ0iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltU8R-007zxo-9D; Wed, 16 Jun 2021 11:55:30 +0000
Date:   Wed, 16 Jun 2021 12:55:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 26/33] mm/writeback: Add folio_wait_writeback()
Message-ID: <YMnmm+fhICQONpWS@casper.infradead.org>
References: <20210614201435.1379188-27-willy@infradead.org>
 <20210614201435.1379188-1-willy@infradead.org>
 <815893.1623839446@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815893.1623839446@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:30:46AM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > +	struct page *page = &folio->page;
> 
> Isn't that a layering violation?  Should it be something like:
> 
> 	struct page *page = folio_head();
> 
> or:
> 
> 	struct page *page = folio_subpage(0);

It's not a layering violation, but it is bad style.  It indicates the
function is incompletely converted to folios and probably isn't actually
folio-safe.  After about a dozen more commits, it's possible to finish
the conversion in afs_page_mkwrite(), and I do so here:

https://git.infradead.org/users/willy/pagecache.git/commitdiff/f49f546f4ad83c8a6fec861af5f9d0825b850abc

It's still not 100% clean as afs_page_dirty() expects a head|base page
instead of a folio, so there's more cleanup required.  Also
trace_afs_page_dirty() continues to take a page instead of a folio,
but that tends to not actually be a problem.
