Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE3254C05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgH0RVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 13:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgH0RVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:21:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B7C061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yAcdCaR4JtnyMSP1+omTdGadAFV5/wzbhwaSvHx/b1o=; b=iV1v9Sms+Ds4vHaT8uyJXGgmIZ
        778Mnnrk87Tf0C1VumhOAhAtlnj4VVRvrdbB0DsWGQ7/r8HiDiAOczy8oWZ/3vOmoQWfH+ItAqS9l
        0bsRhAKIyh6fGJ+YWdpfPtGmwZsYQnP1PZVZFc8m6MHfYayBRLrWsnT0k65aDCmFFpk2XnmNBJWPQ
        OuRdSuwR2aOJBC94AWLVBSDCILRxFPokAhWRFs3ASsOMtCg3bbCtPJGSE7LVqqLSSAQVkHFjbqeRT
        ffxZ5SxJMv4ZnuRipeSPU/wpE0RUigIR4gBt1msdiUS++ZhTMO2/bn8gGELHNgwPymXyOD7574Q90
        RcNZ/gDg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBLab-0005qs-T1; Thu, 27 Aug 2020 17:21:29 +0000
Date:   Thu, 27 Aug 2020 18:21:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Mike Marshall <hubcap@omnibond.com>
Subject: Re: The future of readahead
Message-ID: <20200827172129.GL14765@casper.infradead.org>
References: <20200826193116.GU17456@casper.infradead.org>
 <1441311.1598547738@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1441311.1598547738@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 06:02:18PM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> > void readahead_expand(struct readahead_control *rac, loff_t start, u64 len);
> > or possibly
> > void readahead_expand(struct readahead_control *rac, pgoff_t start,
> > 		unsigned int count);
> > 
> > It might not actually expand the readahead attempt at all -- for example,
> > if there's already a page in the page cache, or if it can't allocate
> > memory.  But this puts the responsibility for allocating pages in the VFS,
> > where it belongs.
> 
> This is exactly what the fscache read helper in my fscache rewrite is doing,
> except that I'm doing it in fs/fscache/read_helper.c.
> 
> Have a look here:
> 
> 	https://lore.kernel.org/linux-fsdevel/159465810864.1376674.10267227421160756746.stgit@warthog.procyon.org.uk/
> 
> and look for the fscache_read_helper() function.
> 
> Note that it's slighly complicated because it handles ->readpage(),
> ->readpages() and ->write_begin()[*].
> 
> [*] I want to be able to bring the granule into the cache for modification.
>     Ideally I'd be able to see that the entire granule is going to get written
>     over and skip - kind of like write_begin for a whole granule rather than a
>     page.

I'm going to want something like that for THP too.  I may end up
changing the write_begin API.

> Shaping the readahead request has the following issues:
> 
>  (1) The request may span multiple granules.
> 
>  (2) Those granules may be a mixture of cached and uncached.
> 
>  (3) The granule size may vary.
> 
>  (4) Granules fall on power-of-2 boundaries (for example 256K boundaries)
>      within the file, but the request may not start on a boundary and may not
>      end on one.
> 
> To deal with this, fscache_read_helper() calls out to the cache backend
> (fscache_shape_request()) and the netfs (req->ops->reshape()) to adjust the
> read it's going to make.  Shaping the request may mean moving the start
> earlier as well as expanding or contracting the size.  The only thing that's
> guaranteed is that the first page of the request will be retained.

Thank you for illustrating why this shouldn't be handled in the
filesystem ;-)

mmap readaround starts n/2 pages below the the faulting page and ends n/2
pages above the faulting page.  So if your adjustment fails to actually
bring in the page in the middel, it has failed mmap.

> What I was originally envisioning for the new ->readahead() interface is add a
> second aop that allows the shaping to be accessed by the VM, before it's
> started pinning any pages.
> 
> The shaping parameters I think we need are:
> 
> 	- The inode, for i_size and fscache cookie
> 	- The proposed page range
> 
> and what you would get back could be:
> 
> 	- Shaped page range
> 	- Minimum I/O granularity[1]
> 	- Minimum preferred granularity[2]
> 	- Flag indicating if the pages can just be zero-filled[3]
> 
> [1] The filesystem doesn't want to read in smaller chunks than this.
> 
> [2] The cache doesn't want to read in smaller chunks than this, though in the
>     cache's case, a partially read block is just abandoned for the moment.
>     This number would allow the readahead algorithm to shorten the request if
>     it can't allocate a page.
> 
> [3] If I know that the local i_size is much bigger than the i_size on the
>     server, there's no need to download/read those pages and readahead can
>     just clear them.  This is more applicable to write_begin() normally.
> 
> Now a chunk of this is in struct readahead_control, so it might be reasonable
> to add the other bits there too.
> 
> Note that one thing I really would like to avoid having to do is to expand a
> request forward, particularly if the main page of interest is precreated and
> locked by the VM before calling the filesystem.  I would much rather the VM
> created the pages, starting from the lowest-numbered.

A call to ->readahead is always a contiguous set of pages.  A call to
readahead_expand() which tried to expand both up and down would start
by allocating, locking and adding the pages to the page cache heading
downwards from the current start (it's usually not allowed to lock
pages out of order, but because they're locked before being added,
this is an exception).  Then we'd try to expand upwards.  We'll fail
to expand if we can't allocate a page or if there's already a page in
the cache that blocks our expansion in that direction.

As far as the zeroing beyond i_size, that's the responsibility of the
filesystem.
