Return-Path: <linux-fsdevel+bounces-11004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A418C84FC4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E16285603
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C268288F;
	Fri,  9 Feb 2024 18:51:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B62580BF8
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504692; cv=none; b=tJVdy1Oz+/Rbi26gfhlJtEic3Bwh0SrwkcftqsWX82olTthK2VsjInDcGldA5f3KuvhF3ddwBYAufsNL4ObfPkEWuOLqx/aBpO8QetnZhPmcVjqx+z9tK5Cspr6UqKP4CDd1E/QQ+laaoSeHOAXmPNAfWPB1bedOJr6r170i1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504692; c=relaxed/simple;
	bh=Tu0ElYYCxwfDUVwALkCxB1vEswdt7vcITJbQk2Tz/t4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T+IUJDd+6rMsaxrVz7lGclP65dqWelFRnJ7T/fORtOvby+GNB37S9jlM7jzkIyjVGe90kqkTqlzTMiHM9vSguYBWSdMSLdugaShfj/PPmSxD08Ze6tlBu6/hhsCZhnsJyN6widvlG7m0weJEH+mD6pHRIpCy5WToIDMdWGr/Z4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36387e7abccso8593475ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 10:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504689; x=1708109489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaQFh3BM5KkXzHuxJBu4/3J2wMPDItc2ahT0DVe0s04=;
        b=MBTRoBJ4CIDg3qYhOtYQMHqExJUewNWTaBkk0Anz4t9CijoBHDaxsjJiNwCM+/D1+O
         SBrfhGwcSCyEq2ucV34MjHwHY1CWWNZUcooEzYH79mn4bSfMmuGtde+D+yvjCmXnRVfT
         QxdjHg/RwccMGwtxXmrKlr1aeg61ycrAtPxIgdkP1zdGM7XaVglAOaomheUvM9pivz/f
         gzqYoNeWAIqDWip0b0E3bDe9/06sYpgEPyMVIM0rz1s08oclgNfoTTPa4xvYXKsY3AZj
         k3r9iTtJHnDjZb8TkwfQTQbrti9HjoZ9fUe5UJ9pEAJgXgjpyNx6rPtESgI1MaUQp3tT
         9B+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvgrF5ymJnJaUVThSguhO0JbLSEA72W0eY6JKglW2C2nDB9MADrRgpNnEfa6u2fVuqoqgeXIP+oF45eP+2+AUIu47N+yl+IJuBt7Vscg==
X-Gm-Message-State: AOJu0Yzo8/tZu57EKqevaieThK1gYZ5m4g9LokQVlFn2zT9sLhpAhixH
	EC8M1MLZ+aON7IxAuppcmsmKW4/ROW5fuA8KaDx/pnTr/HDRzDZmy/fh+VBJLAYKeZJvduJKdUm
	UlsIjhqzQ9UCSQjCUZIDaQOSM8n2ZA2UmE5oC8rLZqlhsd3yfyiYo5CE=
X-Google-Smtp-Source: AGHT+IGQGyisrSeC7tNSvzRN8yfk04MLfykEDeKBoW2cZ9dfUj1lfobhy0PRtZq5TRm6hPpmtKJ13GAe+CmXgYP01idUM801xuT0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:363:b5f6:7379 with SMTP id
 i2-20020a056e021d0200b00363b5f67379mr886ila.4.1707504689525; Fri, 09 Feb 2024
 10:51:29 -0800 (PST)
Date: Fri, 09 Feb 2024 10:51:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078bc8c0610f76abc@google.com>
Subject: [syzbot] [fs?] WARNING in pagemap_scan_pmd_entry (2)
From: syzbot <syzbot+0748a3a1931714d970d0@syzkaller.appspotmail.com>
To: Liam.Howlett@Oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	hughd@google.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ryan.roberts@arm.com, syzkaller-bugs@googlegroups.com, 
	usama.anjum@collabora.com, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    547ab8fc4cb0 Merge tag 'loongarch-fixes-6.8-2' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=146d3360180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d64aaed894826fe
dashboard link: https://syzkaller.appspot.com/bug?extid=0748a3a1931714d970d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107153c4180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b1c918180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/baf9b6ea7fce/disk-547ab8fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4387f7514b49/vmlinux-547ab8fc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26bbd5d6cf3a/bzImage-547ab8fc.xz

The issue was bisected to:

commit 12f6b01a0bcbeeab8cc9305673314adb3adf80f7
Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date:   Mon Aug 21 14:15:15 2023 +0000

    fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126a175c180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=116a175c180000
console output: https://syzkaller.appspot.com/x/log.txt?x=166a175c180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0748a3a1931714d970d0@syzkaller.appspotmail.com
Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5069 at arch/x86/include/asm/pgtable.h:404 pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
WARNING: CPU: 1 PID: 5069 at arch/x86/include/asm/pgtable.h:404 pagemap_scan_pmd_entry+0xa15/0x2e10 fs/proc/task_mmu.c:2195
Modules linked in:
CPU: 1 PID: 5069 Comm: syz-executor103 Not tainted 6.8.0-rc3-syzkaller-00041-g547ab8fc4cb0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:404 [inline]
RIP: 0010:pagemap_scan_pmd_entry+0xa15/0x2e10 fs/proc/task_mmu.c:2195
Code: 2d 67 ff 83 e3 42 bf 40 00 00 00 48 89 de e8 b2 32 67 ff 48 83 fb 40 0f 85 6d fe ff ff e8 c3 2d 67 ff eb 05 e8 bc 2d 67 ff 90 <0f> 0b 90 e9 5d fe ff ff e8 ae 2d 67 ff 31 c0 48 89 44 24 20 4d 89
RSP: 0018:ffffc9000395f5c0 EFLAGS: 00010293
RAX: ffffffff822c3974 RBX: 07ffffffffff040a RCX: ffff888023abbb80
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000395f830 R08: ffffffff822c393b R09: fffff5200072be88
R10: dffffc0000000000 R11: fffff5200072be88 R12: dffffc0000000000
R13: 000000002007d000 R14: ffffc9000395f740 R15: ffff888023eef3e0
FS:  000055555572c380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200007c8 CR3: 0000000075868000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0xba1/0x17e0 mm/pagewalk.c:293
 __walk_page_range+0x132/0x720 mm/pagewalk.c:395
 walk_page_range+0x4c8/0x6c0 mm/pagewalk.c:521
 do_pagemap_scan fs/proc/task_mmu.c:2471 [inline]
 do_pagemap_cmd+0xb11/0x1340 fs/proc/task_mmu.c:2513
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f948bf61b69
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffdc7d4d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffffdc7d510 RCX: 00007f948bf61b69
RDX: 00000000200007c0 RSI: 00000000c0606610 RDI: 0000000000000004
RBP: 00007ffffdc7d510 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffffdc7d4f0 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

