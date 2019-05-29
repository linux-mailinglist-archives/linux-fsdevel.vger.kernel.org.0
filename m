Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A132D4DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 06:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfE2ErG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 00:47:06 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38095 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfE2ErG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 00:47:06 -0400
Received: from dread.disaster.area (pa49-180-144-61.pa.nsw.optusnet.com.au [49.180.144.61])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 76CD1438371;
        Wed, 29 May 2019 14:47:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hVqUM-0001CD-8v; Wed, 29 May 2019 14:46:58 +1000
Date:   Wed, 29 May 2019 14:46:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>, Jan Kara <jack@suse.cz>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190529044658.GD16786@dread.disaster.area>
References: <20190429172649.8288-5-rgoldwyn@suse.de>
 <20190521165158.GB5125@magnolia>
 <1e9951c1-d320-e480-3130-dc1f4b81ef2c@cn.fujitsu.com>
 <20190523115109.2o4txdjq2ft7fzzc@fiona>
 <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
 <20190528091729.GD9607@quack2.suse.cz>
 <a3a919e6-ecad-bdf6-423c-fc01f9cfa661@cn.fujitsu.com>
 <20190529024749.GC16786@dread.disaster.area>
 <376256fd-dee4-5561-eb4e-546e227303cd@cn.fujitsu.com>
 <20190529040719.GL5221@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529040719.GL5221@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=8RU0RCro9O0HS2ezTvitPg==:117 a=8RU0RCro9O0HS2ezTvitPg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=1qB8P1dNaAx9hIWnnysA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 09:07:19PM -0700, Darrick J. Wong wrote:
> On Wed, May 29, 2019 at 12:02:40PM +0800, Shiyang Ruan wrote:
> > On 5/29/19 10:47 AM, Dave Chinner wrote:
> > > On Wed, May 29, 2019 at 10:01:58AM +0800, Shiyang Ruan wrote:
> > > > On 5/28/19 5:17 PM, Jan Kara wrote:
> > > > > I'm sorry but I don't follow what you suggest. One COW operation is a call
> > > > > to dax_iomap_rw(), isn't it? That may call iomap_apply() several times,
> > > > > each invocation calls ->iomap_begin(), ->actor() (dax_iomap_actor()),
> > > > > ->iomap_end() once. So I don't see a difference between doing something in
> > > > > ->actor() and ->iomap_end() (besides the passed arguments but that does not
> > > > > seem to be your concern). So what do you exactly want to do?
> > > > 
> > > > Hi Jan,
> > > > 
> > > > Thanks for pointing out, and I'm sorry for my mistake.  It's
> > > > ->dax_iomap_rw(), not ->dax_iomap_actor().
> > > > 
> > > > I want to call the callback function at the end of ->dax_iomap_rw().
> > > > 
> > > > Like this:
> > > > dax_iomap_rw(..., callback) {
> > > > 
> > > >      ...
> > > >      while (...) {
> > > >          iomap_apply(...);
> > > >      }
> > > > 
> > > >      if (callback != null) {
> > > >          callback();
> > > >      }
> > > >      return ...;
> > > > }
> > > 
> > > Why does this need to be in dax_iomap_rw()?
> > > 
> > > We already do post-dax_iomap_rw() "io-end callbacks" directly in
> > > xfs_file_dax_write() to update the file size....
> > 
> > Yes, but we also need to call ->xfs_reflink_end_cow() after a COW operation.
> > And an is-cow flag(from iomap) is also needed to determine if we call it.  I
> > think it would be better to put this into ->dax_iomap_rw() as a callback
> > function.
> 
> Sort of like how iomap_dio_rw takes a write endio function?

You mean like we originally had in the DAX code for unwritten
extents?

But we got rid of that because performance of unwritten extents was
absolutely woeful - it's cheaper in terms of CPU cost to do up front
zeroing (i.e. inside ->iomap_begin) than it is to use unwritten
extents and convert them to protect against stale data exposure.

I have a feeling that exactly the same thing is true for CoW - the
hoops we jump through to do COW fork manipulation and then extent
movement between the COW fork and the data fork on IO completion
would be better done before we commit the COW extent allocation.

In which case, what we actually want for DAX is:


 iomap_apply()

 	->iomap_begin()
		map old data extent that we copy from

		allocate new data extent we copy to in data fork,
		immediately replacing old data extent

		return transaction handle as private data

	dax_iomap_actor()
		copies data from old extent to new extent

	->iomap_end
		commits transaction now data has been copied, making
		the COW operation atomic with the data copy.


This, in fact, should be how we do all DAX writes that require
allocation, because then we get rid of the need to zero newly
allocated or unwritten extents before we copy the data into it. i.e.
we only need to write once to newly allocated storage rather than
twice.

This gets rid of the need for COW callbacks, and means the DAX
reflink implementation does not need to use delalloc
speculative preallocation or COW forks at all.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
