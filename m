Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82BAFA95E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 06:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfKMFIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 00:08:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52850 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfKMFIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 00:08:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD4xJnx194744;
        Wed, 13 Nov 2019 05:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=I5Y9z5o5t3CS3vcZITmaWGKBx8zW1AOCXd90p/9m3IA=;
 b=JyUQMJNBR0b0ElBk3FAIxKqdf5seHz5YUt8ZvHZiat9k6ocFgx7CBQFjTDdax+D1tdK2
 BVSZvcXQvi/pl1c99/srX2eHgv9+b9hnKkRzcOHkyjUaogPJCWZIdypDkuUlfP9wJgJA
 tyiP6TIfsGGpEEEAyKvtDZKA+LtMn2hLTVxyun0Ct3ZNswlsmUPETqnSBRE3g+sDUO1V
 rRndGYc+qkwIteZWF+s8ZEXWT5lU/q2ah7V91EySp5vr6b1+uY2kdVbgcE6MJ+GauQy+
 VPpXxGbey8bnQ5gEeGnrkrDU8w1XFrwzGZFv761AFPXT8+O/u68hc9mkk0heFepDglk4 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w5mvtsqqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 05:08:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD53r3v137732;
        Wed, 13 Nov 2019 05:06:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w7khmn807-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 05:06:32 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAD56UiJ014286;
        Wed, 13 Nov 2019 05:06:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 21:06:30 -0800
Date:   Tue, 12 Nov 2019 21:06:28 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-xfs@vger.kernel.org,
        y2038@lists.linaro.org, Deepa Dinamani <deepa.kernel@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/5] xfs: [variant A] avoid time_t in user api
Message-ID: <20191113050628.GS6219@magnolia>
References: <20191112120910.1977003-1-arnd@arndb.de>
 <20191112120910.1977003-2-arnd@arndb.de>
 <20191112141600.GB10922@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112141600.GB10922@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=903
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=965 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130044
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 03:16:00PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2019 at 01:09:06PM +0100, Arnd Bergmann wrote:
> > However, as long as two observations are true, a much simpler solution
> > can be used:
> > 
> > 1. xfsprogs is the only user space project that has a copy of this header
> 
> We can't guarantee that.
> 
> > 2. xfsprogs already has a replacement for all three affected ioctl commands,
> >    based on the xfs_bulkstat structure to pass 64-bit timestamps
> >    regardless of the architecture
> 
> XFS_IOC_BULKSTAT replaces XFS_IOC_FSBULKSTAT directly, and can replace
> XFS_IOC_FSBULKSTAT_SINGLE indirectly, so that is easy.  Most users
> actually use the new one now through libfrog, although I found a user
> of the direct ioctl in the xfs_io tool, which could easily be fixed as
> well.

Agreed, XFS_IOC_BULKSTAT is the replacement for the two FSBULKSTAT
variants.  The only question in my mind for the old ioctls is whether we
should return EOVERFLOW if the timestamp would overflow?  Or just
truncate the results?

> XFS_IOC_SWAPEXT does not have a direct replacement, but the timestamp
> is only used to verify that the file did not change vs the previous
> stat.  So not being able to represent > 2038 times is not a real
> problem anyway.

Won't it become a problem when the tv_sec comparison in xfs_swap_extents
is type-promoted to the larger type but lacks the upper bits?

I guess we could force the check to the lower 32 bits on the assumption
that those are the most likely to change due to a file write.

I kinda want to do a SWAPEXT v5, fwiw....

> At some point we should probably look into a file system independent
> defrag ioctl anyway, at which point we can deprecate XFS_IOC_SWAPEXT.
> 
> > Based on those assumptions, changing xfs_bstime to use __kernel_long_t
> > instead of time_t in both the kernel and in xfsprogs preserves the current
> > ABI for any libc definition of time_t and solves the problem of passing
> > 64-bit timestamps to 32-bit user space.
> 
> As said above their are not entirely true, but I still think this patch
> is the right thing to do, if only to get the time_t out of the ABI..
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Seconded,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

