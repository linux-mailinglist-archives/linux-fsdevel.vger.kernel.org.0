Return-Path: <linux-fsdevel+bounces-67414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C93C3EC35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 08:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265F73AFBD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58684308F36;
	Fri,  7 Nov 2025 07:31:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AE27B4FB
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500690; cv=none; b=PITO+K6PfOuGgH27dkJ4y4YibUBTrQ1tKHAh8Lc1cQoyZBPLB/V5qOL/EQlO5HOhdr9uh1xpf9qO8oiJhyuPfhlza1Irqe/fymG09iQ7PC6OBiM4/ztCfmU/S6u3J2Tcq8+tQj/g1cBq942fnmhLhTDDh9NoPANqb4VQgA47J08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500690; c=relaxed/simple;
	bh=hmBQunOCM5ZmhF1k490t04BJn11l0BugsBMHywhEaok=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WdIsO+x/yPyaJ8iI5ZFLKI4poX1PwOsTJhbUPgBcurb2fpjf3razv0amZoymHpEKafHPaeyiHMog+8ungfBLklNGUOYRPFxljV5k8gvbEEiiLI74CTuGjWcPrxPg6qpfZ/9Op9sEAx8xybOwyUqQtcy66tBaYahRLOI/YERpYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9486440360dso41825439f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 23:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500688; x=1763105488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DC5whZ6xjAg9orncDEXG9Mf4Zikpjttx0BkeAU8vHTQ=;
        b=JShywigQSMuQ6+9DwiCXkf+BtoIXWCmjFXuQulv88CR7Czg6EwN8ba1NAZy8yIIV7K
         qIieN1FEZdZsUc4d0i01CVQQbKU8EU3d4VeZ+dj1b/0quPSWCbr0q1HGnOqhUD0cVVJw
         8c6FTahX0wsHYY5GOyGWzj/KN5Y4I7qPT+YZS1QjUIEbHlHMgkc569SsPSTqyd0XaSVv
         fzfDvNWM+fC4laOs/bzydNbUQ/8b9aBEzhCLFBeKGdYYCMqdgGoULZHsxKovUw+p41/B
         aEfQBImfzM2qh+dB4sTGdJ5X6RUGMcLz5SCeJGMk0YT91eFtyh6Z+k4XSDVPAhqrelAV
         8o/A==
X-Forwarded-Encrypted: i=1; AJvYcCV/1ufHuiTu2bsCb3qmDeL+H848GXNg4OaxAdslMEIcN+G2qISi0/6CcDMVlN+frE2RTfSVYd2oF/DdAH4M@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGm2iNG+92ILElbPujlXo5pvY4IrFpRVGIoOJFe9ouVHmd+DO
	ZUhr/dyB7w2xATrVfYcCzVpbbyvERiyIFexyaqQgGvbrWYSesets0pl11UX2HLAbgOGDiyHCbsF
	fGbgpn66f52X8Fo/LORgiGPbRrOV+zVkwIyTqv6BzQGfRr1NC0AnCqbXt4lI=
X-Google-Smtp-Source: AGHT+IF1mWmFU+QuzP+6G0raJVSuUbhvWf35rIhwvg/7kKBEsHrx+TEWgqipXwdks6Tvvg+v62pf8jfuYyIcJq7AP3kS3CRjzES2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:433:290f:c201 with SMTP id
 e9e14a558f8ab-4335f3d0389mr32665345ab.11.1762500687581; Thu, 06 Nov 2025
 23:31:27 -0800 (PST)
Date: Thu, 06 Nov 2025 23:31:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690da04f.a70a0220.22f260.0027.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	anna-maria@linutronix.de, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, cgroups@vger.kernel.org, david@redhat.com, 
	dietmar.eggemann@arm.com, frederic@kernel.org, hannes@cmpxchg.org, 
	jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, mjguzik@gmail.com, mkoutny@suse.com, oleg@redhat.com, 
	paul@paul-moore.com, peterz@infradead.org, rostedt@goodmis.org, 
	rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    982312090977 Add linux-next specific files for 20251103
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17b2932f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43cc0e31558cb527
dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1347817c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40058f8a830c/disk-98231209.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d7f42e8639f/vmlinux-98231209.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8bb0284f393/bzImage-98231209.xz

The issue was bisected to:

commit 3c9820d5c64aeaadea7ffe3a6bb99d019a5ff46a
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Oct 29 12:20:24 2025 +0000

    ns: add active reference count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101e9bcd980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121e9bcd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=141e9bcd980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Fixes: 3c9820d5c64a ("ns: add active reference count")

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:229 at __ns_ref_put include/linux/ns_common.h:229 [inline], CPU#0: kworker/0:6/6108
WARNING: ./include/linux/ns_common.h:229 at put_user_ns include/linux/user_namespace.h:189 [inline], CPU#0: kworker/0:6/6108
WARNING: ./include/linux/ns_common.h:229 at destroy_super_work+0x15c/0x1a0 fs/super.c:280, CPU#0: kworker/0:6/6108
Modules linked in:
CPU: 0 UID: 0 PID: 6108 Comm: kworker/0:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events destroy_super_work
RIP: 0010:__ns_ref_put include/linux/ns_common.h:229 [inline]
RIP: 0010:put_user_ns include/linux/user_namespace.h:189 [inline]
RIP: 0010:destroy_super_work+0x15c/0x1a0 fs/super.c:280
Code: 90 63 ff 48 81 c3 a8 fc ff ff 48 89 df e8 ec 90 63 ff 4c 89 f7 5b 41 5c 41 5d 41 5e 41 5f 5d e9 8a 91 e1 ff e8 45 df 86 ff 90 <0f> 0b 90 e9 6d ff ff ff e8 37 df 86 ff 4c 89 e7 be 03 00 00 00 e8
RSP: 0018:ffffc900030d7a48 EFLAGS: 00010293
RAX: ffffffff823a294b RBX: ffff88805639c898 RCX: ffff88802ab59e80
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffff88807477565b R09: 1ffff1100e8eeacb
R10: dffffc0000000000 R11: ffffed100e8eeacc R12: ffff888074775658
R13: dffffc0000000000 R14: ffff88805639c000 R15: ffff8880747754c8
FS:  0000000000000000(0000) GS:ffff888125eda000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c008044000 CR3: 0000000077ad4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 process_one_work+0x94a/0x15d0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3350 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3431
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x52d/0xa70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

