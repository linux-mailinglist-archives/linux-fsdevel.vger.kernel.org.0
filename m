Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A243C233A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhGIMEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 08:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGIMEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:04:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34213C0613DD;
        Fri,  9 Jul 2021 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V2q4GBgvapBkUtONrRhHvOxMo42HXY3kTYClqLepHos=; b=VDvt/2mc4DStW94xQ6Y3W7pIML
        DRDik9Avp8HHHpkHUuhgQfIBNddzWJRTnTgl2SifTdE4qDeSxy839guoFqJip+ry+EuCpMDCna0ri
        X2bk+VQkZqGm6jw1ccpUv7If27HUzqC5DwHOqFNs+hkVFeWYfTSYvJQi5OGUvCm81eizPV/OOsZiM
        3bQTWTdS3kOZ598HBDOO9boAyepwaBhdyiRcm7tb7SaKp0OnYlM4yLeRUT3CzVSvWERk5fERewVY4
        6N87j+Oqf0g7hlOyPQXVbU2JaAmtuSJamlow1dhUUvCwYuAj2MF1h6jhuNRAzG9uDOgjZmM2Y756x
        lVEeLRUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1pCR-00ETWy-P5; Fri, 09 Jul 2021 12:01:45 +0000
Date:   Fri, 9 Jul 2021 13:01:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: [PATCH v3 2/3] iomap: Don't create iomap_page objects for inline
 files
Message-ID: <YOg6p6zzGHdyiIvt@casper.infradead.org>
References: <20210707115524.2242151-1-agruenba@redhat.com>
 <20210707115524.2242151-3-agruenba@redhat.com>
 <YOW6Hz0/FgQkQDgm@casper.infradead.org>
 <20210709042737.GT11588@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709042737.GT11588@locust>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 08, 2021 at 09:27:37PM -0700, Darrick J. Wong wrote:
> On Wed, Jul 07, 2021 at 03:28:47PM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 07, 2021 at 01:55:23PM +0200, Andreas Gruenbacher wrote:
> > > @@ -252,6 +253,7 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > >  	}
> > >  
> > >  	/* zero post-eof blocks as the page may be mapped */
> > > +	iop = iomap_page_create(inode, page);
> > >  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> > >  	if (plen == 0)
> > >  		goto done;
> > 
> > I /think/ a subsequent patch would look like this:
> > 
> > +	/* No need to create an iop if the page is within an extent */
> > +	loff_t page_pos = page_offset(page);
> > +	if (pos > page_pos || pos + length < page_pos + page_size(page))
> > +		iop = iomap_page_create(inode, page);
> > 
> > but that might miss some other reasons to create an iop.
> 
> I was under the impression that for blksize<pagesize filesystems, the
> page always had to have an iop attached.  In principle I think you're
> right that we don't need one if all i_blocks_per_page blocks have the
> same uptodate state, but someone would have to perform a close reading
> of buffered-io.c to make it drop them when unnecessary and re-add them
> if it becomes necessary.  That might be more cycling through kmem_alloc
> than we like, but as I said, I have never studied this idea.

I wouldn't free them unnecessarily; that is, once we've determined that
we need an iop, we should just keep it, even once the entire page is
Uptodate (because we'll need it for write-out eventually anyway).

I haven't noticed any ill-effects from discarding iops while running
xfstests on the THP/multipage folio patches.  That will discard iops
when splitting a page (the page must be entirely uptodate at that point).
