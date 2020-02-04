Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703321523A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 00:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgBDX4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 18:56:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38090 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgBDX4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:56:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014NmU3L079333;
        Tue, 4 Feb 2020 23:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=52KzkG/J+VWiaJrVi1k1Dkvuk2f0YHbnNWygA0UWPSo=;
 b=otK55Zj5wnz49Zx/Q+uqE35yqQwRoTkfKMxRH66VdqI4y+zhQmfweIyQ4hGDaO7PzFmu
 0KFP4jtBcLKIo0AUlv3wRe05VdLcSHYJnjmiw99tr2bFkQIVfvipnE+y4uMOPcqzDqy6
 +988bEGSJcsFLrHwTU03J9O0unvOnCc+FFJ64k21WLEHkfflCRRnXhq36wH2WosswUG9
 YUU/leTlBe3vnpNnBaTGJOcJBeaWeiWPFnb7XOXaH37t2qTJeCXBklmhet0cmsXG2CH4
 OLNMXMGVVRs7vQw1et2oBekYv6cc2y+fFTyAvyYoZLuEx8sDClOhfaPFJv2SM821ITxd zQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xyhkf87n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 23:56:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014NrwZx049508;
        Tue, 4 Feb 2020 23:56:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xyhmq3527-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 23:56:10 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014Nu9Ex018740;
        Tue, 4 Feb 2020 23:56:09 GMT
Received: from localhost (/10.159.250.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 15:56:09 -0800
Date:   Tue, 4 Feb 2020 15:56:08 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm, swap: unlock inode in error path of claim_swapfile
Message-ID: <20200204235608.GG6874@magnolia>
References: <20200204095943.727666-1-naohiro.aota@wdc.com>
 <20200204154229.GC6874@magnolia>
 <20200204234916.s6zx6i2ko4mvxim2@naota.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204234916.s6zx6i2ko4mvxim2@naota.dhcp.fujisawa.hgst.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2001150001 definitions=main-2002040163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-2001150001
 definitions=main-2002040163
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 08:49:16AM +0900, Naohiro Aota wrote:
> On Tue, Feb 04, 2020 at 07:42:29AM -0800, Darrick J. Wong wrote:
> > On Tue, Feb 04, 2020 at 06:59:43PM +0900, Naohiro Aota wrote:
> > > claim_swapfile() currently keeps the inode locked when it is successful, or
> > > the file is already swapfile (with -EBUSY). And, on the other error cases,
> > > it does not lock the inode.
> > > 
> > > This inconsistency of the lock state and return value is quite confusing
> > > and actually causing a bad unlock balance as below in the "bad_swap"
> > > section of __do_sys_swapon().
> > > 
> > > This commit fixes this issue by unlocking the inode on the error path. It
> > > also reverts blocksize and releases bdev, so that the caller can safely
> > > forget about the inode.
> > > 
> > >     =====================================
> > >     WARNING: bad unlock balance detected!
> > >     5.5.0-rc7+ #176 Not tainted
> > >     -------------------------------------
> > >     swapon/4294 is trying to release lock (&sb->s_type->i_mutex_key) at:
> > >     [<ffffffff8173a6eb>] __do_sys_swapon+0x94b/0x3550
> > >     but there are no more locks to release!
> > > 
> > >     other info that might help us debug this:
> > >     no locks held by swapon/4294.
> > > 
> > >     stack backtrace:
> > >     CPU: 5 PID: 4294 Comm: swapon Not tainted 5.5.0-rc7-BTRFS-ZNS+ #176
> > >     Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2014
> > >     Call Trace:
> > >      dump_stack+0xa1/0xea
> > >      ? __do_sys_swapon+0x94b/0x3550
> > >      print_unlock_imbalance_bug.cold+0x114/0x123
> > >      ? __do_sys_swapon+0x94b/0x3550
> > >      lock_release+0x562/0xed0
> > >      ? kvfree+0x31/0x40
> > >      ? lock_downgrade+0x770/0x770
> > >      ? kvfree+0x31/0x40
> > >      ? rcu_read_lock_sched_held+0xa1/0xd0
> > >      ? rcu_read_lock_bh_held+0xb0/0xb0
> > >      up_write+0x2d/0x490
> > >      ? kfree+0x293/0x2f0
> > >      __do_sys_swapon+0x94b/0x3550
> > >      ? putname+0xb0/0xf0
> > >      ? kmem_cache_free+0x2e7/0x370
> > >      ? do_sys_open+0x184/0x3e0
> > >      ? generic_max_swapfile_size+0x40/0x40
> > >      ? do_syscall_64+0x27/0x4b0
> > >      ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >      ? lockdep_hardirqs_on+0x38c/0x590
> > >      __x64_sys_swapon+0x54/0x80
> > >      do_syscall_64+0xa4/0x4b0
> > >      entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >     RIP: 0033:0x7f15da0a0dc7
> > > 
> > > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  mm/swapfile.c | 29 ++++++++++++++++++++++-------
> > >  1 file changed, 22 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index bb3261d45b6a..dd5d7fa42282 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -2886,24 +2886,37 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
> > >  		p->old_block_size = block_size(p->bdev);
> > >  		error = set_blocksize(p->bdev, PAGE_SIZE);
> > >  		if (error < 0)
> > > -			return error;
> > > +			goto err;
> > >  		/*
> > >  		 * Zoned block devices contain zones that have a sequential
> > >  		 * write only restriction.  Hence zoned block devices are not
> > >  		 * suitable for swapping.  Disallow them here.
> > >  		 */
> > > -		if (blk_queue_is_zoned(p->bdev->bd_queue))
> > > -			return -EINVAL;
> > > +		if (blk_queue_is_zoned(p->bdev->bd_queue)) {
> > > +			error = -EINVAL;
> > > +			goto err;
> > > +		}
> > >  		p->flags |= SWP_BLKDEV;
> > >  	} else if (S_ISREG(inode->i_mode)) {
> > >  		p->bdev = inode->i_sb->s_bdev;
> > >  	}
> > > 
> > >  	inode_lock(inode);
> > > -	if (IS_SWAPFILE(inode))
> > > -		return -EBUSY;
> > > +	if (IS_SWAPFILE(inode)) {
> > > +		inode_unlock(inode);
> > > +		error = -EBUSY;
> > > +		goto err;
> > > +	}
> > > 
> > >  	return 0;
> > > +
> > > +err:
> > > +	if (S_ISBLK(inode->i_mode)) {
> > > +		set_blocksize(p->bdev, p->old_block_size);
> > > +		blkdev_put(p->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
> > > +	}
> > > +
> > > +	return error;
> > >  }
> > > 
> > > 
> > > @@ -3157,10 +3170,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
> > >  	mapping = swap_file->f_mapping;
> > >  	inode = mapping->host;
> > > 
> > > -	/* If S_ISREG(inode->i_mode) will do inode_lock(inode); */
> > > +	/* do inode_lock(inode); */
> > 
> > What if we made this function responsible for calling inode_lock (and
> > unlock) instead of splitting it between sys_swapon and claim_swapfile?
> 
> I think we cannot take inode_lock before claim_swapfile() because we can
> have circular locking dependency as:
> 
> claim_swapfile()
> -> blkdev_get()    -> __blkdev_get()
>       -> mutex_lock(&bdev->bd_mutex)
>       -> bd_set_size()
>          -> inode_lock(&bdev->bd_inode);

Ah, good point. Thank you for doing the research on that. :)

> So, one thing we can do is to move inode_lock() and "if (IS_SWAPFILE(..))
> ..." out of claim_swapfile(). In this case, the "bad_swap" section must
> check if "inode_is_locked" to call "inode_unlock".

I think I wouldn't rely on inode_is_locked and structure the error
escape as follows:

	err = claim_swapfile()
	if (err)
		goto bad_swap;

	inode_lock()
	if (IS_SWAPFILE)
		goto unlock_swap;

	other_stuff()

unlock_swap:
	inode_unlock()
bad_swap:
	fput()

since that's how we (well, XFS anyway :)) tend to do it.

--D

> > 
> > --D
> > 
> > >  	error = claim_swapfile(p, inode);
> > > -	if (unlikely(error))
> > > +	if (unlikely(error)) {
> > > +		inode = NULL;
> > >  		goto bad_swap;
> > > +	}
> > > 
> > >  	/*
> > >  	 * Read the swap header.
> > > --
> > > 2.25.0
> > > 
