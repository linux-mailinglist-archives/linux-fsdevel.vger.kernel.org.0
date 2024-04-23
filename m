Return-Path: <linux-fsdevel+bounces-17553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93248AFBAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F841F23EBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996F143C48;
	Tue, 23 Apr 2024 22:25:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D285274
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911131; cv=none; b=D6CiZf5qV2X2ISvwMtBUHB1eFdulBCdy/9EGPB07tBM2CWdIY1euuBUOnt0WdXG44QYLtR5PCDIj4mVfpdjA7HU44BY2V2La/fcC0nAyb21iHqOTzteDZFQITiB5MrxJE/PX9CNdJkn40zIzU4c7zcoxdHLV8EBJYvSjDf5EWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911131; c=relaxed/simple;
	bh=5NKc+KzJv4XeC9iiJoL21wYs9nyIBRjvAj5KvZ1W4A4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cWDslsz6kWDCizeAQN7hndwJmmiFtdKW7Cg1rd5A+I80ovTOnYNIu2bL1YVMZjjg4tf6flQyy5Y/4APsd36TVL7r/hwlLN9q4DQPKvxIO5j/vUxIn0WwIPs9aL4XMbow4UraORBASTK4easRotOH9V1rrFKCuu5uNvlBEcN/wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso812626839f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 15:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713911129; x=1714515929;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sedmCRB2uj77q0fSKeZqXQWSbzSs2fuWMeWh1CFXBaM=;
        b=FllNHA0eAUwzbdOngBuEWsfcMdqmiPyuDXnSz+/GQxEynxVmYBoyLjP6x5/XbsPZy7
         DIYKimeJo49mp8rsSQky6viF7aAibu3BH3h3APrL876y4BMErBJI//4mrT3epuVuiTv+
         S++G5JxpqUhDyHOR6J6e1FGxZrL6jWvolvzDn7XnCEku17tOHAztPieswGcAjGWMh9GI
         FHKb4BoH8o2ZXzfM5H4P660HZmOas0rKqL4QeqvwF5U9NzRzmxyYcWulCAgcjeW9O7a4
         SpdQM4b0DMF5mqrn6ETf47ErXpx0zPoTT/DyiJGGQXazgHo+AJoTjCkTEDWWB5bEov4M
         z8dA==
X-Forwarded-Encrypted: i=1; AJvYcCUBXA3kcEui1c266p3A1vOsdyA9hoPELhTx5RY712pnYm9Q6D2knQ5sajUN77EVbawaw8hnaj7vS4Qaw20hQxJbe3/0VFow9IL7yWR4jQ==
X-Gm-Message-State: AOJu0YxsQOWQBD0srwLEYnBv58B0mEGn7rHrlGl/DyBmWbdAemZ4aOfm
	Gad8jixeBPCzc69lOmy7tQyvnRXZ0fVcfbNi+m1fETtkPWyU5dklDKtetrh3hmGoBj5g5wo2x1v
	d3ZuB4chGKAY8+rodYHTp2j0kU3UUE/Qn3vIXCM43c0Xpk4NdsbSTBJs=
X-Google-Smtp-Source: AGHT+IE67aMdA0tSXgLd6wNUNc5Qs/GVAVjjQKKTFh1BI8qt4IDBG2m2u4C2yNjHtD6EgyroMTQPGZidXRrviYu5qquW6nUdqssa
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:840a:b0:482:e78a:899c with SMTP id
 iq10-20020a056638840a00b00482e78a899cmr72874jab.3.1713911129199; Tue, 23 Apr
 2024 15:25:29 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:25:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000866ea0616cb082c@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
From: syzbot <syzbot+241c815bda521982cb49@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=115a2547180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f47e5e015c177e57
dashboard link: https://syzkaller.appspot.com/bug?extid=241c815bda521982cb49
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109bb8f7180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e54bab180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4befd8e98bed/disk-3cdb4559.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efc09f95602f/vmlinux-3cdb4559.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29a54be03694/bzImage-3cdb4559.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/784deb2bb8a2/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14dc8b53180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16dc8b53180000
console output: https://syzkaller.appspot.com/x/log.txt?x=12dc8b53180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:886:2
index 524288 is out of range for type 'struct mutex[128]'
CPU: 1 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 PID: 111 Comm: jfsCommit Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 panic+0x349/0x860 kernel/panic.c:348
 check_panic_on_warn+0x86/0xb0 kernel/panic.c:241
 ubsan_epilogue lib/ubsan.c:222 [inline]
 __ubsan_handle_out_of_bounds+0x141/0x150 lib/ubsan.c:415
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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

