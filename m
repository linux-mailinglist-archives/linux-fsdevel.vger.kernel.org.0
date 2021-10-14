Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF542D01E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 03:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJNB6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 21:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhJNB6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634176573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/eMqOQ3e5RQMx416/mb99bJ9/X7E112z3XaSuwCe8BQ=;
        b=AAq5RLdPvd76gXD9mT9T9H3pzUC1tZ6ciMvSoNe8qaI1lo8yVftCOilv5Z6ytxNMHsWWLE
        E/Wy1yohiWLvAXttxk0+Hdvw00f46Q4tMMHsUtLh28mKSlB1fcfFRGIMi8XzUjhh/+/yUw
        yev3zlHBr5dvjHyEnCDOLC3f4Yw/iFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-ErOttYVpP9Wxn08DKzneyw-1; Wed, 13 Oct 2021 21:56:07 -0400
X-MC-Unique: ErOttYVpP9Wxn08DKzneyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F0A3100C660;
        Thu, 14 Oct 2021 01:56:05 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 495E15D6BA;
        Thu, 14 Oct 2021 01:55:52 +0000 (UTC)
Date:   Thu, 14 Oct 2021 09:55:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWeOJP2UJWYF94fu@T590>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-12-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Hello Luis,

Can you test the following patch and see if the issue can be addressed?

Please see the idea from the inline comment.

Also zram_index_mutex isn't needed in zram disk's store() compared with
your patch, then the deadlock issue you are addressing in this series can
be avoided.


diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..3c17927d23a7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1985,11 +1985,17 @@ static int zram_remove(struct zram *zram)
 
 	/* Make sure all the pending I/O are finished */
 	fsync_bdev(bdev);
-	zram_reset_device(zram);
 
 	pr_info("Removed device: %s\n", zram->disk->disk_name);
 
 	del_gendisk(zram->disk);
+
+	/*
+	 * reset device after gendisk is removed, so any change from sysfs
+	 * store won't come in, then we can really reset device here
+	 */
+	zram_reset_device(zram);
+
 	blk_cleanup_disk(zram->disk);
 	kfree(zram);
 	return 0;
@@ -2073,7 +2079,12 @@ static int zram_remove_cb(int id, void *ptr, void *data)
 static void destroy_devices(void)
 {
 	class_unregister(&zram_control_class);
+
+	/* hold the global lock so new device can't be added */
+	mutex_lock(&zram_index_mutex);
 	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
+	mutex_unlock(&zram_index_mutex);
+
 	zram_debugfs_destroy();
 	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");

Thanks,
Ming

