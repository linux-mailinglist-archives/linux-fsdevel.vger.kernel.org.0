Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C936D15A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 04:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCaCdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 22:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCaCc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:32:59 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1195C1712
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 19:32:56 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id v126-20020a6bac84000000b007587234a54cso12626381ioe.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 19:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680229975; x=1682821975;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdfWxE7qTekvVgvYXimZhffUh8i0KCdKojoqqBZwDFA=;
        b=foExt8woSq6KYu0PmrUge4cjVugplGvXjfwrDMnF257nRfmGmEQY7S8Hwkua/oQFzR
         wEWo8Q8B9YPc5LnUSfldGKJBLgUsOAYmVc7eLS4HSG4QuSi/XCuV+MAObgr+40LZpfWh
         tWZs7cZnPhlWYeFG2SMQL6e88VieOA1O1KcwRHqPqGzIJQvkLxQFI3fLBHW28AIDZxd/
         ONF998ono56W1sfM3nx8qstCPgSLEcjF69/EXtmsTyXK11OKEYgRIa0ZRg9BLAa7EUH9
         HDvkBVQgm2sC5hf2DxRDNbXb2df1kNJ4+3RC0pX0qWNPokIgJEIK/ayCqgg6XMy/53H0
         7M5A==
X-Gm-Message-State: AO0yUKWBbeRJvSt/y/jO6Q2oZ9J8SsxGwW2dtUloC7HlNDxmz1VSL/Ug
        ZJg2mHn7ixThHhNm57MbIVuJtZXK8Qq9+vDF4xzUpEmxCAKE
X-Google-Smtp-Source: AK7set9rfQHEo5DQ+z7vq0IaNpBOVeRh1QxBQ2lLhTgWbddnCIBjCB2P1gECx1ftcYQCT19lPE/ciYCOX73CjKuxRW4rLPnEvdyZ
MIME-Version: 1.0
X-Received: by 2002:a5e:de09:0:b0:756:8d49:49f7 with SMTP id
 e9-20020a5ede09000000b007568d4949f7mr10188627iok.3.1680229975298; Thu, 30 Mar
 2023 19:32:55 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:32:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1971705f82906f1@google.com>
Subject: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in alloc_workqueue
From:   syzbot <syzbot+513ff74eed8ed0db2a62@syzkaller.appspotmail.com>
To:     bp@alien8.de, clm@fb.com, dave.hansen@linux.intel.com,
        dsterba@suse.com, hpa@zytor.com, josef@toxicpanda.com,
        kvm@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a6d9e3034536 Add linux-next specific files for 20230330
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10af5d85c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
dashboard link: https://syzkaller.appspot.com/bug?extid=513ff74eed8ed0db2a62
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ec1f900ea929/disk-a6d9e303.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fabbf89c0d22/vmlinux-a6d9e303.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ed05d6192fa/bzImage-a6d9e303.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+513ff74eed8ed0db2a62@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in lockdep_register_key+0x396/0x410 kernel/locking/lockdep.c:1231
Read of size 8 at addr ffff88806fde3360 by task syz-executor.4/14593

CPU: 0 PID: 14593 Comm: syz-executor.4 Not tainted 6.3.0-rc4-next-20230330-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 lockdep_register_key+0x396/0x410 kernel/locking/lockdep.c:1231
 wq_init_lockdep kernel/workqueue.c:3604 [inline]
 alloc_workqueue+0x3f8/0x1110 kernel/workqueue.c:4476
 kvm_mmu_init_tdp_mmu+0x23/0x100 arch/x86/kvm/mmu/tdp_mmu.c:19
 kvm_mmu_init_vm+0x150/0x360 arch/x86/kvm/mmu/mmu.c:6194
 kvm_arch_init_vm+0x6c/0x750 arch/x86/kvm/x86.c:12232
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1196 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:5018 [inline]
 kvm_dev_ioctl+0xa31/0x1bb0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:5060
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f953d28c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f953df2f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f953d3abf80 RCX: 00007f953d28c0f9
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 00007f953d2e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff39044f3f R14: 00007f953df2f300 R15: 0000000000022000
 </TASK>

Allocated by task 12:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x5e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 ieee802_11_parse_elems_full+0x106/0x1340 net/mac80211/util.c:1609
 ieee802_11_parse_elems_crc.constprop.0+0x99/0xd0 net/mac80211/ieee80211_i.h:2311
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2318 [inline]
 ieee80211_bss_info_update+0x410/0xb50 net/mac80211/scan.c:212
 ieee80211_rx_bss_info net/mac80211/ibss.c:1120 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1609 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x18c4/0x2d50 net/mac80211/ibss.c:1638
 ieee80211_iface_process_skb net/mac80211/iface.c:1594 [inline]
 ieee80211_iface_work+0xa4d/0xd70 net/mac80211/iface.c:1648
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 12:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 ieee80211_bss_info_update+0x4a2/0xb50 net/mac80211/scan.c:223
 ieee80211_rx_bss_info net/mac80211/ibss.c:1120 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1609 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x18c4/0x2d50 net/mac80211/ibss.c:1638
 ieee80211_iface_process_skb net/mac80211/iface.c:1594 [inline]
 ieee80211_iface_work+0xa4d/0xd70 net/mac80211/iface.c:1648
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 kvfree_call_rcu+0x70/0xad0 kernel/rcu/tree.c:3331
 neigh_destroy+0x433/0x660 net/core/neighbour.c:910
 neigh_release include/net/neighbour.h:447 [inline]
 neigh_cleanup_and_release net/core/neighbour.c:103 [inline]
 neigh_periodic_work+0x726/0xb80 net/core/neighbour.c:994
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 kvfree_call_rcu+0x70/0xad0 kernel/rcu/tree.c:3331
 put_css_set_locked kernel/cgroup/cgroup.c:995 [inline]
 put_css_set_locked+0xad9/0x1080 kernel/cgroup/cgroup.c:961
 put_css_set kernel/cgroup/cgroup-internal.h:209 [inline]
 put_css_set kernel/cgroup/cgroup-internal.h:196 [inline]
 cgroup_free+0x87/0x1d0 kernel/cgroup/cgroup.c:6717
 __put_task_struct+0x10e/0x3d0 kernel/fork.c:976
 put_task_struct include/linux/sched/task.h:126 [inline]
 delayed_put_task_struct+0x1f5/0x280 kernel/exit.c:225
 rcu_do_batch kernel/rcu/tree.c:2123 [inline]
 rcu_core+0x801/0x1b80 kernel/rcu/tree.c:2387
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571

The buggy address belongs to the object at ffff88806fde3000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 864 bytes inside of
 freed 1024-byte region [ffff88806fde3000, ffff88806fde3400)

The buggy address belongs to the physical page:
page:ffffea0001bf7800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6fde0
head:ffffea0001bf7800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012441dc0 ffffea0002518c00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5186, tgid 5186 (kworker/1:4), ts 283030316376, free_ts 281186381095
 prep_new_page mm/page_alloc.c:1729 [inline]
 get_page_from_freelist+0xf75/0x2aa0 mm/page_alloc.c:3493
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4759
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x28e/0x380 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 neigh_alloc net/core/neighbour.c:486 [inline]
 ___neigh_create+0x156f/0x2a40 net/core/neighbour.c:640
 ip6_finish_output2+0xfef/0x1570 net/ipv6/ip6_output.c:125
 __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
 ip6_finish_output+0x69a/0x1170 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x1f1/0x540 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:458 [inline]
 NF_HOOK include/linux/netfilter.h:302 [inline]
 ndisc_send_skb+0xa63/0x1850 net/ipv6/ndisc.c:508
 ndisc_send_rs+0x132/0x6f0 net/ipv6/ndisc.c:718
 addrconf_dad_completed+0x37a/0xe00 net/ipv6/addrconf.c:4254
 addrconf_dad_work+0x75d/0x1390 net/ipv6/addrconf.c:4162
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x4d8/0xb80 mm/page_alloc.c:2555
 free_unref_page+0x33/0x370 mm/page_alloc.c:2650
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 kmem_cache_alloc_node+0x185/0x3e0 mm/slub.c:3497
 __alloc_skb+0x288/0x330 net/core/skbuff.c:594
 alloc_skb include/linux/skbuff.h:1269 [inline]
 nlmsg_new include/net/netlink.h:1003 [inline]
 netlink_ack+0x357/0x1360 net/netlink/af_netlink.c:2509
 netlink_rcv_skb+0x34f/0x440 net/netlink/af_netlink.c:2578
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 __sys_sendto+0x23a/0x340 net/socket.c:2142
 __do_sys_sendto net/socket.c:2154 [inline]
 __se_sys_sendto net/socket.c:2150 [inline]
 __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2150
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88806fde3200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806fde3280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806fde3300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88806fde3380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806fde3400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
