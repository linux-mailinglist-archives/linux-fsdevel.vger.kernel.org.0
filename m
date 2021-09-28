Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB6641A41F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 02:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhI1AWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 20:22:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59028 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhI1AWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 20:22:21 -0400
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18S0Jl6P039939;
        Tue, 28 Sep 2021 09:19:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Tue, 28 Sep 2021 09:19:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18S0JlmW039936
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Sep 2021 09:19:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 1/2] block: make __register_blkdev() return an error
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        efremov@linux.com, song@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, hare@suse.de,
        jack@suse.cz, ming.lei@redhat.com, tj@kernel.org
References: <20210927220332.1074647-1-mcgrof@kernel.org>
 <20210927220332.1074647-2-mcgrof@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <11a884b0-53f2-5174-fcb2-6247cece7104@i-love.sakura.ne.jp>
Date:   Tue, 28 Sep 2021 09:19:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927220332.1074647-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/09/28 7:03, Luis Chamberlain wrote:
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index 5dc9b3d32415..be0627345b21 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1989,24 +1989,34 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
>  
>  static DEFINE_MUTEX(ataflop_probe_lock);
>  
> -static void ataflop_probe(dev_t dev)
> +static int ataflop_probe(dev_t dev)
>  {
>  	int drive = MINOR(dev) & 3;
>  	int type  = MINOR(dev) >> 2;
> +	int err = 0;
>  
>  	if (type)
>  		type--;
>  
> -	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
> -		return;
> +	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	mutex_lock(&ataflop_probe_lock);
>  	if (!unit[drive].disk[type]) {
> -		if (ataflop_alloc_disk(drive, type) == 0) {
> -			add_disk(unit[drive].disk[type]);
> +		err = ataflop_alloc_disk(drive, type);
> +		if (err == 0) {
> +			err = add_disk(unit[drive].disk[type]);
> +			if (err)
> +				blk_cleanup_disk(unit[drive].disk[type]);
>  			unit[drive].registered[type] = true;

Why setting registered to true despite add_disk() failed?
del_gendisk() without successful add_disk() sounds wrong.

Don't we need to undo ataflop_alloc_disk() because it sets
unit[drive].disk[type] to non-NULL ?

>  		}
>  	}
>  	mutex_unlock(&ataflop_probe_lock);
> +
> +out:
> +	return err;
>  }
>  
>  static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)



> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index c2bf4946f4e3..82a93044de95 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -426,10 +426,11 @@ static int brd_alloc(int i)
>  	return err;
>  }
>  
> -static void brd_probe(dev_t dev)
> +static int brd_probe(dev_t dev)
>  {
>  	int i = MINOR(dev) / max_part;
>  	struct brd_device *brd;
> +	int err = 0;
>  
>  	mutex_lock(&brd_devices_mutex);
>  	list_for_each_entry(brd, &brd_devices, brd_list) {
> @@ -437,9 +438,11 @@ static void brd_probe(dev_t dev)
>  			goto out_unlock;
>  	}
>  
> -	brd_alloc(i);
> +	err = brd_alloc(i);
>  out_unlock:
>  	mutex_unlock(&brd_devices_mutex);
> +
> +	return err;
>  }
>  
>  static void brd_del_one(struct brd_device *brd)

https://lkml.kernel.org/r/e205f13d-18ff-a49c-0988-7de6ea5ff823@i-love.sakura.ne.jp
will require this part to be updated.


> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 0434f28742e7..95a1c8ef62f7 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4517,21 +4517,27 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
>  
>  static DEFINE_MUTEX(floppy_probe_lock);
>  
> -static void floppy_probe(dev_t dev)
> +static int floppy_probe(dev_t dev)
>  {
>  	unsigned int drive = (MINOR(dev) & 3) | ((MINOR(dev) & 0x80) >> 5);
>  	unsigned int type = (MINOR(dev) >> 2) & 0x1f;
> +	int err = 0;
>  
>  	if (drive >= N_DRIVE || !floppy_available(drive) ||
>  	    type >= ARRAY_SIZE(floppy_type))
> -		return;
> +		return -EINVAL;
>  
>  	mutex_lock(&floppy_probe_lock);
>  	if (!disks[drive][type]) {
> -		if (floppy_alloc_disk(drive, type) == 0)
> -			add_disk(disks[drive][type]);
> +		if (floppy_alloc_disk(drive, type) == 0) {
> +			err = add_disk(disks[drive][type]);
> +			if (err)
> +				blk_cleanup_disk(disks[drive][type]);

This makes future floppy_probe() no-op once add_disk() failed (or maybe a bad
thing happens somewhere else), for disks[drive][type] was set to non-NULL by
floppy_alloc_disk() but blk_cleanup_disk() does not reset it to NULL.

According to floppy_module_exit() which tries to cleanup it, implementing
undo might be complicated...

> +		}
>  	}
>  	mutex_unlock(&floppy_probe_lock);
> +
> +	return err;
>  }
>  
>  static int __init do_floppy_init(void)

