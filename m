Return-Path: <linux-fsdevel+bounces-45422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E78A777E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA83A4275
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829F1EF0A6;
	Tue,  1 Apr 2025 09:40:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F121C38B
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500426; cv=none; b=C6v+wRw9+9/R/OMnKEbMg/UEAjOlFQrx6FBlVTqcRd5fveNq6O2tPx5QrVwJwSToyNLIskS56fk2p6qba29asngooopaO7456Z5Jwl2hE4kYJF5SgXG71f2eoeS0Wth3BrYS80AIppWhKVD3BFufbuWSa8gDocCSczBXxE81V1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500426; c=relaxed/simple;
	bh=bMvAYJXBmlVd+nxrsL+KEButwoB/DnD4Wb9PLyyDajw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZVAtdhuENwPbvrJQly9lBB+YnssvwcSkJOrf7Qk3B7Dn85Z/LO43kaNcnmfwN3voWkjXwmpnm9+QwO6FrV09ZYCK5nZE4hKmsuNPab2p1YrTBeXlxHR3l/EMz+OSDFcdCR1JurKT7N1KaAQJbbrnJqnx6pH1NLngOacvOLl3oEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d458e61faaso53403405ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 02:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743500424; x=1744105224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T99KLhRaT/zg5krqq6egVQGPY8M5vnskt1JQriQgYiU=;
        b=RCHlJdFgzO417h7l3twO/ZpIRFfBnN57/de3WVckfEg2NsBkTj9mrsi42/p4Kc7fC9
         ++nj34giq7fCBJPERjTStvYyDPcJbGbPWlEPt83iLaVB/0inTud9FxeHeumeDV/7xhsk
         9IUQJSegrK9BKGQnFLdAZHCXx8Wvs+9N84wY4OIGR+wbJxf216cZlrOhgJJyYeauD+Vq
         SbAWRfdtRcw9s+AaFdpEARZTPyfgD5cOJhtqTiaP7kBUTzFMzMKQlFHrVh1mJw7/cDp4
         azelIjR3IfHpgStXRFo5zgedZ+INCr+Aeqea7ONcsusEb+lnlvTEIHeDTjSBlUce5n0B
         U7uw==
X-Forwarded-Encrypted: i=1; AJvYcCXXKNR8Iuv7QDt9oxO1Kjcr88ftTu3OBx+kXI9A1y2Ia0DwVm+IWauUrtZ1z3JRXMwft3EIHvMiw9DZMSwB@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6JXXzrIyMtOOUhqBh7AFb104mRQTNPpQtKOlAamRXKXLFzrA
	SraugRL0EoSWIf+kEGzCo94dezGaaWmU3IiwPaBLjIKHYQftO2B38d+/ck8sfOxcd1opY1DH1nD
	YfXHlMKOzoXcsfChj57l9cGTTcmzKB4Q/aFKSe0hk7jwhUXaXu1tZPMA=
X-Google-Smtp-Source: AGHT+IE2OVwt/Fi/HdMaxn9+dAXwdx2XZ6OX3zUiWvhr4o2huMhlCYQJ24LyTxTZ4x9N79CdkPXEiu2RZmWoBAwlYHvfeIggBhfN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:6812:0:b0:3d1:84ad:165e with SMTP id
 e9e14a558f8ab-3d5d6cfd612mr117415665ab.7.1743500424049; Tue, 01 Apr 2025
 02:40:24 -0700 (PDT)
Date: Tue, 01 Apr 2025 02:40:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ebb488.050a0220.297a31.000a.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in mem_cgroup_track_foreign_dirty_slowpath
 / mem_cgroup_track_foreign_dirty_slowpath (7)
From: syzbot <syzbot+6f43371b62882ee50909@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1e7857b28020 x86: don't re-generate cpufeaturemasks.h so e..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12bb8268580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bdb65086dcaf0454
dashboard link: https://syzkaller.appspot.com/bug?extid=6f43371b62882ee50909
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08333bdf2b6c/disk-1e7857b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c798f117761a/vmlinux-1e7857b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2171375da2b/bzImage-1e7857b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f43371b62882ee50909@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in mem_cgroup_track_foreign_dirty_slowpath / mem_cgroup_track_foreign_dirty_slowpath

write to 0xffff8881184b45d8 of 8 bytes by task 15048 on cpu 0:
 mem_cgroup_track_foreign_dirty_slowpath+0x3bf/0x450 mm/memcontrol.c:-1
 mem_cgroup_track_foreign_dirty include/linux/memcontrol.h:1586 [inline]
 folio_account_dirtied mm/page-writeback.c:2756 [inline]
 __folio_mark_dirty+0x3f5/0x4e0 mm/page-writeback.c:2797
 mark_buffer_dirty+0x134/0x230 fs/buffer.c:1196
 __block_commit_write fs/buffer.c:2189 [inline]
 block_page_mkwrite+0x29b/0x3f0 fs/buffer.c:2621
 ext4_page_mkwrite+0x75c/0xba0 fs/ext4/inode.c:6225
 do_page_mkwrite mm/memory.c:3253 [inline]
 wp_page_shared mm/memory.c:3654 [inline]
 do_wp_page+0xcaf/0x2380 mm/memory.c:3804
 handle_pte_fault mm/memory.c:5906 [inline]
 __handle_mm_fault mm/memory.c:6033 [inline]
 handle_mm_fault+0xc78/0x2b30 mm/memory.c:6202
 do_user_addr_fault arch/x86/mm/fault.c:1337 [inline]
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x3b9/0x650 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

read to 0xffff8881184b45d8 of 8 bytes by task 15063 on cpu 1:
 mem_cgroup_track_foreign_dirty_slowpath+0xdb/0x450 mm/memcontrol.c:3291
 mem_cgroup_track_foreign_dirty include/linux/memcontrol.h:1586 [inline]
 folio_account_dirtied mm/page-writeback.c:2756 [inline]
 __folio_mark_dirty+0x3f5/0x4e0 mm/page-writeback.c:2797
 mark_buffer_dirty+0x134/0x230 fs/buffer.c:1196
 __block_commit_write fs/buffer.c:2189 [inline]
 block_write_end+0x123/0x210 fs/buffer.c:2265
 ext4_da_do_write_end fs/ext4/inode.c:3015 [inline]
 ext4_da_write_end+0x20a/0x810 fs/ext4/inode.c:3090
 generic_perform_write+0x31e/0x4b0 mm/filemap.c:4135
 ext4_buffered_write_iter+0x1ed/0x3c0 fs/ext4/file.c:299
 ext4_file_write_iter+0x3b2/0xf80 include/linux/fs.h:-1
 iter_file_splice_write+0x5f2/0x980 fs/splice.c:738
 do_splice_from fs/splice.c:935 [inline]
 direct_splice_actor+0x160/0x2c0 fs/splice.c:1158
 splice_direct_to_actor+0x305/0x680 fs/splice.c:1102
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0xd9/0x150 fs/splice.c:1227
 do_sendfile+0x40a/0x690 fs/read_write.c:1368
 __do_sys_sendfile64 fs/read_write.c:1429 [inline]
 __se_sys_sendfile64 fs/read_write.c:1415 [inline]
 __x64_sys_sendfile64+0x113/0x160 fs/read_write.c:1415
 x64_sys_call+0xfc3/0x2e10 arch/x86/include/generated/asm/syscalls_64.h:41
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000ffffebe1 -> 0x00000000ffffef33

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 15063 Comm: syz.2.3982 Not tainted 6.14.0-syzkaller-11144-g1e7857b28020 #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
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

