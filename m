Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EA7FB52E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfKMQeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:34:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51584 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfKMQeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:34:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGOJCK005238;
        Wed, 13 Nov 2019 16:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=uwOzuqofgFKh9CEoqNvzVkfLznB5nfyiXg6VNNfhcFk=;
 b=HBCnFCelzgmakVWzg73V7nhlS1OQXWcHa07QisTyW2UrFi9oAfnuHUuODUuZv30DlqlF
 dsa56DWJD91/+SDPrDavFw0knljOon4amqfR2J9qDzaZwKz/9Xk5Ha9UgZpJxBMqJAEu
 94s+QXHBNmKe0B//15+xn096nnlU2bmLAScpe8XdbwKWgZEgCJFDIkKsuS+iCDmpSaxu
 X+jCfwh4+KQIWg+G1kfC+B5hcc4osjCphSB/nFpJKD5T5lxV6MDwvdwHor2Pl9hTJljz
 qMLFvRbd/VJtv7MmUhM/57LfsdNaq2B4S0/PbOE0YjxpOnG1yx5GxeyvJxCUSVKT/Cg6 lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w5ndqdpp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 16:34:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADGQZwx186050;
        Wed, 13 Nov 2019 16:34:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w7vppj4q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 16:34:10 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xADGY3V9006663;
        Wed, 13 Nov 2019 16:34:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 08:34:03 -0800
Date:   Wed, 13 Nov 2019 08:34:01 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC 1/5] xfs: [variant A] avoid time_t in user api
Message-ID: <20191113163401.GW6219@magnolia>
References: <20191112120910.1977003-1-arnd@arndb.de>
 <20191112120910.1977003-2-arnd@arndb.de>
 <20191112141600.GB10922@lst.de>
 <20191113050628.GS6219@magnolia>
 <CAK8P3a3c3kCXAPU-sJQvAvDQdAwVnQRiterdmqXufWkFdSSZ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3c3kCXAPU-sJQvAvDQdAwVnQRiterdmqXufWkFdSSZ+g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130146
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:42:24PM +0100, Arnd Bergmann wrote:
> On Wed, Nov 13, 2019 at 6:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > On Tue, Nov 12, 2019 at 03:16:00PM +0100, Christoph Hellwig wrote:
> > > On Tue, Nov 12, 2019 at 01:09:06PM +0100, Arnd Bergmann wrote:
> > > > However, as long as two observations are true, a much simpler solution
> > > > can be used:
> > > >
> > > > 1. xfsprogs is the only user space project that has a copy of this header
> > >
> > > We can't guarantee that.
> > >
> > > > 2. xfsprogs already has a replacement for all three affected ioctl commands,
> > > >    based on the xfs_bulkstat structure to pass 64-bit timestamps
> > > >    regardless of the architecture
> > >
> > > XFS_IOC_BULKSTAT replaces XFS_IOC_FSBULKSTAT directly, and can replace
> > > XFS_IOC_FSBULKSTAT_SINGLE indirectly, so that is easy.  Most users
> > > actually use the new one now through libfrog, although I found a user
> > > of the direct ioctl in the xfs_io tool, which could easily be fixed as
> > > well.
> >
> > Agreed, XFS_IOC_BULKSTAT is the replacement for the two FSBULKSTAT
> > variants.  The only question in my mind for the old ioctls is whether we
> > should return EOVERFLOW if the timestamp would overflow?  Or just
> > truncate the results?
> 
> I think neither of these would be particularly helpful, the result is that users
> see no change in behavior until it's actually too late and the timestamps have
> overrun.
> 
> If we take variant A and just fix the ABI to 32-bit time_t, it is important
> that all user space stop using these ioctls and moves to the v5 interfaces
> instead (including SWAPEXT I guess).
> 
> Something along the lines of this change would work:
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index d50135760622..87318486c96e 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -830,6 +830,23 @@ xfs_fsinumbers_fmt(
>         return xfs_ibulk_advance(breq, sizeof(struct xfs_inogrp));
>  }
> 
> +/* disallow y2038-unsafe ioctls with CONFIG_COMPAT_32BIT_TIME=n */
> +static bool xfs_have_compat_bstat_time32(unsigned int cmd)
> +{

Wouldn't we want a test here like:

	if (!xfs_sb_version_hasbigtimestamps(&mp->m_sb))
		return true;

Since date overflow isn't a problem for existing xfs with 32-bit
timestamps, right?

> +       if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))

Heh, I didn't know that existed.

> +               return true;
> +
> +       if (IS_ENABLED(CONFIG_64BIT) && !in_compat_syscall())
> +               return true;
> +       if (cmd == XFS_IOC_FSBULKSTAT_SINGLE ||
> +           cmd == XFS_IOC_FSBULKSTAT ||
> +           cmd == XFS_IOC_SWAPEXT)
> +               return false;
> +
> +       return true;
> +}
> +
>  STATIC int
>  xfs_ioc_fsbulkstat(
>         xfs_mount_t             *mp,
> @@ -850,6 +867,9 @@ xfs_ioc_fsbulkstat(
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
> 
> +       if (!xfs_have_compat_bstat_time32())
> +               return -EINVAL;
> +
>         if (XFS_FORCED_SHUTDOWN(mp))
>                 return -EIO;
> 
> @@ -2051,6 +2071,11 @@ xfs_ioc_swapext(
>         struct fd       f, tmp;
>         int             error = 0;
> 
> +       if (xfs_have_compat_bstat_time32(XFS_IOC_SWAPEXT)) {
> +               error = -EINVAL
> +               got out;
> +       }
> +
>         /* Pull information for the target fd */
>         f = fdget((int)sxp->sx_fdtarget);
>         if (!f.file) {
> 
> This way, at least users that intentionally turn off CONFIG_COMPAT_32BIT_TIME
> run into the broken application right away, which forces them to upgrade or fix
> the code to use the v5 ioctl.

Sounds reasonable.

--D

> > > > Based on those assumptions, changing xfs_bstime to use __kernel_long_t
> > > > instead of time_t in both the kernel and in xfsprogs preserves the current
> > > > ABI for any libc definition of time_t and solves the problem of passing
> > > > 64-bit timestamps to 32-bit user space.
> > >
> > > As said above their are not entirely true, but I still think this patch
> > > is the right thing to do, if only to get the time_t out of the ABI..
> > >
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > Seconded,
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Thanks!
> 
>      Arnd
