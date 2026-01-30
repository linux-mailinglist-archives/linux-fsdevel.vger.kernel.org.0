Return-Path: <linux-fsdevel+bounces-75928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAZsFW0+fGkxLgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:15:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB718B7412
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 109363011752
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 05:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386F329C6D;
	Fri, 30 Jan 2026 05:14:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242C33BBBD
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750077; cv=none; b=f6g+IgOqPi1uHqUgTQF+L2e97NfZBVk+qOXecDJtL8IzXKxsBB9PPGVg1PvMEBmj+i1ehFzLcvKgNRR3dYMU46hcZJWBYi08jeEy6ruUtBrGP52EqraXm5mhFi/XXT7SZXs9O3rDSN81LfSTfQAIaFr4tFhRjzfEIqjRF8U4iog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750077; c=relaxed/simple;
	bh=d7+T2RJO7nULQJuZtk2H2BMRMZ+2NKjSNlnNmZlE/EA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NhND8kUH6MXSqX92Uh7rxwQnIDVGlZWz/T3RoVZDAMZUnGmQfkzBz8PUfl/rUSELMc89QCk/Ue7HHj83A1sxu1pXts/ayMaRfEiiYiUQ+zW41msJ1Xt+eYe0dNEGK4ci1tAXe4n/rOVV0jLG+P9jp59nLoln94YoEVrgRsfgMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65f30d38617so3931129eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 21:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769750075; x=1770354875;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZBxNEkKoPRXPMzLcWsvsFY0BDmm7GFubz7Cg7pAEUM=;
        b=hYonExNYMRmU8zQUPRbm/nJMy9PsRq9J3x/7kzVYW58YlIt8kOFZn1o7K3LeBXHc8T
         qjtgOYGBFIzG3vgyZNlNQPk32mp7y21Vq2Rrs3otwEQw16hzTwhVD6IMVi8FNcj0kNQe
         i5iwYuP3rRZG8ifprf1stMtSQIys0b7w59lzaJKBJf7Dtlutyo8k6SasWkXJDj9i+O8A
         qe/7oJ4MJP/ydxnxQhp6K+LukTKNxIgQMOjqxfXVReJXtw+AWw1RGSPRBFUO+QtDdg21
         N70Rxpo4kkc/64qiyN7vzTxUZ23tLy3DtJ8ydEMO1aj2sBrLzpIte2Z8gx4tnb6k5+Fg
         AngQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUn+85DVWauMvZ7TEF2WwA+SUJli+uXSwOltUFHuOpnPzsh3rTtiH8OCkk5HlEgvHxlxwz1lNQOLlrzkYL@vger.kernel.org
X-Gm-Message-State: AOJu0YxA00+9FsCCRHXBsRookgA+R3qkVEJp+dXIGqpITNP/dkCUt1K5
	BapUnqf1yNa6tVOJTnX3IWyWNpuV+ZzQtddnOE/twJiOJEvDBDoZ9DiOcZ9r04bJqeVvF/FYaKN
	gRflmZi6jLWU3GCrrnwlCLbnHSlv2saJi9XZ0SPge4ir540mKki1WbuZgVhA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee0d:0:b0:662:c301:a278 with SMTP id
 006d021491bc7-6630f358020mr725707eaf.45.1769750074944; Thu, 29 Jan 2026
 21:14:34 -0800 (PST)
Date: Thu, 29 Jan 2026 21:14:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697c3e3a.a00a0220.35f26.000d.GAE@google.com>
Subject: [syzbot] [iomap?] KASAN: use-after-free Write in iomap_write_end
From: syzbot <syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com>
To: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4aae00ac5a9d2645];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75928-lists,linux-fsdevel=lfdr.de,ea1cd4aa4d1e98458a55];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,appspotmail.com:email]
X-Rspamd-Queue-Id: AB718B7412
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    4d310797262f Merge tag 'pm-6.19-rc8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e91bfa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aae00ac5a9d2645
dashboard link: https://syzkaller.appspot.com/bug?extid=ea1cd4aa4d1e98458a55
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4d310797.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0731328b5303/vmlinux-4d310797.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fbeb5d7bc402/bzImage-4d310797.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea1cd4aa4d1e98458a55@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
overlay: ./bus is not a directory
==================================================================
BUG: KASAN: use-after-free in iomap_write_end_inline fs/iomap/buffered-io.c:1032 [inline]
BUG: KASAN: use-after-free in iomap_write_end+0x390/0x720 fs/iomap/buffered-io.c:1050
Write of size 1 at addr ffff88800e1d5904 by task syz.0.0/5322

CPU: 0 UID: 0 PID: 5322 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 iomap_write_end_inline fs/iomap/buffered-io.c:1032 [inline]
 iomap_write_end+0x390/0x720 fs/iomap/buffered-io.c:1050
 iomap_write_iter fs/iomap/buffered-io.c:1123 [inline]
 iomap_file_buffered_write+0x52b/0xb30 fs/iomap/buffered-io.c:1189
 gfs2_file_buffered_write+0x4eb/0x870 fs/gfs2/file.c:1061
 gfs2_file_write_iter+0x976/0x1130 fs/gfs2/file.c:1166
 iter_file_splice_write+0x99b/0x1100 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x53a/0xc70 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x195/0x290 fs/splice.c:1230
 do_sendfile+0x535/0x7d0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x144/0x1a0 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f224299aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2243773028 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f2242c15fa0 RCX: 00007f224299aeb9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007f2242a08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 000000007ffff004 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2242c16038 R14: 00007f2242c15fa0 R15: 00007ffeffb7adf8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x92c pfn:0xe1d5
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0000387488 ffffea00008c1448 0000000000000000
raw: 000000000000092c 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_MOVABLE|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL), pid 5322, tgid 5321 (syz.0.0), ts 77159152107, free_ts 77205550804
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x228/0x280 mm/page_alloc.c:1884
 prep_new_page mm/page_alloc.c:1892 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3945
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5240
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 alloc_frozen_pages_noprof mm/mempolicy.c:2557 [inline]
 alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2577
 folio_alloc_noprof+0x1e/0x30 mm/mempolicy.c:2587
 filemap_alloc_folio_noprof+0x111/0x470 mm/filemap.c:1013
 __filemap_get_folio_mpol+0x3fc/0xb00 mm/filemap.c:2006
 __filemap_get_folio include/linux/pagemap.h:774 [inline]
 gfs2_getbuf+0x186/0x6d0 fs/gfs2/meta_io.c:144
 gfs2_meta_read+0x109/0x8d0 fs/gfs2/meta_io.c:271
 gfs2_meta_buffer+0x10f/0x2e0 fs/gfs2/meta_io.c:495
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:70 [inline]
 __gfs2_iomap_get+0x193/0x1840 fs/gfs2/bmap.c:861
 gfs2_iomap_begin+0x219/0x11e0 fs/gfs2/bmap.c:1109
 iomap_iter+0x600/0xf30 fs/iomap/iter.c:110
 __iomap_dio_rw+0xcc4/0x1e10 fs/iomap/direct-io.c:752
 iomap_dio_rw+0x45/0xb0 fs/iomap/direct-io.c:847
page last free pid 74 tgid 74 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1433 [inline]
 free_unref_folios+0xdce/0x1510 mm/page_alloc.c:3030
 shrink_folio_list+0x4930/0x5160 mm/vmscan.c:1603
 evict_folios+0x4795/0x5880 mm/vmscan.c:4711
 try_to_shrink_lruvec+0x88b/0xb20 mm/vmscan.c:4874
 shrink_one+0x25c/0x710 mm/vmscan.c:4919
 shrink_many mm/vmscan.c:4982 [inline]
 lru_gen_shrink_node mm/vmscan.c:5060 [inline]
 shrink_node+0x2f8b/0x35f0 mm/vmscan.c:6047
 kswapd_shrink_node mm/vmscan.c:6901 [inline]
 balance_pgdat mm/vmscan.c:7084 [inline]
 kswapd+0x144c/0x2800 mm/vmscan.c:7354
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Memory state around the buggy address:
 ffff88800e1d5800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88800e1d5880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88800e1d5900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88800e1d5980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88800e1d5a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

