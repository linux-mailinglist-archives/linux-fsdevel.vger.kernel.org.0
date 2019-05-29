Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5774D2DECA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 15:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfE2Nqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 09:46:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:54240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727389AbfE2Nqb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 09:46:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4653FAFD4;
        Wed, 29 May 2019 13:46:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 697321E3F53; Wed, 29 May 2019 15:46:29 +0200 (CEST)
Date:   Wed, 29 May 2019 15:46:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        Jan Kara <jack@suse.cz>, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190529134629.GA32147@quack2.suse.cz>
References: <20190521165158.GB5125@magnolia>
 <1e9951c1-d320-e480-3130-dc1f4b81ef2c@cn.fujitsu.com>
 <20190523115109.2o4txdjq2ft7fzzc@fiona>
 <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
 <20190528091729.GD9607@quack2.suse.cz>
 <a3a919e6-ecad-bdf6-423c-fc01f9cfa661@cn.fujitsu.com>
 <20190529024749.GC16786@dread.disaster.area>
 <376256fd-dee4-5561-eb4e-546e227303cd@cn.fujitsu.com>
 <20190529040719.GL5221@magnolia>
 <20190529044658.GD16786@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529044658.GD16786@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 29-05-19 14:46:58, Dave Chinner wrote:
> On Tue, May 28, 2019 at 09:07:19PM -0700, Darrick J. Wong wrote:
> > On Wed, May 29, 2019 at 12:02:40PM +0800, Shiyang Ruan wrote:
> > > On 5/29/19 10:47 AM, Dave Chinner wrote:
> > > > On Wed, May 29, 2019 at 10:01:58AM +0800, Shiyang Ruan wrote:
> > > > > On 5/28/19 5:17 PM, Jan Kara wrote:
> > > > > > I'm sorry but I don't follow what you suggest. One COW operation is a call
> > > > > > to dax_iomap_rw(), isn't it? That may call iomap_apply() several times,
> > > > > > each invocation calls ->iomap_begin(), ->actor() (dax_iomap_actor()),
> > > > > > ->iomap_end() once. So I don't see a difference between doing something in
> > > > > > ->actor() and ->iomap_end() (besides the passed arguments but that does not
> > > > > > seem to be your concern). So what do you exactly want to do?
> > > > > 
> > > > > Hi Jan,
> > > > > 
> > > > > Thanks for pointing out, and I'm sorry for my mistake.  It's
> > > > > ->dax_iomap_rw(), not ->dax_iomap_actor().
> > > > > 
> > > > > I want to call the callback function at the end of ->dax_iomap_rw().
> > > > > 
> > > > > Like this:
> > > > > dax_iomap_rw(..., callback) {
> > > > > 
> > > > >      ...
> > > > >      while (...) {
> > > > >          iomap_apply(...);
> > > > >      }
> > > > > 
> > > > >      if (callback != null) {
> > > > >          callback();
> > > > >      }
> > > > >      return ...;
> > > > > }
> > > > 
> > > > Why does this need to be in dax_iomap_rw()?
> > > > 
> > > > We already do post-dax_iomap_rw() "io-end callbacks" directly in
> > > > xfs_file_dax_write() to update the file size....
> > > 
> > > Yes, but we also need to call ->xfs_reflink_end_cow() after a COW operation.
> > > And an is-cow flag(from iomap) is also needed to determine if we call it.  I
> > > think it would be better to put this into ->dax_iomap_rw() as a callback
> > > function.
> > 
> > Sort of like how iomap_dio_rw takes a write endio function?
> 
> You mean like we originally had in the DAX code for unwritten
> extents?
> 
> But we got rid of that because performance of unwritten extents was
> absolutely woeful - it's cheaper in terms of CPU cost to do up front
> zeroing (i.e. inside ->iomap_begin) than it is to use unwritten
> extents and convert them to protect against stale data exposure.
> 
> I have a feeling that exactly the same thing is true for CoW - the
> hoops we jump through to do COW fork manipulation and then extent
> movement between the COW fork and the data fork on IO completion
> would be better done before we commit the COW extent allocation.
> 
> In which case, what we actually want for DAX is:
> 
> 
>  iomap_apply()
> 
>  	->iomap_begin()
> 		map old data extent that we copy from
> 
> 		allocate new data extent we copy to in data fork,
> 		immediately replacing old data extent
> 
> 		return transaction handle as private data
> 
> 	dax_iomap_actor()
> 		copies data from old extent to new extent
> 
> 	->iomap_end
> 		commits transaction now data has been copied, making
> 		the COW operation atomic with the data copy.
> 
> 
> This, in fact, should be how we do all DAX writes that require
> allocation, because then we get rid of the need to zero newly
> allocated or unwritten extents before we copy the data into it. i.e.
> we only need to write once to newly allocated storage rather than
> twice.

You need to be careful though. You need to synchronize with page faults so
that they cannot see and expose in page tables blocks you've allocated
before their contents is filled. This race was actually the strongest
motivation for pre-zeroing of blocks. OTOH copy_from_iter() in
dax_iomap_actor() needs to be able to fault pages to copy from (and these
pages may be from the same file you're writing to) so you cannot just block
faulting for the file through I_MMAP_LOCK.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
