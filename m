Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D374D98A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 17:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjGJPGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 11:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjGJPGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:06:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26798123;
        Mon, 10 Jul 2023 08:06:35 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R06kR1TCbzTmQ3;
        Mon, 10 Jul 2023 23:05:19 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 23:06:29 +0800
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_split_extent_at (2)
To:     syzbot <syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tytso@mit.edu>
References: <000000000000f1378f0600025915@google.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <64AC1E74.30606@huawei.com>
Date:   Mon, 10 Jul 2023 23:06:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <000000000000f1378f0600025915@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/9 7:45, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    8689f4f2ea56 Merge tag 'mmc-v6.5-2' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b9cb02a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
> dashboard link: https://syzkaller.appspot.com/bug?extid=0f4d9f68fb6632330c6c
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13977778a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1004666aa80000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/21b63023cf5a/disk-8689f4f2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e04836fe057e/vmlinux-8689f4f2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ee05dfd52843/bzImage-8689f4f2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/e2ab005f1edb/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/ext4_extents.h:200!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 5885 Comm: syz-executor219 Not tainted 6.4.0-syzkaller-12365-g8689f4f2ea56 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
> RIP: 0010:ext4_ext_mark_unwritten fs/ext4/ext4_extents.h:200 [inline]
> RIP: 0010:ext4_split_extent_at+0xd11/0xe10 fs/ext4/extents.c:3221
> Code: e9 d2 f8 ff ff e8 1f 6d 5d ff 66 81 c5 00 80 e9 32 fd ff ff e8 10 6d 5d ff 44 8d bd 00 80 ff ff e9 d1 fc ff ff e8 ff 6c 5d ff <0f> 0b 48 8b 7c 24 18 e8 73 9d b0 ff e9 7f f3 ff ff 48 89 cf e8 46
> RSP: 0018:ffffc900055ef268 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88807d9c0000 RSI: ffffffff82277271 RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807587d00c
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88807587d012
> FS:  00007f4820ae9700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4820ae8fe8 CR3: 0000000028105000 CR4: 0000000000350ee0
> Call Trace:
>   <TASK>
>   ext4_split_extent+0x3fc/0x530 fs/ext4/extents.c:3384
>   ext4_ext_handle_unwritten_extents fs/ext4/extents.c:3874 [inline]
>   ext4_ext_map_blocks+0x2e22/0x5bc0 fs/ext4/extents.c:4166
>   ext4_map_blocks+0x760/0x1890 fs/ext4/inode.c:621
>   ext4_iomap_alloc fs/ext4/inode.c:3276 [inline]
>   ext4_iomap_begin+0x43d/0x7a0 fs/ext4/inode.c:3326
>   iomap_iter+0x446/0x10e0 fs/iomap/iter.c:91
>   __iomap_dio_rw+0x6e3/0x1d80 fs/iomap/direct-io.c:574
>   iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:665
>   ext4_dio_write_iter fs/ext4/file.c:609 [inline]
>   ext4_file_write_iter+0x1102/0x1880 fs/ext4/file.c:720
>   call_write_iter include/linux/fs.h:1871 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x981/0xda0 fs/read_write.c:584
>   ksys_write+0x122/0x250 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f4828f26cd9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4820ae9208 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000034 RCX: 00007f4828f26cd9
> RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000004
> RBP: 00007f4828fa4790 R08: 00007f4828fa4798 R09: 00007f4828fa4798
> R10: 00007f4828fa4798 R11: 0000000000000246 R12: 00007f4828fa479c
> R13: 00007ffef851f96f R14: 00007f4820ae9300 R15: 0000000000022000
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:ext4_ext_mark_unwritten fs/ext4/ext4_extents.h:200 [inline]
> RIP: 0010:ext4_split_extent_at+0xd11/0xe10 fs/ext4/extents.c:3221
> Code: e9 d2 f8 ff ff e8 1f 6d 5d ff 66 81 c5 00 80 e9 32 fd ff ff e8 10 6d 5d ff 44 8d bd 00 80 ff ff e9 d1 fc ff ff e8 ff 6c 5d ff <0f> 0b 48 8b 7c 24 18 e8 73 9d b0 ff e9 7f f3 ff ff 48 89 cf e8 46
> RSP: 0018:ffffc900055ef268 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88807d9c0000 RSI: ffffffff82277271 RDI: 0000000000000007
> RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807587d00c
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88807587d012
> FS:  00007f4820ae9700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffef85799a0 CR3: 0000000028105000 CR4: 0000000000350ee0
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> .
This should be caused by the write block device.
Here's the log I captured writing the block device：
[T15721] blkdev_write_iter:---------bdev=0xffff888117fc5080 loop2-----
[T15722] EXT4-fs error (device loop2) in ext4_reserve_inode_write:5718: 
Corrupt filesystem
[T15722] EXT4-fs (loop2): Remounting filesystem read-only
[T15722] EXT4-fs error (device loop2): ext4_ext_grow_indepth:1468: inode 
#16: comm rep: mark_inode_dirty error
[T15722] general protection fault, probably for non-canonical address 
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
[T15722] KASAN: null-ptr-deref in range 
[0x0000000000000000-0x0000000000000007]


