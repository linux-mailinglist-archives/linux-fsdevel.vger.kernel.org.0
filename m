Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22A40FC7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 17:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbhIQPgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 11:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242482AbhIQPe1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:34:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C941A610A7;
        Fri, 17 Sep 2021 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631892784;
        bh=9MHIk2t5x7NEHeTxPOE1It1AGkcx0ikE4Sxn9rPtHQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0GMxlW2/qRnn9KvjDA2e4/N8ThLppKFZdLCMZO16lyjwnRDCZ3dlTfK0bNMGaFEt
         Ns0l2VkaNU0c5R63DCWMVeXuMxtKLB7QXHZXuU/VluNMbCD10Amr/SFtTradft6PT/
         kIbUxdZE/NcwzoLf6oWvmxuhaA/Vg56JS5ZuGnm0yFwSNcT1IyKAW/jZ4jHltT+FFc
         PW6fNq+b7CdfzUjyAoIJi5/Xyk98g3z6nUFpI9bc/nTwzafC1tAGdTRHv0mWZbtc07
         ypQtB/mSa0xe+6Stoo52k7dLskqy/4Xamxj4/ut6gDseyOwj1njfwqYpmVWNVMAHqj
         rY491xXQ9RYjQ==
Date:   Fri, 17 Sep 2021 08:33:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [PATCH v9 7/8] xfs: support CoW in fsdax mode
Message-ID: <20210917153304.GB10250@magnolia>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-8-ruansy.fnst@fujitsu.com>
 <20210916002227.GD34830@magnolia>
 <20210916063251.GE13306@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916063251.GE13306@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 08:32:51AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 15, 2021 at 05:22:27PM -0700, Darrick J. Wong wrote:
> > >  		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> > >  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
> > >  				(write_fault && !vmf->cow_page) ?
> > > -				 &xfs_direct_write_iomap_ops :
> > > -				 &xfs_read_iomap_ops);
> > > +					&xfs_dax_write_iomap_ops :
> > > +					&xfs_read_iomap_ops);
> > 
> > Hmm... I wonder if this should get hoisted to a "xfs_dax_iomap_fault"
> > wrapper like you did for xfs_iomap_zero_range?
> 
> This has just a single users, so the classic argument won't apply.  That
> being said __xfs_filemap_fault is a complete mess to due the calling
> conventions of the various VFS methods multiplexed into it.  So yes,
> splitting out a xfs_dax_iomap_fault to wrap the above plus the
> dax_finish_sync_fault call might not actually be a bad idea nevertheless.

Agree.

> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > +	/*
> > > +	 * Usually we use @written to indicate whether the operation was
> > > +	 * successful.  But it is always positive or zero.  The CoW needs the
> > > +	 * actual error code from actor().  So, get it from
> > > +	 * iomap_iter->processed.
> > 
> > Hm.  All six arguments are derived from the struct iomap_iter, so maybe
> > it makes more sense to pass that in?  I'll poke around with this more
> > tomorrow.
> 
> I'd argue against just changing the calling conventions for ->iomap_end
> now.  The original iter patches from willy allowed passing a single
> next callback combinging iomap_begin and iomap_end in a way that with
> a little magic we can avoid the indirect calls entirely.  I think we'll
> need to experiment with that that a bit and see if is worth the effort
> first.  I plan to do that but I might not get to it immediate.  If some
> else wants to take over I'm fine with that.

Ah, I forgot that.  Yay Etch-a-Sketch brain. <shake> -ENODATA ;)

> > >  static int
> > >  xfs_buffered_write_iomap_begin(
> > 
> > Also, we have an related request to drop the EXPERIMENTAL tag for
> > non-DAX reflink.  Whichever patch enables dax+reflink for xfs needs to
> > make it clear that reflink + any possibility of DAX emits an
> > EXPERIMENTAL warning.
> 
> More importantly before we can merge this series we also need the VM
> level support for reflink-aware reverse mapping.  So while this series
> here is no in a good enough shape I don't see how we could merge it
> without that other series as we'd have to disallow mmap for reflink+dax
> files otherwise.

I've forgotten why we need mm level reverse mapping again?  The pmem
poison stuff can use ->media_failure (or whatever it was called,
memory_failure?) to find all the owners and notify them.  Was there
some other accounting reason that fell out of my brain?

I'm more afraid of 'sharing pages between files needs mm support'
sparking another multi-year folioesque fight with the mm people.

--D
