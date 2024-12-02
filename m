Return-Path: <linux-fsdevel+bounces-36276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894819E09C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 18:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495002828A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12E1DB922;
	Mon,  2 Dec 2024 17:23:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA881D8DFE
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160205; cv=none; b=AVT+o6aNo0+0A9XEZBeSNF9t7Hxtr0gP3Azc8S/dPIqqyosPSb6FpUwfku/FklzAFOouPxNDGhzR313N66VmUqvfAVGeTt53gG9e8gkn3sDCQlu4cyFzfJTsUyz6o3+CbDEyPo9XOXqsR07o+8PRwW/dQTQ4/v/Eyxi7lnd8IIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160205; c=relaxed/simple;
	bh=niYey3A2BI1zHc9oE/V9wTEb2AngGjaDi9xTB6eXJp0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MFzVJKTGACbm/Hfs+2525nqLfotcZXVzMoRWd7Yj01Dx9O7rdNpSDJTeeZTrD/Hxq4omjxVy/FCWDFkGhReUkYqN4C8sUJGSQNMf4ZkswsDy8sgC8kwoN6PnTonb6Uzdo69/PGJ0dArNZ0g38L98np4Z5FbE+/BQ2ySVGrCV5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7bdd00353so50513055ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 09:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733160203; x=1733765003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWtCFCl9BH6B1/hrLDgMJbyasTsGi0yL5kBQrDwE6xQ=;
        b=gRfjxqFaDjqF3pizpe51B0SXgdATunDvrHp+247l++G6SvVI7RcTTyovrWZDIuC87o
         au0EL+BpgOyQXueCAzYhe8IVtj0VSKIWFeJlQ9O4NAHLJovbaNXPVHZREPaJzgjFzDWf
         cfe4uG059w/MTv7d3B7oXB4Tf9V712aDRKMH+DVYk0CQWooAy32h0NzRs5SOMoiUEbds
         SM+SbNGBMV2MuixVwiPH5G4uuNrQ+QV0i69slykfbQCqVW2Y9RJ4NtijVHFiCtKMLe9s
         EngE/BwgYSihhhE+W7FcuQU01mRsjqOrlblZzs7vXyARbpvabzgtAWUuLUH4/i6LMZId
         /A4A==
X-Forwarded-Encrypted: i=1; AJvYcCU05FqtJHy4yFg4tGz3vRfI0M31QmeyHLsO+q+jCSw15TJ/7W+5mzGBjjirdmhThPgEtn+sXPfOUfjnsGxO@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIxU6epfWJujwbneJeP3Bqb8rQK40yP06sGj3Absa6ux623fn
	dJyQW5e2J5ZEPJwN7tMKyuBXri33RvDW6HWsFhHxQKp7Lz87+6O8wjAQH+lgFvgP7OVPaS/QOcz
	Wbjwd+xKLCgqgYOsfidehafR4b12c9CSf9/cFVpeGYsLVk9XrBttSGq4=
X-Google-Smtp-Source: AGHT+IFGrYLgVMCkuWthz1BRGHleiw9U22O8SugwE5SIOQ51OAgdGsPOdMZVjiB1rIUZC23Pv25Kpzsr+8zM3B/WjzigFSvEFPLm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:3a7:9347:5465 with SMTP id
 e9e14a558f8ab-3a7c5523826mr268135525ab.3.1733160203172; Mon, 02 Dec 2024
 09:23:23 -0800 (PST)
Date: Mon, 02 Dec 2024 09:23:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ded0b.050a0220.48a03.0027.GAE@google.com>
Subject: [syzbot] [netfs?] WARNING in netfs_retry_reads (2)
From: syzbot <syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bharathsm@microsoft.com, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com, 
	rostedt@goodmis.org, samba-technical@lists.samba.org, sfrench@samba.org, 
	sprasad@microsoft.com, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1236a0df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=5621e2baf492be382fa9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17da7f78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138f3d30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz

The issue was bisected to:

commit 1bd9011ee163e11f186b72705978fd6b21bdc07b
Author: David Howells <dhowells@redhat.com>
Date:   Fri Nov 8 17:32:29 2024 +0000

    netfs: Change the read result collector to only use one work item

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144ccfc0580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164ccfc0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=124ccfc0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5621e2baf492be382fa9@syzkaller.appspotmail.com
Fixes: 1bd9011ee163 ("netfs: Change the read result collector to only use one work item")

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=2 set at [<ffffffff8177c166>] prepare_to_wait+0x186/0x210 kernel/sched/wait.c:237
WARNING: CPU: 0 PID: 5828 at kernel/sched/core.c:8685 __might_sleep+0xb9/0xe0 kernel/sched/core.c:8681
Modules linked in:
CPU: 0 UID: 0 PID: 5828 Comm: syz-executor222 Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__might_sleep+0xb9/0xe0 kernel/sched/core.c:8681
Code: 94 0e 01 90 42 80 3c 23 00 74 08 48 89 ef e8 ae 30 9b 00 48 8b 4d 00 48 c7 c7 e0 2d 0a 8c 44 89 ee 48 89 ca e8 08 e6 f0 ff 90 <0f> 0b 90 90 eb b5 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 70 ff ff ff
RSP: 0018:ffffc900039765a8 EFLAGS: 00010246
RAX: b7d7501871149800 RBX: 1ffff1100ff252ed RCX: ffff88807f928000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807f929768 R08: ffffffff81601ea2 R09: fffffbfff1cfa220
R10: dffffc0000000000 R11: fffffbfff1cfa220 R12: dffffc0000000000
R13: 0000000000000002 R14: 000000000000004a R15: ffffffff8c1ca1a0
FS:  0000555593050480(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bb6dfcc068 CR3: 000000002f04e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wait_on_bit include/linux/wait_bit.h:74 [inline]
 netfs_retry_reads+0xde/0x1e10 fs/netfs/read_retry.c:263
 netfs_collect_read_results fs/netfs/read_collect.c:333 [inline]
 netfs_read_collection+0x334e/0x4020 fs/netfs/read_collect.c:414
 netfs_wait_for_read+0x2ba/0x4e0 fs/netfs/read_collect.c:629
 netfs_unbuffered_read fs/netfs/direct_read.c:156 [inline]
 netfs_unbuffered_read_iter_locked+0x11fc/0x1540 fs/netfs/direct_read.c:231
 netfs_unbuffered_read_iter+0xbf/0xe0 fs/netfs/direct_read.c:266
 __kernel_read+0x513/0x9d0 fs/read_write.c:523
 integrity_kernel_read+0xb0/0x100 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0xae6/0x1b30 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x520/0xb10 security/integrity/ima/ima_api.c:293
 process_measurement+0x1351/0x1fb0 security/integrity/ima/ima_main.c:372
 ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xb9/0x280 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x2ccd/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_open fs/open.c:1425 [inline]
 __se_sys_open fs/open.c:1421 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1421
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdf86d213b9
Code: d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb23978f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffdb2397940 RCX: 00007fdf86d213b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000340
RBP: 00007ffdb2397948 R08: aaaaaaaaaaaa0102 R09: aaaaaaaaaaaa0102
R10: aaaaaaaaaaaa0102 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 000000000000001d R15: 00007fdf86d983a0
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

