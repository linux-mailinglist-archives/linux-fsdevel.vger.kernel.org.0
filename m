Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6C18F392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgCWLSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 07:18:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgCWLSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ymr0e7RdICUQwi0ZH+vMEGmBcUKM1ZDzJV85bLwglDU=; b=eZ+RTdv1H6xqPbfAS5/8rHuqVZ
        15rJQh7FfZkLsfln33wyeV6Z2Xlmw3T0F6ind95TyJmfdgD+gTd/EFLiTCdwmdcs238aprNM3XCok
        hjKNBo+NHaa+O4CHHmjdm4EJsDGJ6dCYKaazvc+DszgIxMfNv+GUIhzuJwpFn18tcdDXVTfgdqjuZ
        rlrQeAqiRkoGMYhq30q/1GwAaBp6qRX1P+4UU/DK6qzkBy2TggeFMe9O7jsxbvYYixpJVI1SjhlO2
        bRIDuBmA40z249zQQwcvygk+K3pzdThXL9AfRtGBnBdMfmxV6/7OxnYd8rkpNC926D6snCd9jKeQ0
        PgaNBQhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGL6C-0003IJ-2x; Mon, 23 Mar 2020 11:18:28 +0000
Date:   Mon, 23 Mar 2020 04:18:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Salman Qazi <sqazi@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bdev: Reduce time holding bd_mutex in sync in
 blkdev_close()
Message-ID: <20200323111828.GB4554@infradead.org>
References: <20200320110321.1.I9df0264e151a740be292ad3ee3825f31b5997776@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320110321.1.I9df0264e151a740be292ad3ee3825f31b5997776@changeid>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:07:16AM -0700, Douglas Anderson wrote:
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

The idea ok, but I see no point in even taking the lock to check
bd_openers given that it is going to be racy anyway.
