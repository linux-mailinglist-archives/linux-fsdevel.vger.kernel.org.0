Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF18E005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 23:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfHNVjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 17:39:06 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55540 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbfHNVjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:39:05 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C05B043D91C;
        Thu, 15 Aug 2019 07:39:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hy0xt-00065E-SN; Thu, 15 Aug 2019 07:37:53 +1000
Date:   Thu, 15 Aug 2019 07:37:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
Message-ID: <20190814213753.GP6129@dread.disaster.area>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814204259.120942-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814204259.120942-2-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=ofEyNPXqulms9I7KujUA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:42:28PM +0200, Arnd Bergmann wrote:
> For 31-bit s390 user space, we have to pass pointer arguments through
> compat_ptr() in the compat_ioctl handler.

Seems fair enough, but...
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/xfs/xfs_ioctl32.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
> index 7fcf7569743f..ad91e81a2fcf 100644
> --- a/fs/xfs/xfs_ioctl32.c
> +++ b/fs/xfs/xfs_ioctl32.c
> @@ -547,7 +547,7 @@ xfs_file_compat_ioctl(
>  	struct inode		*inode = file_inode(filp);
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
> -	void			__user *arg = (void __user *)p;
> +	void			__user *arg = compat_ptr(p);
>  	int			error;
>  
>  	trace_xfs_file_compat_ioctl(ip);
> @@ -576,7 +576,7 @@ xfs_file_compat_ioctl(
>  	case XFS_IOC_SCRUB_METADATA:
>  	case XFS_IOC_BULKSTAT:
>  	case XFS_IOC_INUMBERS:
> -		return xfs_file_ioctl(filp, cmd, p);
> +		return xfs_file_ioctl(filp, cmd, (unsigned long)arg);

I don't really like having to sprinkle special casts through the
code because of this.

Perhaps do something like:

static inline unsigned long compat_ptr_mask(unsigned long p)
{
	return (unsigned long)compat_ptr(p);
}

and then up front you can do:

	void	__user *arg;

	p = compat_ptr_mask(p);
	arg = (void __user *)p;


and then the rest of the code remains unchanged by now uses p
correctly instead of having to change all the code to cast arg back
to an unsigned long...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
