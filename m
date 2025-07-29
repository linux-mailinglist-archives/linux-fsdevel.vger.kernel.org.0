Return-Path: <linux-fsdevel+bounces-56279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53EAB154E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 23:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A35B7AFF3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 21:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E43127A445;
	Tue, 29 Jul 2025 21:58:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC1238D53
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753826315; cv=none; b=roS37LrNoPlpSW49oRq60pBVzKREcsroj7WlcW0ZTVFd7/c7/+qJwbe857pJ08+LAG7jUrNJkj0QqtgnH08SbdzlJkVUd8VJ9g3GgTVO+BNHZWUiYqQGCpJsVioThFQHWHMinSUynxrRIEUGJPFkITZxtnrFjD6eHiJNgDOaxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753826315; c=relaxed/simple;
	bh=O50tvZ9uzcqlRzDDNeFodAcq7WeDXH+IABY3xY66fjk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=brDjePnKtfbNmuqai/ECmd1dMI3EY86Z1ocd+81oT1AIcIQ7u8VfRlNkdZAoeYOXiOIKXIvK8KAzD6zpxgoSUhaCMGxdl2tvSNsuu45IYnxEl/XJhI7zOVrKjdcQHiOUVByxE+9vy8GiaBViGAL5ldxmru85vPhmM5I/YPVDsDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-87c0e531fc4so1435340539f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 14:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753826313; x=1754431113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DcDO4V4KRc215iriex9i8eYJYQg1FoSqnkmjhIQzXM=;
        b=vWY44FFtWcyzNGEGFsO9INCCPe3bpv74BWZNJ95r/d/wnqWzqZOrvJwY9B3VAj4MV7
         FJmynaty8IiGwfXWhiGpTHklidL5oYYIFUD5PhUDfbI7JIq66bYcLhPPXwQs/G48h5Zj
         plZ2VhZogFFUhUFZybpZufjMzPaYegdV6yUHrLtNplhvIpUi3gLs37tTTFCEx4/PcDt2
         8iVfjcKJIKsykLy1+4hiib0lI2fDOtDOSiOwW3SWgjIaSLAPjJ/SfH4fgjmOqBrTHGX1
         z/1OWzAAxQgJ6BIOGYpI6aNZ+Buw6SYh+mDq77LH2a3iu2qrl/0sUlOv/F/Z34fdLQVx
         LXcw==
X-Forwarded-Encrypted: i=1; AJvYcCVSFUVH9VBwpjSX3wEFhp1aj+BCrV1U7z4NYpVajWbGVxXK4icAOUic8Kxhc0Nje1S3GwMBo7LorOBf38pg@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpdbdhZAPkAmslFyY7JrL+nr8Dxf7K1QB3+qZF3N1HUyDw2he
	YstTvYdfDsiyBf8ipnifT9AloyRrN/xiCdI/GoTCfBuBnwqurENkPTVoirmashUtvHs2cF36824
	OpA6BHhfORm1AtWlKq3oF8gJOW4sN7VE6Asu1nskX6Dwy8RRVNsWLzruBylc=
X-Google-Smtp-Source: AGHT+IFjyuViMt8FcZdD77JfCWZH8Wa2HxqZ4ZaoIVgzAP4iwva2GhiwfyLeP/N67s+X6PF+Go1NLRdD3c1RCE8n6tD0E9Lgtcsq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:3e2:a12c:9c56 with SMTP id
 e9e14a558f8ab-3e3f5d8e0admr16177205ab.0.1753826312706; Tue, 29 Jul 2025
 14:58:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:58:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68894408.a00a0220.26d0e1.0012.GAE@google.com>
Subject: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works
From: syzbot <syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com>
To: andrew.cooper3@citrix.com, bp@alien8.de, brgerst@gmail.com, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, miklos@szeredi.hu, 
	mingo@redhat.com, peterz@infradead.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org, 
	xni@redhat.com, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ced1b9e0392d Merge tag 'ata-6.17-rc1' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c89782580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d51af648924b64c9
dashboard link: https://syzkaller.appspot.com/bug?extid=9921e319bd6168140b40
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f7034580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165e44a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1495c1de592/disk-ced1b9e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/982f755305ce/vmlinux-ced1b9e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b17cd424f373/bzImage-ced1b9e0.xz

The issue was bisected to:

commit 9e59d609763f70a992a8f3808dabcce60f14eb5c
Author: Xiao Ni <xni@redhat.com>
Date:   Wed Jun 11 07:31:06 2025 +0000

    md: call del_gendisk in control path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ab54a2580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ab54a2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ab54a2580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com
Fixes: 9e59d609763f ("md: call del_gendisk in control path")

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 24 at lib/refcount.c:28 refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted 6.16.0-syzkaller-00857-gced1b9e0392d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: md_misc mddev_delayed_delete
RIP: 0010:refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Code: 00 83 e2 8b e8 b7 5b bf fc 90 0f 0b 90 90 eb d7 e8 bb 6d fb fc c6 05 09 32 c7 0a 01 90 48 c7 c7 60 83 e2 8b e8 97 5b bf fc 90 <0f> 0b 90 90 eb b7 e8 9b 6d fb fc c6 05 e6 31 c7 0a 01 90 48 c7 c7
RSP: 0018:ffffc900001e7a68 EFLAGS: 00010246
RAX: 3c6a9b38a742a100 RBX: 0000000000000003 RCX: ffff88801d298000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc900001e7c70 R08: ffff8880b8724293 R09: 1ffff110170e4852
R10: dffffc0000000000 R11: ffffed10170e4853 R12: ffff8880b8739700
R13: ffff88801d2ab218 R14: ffff8880331dc130 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125d07000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056071c71c048 CR3: 000000000df38000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
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

