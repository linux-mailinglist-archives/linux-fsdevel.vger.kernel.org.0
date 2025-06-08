Return-Path: <linux-fsdevel+bounces-50925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B32AD1113
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 07:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AC2188D684
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 05:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89931F416A;
	Sun,  8 Jun 2025 05:52:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFB1A08B8
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jun 2025 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749361949; cv=none; b=Xu5ivjwLfGgjzk8+R0Q8ehfgMVf3PfhEiLxuUDx7Qa3qHWplnvpa6GDaxARFLhYG8TfTKxuo7BvHqcU7t1UXaW1uH6kbXz1izCy3SgvYuf9dw2TDdFuwHwjoAZHqb4NF/RoIX1J6QJX+HMp+Vxr/L002npDCo3AL8TbMTugwlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749361949; c=relaxed/simple;
	bh=qKfRNG4CDlfDLTDcwYrI3sQenEFSFY+8eszH/djEgpw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LSBWXUFl6Y/DzL+7Cb+CJMIZxETeyec/Nhv9+A+3WAltyZ42d4Og/dljEIByJSbU/6VW1vYCm+2VIXIqNlo+sgAbnFbAiC7g2f5OXFZZgzwH9as4dbRtScCi0pZdqNxzlIw8cmaUGKQs6WyAt2At99oaXrMInLSZBV/qb1Pn/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddd03db21cso37585455ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 22:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749361947; x=1749966747;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jcpD0WAjPXInoYOjIEM2gCgbdLZHAzXILaKBUQO5vQI=;
        b=Biinbl9rxrczLqY/nEIeiHkLy3+vHVMK1L/SZnq6418HIlHK3YatM8y9WQ1RKFQRUo
         3MZ5TcSzh3/4HFVad7GL42zPGB7Gj5i6lyCi40FD+R4vUomcBaRIybEWv0suvtaeGKD8
         N//PLJeyz2iDTuw2uWKfpZyT4vqjWEg5kxEy8tCNpJ6hlgsOsO0++bBEl2x9k9GjZLjF
         3fC1G0993gAkTW+I60D2V9ZpBokBEHktP3K/iyJQtK/8uieSRUn7y0B4c3rYF/HiLULB
         +TbSyj9fvtLUPT/IZqrDXJORiWO+NPlHk+YDGUlLbDNQSnxDSIlTe1c203CqU8N3JE0z
         CDMw==
X-Forwarded-Encrypted: i=1; AJvYcCXglwbCUAYnqLGGOMggITSxQzdIeDIqvAI7cHIaPBLdW12hhlQPaDvs3/XJovbCxNJQptxeQ2DnsWP4BwSB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8GJyMEQ5j9qxKBfI+1qT/dsQ3g85TmTw21Vn1SFdB+gkQJjmw
	pfm2Yi2wKVkji2WDrkS1p6FgILwKNlSyrMk9JI+VRKXaLj8041FS3OFRZaYd/WOhDvQBzerfdr2
	KR1nPkCwKWtnMCFEyOxoGlKeM+HexGf3Ga+geMKUgbzRdgYtrNZGz+yC291E=
X-Google-Smtp-Source: AGHT+IGxpDaJrmlySBLqlw/KI8UBV6V43VtsKHhfdAabbQN0gual+U7s2e4m87WT1EHQ12tptZaJOSaZvnkhB+iBsY25DpGpBVEc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:3dc:7f17:72e6 with SMTP id
 e9e14a558f8ab-3ddce461b22mr106219555ab.5.1749361947068; Sat, 07 Jun 2025
 22:52:27 -0700 (PDT)
Date: Sat, 07 Jun 2025 22:52:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6845251b.050a0220.daf97.0aed.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree (2)
From: syzbot <syzbot+10a214d962941493d1dd@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    911483b25612 Add linux-next specific files for 20250604
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=161761d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28859360c84ac63d
dashboard link: https://syzkaller.appspot.com/bug?extid=10a214d962941493d1dd
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1106940c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ce7c82580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1067df4a0ae9/disk-911483b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ec468cccc74/vmlinux-911483b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/02250b138a0f/bzImage-911483b2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ac45824a405f/mount_0.gz

The issue was bisected to:

commit ad7a2ae339342ce4721993e637ecd9f7dc654f3b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Jun 2 00:22:17 2025 +0000

    bcachefs: Add missing restart handling to check_topology()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162c2c0c580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=152c2c0c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=112c2c0c580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10a214d962941493d1dd@syzkaller.appspotmail.com
Fixes: ad7a2ae33934 ("bcachefs: Add missing restart handling to check_topology()")

bcachefs (loop0): error in recovery: ENOMEMemergency read only at seq 10
bcachefs (loop0): bch2_fs_start(): error starting filesystem ENOMEM
bcachefs (loop0): shutting down
bcachefs (loop0): shutdown complete
bcachefs: bch2_fs_get_tree() error: ENOMEM
Filesystem bcachefs get_tree() didn't set fc->root, returned 12
------------[ cut here ]------------
kernel BUG at fs/super.c:1812!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5842 Comm: syz-executor187 Not tainted 6.15.0-next-20250604-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1812
Code: 1b 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 8b ee ff 48 8b 33 48 c7 c7 00 31 99 8b 44 89 f2 e8 d2 42 f2 fe 90 <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000437fd58 EFLAGS: 00010246
RAX: 000000000000003f RBX: ffffffff8e7829a0 RCX: ad6f5de195933e00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa9ec R12: 1ffff1100ea3c216
R13: dffffc0000000000 R14: 000000000000000c R15: 0000000000000000
FS:  000055558ea4c380(0000) GS:ffff888125c4d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005620027d9f60 CR3: 0000000075234000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_new_mount+0x24a/0xa40 fs/namespace.c:3874
 do_mount fs/namespace.c:4211 [inline]
 __do_sys_mount fs/namespace.c:4422 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4399
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff57623fe2a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda26af7f8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffda26af810 RCX: 00007ff57623fe2a
RDX: 00002000000000c0 RSI: 0000200000000000 RDI: 00007ffda26af810
RBP: 0000200000000000 R08: 00007ffda26af850 R09: 0000000000005972
R10: 0000000000800000 R11: 0000000000000282 R12: 00002000000000c0
R13: 00007ffda26af850 R14: 0000000000000003 R15: 0000000000800000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vfs_get_tree+0x29f/0x2b0 fs/super.c:1812
Code: 1b 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 14 8b ee ff 48 8b 33 48 c7 c7 00 31 99 8b 44 89 f2 e8 d2 42 f2 fe 90 <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc9000437fd58 EFLAGS: 00010246
RAX: 000000000000003f RBX: ffffffff8e7829a0 RCX: ad6f5de195933e00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa9ec R12: 1ffff1100ea3c216
R13: dffffc0000000000 R14: 000000000000000c R15: 0000000000000000
FS:  000055558ea4c380(0000) GS:ffff888125c4d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe40667f19 CR3: 0000000075234000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

