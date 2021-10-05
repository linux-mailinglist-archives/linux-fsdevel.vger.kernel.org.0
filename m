Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1642327C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 22:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhJEU6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 16:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhJEU6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:58:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172EC061749
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 13:57:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v19so561592pjh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+sMQPLCyYA4dgDA1po3mBpk0YoEDbPhmdJtIoH1yHg=;
        b=kVgnrWPqt/8TfKL7BNZmPQgr0QNgPXvvZytDS2h5kaHcpxqTbADjBCJ/Abt2MRD2ho
         AQE6rA2089pPBRBYTGNYGFKtDpFFZRx90vfQSkxbm4IaXQ3Pq8Gm9EV0WQBnS6muswp+
         oqVLs9ZzfyMttc3apez4GOzOBxGUI3GFG9IZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+sMQPLCyYA4dgDA1po3mBpk0YoEDbPhmdJtIoH1yHg=;
        b=bLrRs80gdbvc2XuV/LbfCPbDkDpH+caHKcyzQL/Fnkxk8P9lgwvQxE7rIcMpKI3z+r
         T1wtOXXDn32/1h8usk9AQYmWq0oTCJ8PLmZyYXR7oBmsdx+K5nqa21+kD7O0TkdgXKLY
         ha6S5jRg6/SZiM5V4qBOC8wc6jSt7i8mSGGJSP7WIjO1VeVhwOgS6RGDZLC4Qm5Qnu/6
         76eSbNOX7E+TSOqxv1/lIWj8qx7qsBYetie2/tisWBl6ANdho0Ua6zDLCHrsQ92aeVTL
         ZbCDseoDIFG3y8XokJQytAsHOVBpsD8pRaP22Wcl2JOUzAZyx3lpa43RgsASAG+oOZOn
         MTkQ==
X-Gm-Message-State: AOAM530+Eo4WwzHvi16m09fHP82O3uMfwnwuCxHB4XdBzrfNvBtJ+ysj
        WJDiQGpwYYQ4QkYjviw3p7s25w==
X-Google-Smtp-Source: ABdhPJy7Oi6ah2YEoAsHtUO4Oj62iQ0k+3Z363yUYvVg6uJCzv8mP6M8mdrm/8nMPcYAbOMuxZNFfA==
X-Received: by 2002:a17:90a:1984:: with SMTP id 4mr6348154pji.87.1633467421458;
        Tue, 05 Oct 2021 13:57:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u12sm3312455pjr.2.2021.10.05.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:57:01 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:57:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] zram: use ATTRIBUTE_GROUPS to fix sysfs
 deadlock module removal
Message-ID: <202110051356.D8B18C4@keescook>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-13-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-13-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:38:05AM -0700, Luis Chamberlain wrote:
> The ATTRIBUTE_GROUPS is typically used to avoid boiler plate
> code which is used in many drivers. Embracing ATTRIBUTE_GROUPS was
> long due on the zram driver, however a recent fix for sysfs allows
> users of ATTRIBUTE_GROUPS to also associate a module to the group
> attribute.

Does this mean that other modules using sysfs but _not_
ATTRIBUTE_GROUPS() are still vulnerable to potential use-after-free of
the kernfs fops?

-Kees

> 
> In zram's case this also means it allows us to fix a race which triggers
> a deadlock on the zram driver. This deadlock happens when a sysfs attribute
> use a lock also used on module removal. This happens when for instance a
> sysfs file on a driver is used, then at the same time we have module
> removal call trigger. The module removal call code holds a lock, and then
> the sysfs file entry waits for the same lock. While holding the lock the
> module removal tries to remove the sysfs entries, but these cannot be
> removed yet as one is waiting for a lock. This won't complete as the lock
> is already held. Likewise module removal cannot complete, and so we
> deadlock.
> 
> Sysfs fixes this when the group attributes have a module associated to
> it, sysfs will *try* to get a refcount to the module when a shared
> lock is used, prior to mucking with a sysfs attribute. If this fails we
> just give up right away.
> 
> This deadlock was first reported with the zram driver, a sketch of how
> this can happen follows:
> 
> CPU A                              CPU B
>                                    whatever_store()
> module_unload
>   mutex_lock(foo)
>                                    mutex_lock(foo)
>    del_gendisk(zram->disk);
>      device_del()
>        device_remove_groups()
> 
> In this situation whatever_store() is waiting for the mutex foo to
> become unlocked, but that won't happen until module removal is complete.
> But module removal won't complete until the sysfs file being poked
> completes which is waiting for a lock already held.
> 
> This issue can be reproduced easily on the zram driver as follows:
> 
> Loop 1 on one terminal:
> 
> while true;
> 	do modprobe zram;
> 	modprobe -r zram;
> done
> 
> Loop 2 on a second terminal:
> while true; do
> 	echo 1024 >  /sys/block/zram0/disksize;
> 	echo 1 > /sys/block/zram0/reset;
> done
> 
> Without this patch we end up in a deadlock, and the following
> stack trace is produced which hints to us what the issue was:
> 
> INFO: task bash:888 blocked for more than 120 seconds.
>       Tainted: G            E 5.12.0-rc1-next-20210304+ #4
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:bash            state:D stack:    0 pid:  888 ppid: 887 flags:<etc>
> Call Trace:
>  __schedule+0x2e4/0x900
>  schedule+0x46/0xb0
>  schedule_preempt_disabled+0xa/0x10
>  __mutex_lock.constprop.0+0x2c3/0x490
>  ? _kstrtoull+0x35/0xd0
>  reset_store+0x6c/0x160 [zram]
>  kernfs_fop_write_iter+0x124/0x1b0
>  new_sync_write+0x11c/0x1b0
>  vfs_write+0x1c2/0x260
>  ksys_write+0x5f/0xe0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f34f2c3df33
> RSP: 002b:00007ffe751df6e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f34f2c3df33
> RDX: 0000000000000002 RSI: 0000561ccb06ec10 RDI: 0000000000000001
> RBP: 0000561ccb06ec10 R08: 000000000000000a R09: 0000000000000001
> R10: 0000561ccb157590 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007f34f2d0e6a0 R14: 0000000000000002 R15: 00007f34f2d0e8a0
> INFO: task modprobe:1104 can't die for more than 120 seconds.
> task:modprobe        state:D stack:    0 pid: 1104 ppid: 916 flags:<etc>
> Call Trace:
>  __schedule+0x2e4/0x900
>  schedule+0x46/0xb0
>  __kernfs_remove.part.0+0x228/0x2b0
>  ? finish_wait+0x80/0x80
>  kernfs_remove_by_name_ns+0x50/0x90
>  remove_files+0x2b/0x60
>  sysfs_remove_group+0x38/0x80
>  sysfs_remove_groups+0x29/0x40
>  device_remove_attrs+0x4a/0x80
>  device_del+0x183/0x3e0
>  ? mutex_lock+0xe/0x30
>  del_gendisk+0x27a/0x2d0
>  zram_remove+0x8a/0xb0 [zram]
>  ? hot_remove_store+0xf0/0xf0 [zram]
>  zram_remove_cb+0xd/0x10 [zram]
>  idr_for_each+0x5e/0xd0
>  destroy_devices+0x39/0x6f [zram]
>  __do_sys_delete_module+0x190/0x2a0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f32adf727d7
> RSP: 002b:00007ffc08bb38a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> RAX: ffffffffffffffda RBX: 000055eea23cbb10 RCX: 00007f32adf727d7
> RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055eea23cbb78
> RBP: 000055eea23cbb10 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007f32adfe5ac0 R11: 0000000000000206 R12: 000055eea23cbb78
> R13: 0000000000000000 R14: 0000000000000000 R15: 000055eea23cbc20
> 
> [0] https://lkml.kernel.org/r/20210401235925.GR4332@42.do-not-panic.com
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/zram/zram_drv.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index b26abcb955cc..60a55ae8cd91 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1902,14 +1902,7 @@ static struct attribute *zram_disk_attrs[] = {
>  	NULL,
>  };
>  
> -static const struct attribute_group zram_disk_attr_group = {
> -	.attrs = zram_disk_attrs,
> -};
> -
> -static const struct attribute_group *zram_disk_attr_groups[] = {
> -	&zram_disk_attr_group,
> -	NULL,
> -};
> +ATTRIBUTE_GROUPS(zram_disk);
>  
>  /*
>   * Allocate and initialize new zram device. the function returns
> @@ -1981,7 +1974,7 @@ static int zram_add(void)
>  		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
>  
>  	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, zram->disk->queue);
> -	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
> +	device_add_disk(NULL, zram->disk, zram_disk_groups);
>  
>  	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
>  
> -- 
> 2.30.2
> 

-- 
Kees Cook
