Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB701B1029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgDTPan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgDTPan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:30:43 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A5DC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 08:30:42 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so8845433ilp.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 08:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6hY2e7V+n8Wl4xNoUPcCBYpmb9tG1We42hYqz+y59M0=;
        b=calNWgGiCEjsReU19ectmceeART7rDQaqrf9b5FXvLDfbulvXpQXKKEIXIAY1d+Yku
         TBmfn3MZJN46TnQngEYtnd5l245LE8y/8t41z3GSolQkZrwtXF5M76ysnSZlRWRPwDp3
         NlhtXH3lPlC5MwbRuFJUsTVGdWnn0vT58S48Ycy4eOQPLp83bTramUumgAJuVv7cedAv
         +5JI+6zILcpqFyNJYCcU7XpciWgBx1/b8SEGgMKzkzVvkVNbrZ2tkIEFSwrtsKY7TBML
         CBam0eOULU52hmYf919jqt3evSDhEebbE89QNTRbx/wdASWl4K3CJqhCpWs3ybXQeP/K
         /GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6hY2e7V+n8Wl4xNoUPcCBYpmb9tG1We42hYqz+y59M0=;
        b=AoC1udwMIYrwVOPb9/ehSS9DtZYwBQA6c6E47/O4ADJF9vyKVd70UvMchy3ZAYxEmz
         Rd8gItvABb99mhiuEwcz+rx9fmBsoVSNoYb0PuaEPLcjwl0MlMPZWRf0EKC1x/Ea9mgK
         KYAFCtwGHdYR+8ZvfGecjpXv1uKyzYFwDqbXbpceoV+oGqSmBrcZJuHPk8T/JHj0JpUQ
         jj2NTJZWaFGEYKH4zaolvXDdDziQIiDKggRWrCzkit9AeuwJrwBsewfPkyT+tcr8RsoD
         +GaF1EhhkggSRbtAMF5Par2A7NrPH1SKYwfdij9pFbF9WixZRP/HadcVG0wO8sMXS3Ce
         FjWw==
X-Gm-Message-State: AGi0PuZ0BYmaDofak0IRzkGOTE/HavuWzz+WsBUpCfq39t51rQDscsWe
        5tO8BxOmA6eecgNEBgP7Bg+/3A==
X-Google-Smtp-Source: APiQypIHZIexbLMyWevVKSOTVT25hRoMdBJNE4i4FR0q8T1iWQI2Wc44ea779q8kEvI/3uXZLi8psg==
X-Received: by 2002:a92:5ed1:: with SMTP id f78mr15300632ilg.67.1587396641969;
        Mon, 20 Apr 2020 08:30:41 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y3sm389123ila.70.2020.04.20.08.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 08:30:41 -0700 (PDT)
Subject: Re: [PATCH v2] bdev: Reduce time holding bd_mutex in sync in
 blkdev_close()
To:     Doug Anderson <dianders@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Salman Qazi <sqazi@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20200324144754.v2.1.I9df0264e151a740be292ad3ee3825f31b5997776@changeid>
 <CAD=FV=Uu-5quAn4w+9t3zRYcnLBx_PyoN1FE9_io4yvoxcA4Fg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25800c6a-a3d4-5726-086d-8b86fb6eeb89@kernel.dk>
Date:   Mon, 20 Apr 2020 09:30:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Uu-5quAn4w+9t3zRYcnLBx_PyoN1FE9_io4yvoxcA4Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/20/20 8:51 AM, Doug Anderson wrote:
> Hi Alexander,
> 
> On Tue, Mar 24, 2020 at 2:48 PM Douglas Anderson <dianders@chromium.org> wrote:
>>
>> While trying to "dd" to the block device for a USB stick, I
>> encountered a hung task warning (blocked for > 120 seconds).  I
>> managed to come up with an easy way to reproduce this on my system
>> (where /dev/sdb is the block device for my USB stick) with:
>>
>>   while true; do dd if=/dev/zero of=/dev/sdb bs=4M; done
>>
>> With my reproduction here are the relevant bits from the hung task
>> detector:
>>
>>  INFO: task udevd:294 blocked for more than 122 seconds.
>>  ...
>>  udevd           D    0   294      1 0x00400008
>>  Call trace:
>>   ...
>>   mutex_lock_nested+0x40/0x50
>>   __blkdev_get+0x7c/0x3d4
>>   blkdev_get+0x118/0x138
>>   blkdev_open+0x94/0xa8
>>   do_dentry_open+0x268/0x3a0
>>   vfs_open+0x34/0x40
>>   path_openat+0x39c/0xdf4
>>   do_filp_open+0x90/0x10c
>>   do_sys_open+0x150/0x3c8
>>   ...
>>
>>  ...
>>  Showing all locks held in the system:
>>  ...
>>  1 lock held by dd/2798:
>>   #0: ffffff814ac1a3b8 (&bdev->bd_mutex){+.+.}, at: __blkdev_put+0x50/0x204
>>  ...
>>  dd              D    0  2798   2764 0x00400208
>>  Call trace:
>>   ...
>>   schedule+0x8c/0xbc
>>   io_schedule+0x1c/0x40
>>   wait_on_page_bit_common+0x238/0x338
>>   __lock_page+0x5c/0x68
>>   write_cache_pages+0x194/0x500
>>   generic_writepages+0x64/0xa4
>>   blkdev_writepages+0x24/0x30
>>   do_writepages+0x48/0xa8
>>   __filemap_fdatawrite_range+0xac/0xd8
>>   filemap_write_and_wait+0x30/0x84
>>   __blkdev_put+0x88/0x204
>>   blkdev_put+0xc4/0xe4
>>   blkdev_close+0x28/0x38
>>   __fput+0xe0/0x238
>>   ____fput+0x1c/0x28
>>   task_work_run+0xb0/0xe4
>>   do_notify_resume+0xfc0/0x14bc
>>   work_pending+0x8/0x14
>>
>> The problem appears related to the fact that my USB disk is terribly
>> slow and that I have a lot of RAM in my system to cache things.
>> Specifically my writes seem to be happening at ~15 MB/s and I've got
>> ~4 GB of RAM in my system that can be used for buffering.  To write 4
>> GB of buffer to disk thus takes ~4000 MB / ~15 MB/s = ~267 seconds.
>>
>> The 267 second number is a problem because in __blkdev_put() we call
>> sync_blockdev() while holding the bd_mutex.  Any other callers who
>> want the bd_mutex will be blocked for the whole time.
>>
>> The problem is made worse because I believe blkdev_put() specifically
>> tells other tasks (namely udev) to go try to access the device at right
>> around the same time we're going to hold the mutex for a long time.
>>
>> Putting some traces around this (after disabling the hung task detector),
>> I could confirm:
>>  dd:    437.608600: __blkdev_put() right before sync_blockdev() for sdb
>>  udevd: 437.623901: blkdev_open() right before blkdev_get() for sdb
>>  dd:    661.468451: __blkdev_put() right after sync_blockdev() for sdb
>>  udevd: 663.820426: blkdev_open() right after blkdev_get() for sdb
>>
>> A simple fix for this is to realize that sync_blockdev() works fine if
>> you're not holding the mutex.  Also, it's not the end of the world if
>> you sync a little early (though it can have performance impacts).
>> Thus we can make a guess that we're going to need to do the sync and
>> then do it without holding the mutex.  We still do one last sync with
>> the mutex but it should be much, much faster.
>>
>> With this, my hung task warnings for my test case are gone.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> I didn't put a "Fixes" annotation here because, as far as I can tell,
>> this issue has been here "forever" unless someone knows of something
>> else that changed that made this possible to hit.  This could probably
>> get picked back to any stable tree that anyone is still maintaining.
>>
>> Changes in v2:
>> - Don't bother holding the mutex when checking "bd_openers".
>>
>>  fs/block_dev.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 9501880dff5e..40c57a9cc91a 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -1892,6 +1892,16 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
>>         struct gendisk *disk = bdev->bd_disk;
>>         struct block_device *victim = NULL;
>>
>> +       /*
>> +        * Sync early if it looks like we're the last one.  If someone else
>> +        * opens the block device between now and the decrement of bd_openers
>> +        * then we did a sync that we didn't need to, but that's not the end
>> +        * of the world and we want to avoid long (could be several minute)
>> +        * syncs while holding the mutex.
>> +        */
>> +       if (bdev->bd_openers == 1)
>> +               sync_blockdev(bdev);
>> +
>>         mutex_lock_nested(&bdev->bd_mutex, for_part);
>>         if (for_part)
>>                 bdev->bd_part_count--;
>> --
>> 2.25.1.696.g5e7596f4ac-goog
> 
> Are you the right person to land this patch?  If so, is there anything
> else that needs to be done?  Jens: if you should be the person to land
> (as suggested by "git log" but not by "get_maintainer") I'm happy to
> repost with collected tags.  Originally I trusted "get_maintainer" to
> help point me to the right person.

I can queue it up, looks good to me.

-- 
Jens Axboe

