Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4785E7F57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiIWQOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIWQOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:14:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439E91280F1;
        Fri, 23 Sep 2022 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YgHH6pk3nJLXW2jbXtGoxm+4FKcaifQJYVKj+aRwkxg=; b=ELnSTSol/sfK6s31ClYuS8gszF
        sgXyMtpRrY266URjhhF2+1SDFZPQ78gjuIuhX2IKz28nBNhRVMvO+lvdYB0u9QfxT77iP5VaWVadQ
        XQ7c8C2XILfSmvEUEZNndcp74iadwyK5fGrJ2BFrCVFtzqPwlVzV8idNgG0D9vuRVL5c60jrYWDzq
        7t0rwxdFdeOKfLhnBFBDnyEJQ9KRzGyGnf7Y6ovolAFvEL3wYKawkB7tGYFSqpHRkMjTbebYoWz82
        P+56yyxTj49Ngg8b0QDC7L5mid0UQH+ffCszwa9c1DnG3p+HPNkrve7pWm/ViH77+sQ5wQ2HwLSDK
        1uOznKEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oblJ8-002uO3-0s;
        Fri, 23 Sep 2022 16:13:42 +0000
Date:   Fri, 23 Sep 2022 17:13:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <Yy3bNjaiUoGv/djG@ZenIV>
References: <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyvG+Oih2A37Grcf@ZenIV>
 <YyxzYTlyGhbb2MOu@infradead.org>
 <Yy00eSjyxvUIp7D5@ZenIV>
 <Yy1x8QE9YA4HHzbQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy1x8QE9YA4HHzbQ@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 01:44:33AM -0700, Christoph Hellwig wrote:

> Why would I?  We generall do have or should have the iov_iter around.

Not for async IO.

> And for the common case where we don't (bios) we can carry that
> information in the bio as it needs a special unmap helper anyway.

*Any* async read_iter is like that.

> > Where are they getting
> > dropped and what guarantees that IO is complete by that point?
> 
> The exact place depens on the exact taaraget frontend of which we have
> a few.  But it happens from the end_io callback that is triggered
> through a call to target_complete_cmd.

OK...

> > The reason I'm asking is that here you have an ITER_BVEC possibly fed to
> > __blkdev_direct_IO_async(), with its
> >         if (iov_iter_is_bvec(iter)) {
> >                 /*
> >                  * Users don't rely on the iterator being in any particular
> >                  * state for async I/O returning -EIOCBQUEUED, hence we can
> >                  * avoid expensive iov_iter_advance(). Bypass
> >                  * bio_iov_iter_get_pages() and set the bvec directly.
> >                  */
> >                 bio_iov_bvec_set(bio, iter);
> > which does *not* grab the page referneces.  Sure, bio_release_pages() knows
> > to leave those alone and doesn't drop anything.  However, what is the
> > mechanism preventing the pages getting freed before the IO completion
> > in this case?
> 
> The contract that callers of bvec iters need to hold their own
> references as without that doing I/O do them would be unsafe.  It they
> did not hold references the pages could go away before even calling
> bio_iov_iter_get_pages (or this open coded bio_iov_bvec_set).

You are mixing two issues here - holding references to pages while using
iov_iter instance is obvious; holding them until async IO is complete, even
though struct iov_iter might be long gone by that point is a different
story.

And originating iov_iter instance really can be long-gone by the time
of IO completion - requirement to keep it around would be very hard to
satisfy.  I've no objections to requiring the pages in ITER_BVEC to be
preserved at least until the IO completion by means independent of
whatever ->read_iter/->write_iter does to them, but
	* that needs to be spelled out very clearly and
	* we need to verify that it is, indeed, the case for all existing
iov_iter_bvec callers, preferably with comments next to non-obvious ones
(something that is followed only by the sync IO is obvious)

That goes not just for bio - if we make get_pages *NOT* grab references
on ITER_BVEC (and I'm all for it), we need to make sure that those
pages won't be retained after the original protection runs out.  Which
includes the reference put into struct nfs_request, for example, as well
as whatever ceph transport is doing, etc.  Another thing that needs to
be sorted out is __zerocopy_sg_from_iter() and its callers - AFAICS,
all of those are in ->sendmsg() with MSG_ZEROCOPY in flags.

It's a non-trivial amount of code audit - we have about 40 iov_iter_bvec()
callers in the tree, and while many are clearly sync-only... the ones
that are not tend to balloon into interesting analysis of call chains, etc.

Don't get me wrong - that analysis needs to be done, just don't expect
it to be trivial.  And it will require quite a bit of cooperation from the
folks familiar with e.g. drivers/target, or with ceph transport layer,
etc.

FWIW, my preference would be along the lines of

	Backing memory for any non user-backed iov_iter should be protected
	from reuse by creator of iov_iter and that protection should continue
	through not just all synchronous operations with iov_iter in question
	- it should last until all async operations involving that memory are
	finished.  That continued protection must not depend upon taking
	extra page references, etc. while we are working with iov_iter.

But getting there will take quite a bit of code audit and probably some massage
as well.
