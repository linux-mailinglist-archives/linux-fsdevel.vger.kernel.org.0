Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A760742E2B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 22:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhJNU0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 16:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNU0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:26:46 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8B4C061570;
        Thu, 14 Oct 2021 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H/+saBVHG6Q0/3w93ZreMAu3RniGzEFHzOX/deXs7WM=; b=moxm7Ky/KkaxZMIX+sDuPRs9SX
        a6kbxyFuHrfxo8f2Y2/l7Hh4u6J1z1pdV7r9x1a4ZR2OAHn2zc5tQIfEWV6yhP8lxOrFLmJ7uslKr
        SDbIVJ2jJ0JDVFRciyb5WOC4w0yIM+HqfRcPh2kL1orbm9OTkjzA3igI0RuhXnj2xMLxthcXA713f
        BCLrie7TmS8R9NLD439hSLPp8jtoSJGNnO5wkAz6j7uxxEUMhzyf5VH1DFvx3ISYBzOQqMkxbQAxr
        AVRXPp6fHhdE8Hj/QB3Y4DhMQlJYHo9zviV9vJ3a1/Qhy/tF+bRqTbsH0wBVrv4saIf5H6GE/Sec9
        yxeQSZDw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb7HE-004Lo0-4q; Thu, 14 Oct 2021 20:24:32 +0000
Date:   Thu, 14 Oct 2021 13:24:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
 <YWeOJP2UJWYF94fu@T590>
 <YWeR4moCRh+ZHOmH@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWeR4moCRh+ZHOmH@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:11:46AM +0800, Ming Lei wrote:
> On Thu, Oct 14, 2021 at 09:55:48AM +0800, Ming Lei wrote:
> > On Mon, Sep 27, 2021 at 09:38:04AM -0700, Luis Chamberlain wrote:
> 
> ...
> 
> > 
> > Hello Luis,
> > 
> > Can you test the following patch and see if the issue can be addressed?
> > 
> > Please see the idea from the inline comment.
> > 
> > Also zram_index_mutex isn't needed in zram disk's store() compared with
> > your patch, then the deadlock issue you are addressing in this series can
> > be avoided.
> > 
> > 
> > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > index fcaf2750f68f..3c17927d23a7 100644
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -1985,11 +1985,17 @@ static int zram_remove(struct zram *zram)
> >  
> >  	/* Make sure all the pending I/O are finished */
> >  	fsync_bdev(bdev);
> > -	zram_reset_device(zram);
> >  
> >  	pr_info("Removed device: %s\n", zram->disk->disk_name);
> >  
> >  	del_gendisk(zram->disk);
> > +
> > +	/*
> > +	 * reset device after gendisk is removed, so any change from sysfs
> > +	 * store won't come in, then we can really reset device here
> > +	 */
> > +	zram_reset_device(zram);
> > +
> >  	blk_cleanup_disk(zram->disk);
> >  	kfree(zram);
> >  	return 0;
> > @@ -2073,7 +2079,12 @@ static int zram_remove_cb(int id, void *ptr, void *data)
> >  static void destroy_devices(void)
> >  {
> >  	class_unregister(&zram_control_class);
> > +
> > +	/* hold the global lock so new device can't be added */
> > +	mutex_lock(&zram_index_mutex);
> >  	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
> > +	mutex_unlock(&zram_index_mutex);
> > +
> 
> Actually zram_index_mutex isn't needed when calling zram_remove_cb()
> since the zram-control sysfs interface has been removed, so userspace
> can't add new device any more, then the issue is supposed to be fixed
> by the following one line change, please test it:
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fcaf2750f68f..96dd641de233 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1985,11 +1985,17 @@ static int zram_remove(struct zram *zram)
>  
>  	/* Make sure all the pending I/O are finished */
>  	fsync_bdev(bdev);
> -	zram_reset_device(zram);
>  
>  	pr_info("Removed device: %s\n", zram->disk->disk_name);
>  
>  	del_gendisk(zram->disk);
> +
> +	/*
> +	 * reset device after gendisk is removed, so any change from sysfs
> +	 * store won't come in, then we can really reset device here
> +	 */
> +	zram_reset_device(zram);
> +
>  	blk_cleanup_disk(zram->disk);
>  	kfree(zram);
>  	return 0;

Sorry but nope, the cpu multistate issue is still present and we end up
eventually with page faults. I tried with both patches.

Oct 14 20:21:34 kdevops kernel: ------------[ cut here ]------------
Oct 14 20:21:34 kdevops kernel: Error: Removing state 65 which has
instances left.
Oct 14 20:21:34 kdevops kernel: WARNING: CPU: 4 PID: 3358 at
kernel/cpu.c:2151 __cpuhp_remove_state_cpuslocked+0xf9/0x100
Oct 14 20:21:34 kdevops kernel: Modules linked in: zram(E-) zstd(E)
zsmalloc(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E)
crc32_pclmul(E) ghash_clmulni_intel(E) >
Oct 14 20:21:34 kdevops kernel: CPU: 4 PID: 3358 Comm: rmmod Tainted: G
E     5.15.0-rc3-next-20210927+ #89
Oct 14 20:21:34 kdevops kernel: Hardware name: QEMU Standard PC (i440FX
+ PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Oct 14 20:21:34 kdevops kernel: RIP:
0010:__cpuhp_remove_state_cpuslocked+0xf9/0x100
Oct 14 20:21:34 kdevops kernel: Code: 21 00 48 c7 43 18 00 00 00 00 5b
5d 41 5c 41 5d 41 5e 41 5f e9 d8 17 84 00 0f 0b 44 89 e6 48 c7 c7 78 0c
8b ad e8 56 92 7f 00 <0f> 0b >
Oct 14 20:21:34 kdevops kernel: RSP: 0018:ffffaac980a1fe90 EFLAGS:
00010286
Oct 14 20:21:34 kdevops kernel: RAX: 0000000000000000 RBX:
ffffffffada3e208 RCX: 0000000000000000
Oct 14 20:21:34 kdevops kernel: RDX: 0000000000000001 RSI:
ffffffffad8efdb6 RDI: 00000000ffffffff
Oct 14 20:21:34 kdevops kernel: RBP: 0000000000000000 R08:
0000000000000000 R09: ffffaac980a1fcc0
Oct 14 20:21:34 kdevops kernel: R10: ffffaac980a1fcb8 R11:
ffffffffadac3c68 R12: 0000000000000041
Oct 14 20:21:34 kdevops kernel: R13: 0000000000000a28 R14:
0000000000000000 R15: 0000000000000000
Oct 14 20:21:34 kdevops kernel: FS:  00007fc0c2882580(0000)
GS:ffff9ed6f7d00000(0000) knlGS:0000000000000000
Oct 14 20:21:34 kdevops kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 14 20:21:34 kdevops kernel: CR2: 00005621b0490b78 CR3:
000000011a538005 CR4: 0000000000370ee0
Oct 14 20:21:34 kdevops kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Oct 14 20:21:34 kdevops kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Oct 14 20:21:34 kdevops kernel: Call Trace:
Oct 14 20:21:34 kdevops kernel:  <TASK>
Oct 14 20:21:34 kdevops kernel:  __cpuhp_remove_state+0x4d/0xc0
Oct 14 20:21:34 kdevops kernel:  __do_sys_delete_module+0x18d/0x2a0
Oct 14 20:21:34 kdevops kernel:  ?
fpregs_assert_state_consistent+0x1e/0x40
Oct 14 20:21:34 kdevops kernel:  ? exit_to_user_mode_prepare+0x3a/0x180
Oct 14 20:21:34 kdevops kernel:  do_syscall_64+0x38/0xc0
Oct 14 20:21:34 kdevops kernel:
entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 14 20:21:34 kdevops kernel: RIP: 0033:0x7fc0c29a84a7
<etc>
Oct 14 20:21:35 kdevops kernel: sysfs: cannot create duplicate filename
'/devices/virtual/block/zram0'
Oct 14 20:21:35 kdevops kernel: CPU: 5 PID: 3388 Comm: modprobe Tainted:
G        W   E     5.15.0-rc3-next-20210927+ #89
Oct 14 20:21:35 kdevops kernel: Hardware name: QEMU Standard PC (i440FX
+ PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Oct 14 20:21:35 kdevops kernel: Call Trace:
Oct 14 20:21:35 kdevops kernel:  <TASK>
Oct 14 20:21:35 kdevops kernel:  dump_stack_lvl+0x48/0x5e
Oct 14 20:21:35 kdevops kernel:  sysfs_warn_dup.cold+0x17/0x24
Oct 14 20:21:35 kdevops kernel:  sysfs_create_dir_ns+0xbc/0xd0
Oct 14 20:21:35 kdevops kernel:  kobject_add_internal+0xbd/0x2b0
Oct 14 20:21:35 kdevops kernel:  kobject_add+0x7e/0xb0
Oct 14 20:21:35 kdevops kernel:  ? _raw_spin_unlock_irqrestore+0x25/0x40
Oct 14 20:21:35 kdevops kernel:  ? preempt_count_add+0x68/0xa0
Oct 14 20:21:35 kdevops kernel:  device_add+0x11a/0x980
Oct 14 20:21:35 kdevops kernel:  ? dev_set_name+0x53/0x70
Oct 14 20:21:35 kdevops kernel:  device_add_disk+0x9d/0x3a0
Oct 14 20:21:35 kdevops kernel:  zram_add+0x1ad/0x200 [zram]
Oct 14 20:21:35 kdevops kernel:  ? 0xffffffffc0c10000
Oct 14 20:21:35 kdevops kernel:  zram_init+0xd7/0x1000 [zram]
Oct 14 20:21:35 kdevops kernel:  do_one_initcall+0x41/0x200
Oct 14 20:21:35 kdevops kernel:  ? _raw_spin_unlock_irqrestore+0x25/0x40
Oct 14 20:21:35 kdevops kernel:  ? kmem_cache_alloc_trace+0x2ab/0x420
Oct 14 20:21:35 kdevops kernel:  do_init_module+0x5c/0x270
Oct 14 20:21:35 kdevops kernel:  __do_sys_finit_module+0xae/0x110
Oct 14 20:21:35 kdevops kernel:  do_syscall_64+0x38/0xc0
Oct 14 20:21:35 kdevops kernel:
entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 14 20:21:35 kdevops kernel: RIP: 0033:0x7fca3aa555e9
Oct 14 20:21:35 kdevops kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00
00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8
4c 8b 4c 24 08 0f 05 <48> 3d >
Oct 14 20:21:35 kdevops kernel: RSP: 002b:00007fff142417b8 EFLAGS:
00000246 ORIG_RAX: 0000000000000139
Oct 14 20:21:35 kdevops kernel: RAX: ffffffffffffffda RBX:
0000558ba9491bd0 RCX: 00007fca3aa555e9
Oct 14 20:21:35 kdevops kernel: RDX: 0000000000000000 RSI:
0000558ba9491f60 RDI: 0000000000000003
Oct 14 20:21:35 kdevops kernel: RBP: 0000000000040000 R08:
0000000000000000 R09: 0000558ba9491db0
Oct 14 20:21:35 kdevops kernel: R10: 0000000000000003 R11:
0000000000000246 R12: 0000558ba9491f60
Oct 14 20:21:35 kdevops kernel: R13: 0000000000000000 R14:
0000558ba9491d00 R15: 0000558ba9491bd0
Oct 14 20:21:35 kdevops kernel:  </TASK>
<etc>
Oct 14 20:21:35 kdevops kernel: kobject_add_internal failed for zram0
with -EEXIST, don't try to register things with the same name in the
same directory.
Oct 14 20:21:35 kdevops kernel: ------------[ cut here ]------------
Oct 14 20:21:35 kdevops kernel: WARNING: CPU: 5 PID: 3388 at
block/genhd.c:537 device_add_disk+0x1b9/0x3a0
Oct 14 20:21:35 kdevops kernel: Modules linked in: zram(E+) zstd(E)
zsmalloc(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E)
crc32_pclmul(E) ghash_clmulni_intel(E) >
Oct 14 20:21:35 kdevops kernel: CPU: 5 PID: 3388 Comm: modprobe Tainted:
G        W   E     5.15.0-rc3-next-20210927+ #89
Oct 14 20:21:35 kdevops kernel: Hardware name: QEMU Standard PC (i440FX
+ PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Oct 14 20:21:35 kdevops kernel: RIP: 0010:device_add_disk+0x1b9/0x3a0
Oct 14 20:21:35 kdevops kernel: Code: 00 03 01 00 00 0f 85 32 ff ff ff
e9 1e ff ff ff 0f 0b 41 bc ea ff ff ff e9 29 ff ff ff 4c 89 ff e8 5c 45
1c 00 e9 ef fe ff ff <0f> 0b >
Oct 14 20:21:35 kdevops kernel: RSP: 0018:ffffaac980607d90 EFLAGS:
00010287
Oct 14 20:21:35 kdevops kernel: RAX: 0000000000000000 RBX:
0000000000000000 RCX: 0000000000023005
Oct 14 20:21:35 kdevops kernel: RDX: 0000000000022e05 RSI:
ffffffffacc4b710 RDI: 0000000000000000
Oct 14 20:21:35 kdevops kernel: RBP: ffff9ed5d788a600 R08:
0000000000000000 R09: ffffaac980607a98
Oct 14 20:21:35 kdevops kernel: R10: ffff9ed5c795ef00 R11:
ffffffffadac3c68 R12: 00000000ffffffef
Oct 14 20:21:35 kdevops kernel: R13: ffff9ed5d5600000 R14:
ffffffffc0a52100 R15: ffff9ed5d5600040
Oct 14 20:21:35 kdevops kernel: FS:  00007fca3a935580(0000)
GS:ffff9ed6f7d40000(0000) knlGS:0000000000000000
Oct 14 20:21:35 kdevops kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 14 20:21:35 kdevops kernel: CR2: 00007fff1423e6d8 CR3:
0000000136752002 CR4: 0000000000370ee0
Oct 14 20:21:35 kdevops kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Oct 14 20:21:35 kdevops kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Oct 14 20:21:35 kdevops kernel: Call Trace:
Oct 14 20:21:35 kdevops kernel:  <TASK>
Oct 14 20:21:35 kdevops kernel:  zram_add+0x1ad/0x200 [zram]
Oct 14 20:21:35 kdevops kernel:  ? 0xffffffffc0c10000
Oct 14 20:21:35 kdevops kernel:  zram_init+0xd7/0x1000 [zram]
Oct 14 20:21:35 kdevops kernel:  do_one_initcall+0x41/0x200
Oct 14 20:21:35 kdevops kernel:  ? _raw_spin_unlock_irqrestore+0x25/0x40
Oct 14 20:21:35 kdevops kernel:  ? kmem_cache_alloc_trace+0x2ab/0x420
Oct 14 20:21:35 kdevops kernel:  do_init_module+0x5c/0x270
Oct 14 20:21:35 kdevops kernel:  __do_sys_finit_module+0xae/0x110
Oct 14 20:21:35 kdevops kernel:  do_syscall_64+0x38/0xc0
Oct 14 20:21:35 kdevops kernel:
entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 14 20:21:35 kdevops kernel: RIP: 0033:0x7fca3aa555e9
<etc>
Oct 14 20:21:35 kdevops kernel: ------------[ cut here ]------------
Oct 14 20:21:35 kdevops kernel: WARNING: CPU: 2 PID: 3457 at
block/genhd.c:564 del_gendisk+0x1a2/0x1d0
Oct 14 20:21:35 kdevops kernel: Modules linked in: 842(E)
842_decompress(E) 842_compress(E) zram(E-) zstd(E) zsmalloc(E)
kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E>
Oct 14 20:21:35 kdevops kernel: CPU: 2 PID: 3457 Comm: rmmod Tainted: G
W   E     5.15.0-rc3-next-20210927+ #89
Oct 14 20:21:35 kdevops kernel: Hardware name: QEMU Standard PC (i440FX
+ PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Oct 14 20:21:35 kdevops kernel: RIP: 0010:del_gendisk+0x1a2/0x1d0
Oct 14 20:21:35 kdevops kernel: Code: 48 8d 78 40 e8 8f 87 1d 00 48 8b
7b 40 5b 5d 41 5c 48 83 c7 40 e9 4e 47 1c 00 48 8b 70 40 eb ce f6 43 61
04 0f 85 85 fe ff ff <0f> 0b >
Oct 14 20:21:35 kdevops kernel: RSP: 0018:ffffaac9807cfe30 EFLAGS:
00010246
Oct 14 20:21:35 kdevops kernel: RAX: ffff9ed5d5600380 RBX:
ffff9ed5d788a600 RCX: 0000000000000000
Oct 14 20:21:35 kdevops kernel: RDX: 0000000000000000 RSI:
ffffffffad8efdb6 RDI: ffff9ed5d788a600
Oct 14 20:21:35 kdevops kernel: RBP: ffff9ed5d788b600 R08:
0000000000000000 R09: ffffaac9807cfc88
Oct 14 20:21:35 kdevops kernel: R10: ffffaac9807cfc80 R11:
ffffffffadac3c68 R12: ffff9ed5d5600000
Oct 14 20:21:35 kdevops kernel: R13: 0000000000000000 R14:
ffffffffc0a52360 R15: ffff9ed5c4a87b78
Oct 14 20:21:35 kdevops kernel: FS:  00007f292a2bb580(0000)
GS:ffff9ed6f7c80000(0000) knlGS:0000000000000000
Oct 14 20:21:35 kdevops kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 14 20:21:35 kdevops kernel: CR2: 000056161b453b78 CR3:
000000013213e002 CR4: 0000000000370ee0
Oct 14 20:21:35 kdevops kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Oct 14 20:21:35 kdevops kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Oct 14 20:21:35 kdevops kernel: Call Trace:
Oct 14 20:21:35 kdevops kernel:  <TASK>
Oct 14 20:21:35 kdevops kernel:  zram_remove+0x96/0xc0 [zram]
Oct 14 20:21:35 kdevops kernel:  ? hot_remove_store+0xe0/0xe0 [zram]
Oct 14 20:21:35 kdevops kernel:  zram_remove_cb+0xd/0x10 [zram]
Oct 14 20:21:35 kdevops kernel:  idr_for_each+0x5b/0xd0
Oct 14 20:21:35 kdevops kernel:  destroy_devices+0x32/0x68 [zram]
Oct 14 20:21:35 kdevops kernel:  __do_sys_delete_module+0x18d/0x2a0
Oct 14 20:21:35 kdevops kernel:  ?
fpregs_assert_state_consistent+0x1e/0x40
Oct 14 20:21:35 kdevops kernel:  ? exit_to_user_mode_prepare+0x3a/0x180
Oct 14 20:21:35 kdevops kernel:  do_syscall_64+0x38/0xc0
Oct 14 20:21:35 kdevops kernel:
entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 14 20:21:35 kdevops kernel: RIP: 0033:0x7f292a3e14a7
<etc>
Oct 14 20:21:35 kdevops kernel: BUG: unable to handle page fault for
address: ffffffffc0a4e0ae
Oct 14 20:21:35 kdevops kernel: #PF: supervisor instruction fetch in
kernel mode
Oct 14 20:21:35 kdevops kernel: #PF: error_code(0x0010) - not-present
page
Oct 14 20:21:35 kdevops kernel: PGD 3ba0e067 P4D 3ba0e067 PUD 3ba10067
PMD 10526c067 PTE 0
Oct 14 20:21:35 kdevops kernel: Oops: 0010 [#1] PREEMPT SMP NOPTI
Oct 14 20:21:35 kdevops kernel: CPU: 6 PID: 3655 Comm: zram02.sh
Tainted: G        W   E     5.15.0-rc3-next-20210927+ #89
Oct 14 20:21:35 kdevops kernel: Hardware name: QEMU Standard PC (i440FX
+ PIIX, 1996), BIOS 1.14.0-2 04/01/2014
Oct 14 20:21:35 kdevops kernel: RIP: 0010:0xffffffffc0a4e0ae
Oct 14 20:21:35 kdevops kernel: Code: Unable to access opcode bytes at
RIP 0xffffffffc0a4e084.
Oct 14 20:21:35 kdevops kernel: RSP: 0018:ffffaac980687da8 EFLAGS:
00010286
Oct 14 20:21:35 kdevops kernel: RAX: 0000000000000000 RBX:
ffff9ed5c40be400 RCX: 0000000080400035
Oct 14 20:21:35 kdevops kernel: RDX: 0000000080400036 RSI:
fffffa3544561080 RDI: 0000000040000000
Oct 14 20:21:35 kdevops kernel: RBP: 0000000001900000 R08:
ffff9ed5d5842cc0 R09: 0000000080400035
Oct 14 20:21:35 kdevops kernel: R10: ffff9ed5d5842c00 R11:
ffff9ed5f1341350 R12: 0000000001900000
Oct 14 20:21:35 kdevops kernel: R13: ffff9ed5d5666c00 R14:
ffff9ed5c40be420 R15: ffff9ed5dfa8c8c0
Oct 14 20:21:35 kdevops kernel: FS:  00007f978fe2d5c0(0000)
GS:ffff9ed6f7d80000(0000) knlGS:0000000000000000
Oct 14 20:21:35 kdevops kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 14 20:21:35 kdevops kernel: CR2: ffffffffc0a4e084 CR3:
0000000133fd4006 CR4: 0000000000370ee0
Oct 14 20:21:35 kdevops kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Oct 14 20:21:35 kdevops kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Oct 14 20:21:35 kdevops kernel: Call Trace:
Oct 14 20:21:35 kdevops kernel:  <TASK>
Oct 14 20:21:35 kdevops kernel:  ? kernfs_fop_write_iter+0x177/0x220
Oct 14 20:21:35 kdevops kernel:  ? new_sync_write+0x11c/0x1b0
Oct 14 20:21:35 kdevops kernel:  ? vfs_write+0x20d/0x2a0
Oct 14 20:21:35 kdevops kernel:  ? ksys_write+0x5f/0xe0
Oct 14 20:21:35 kdevops kernel:  ? do_syscall_64+0x38/0xc0
Oct 14 20:21:35 kdevops kernel:  ?
entry_SYSCALL_64_after_hwframe+0x44/0xae
Oct 14 20:21:35 kdevops kernel:  </TASK>
<etc, etc, etc, this goes on and on>

  Luis
