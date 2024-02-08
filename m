Return-Path: <linux-fsdevel+bounces-10764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1784DD71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC7BB2628A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105036DCFA;
	Thu,  8 Feb 2024 09:57:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F986BFDD
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386249; cv=none; b=jURfEFh4VElsrClrKdcEtxV0yeRVEmJHkKEUVaIn2T+PlZaLATR/A3Sw7Z1TSo8I4vUwjhNTSsLmMghV4abTI81poi858OeFSAveaHrSoLXc3zY/5T/945iUipPrGzIUN5SlYZAZv+NOdD9gZfjWvhqTOs0tKAR47l2UMx3gk3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386249; c=relaxed/simple;
	bh=GZQm9k+2KIiJpFa40c50yg1S0Zbr9J8gDjOrxG59aac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c7LeLp46m7pThJMuYgdh38SznG3eYnXpzNL++fWc135rIb83K79TZAlQGPfmnvvRGCeMFiO9NMuZPr3O0G0su3ChXDx0WeyPMWoos0jAQdpXDHp2YnWk1ZAg+2Z4U6aSgWsr3h3CdkpZIuHAiHXTcsw//EewAiA+/I2b5+1D2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c0257e507cso114596139f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 01:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386247; x=1707991047;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8XFTO75xgUrB2vWN4Y9hBFYrzzs3sXtmx8tafiVzfo=;
        b=VZ4eetoLZdeK24YrbEnom9j/TYrMOBXiEoKEFFsoevSRquMst/ZEKDs6IH+BCFZptX
         JiWnpEcLaPy6CkPoHhKD1fgdRrbO5DBHBymDzYkl3i0F7/wsWklcfVs7JdhgICKZzSs5
         kVNE6QLd9IK7QcBWZF3i8bnlU7yEj4/s03HydizUmr1wwBizJy32I7yL+IgjxsMxeLTe
         axAaLQkUJcpsk1PY6R9TOwEuML7xyBn06vYWtq4eZM681F8QibsmgowkSEaZuHDv5+wo
         NSH0Ze18OT/D3g2b9NICzv3FhkGSNoJ2YWaycHobTs3OZQZRNGpNorQArwpC9L1xHUg1
         LFrA==
X-Gm-Message-State: AOJu0YznSsoe5k5SWqe5ZnllYXPO29eT9zryGUnXjzDrJSHgkcOgt/rM
	D19GQp0FmAuruB3gHV8T0+GukIOprfdXtJEnlWra79y8G+6eoNDfuTnQJZMxb6Cu6O3xJYYUMD6
	RK4K2mYEsS1UqCBmP9S3Z2GYclcbpARHGqftPLcG/jt5ZIuyobTwGNME=
X-Google-Smtp-Source: AGHT+IEQBlp/80fFSHsrYZLa9DIYSuilJkzHmyv28Ert07IH2UTRsnj0E7/GH6nK8PE6SxqJe9MLGbiwYlOMEKok3UAcduRonz0E
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1347:b0:471:2aee:54fb with SMTP id
 u7-20020a056638134700b004712aee54fbmr291477jad.3.1707386247088; Thu, 08 Feb
 2024 01:57:27 -0800 (PST)
Date: Thu, 08 Feb 2024 01:57:27 -0800
In-Reply-To: <0000000000001e48350610dbc5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c091060610dbd67b@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_rindex_update
From: syzbot <syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    547ab8fc4cb0 Merge tag 'loongarch-fixes-6.8-2' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150285d4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=74edb1a3ea8f1c65a086
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11395147e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ff68fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a8d318be4c39/disk-547ab8fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8178462cbfb5/vmlinux-547ab8fc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62939e7c5fbb/bzImage-547ab8fc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/93eefe621564/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 20 extents in 0ms
general protection fault, probably for non-canonical address 0xdffffc0000000097: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000004b8-0x00000000000004bf]
CPU: 0 PID: 5058 Comm: syz-executor337 Not tainted 6.8.0-rc3-syzkaller-00041-g547ab8fc4cb0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:gfs2_rindex_update+0xbc/0x3d0 fs/gfs2/rgrp.c:1037
Code: e8 f9 65 1d fe 4c 8d 74 24 60 48 8b 03 48 89 44 24 38 48 8d 98 b8 04 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c6 65 1d fe 48 8b 03 48 89 44 24 20
RSP: 0018:ffffc900040671a0 EFLAGS: 00010202
RAX: 0000000000000097 RBX: 00000000000004b8 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807f558000
RBP: ffffc900040672b0 R08: ffffffff83cb50d7 R09: 1ffff1100f02e2f8
R10: dffffc0000000000 R11: ffffed100f02e2f9 R12: 1ffff9200080ce3c
R13: ffff88807f558000 R14: ffffc90004067200 R15: 0000000000000001
FS:  0000555555a0f380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056427a53bb08 CR3: 0000000022d54000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 punch_hole+0xe7b/0x3a30 fs/gfs2/bmap.c:1809
 gfs2_truncatei_resume+0x3c/0x70 fs/gfs2/bmap.c:2159
 gfs2_glock_holder_ready fs/gfs2/glock.c:1336 [inline]
 gfs2_glock_wait+0x1df/0x2b0 fs/gfs2/glock.c:1356
 gfs2_glock_nq_init fs/gfs2/glock.h:238 [inline]
 init_statfs fs/gfs2/ops_fstype.c:694 [inline]
 init_journal+0x1680/0x23f0 fs/gfs2/ops_fstype.c:816
 init_inodes+0xdc/0x320 fs/gfs2/ops_fstype.c:884
 gfs2_fill_super+0x1edb/0x26c0 fs/gfs2/ops_fstype.c:1263
 get_tree_bdev+0x3f7/0x570 fs/super.c:1619
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0x90/0x2a0 fs/super.c:1784
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fe98b1e18ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3b0f9eb8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe3b0f9ec0 RCX: 00007fe98b1e18ba
RDX: 0000000020000040 RSI: 0000000020000100 RDI: 00007ffe3b0f9ec0
RBP: 0000000000000004 R08: 00007ffe3b0f9f00 R09: 0000000000012783
R10: 0000000000008c1b R11: 0000000000000282 R12: 00007ffe3b0f9f00
R13: 0000000000000003 R14: 0000000001000000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_rindex_update+0xbc/0x3d0 fs/gfs2/rgrp.c:1037
Code: e8 f9 65 1d fe 4c 8d 74 24 60 48 8b 03 48 89 44 24 38 48 8d 98 b8 04 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 c6 65 1d fe 48 8b 03 48 89 44 24 20
RSP: 0018:ffffc900040671a0 EFLAGS: 00010202
RAX: 0000000000000097 RBX: 00000000000004b8 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807f558000
RBP: ffffc900040672b0 R08: ffffffff83cb50d7 R09: 1ffff1100f02e2f8
R10: dffffc0000000000 R11: ffffed100f02e2f9 R12: 1ffff9200080ce3c
R13: ffff88807f558000 R14: ffffc90004067200 R15: 0000000000000001
FS:  0000555555a0f380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056427a53bb08 CR3: 0000000022d54000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 f9 65 1d fe       	call   0xfe1d65fe
   5:	4c 8d 74 24 60       	lea    0x60(%rsp),%r14
   a:	48 8b 03             	mov    (%rbx),%rax
   d:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  12:	48 8d 98 b8 04 00 00 	lea    0x4b8(%rax),%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 c6 65 1d fe       	call   0xfe1d65fe
  38:	48 8b 03             	mov    (%rbx),%rax
  3b:	48 89 44 24 20       	mov    %rax,0x20(%rsp)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

