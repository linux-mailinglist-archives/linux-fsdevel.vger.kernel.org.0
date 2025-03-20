Return-Path: <linux-fsdevel+bounces-44503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE25A69ED3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 04:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437918A1F3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDEA207A03;
	Thu, 20 Mar 2025 03:28:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F81EB1BA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441309; cv=none; b=pjDCEdP/EAKDf7+L37cExL4Kinx3MWtRNbLWyuco5zdapHtzAVHf5O3atnafTBsqKjZ0cH+22IGeY0CwlxDcHi7KhvzJh3RBWSw84RpTj+ORxu+izILzfXuwIkt+RxXxNsu6TIYtKtRD3LSF8CkaKnSC2Ult+YwtNDmwYKQBB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441309; c=relaxed/simple;
	bh=JLOL9AJQ2cnSXdz2CMf8N5vWGfKJ6GmWRVN03fA85Hk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wa2ta0/G41VT/VdXy6OUKQfgTMaXbNfaczp4gAQ4N6H6ojbvUoghqqW5DKo0KswJxi2YQ1AqwKT15VqGNhl99TjPBsLYzT2rqZP0kA+IjwaclbSErB9s92uj+PsptxHimezPb+m5c79kPXQ6H8EeJH/a4QyxE3NRD/WBOKDS/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d054d79dacso7082635ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 20:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742441307; x=1743046107;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hecAEkEpOupHb2oLD0Zh2B0utuBtVCK9YGIDBVlwllE=;
        b=d4K4vJO+mBZxPTH4jELu4/+cPM+w1Mq9cbDHTWXVIGo9h84x57oLvsKR1F/sqxm5zy
         zCjw3IHrqfldqAj8lyMC5yUCv5f6tOIgUrn8CWfBedlV9n/qHn/Kc7hFJ4m/y1kbaXNA
         1QknEtNyNBGSiYQxIpd8GjZSbS/IYSudRy17oAaNJCqAcBE+obF3gjlFUslR3dOF3ZRK
         c24uD3+pt7RKn/5+Hpp3vJzaiSnjYr8zKSGOWvaQL2x/LHr+2PcKKbmmZDagc0BBHBvT
         JjaZXLsXmqWWdMBX+7g5/9KypUl1VWuQYpXoX/BaK4WzMV8jE6MPnAzaMrAnC6A8f1vR
         /7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8UHNZiIt7U5oXAI0O0jzfvpzwuiMMIdfBTcNxPNGeYLNsyhCxePaAHH1kxWIih5bmSd06XQt3/WWULAe@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0J4VrYkKfgelu7KfqWadF7cHYmRfAgFHr5xLYhZ7ddk4Lc0C
	eN7lVMT9tUJcglS6bakANJsxEVbiNrAuOF4op/PIy+QWfbD30lXZ3CUpVilmfoRe69uM6ndUrJY
	KXK9jC5nP/1OUhepGshBK3ziKy1hYkqJPBlVN8vrOaoY+PFwTnSZes0Y=
X-Google-Smtp-Source: AGHT+IH2FH63ihr7KH8PHX4OwIbTm0+zipnw7sTZ8BDsGMrxsR8sA4b5DdQfTomhyQTgDAln6rbz9JOtu9oWrogpobyrchcjdtaD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d586b40c24mr59334145ab.7.1742441307205; Wed, 19 Mar 2025
 20:28:27 -0700 (PDT)
Date: Wed, 19 Mar 2025 20:28:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67db8b5b.050a0220.31a16b.0001.GAE@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in __lookup_mnt / __se_sys_pivot_root (6)
From: syzbot <syzbot+de8b27abd23eac60e15f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a7f2e10ecd8f Merge tag 'hwmon-fixes-for-v6.14-rc8/6.14' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166a383f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f33d372c4021745
dashboard link: https://syzkaller.appspot.com/bug?extid=de8b27abd23eac60e15f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/614aabc71b48/disk-a7f2e10e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d47dd90a010a/vmlinux-a7f2e10e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/418d8cf8782b/bzImage-a7f2e10e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de8b27abd23eac60e15f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __lookup_mnt / __se_sys_pivot_root

write to 0xffff888118782d98 of 8 bytes by task 20163 on cpu 0:
 unhash_mnt fs/namespace.c:1030 [inline]
 __do_sys_pivot_root fs/namespace.c:4456 [inline]
 __se_sys_pivot_root+0x850/0x1090 fs/namespace.c:4388
 __x64_sys_pivot_root+0x31/0x40 fs/namespace.c:4388
 x64_sys_call+0x1abf/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:156
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888118782d98 of 8 bytes by task 20164 on cpu 1:
 __lookup_mnt+0xa0/0xf0 fs/namespace.c:839
 __follow_mount_rcu fs/namei.c:1592 [inline]
 handle_mounts fs/namei.c:1622 [inline]
 step_into+0x426/0x820 fs/namei.c:1952
 walk_component fs/namei.c:2120 [inline]
 link_path_walk+0x50e/0x830 fs/namei.c:2479
 path_lookupat+0x72/0x2b0 fs/namei.c:2635
 filename_lookup+0x150/0x340 fs/namei.c:2665
 user_path_at+0x3c/0x120 fs/namei.c:3072
 __do_sys_pivot_root fs/namespace.c:4404 [inline]
 __se_sys_pivot_root+0x10e/0x1090 fs/namespace.c:4388
 __x64_sys_pivot_root+0x31/0x40 fs/namespace.c:4388
 x64_sys_call+0x1abf/0x2dc0 arch/x86/include/generated/asm/syscalls_64.h:156
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888106a31d80 -> 0xffff8881004dccc0

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 20164 Comm: syz.0.5594 Tainted: G        W          6.14.0-rc7-syzkaller-00074-ga7f2e10ecd8f #0
Tainted: [W]=WARN
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

