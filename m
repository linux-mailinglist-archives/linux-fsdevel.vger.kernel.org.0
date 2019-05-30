Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDBD2FAC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 13:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE3LQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 07:16:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfE3LQK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 07:16:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88774AF60;
        Thu, 30 May 2019 11:16:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AE1651E3C08; Thu, 30 May 2019 13:16:05 +0200 (CEST)
Date:   Thu, 30 May 2019 13:16:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190530111605.GC29237@quack2.suse.cz>
References: <20190523115109.2o4txdjq2ft7fzzc@fiona>
 <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
 <20190528091729.GD9607@quack2.suse.cz>
 <a3a919e6-ecad-bdf6-423c-fc01f9cfa661@cn.fujitsu.com>
 <20190529024749.GC16786@dread.disaster.area>
 <376256fd-dee4-5561-eb4e-546e227303cd@cn.fujitsu.com>
 <20190529040719.GL5221@magnolia>
 <20190529044658.GD16786@dread.disaster.area>
 <20190529134629.GA32147@quack2.suse.cz>
 <20190529221445.GE16786@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529221445.GE16786@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 30-05-19 08:14:45, Dave Chinner wrote:
> On Wed, May 29, 2019 at 03:46:29PM +0200, Jan Kara wrote:
> > On Wed 29-05-19 14:46:58, Dave Chinner wrote:
> > >  iomap_apply()
> > > 
> > >  	->iomap_begin()
> > > 		map old data extent that we copy from
> > > 
> > > 		allocate new data extent we copy to in data fork,
> > > 		immediately replacing old data extent
> > > 
> > > 		return transaction handle as private data
> 
> This holds the inode block map locked exclusively across the IO,
> so....

Does it? We do hold XFS_IOLOCK_EXCL during the whole dax write. But
xfs_file_iomap_begin() does release XFS_ILOCK_* on exit AFAICS. So I don't
see anything that would prevent page fault from mapping blocks into page
tables just after xfs_file_iomap_begin() returns.

> > > 	dax_iomap_actor()
> > > 		copies data from old extent to new extent
> > > 
> > > 	->iomap_end
> > > 		commits transaction now data has been copied, making
> > > 		the COW operation atomic with the data copy.
> > > 
> > > 
> > > This, in fact, should be how we do all DAX writes that require
> > > allocation, because then we get rid of the need to zero newly
> > > allocated or unwritten extents before we copy the data into it. i.e.
> > > we only need to write once to newly allocated storage rather than
> > > twice.
> > 
> > You need to be careful though. You need to synchronize with page faults so
> > that they cannot see and expose in page tables blocks you've allocated
> > before their contents is filled.
> 
> ... so the page fault will block trying to map the blocks because
> it can't get the xfs_inode->i_ilock until the allocation transaciton
> commits....
> 
> > This race was actually the strongest
> > motivation for pre-zeroing of blocks. OTOH copy_from_iter() in
> > dax_iomap_actor() needs to be able to fault pages to copy from (and these
> > pages may be from the same file you're writing to) so you cannot just block
> > faulting for the file through I_MMAP_LOCK.
> 
> Right, it doesn't take the I_MMAP_LOCK, but it would block further
> in. And, really, I'm not caring all this much about this corner
> case. i.e.  anyone using a "mmap()+write() zero copy" pattern on DAX
> within a file is unbeleivably naive - the data still gets copied by
> the CPU in the write() call. It's far simpler and more effcient to
> just mmap() both ranges of the file(s) and memcpy() in userspace....
> 
> FWIW, it's to avoid problems with stupid userspace stuff that nobody
> really should be doing that I want range locks for the XFS inode
> locks.  If userspace overlaps the ranges and deadlocks in that case,
> they they get to keep all the broken bits because, IMO, they are
> doing something monumentally stupid. I'd probably be making it
> return EDEADLOCK back out to userspace in the case rather than
> deadlocking but, fundamentally, I think it's broken behaviour that
> we should be rejecting with an error rather than adding complexity
> trying to handle it.

I agree with this. We must just prevent user from taking the kernel down
with maliciously created IOs...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
