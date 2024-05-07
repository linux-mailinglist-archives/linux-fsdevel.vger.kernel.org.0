Return-Path: <linux-fsdevel+bounces-18878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F698BDCC8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 09:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C59C2814AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A313C825;
	Tue,  7 May 2024 07:57:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544D78274
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068643; cv=none; b=BT1+WfyDGZo7Sa3pqf+yAPO9zi67zVk17Xy4sr6mEuYX3AwOfSnwGL/ufpHot8tnfwLsy7YEyqG6eOn+nazIRlRU4eEjSRJnzuGCHQynsnQdnFNAA+XtdkuUYJ3qqBIK7MsI/OnI0obfrfQUfqS1xTlwkYuo1H2W1KLwi1Op8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068643; c=relaxed/simple;
	bh=UiL0lNsLkBheMrPpfn7tGAXa1d92jQg/501qFzXU8gk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BMTXrInR98zAXvtWfe8XFWasa2FNLbFltyRNLSjcfhlsWmx9j3k2LUSCYCPnyLue1RG9kCbemYSDmUVuKkq2MzSm0x/QjXUDFrkUJ8cScZ/iXt1r7yqa0q6l1C3IIy8CdTn7HHOmrcfIdCXUouGmbBQpybL0+rD5N1sVvpfXAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-36b1d46700eso21132275ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 00:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715068641; x=1715673441;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZidFwnkN6Y7nu+nx4pT0dPd/8UpyGwIteouTtk6ORGA=;
        b=a8xQ3r+7SAsaZiNtGIudW7hV28JTiecSq3HUKT/bQTCtT8AMXT6iOdmPPD9AhJzHpJ
         6oOqS/UqG8qpTG7xhC464ooQrLQYLZ4OAtJp7akAUx2QrwFuwSrCDDPpbEKj6ZpmhjvR
         qShuUeKxZZS5n696BHAUvyP3PaJVEIvng5fKGbu0ngbOjtRWsRH10cKeqhiTlg37xImR
         vdBspkDyR6bMj2TDtxzDopliyhraaX03JaPgBZOibfY9vq9UzSwHaS6xcQIhSJ5YVg3T
         3EuU5HuiuqeAz4Uw7OrPd1ek4fgpwBm2ahLb4K7TJj5jgT8xSkEgWcwzEqK4pKWUAPJV
         p5wg==
X-Forwarded-Encrypted: i=1; AJvYcCUK7W2Y7SV1++gL2lEsJnVkfY0W6dsorYWj3OubGPcsg6BQLZ44rRfnDnET8EI0RmV/FPORM/AeMLTy8+58DuP23K0yCNbcenPwhrTFsw==
X-Gm-Message-State: AOJu0Yyn3GxqK8VMrLPyAHClhom3O83s71nxDCm/BXQS73jOCsEuOdUD
	xUosB02f6dh4qFQzyYm8vmTzEj7bxsVhlvyFIJbJa7E8Ao7aBDC345rjdC4PhJXp/hX4cMY3V1a
	/zP9EMCLv6U0I+hmhFGezltmcI59wTcUWE3qLhWkTnMbR0HscM0zEiFc=
X-Google-Smtp-Source: AGHT+IF+gmQQ+Y47r012cbKpIZjJALZDEvS8pq5lcXedbZbB2jBj55ZuxuaQYAKhNik1HGw0X7T6YFqlwcATGTAP2eMLMZQsZdgq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2b:b0:36c:5014:3bf0 with SMTP id
 m11-20020a056e021c2b00b0036c50143bf0mr625706ilh.3.1715068641622; Tue, 07 May
 2024 00:57:21 -0700 (PDT)
Date: Tue, 07 May 2024 00:57:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000264c0d0617d88912@google.com>
Subject: [syzbot] [jfs?] KASAN: user-memory-access Read in jfs_statfs
From: syzbot <syzbot+cea4fad5485bc30243a9@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fc7570980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=cea4fad5485bc30243a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c07ad4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea1961ce01fe/disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/445a00347402/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/461aed7c4df3/bzImage-dccb07f2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/30e39d5c3e2c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cea4fad5485bc30243a9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: user-memory-access in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: user-memory-access in jfs_statfs+0x20e/0x510 fs/jfs/super.c:140
Read of size 4 at addr 00000000000050c0 by task syz-executor.1/7188

CPU: 1 PID: 7188 Comm: syz-executor.1 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 jfs_statfs+0x20e/0x510 fs/jfs/super.c:140
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs fs/statfs.c:90 [inline]
 user_statfs+0x216/0x460 fs/statfs.c:105
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs fs/statfs.c:192 [inline]
 __x64_sys_statfs+0xe8/0x1a0 fs/statfs.c:192
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff13647dca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff1371a30c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 00007ff1365abf80 RCX: 00007ff13647dca9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007ff1364c947e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff1365abf80 R15: 00007fffc058c158
 </TASK>
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

