Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432413E9319
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 15:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhHKN4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhHKN4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:56:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA349C061765;
        Wed, 11 Aug 2021 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MT3bL/CGD5B/Mm/makQi9BAHexMScUACD6ZuAagwh7I=; b=dsk5YLcRQvQjKLveuI97OFEV5C
        5iHj/ZAa2Qn6pC0YvZ4R+Escf+J/8G3CXvbNAkxbYKTshfVtUQg/OXkpMuuvq9bMYaO7YE0XVDKLG
        5Ht5LRawTbVOu1j3kBnJs7cVBL0YpO01cVqPB51LVRe21KkknEQOOe/e4v+hz9yMfMDeJ8C+MDPZ1
        e50K6vdO5mHWeVtqw7H34/XgBN3dALZAZ6J0+s0SDCzVEamzQI3FLa3YR9CoYOO6JpNpdw+lHVgok
        VJaTKyaFDg+2j5R+p3wEbnX3jlPYayQgFuV1I56l57CxC71uNSKbH0uIB6bhI2T7FhD/MLMTzsi+f
        yoXH1PHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDogz-00DTvn-6N; Wed, 11 Aug 2021 13:55:02 +0000
Date:   Wed, 11 Aug 2021 14:54:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] netfs, afs, ceph: Use folios
Message-ID: <YRPWqRVfRLtY7CyF@casper.infradead.org>
References: <2408234.1628687271@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2408234.1628687271@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 02:07:51PM +0100, David Howells wrote:
> Convert the netfs helper library and the afs filesystem to use folios.
> 
> NOTE: This patch will also need to alter the ceph filesystem, but as that's
> not been done that yet, ceph will fail to build.
> 
> The patch makes two alterations to the mm headers:
> 
>  (1) Fix a bug in readahead_folio() where a NULL return from
>      __readahead_folio() will cause folio_put() to oops.

I'll fold that in.

>  (2) Add folio_change_private() to change the private data on the folio
>      without adjusting the page refcount or changing the flag.  This
>      assumes folio_attach_private() was already called.

Makes sense.

>  (*) Should I be using page_mapping() or page_file_mapping()?

Depends if you can have a swapfile on your filesystem.  I'd like to
get rid of this and only use the directIO path for swap, but that's a
far-distant project.

>  (*) Can page_endio() be split into two separate functions, one for read
>      and one for write?  If seems a waste of time to conditionally switch
>      between two different branches.

So you'd like a folio_end_write() and folio_end_read()?

>  (*) Is there a better way to implement afs_kill_pages() and
>      afs_redirty_pages()?  I was previously using find_get_pages_contig()
>      into a pagevec, but that doesn't look like it'll work with folios, so
>      I'm now calling filemap_get_folio() a lot more - not that it matters
>      so much, as these are failure paths.

I always disliked the _contig variants.  Block filesystems tend to
follow the pattern

	for-each-page-in-range
		if page-is-contig-with-prev
			append-to-bio
		else
			start-new-bio

while network filesystems tend to use the pattern

	for-range
		get-a-batch-of-contig-pages
			submit-an-io-using-these-pages

it'd be nice to follow the same pattern for both.  Would reduce the
amount of duplicated infrastructure.

>      Also, should these be moved into generic code?

I'd have to figure out what they do to answer this question.

>  (*) Can ->page_mkwrite() see which subpage of a folio got hit?

It already does -- you're passed a page, not a folio.  Are you trying
to optimise by only marking part of a folio as dirty?  If so, that's a
bad idea because we're going to want to, eg, map 64KB chunks of a folio
with a single TLB entry on ARM, so you'll only get one notification for
that page.

>  (*) __filemap_get_folio() should be used instead of
>      grab_cache_page_write_begin()?  What should be done if xa_is_value()
>      returns true on the value returned by that?

If you don't pass FGP_ENTRY, it won't return you an xa_is_value() ...

