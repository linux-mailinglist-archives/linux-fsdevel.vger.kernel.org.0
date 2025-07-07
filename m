Return-Path: <linux-fsdevel+bounces-54085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E6AFB1E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB703B0E8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B132566DF;
	Mon,  7 Jul 2025 11:02:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09527453
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886155; cv=none; b=bgXhdqYvYU/X3FPaxrlMMalMB1ShCcZf9x0aC3IiQjVsVObM0muNp/EV0yNs2+7zlF7A6KoOZdaPXkuTk460WbyJXXZy/Y4aK+cbAibgT2Jp9hN7s0AFluIR+/DZJXry6N63mpC2LgdwXjq9lXAcaJlLMcgNF/LQU03IBByPOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886155; c=relaxed/simple;
	bh=8Ii0Jsu/3WB5HeTUfMGI7aKY6Fo6vjrGoI+l3hmCV2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KUAnx+WygahgCRvzr+7K35YV+5pMzzvL8zUYqAWSF1xrUUpd3xa5GGrH/IbyCYNmN0NzVzVBqSSFdnCTtYnMKKU9h9Bwfe2tE279OezzzVgqeDtbzC4Cj1uENTQHJ3CjYz/o9seU3SGQI4954mTaU+R88SyE8hsyfUh7yKm9BhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddcfea00afso47868755ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 04:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751886153; x=1752490953;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoO4p3o3Z4edfCGbyaeuxegF703mrzNk7A5ybw22csE=;
        b=U65p/LGa14m2gTLhyAll82gdd0Y0bCnIKNdD03JQBGFUTsWx8nvZ3tcqK7Qe3LmOhC
         8QwoP79kLu70keeQ72ryJMfm4JbC0v6u2JqOg7bdG3vbnT/mzQ4D62rZe7m609+bGh2D
         +eEvh/oI8azglkM80W9PiZZ+0G3pSHwiobCFjJcSex4E+xZ/BjIHHBoB15a2jxsma0Jq
         XOemaR46PEO0qQhfQyF6fxSU9v7RdqLCWQ/8yRAqvc7uWsv6DFfkJDQPvk4XOapatPaZ
         2Z9ROZrfuiJkiHoqobij8KSbA9FHYhBszyNLQ/KErjaGFQRVV0LskNXsE8eVudpuwj/2
         JecQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPSdgUupG7ZRxEkCwQf1qKX3hv9PI83xwQgXg3aFN/3GeAu2gChdoGpvCLdU/9U8/gKL9wR4rYWey/XPcv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ZAssm2BhhmaPn8oJAJafqR7qrrYVvQWGSn3DNKIRoyKT9aXz
	yAkrhUS6iIS14u4R0KcnFFVI9aDr2/wBPf+9ZriQjj4ue3gKYfbj0JarDOV+7N+L3QoLhA5XdIP
	YkzbjjQtV9ZLAzljcsUrCd7Z7Db+gFtYzjv4nfYv+oc+S0d6OoLYSOleEHHI=
X-Google-Smtp-Source: AGHT+IHa1fNMrSF8on5m8kh4qD1nJ4gwYlamzj3MyZiKLaKlENDFo7wQaWbYExFLEF03QVkikDcNmonnG6fV4FSRT9AWByon68Iz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:3df:3d4c:be27 with SMTP id
 e9e14a558f8ab-3e136ee41admr94651665ab.5.1751886152803; Mon, 07 Jul 2025
 04:02:32 -0700 (PDT)
Date: Mon, 07 Jul 2025 04:02:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686ba948.a00a0220.c7b3.0080.GAE@google.com>
Subject: [syzbot] [mm?] [fs?] WARNING in path_noexec
From: syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d6c58332c7a Add linux-next specific files for 20250703
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15788582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7dc16394230c170
dashboard link: https://syzkaller.appspot.com/bug?extid=3de83a9efcca3f0412ee
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ecb3d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153af770580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ff731adf5dfa/disk-8d6c5833.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5c7a3c57e0a1/vmlinux-8d6c5833.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f90e7c18574/bzImage-8d6c5833.xz

The issue was bisected to:

commit df43ee1b368c791b7042504d2aa90893569b9034
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Jul 2 09:23:55 2025 +0000

    anon_inode: rework assertions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b373d4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b373d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b373d4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com
Fixes: df43ee1b368c ("anon_inode: rework assertions")

------------[ cut here ]------------
WARNING: fs/exec.c:119 at path_noexec+0x1af/0x200 fs/exec.c:118, CPU#1: syz-executor260/5835
Modules linked in:
CPU: 1 UID: 0 PID: 5835 Comm: syz-executor260 Not tainted 6.16.0-rc4-next-20250703-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:path_noexec+0x1af/0x200 fs/exec.c:118
Code: 02 31 ff 48 89 de e8 f0 b1 89 ff d1 eb eb 07 e8 07 ad 89 ff b3 01 89 d8 5b 41 5e 41 5f 5d c3 cc cc cc cc cc e8 f2 ac 89 ff 90 <0f> 0b 90 e9 48 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c a6
RSP: 0018:ffffc90003eefbd8 EFLAGS: 00010293
RAX: ffffffff8235f22e RBX: ffff888072be0940 RCX: ffff88807763bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000080000 R08: ffff88807763bc00 R09: 0000000000000003
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000011
R13: 1ffff920007ddf90 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055556832d380(0000) GS:ffff888125d1e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f21e34810d0 CR3: 00000000718a8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 do_mmap+0xa43/0x10d0 mm/mmap.c:472
 vm_mmap_pgoff+0x31b/0x4c0 mm/util.c:579
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f21e340a9f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd23ca3468 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f21e340a9f9
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000200000ff9000
RBP: 00007f21e347d5f0 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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

