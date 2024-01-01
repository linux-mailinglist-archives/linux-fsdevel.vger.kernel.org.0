Return-Path: <linux-fsdevel+bounces-7056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFC821370
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 10:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4488C282B9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978B20FD;
	Mon,  1 Jan 2024 09:54:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847A17E4
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jan 2024 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fe6d256eso1221108239f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jan 2024 01:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704102863; x=1704707663;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NP45h3cNbaU1W5ZqRvf11WWj8aK3hXs0ylShj0AXyVE=;
        b=g7WcqAJ3BVTY6xLQzxVruxdeE8KOlw4DrEBZEfT1rI7r0kdf6n5MT47t20XyvYvnu1
         xYrE4483P76C+WF1affeDHieACr0DKeFrfcbeFTMWJE4xQRa8R9E1Mj8wtpldndT/Vnv
         rC+Prn3GzJQVbGzxjI9R9KHjygHFPiMFEoj/eP+LXpWzKTlUWpPcvqyxecM73KaVTxoo
         JoDRoFLinkurjwfi/k3MdMV++hILRZfyt3kQftGtqf4apTrn8SoGYWZdMUzdy4rx0zYG
         62kv1UYO2GRSo7Rro95udVA6Gdz6hVOfSh8jphQZwXNq4nocbrk0Ielys7NLAvz9WlFZ
         BTlw==
X-Gm-Message-State: AOJu0YwTrj+4ddL1eOJyWKzrw73mIUYcPjyhFburfGWzty438KwtK2Jt
	GEtkROWHzNlYq49+JxZxVSqwkfxtAHp2HWvXvP9A2smqoNTn
X-Google-Smtp-Source: AGHT+IHDYxOCBF+E6pNKWPBAt9KLV5FKIdmX2t66B6it0QtyPV4fgZkAmPgnM+4f6esnhpzLNSUN2BmMKRZXgYzZ83PdfluVSkBl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bad:b0:360:e6b:bc4a with SMTP id
 n13-20020a056e021bad00b003600e6bbc4amr1255413ili.2.1704102862692; Mon, 01 Jan
 2024 01:54:22 -0800 (PST)
Date: Mon, 01 Jan 2024 01:54:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caa956060ddf5db1@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in __fget_files (2)
From: syzbot <syzbot+63cebbb27f598a7f901b@syzkaller.appspotmail.com>
To: brauner@kernel.org, chouhan.shreyansh630@gmail.com, jack@suse.cz, 
	jeffm@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, rkovhaev@gmail.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ad7616e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
dashboard link: https://syzkaller.appspot.com/bug?extid=63cebbb27f598a7f901b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230c7e9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133d189ae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bb9a47cfe092/disk-f5837722.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e6428b5b55b/vmlinux-f5837722.xz
kernel image: https://storage.googleapis.com/syzbot-assets/545d22abacbc/bzImage-f5837722.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bb1e27bc000d/mount_0.gz

The issue was bisected to:

commit 13d257503c0930010ef9eed78b689cec417ab741
Author: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Date:   Fri Jul 9 15:29:29 2021 +0000

    reiserfs: check directory items on read from disk

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125e92f9e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=115e92f9e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=165e92f9e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63cebbb27f598a7f901b@syzkaller.appspotmail.com
Fixes: 13d257503c09 ("reiserfs: check directory items on read from disk")

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5053 Comm: sshd Not tainted 6.7.0-rc7-syzkaller-00016-gf5837722ffec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:__fget_files_rcu fs/file.c:963 [inline]
RIP: 0010:__fget_files+0x96/0x340 fs/file.c:1022
Code: 89 f8 48 c1 e8 03 4c 01 f0 48 89 04 24 e8 62 86 92 ff 48 8b 04 24 80 38 00 0f 85 7f 02 00 00 4d 8b 65 58 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30 84 c0 74 08 3c 03 0f 8e 70 02 00 00 41 8b 1c 24 89
RSP: 0018:ffffc9000331f8a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81f3df8d
RDX: ffff88802a5e2180 RSI: ffffffff81f3de1e RDI: 0000000000000001
RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807300f040 R14: dffffc0000000000 R15: ffff88807300f098
FS:  00007f9d8d382800(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005592de0c8df8 CR3: 000000001f753000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __fget fs/file.c:1030 [inline]
 __fget_light+0xd0/0x260 fs/file.c:1137
 fdget include/linux/file.h:64 [inline]
 do_pollfd fs/select.c:866 [inline]
 do_poll fs/select.c:921 [inline]
 do_sys_poll+0x469/0xde0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __x64_sys_ppoll+0x256/0x2d0 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f9d8cf19ad5
Code: 85 d2 74 0d 0f 10 02 48 8d 54 24 20 0f 11 44 24 20 64 8b 04 25 18 00 00 00 85 c0 75 27 41 b8 08 00 00 00 b8 0f 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 75 48 8b 15 24 73 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffeaa4272d0 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 00000000000668a0 RCX: 00007f9d8cf19ad5
RDX: 00007ffeaa4272f0 RSI: 0000000000000004 RDI: 000055c03123eaa0
RBP: 000055c03123f260 R08: 0000000000000008 R09: 0000000000000000
R10: 00007ffeaa4273d8 R11: 0000000000000246 R12: 000055c02f66caa4
R13: 0000000000000001 R14: 000055c02f66d3e8 R15: 00007ffeaa427358
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	89 f8                	mov    %edi,%eax
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	4c 01 f0             	add    %r14,%rax
   9:	48 89 04 24          	mov    %rax,(%rsp)
   d:	e8 62 86 92 ff       	call   0xff928674
  12:	48 8b 04 24          	mov    (%rsp),%rax
  16:	80 38 00             	cmpb   $0x0,(%rax)
  19:	0f 85 7f 02 00 00    	jne    0x29e
  1f:	4d 8b 65 58          	mov    0x58(%r13),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	74 08                	je     0x3b
  33:	3c 03                	cmp    $0x3,%al
  35:	0f 8e 70 02 00 00    	jle    0x2ab
  3b:	41 8b 1c 24          	mov    (%r12),%ebx
  3f:	89                   	.byte 0x89


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

