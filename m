Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E424445EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 17:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhKCQcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhKCQcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:32:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5162C061714;
        Wed,  3 Nov 2021 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cj3Ogsyg3Lz2VHkzTH5tWxtqDLyQrRH//9PvxlJINbM=; b=fzyxYkOmFPj5mYRu0/Oue66U8S
        mc6O0rW/kmK4juSuHAU3CVAQPNMgm/sfRYX1W3hu9MEF0wdRYKKU+fMwrX6m5CqZ5H9YIcVCkfcsG
        tYwUkAuyvHDFBxme5tS/H3+Es/qGwxYcpTd7gwU2WwiYAM9FbeA1misue+ng5vVHMjNcJYibRS6HE
        WIkIM4l8gezYIUYMFZGIcCXKadJJeAR4yJaMhMtwUkrY1uGtwpY6b8RSwIvBFDPLB0QRcCKqv77Tc
        OmzJM6qWyh30kQ5HqTByWvac7h2bKmAEP9UdCHaANqqkbZa1njQxffyq02IGVOdug+WDpHrY1jdQV
        lT9xVz4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miJ6W-005Jo8-KL; Wed, 03 Nov 2021 16:27:44 +0000
Date:   Wed, 3 Nov 2021 16:27:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] netfs, 9p, afs, ceph: Use folios
Message-ID: <YYK4YKCnDyoJx5eW@casper.infradead.org>
References: <YYKa3bfQZxK5/wDN@casper.infradead.org>
 <163584174921.4023316.8927114426959755223.stgit@warthog.procyon.org.uk>
 <163584187452.4023316.500389675405550116.stgit@warthog.procyon.org.uk>
 <1038257.1635951492@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038257.1635951492@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 02:58:12PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > +	len = (size >= start + gran) ? gran : size - start;
> > 
> > This seems like the most complicated way to write this ... how about:
> > 
> >         size_t len = min_t(loff_t, isize - start, folio_size(folio));
> 
> I was trying to hedge against isize-start going negative.  Can this code race
> against truncate?  truncate_setsize() changes i_size *before* invalidating the
> pages.

We should check for isize < start separately, and skip the writeback
entirely.

> > >  static int afs_symlink_readpage(struct file *file, struct page *page)
> > >  {
> > > -	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
> > > +	struct afs_vnode *vnode = AFS_FS_I(page_mapping(page)->host);
> > 
> > How does swap end up calling readpage on a symlink?
> 
> Um - readpage is called to read the symlink.

But the only reason to use page_mapping() instead of page->mapping
is if you don't know that the page is in the page cache.  You know
that here, so I don't understand why you changed it.

> > > -	page_endio(page, false, ret);
> > > +	page_endio(&folio->page, false, ret);
> > 
> > We need a folio_endio() ...
> 
> I think we mentioned this before and I think you said you had or would make a
> patch for it.  I can just create a wrapper for it if that'll do.

Probably better to convert it and put a page_endio wrapper in
folio-compat.c
