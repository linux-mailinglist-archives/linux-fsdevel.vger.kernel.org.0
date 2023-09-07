Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1F797B84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbjIGSTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343726AbjIGSTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:19:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B7D1A8;
        Thu,  7 Sep 2023 11:19:23 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.216.208])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7DB8C6607314;
        Thu,  7 Sep 2023 13:56:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694091419;
        bh=WsxD3QAj9D0dO60nTDlkBkdGVfhYp4rFqJDQuXMSfKY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=X7YuDGv2vAt4kQZCrL/reX0M9QFni/ByfSPYposj/RPC0sDYfOO1J7VkVAZ6chLun
         1k20es40EqtqKQLIlMvH1c3dhJ/E6a3dCAZMRr3Gfe1zKQEAriTZFsKg5RdZh/dlBy
         MTjlAZ1BjymhUCyi/UE0AraR469/Z+Smqg1dk+m6OgoGt357fHjSCOrxIXfm6Dh+tD
         8ctpG4SpV6weZ7PRPFzu04F1t6nJ+bf2jlcUzZgZxCdFwHiMrXn29Hphp4+qOWpVGr
         tF/WoVQjiZ59ftfcnaOtrNcugnJKF5iJo2hNfTo4uVwwBvdMSyArFlOBwYncpR1JoQ
         ZautUNYl8NJCA==
Message-ID: <7965cc78-941f-480f-9222-f5131b1f9191@collabora.com>
Date:   Thu, 7 Sep 2023 17:56:52 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in
 ext4_ext_remove_space
To:     syzbot <syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Allison Henderson <achender@us.ibm.com>,
        Alex Tomas <alex@clusterfs.com>,
        Allison Henderson <achender@us.ibm.com>
References: <0000000000001655710600710dd0@google.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <0000000000001655710600710dd0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/14/23 4:50 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit: 06c2afb862f9 Linux 6.5-rc1
> git tree: upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13d550a2a80000
> kernel config: https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
> dashboard link: https://syzkaller.appspot.com/bug?extid=6e5f2db05775244c73b7
> compiler: Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=11fc4702a80000
> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=172a98eca80000
The last crash on upstream/mainline happened at e6fda526d9db. On the latest
mainline 7ba2090ca64ea, there is no crash. I've searched on mailing lists
if some fix has been merged. I've not found anything. The same bug is
present on LTS kernels.

In fs/ext4/extents.c:

memmove(ex, ex+1,
	(EXT_LAST_EXTENT(eh) - ex) * sizeof(struct ext4_extent));

When crash happens:
EXT_LAST_EXTENT(eh) = 0xFFFF888130260000
ex = 0xFFFF88813026006C

These are wrong values. EXT_LAST_EXTENT(eh) - ex results in negative value
as ex is bigger. The bigger ex is bug in itself. ex is the member of this
list with header eh. Any help would be much appreciated.

> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b66ebf11f3d4/disk-06c2afb8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e277ce7d54f6/vmlinux-06c2afb8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5d0b981e9278/bzImage-06c2afb8.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c48fda4748ae/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com
> 
> EXT4-fs error (device loop0) in ext4_mb_clear_bb:6537: Corrupt filesystem
> ==================================================================
> BUG: KASAN: out-of-bounds in ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
> BUG: KASAN: out-of-bounds in ext4_ext_remove_space+0x2482/0x4d90 fs/ext4/extents.c:2958
> Read of size 18446744073709551508 at addr ffff888073aea078 by task syz-executor420/6443
> 
> CPU: 1 PID: 6443 Comm: syz-executor420 Not tainted 6.5.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:364 [inline]
> print_report+0x163/0x540 mm/kasan/report.c:475
> kasan_report+0x175/0x1b0 mm/kasan/report.c:588
> kasan_check_range+0x27e/0x290 mm/kasan/generic.c:187
> __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
> ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
> ext4_ext_remove_space+0x2482/0x4d90 fs/ext4/extents.c:2958
> ext4_punch_hole+0x7a0/0xc10 fs/ext4/inode.c:3977
> ext4_fallocate+0x311/0x1f90 fs/ext4/extents.c:4706
> vfs_fallocate+0x551/0x6b0 fs/open.c:324
> do_vfs_ioctl+0x22cb/0x2b30 fs/ioctl.c:849
> __do_sys_ioctl fs/ioctl.c:868 [inline]
> __se_sys_ioctl+0x81/0x170 fs/ioctl.c:856
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7ff03605dce9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff02dc072f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ff0360e27c0 RCX: 00007ff03605dce9
> RDX: 0000000020000080 RSI: 000000004030582b RDI: 0000000000000004
> RBP: 00007ff0360af678 R08: 00007ff02dc07700 R09: 0000000000000000
> R10: 00007ff02dc07700 R11: 0000000000000246 R12: 65766f6365726f6e
> R13: 0031656c69662f2e R14: 6f6f6c2f7665642f R15: 00007ff0360e27c8
> </TASK>
> 
> The buggy address belongs to the physical page:
> page:ffffea0001ceba80 refcount:2 mapcount:0 mapping:ffff88801e21cd80 index:0x2b pfn:0x73aea
> memcg:ffff888141652000
> aops:def_blk_aops ino:700000
> flags: 0xfff00000002036(referenced|uptodate|lru|active|private|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000002036 ffffea0001c164c8 ffffea0001f600c8 ffff88801e21cd80
> raw: 000000000000002b ffff8880729c1d98 00000002ffffffff ffff888141652000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 6428, tgid 6426 (syz-executor420), ts 165572616396, free_ts 165556735464
> set_page_owner include/linux/page_owner.h:31 [inline]
> post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
> prep_new_page mm/page_alloc.c:1577 [inline]
> get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
> __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
> folio_alloc+0x1e/0x60 mm/mempolicy.c:2289
> filemap_alloc_folio+0xde/0x500 mm/filemap.c:979
> __filemap_get_folio+0x323/0xa00 mm/filemap.c:1933
> grow_dev_page fs/buffer.c:1063 [inline]
> grow_buffers fs/buffer.c:1123 [inline]
> __getblk_slow fs/buffer.c:1150 [inline]
> __getblk_gfp+0x218/0x630 fs/buffer.c:1445
> sb_getblk_gfp include/linux/buffer_head.h:376 [inline]
> ext4_ext_grow_indepth fs/ext4/extents.c:1334 [inline]
> ext4_ext_create_new_leaf fs/ext4/extents.c:1435 [inline]
> ext4_ext_insert_extent+0xfe3/0x4e60 fs/ext4/extents.c:2102
> ext4_ext_map_blocks+0x1bdc/0x71d0 fs/ext4/extents.c:4306
> ext4_map_blocks+0xa2f/0x1cb0 fs/ext4/inode.c:621
> _ext4_get_block+0x238/0x6a0 fs/ext4/inode.c:763
> ext4_block_write_begin+0x53d/0x1570 fs/ext4/inode.c:1043
> ext4_write_begin+0x619/0x10b0
> ext4_da_write_begin+0x300/0xa40 fs/ext4/inode.c:2867
> generic_perform_write+0x31b/0x630 mm/filemap.c:3923
> ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
> page last free stack trace:
> reset_page_owner include/linux/page_owner.h:24 [inline]
> free_pages_prepare mm/page_alloc.c:1161 [inline]
> free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2348
> free_unref_page_list+0x596/0x830 mm/page_alloc.c:2489
> release_pages+0x2193/0x2470 mm/swap.c:1042
> tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
> tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
> tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
> tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
> unmap_region+0x258/0x2a0 mm/mmap.c:2317
> do_vmi_align_munmap+0x135d/0x1630 mm/mmap.c:2556
> do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2623
> __vm_munmap+0x230/0x450 mm/mmap.c:2905
> __do_sys_munmap mm/mmap.c:2922 [inline]
> __se_sys_munmap mm/mmap.c:2919 [inline]
> __x64_sys_munmap+0x69/0x80 mm/mmap.c:2919
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Memory state around the buggy address:
> ffff888073ae9f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888073ae9f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> ffff888073aea000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ^
> ffff888073aea080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff888073aea100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

-- 
BR,
Muhammad Usama Anjum
