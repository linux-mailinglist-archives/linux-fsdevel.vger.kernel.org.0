Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22126E258
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIQR1l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:27:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43456 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgIQR1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:27:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id i17so3339062oig.10;
        Thu, 17 Sep 2020 10:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ti1DSc22l1OTXWw3UqGRGhr/gUl2umii2yhtCBxuHDg=;
        b=mW/dK8jQGFhBKHyOVFHzgvFJStShWozFsTX18/lU7wXogFmqz5mveGy9lGV7qQyZVz
         lxP4+2J/m1VXNoNqPSxQEExwloUk/fac39/nokwUZZ2SwWomIxfW5Q37oJqmUuKYFyAL
         VJmeETJo9UVA9FiN6v/P5O2c8g99Fsmfr14XvL/7ivMIkRlgn9p4YlIN64UKDcuhOewm
         YdW8h48Ks09vK56FeZuyhGoMuPd7SSfi6fXFaZXMpJZ/kOtzf/xddQoEQ/jZzjOpDiQ6
         wBMA0MV7Het1Rvip6R3dugQeuEg/vao3dMD0Fa1Ej5rRT2WBNPK+rCVUiJFNEDNsSnUA
         25RQ==
X-Gm-Message-State: AOAM530sq6gIXcibpL6WNtUHXGTY3FnXn1cMnU0oU7xN5sG7MDSm08QN
        fhaeiZTTaYQ1BV74vNhlVgOpAfjTOCvoppsu6ys=
X-Google-Smtp-Source: ABdhPJyxWcNaiYYx/PgKQVmfX9UkChVN7amPa6jbDo4mZp02WYuGpLkS7XSRAAssnMS4AZvrpL/9pXv3g76gc1DAJ3I=
X-Received: by 2002:aca:df84:: with SMTP id w126mr7311183oig.103.1600363614359;
 Thu, 17 Sep 2020 10:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200917165720.3285256-1-hch@lst.de> <20200917165720.3285256-12-hch@lst.de>
In-Reply-To: <20200917165720.3285256-12-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Sep 2020 19:26:43 +0200
Message-ID: <CAJZ5v0gF1_JLP6B6Ecnax1w72GxRUUhPxs0q7ciT=Q2U=LQD9Q@mail.gmail.com>
Subject: Re: [PATCH 11/14] PM: rewrite is_hibernate_resume_dev to not require
 an inode
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nbd@other.debian.org,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 7:24 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Just check the dev_t to help simplifying the code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  fs/block_dev.c          |  2 +-
>  include/linux/suspend.h |  4 ++--
>  kernel/power/user.c     | 12 ++++++------
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 1a9325f4315769..2898d69be6b3e4 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1885,7 +1885,7 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         if (bdev_read_only(I_BDEV(bd_inode)))
>                 return -EPERM;
>
> -       if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode))
> +       if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode->i_rdev))
>                 return -ETXTBSY;
>
>         if (!iov_iter_count(from))
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index cb9afad82a90c8..8af13ba60c7e45 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -473,9 +473,9 @@ static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
>  #endif /* CONFIG_HIBERNATION */
>
>  #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
> -int is_hibernate_resume_dev(const struct inode *);
> +int is_hibernate_resume_dev(dev_t dev);
>  #else
> -static inline int is_hibernate_resume_dev(const struct inode *i) { return 0; }
> +static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
>  #endif
>
>  /* Hibernation and suspend events */
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index d5eedc2baa2a10..b5815685b944fe 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -35,12 +35,12 @@ static struct snapshot_data {
>         bool ready;
>         bool platform_support;
>         bool free_bitmaps;
> -       struct inode *bd_inode;
> +       dev_t dev;
>  } snapshot_state;
>
> -int is_hibernate_resume_dev(const struct inode *bd_inode)
> +int is_hibernate_resume_dev(dev_t dev)
>  {
> -       return hibernation_available() && snapshot_state.bd_inode == bd_inode;
> +       return hibernation_available() && snapshot_state.dev == dev;
>  }
>
>  static int snapshot_open(struct inode *inode, struct file *filp)
> @@ -101,7 +101,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>         data->frozen = false;
>         data->ready = false;
>         data->platform_support = false;
> -       data->bd_inode = NULL;
> +       data->dev = 0;
>
>   Unlock:
>         unlock_system_sleep();
> @@ -117,7 +117,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
>
>         swsusp_free();
>         data = filp->private_data;
> -       data->bd_inode = NULL;
> +       data->dev = 0;
>         free_all_swap_pages(data->swap);
>         if (data->frozen) {
>                 pm_restore_gfp_mask();
> @@ -245,7 +245,7 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
>         if (data->swap < 0)
>                 return -ENODEV;
>
> -       data->bd_inode = bdev->bd_inode;
> +       data->dev = bdev->bd_dev;
>         bdput(bdev);
>         return 0;
>  }
> --
> 2.28.0
>
