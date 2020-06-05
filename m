Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC21EEF90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 04:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgFECiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 22:38:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbgFECiP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 22:38:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 961954AA5641024DAF77;
        Fri,  5 Jun 2020 10:38:13 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 5 Jun 2020
 10:38:07 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangyingliang@huawei.com>
Subject: [PATCH] hfs: fix null-ptr-deref in hfs_find_init()
Date:   Fri, 5 Jun 2020 11:01:07 +0800
Message-ID: <1591326067-29972-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a null-ptr-deref in hfs_find_init():

[  107.092729] hfs: continuing without an alternate MDB
[  107.097632] general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN PTI
[  107.104679] KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
[  107.109100] CPU: 0 PID: 379 Comm: hfs_inject Not tainted 5.7.0-rc7-00001-g24627f5f2973 #897
[  107.114142] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  107.121095] RIP: 0010:hfs_find_init+0x72/0x170
[  107.123609] Code: c1 ea 03 80 3c 02 00 0f 85 e6 00 00 00 4c 8d 65 40 48 c7 43 18 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e a5 00 00 00 8b 45 40 be c0 0c
[  107.134660] RSP: 0018:ffff88810291f3f8 EFLAGS: 00010202
[  107.137897] RAX: dffffc0000000000 RBX: ffff88810291f468 RCX: 1ffff110175cdf05
[  107.141874] RDX: 0000000000000008 RSI: ffff88810291f468 RDI: ffff88810291f480
[  107.145844] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed1020381013
[  107.149431] R10: ffff88810291f500 R11: ffffed1020381012 R12: 0000000000000040
[  107.152315] R13: 0000000000000000 R14: ffff888101c0814a R15: ffff88810291f468
[  107.155464] FS:  00000000009ea880(0000) GS:ffff88810c600000(0000) knlGS:0000000000000000
[  107.159795] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  107.162987] CR2: 00005605a19dd284 CR3: 0000000103a0c006 CR4: 0000000000020ef0
[  107.166665] Call Trace:
[  107.167969]  ? find_held_lock+0x33/0x1c0
[  107.169972]  hfs_ext_read_extent+0x16b/0xb00
[  107.172092]  ? create_page_buffers+0x14e/0x1b0
[  107.174303]  ? hfs_free_extents+0x280/0x280
[  107.176437]  ? lock_downgrade+0x730/0x730
[  107.178272]  hfs_get_block+0x496/0x8a0
[  107.179972]  block_read_full_page+0x241/0x8d0
[  107.181971]  ? hfs_extend_file+0xae0/0xae0
[  107.183814]  ? end_buffer_async_read_io+0x10/0x10
[  107.185954]  ? add_to_page_cache_lru+0x13f/0x1f0
[  107.188006]  ? add_to_page_cache_locked+0x10/0x10
[  107.190175]  do_read_cache_page+0xc6a/0x1180
[  107.192096]  ? generic_file_read_iter+0x4c0/0x4c0
[  107.194234]  ? hfs_btree_open+0x408/0x1000
[  107.196068]  ? lock_downgrade+0x730/0x730
[  107.197926]  ? wake_bit_function+0x180/0x180
[  107.199845]  ? lockdep_init_map_waits+0x267/0x7c0
[  107.201895]  hfs_btree_open+0x455/0x1000
[  107.203479]  hfs_mdb_get+0x122c/0x1ae8
[  107.205065]  ? hfs_mdb_put+0x350/0x350
[  107.206590]  ? queue_work_node+0x260/0x260
[  107.208309]  ? rcu_read_lock_sched_held+0xa1/0xd0
[  107.210227]  ? lockdep_init_map_waits+0x267/0x7c0
[  107.212144]  ? lockdep_init_map_waits+0x267/0x7c0
[  107.213979]  hfs_fill_super+0x9ba/0x1280
[  107.215444]  ? bdev_name.isra.9+0xf1/0x2b0
[  107.217028]  ? hfs_remount+0x190/0x190
[  107.218428]  ? pointer+0x5da/0x710
[  107.219745]  ? file_dentry_name+0xf0/0xf0
[  107.221262]  ? mount_bdev+0xd1/0x330
[  107.222592]  ? vsnprintf+0x7bd/0x1250
[  107.224007]  ? pointer+0x710/0x710
[  107.225332]  ? down_write+0xe5/0x160
[  107.226698]  ? hfs_remount+0x190/0x190
[  107.228120]  ? snprintf+0x91/0xc0
[  107.229388]  ? vsprintf+0x10/0x10
[  107.230628]  ? sget+0x3af/0x4a0
[  107.231848]  ? hfs_remount+0x190/0x190
[  107.233300]  mount_bdev+0x26e/0x330
[  107.234611]  ? hfs_statfs+0x540/0x540
[  107.236015]  legacy_get_tree+0x101/0x1f0
[  107.237431]  ? security_capable+0x58/0x90
[  107.238832]  vfs_get_tree+0x89/0x2d0
[  107.240082]  ? ns_capable_common+0x5c/0xd0
[  107.241521]  do_mount+0xd8a/0x1720
[  107.242727]  ? lock_downgrade+0x730/0x730
[  107.244116]  ? copy_mount_string+0x20/0x20
[  107.245557]  ? _copy_from_user+0xbe/0x100
[  107.246967]  ? memdup_user+0x47/0x70
[  107.248212]  __x64_sys_mount+0x162/0x1b0
[  107.249537]  do_syscall_64+0xa5/0x4f0
[  107.250742]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[  107.252369] RIP: 0033:0x44e8ea
[  107.253360] Code: 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
[  107.259240] RSP: 002b:00007ffd910e4c28 EFLAGS: 00000207 ORIG_RAX: 00000000000000a5
[  107.261668] RAX: ffffffffffffffda RBX: 0000000000400400 RCX: 000000000044e8ea
[  107.263920] RDX: 000000000049321e RSI: 0000000000493222 RDI: 00007ffd910e4d00
[  107.266177] RBP: 00007ffd910e5d10 R08: 0000000000000000 R09: 000000000000000a
[  107.268451] R10: 0000000000000001 R11: 0000000000000207 R12: 0000000000401c40
[  107.270721] R13: 0000000000000000 R14: 00000000006ba018 R15: 0000000000000000
[  107.273025] Modules linked in:
[  107.274029] Dumping ftrace buffer:
[  107.275121]    (ftrace buffer empty)
[  107.276370] ---[ end trace c5e0b9d684f3570e ]---

We need check tree in hfs_find_init().

https://lore.kernel.org/linux-fsdevel/20180419024358.GA5215@bombadil.infradead.org/
https://marc.info/?l=linux-fsdevel&m=152406881024567&w=2
References: CVE-2018-12928
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/hfs/bfind.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 4af318f..aafa6bd 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -16,6 +16,8 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 {
 	void *ptr;
 
+	if (!tree)
+		return -EINVAL;
 	fd->tree = tree;
 	fd->bnode = NULL;
 	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
-- 
1.8.3

