Return-Path: <linux-fsdevel+bounces-56120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E33B1362A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 10:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D2A3B8E38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDD230D0D;
	Mon, 28 Jul 2025 08:17:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002D2288EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690654; cv=none; b=gd/uYT3UxCxdmEKaXtx4PtjNQRJbRbwHywlr4sEIvMG5p3Go1w8kcSu27mLP+mrUBd1YjM57p9fh11Sdt6RLSRWHYbHENgoZSsyEkY/0q6xvR4dDdID7jJqe7kOla+xk3FdM3gvWwCEkcUj96ElZOPGZ8VQzrb3xQMhr7liUEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690654; c=relaxed/simple;
	bh=pgP4SXgreuJwhQOo9oaITtVbd6yuZfPazJKt5RS1v+g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YbmWkzkV6/TZStAbBIjys+yRUPhC5A2oa5kx9b85/E1BZNlLPhuQ56kotGtLbbv680Quw/SjEFtFSkcBa0Wf8ntYJOwEFYc4Cqgr0v826VII1R3DUqAnyMQFlrFhy9jKDQjjCNh9QA8TegIsJd406o8/nt+g4ErjfsncdR92XXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86463467dddso458453439f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 01:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753690652; x=1754295452;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Di28IITQYUNeX9DGoYvQzMQDoIrq4xMQOoFcmX5YyQ=;
        b=CoVqQ8VjtzV+OSXNcA/H6nWk0uc6e9so+KCZRyc0UaPAzyQc3NEXSj5lnS6kExZaTD
         VO3FPEc7rsnCgLW6YOLsg3F1TluPe6q6/SFgCcLMHKUAMiTLXtr6uVoTr+mOB00xuhSt
         XA58oTxksCIhjnH2A07rf2V40KsEhhl3lFEOmlUmRbjqaCxZGQlvj9vtHtaVLFb9o6f0
         kas8dHYdC0sgvSmm2SlcX15CPYhhqoQrFUqkndR5v+gmx+l6wS+WRAad9HE6oNc7J6Nu
         p9QHkPsZHuwlZM5gHH/RLhRdTka5+zeJjB1lT6w3IrKtWY0aHhiIWXEx1awROEJQVqdu
         m5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXmpf/GknLfj5kmV9J9kD+RzXquHPMBUhCsLJRw3v719vjxwvdjjCvaxa21QTXBJKB2aVYE0mDpxkndCNZL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9msZlutCtrRLlpC+J2AFDCXXD4YF2lkS6Wf82J9Vl2FpQFeD5
	Bkg7Nox0ds9Ppb683eSZViVgKNej9HYWp8HhSR6ZOczm/xK2YQ/q8CtyLiquN2mNiaAa+dNMF5A
	X/ZxN0Qcn3UQt2JFXXPMsX0BuUATkJvHjmdwF+M6ZhPHKJpNmrkqVrZL7ju8=
X-Google-Smtp-Source: AGHT+IFTAiSvpBcwD6vor4JSikJ2yt9T6mKhrc0ImuMZDGgx8PTw2YkmzwrUD8n8fNS7IULtjq4ak9jgHyBj8wqY/9GmaUWhB1lB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1685:b0:86d:d6:5687 with SMTP id
 ca18e2360f4ac-8800f1039camr2035220539f.6.1753690651654; Mon, 28 Jul 2025
 01:17:31 -0700 (PDT)
Date: Mon, 28 Jul 2025 01:17:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6887321b.a00a0220.b12ec.0096.GAE@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in fat32_ent_get / fat32_ent_put
From: syzbot <syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ec2df4364666 Merge tag 'spi-fix-v6.16-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1567c782580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0dd0a92e88efc24
dashboard link: https://syzkaller.appspot.com/bug?extid=d3c29ed63db6ddf8406e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/29b468ddeacc/disk-ec2df436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/996435d5d9de/vmlinux-ec2df436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/170fc9879e1c/bzImage-ec2df436.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fat32_ent_get / fat32_ent_put

read-write to 0xffff88810b7b319c of 4 bytes by task 7231 on cpu 0:
 fat32_ent_put+0x4e/0x90 fs/fat/fatent.c:191
 fat_ent_write+0x6c/0xe0 fs/fat/fatent.c:417
 fat_chain_add+0x15b/0x3f0 fs/fat/misc.c:136
 fat_add_cluster fs/fat/inode.c:112 [inline]
 __fat_get_block fs/fat/inode.c:154 [inline]
 fat_get_block+0x46c/0x5e0 fs/fat/inode.c:189
 __block_write_begin_int+0x400/0xf90 fs/buffer.c:2151
 block_write_begin fs/buffer.c:2262 [inline]
 cont_write_begin+0x5fc/0x970 fs/buffer.c:2601
 fat_write_begin+0x4f/0xe0 fs/fat/inode.c:228
 generic_perform_write+0x184/0x490 mm/filemap.c:4112
 __generic_file_write_iter+0xec/0x120 mm/filemap.c:4226
 generic_file_write_iter+0x8d/0x2f0 mm/filemap.c:4255
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x4a0/0x8e0 fs/read_write.c:686
 ksys_write+0xda/0x1a0 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x40/0x50 fs/read_write.c:746
 x64_sys_call+0x2cdd/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88810b7b319c of 4 bytes by task 7250 on cpu 1:
 fat32_ent_get+0x24/0x80 fs/fat/fatent.c:149
 fat_count_free_clusters+0x50e/0x760 fs/fat/fatent.c:741
 fat_statfs+0xc0/0x200 fs/fat/inode.c:834
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0xc8/0x1c0 fs/statfs.c:90
 user_statfs+0x71/0x110 fs/statfs.c:105
 __do_sys_statfs fs/statfs.c:193 [inline]
 __se_sys_statfs fs/statfs.c:190 [inline]
 __x64_sys_statfs+0x65/0xf0 fs/statfs.c:190
 x64_sys_call+0x1edd/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:138
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0fffffff -> 0x00000068

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 7250 Comm: syz.4.1276 Not tainted 6.16.0-rc7-syzkaller-00140-gec2df4364666 #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
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

