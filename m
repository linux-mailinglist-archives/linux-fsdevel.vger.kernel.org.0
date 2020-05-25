Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206C11E0C33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbgEYKwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 06:52:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46935 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 06:52:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id g25so13488349otp.13;
        Mon, 25 May 2020 03:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kn5DgIdG1SurfUunm0E75UQw8EiNvkA9Al8xtkzW3es=;
        b=UrKk+sGLLOqKUM0I9Yzn8/p9A6G03dglUjaJDaKWpT55VLa31e2zTQpeo9SR5sSlP8
         3iGYvP5OkRyA2p0t8F19ubqEAOeCsA8O0juP+hI4Al8kFHTfHpekk/sEULzHvOD/8dht
         0nkGytgVaTQ6X8seCifi+8SbK/MHjQdjPtzfAFbn7giW+d1GYMZBBGfivXJEuVFdNla/
         o4G/arelHUP2CT80jLNtpgpaHRARCUE8QbshXxKBQ2nRvAbgBNpKAH77BuLdkCDtz4uN
         EQnbjnQVfSeocYqPPmeRZ342ZKkO8AKsCDcgts1cFGAue9EXw+s+6et+wVz2wn5n0Sww
         5icw==
X-Gm-Message-State: AOAM532OdJQlbCKSKpRc/5oQEPPQLYl/Jr92tBpsu3fNuSad41G20PP9
        uiEC/iTc37aiHsbOJpW43mPGnrLzB9D6WORTqKgzfg==
X-Google-Smtp-Source: ABdhPJzN9NDd9Y5vYW/zlgzrOQQ9k3eQjez5M7ybDE92g5OjVQvouP6M4mQN1W/hmM1/gB1byI9HMS7SGlnZuagf08A=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr20639639otc.262.1590403948925;
 Mon, 25 May 2020 03:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200519181410.GA1963@dumbo>
In-Reply-To: <20200519181410.GA1963@dumbo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 May 2020 12:52:17 +0200
Message-ID: <CAJZ5v0jgA3hh3nB60ANKN1WG9py9BoBqp8N8BuM2W-gpcUaPpg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: restrict writes to the resume device
To:     Domenico Andreoli <domenico.andreoli@linux.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@lst.de>,
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

On Tue, May 19, 2020 at 8:14 PM Domenico Andreoli
<domenico.andreoli@linux.com> wrote:
>
> From: Domenico Andreoli <domenico.andreoli@linux.com>
>
> Hibernation via snapshot device requires write permission to the swap
> block device, the one that more often (but not necessarily) is used to
> store the hibernation image.
>
> With this patch, such permissions are granted iff:
>
> 1) snapshot device config option is enabled
> 2) swap partition is used as resume device
>
> In other circumstances the swap device is not writable from userspace.
>
> In order to achieve this, every write attempt to a swap device is
> checked against the device configured as part of the uswsusp API [0]
> using a pointer to the inode struct in memory. If the swap device being
> written was not configured for resuming, the write request is denied.
>
> NOTE: this implementation works only for swap block devices, where the
> inode configured by swapon (which sets S_SWAPFILE) is the same used
> by SNAPSHOT_SET_SWAP_AREA.
>
> In case of swap file, SNAPSHOT_SET_SWAP_AREA indeed receives the inode
> of the block device containing the filesystem where the swap file is
> located (+ offset in it) which is never passed to swapon and then has
> not set S_SWAPFILE.
>
> As result, the swap file itself (as a file) has never an option to be
> written from userspace. Instead it remains writable if accessed directly
> from the containing block device, which is always writeable from root.
>
> [0] Documentation/power/userland-swsusp.rst
>
> v2:
>  - rename is_hibernate_snapshot_dev() to is_hibernate_resume_dev()
>  - fix description so to correctly refer to the resume device
>
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: viro@zeniv.linux.org.uk
> Cc: tytso@mit.edu
> Cc: len.brown@intel.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
>  fs/block_dev.c          |    3 +--
>  include/linux/suspend.h |    6 ++++++
>  kernel/power/user.c     |   14 +++++++++++++-
>  3 files changed, 20 insertions(+), 3 deletions(-)
>
> Index: b/include/linux/suspend.h
> ===================================================================
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -466,6 +466,12 @@ static inline bool system_entering_hiber
>  static inline bool hibernation_available(void) { return false; }
>  #endif /* CONFIG_HIBERNATION */
>
> +#ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
> +int is_hibernate_resume_dev(const struct inode *);
> +#else
> +static inline int is_hibernate_resume_dev(const struct inode *i) { return 0; }
> +#endif
> +
>  /* Hibernation and suspend events */
>  #define PM_HIBERNATION_PREPARE 0x0001 /* Going to hibernate */
>  #define PM_POST_HIBERNATION    0x0002 /* Hibernation finished */
> Index: b/kernel/power/user.c
> ===================================================================
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -35,8 +35,14 @@ static struct snapshot_data {
>         bool ready;
>         bool platform_support;
>         bool free_bitmaps;
> +       struct inode *bd_inode;
>  } snapshot_state;
>
> +int is_hibernate_resume_dev(const struct inode *bd_inode)
> +{
> +       return hibernation_available() && snapshot_state.bd_inode == bd_inode;
> +}
> +
>  static int snapshot_open(struct inode *inode, struct file *filp)
>  {
>         struct snapshot_data *data;
> @@ -95,6 +101,7 @@ static int snapshot_open(struct inode *i
>         data->frozen = false;
>         data->ready = false;
>         data->platform_support = false;
> +       data->bd_inode = NULL;
>
>   Unlock:
>         unlock_system_sleep();
> @@ -110,6 +117,7 @@ static int snapshot_release(struct inode
>
>         swsusp_free();
>         data = filp->private_data;
> +       data->bd_inode = NULL;
>         free_all_swap_pages(data->swap);
>         if (data->frozen) {
>                 pm_restore_gfp_mask();
> @@ -202,6 +210,7 @@ struct compat_resume_swap_area {
>  static int snapshot_set_swap_area(struct snapshot_data *data,
>                 void __user *argp)
>  {
> +       struct block_device *bdev;
>         sector_t offset;
>         dev_t swdev;
>
> @@ -232,9 +241,12 @@ static int snapshot_set_swap_area(struct
>                 data->swap = -1;
>                 return -EINVAL;
>         }
> -       data->swap = swap_type_of(swdev, offset, NULL);
> +       data->swap = swap_type_of(swdev, offset, &bdev);
>         if (data->swap < 0)
>                 return -ENODEV;
> +
> +       data->bd_inode = bdev->bd_inode;
> +       bdput(bdev);
>         return 0;
>  }
>
> Index: b/fs/block_dev.c
> ===================================================================
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -2023,8 +2023,7 @@ ssize_t blkdev_write_iter(struct kiocb *
>         if (bdev_read_only(I_BDEV(bd_inode)))
>                 return -EPERM;
>
> -       /* uswsusp needs write permission to the swap */
> -       if (IS_SWAPFILE(bd_inode) && !hibernation_available())
> +       if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode))
>                 return -ETXTBSY;
>
>         if (!iov_iter_count(from))
>
> --

The patch looks OK to me.

Darrick, what do you think?
