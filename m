Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7155F055D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 08:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiI3Gv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiI3GvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:51:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C2146F86;
        Thu, 29 Sep 2022 23:51:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b23so3442808pfp.9;
        Thu, 29 Sep 2022 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=LMDEKRVatEhmPhLDNavek8Wpgc8QEAKXkZK2xGE+vvA=;
        b=FJTZLhywfSQ2+1K/cFOC4yX8Ue06nyDaygmHm1uGByaLEQZpe13ov2eViY4mRFQd3p
         fv5UGKSZvE2V4I0fr3lJ5Yb/8TxnL0ZT/IWKF9pvceDK46S+RrdSBoVIxgj+sa6iDEyU
         GyKD6TiRHTvMWWTFk/7kkVmTW9OPe4CZM+b+JOqGnQSDj2+h5LabD6JfZMY6fO5QptDd
         rZ4c+DLmD5j0fNc1ySoPor7miY/+onjbUp+t6JlWReH1ZRBTx1o3+GBWexQiUU4BYSI4
         a8PYVOo6AxNIz6T/GS3ODO0V8jmP2XG9uZtNX+W16a/jWYeqGKZc6/VUO4vGucRPMz7S
         jkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=LMDEKRVatEhmPhLDNavek8Wpgc8QEAKXkZK2xGE+vvA=;
        b=l7g22lGhc0Y3UtjWe1jZxpWS6XTqGQvw8qqg8CrBbS/TVsZypuKrJan5lNof6h8BxF
         OUN/G/vFTvZxbZpkncmCvR/L8Xx6Fdzk8r+ST55c7bi13al+y8krwb+UF2m0sq7W62bt
         vH0W2sz+k985PByAxn4TQk8u1BSnY+yIICJynuaEnCvbl723T7AidHUKkF+axI9nhYA7
         PVwGlOPQ1ioGgZBDe8wog3jSUDnNr4bKFGzVC4dVBI0YSc2BwYlqjnAT+40ujRsN1cRk
         snESCEBPiK2xgDmqHfQPK/gnIMWDoWMUka7XjMVFgirSx9ea3vNGhpctcNTJTiXjTE57
         b8Kg==
X-Gm-Message-State: ACrzQf0pMIzlSRKtIqvpORPOPuDc08DlugyeJ0vGh/hQpjLvKtCCGWd6
        QrXLry+kAIizM/XpOZodX6Bpp5tHRPxocjtAAg/yx2Yx2g6Yis8c1u0=
X-Google-Smtp-Source: AMsMyM5ZkmTyIVrq/B1DvrXBCRw1G4qg85UrfUllnknpExHkJKcjlFf9uTtWwiWSeQx17CMzx9IAkE4jOBUIlBZVWxA=
X-Received: by 2002:a05:6a00:1743:b0:548:8629:ceab with SMTP id
 j3-20020a056a00174300b005488629ceabmr7205740pfc.23.1664520682515; Thu, 29 Sep
 2022 23:51:22 -0700 (PDT)
MIME-Version: 1.0
From:   "Sabri N. Ferreiro" <snferreiro1@gmail.com>
Date:   Fri, 30 Sep 2022 14:51:11 +0800
Message-ID: <CAKG+3NQww6ipPDyaPyXKto8FoU62Rix-XNpzkWtMbJNSyKKCmQ@mail.gmail.com>
Subject: KASAN: use-after-free Read in filp_close
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When I used fuzz testing to test Linux kernel 6.0.0-rc6, the kernel
triggered the following error:
HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
git tree: upstream

kernel config: https://pastebin.com/raw/hekxU61F
console log: https://pastebin.com/raw/YmeXN9F0


It seems that the fuzzer failed to extract any C reproducer, but I
would so appreciate it if you have any idea how to solve this bug.

==================================================================
BUG: KASAN: use-after-free in filp_close+0x13f/0x160 fs/open.c:1420
Read of size 8 at addr ffff888024d5b078 by task syz-executor.7/12532

CPU: 0 PID: 12532 Comm: syz-executor.7 Not tainted 6.0.0-rc6+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:317 [inline]
print_report.cold+0xe5/0x66d mm/kasan/report.c:433
kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
filp_close+0x13f/0x160 fs/open.c:1420
close_fd+0x76/0xa0 fs/file.c:664
__do_sys_close fs/open.c:1440 [inline]
__se_sys_close fs/open.c:1438 [inline]
__x64_sys_close+0x2f/0xa0 fs/open.c:1438
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f034163f60b
Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c
24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 2f 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffe3a4724e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f034163f60b
RDX: 0000001b2e120000 RSI: 0000001b2e128c00 RDI: 0000000000000006
RBP: 00007f034179dd4c R08: 0000000000000000 R09: 000000003ac8e423
R10: 0000000000000000 R11: 0000000000000293 R12: 00000000000699df
R13: 00007ffe3a472620 R14: 00007f034179c4ec R15: 000000000006981e
</TASK>

Allocated by task 10844:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:437 [inline]
____kasan_kmalloc mm/kasan/common.c:516 [inline]
____kasan_kmalloc mm/kasan/common.c:475 [inline]
__kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
kasan_kmalloc include/linux/kasan.h:234 [inline]
__kmalloc+0x1da/0x3f0 mm/slub.c:4424
kmalloc include/linux/slab.h:605 [inline]
kzalloc include/linux/slab.h:733 [inline]
tomoyo_init_log+0x1254/0x1eb0 security/tomoyo/audit.c:275
tomoyo_supervisor+0x2e7/0xe30 security/tomoyo/common.c:2088
tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
tomoyo_path_permission security/tomoyo/file.c:587 [inline]
tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
tomoyo_path_perm+0x2fc/0x420 security/tomoyo/file.c:838
tomoyo_path_unlink+0x8e/0xd0 security/tomoyo/tomoyo.c:149
security_path_unlink+0xd7/0x150 security/security.c:1173
do_unlinkat+0x36c/0x660 fs/namei.c:4293
__do_sys_unlink fs/namei.c:4345 [inline]
__se_sys_unlink fs/namei.c:4343 [inline]
__x64_sys_unlink+0x3e/0x50 fs/namei.c:4343
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 12535:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track+0x21/0x30 mm/kasan/common.c:45
kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
____kasan_slab_free mm/kasan/common.c:367 [inline]
____kasan_slab_free mm/kasan/common.c:329 [inline]
__kasan_slab_free+0x11d/0x1b0 mm/kasan/common.c:375
kasan_slab_free include/linux/kasan.h:200 [inline]
slab_free_hook mm/slub.c:1754 [inline]
slab_free_freelist_hook mm/slub.c:1780 [inline]
slab_free mm/slub.c:3534 [inline]
kfree+0xe9/0x650 mm/slub.c:4562
dvb_free_device drivers/media/dvb-core/dvbdev.c:572 [inline]
dvb_free_device drivers/media/dvb-core/dvbdev.c:567 [inline]
dvb_unregister_device+0x3f/0x60 drivers/media/dvb-core/dvbdev.c:581
dvb_dmxdev_release+0x1c9/0x630 drivers/media/dvb-core/dmxdev.c:1462
ttusb_disconnect+0x144/0x260
drivers/media/usb/ttusb-budget/dvb-ttusb-budget.c:1731
usb_unbind_interface+0x1bd/0x890 drivers/usb/core/driver.c:458
device_remove drivers/base/dd.c:550 [inline]
device_remove+0x11f/0x170 drivers/base/dd.c:542
__device_release_driver drivers/base/dd.c:1249 [inline]
device_release_driver_internal+0x1a7/0x360 drivers/base/dd.c:1275
usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:627
usb_forced_unbind_intf+0x48/0xa0 drivers/usb/core/driver.c:1118
usb_reset_device+0x439/0xac0 drivers/usb/core/hub.c:6113
proc_resetdevice drivers/usb/core/devio.c:1514 [inline]
usbdev_do_ioctl drivers/usb/core/devio.c:2655 [inline]
usbdev_ioctl+0x1e70/0x3340 drivers/usb/core/devio.c:2807
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:870 [inline]
__se_sys_ioctl fs/ioctl.c:856 [inline]
__x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888024d5b000
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 120 bytes inside of
512-byte region [ffff888024d5b000, ffff888024d5b200)

The buggy address belongs to the physical page:
page:ffffea0000935600 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff888024d58400 pfn:0x24d58
head:ffffea0000935600 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0000789108 ffffea0000787108 ffff888011c42c80
raw: ffff888024d58400 0000000000100008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask
0x1d2a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL),
pid 0, tgid 0 (swapper/0), ts 378270268280, free_ts 371843614843
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook mm/page_alloc.c:2525 [inline]
prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
__alloc_pages+0x321/0x710 mm/page_alloc.c:5515
alloc_pages+0x117/0x2f0 mm/mempolicy.c:2270
alloc_slab_page mm/slub.c:1824 [inline]
allocate_slab mm/slub.c:1969 [inline]
new_slab+0x246/0x3a0 mm/slub.c:2029
___slab_alloc+0xa50/0x1060 mm/slub.c:3031
__slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
slab_alloc_node mm/slub.c:3209 [inline]
__kmalloc_node_track_caller+0x2ec/0x370 mm/slub.c:4955
kmalloc_reserve+0x32/0xd0 net/core/skbuff.c:362
__alloc_skb+0x11a/0x320 net/core/skbuff.c:434
alloc_skb include/linux/skbuff.h:1257 [inline]
ndisc_alloc_skb+0x134/0x330 net/ipv6/ndisc.c:421
ndisc_send_rs+0x37f/0x6f0 net/ipv6/ndisc.c:702
addrconf_rs_timer+0x415/0x740 net/ipv6/addrconf.c:3931
call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers.part.0+0x69c/0xad0 kernel/time/timer.c:1790
__run_timers kernel/time/timer.c:1768 [inline]
run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1803
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1449 [inline]
free_pcp_prepare+0x5ab/0xd00 mm/page_alloc.c:1499
free_unref_page_prepare mm/page_alloc.c:3380 [inline]
free_unref_page+0x19/0x410 mm/page_alloc.c:3476
__stack_depot_save+0x1ef/0x530 lib/stackdepot.c:489
kasan_save_stack+0x2e/0x40 mm/kasan/common.c:39
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:437 [inline]
____kasan_kmalloc mm/kasan/common.c:516 [inline]
____kasan_kmalloc mm/kasan/common.c:475 [inline]
__kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
kasan_kmalloc include/linux/kasan.h:234 [inline]
kmem_cache_alloc_trace+0x19b/0x380 mm/slub.c:3284
kmalloc include/linux/slab.h:600 [inline]
usb_control_msg+0xb9/0x4a0 drivers/usb/core/message.c:143
get_port_status drivers/usb/core/hub.c:581 [inline]
hub_ext_port_status+0x125/0x460 drivers/usb/core/hub.c:598
usb_hub_port_status drivers/usb/core/hub.c:620 [inline]
hub_port_wait_reset drivers/usb/core/hub.c:2865 [inline]
hub_port_reset+0x2e0/0x1ac0 drivers/usb/core/hub.c:2986
hub_port_init+0x186/0x34d0 drivers/usb/core/hub.c:4703
hub_port_connect drivers/usb/core/hub.c:5282 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
port_event drivers/usb/core/hub.c:5653 [inline]
hub_event+0x21b6/0x4260 drivers/usb/core/hub.c:5735
process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
ffff888024d5af00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff888024d5af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888024d5b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff888024d5b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888024d5b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
