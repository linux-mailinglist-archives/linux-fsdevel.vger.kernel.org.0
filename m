Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9955E35DFEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbhDMNSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 09:18:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16454 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbhDMNSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:18:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKR1X25xSztVpx;
        Tue, 13 Apr 2021 21:15:44 +0800 (CST)
Received: from [10.174.176.32] (10.174.176.32) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 21:17:51 +0800
Subject: Subject: [BUG && Question] question of BUG_ON when a device is
 hot-removed and when a file systems is writing
References: <37b0609b-faac-93cc-2024-ba9f85155569@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <yi.zhang@huawei.com>
From:   "Wangli (T)" <wangli74@huawei.com>
X-Forwarded-Message-Id: <37b0609b-faac-93cc-2024-ba9f85155569@huawei.com>
Message-ID: <fe236201-c6e0-2c4c-b45b-9365e137f05b@huawei.com>
Date:   Tue, 13 Apr 2021 21:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <37b0609b-faac-93cc-2024-ba9f85155569@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello，

We find a BUG_ON in submit_bh_wbc() if a device is hot-removed when a 
file systems is writing.

Code path:

ext4_write_begin()

     __block_write_begin()

         __block_write_begin_int()  <== judge if 'buffer_mapped(bh)' is 
false, it will get_block and continue, this time device still lives.

             ll_rw_block(REQ_OP_READ) <== bh is not uptodate, read from 
device.

                 submit_bh_wbc()  <== judge if 'buffer_mapped(bh)' is 
false,BUG_ON().Block device dies and the buffer heads Buffer_Mapped flag 
get cleared.

stack is below

[41253.006160] kernel BUG at fs/buffer.c:3015!<== 
BUG_ON(!buffer_mapped(bh))' in submit_bh_wbc()
[41253.006767] invalid opcode: 0000 [#1] SMP
[41253.007293] CPU: 0 PID: 22157 Comm: dd Not tainted 
5.10.0-01679-ge46e150e09e0 #2
[41253.008257] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[41253.009778] RIP: 0010:submit_bh_wbc+0x231/0x2e0
[41253.010403] Code: 48 83 05 11 26 7e 0b 01 0f 0b 48 83 05 0f 26 7e 0b 
01 48 83 05 0f 26 7e 0b 01 48 83 05 0f 26 7e 0b 01 48 83 05 0f 26 7e 0b 
01 <0f> 0b 48 83 05 0d 26 7e 0b 01 48 83 05 0d 26 7e 0b 01 48 8d
[41253.012831] RSP: 0018:ffffc90003c17b20 EFLAGS: 00010202
[41253.013526] RAX: 0000000000000004 RBX: ffff88803d083af8 RCX: 
0000000000000000
[41253.014470] RDX: ffff88803d083af8 RSI: 0000000000000000 RDI: 
0000000000000000
[41253.015403] RBP: ffffc90003c17bc8 R08: 0000000000000000 R09: 
ffff888100041800
[41253.016357] R10: 0000000000000000 R11: ffff88810fd71000 R12: 
0000000000000000
[41253.017297] R13: ffffffff9acbda20 R14: ffffffff8f4d9c50 R15: 
ffffc90003c17bc0
[41253.018242] FS: 00007f2d41f0c4c0(0000) GS:ffff88813bc00000(0000) 
knlGS:0000000000000000
[41253.019308] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[41253.020046] CR2: 000055d54d154000 CR3: 00000000ba850000 CR4: 
00000000000006f0
[41253.020962] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[41253.021888] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[41253.022805] Call Trace:
[41253.023146] ? end_buffer_read_nobh+0x20/0x20
[41253.023712] ll_rw_block+0x114/0x140
[41253.024183] __block_write_begin_int+0x343/0x8e0
[41253.024780] ? ext4_block_zero_page_range+0x580/0x580
[41253.025441] ? _cond_resched+0x25/0x70
[41253.025933] ? ext4_journal_check_start+0x16/0xe0
[41253.026548] __block_write_begin+0x15/0x20
[41253.027081] ext4_write_begin+0x5f3/0x970
[41253.027624] ext4_da_write_begin+0x15d/0x720
[41253.028186] generic_perform_write+0xd3/0x240
[41253.028754] ext4_buffered_write_iter+0x107/0x1f0
[41253.029364] ext4_file_write_iter+0x78/0xae0
[41253.029918] ? asm_exc_page_fault+0x1e/0x30
[41253.030466] new_sync_write+0x17e/0x220
[41253.030966] vfs_write+0x32f/0x3d0
[41253.031413] ksys_write+0xdd/0x170
[41253.031857] __x64_sys_write+0x1e/0x30
[41253.032350] do_syscall_64+0x4d/0x70
[41253.032817] entry_SYSCALL_64_after_hwframe+0x44/0xa9

This code path is common write path for other file systems. To address 
this, we think add the check of 'buffer_mapped(bh)' just before 
ll_rw_block().

@@ -2036,7 +2036,7 @@ int __block_write_begin_int(struct page *page, 
loff_t pos, unsigned len,
                         continue;
                 }
                 if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
-                   !buffer_unwritten(bh) &&
+                  !buffer_unwritten(bh) && buffer_mapped(bh) &&
                      (block_start < from || block_end > to)) {
                         ll_rw_block(REQ_OP_READ, 0, 1, &bh);
                         *wait_bh++=bh;

But it's still possible to hit the BUG_ON(!buffer_mapped(bh)) if the 
device dies between when the check before ll_rw_block() and when 
submit_bh_wbh()

is finally called.


Could you give some suggestions?


Thanks,

Wangli.

