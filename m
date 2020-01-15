Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0695313CB25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAORjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 12:39:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47096 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAORjH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:39:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FHcnAU084653;
        Wed, 15 Jan 2020 17:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=QG0Yb9J5ryv/uTyeN6AmB2e0wEHUHKhMZMN7Hc+Zff0=;
 b=R/V6aHyzlhpGPcv9dl7QkYoMUZZEHd4MVjIMyI5R6uT7tw4vMAqK0FwzAlZ6hZ2p4O1Z
 F9iZdDx1qNKPxLsZaEdQMMqhAeJnmOMbx5GPafGaXYkBPg18BqJpgB32f/eyy2kd4I9s
 bHOBy7FYn3TCE8fVKPpVBywut9k8CpPMIVwsYQmVi+GdyVinblPG/pcWMsOJP0j89bYQ
 ZgFmsBWMA76b2JhfG3bLacY/xfqQhhW7TCF1fJtdR2xxsBuDSRZVBBqyaNo4t3hNAwrk
 QnTHcu9nGuJF+QMfW9p2WvnZA6kY8po+7o6lPNrvXDcA/g+TtLShTqaMbsE0lJa9FQix TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xf74sdmkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:38:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FHcr6T069151;
        Wed, 15 Jan 2020 17:38:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xj61k5019-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 17:38:57 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00FHccfd011629;
        Wed, 15 Jan 2020 17:38:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 09:38:37 -0800
Date:   Wed, 15 Jan 2020 09:38:34 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
Message-ID: <20200115173834.GD8247@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115113715.GB2595@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150135
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 12:37:15PM +0100, Jan Kara wrote:
> On Fri 10-01-20 11:29:31, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > In order for users to determine if a file is currently operating in DAX
> > mode (effective DAX).  Define a statx attribute value and set that
> > attribute if the effective DAX flag is set.
> > 
> > To go along with this we propose the following addition to the statx man
> > page:
> > 
> > STATX_ATTR_DAX
> > 
> > 	DAX (cpu direct access) is a file mode that attempts to minimize

"..is a file I/O mode"?

> > 	software cache effects for both I/O and memory mappings of this
> > 	file.  It requires a capable device, a compatible filesystem
> > 	block size, and filesystem opt-in.

"...a capable storage device..."

What does "compatible fs block size" mean?  How does the user figure out
if their fs blocksize is compatible?  Do we tell users to refer their
filesystem's documentation here?

> > It generally assumes all
> > 	accesses are via cpu load / store instructions which can
> > 	minimize overhead for small accesses, but adversely affect cpu
> > 	utilization for large transfers.

Will this always be true for persistent memory?

I wasn't even aware that large transfers adversely affected CPU
utilization. ;)

> >  File I/O is done directly
> > 	to/from user-space buffers. While the DAX property tends to
> > 	result in data being transferred synchronously it does not give

"...transferred synchronously, it does not..."

> > 	the guarantees of synchronous I/O that data and necessary

"...it does not guarantee that I/O or file metadata have been flushed to
the storage device."

> > 	metadata are transferred. Memory mapped I/O may be performed
> > 	with direct mappings that bypass system memory buffering.

"...with direct memory mappings that bypass kernel page cache."

> > Again
> > 	while memory-mapped I/O tends to result in data being

I would move the sentence about "Memory mapped I/O..." to directly after
the sentence about file I/O being done directly to and from userspace so
that you don't need to repeat this statement.

> > 	transferred synchronously it does not guarantee synchronous
> > 	metadata updates. A dax file may optionally support being mapped
> > 	with the MAP_SYNC flag which does allow cpu store operations to
> > 	be considered synchronous modulo cpu cache effects.

How does one detect or work around or deal with "cpu cache effects"?  I
assume some sort of CPU cache flush instruction is what is meant here,
but I think we could mention the basics of what has to be done here:

"A DAX file may support being mapped with the MAP_SYNC flag, which
enables a program to use CPU cache flush operations to persist CPU store
operations without an explicit fsync(2).  See mmap(2) for more
information."?

Oof, a paragraph break would be nice. :)

--D

> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> This looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> > ---
> >  fs/stat.c                 | 3 +++
> >  include/uapi/linux/stat.h | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 030008796479..894699c74dde 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -79,6 +79,9 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> >  	if (IS_AUTOMOUNT(inode))
> >  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
> >  
> > +	if (IS_DAX(inode))
> > +		stat->attributes |= STATX_ATTR_DAX;
> > +
> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(path, stat, request_mask,
> >  					    query_flags);
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index ad80a5c885d5..e5f9d5517f6b 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -169,6 +169,7 @@ struct statx {
> >  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
> >  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> >  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> > +#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
> >  
> >  
> >  #endif /* _UAPI_LINUX_STAT_H */
> > -- 
> > 2.21.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
