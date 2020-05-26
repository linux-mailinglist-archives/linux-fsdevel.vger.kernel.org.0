Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9151E26C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgEZQUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 12:20:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbgEZQUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 12:20:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QGHhbg075545;
        Tue, 26 May 2020 16:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZBzh/ybbV61B1Qei3812YPkuod4SSPrDyvvb4BUpNrU=;
 b=s2Af90imq+R8Ct3jec5smTb58lz3XYj28S2RmI5QOq1qrahWHRbSiWGEgByDxN4OWP+g
 xdi1+jm77RmAU5Z00zbI4yalzSEObd93gkYp8sRuDnQ5dTrBQKx4f4Oy5i3M8qdw6jFh
 qiqZgzZ4J4PtyuOHTkfhNkQd4nQMNXc/I1T2/SfTcsTbdhIEdlbXm58GLj5MJvCnw2G4
 ubfHKtPrpzNqTN9kKFYrfcQYR3feq0x323wC/Xyw+nWJ4iovYe2aS0Y9Z3MIGsgkjjBp
 CUOVJwL8tWedyytmhSu+KW0QfgZv0dnMGVnNsat2u9/qBriY3Jgr2EU2ZfEKvruH6OHu EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 318xbjtvjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 16:19:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QGJ0S0032213;
        Tue, 26 May 2020 16:19:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 317ddp54r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 16:19:38 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04QGJYhv023079;
        Tue, 26 May 2020 16:19:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 09:19:34 -0700
Date:   Tue, 26 May 2020 09:19:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PM: hibernate: restrict writes to the resume device
Message-ID: <20200526161932.GD252930@magnolia>
References: <20200519181410.GA1963@dumbo>
 <CAJZ5v0jgA3hh3nB60ANKN1WG9py9BoBqp8N8BuM2W-gpcUaPpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jgA3hh3nB60ANKN1WG9py9BoBqp8N8BuM2W-gpcUaPpg@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=5 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=5 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005260126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 12:52:17PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 19, 2020 at 8:14 PM Domenico Andreoli
> <domenico.andreoli@linux.com> wrote:
> >
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> >
> > Hibernation via snapshot device requires write permission to the swap
> > block device, the one that more often (but not necessarily) is used to
> > store the hibernation image.
> >
> > With this patch, such permissions are granted iff:
> >
> > 1) snapshot device config option is enabled
> > 2) swap partition is used as resume device
> >
> > In other circumstances the swap device is not writable from userspace.
> >
> > In order to achieve this, every write attempt to a swap device is
> > checked against the device configured as part of the uswsusp API [0]
> > using a pointer to the inode struct in memory. If the swap device being
> > written was not configured for resuming, the write request is denied.
> >
> > NOTE: this implementation works only for swap block devices, where the
> > inode configured by swapon (which sets S_SWAPFILE) is the same used
> > by SNAPSHOT_SET_SWAP_AREA.
> >
> > In case of swap file, SNAPSHOT_SET_SWAP_AREA indeed receives the inode
> > of the block device containing the filesystem where the swap file is
> > located (+ offset in it) which is never passed to swapon and then has
> > not set S_SWAPFILE.
> >
> > As result, the swap file itself (as a file) has never an option to be
> > written from userspace. Instead it remains writable if accessed directly
> > from the containing block device, which is always writeable from root.
> >
> > [0] Documentation/power/userland-swsusp.rst
> >
> > v2:
> >  - rename is_hibernate_snapshot_dev() to is_hibernate_resume_dev()
> >  - fix description so to correctly refer to the resume device
> >
> > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: viro@zeniv.linux.org.uk
> > Cc: tytso@mit.edu
> > Cc: len.brown@intel.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-xfs@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> >
> > ---
> >  fs/block_dev.c          |    3 +--
> >  include/linux/suspend.h |    6 ++++++
> >  kernel/power/user.c     |   14 +++++++++++++-
> >  3 files changed, 20 insertions(+), 3 deletions(-)
> >
> > Index: b/include/linux/suspend.h
> > ===================================================================
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -466,6 +466,12 @@ static inline bool system_entering_hiber
> >  static inline bool hibernation_available(void) { return false; }
> >  #endif /* CONFIG_HIBERNATION */
> >
> > +#ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
> > +int is_hibernate_resume_dev(const struct inode *);
> > +#else
> > +static inline int is_hibernate_resume_dev(const struct inode *i) { return 0; }
> > +#endif
> > +
> >  /* Hibernation and suspend events */
> >  #define PM_HIBERNATION_PREPARE 0x0001 /* Going to hibernate */
> >  #define PM_POST_HIBERNATION    0x0002 /* Hibernation finished */
> > Index: b/kernel/power/user.c
> > ===================================================================
> > --- a/kernel/power/user.c
> > +++ b/kernel/power/user.c
> > @@ -35,8 +35,14 @@ static struct snapshot_data {
> >         bool ready;
> >         bool platform_support;
> >         bool free_bitmaps;
> > +       struct inode *bd_inode;
> >  } snapshot_state;
> >
> > +int is_hibernate_resume_dev(const struct inode *bd_inode)
> > +{
> > +       return hibernation_available() && snapshot_state.bd_inode == bd_inode;
> > +}
> > +
> >  static int snapshot_open(struct inode *inode, struct file *filp)
> >  {
> >         struct snapshot_data *data;
> > @@ -95,6 +101,7 @@ static int snapshot_open(struct inode *i
> >         data->frozen = false;
> >         data->ready = false;
> >         data->platform_support = false;
> > +       data->bd_inode = NULL;
> >
> >   Unlock:
> >         unlock_system_sleep();
> > @@ -110,6 +117,7 @@ static int snapshot_release(struct inode
> >
> >         swsusp_free();
> >         data = filp->private_data;
> > +       data->bd_inode = NULL;
> >         free_all_swap_pages(data->swap);
> >         if (data->frozen) {
> >                 pm_restore_gfp_mask();
> > @@ -202,6 +210,7 @@ struct compat_resume_swap_area {
> >  static int snapshot_set_swap_area(struct snapshot_data *data,
> >                 void __user *argp)
> >  {
> > +       struct block_device *bdev;
> >         sector_t offset;
> >         dev_t swdev;
> >
> > @@ -232,9 +241,12 @@ static int snapshot_set_swap_area(struct
> >                 data->swap = -1;
> >                 return -EINVAL;
> >         }
> > -       data->swap = swap_type_of(swdev, offset, NULL);
> > +       data->swap = swap_type_of(swdev, offset, &bdev);
> >         if (data->swap < 0)
> >                 return -ENODEV;
> > +
> > +       data->bd_inode = bdev->bd_inode;
> > +       bdput(bdev);
> >         return 0;
> >  }
> >
> > Index: b/fs/block_dev.c
> > ===================================================================
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -2023,8 +2023,7 @@ ssize_t blkdev_write_iter(struct kiocb *
> >         if (bdev_read_only(I_BDEV(bd_inode)))
> >                 return -EPERM;
> >
> > -       /* uswsusp needs write permission to the swap */
> > -       if (IS_SWAPFILE(bd_inode) && !hibernation_available())
> > +       if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode))
> >                 return -ETXTBSY;
> >
> >         if (!iov_iter_count(from))
> >
> > --
> 
> The patch looks OK to me.
> 
> Darrick, what do you think?

Looks fine to me too.

I kinda wonder how uswsusp prevents the bdev from being swapoff'd (or
just plain disappearing) such that bd_inode will never point to a
recycled inode, but I guess since we're only comparing pointer values
it's not a big deal for this patch...

Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

