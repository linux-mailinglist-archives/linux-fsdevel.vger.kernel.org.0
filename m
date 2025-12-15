Return-Path: <linux-fsdevel+bounces-71305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DCCCBD662
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56650301396A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D23168F1;
	Mon, 15 Dec 2025 10:44:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BB3168E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795477; cv=none; b=p40TFCZPfVo/qerCUeM95LyLUU8WOCdOJqitxWfFjEuV046R1KSGvez2Wi67UzP4j3c5XXtwMeOn4Cv5dkJ53Bc0DIIVDyApLWMcUwwgXg00AqopReB6UyMSZTMdFII9d+FMX/pCYguUlhbZ60zP47sB3Af2mfyFYqnjX/q8T7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795477; c=relaxed/simple;
	bh=uFETebDBxR8cujiqPBalfjv9ymqc37v8PPuTb63vDqo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UgCRgOq+yiluetyHy7JDoIEd4gT3jjNZqw89cNUN30hbaGVfL42uTJonnp0UorfzVnUbrJzLSfzi+bb6ljEuBpiuaWAUUXbFy8IZH2WOpPGh/FvDpVpGIRiSisEX1LuIGWYDXlg05MqYkSNsutl+kihFq/gFreSBKpxkAazKmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7c75798bfacso7817437a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 02:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765795475; x=1766400275;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqCNuwmA4fbA37GlLvH1uHV20RN2FR+FjvmX3WZ33UE=;
        b=Z9My97GdnXOs2v3/ymEYX6G6xlyopElDAe88+nhhh0hoQw2WYNAYVoTwKBGlN68vee
         l8DqKtWU7YGy6Cm+PyqSaznEeDZiUkkLsASQfT5rtGVVbi+GptSpFx3UHuhkGiJDPPSN
         aRNE9BjF1OpV/pM29k7vrLYzxecR8eJ0J2LSxZHq49lDoWHelugt3Ef8XAMSvmGqiijV
         U2ah6rZwNaf8NgfahueAiGDvVErSecann6qSu4UtgBAudDthdmjO4Jngv/sa0bCNFcHk
         omqYZqiUXkD7O66kAxU4qy3VfN0CFYhB1N17aINBn0jgkvy6+1ESEMQJJAg8yAYHSVHA
         iYbg==
X-Forwarded-Encrypted: i=1; AJvYcCVHYPiZiA0xrG2TOobqJeh7vciVTVySOxCOZG/dTK5QfJIkXwa6tDH2y1/1qGWdONBQ/CxH/MCptefUzjGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYLFb/yj/6CscHDH5mtVQhhtjdJQRZ8r5dZcfg7q0QPVaxWMGa
	sH6qpUePwxpchyOahtxoeSpkhNOwa/tRuTyl36pS4o3kf+2UHeDISzOZrgQHq1Aa9x4hFP074Hc
	mV/MoLky2v+es1Xf0+f/OJFlPkpvdNIHaitzC/wcdJVOfYJQauwcjOE8VOWw=
X-Google-Smtp-Source: AGHT+IHo4gJjjhrRPFyJ9Gs244i1tNBM1GLQIxw95uTKBrJVMwsHDbLnLCjCh33girb31Da/Ohs6f8hKfVdzAUrjp4blywts1kXU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1613:b0:659:858f:f1df with SMTP id
 006d021491bc7-65b44ff776dmr4579519eaf.0.1765795474961; Mon, 15 Dec 2025
 02:44:34 -0800 (PST)
Date: Mon, 15 Dec 2025 02:44:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693fe692.a70a0220.104cf0.033c.GAE@google.com>
Subject: [syzbot] [gfs2] KASAN: use-after-free Read in iomap_read_inline_data (2)
From: syzbot <syzbot+365d799c2cc252b698e4@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f0b4cce4481 Linux 6.19-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169acd92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=365d799c2cc252b698e4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8f0b4cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b037b4b8714/vmlinux-8f0b4cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31c24c278e15/bzImage-8f0b4cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+365d799c2cc252b698e4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
==================================================================
BUG: KASAN: use-after-free in folio_fill_tail include/linux/highmem.h:600 [inline]
BUG: KASAN: use-after-free in iomap_read_inline_data+0x6dd/0xbb0 fs/iomap/buffered-io.c:379
Read of size 159 at addr ffff88801e8298e8 by task syz.0.0/5336

CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 folio_fill_tail include/linux/highmem.h:600 [inline]
 iomap_read_inline_data+0x6dd/0xbb0 fs/iomap/buffered-io.c:379
 iomap_write_begin_inline fs/iomap/buffered-io.c:898 [inline]
 iomap_write_begin+0xcdd/0x1270 fs/iomap/buffered-io.c:975
 iomap_write_iter fs/iomap/buffered-io.c:1107 [inline]
 iomap_file_buffered_write+0x45f/0x9c0 fs/iomap/buffered-io.c:1188
 gfs2_file_buffered_write+0x4ed/0x880 fs/gfs2/file.c:1061
 gfs2_file_write_iter+0x94e/0x1100 fs/gfs2/file.c:1166
 iter_file_splice_write+0x972/0x10b0 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x5a8/0xcc0 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1230
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c8bf8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c8ce68038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9c8c1e5fa0 RCX: 00007f9c8bf8f7c9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000008
RBP: 00007f9c8c013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 000000007ffff000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9c8c1e6038 R14: 00007f9c8c1e5fa0 R15: 00007ffdb62719d8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x92c pfn:0x1e829
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea00007a2288 ffffea00007f1cc8 0000000000000000
raw: 000000000000092c 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_MOVABLE|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL), pid 5336, tgid 5335 (syz.0.0), ts 75696329519, free_ts 76469625595
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_frozen_pages_noprof mm/mempolicy.c:2557 [inline]
 alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2577
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2587
 filemap_alloc_folio_noprof+0x112/0x490 mm/filemap.c:1013
 __filemap_get_folio_mpol+0x3fc/0xb00 mm/filemap.c:2006
 __filemap_get_folio include/linux/pagemap.h:763 [inline]
 gfs2_getbuf+0x181/0x6d0 fs/gfs2/meta_io.c:144
 gfs2_meta_new+0x31/0x160 fs/gfs2/meta_io.c:196
 init_dinode+0x75/0xa70 fs/gfs2/inode.c:580
 gfs2_create_inode+0x10d6/0x15b0 fs/gfs2/inode.c:863
 gfs2_atomic_open+0x116/0x200 fs/gfs2/inode.c:1402
 atomic_open fs/namei.c:4295 [inline]
 lookup_open fs/namei.c:4406 [inline]
 open_last_lookups fs/namei.c:4540 [inline]
 path_openat+0x11f8/0x3dd0 fs/namei.c:4784
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
page last free pid 78 tgid 78 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 free_unref_folios+0xdb3/0x14f0 mm/page_alloc.c:3000
 shrink_folio_list+0x4800/0x5010 mm/vmscan.c:1603
 evict_folios+0x473e/0x57f0 mm/vmscan.c:4711
 try_to_shrink_lruvec+0x8a3/0xb50 mm/vmscan.c:4874
 shrink_one+0x25c/0x720 mm/vmscan.c:4919
 shrink_many mm/vmscan.c:4982 [inline]
 lru_gen_shrink_node mm/vmscan.c:5060 [inline]
 shrink_node+0x2f7d/0x35b0 mm/vmscan.c:6047
 kswapd_shrink_node mm/vmscan.c:6901 [inline]
 balance_pgdat mm/vmscan.c:7084 [inline]
 kswapd+0x145a/0x2820 mm/vmscan.c:7354
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Memory state around the buggy address:
 ffff88801e829780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88801e829800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88801e829880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                          ^
 ffff88801e829900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88801e829980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

