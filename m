Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D0191C99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 23:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgCXWXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 18:23:35 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45408 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgCXWXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:23:33 -0400
Received: by mail-yb1-f193.google.com with SMTP id g6so85341ybh.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVSbSvfz1gZI9ivjqElu8FogAPNCky/2IShtkcLGE5c=;
        b=eldXL0yS3Q3EDVEFAKBWhmWQw023zxMm5bk0EQYWJsHN0RXHhZkuhnruXptdlHs7gR
         axVsJylivgh7YStpxeALbgVusM2S9A8YyJ18r0GfFWAuT/Ah/8WIGyTp9uZXI3LLW0oU
         snjF9CufYzyZnOwnkDuD1Z5vsQNj02Z1tCH2nLz5SkQQqPu0353kKUIaHuAvAx8HaEp4
         OjDzPGmYCMFh0NZayPZfvcqkugb9bIKHE5tVRJRJ18cjOhk6UwS37s6mSMg0FVlUDUSa
         fpVXSPzgEVwg4RcT+pRmEHZ13JEeqx6M7vEMrwQwYR3ql4XSpCe3WKbwgFzdh9fLX7OU
         V5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVSbSvfz1gZI9ivjqElu8FogAPNCky/2IShtkcLGE5c=;
        b=sdTdI0ukOtBEQX/LtLn1Ap47JvhrD2CnLH0GRFxCc2ttnY3DKcqlTziiJoPgLdrAEB
         +o1eRKl+rNZ93Zhewu7jLWhv49wYvHftDSECva0uiafs0V6IgxqFM9ttDE64KHSFNmac
         gBw09Y6itXW9X+8vbEPNTgBWS3V1bKXnvzz/eciNiZp0fMsQN78TzfN9Ldyk9xwpxScO
         ntRorR9mmWdf7WO80e0qeBuASBg6sYTwmjecWvtqtG0HHjYGFtgoDAhUxjrSAfRCA3PG
         ysKYZkvbXZMU73A4QFGMIXUD642AAYJ75VghSXWCUhwDNio2hp3soHrVoh0s6f1fuaBd
         5Z5w==
X-Gm-Message-State: ANhLgQ2cYSBUoar41lgK4CD3he3qMN+69lZG9LU0huH0VqCu4mcyrAfY
        6/MM9mfpjFA5XXANZYKyNPFAQZo90ZmWW84V8g0dEQ==
X-Google-Smtp-Source: ADFU+vvtHPA1BUZ9RZvFsr3GPm+xhQ5DwpJJ71dQ3GblWeF3v+joWD70McIxrAasQibK6I3x2vtnBAqabGB4crXMU58=
X-Received: by 2002:a25:a4c5:: with SMTP id g63mr773676ybi.318.1585088611639;
 Tue, 24 Mar 2020 15:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200324144754.v2.1.I9df0264e151a740be292ad3ee3825f31b5997776@changeid>
In-Reply-To: <20200324144754.v2.1.I9df0264e151a740be292ad3ee3825f31b5997776@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 24 Mar 2020 15:23:20 -0700
Message-ID: <CABXOdTf4kVgcp2AGWe6qvbhZbDjQ++30ASr1R9gt77hjRrcBpQ@mail.gmail.com>
Subject: Re: [PATCH v2] bdev: Reduce time holding bd_mutex in sync in blkdev_close()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Salman Qazi <sqazi@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 2:48 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> While trying to "dd" to the block device for a USB stick, I
> encountered a hung task warning (blocked for > 120 seconds).  I
> managed to come up with an easy way to reproduce this on my system
> (where /dev/sdb is the block device for my USB stick) with:
>
>   while true; do dd if=/dev/zero of=/dev/sdb bs=4M; done
>
> With my reproduction here are the relevant bits from the hung task
> detector:
>
>  INFO: task udevd:294 blocked for more than 122 seconds.
>  ...
>  udevd           D    0   294      1 0x00400008
>  Call trace:
>   ...
>   mutex_lock_nested+0x40/0x50
>   __blkdev_get+0x7c/0x3d4
>   blkdev_get+0x118/0x138
>   blkdev_open+0x94/0xa8
>   do_dentry_open+0x268/0x3a0
>   vfs_open+0x34/0x40
>   path_openat+0x39c/0xdf4
>   do_filp_open+0x90/0x10c
>   do_sys_open+0x150/0x3c8
>   ...
>
>  ...
>  Showing all locks held in the system:
>  ...
>  1 lock held by dd/2798:
>   #0: ffffff814ac1a3b8 (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0x50/0x204
>  ...
>  dd              D    0  2798   2764 0x00400208
>  Call trace:
>   ...
>   schedule+0x8c/0xbc
>   io_schedule+0x1c/0x40
>   wait_on_page_bit_common+0x238/0x338
>   __lock_page+0x5c/0x68
>   write_cache_pages+0x194/0x500
>   generic_writepages+0x64/0xa4
>   blkdev_writepages+0x24/0x30
>   do_writepages+0x48/0xa8
>   __filemap_fdatawrite_range+0xac/0xd8
>   filemap_write_and_wait+0x30/0x84
>   __blkdev_put+0x88/0x204
>   blkdev_put+0xc4/0xe4
>   blkdev_close+0x28/0x38
>   __fput+0xe0/0x238
>   ____fput+0x1c/0x28
>   task_work_run+0xb0/0xe4
>   do_notify_resume+0xfc0/0x14bc
>   work_pending+0x8/0x14
>
> The problem appears related to the fact that my USB disk is terribly
> slow and that I have a lot of RAM in my system to cache things.
> Specifically my writes seem to be happening at ~15 MB/s and I've got
> ~4 GB of RAM in my system that can be used for buffering.  To write 4
> GB of buffer to disk thus takes ~4000 MB / ~15 MB/s = ~267 seconds.
>
> The 267 second number is a problem because in __blkdev_put() we call
> sync_blockdev() while holding the bd_mutex.  Any other callers who
> want the bd_mutex will be blocked for the whole time.
>
> The problem is made worse because I believe blkdev_put() specifically
> tells other tasks (namely udev) to go try to access the device at right
> around the same time we're going to hold the mutex for a long time.
>
> Putting some traces around this (after disabling the hung task detector),
> I could confirm:
>  dd:    437.608600: __blkdev_put() right before sync_blockdev() for sdb
>  udevd: 437.623901: blkdev_open() right before blkdev_get() for sdb
>  dd:    661.468451: __blkdev_put() right after sync_blockdev() for sdb
>  udevd: 663.820426: blkdev_open() right after blkdev_get() for sdb
>
> A simple fix for this is to realize that sync_blockdev() works fine if
> you're not holding the mutex.  Also, it's not the end of the world if
> you sync a little early (though it can have performance impacts).
> Thus we can make a guess that we're going to need to do the sync and
> then do it without holding the mutex.  We still do one last sync with
> the mutex but it should be much, much faster.
>
> With this, my hung task warnings for my test case are gone.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I didn't put a "Fixes" annotation here because, as far as I can tell,
> this issue has been here "forever" unless someone knows of something
> else that changed that made this possible to hit.  This could probably
> get picked back to any stable tree that anyone is still maintaining.
>
> Changes in v2:
> - Don't bother holding the mutex when checking "bd_openers".
>

The checking-under-lock had bothered me as well in v1.
I like this version much more.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
>  fs/block_dev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9501880dff5e..40c57a9cc91a 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1892,6 +1892,16 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
>         struct gendisk *disk = bdev->bd_disk;
>         struct block_device *victim = NULL;
>
> +       /*
> +        * Sync early if it looks like we're the last one.  If someone else
> +        * opens the block device between now and the decrement of bd_openers
> +        * then we did a sync that we didn't need to, but that's not the end
> +        * of the world and we want to avoid long (could be several minute)
> +        * syncs while holding the mutex.
> +        */
> +       if (bdev->bd_openers == 1)
> +               sync_blockdev(bdev);
> +
>         mutex_lock_nested(&bdev->bd_mutex, for_part);
>         if (for_part)
>                 bdev->bd_part_count--;
> --
> 2.25.1.696.g5e7596f4ac-goog
>
