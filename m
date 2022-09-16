Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F213D5BA435
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 03:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIPB4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 21:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiIPB4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 21:56:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D34D839;
        Thu, 15 Sep 2022 18:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J30JNwom7vQid4zWEaAjuOGQKZP7syeMiY8+9KV+FKY=; b=BvcU3km0KfSNim65iuY74essLc
        dF427a6nHkyNASvBjaXX4algXt7MW275rBnaScvxth/J8ok2SeGkGhDT8AmmgwgQMt1/IZ/78N/r6
        fEMS9BysLwz1VYsv6S+TPrR0j0Hdy76hwkH0Vbp9y7jzOr9mCH2Czjrqc7wne1zexm4/o1MwsR7NQ
        gqkH1VWNs/BVMn+r747M6z0ddhJQ6Qm1OleNiUHkCF+F4e5fnpAa06olO11cYPFjpL6evqQAIUuIU
        D2+yebeP7+T8GBaRugEqqM6tuz/6RE4Iua5uSzzdSI9CvuXC/djbWCTGlylWgX80SDMhKjzmm2Y7T
        3XXSZ8hg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oZ0a9-00GsoS-0s;
        Fri, 16 Sep 2022 01:55:53 +0000
Date:   Fri, 16 Sep 2022 02:55:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <YyPXqfyf37CUbOf0@ZenIV>
References: <20220831041843.973026-5-jhubbard@nvidia.com>
 <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915081625.6a72nza6yq4l5etp@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:16:25AM +0200, Jan Kara wrote:

> > How would that work?  What protects the area where you want to avoid running
> > into pinned pages from previously acceptable page getting pinned?  If "they
> > must have been successfully unmapped" is a part of what you are planning, we
> > really do have a problem...
> 
> But this is a very good question. So far the idea was that we lock the
> page, unmap (or writeprotect) the page, and then check pincount == 0 and
> that is a reliable method for making sure page data is stable (until we
> unlock the page & release other locks blocking page faults and writes). But
> once suddently ordinary page references can be used to create pins this
> does not work anymore. Hrm.
> 
> Just brainstorming ideas now: So we'd either need to obtain the pins early
> when we still have the virtual address (but I guess that is often not
> practical but should work e.g. for normal direct IO path) or we need some
> way to "simulate" the page fault when pinning the page, just don't map it
> into page tables in the end. This simulated page fault could be perhaps
> avoided if rmap walk shows that the page is already mapped somewhere with
> suitable permissions.

OK...  I'd done some digging; results so far

	* READ vs. WRITE turned out to be an awful way to specify iov_iter
data direction.  Local iov_iter branch so far:
	get rid of unlikely() on page_copy_sane() calls
	csum_and_copy_to_iter(): handle ITER_DISCARD
	[s390] copy_oldmem_kernel() - WRITE is "data source", not destination
	[fsi] WRITE is "data source", not destination...
	[infiniband] READ is "data destination", not source...
	[s390] zcore: WRITE is "data source", not destination...
	[target] fix iov_iter_bvec() "direction" argument
	[vhost] fix 'direction' argument of iov_iter_{init,bvec}()
	[xen] fix "direction" argument of iov_iter_kvec()
	[trace] READ means "data destination", not source...
	iov_iter: saner checks for attempt to copy to/from iterator
	use less confusing names for iov_iter direction initializers
those 8 commits in the middle consist of fixes, some of them with more than
one call site affected.  Folks keep going "oh, we are going to copy data
into that iterator, must be WRITE".  Wrong - WRITE means "as for write(2)",
i.e. the data _source_, not data destination.  And the same kind of bugs
goes in the opposite direction, of course.
	I think something like ITER_DEST vs. ITER_SOURCE would be less
confusing.

	* anything that goes with ITER_SOURCE doesn't need pin.
	* ITER_IOVEC/ITER_UBUF need pin for get_pages and for nothing else.
Need to grab reference on get_pages, obviously.
	* even more obviously, ITER_DISCARD is irrelevant here.
	* ITER_PIPE only modifies anonymous pages that had been allocated
by iov_iter primitives and hadn't been observed by anything outside until
we are done with said ITER_PIPE.
	* quite a few instances are similar to e.g. REQ_OP_READ handling in
/dev/loop - we work with ITER_BVEC there and we do modify the page contents,
but the damn thing would better be given to us locked and stay locked until
all involved modifications (be it real IO/decoding/whatever) is complete.
That ought to be safe, unless I'm missing something.

That doesn't cover everything; still going through the list...
