Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2564C26F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 22:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfI3Und convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 16:43:33 -0400
Received: from albireo.enyo.de ([37.24.231.21]:55542 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfI3Und (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:43:33 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iF11W-0000Rv-Kq; Mon, 30 Sep 2019 19:07:54 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iF11V-0006lS-HQ; Mon, 30 Sep 2019 21:07:53 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: xfs_inode not reclaimed/memory leak on 5.2.16
References: <87pnji8cpw.fsf@mid.deneb.enyo.de>
        <20190930085406.GP16973@dread.disaster.area>
Date:   Mon, 30 Sep 2019 21:07:53 +0200
In-Reply-To: <20190930085406.GP16973@dread.disaster.area> (Dave Chinner's
        message of "Mon, 30 Sep 2019 18:54:06 +1000")
Message-ID: <87o8z1fvqu.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Dave Chinner:

> On Mon, Sep 30, 2019 at 09:28:27AM +0200, Florian Weimer wrote:
>> Simply running “du -hc” on a large directory tree causes du to be
>> killed because of kernel paging request failure in the XFS code.
>
> dmesg output? if the system was still running, then you might be
> able to pull the trace from syslog. But we can't do much without
> knowing what the actual failure was....

Huh.  I actually have something in syslog:

[ 4001.238411] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 4001.238415] #PF: supervisor read access in kernel mode
[ 4001.238417] #PF: error_code(0x0000) - not-present page
[ 4001.238418] PGD 0 P4D 0 
[ 4001.238420] Oops: 0000 [#1] SMP PTI
[ 4001.238423] CPU: 3 PID: 143 Comm: kswapd0 Tainted: G          I       5.2.16fw+ #1
[ 4001.238424] Hardware name: System manufacturer System Product Name/P6X58D-E, BIOS 0701    05/10/2011
[ 4001.238430] RIP: 0010:__reset_isolation_pfn+0x27f/0x3c0
[ 4001.238432] Code: 44 c6 48 8b 00 a8 10 74 bc 49 8b 16 48 89 d0 48 c1 ea 35 48 8b 14 d7 48 c1 e8 2d 48 85 d2 74 0a 0f b6 c0 48 c1 e0 04 48 01 c2 <48> 8b 02 4c 89 f2 41 b8 01 00 00 00 31 f6 b9 03 00 00 00 4c 89 f7
[ 4001.238433] RSP: 0018:ffffc900003e7de0 EFLAGS: 00010246
[ 4001.238435] RAX: 0000000000057285 RBX: 0000000000108000 RCX: 0000000000000000
[ 4001.238437] RDX: 0000000000000000 RSI: 0000000000000210 RDI: ffff88833fffa000
[ 4001.238438] RBP: ffffc900003e7e18 R08: 0000000000000004 R09: ffff888335000000
[ 4001.238439] R10: ffff88833fff9000 R11: 0000000000000000 R12: 0000000000000000
[ 4001.238440] R13: 0000000000000000 R14: ffff8883389c01c0 R15: 0000000000000001
[ 4001.238442] FS:  0000000000000000(0000) GS:ffff888333cc0000(0000) knlGS:0000000000000000
[ 4001.238444] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4001.238445] CR2: 0000000000000000 CR3: 000000000200a003 CR4: 00000000000206e0
[ 4001.238446] Call Trace:
[ 4001.238450]  __reset_isolation_suitable+0x9b/0x120
[ 4001.238453]  reset_isolation_suitable+0x3b/0x40
[ 4001.238456]  kswapd+0x98/0x300
[ 4001.238460]  ? wait_woken+0x80/0x80
[ 4001.238463]  kthread+0x114/0x130
[ 4001.238465]  ? balance_pgdat+0x450/0x450
[ 4001.238467]  ? kthread_park+0x80/0x80
[ 4001.238470]  ret_from_fork+0x1f/0x30
[ 4001.238472] Modules linked in: nfnetlink 8021q garp stp llc fuse ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_filter xt_state xt_conntrack iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter tun ip6_tables binfmt_misc mxm_wmi evdev snd_hda_codec_hdmi coretemp snd_hda_intel kvm_intel snd_hda_codec serio_raw kvm snd_hwdep irqbypass snd_hda_core pcspkr snd_pcm snd_timer snd soundcore sg i7core_edac asus_atk0110 wmi button loop ip_tables x_tables raid10 raid456 async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor async_tx raid1 raid0 multipath linear md_mod hid_generic usbhid hid crc32c_intel psmouse sr_mod cdrom radeon e1000e ptp xhci_pci pps_core uhci_hcd ehci_pci xhci_hcd ehci_hcd sky2 usbcore ttm usb_common sd_mod
[ 4001.238509] CR2: 0000000000000000
[ 4001.238511] ---[ end trace 3cdcc14b40255fe6 ]---
[ 4001.238514] RIP: 0010:__reset_isolation_pfn+0x27f/0x3c0
[ 4001.238516] Code: 44 c6 48 8b 00 a8 10 74 bc 49 8b 16 48 89 d0 48 c1 ea 35 48 8b 14 d7 48 c1 e8 2d 48 85 d2 74 0a 0f b6 c0 48 c1 e0 04 48 01 c2 <48> 8b 02 4c 89 f2 41 b8 01 00 00 00 31 f6 b9 03 00 00 00 4c 89 f7
[ 4001.238518] RSP: 0018:ffffc900003e7de0 EFLAGS: 00010246
[ 4001.238519] RAX: 0000000000057285 RBX: 0000000000108000 RCX: 0000000000000000
[ 4001.238521] RDX: 0000000000000000 RSI: 0000000000000210 RDI: ffff88833fffa000
[ 4001.238522] RBP: ffffc900003e7e18 R08: 0000000000000004 R09: ffff888335000000
[ 4001.238523] R10: ffff88833fff9000 R11: 0000000000000000 R12: 0000000000000000
[ 4001.238524] R13: 0000000000000000 R14: ffff8883389c01c0 R15: 0000000000000001
[ 4001.238526] FS:  0000000000000000(0000) GS:ffff888333cc0000(0000) knlGS:0000000000000000
[ 4001.238528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4001.238529] CR2: 0000000000000000 CR3: 000000000200a003 CR4: 00000000000206e0
[ 4001.709169] BUG: unable to handle page fault for address: ffffc900003e7ec8
[ 4001.709172] #PF: supervisor read access in kernel mode
[ 4001.709173] #PF: error_code(0x0000) - not-present page
[ 4001.709174] PGD 33201a067 P4D 33201a067 PUD 33201b067 PMD 3322af067 PTE 0
[ 4001.709177] Oops: 0000 [#2] SMP PTI
[ 4001.709179] CPU: 1 PID: 10507 Comm: du Tainted: G      D   I       5.2.16fw+ #1
[ 4001.709180] Hardware name: System manufacturer System Product Name/P6X58D-E, BIOS 0701    05/10/2011
[ 4001.709184] RIP: 0010:__wake_up_common+0x3c/0x130
[ 4001.709186] Code: 85 c9 74 0a 41 f6 01 04 0f 85 9f 00 00 00 48 8b 47 08 48 8d 5f 08 48 83 e8 18 48 8d 78 18 48 39 fb 0f 84 ca 00 00 00 89 75 d4 <48> 8b 70 18 4d 89 cd 45 31 e4 4c 89 45 c8 89 4d d0 89 55 c4 4c 8d
[ 4001.709187] RSP: 0018:ffffc900043db5e0 EFLAGS: 00010012
[ 4001.709188] RAX: ffffc900003e7eb0 RBX: ffffffff82066f00 RCX: 0000000000000000
[ 4001.709189] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffc900003e7ec8
[ 4001.709190] RBP: ffffc900043db620 R08: 0000000000000000 R09: ffffc900043db638
[ 4001.709191] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000001
[ 4001.709192] R13: 0000000000000286 R14: 0000000000000000 R15: 0000000000000000
[ 4001.709193] FS:  00007f0090d20540(0000) GS:ffff888333c40000(0000) knlGS:0000000000000000
[ 4001.709194] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4001.709195] CR2: ffffc900003e7ec8 CR3: 00000002b85dc004 CR4: 00000000000206e0
[ 4001.709195] Call Trace:
[ 4001.709198]  __wake_up_common_lock+0x6c/0x90
[ 4001.709200]  __wake_up+0xe/0x10
[ 4001.709203]  wakeup_kswapd+0xf4/0x120
[ 4001.709206]  get_page_from_freelist+0x52e/0xc80
[ 4001.709208]  __alloc_pages_nodemask+0xf0/0xcc0
[ 4001.709209]  ? get_page_from_freelist+0xa8d/0xc80
[ 4001.709212]  ? radix_tree_lookup+0xd/0x10
[ 4001.709215]  ? kmem_cache_alloc+0x80/0xa0
[ 4001.709217]  xfs_buf_allocate_memory+0x20e/0x320
[ 4001.709219]  xfs_buf_get_map+0xe8/0x190
[ 4001.709220]  xfs_buf_read_map+0x25/0x100
[ 4001.709223]  xfs_trans_read_buf_map+0xb2/0x1f0
[ 4001.709225]  xfs_imap_to_bp+0x53/0xa0
[ 4001.709226]  xfs_iread+0x76/0x1b0
[ 4001.709229]  xfs_iget+0x1e5/0x700
[ 4001.709231]  xfs_lookup+0x63/0x90
[ 4001.709232]  xfs_vn_lookup+0x47/0x80
[ 4001.709235]  __lookup_slow+0x7f/0x120
[ 4001.709236]  lookup_slow+0x35/0x50
[ 4001.709238]  walk_component+0x193/0x2a0
[ 4001.709239]  ? path_init+0x112/0x2f0
[ 4001.709240]  path_lookupat.isra.16+0x5c/0x200
[ 4001.709242]  filename_lookup.part.27+0x88/0x100
[ 4001.709243]  ? xfs_ilock+0x39/0x90
[ 4001.709245]  ? __check_object_size+0xf6/0x187
[ 4001.709248]  ? strncpy_from_user+0x56/0x1c0
[ 4001.709249]  user_path_at_empty+0x39/0x40
[ 4001.709250]  vfs_statx+0x62/0xb0
[ 4001.709252]  __se_sys_newfstatat+0x26/0x50
[ 4001.709254]  __x64_sys_newfstatat+0x19/0x20
[ 4001.709255]  do_syscall_64+0x4b/0x260
[ 4001.709257]  ? page_fault+0x8/0x30
[ 4001.709259]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4001.709261] RIP: 0033:0x7f0090c47e49
[ 4001.709262] Code: 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 89 f0 48 89 d6 83 ff 01 77 36 89 c7 45 89 c2 48 89 ca b8 06 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 07 c3 66 0f 1f 44 00 00 48 8b 15 11 10 0d 00
[ 4001.709263] RSP: 002b:00007fffee0929e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
[ 4001.709264] RAX: ffffffffffffffda RBX: 00005635d95cfe00 RCX: 00007f0090c47e49
[ 4001.709265] RDX: 00005635d95cfe78 RSI: 00005635d95cff08 RDI: 0000000000000004
[ 4001.709266] RBP: 00005635d95cfe78 R08: 0000000000000100 R09: 0000000000000001
[ 4001.709267] R10: 0000000000000100 R11: 0000000000000246 R12: 00005635d8c1e5c0
[ 4001.709268] R13: 00005635d95cfe00 R14: 00005635d8c1e650 R15: 000000000000000b
[ 4001.709269] Modules linked in: nfnetlink 8021q garp stp llc fuse ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_filter xt_state xt_conntrack iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter tun ip6_tables binfmt_misc mxm_wmi evdev snd_hda_codec_hdmi coretemp snd_hda_intel kvm_intel snd_hda_codec serio_raw kvm snd_hwdep irqbypass snd_hda_core pcspkr snd_pcm snd_timer snd soundcore sg i7core_edac asus_atk0110 wmi button loop ip_tables x_tables raid10 raid456 async_raid6_recov async_memcpy async_pq raid6_pq async_xor xor async_tx raid1 raid0 multipath linear md_mod hid_generic usbhid hid crc32c_intel psmouse sr_mod cdrom radeon e1000e ptp xhci_pci pps_core uhci_hcd ehci_pci xhci_hcd ehci_hcd sky2 usbcore ttm usb_common sd_mod
[ 4001.709293] CR2: ffffc900003e7ec8
[ 4001.709295] ---[ end trace 3cdcc14b40255fe7 ]---
[ 4001.709297] RIP: 0010:__reset_isolation_pfn+0x27f/0x3c0
[ 4001.709299] Code: 44 c6 48 8b 00 a8 10 74 bc 49 8b 16 48 89 d0 48 c1 ea 35 48 8b 14 d7 48 c1 e8 2d 48 85 d2 74 0a 0f b6 c0 48 c1 e0 04 48 01 c2 <48> 8b 02 4c 89 f2 41 b8 01 00 00 00 31 f6 b9 03 00 00 00 4c 89 f7
[ 4001.709299] RSP: 0018:ffffc900003e7de0 EFLAGS: 00010246
[ 4001.709300] RAX: 0000000000057285 RBX: 0000000000108000 RCX: 0000000000000000
[ 4001.709301] RDX: 0000000000000000 RSI: 0000000000000210 RDI: ffff88833fffa000
[ 4001.709302] RBP: ffffc900003e7e18 R08: 0000000000000004 R09: ffff888335000000
[ 4001.709303] R10: ffff88833fff9000 R11: 0000000000000000 R12: 0000000000000000
[ 4001.709304] R13: 0000000000000000 R14: ffff8883389c01c0 R15: 0000000000000001
[ 4001.709305] FS:  00007f0090d20540(0000) GS:ffff888333c40000(0000) knlGS:0000000000000000
[ 4001.709306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4001.709307] CR2: ffffc900003e7ec8 CR3: 00000002b85dc004 CR4: 00000000000206e0

So XFS wasn't *that* unhappy if it could still write to the file
system.

> FWIW, one of my regular test workloads is iterating a directory tree
> with 50 million inodes in several different ways to stress reclaim
> algorithms in ways that users do. I haven't seen issues with that
> test for a while, so it's not an obvious problem whatever you came
> across.

Right, I should have tried to reproduce it first.  I actually can't.
