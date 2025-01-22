Return-Path: <linux-fsdevel+bounces-39883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F548A19B73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 00:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749E916C860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 23:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9381CDA09;
	Wed, 22 Jan 2025 23:27:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D4F1CAA96
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737588442; cv=none; b=kLCeKjJFQzsZFUXWpGTwTFHw5P9BW5FXVBb8ZabuepijxiqlahQual2EaepKu1QToq9GuH+KIu9S/nna17JOYShh96F9J9DDIMYNp94yqgZfOZkBJnlIkklP2xzLhSlq8JClAiC1UyVQFkMOV8YSQXHQEwySNcCEXL2BCWQbxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737588442; c=relaxed/simple;
	bh=t34vYmG4ermwOVueidHoCUcjEDyWUMrynYw5pxZnZhE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pkzrFXUHG9fIEMAYwrfmHxpcT8bzUCd3Mvf8bzNwkkYRIk1Rq0yhtoHrteSxfJ4YTE3F1Cv+XHw2N4lGFB217EtOo9AzreIUnesEZJwJeUZpJt7DUm8Jjjp2HK01lvLnWcSAiai4YSnqC1bdkMbz/xCurm5r2A647+SRYtKd7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3cfb20d74b5so2104045ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 15:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737588440; x=1738193240;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqMC+G6rwK87UaS7Zs1/0KnA34jqKav2Ciavl8IbR+I=;
        b=Z3RIHZATosSPayZFbdox3M8VsmtIFKzxNyBh5XWKfx+ezIgDeScKqRjJLI1z3baiAo
         0JWAndrF3sPnq76dsssE8ZB7WoCAtHB368IxEwii0TS6VTgiYSusSMUN2Tqn1YlJynaN
         cnr8363N3w9BcaYGUZNB77bVXQHBnv8YurA/Hh7Y5E4B7rtT/JHN+Sjz6a4OLV8d5wu7
         D2DOUPF5tPWvwJY0MKCQZAB7C3Jn9ATwm0+E8A3rxnlIrzDsRqCm/N7voZXBGIi+HUdq
         At0zeoH2pDKtViYBCCxGb6XDHL3gZP74bVTs2N4Q2DSKwkll99S1Cfuws6uv0v7fb5jH
         Vxkw==
X-Forwarded-Encrypted: i=1; AJvYcCX8iyJgpk/xJVA6lQEWEPEEUf/hUa5muZ67L3BqVMqndc7Xn3K8YtM8t+Hfh3vlN/SwfD0WMe0YIRgeOx32@vger.kernel.org
X-Gm-Message-State: AOJu0YxkaC3mHmmaP/GA9ZVt3uvowbHqYoZm/Rhx9RpjSn4wn818YoWx
	03il8Uylh/B7zNV33AyJ0OMHwpsiRnqXmZz3jyMC333yF+WTvUnDenu1Lzv2q787KEidpbI6cbO
	42cIsroIRbj2Hvkl6PRcc64yOCprYHy+HMxtV1tCTuRONAgdsQbnrwGA=
X-Google-Smtp-Source: AGHT+IGZ2JlrsJ9DEVAXeCMysgWQpjYiv+Yzwd6bBU3hFrx6rDmqZ6PtUmJycAzdIw8dYpn5CB7TlA6bjORSJslQ8If6Ai1jbLSV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:3cf:6d33:d40d with SMTP id
 e9e14a558f8ab-3cf742812e4mr186744515ab.0.1737588440204; Wed, 22 Jan 2025
 15:27:20 -0800 (PST)
Date: Wed, 22 Jan 2025 15:27:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67917ed8.050a0220.15cac.02eb.GAE@google.com>
Subject: [syzbot] [fs?] BUG: corrupted list in remove_wait_queue (2)
From: syzbot <syzbot+4e21d5f67b886a692b55@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fda5e3f28400 Merge tag 'trace-v6.13-rc7-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1117e024580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e182416a4b418f
dashboard link: https://syzkaller.appspot.com/bug?extid=4e21d5f67b886a692b55
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177959df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1288d1f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd46ddd4b381/disk-fda5e3f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7cf021f77f5/vmlinux-fda5e3f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/12cb03ba7d7e/bzImage-fda5e3f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e21d5f67b886a692b55@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffffc90003377b98, but was ffff88802a2585c8. (prev=ffff88802a2585c8)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:62!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 9290 Comm: syz-executor367 Not tainted 6.13.0-rc7-syzkaller-00191-gfda5e3f28400 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__list_del_entry_valid_or_report+0x12c/0x1c0 lib/list_debug.c:62
Code: e8 19 db da fc 90 0f 0b 48 89 ca 48 c7 c7 00 a0 b1 8b e8 07 db da fc 90 0f 0b 48 89 c2 48 c7 c7 60 a0 b1 8b e8 f5 da da fc 90 <0f> 0b 48 89 d1 48 c7 c7 e0 a0 b1 8b 48 89 c2 e8 e0 da da fc 90 0f
RSP: 0018:ffffc90003377880 EFLAGS: 00010086
RAX: 000000000000006d RBX: ffffc90003377b80 RCX: ffffffff8178e449
RDX: 0000000000000000 RSI: ffffffff81798bd6 RDI: 0000000000000005
RBP: ffff88802a258588 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: 0000000000000286
R13: ffffc90003377b98 R14: ffffc90003377ba0 R15: ffffc90003377b70
FS:  0000555578a00380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f687b8542b0 CR3: 0000000073a90000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 __remove_wait_queue include/linux/wait.h:207 [inline]
 remove_wait_queue+0x30/0x180 kernel/sched/wait.c:55
 free_poll_entry fs/select.c:132 [inline]
 poll_freewait+0xd5/0x250 fs/select.c:141
 do_sys_poll+0x6f7/0xde0 fs/select.c:1010
 __do_sys_poll fs/select.c:1074 [inline]
 __se_sys_poll fs/select.c:1062 [inline]
 __x64_sys_poll+0x1a8/0x450 fs/select.c:1062
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f687b7d8809
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb8bb93f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
RAX: ffffffffffffffda RBX: 00307276642f3072 RCX: 00007f687b7d8809
RDX: 0000000000000106 RSI: 0000000000000005 RDI: 0000000020000080
RBP: 0000000000000000 R08: 00007ffdb8bb8f60 R09: 00007ffdb8bb8f60
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdb8bb941c
R13: 00007ffdb8bb9430 R14: 00007ffdb8bb9470 R15: 0000000000000359
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x12c/0x1c0 lib/list_debug.c:62
Code: e8 19 db da fc 90 0f 0b 48 89 ca 48 c7 c7 00 a0 b1 8b e8 07 db da fc 90 0f 0b 48 89 c2 48 c7 c7 60 a0 b1 8b e8 f5 da da fc 90 <0f> 0b 48 89 d1 48 c7 c7 e0 a0 b1 8b 48 89 c2 e8 e0 da da fc 90 0f
RSP: 0018:ffffc90003377880 EFLAGS: 00010086
RAX: 000000000000006d RBX: ffffc90003377b80 RCX: ffffffff8178e449
RDX: 0000000000000000 RSI: ffffffff81798bd6 RDI: 0000000000000005
RBP: ffff88802a258588 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: 0000000000000286
R13: ffffc90003377b98 R14: ffffc90003377ba0 R15: ffffc90003377b70
FS:  0000555578a00380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f687b8542b0 CR3: 0000000073a90000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

