Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9501E48FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbgE0P6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 11:58:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35792 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgE0P6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 11:58:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id 69so19563657otv.2;
        Wed, 27 May 2020 08:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQuabQyL0NgSQawHuCBbM06Uabm6iw+SZxZ1s5FLlmI=;
        b=ADgKb0M1LMTLd2J7P5FDwQkUC4jZvTZSBEq9vaYT/2NoPMMavFSlnAdSTDX8Z0KpmD
         UlT28gPqLSx/0HmfsYKL9WUvHngIwzS3EARQyiYrw9Do2BADkUX/5pu0PONh3VEJ+n8i
         9POT/agPfyqanMg35yrDAfCQrF4UBkaXxJPcwRRcxroeyuY8ftIYsT0DP+GicHabyV/k
         MF3faPCE86+yQndZTcEXePUCF/mwEd0H7BWBn0IWQFpuKSxv44RMZ8SOMuEvYpSReCum
         70h20yUCi+unX80ARit3DnZGEV3f33HSDUtwK0phUoTMEYgc2kdJKSmZAuuvo6ynf/Nq
         JFVw==
X-Gm-Message-State: AOAM533EJgYwIvbUpuG6rgmIqATM+qGjlMKN2rR/0Bi/DnO638edQl3f
        aSKISilHIZVCgColULKCiKJsFtUn45zsuqbRrT4=
X-Google-Smtp-Source: ABdhPJxZVUkNZZJOj47bYNYMRKPYK5sTIzrR5L6ethTLfIfWOYb2kkqtX77sqotxWR7aaeZzl2Agv4JRbcsf2h3jXXw=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr5178288otc.262.1590595103734;
 Wed, 27 May 2020 08:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200519181410.GA1963@dumbo> <CAJZ5v0jgA3hh3nB60ANKN1WG9py9BoBqp8N8BuM2W-gpcUaPpg@mail.gmail.com>
 <20200526161932.GD252930@magnolia>
In-Reply-To: <20200526161932.GD252930@magnolia>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 May 2020 17:58:12 +0200
Message-ID: <CAJZ5v0giCLCqVCTNZW64UYnZvgmOd492YuwUH2KDaWyP4aX+TQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: restrict writes to the resume device
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 6:19 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Mon, May 25, 2020 at 12:52:17PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 19, 2020 at 8:14 PM Domenico Andreoli
> > <domenico.andreoli@linux.com> wrote:
> > >
> > > From: Domenico Andreoli <domenico.andreoli@linux.com>
> > >
> > > Hibernation via snapshot device requires write permission to the swap
> > > block device, the one that more often (but not necessarily) is used to
> > > store the hibernation image.
> > >
> > > With this patch, such permissions are granted iff:
> > >
> > > 1) snapshot device config option is enabled
> > > 2) swap partition is used as resume device
> > >
> > > In other circumstances the swap device is not writable from userspace.
> > >
> > > In order to achieve this, every write attempt to a swap device is
> > > checked against the device configured as part of the uswsusp API [0]
> > > using a pointer to the inode struct in memory. If the swap device being
> > > written was not configured for resuming, the write request is denied.
> > >
> > > NOTE: this implementation works only for swap block devices, where the
> > > inode configured by swapon (which sets S_SWAPFILE) is the same used
> > > by SNAPSHOT_SET_SWAP_AREA.
> > >
> > > In case of swap file, SNAPSHOT_SET_SWAP_AREA indeed receives the inode
> > > of the block device containing the filesystem where the swap file is
> > > located (+ offset in it) which is never passed to swapon and then has
> > > not set S_SWAPFILE.
> > >
> > > As result, the swap file itself (as a file) has never an option to be
> > > written from userspace. Instead it remains writable if accessed directly
> > > from the containing block device, which is always writeable from root.
> > >
> > > [0] Documentation/power/userland-swsusp.rst
> > >
> > > v2:
> > >  - rename is_hibernate_snapshot_dev() to is_hibernate_resume_dev()
> > >  - fix description so to correctly refer to the resume device
> > >
> > > Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: viro@zeniv.linux.org.uk
> > > Cc: tytso@mit.edu
> > > Cc: len.brown@intel.com
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: linux-mm@kvack.org
> > > Cc: linux-xfs@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > >
> > > ---
> > >  fs/block_dev.c          |    3 +--
> > >  include/linux/suspend.h |    6 ++++++
> > >  kernel/power/user.c     |   14 +++++++++++++-
> > >  3 files changed, 20 insertions(+), 3 deletions(-)
> > >
> > > Index: b/include/linux/suspend.h
> > > ===================================================================
> > > --- a/include/linux/suspend.h
> > > +++ b/include/linux/suspend.h
> > > @@ -466,6 +466,12 @@ static inline bool system_entering_hiber
> > >  static inline bool hibernation_available(void) { return false; }
> > >  #endif /* CONFIG_HIBERNATION */
> > >
> > > +#ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
> > > +int is_hibernate_resume_dev(const struct inode *);
> > > +#else
> > > +static inline int is_hibernate_resume_dev(const struct inode *i) { return 0; }
> > > +#endif
> > > +
> > >  /* Hibernation and suspend events */
> > >  #define PM_HIBERNATION_PREPARE 0x0001 /* Going to hibernate */
> > >  #define PM_POST_HIBERNATION    0x0002 /* Hibernation finished */
> > > Index: b/kernel/power/user.c
> > > ===================================================================
> > > --- a/kernel/power/user.c
> > > +++ b/kernel/power/user.c
> > > @@ -35,8 +35,14 @@ static struct snapshot_data {
> > >         bool ready;
> > >         bool platform_support;
> > >         bool free_bitmaps;
> > > +       struct inode *bd_inode;
> > >  } snapshot_state;
> > >
> > > +int is_hibernate_resume_dev(const struct inode *bd_inode)
> > > +{
> > > +       return hibernation_available() && snapshot_state.bd_inode == bd_inode;
> > > +}
> > > +
> > >  static int snapshot_open(struct inode *inode, struct file *filp)
> > >  {
> > >         struct snapshot_data *data;
> > > @@ -95,6 +101,7 @@ static int snapshot_open(struct inode *i
> > >         data->frozen = false;
> > >         data->ready = false;
> > >         data->platform_support = false;
> > > +       data->bd_inode = NULL;
> > >
> > >   Unlock:
> > >         unlock_system_sleep();
> > > @@ -110,6 +117,7 @@ static int snapshot_release(struct inode
> > >
> > >         swsusp_free();
> > >         data = filp->private_data;
> > > +       data->bd_inode = NULL;
> > >         free_all_swap_pages(data->swap);
> > >         if (data->frozen) {
> > >                 pm_restore_gfp_mask();
> > > @@ -202,6 +210,7 @@ struct compat_resume_swap_area {
> > >  static int snapshot_set_swap_area(struct snapshot_data *data,
> > >                 void __user *argp)
> > >  {
> > > +       struct block_device *bdev;
> > >         sector_t offset;
> > >         dev_t swdev;
> > >
> > > @@ -232,9 +241,12 @@ static int snapshot_set_swap_area(struct
> > >                 data->swap = -1;
> > >                 return -EINVAL;
> > >         }
> > > -       data->swap = swap_type_of(swdev, offset, NULL);
> > > +       data->swap = swap_type_of(swdev, offset, &bdev);
> > >         if (data->swap < 0)
> > >                 return -ENODEV;
> > > +
> > > +       data->bd_inode = bdev->bd_inode;
> > > +       bdput(bdev);
> > >         return 0;
> > >  }
> > >
> > > Index: b/fs/block_dev.c
> > > ===================================================================
> > > --- a/fs/block_dev.c
> > > +++ b/fs/block_dev.c
> > > @@ -2023,8 +2023,7 @@ ssize_t blkdev_write_iter(struct kiocb *
> > >         if (bdev_read_only(I_BDEV(bd_inode)))
> > >                 return -EPERM;
> > >
> > > -       /* uswsusp needs write permission to the swap */
> > > -       if (IS_SWAPFILE(bd_inode) && !hibernation_available())
> > > +       if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode))
> > >                 return -ETXTBSY;
> > >
> > >         if (!iov_iter_count(from))
> > >
> > > --
> >
> > The patch looks OK to me.
> >
> > Darrick, what do you think?
>
> Looks fine to me too.
>
> I kinda wonder how uswsusp prevents the bdev from being swapoff'd (or
> just plain disappearing) such that bd_inode will never point to a
> recycled inode, but I guess since we're only comparing pointer values
> it's not a big deal for this patch...
>
> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks!

So the patch has been applied as 5.8 material.

Cheers!
