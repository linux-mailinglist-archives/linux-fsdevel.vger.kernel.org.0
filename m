Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7785C42326D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhJEU52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 16:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhJEU51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:57:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D72C061755
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 13:55:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q7-20020a17090a2e0700b001a01027dd88so1157150pjd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h7zWE9i31jJzq3G+G/eSac16EOy/detiV+gtQhd4eec=;
        b=YalS4ndWc1pOJnfLOw2FOzVkMJ0gRp7H+c7RrfXlgaXpBH+PhGZ1+WWfPD9rnIQlqx
         yAL/HJZvvuaSmCHF1XCMCpcckDM3CrICvS4h/Ww0u1YlHk5AVz96Guy5cBt1ohuB47jK
         KWChHrmy9Qz4BQ1LKh7aDCzmZnjXvmjMy4QHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h7zWE9i31jJzq3G+G/eSac16EOy/detiV+gtQhd4eec=;
        b=TubKX74DApmbyFe8Af88sqKdQR956X2zAjzoFtChj9HSafz6aJkYNNqxjZHlDVThxC
         WN1EwAGNadoXl6Y5SdEnLlWCPJVT7vQAOTVj1l2+7UYbp/8ki2bA1ci7LX324PPdbVOH
         OdsHnKvag8x++apy5vuW8Iar8FRQsGEAmkOndIHzez60SyE4OCYistK/BXqv4J9KzCbH
         A0GE0J7jnsxILNo5i/Hj5Y8JfuV0i+33GwNqzyffiMDVtx34RImpBDrXOP0mH5Hcwk5K
         6aG25iIi1XE+wM6JejhEgxCfJS0ZmBqr+JFOx2drMPPXqLreHQM0hjH6Xpf9QyVTSAJh
         sr9w==
X-Gm-Message-State: AOAM5311amfaWetMruQ/B2a742C6K1bJvTib7quGcAZGRtbZ97f2vkkc
        pB4q3BNw9/ZiXRMEKaKMy+l8vw==
X-Google-Smtp-Source: ABdhPJx7L/0BKISnehLwb1nAnaLV8srvJJkE6kb2I5RDqGbXVzD1Zmcg3FWiV1GbQe338+30GyCGBA==
X-Received: by 2002:a17:902:d707:b0:13d:bbe8:bcff with SMTP id w7-20020a170902d70700b0013dbbe8bcffmr7115384ply.75.1633467336281;
        Tue, 05 Oct 2021 13:55:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i27sm18171327pfq.184.2021.10.05.13.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:55:35 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:55:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <202110051354.294E28AC87@keescook>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-12-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:38:04AM -0700, Luis Chamberlain wrote:
> Provide a simple state machine to fix races with driver exit where we
> remove the CPU multistate callbacks and re-initialization / creation of
> new per CPU instances which should be managed by these callbacks.
> 
> The zram driver makes use of cpu hotplug multistate support, whereby it
> associates a struct zcomp per CPU. Each struct zcomp represents a
> compression algorithm in charge of managing compression streams per
> CPU. Although a compiled zram driver only supports a fixed set of
> compression algorithms, each zram device gets a struct zcomp allocated
> per CPU. The "multi" in CPU hotplug multstate refers to these per
> cpu struct zcomp instances. Each of these will have the CPU hotplug
> callback called for it on CPU plug / unplug. The kernel's CPU hotplug
> multistate keeps a linked list of these different structures so that
> it will iterate over them on CPU transitions.
> 
> By default at driver initialization we will create just one zram device
> (num_devices=1) and a zcomp structure then set for the now default
> lzo-rle comrpession algorithm. At driver removal we first remove each
> zram device, and so we destroy the associated struct zcomp per CPU. But
> since we expose sysfs attributes to create new devices or reset /
> initialize existing zram devices, we can easily end up re-initializing
> a struct zcomp for a zram device before the exit routine of the module
> removes the cpu hotplug callback. When this happens the kernel's CPU
> hotplug will detect that at least one instance (struct zcomp for us)
> exists. This can happen in the following situation:
> 
> CPU 1                            CPU 2
> 
>                                 disksize_store(...);
> class_unregister(...);
> idr_for_each(...);
> zram_debugfs_destroy();
> 
> idr_destroy(...);
> unregister_blkdev(...);
> cpuhp_remove_multi_state(...);

So this is strictly separate from the sysfs/module unloading race?

-Kees

> 
> The warning comes up on cpuhp_remove_multi_state() when it sees that the
> state for CPUHP_ZCOMP_PREPARE does not have an empty instance linked list.
> In this case, that a struct zcom still exists, the driver allowed its
> creation per CPU even though we could have just freed them per CPU
> though a call on another CPU, and we are then later trying to remove the
> hotplug callback.
> 
> Fix all this by providing a zram initialization boolean
> protected the shared in the driver zram_index_mutex, which we
> can use to annotate when sysfs attributes are safe to use or
> not -- once the driver is properly initialized. When the driver
> is going down we also are sure to not let userspace muck with
> attributes which may affect each per cpu struct zcomp.
> 
> This also fixes a series of possible memory leaks. The
> crashes and memory leaks can easily be caused by issuing
> the zram02.sh script from the LTP project [0] in a loop
> in two separate windows:
> 
>   cd testcases/kernel/device-drivers/zram
>   while true; do PATH=$PATH:$PWD:$PWD/../../../lib/ ./zram02.sh; done
> 
> You end up with a splat as follows:
> 
> kernel: zram: Removed device: zram0
> kernel: zram: Added device: zram0
> kernel: zram0: detected capacity change from 0 to 209715200
> kernel: Adding 104857596k swap on /dev/zram0.  <etc>
> kernel: zram0: detected capacitky change from 209715200 to 0
> kernel: zram0: detected capacity change from 0 to 209715200
> kernel: ------------[ cut here ]------------
> kernel: Error: Removing state 63 which has instances left.
> kernel: WARNING: CPU: 7 PID: 70457 at \
> 	kernel/cpu.c:2069 __cpuhp_remove_state_cpuslocked+0xf9/0x100
> kernel: Modules linked in: zram(E-) zsmalloc(E) <etc>
> kernel: CPU: 7 PID: 70457 Comm: rmmod Tainted: G            \
> 	E     5.12.0-rc1-next-20210304 #3
> kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), \
> 	BIOS 1.14.0-2 04/01/2014
> kernel: RIP: 0010:__cpuhp_remove_state_cpuslocked+0xf9/0x100
> kernel: Code: <etc>
> kernel: RSP: 0018:ffffa800c139be98 EFLAGS: 00010282
> kernel: RAX: 0000000000000000 RBX: ffffffff9083db58 RCX: ffff9609f7dd86d8
> kernel: RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9609f7dd86d0
> kernel: RBP: 0000000000000000i R08: 0000000000000000 R09: ffffa800c139bcb8
> kernel: R10: ffffa800c139bcb0 R11: ffffffff908bea40 R12: 000000000000003f
> kernel: R13: 00000000000009d8 R14: 0000000000000000 R15: 0000000000000000
> kernel: FS: 00007f1b075a7540(0000) GS:ffff9609f7dc0000(0000) knlGS:<etc>
> kernel: CS:  0010 DS: 0000 ES 0000 CR0: 0000000080050033
> kernel: CR2: 00007f1b07610490 CR3: 00000001bd04e000 CR4: 0000000000350ee0
> kernel: Call Trace:
> kernel: __cpuhp_remove_state+0x2e/0x80
> kernel: __do_sys_delete_module+0x190/0x2a0
> kernel:  do_syscall_64+0x33/0x80
> kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The "Error: Removing state 63 which has instances left" refers
> to the zram per CPU struct zcomp instances left.
> 
> [0] https://github.com/linux-test-project/ltp.git
> 
> Acked-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/zram/zram_drv.c | 63 ++++++++++++++++++++++++++++++-----
>  1 file changed, 55 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index f61910c65f0f..b26abcb955cc 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -44,6 +44,8 @@ static DEFINE_MUTEX(zram_index_mutex);
>  static int zram_major;
>  static const char *default_compressor = CONFIG_ZRAM_DEF_COMP;
>  
> +static bool zram_up;
> +
>  /* Module params (documentation at end) */
>  static unsigned int num_devices = 1;
>  /*
> @@ -1704,6 +1706,7 @@ static void zram_reset_device(struct zram *zram)
>  	comp = zram->comp;
>  	disksize = zram->disksize;
>  	zram->disksize = 0;
> +	zram->comp = NULL;
>  
>  	set_capacity_and_notify(zram->disk, 0);
>  	part_stat_set_all(zram->disk->part0, 0);
> @@ -1724,9 +1727,18 @@ static ssize_t disksize_store(struct device *dev,
>  	struct zram *zram = dev_to_zram(dev);
>  	int err;
>  
> +	mutex_lock(&zram_index_mutex);
> +
> +	if (!zram_up) {
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
>  	disksize = memparse(buf, NULL);
> -	if (!disksize)
> -		return -EINVAL;
> +	if (!disksize) {
> +		err = -EINVAL;
> +		goto out;
> +	}
>  
>  	down_write(&zram->init_lock);
>  	if (init_done(zram)) {
> @@ -1754,12 +1766,16 @@ static ssize_t disksize_store(struct device *dev,
>  	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
>  	up_write(&zram->init_lock);
>  
> +	mutex_unlock(&zram_index_mutex);
> +
>  	return len;
>  
>  out_free_meta:
>  	zram_meta_free(zram, disksize);
>  out_unlock:
>  	up_write(&zram->init_lock);
> +out:
> +	mutex_unlock(&zram_index_mutex);
>  	return err;
>  }
>  
> @@ -1775,8 +1791,17 @@ static ssize_t reset_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (!do_reset)
> -		return -EINVAL;
> +	mutex_lock(&zram_index_mutex);
> +
> +	if (!zram_up) {
> +		len = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (!do_reset) {
> +		len = -EINVAL;
> +		goto out;
> +	}
>  
>  	zram = dev_to_zram(dev);
>  	bdev = zram->disk->part0;
> @@ -1785,7 +1810,8 @@ static ssize_t reset_store(struct device *dev,
>  	/* Do not reset an active device or claimed device */
>  	if (bdev->bd_openers || zram->claim) {
>  		mutex_unlock(&bdev->bd_disk->open_mutex);
> -		return -EBUSY;
> +		len = -EBUSY;
> +		goto out;
>  	}
>  
>  	/* From now on, anyone can't open /dev/zram[0-9] */
> @@ -1800,6 +1826,8 @@ static ssize_t reset_store(struct device *dev,
>  	zram->claim = false;
>  	mutex_unlock(&bdev->bd_disk->open_mutex);
>  
> +out:
> +	mutex_unlock(&zram_index_mutex);
>  	return len;
>  }
>  
> @@ -2010,6 +2038,10 @@ static ssize_t hot_add_show(struct class *class,
>  	int ret;
>  
>  	mutex_lock(&zram_index_mutex);
> +	if (!zram_up) {
> +		mutex_unlock(&zram_index_mutex);
> +		return -ENODEV;
> +	}
>  	ret = zram_add();
>  	mutex_unlock(&zram_index_mutex);
>  
> @@ -2037,6 +2069,11 @@ static ssize_t hot_remove_store(struct class *class,
>  
>  	mutex_lock(&zram_index_mutex);
>  
> +	if (!zram_up) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
>  	zram = idr_find(&zram_index_idr, dev_id);
>  	if (zram) {
>  		ret = zram_remove(zram);
> @@ -2046,6 +2083,7 @@ static ssize_t hot_remove_store(struct class *class,
>  		ret = -ENODEV;
>  	}
>  
> +out:
>  	mutex_unlock(&zram_index_mutex);
>  	return ret ? ret : count;
>  }
> @@ -2072,12 +2110,15 @@ static int zram_remove_cb(int id, void *ptr, void *data)
>  
>  static void destroy_devices(void)
>  {
> +	mutex_lock(&zram_index_mutex);
> +	zram_up = false;
>  	class_unregister(&zram_control_class);
>  	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
>  	zram_debugfs_destroy();
>  	idr_destroy(&zram_index_idr);
>  	unregister_blkdev(zram_major, "zram");
>  	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
> +	mutex_unlock(&zram_index_mutex);
>  }
>  
>  static int __init zram_init(void)
> @@ -2105,15 +2146,21 @@ static int __init zram_init(void)
>  		return -EBUSY;
>  	}
>  
> +	mutex_lock(&zram_index_mutex);
> +
>  	while (num_devices != 0) {
> -		mutex_lock(&zram_index_mutex);
>  		ret = zram_add();
> -		mutex_unlock(&zram_index_mutex);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mutex_unlock(&zram_index_mutex);
>  			goto out_error;
> +		}
>  		num_devices--;
>  	}
>  
> +	zram_up = true;
> +
> +	mutex_unlock(&zram_index_mutex);
> +
>  	return 0;
>  
>  out_error:
> -- 
> 2.30.2
> 

-- 
Kees Cook
