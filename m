Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3A123BE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 01:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfLRAtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 19:49:42 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39735 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbfLRAtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:49:42 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D95547EA8C0;
        Wed, 18 Dec 2019 11:49:34 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ihNWv-0006Lh-SB; Wed, 18 Dec 2019 11:49:33 +1100
Date:   Wed, 18 Dec 2019 11:49:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
Message-ID: <20191218004933.GR19213@dread.disaster.area>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <20191211152943.2933-6-axboe@kernel.dk>
 <20191212223403.GH19213@dread.disaster.area>
 <df334467-9c1a-2f03-654f-58b002ea5ae4@kernel.dk>
 <39af5a4d-7539-5746-ac3e-e2d6bd2209e3@kernel.dk>
 <20191216041748.GL19213@dread.disaster.area>
 <a30113f7-2d5a-3adf-19c4-fe49e8ef1ae8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30113f7-2d5a-3adf-19c4-fe49e8ef1ae8@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=OqSb7lb-M-3Ou3G8FbcA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 07:31:51AM -0700, Jens Axboe wrote:
> On 12/15/19 9:17 PM, Dave Chinner wrote:
> > On Thu, Dec 12, 2019 at 05:57:57PM -0700, Jens Axboe wrote:
> >> On 12/12/19 5:54 PM, Jens Axboe wrote:
> >>> On 12/12/19 3:34 PM, Dave Chinner wrote:
> >>>> Just a thought on further optimisation for this for XFS.
> >>>> IOMAP_UNCACHED is being passed into the filesystem ->iomap_begin
> >>>> methods by iomap_apply().  Hence the filesystems know that it is
> >>>> an uncached IO that is being done, and we can tailor allocation
> >>>> strategies to suit the fact that the data is going to be written
> >>>> immediately.
> >>>>
> >>>> In this case, XFS needs to treat it the same way it treats direct
> >>>> IO. That is, we do immediate unwritten extent allocation rather than
> >>>> delayed allocation. This will reduce the allocation overhead and
> >>>> will optimise for immediate IO locality rather than optimise for
> >>>> delayed allocation.
> >>>>
> >>>> This should just be a relatively simple change to
> >>>> xfs_file_iomap_begin() along the lines of:
> >>>>
> >>>> -	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) && !(flags & IOMAP_DIRECT) &&
> >>>> -			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
> >>>> +	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
> >>>> +	    !(flags & (IOMAP_DIRECT | IOMAP_UNCACHED)) &&
> >>>> +	    !IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
> >>>> 		/* Reserve delalloc blocks for regular writeback. */
> >>>> 		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
> >>>> 				iomap);
> >>>> 	}
> >>>>
> >>>> so that it avoids delayed allocation for uncached IO...
> >>>
> >>> That's very handy! Thanks, I'll add that to the next version. Just out
> >>> of curiosity, would you prefer this as a separate patch, or just bundle
> >>> it with the iomap buffered RWF_UNCACHED patch? I'm assuming the latter,
> >>> and I'll just mention it in the changelog.
> >>
> >> OK, since it's in XFS, it'd be a separate patch.
> > 
> > *nod*
> > 
> >> The code you quote seems
> >> to be something out-of-tree?
> > 
> > Ah, I quoted the code in the 5.4 release branch, not the 5.5-rc1
> > tree. I'd forgotten that the xfs_file_iomap_begin() got massively
> > refactored in the 5.5 merge and I hadn't updated my cscope trees. SO
> > I'm guessing you want to go looking for the
> > xfs_buffered_write_iomap_begin() and add another case to this
> > initial branch:
> > 
> >         /* we can't use delayed allocations when using extent size hints */
> >         if (xfs_get_extsz_hint(ip))
> >                 return xfs_direct_write_iomap_begin(inode, offset, count,
> >                                 flags, iomap, srcmap);
> > 
> > To make the buffered write IO go down the direct IO allocation path...
> 
> Makes it even simpler! Something like this:
> 
> 
> commit 1783722cd4b7088a3c004462c7ae610b8e42b720
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Tue Dec 17 07:30:04 2019 -0700
> 
>     xfs: don't do delayed allocations for uncached buffered writes
>     
>     This data is going to be written immediately, so don't bother trying
>     to do delayed allocation for it.
>     
>     Suggested-by: Dave Chinner <david@fromorbit.com>
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 28e2d1f37267..d0cd4a05d59f 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -847,8 +847,11 @@ xfs_buffered_write_iomap_begin(
>  	int			allocfork = XFS_DATA_FORK;
>  	int			error = 0;
>  
> -	/* we can't use delayed allocations when using extent size hints */
> -	if (xfs_get_extsz_hint(ip))
> +	/*
> +	 * Don't do delayed allocations when using extent size hints, or
> +	 * if we were asked to do uncached buffered writes.
> +	 */
> +	if (xfs_get_extsz_hint(ip) || (flags & IOMAP_UNCACHED))
>  		return xfs_direct_write_iomap_begin(inode, offset, count,
>  				flags, iomap, srcmap);
>  

Yup, that's pretty much what I was thinking. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
