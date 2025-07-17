Return-Path: <linux-fsdevel+bounces-55287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876F5B094A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 21:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EF9560097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471852FCFE8;
	Thu, 17 Jul 2025 19:14:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F01219A89
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779675; cv=none; b=lpjcPwIWO9A4KF1PoiQncsrwIl1nCgsRU6pN9tavGPbpVthi58QTR2nHvYt+JXp6n1R5M0xbNgVsC5NyoqosWftQigX3bUi6CraOMmQCntgh6MdZ+NnYD53O/ITpHN9M4dbN39hTwupXx0td4EfU/u3tx+X8ZYYtr3inmWekSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779675; c=relaxed/simple;
	bh=YXIaXHoUqoYuU+HXrCEvVcBLB7jeJsAZlK48FJJi+5Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OR7v8FjJkXGWV4coZjG/4eoZsscqbqN6KUN7Qmp0hnbp027ONv9+dYaiQ8D82jMy21jNJq0BBVUsIPXyDRY/aGbaVXVhCBFCFwxfXYF517n1sxr0uiFuwPvJOROOT7PbOlZf/AqiHVZHJuO82H15lNd5X/n5zbhZPQTLkG2O0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8760733a107so140609139f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 12:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779673; x=1753384473;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vv3xgCl/yvOqCCI5JYiwJWXCOH+m5RIIh++oOjy6r2Q=;
        b=D8AklbXQ0dfSfAAaaJjtA+YHW8MLzDzzLJdlc5X309DZ/7cQvvOGihtJ8OXJS/3UM3
         pf2WObeKuFdKvGX4mVlOyddnqiPlFB4oiyE7Sx8lIwJH73S3nQITvoLgLZ0xxepchVBK
         cVDzzxSRaO4cQaAkN1aP+6r9vXwjAQaARxFTIkiVy4uw8vj+wKhq96bzHqZaYonLdo0w
         U8kgIXdwtITCcRSGhCQYAxFeAWi5xpVug/lpBEZYoQarwwRS+x989LMU+d6w9GtSiB1J
         HBbUU8eIQ+JukiUXemu0CPFWxk/s4Zbx2hTrUi0IxIjPVbZJ95VydC6qGeQWZ/F7yQcF
         ZOVw==
X-Gm-Message-State: AOJu0YxMzUs1Phq4P5Cpoh168NOaqJ1viFRb+ZLsPfqNqJVsqEOhvVSw
	5uZWof3U8JYZKSzAGjlZS5MNmJvknFnqx/5pgJAy7+S+KgUtT0YpBBAvI2rSwpViATiM+xBa4GH
	B4nFq4c+/Y0jGzUFoBFhdvo9qMxJskMYAYf0OrsHg/C7uNIMx+0xpIocKMSP2/g==
X-Google-Smtp-Source: AGHT+IEF/ivUk7CnbYEy6daglFzdOoYt+R66zoZiswv/PBun8UXki8Qy9+bWyfZPu5CfxcGr6VGGSzAdMtwRgQmHPzXeYjWMWN2q
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b91:b0:86c:f2ea:d8d3 with SMTP id
 ca18e2360f4ac-879c0928225mr904695039f.10.1752779673392; Thu, 17 Jul 2025
 12:14:33 -0700 (PDT)
Date: Thu, 17 Jul 2025 12:14:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68794b99.a70a0220.693ce.0052.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mikulas@artax.karlin.mff.cuni.cz, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    155a3c003e55 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166d6382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f09d04131ef56b22
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b20d8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ebe58c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b4489a1d2de/disk-155a3c00.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c498d4c0c85/vmlinux-155a3c00.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea8acdf1d890/bzImage-155a3c00.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e47f2d7541be/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com

hpfs: filesystem error: warning: spare dnodes used, try chkdsk
hpfs: You really don't want any checks? You are crazy...
hpfs: hpfs_map_sector(): read error
hpfs: code page support is disabled
==================================================================
BUG: KASAN: use-after-free in strcmp+0x6f/0xc0 lib/string.c:283
Read of size 1 at addr ffff8880116728a6 by task syz-executor411/6741

CPU: 1 UID: 0 PID: 6741 Comm: syz-executor411 Not tainted 6.16.0-rc6-syzkaller-00002-g155a3c003e55 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 strcmp+0x6f/0xc0 lib/string.c:283
 hpfs_get_ea+0x114/0xdb0 fs/hpfs/ea.c:139
 hpfs_read_inode+0x19d/0x1010 fs/hpfs/inode.c:63
 hpfs_fill_super+0x12bd/0x2070 fs/hpfs/super.c:654
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1681
 vfs_get_tree+0x92/0x2b0 fs/super.c:1804
 do_new_mount+0x24a/0xa40 fs/namespace.c:3902
 do_mount fs/namespace.c:4239 [inline]
 __do_sys_mount fs/namespace.c:4450 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f718b86112a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee99fcba8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffee99fcbc0 RCX: 00007f718b86112a
RDX: 0000200000009e80 RSI: 0000200000009ec0 RDI: 00007ffee99fcbc0
RBP: 0000200000009ec0 R08: 00007ffee99fcc00 R09: 0000000000009dfd
R10: 0000000000000041 R11: 0000000000000286 R12: 0000200000009e80
R13: 0000000000000004 R14: 0000000000000003 R15: 00007ffee99fcc00
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11672
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001ff38c8 ffffea0001ff3908 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5213, tgid 5213 (udevd), ts 38150701195, free_ts 195740390996
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 folio_alloc_mpol_noprof+0x39/0x70 mm/mempolicy.c:2438
 shmem_alloc_folio mm/shmem.c:1851 [inline]
 shmem_alloc_and_add_folio+0x447/0xf60 mm/shmem.c:1890
 shmem_get_folio_gfp+0x59d/0x1660 mm/shmem.c:2536
 shmem_get_folio mm/shmem.c:2642 [inline]
 shmem_write_begin+0xf7/0x2b0 mm/shmem.c:3292
 generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
 shmem_file_write_iter+0xf8/0x120 mm/shmem.c:3467
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x54b/0xa90 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6740 tgid 6740 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 free_unref_folios+0xcd2/0x1570 mm/page_alloc.c:2763
 folios_put_refs+0x559/0x640 mm/swap.c:992
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x49e/0x14b0 mm/shmem.c:1125
 shmem_truncate_range mm/shmem.c:1237 [inline]
 shmem_evict_inode+0x272/0xa70 mm/shmem.c:1365
 evict+0x501/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1114
 shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1141
 shrink_dcache_parent+0xa1/0x2c0 fs/dcache.c:-1
 do_one_tree+0x23/0xe0 fs/dcache.c:1604
 shrink_dcache_for_umount+0xa0/0x170 fs/dcache.c:1621
 generic_shutdown_super+0x67/0x2c0 fs/super.c:621
 kill_anon_super fs/super.c:1282 [inline]
 kill_litter_super+0x76/0xb0 fs/super.c:1292
 deactivate_locked_super+0xbc/0x130 fs/super.c:474
 cleanup_mnt+0x425/0x4c0 fs/namespace.c:1417
 task_work_run+0x1d4/0x260 kernel/task_work.c:227

Memory state around the buggy address:
 ffff888011672780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888011672800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888011672880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff888011672900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888011672980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

