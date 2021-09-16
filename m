Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB40540D348
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 08:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhIPGeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 02:34:16 -0400
Received: from verein.lst.de ([213.95.11.211]:38749 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234605AbhIPGeO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:34:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7D9EC67357; Thu, 16 Sep 2021 08:32:51 +0200 (CEST)
Date:   Thu, 16 Sep 2021 08:32:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, hch@lst.de,
        linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        rgoldwyn@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v9 7/8] xfs: support CoW in fsdax mode
Message-ID: <20210916063251.GE13306@lst.de>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com> <20210915104501.4146910-8-ruansy.fnst@fujitsu.com> <20210916002227.GD34830@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916002227.GD34830@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 05:22:27PM -0700, Darrick J. Wong wrote:
> >  		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> >  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
> >  				(write_fault && !vmf->cow_page) ?
> > -				 &xfs_direct_write_iomap_ops :
> > -				 &xfs_read_iomap_ops);
> > +					&xfs_dax_write_iomap_ops :
> > +					&xfs_read_iomap_ops);
> 
> Hmm... I wonder if this should get hoisted to a "xfs_dax_iomap_fault"
> wrapper like you did for xfs_iomap_zero_range?

This has just a single users, so the classic argument won't apply.  That
being said __xfs_filemap_fault is a complete mess to due the calling
conventions of the various VFS methods multiplexed into it.  So yes,
splitting out a xfs_dax_iomap_fault to wrap the above plus the
dax_finish_sync_fault call might not actually be a bad idea nevertheless.

> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	/*
> > +	 * Usually we use @written to indicate whether the operation was
> > +	 * successful.  But it is always positive or zero.  The CoW needs the
> > +	 * actual error code from actor().  So, get it from
> > +	 * iomap_iter->processed.
> 
> Hm.  All six arguments are derived from the struct iomap_iter, so maybe
> it makes more sense to pass that in?  I'll poke around with this more
> tomorrow.

I'd argue against just changing the calling conventions for ->iomap_end
now.  The original iter patches from willy allowed passing a single
next callback combinging iomap_begin and iomap_end in a way that with
a little magic we can avoid the indirect calls entirely.  I think we'll
need to experiment with that that a bit and see if is worth the effort
first.  I plan to do that but I might not get to it immediate.  If some
else wants to take over I'm fine with that.

> >  static int
> >  xfs_buffered_write_iomap_begin(
> 
> Also, we have an related request to drop the EXPERIMENTAL tag for
> non-DAX reflink.  Whichever patch enables dax+reflink for xfs needs to
> make it clear that reflink + any possibility of DAX emits an
> EXPERIMENTAL warning.

More importantly before we can merge this series we also need the VM
level support for reflink-aware reverse mapping.  So while this series
here is no in a good enough shape I don't see how we could merge it
without that other series as we'd have to disallow mmap for reflink+dax
files otherwise.
