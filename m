Return-Path: <linux-fsdevel+bounces-38871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBCAA09392
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E403AB056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182121129B;
	Fri, 10 Jan 2025 14:33:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87088210F53
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519616; cv=none; b=NL9XnMQJqivCVdp6jwxTwT8jcbDJGxm7k+LzWEhAcPNDT6L+WwcBfcvxn4rhdZMptgVYMu8eB9okMvTdh/PQg03BaKabljbB0QQySGiti2OZAL5a1EJaPtPrxaGbEe8Ag/5KPJYlwm2O32IU2uGY2zEr+zMDsPoPAcb1QfI9Fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519616; c=relaxed/simple;
	bh=FTixIt1Pfib1SxnFAbx0jxo7zYnNxHMl3ZlfWnNVOFk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YH2JnKfZ553gzijRm3Fiq+B9r19KcDd7JLZJiayxjiY04R/Tr8unpXRH+Xydhgj+X2lU6Y41/ChDl0hRlo8ddmARrnG7U/MEBcl2jujFiA+JqEuDXd392CT6e9BrYa1e9zc5X1IibI5n3asKaLQDlhGuYiGJRKJAXoRZrIZW27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so29746335ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 06:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519613; x=1737124413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dj8sgh3DvK6udNvRy3FZ+BslGGEsfvrIbcGyM9uJhIE=;
        b=gyl8nfqKi0RyiX4jIljQMQ2bzM91pahfhpTYuk+QVZJRE3vEw3YMui6teKOToBXvJ5
         YSalQfid90PYk04G2ly/aP5XbGS1njF62z1mwCWj83z4wxzfuz+hB/qKvMZep68CZsM4
         daEKzn5swq2PB09uobrcs34xVx+1y17REEjeAHqfQMFkbSRlWGDpZ34ydy4/rn53QRP6
         +fOvtcbfjQ4SaNKbh8qgPDj5joJkmG22E2TwGJd4IjfGW4WapYtth0iTz9dAu+dbLhTC
         FYJUzVdZ6+9EMmpvFBVKhKgdJ3iq3pavdCRepxZZuYhGEovNiRnWgJpasmTkjRKB9bMY
         rXHw==
X-Gm-Message-State: AOJu0YyY3+GItXEAnqwoFx5qXrOpuQbR0cpL9J+kn142/cmdNn5b0k2Z
	CcN+yJXw+eEVOgTlMpR+i9/C6i5DR9wYCKz3BWpSgG/jHx8p6aeYk82Ld7aft1j/10AikSvj+Bb
	D/DA/cGYOvtuG9RHe5zExtR7rsHqnbpwHUmttCp3VIRhq99rdrx84S3CrhQ==
X-Google-Smtp-Source: AGHT+IHkMz7OISSaHyZaBDgthjNva58Paqs8zzLq8vVDMYYqlPSITkmjJG2Htv1GKmWcAnWfWIyyXd/6nOepm6XDLqsrkOwKg082
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3201:b0:3a7:4e3e:d03a with SMTP id
 e9e14a558f8ab-3ce3a8e1e77mr81936745ab.22.1736519613663; Fri, 10 Jan 2025
 06:33:33 -0800 (PST)
Date: Fri, 10 Jan 2025 06:33:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67812fbd.050a0220.d0267.0030.GAE@google.com>
Subject: [syzbot] [fs?] kernel BUG in kpagecount_read
From: syzbot <syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c061cf420ded Merge tag 'trace-v6.13-rc3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ee22df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=3d7dc5eaba6b932f8535
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/565ec42c1d1a/disk-c061cf42.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/142d1c3a6f99/vmlinux-c061cf42.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b21efab0a38b/bzImage-c061cf42.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com

 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6883
 napi_poll net/core/dev.c:6952 [inline]
 net_rx_action+0xa94/0x1010 net/core/dev.c:7074
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 common_interrupt+0xbf/0xe0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
------------[ cut here ]------------
kernel BUG at ./include/linux/mm.h:1221!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 11868 Comm: syz.3.1633 Tainted: G     U             6.13.0-rc3-syzkaller-00062-gc061cf420ded #0
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:folio_entire_mapcount include/linux/mm.h:1221 [inline]
RIP: 0010:folio_precise_page_mapcount fs/proc/internal.h:172 [inline]
RIP: 0010:kpagecount_read+0x477/0x570 fs/proc/page.c:71
Code: 31 ff 49 29 c4 48 8b 44 24 08 4c 01 20 e8 41 77 61 ff eb 92 e8 ca 74 61 ff 48 8b 3c 24 48 c7 c6 20 eb 61 8b e8 6a 34 a8 ff 90 <0f> 0b 4c 89 ff e8 ef de c3 ff e9 5a ff ff ff e8 a5 74 61 ff 48 8b
RSP: 0018:ffffc9000ca57ca0 EFLAGS: 00010246
RAX: 0000000000080000 RBX: 0000000000000000 RCX: ffffc9000d719000
RDX: 0000000000080000 RSI: ffffffff8237da36 RDI: ffff888035460444
RBP: 0000000001058a80 R08: 0000000000000001 R09: fffffbfff2d36daf
R10: ffffffff969b6d7f R11: 0000000000000004 R12: 00000000201a9000
R13: 0000000000034eb0 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f56afbaa6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002669000 CR3: 000000006b460000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pde_read fs/proc/inode.c:308 [inline]
 proc_reg_read+0x11d/0x330 fs/proc/inode.c:318
 vfs_read+0x1df/0xbe0 fs/read_write.c:563
 ksys_read+0x12b/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f56aed85d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f56afbaa038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f56aef75fa0 RCX: 00007f56aed85d29
RDX: 00000000fffffea1 RSI: 0000000020001a80 RDI: 0000000000000005
RBP: 00007f56aee01a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f56aef75fa0 R15: 00007ffc1f509908
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_entire_mapcount include/linux/mm.h:1221 [inline]
RIP: 0010:folio_precise_page_mapcount fs/proc/internal.h:172 [inline]
RIP: 0010:kpagecount_read+0x477/0x570 fs/proc/page.c:71
Code: 31 ff 49 29 c4 48 8b 44 24 08 4c 01 20 e8 41 77 61 ff eb 92 e8 ca 74 61 ff 48 8b 3c 24 48 c7 c6 20 eb 61 8b e8 6a 34 a8 ff 90 <0f> 0b 4c 89 ff e8 ef de c3 ff e9 5a ff ff ff e8 a5 74 61 ff 48 8b
RSP: 0018:ffffc9000ca57ca0 EFLAGS: 00010246
RAX: 0000000000080000 RBX: 0000000000000000 RCX: ffffc9000d719000
RDX: 0000000000080000 RSI: ffffffff8237da36 RDI: ffff888035460444
RBP: 0000000001058a80 R08: 0000000000000001 R09: fffffbfff2d36daf
R10: ffffffff969b6d7f R11: 0000000000000004 R12: 00000000201a9000
R13: 0000000000034eb0 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f56afbaa6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000370e000 CR3: 000000006b460000 CR4: 00000000003526f0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

