Return-Path: <linux-fsdevel+bounces-7645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5F828C62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0371C2524A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A03C473;
	Tue,  9 Jan 2024 18:19:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77D3C07B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bc32b0bf5bso269021839f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 10:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824370; x=1705429170;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vhuhc2iT/iPcf+8+Jy5P0A6KcjOLWBP6XP022tsLIFk=;
        b=C6vPAHnHRUabpEItoPGzq24fGNqV2Yu8ovr6a7Aqv6hqrFKuG8GswqfB/GEPpeuADl
         gxjbS21GDu48K3wStSQ9DGDz8rmBLuxS/QSubTXSiEU9Cm46HtN5nCM4ISIJJdKbdkh/
         4aZKnCSXKNo+5PmnMHErEGMBQu55pArL/vwBDmkWYsb44OdyYww5wa+s4xdB860AY5L+
         o3kYxVXCKsKuuH9F3sBpA1z8eVb46tHTJshLhifwoglyRGhumKI8Xo5LEWT8+74iNK84
         ZZvB4Gyh7vzKQyJRVTpyW7lelVB+kZy6YTr2uJzmfPtNoIU9nSD2GUOsbrs5KzEkN4oj
         OnVQ==
X-Gm-Message-State: AOJu0Yx4SmS0jlNVGLk4f2uTnhFUW3xSid+eO3nIRJHIH2IYBqxcEnP1
	MFvhWLLlDW2SkuaUetWyFy0Qs/7rPEGj6tG05m7pS99ZHsGn
X-Google-Smtp-Source: AGHT+IGLMVqLYrxtaqQcqCprJfPH8l104K6tscXNgKh+wH5OR8pg6vEW3OJxCoosW8moLrHGH7HtpSUsVf+/sCemzDYMBTv6CNdn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b16:b0:46c:ff73:a8c4 with SMTP id
 fm22-20020a0566382b1600b0046cff73a8c4mr269871jab.4.1704824368986; Tue, 09 Jan
 2024 10:19:28 -0800 (PST)
Date: Tue, 09 Jan 2024 10:19:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb00d6060e875ad7@google.com>
Subject: [syzbot] [ntfs?] KASAN: use-after-free Write in ntfs_perform_write
From: syzbot <syzbot+f583da5774d7dd400312@syzkaller.appspotmail.com>
To: anton@tuxera.com, linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aafe7ad77b91 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=154cf661e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23ce86eb3d78ef4d
dashboard link: https://syzkaller.appspot.com/bug?extid=f583da5774d7dd400312
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149ca405e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12172d89e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23845238c49b/disk-aafe7ad7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1144b0f74104/vmlinux-aafe7ad7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6db20df213a2/Image-aafe7ad7.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/475f587fffbd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f583da5774d7dd400312@syzkaller.appspotmail.com

ntfs: (device loop0): parse_options(): Option utf8 is no longer supported, using option nls=utf8. Please use option nls=utf8 in the future and make sure utf8 is compiled either as a module or into the kernel.
ntfs: volume version 3.1.
==================================================================
BUG: KASAN: use-after-free in ntfs_commit_pages_after_write fs/ntfs/file.c:1597 [inline]
BUG: KASAN: use-after-free in ntfs_perform_write+0x5354/0x82c8 fs/ntfs/file.c:1853
Write of size 1 at addr ffff0000de9b6170 by task syz-executor306/6098

CPU: 0 PID: 6098 Comm: syz-executor306 Not tainted 6.7.0-rc6-syzkaller-gaafe7ad77b91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 kasan_check_range+0x254/0x294 mm/kasan/generic.c:187
 __asan_memcpy+0x54/0x84 mm/kasan/shadow.c:106
 ntfs_commit_pages_after_write fs/ntfs/file.c:1597 [inline]
 ntfs_perform_write+0x5354/0x82c8 fs/ntfs/file.c:1853
 ntfs_file_write_iter+0xf3c/0x1738 fs/ntfs/file.c:1909
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x610/0x910 fs/read_write.c:584
 ksys_write+0x15c/0x26c fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:646
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

The buggy address belongs to the physical page:
page:000000003d2e8ed5 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x11e9b6
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000000 fffffc00037a6dc8 fffffc00037a6d48 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000de9b6000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000de9b6080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff0000de9b6100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                             ^
 ffff0000de9b6180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000de9b6200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

