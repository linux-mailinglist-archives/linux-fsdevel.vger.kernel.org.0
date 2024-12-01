Return-Path: <linux-fsdevel+bounces-36193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EAA9DF461
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 02:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABEA162E3C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 01:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE712E4A;
	Sun,  1 Dec 2024 01:58:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BFB665
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Dec 2024 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733018310; cv=none; b=hiBQOzvjIgt4tf6mbE4hmuNEZSjTCvW1ZHHfrJH7ls+57/4GHZdiZIFNBePh/fDPADp9UPOAJX8q1pCqoNJMXfrO6PlUBoIUX8O1wMDSxyN3Bln+gVhYdu2cQRlkdN5TLu10IKG3lawxhNjmrDhXQ5xoUpwKOWsm2DCiegIl0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733018310; c=relaxed/simple;
	bh=zTMhgQ7GAngkohf2rn/P/5vDYoYLNJENEFkhFPgmq4A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HHO08NngNIwNLy+fqgLi9qJpPUx/pAyUFG8i+jtJsdMcIZuZO4cottZ5XSlIu4eYhmgmSzERD3pwapw5Wzk5kKXZhiopbaHpbcNthSZVhOgSHroz7FQNGIXn7g6W17HvpadM/zgjUsjG6ELOeMgNuTUnKnT/8M/KiRHlUm2ZtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7ace5dd02so36873605ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 17:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733018307; x=1733623107;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oga6qmMks5KjnhwQMu5wVri17WghvBrofAMjw1HSmnU=;
        b=cUfCg/s3QV33ykgxEYQOzTSzwEt3LW7P1qLLlM2xmJxvISWXT+lI2zwuYzQmaNf2UL
         z+hwDGt7PNQjqIIX7xRwf+aQb/KK13TnefFkc+A0vqTYqpf+GHAPPJZta9ys+hNn9/pg
         v9QHRbfjZG0cfVbRxYuNvurc1uXDj6NYRRpgnEHMUqZFJg2cGnFLjS/cBSIm4dcvKbKp
         ufSsU+5cP4Hcf3xqnFgxoasBXoFOB8MXkTb4nWZ+IF9kd9x0Yr6yVyDRiq2iBfKV99aP
         Df/BEdlQZIdo+REybcKagFg0jSDTtTWWoUjEbFwoGiv5m9jkLsnb2BWG0AnXBiaDSj1m
         If4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtWT9ZiSG28+tF2qJ9N2j9OrXGgWq53YI0NB1BI/YAr1FqPwSVsNsBJd8oLZVi9dlzFrFRw1hpuvOl6YNX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7aNwGfwtjCDSVV4a5mXt6T7O7E/Z/bn2VEPSv9QY5O0U8TtB
	rMh50Su7Ksg1m9abAi/FiAGblqcDiE4TbAuBIA9SOjSGfqJdqBmkyR2KNDZ2VeGiDh83bI5nVWZ
	jx2AiP3EonwyMey2aHpF5ymsxfCIO+QciT1E4Q4XjDgYRJpDQ+fnqJLM=
X-Google-Smtp-Source: AGHT+IHYOe4T8vhtQp3j52u+dUjdYd/xgSjj8rXSIWax2fDqxyDbFB3caVq0f/UT5o8T5Gh3oOPm1b1CEkH8R2dTiQP+hC1QAVzp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a7:86ab:bebf with SMTP id
 e9e14a558f8ab-3a7c55d432dmr165626055ab.19.1733018306816; Sat, 30 Nov 2024
 17:58:26 -0800 (PST)
Date: Sat, 30 Nov 2024 17:58:26 -0800
In-Reply-To: <673ac3cd.050a0220.87769.001f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674bc2c2.050a0220.48a03.0002.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages
From: syzbot <syzbot+06023121b0153752a3d3@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11c905e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=06023121b0153752a3d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c905e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06023121b0153752a3d3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12 at fs/netfs/write_issue.c:583 netfs_writepages+0x8ff/0xb60 fs/netfs/write_issue.c:583
Modules linked in:
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-9p-3)
RIP: 0010:netfs_writepages+0x8ff/0xb60 fs/netfs/write_issue.c:583
Code: 10 4c 89 f2 48 8d 4c 24 70 e8 ad a6 85 ff 48 85 c0 0f 84 e6 00 00 00 48 89 c3 e8 cc dc 49 ff e9 4a fe ff ff e8 c2 dc 49 ff 90 <0f> 0b 90 e9 a9 fe ff ff e8 b4 dc 49 ff 4c 89 e7 be 08 00 00 00 e8
RSP: 0018:ffffc900001170c0 EFLAGS: 00010293
RAX: ffffffff8255983e RBX: 810f000000000000 RCX: ffff88801cac5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 810f000000000000
RBP: ffffc90000117190 R08: ffffffff825596e2 R09: 1ffff110043d34b5
R10: dffffc0000000000 R11: ffffed10043d34b6 R12: ffff888021e9a5d8
R13: dffffc0000000000 R14: ffffea0001784fc0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb76d7e4d58 CR3: 000000002fc7a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_writepages+0x35f/0x880 mm/page-writeback.c:2702
 __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x820/0x1360 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2047
 wb_writeback+0x427/0xb80 fs/fs-writeback.c:2158
 wb_check_background_flush fs/fs-writeback.c:2228 [inline]
 wb_do_writeback fs/fs-writeback.c:2316 [inline]
 wb_workfn+0xc4b/0x1080 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

