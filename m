Return-Path: <linux-fsdevel+bounces-13739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377D6873529
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E823328C4E5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28C77F3C;
	Wed,  6 Mar 2024 10:57:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BF77A18
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722641; cv=none; b=mrp7jb11SYi9eFKrMDOv3FJIPkwm32GQXK/hpiANLVSKTCt5M4hc/ZJFW6d2qcRT8WrUzBwq8XmlQr2Wk+zJvmSzqCqYyp+/mNfqmDwm0hwpf8u0nGNmGZBS6AKfyKGHPZLatQApQMNSZu35E9mNGE8A87Ub5FK4A+opkv5tSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722641; c=relaxed/simple;
	bh=NcwDt28WD1YEa1pUSgc8ylFJjluAMhWyX8PCK+tuF6k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OBy5gE+QyN2Gek1oqY/1bpSIkhDJN98C24nb4Vo0sGzPNe2FI4Q6kk+TmTmU14rRVm3m0PuV9lznLRUxNdeDWcqJwdLkfY7Ih4O5sBcUlxL3jtpZBdUdFIO8ibCZRkHLFUoL+JjsUAaDbd6RZ15m7KhigqTYH4qBXMUec/mvF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c846da7ad2so88274139f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 02:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722639; x=1710327439;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qXxCetncWmf0GqFMx7p5lJmRGpeOCkuynw+Qj5Z8c0=;
        b=c/XlJ76D3UBmBdp0QktoQaBRsEFs6ZUIlzcrkalPlVajODM4n7jtAHmMm0tj4V7RIo
         fmdzBlqD0r6dUmBNAGed/zsTyj43YcMwDwlZX763hjgwg8UKUwifu2EONEOgcVe5dqbq
         tySFYeGv8M+jZIx3IPj3v892e3qr+5nZPd+UDWiNfXoTaunrGfu93vC9FOv4Rhs67AcW
         ryGn2LuEG5GQID5SIdq6CWWvuO7t8ZjAKVrKUID20bQSCE0Jyb+/diEcpfS+xBwZuWhX
         QKG/lbgJOMgwWccNswWnjBFzXVbZKYAJI7Iz7ANMvhaWhU9YKF8gjq9mVa/xaanU2nkL
         Ok5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTCCeeYd6GUaIYWN2Mil6n/mVOhHs6XZKCszukWYot2KLJLeGqMz+0MZ228XOghSqPbCSFiYMoLqk2ItYCuHPG0nDLCQkt/k8KUR05Lg==
X-Gm-Message-State: AOJu0YxzposITqUKqucWVEmt+3Ki41q/IbuBAzmbKdnDtseIZUfOBb4W
	bKxaWZB3LNK77281Nen4H90Clq3ViUnNgN7n6jET96j08IG3bEZGYga7Bh88mUO5oJjvvtqCIsm
	xUOOWELYJ3vh3w4Cnvd11k8k+zuMGqLZBaAx3qc29oBh4IpHrbpKe7AA=
X-Google-Smtp-Source: AGHT+IH6YLEGFgRiGIyEjvD7BFJjeOW+RjgB6wkTjfNiPoIvfnN6/JBkaHbXIRzGSOOU+E5tyT9m6Q7Yz4Hx6VF9w13dlbTQP5tN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3784:b0:474:d7bf:64ed with SMTP id
 w4-20020a056638378400b00474d7bf64edmr706584jal.6.1709722639017; Wed, 06 Mar
 2024 02:57:19 -0800 (PST)
Date: Wed, 06 Mar 2024 02:57:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009033c40612fbd20f@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in __get_metapage (2)
From: syzbot <syzbot+72feb48a17265d9bf496@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9910665503b3 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12413316180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2402d46ab3c7e581
dashboard link: https://syzkaller.appspot.com/bug?extid=72feb48a17265d9bf496
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129fb526180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c40bba180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16059f53446c/disk-99106655.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7fc6c7c495d5/vmlinux-99106655.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8b0ce53ea33/Image-99106655.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1d3700eeba9f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72feb48a17265d9bf496@syzkaller.appspotmail.com

INFO: task jfsCommit:94 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc6-syzkaller-g9910665503b3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jfsCommit       state:D stack:0     pid:94    tgid:94    ppid:2      flags:0x00000008
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 io_schedule+0x8c/0x12c kernel/sched/core.c:9023
 __lock_metapage+0x1cc/0x458 fs/jfs/jfs_metapage.c:50
 lock_metapage fs/jfs/jfs_metapage.c:64 [inline]
 __get_metapage+0x96c/0x1050 fs/jfs/jfs_metapage.c:639
 diIAGRead+0xe4/0x14c fs/jfs/jfs_imap.c:2669
 diFree+0x800/0x2648 fs/jfs/jfs_imap.c:956
 jfs_evict_inode+0x2d0/0x3f4 fs/jfs/inode.c:156
 evict+0x260/0x68c fs/inode.c:665
 iput_final fs/inode.c:1739 [inline]
 iput+0x734/0x818 fs/inode.c:1765
 txUpdateMap+0x73c/0x8e4 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x3a4/0x98c fs/jfs/jfs_txnmgr.c:2733
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffff80008ee73f40 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:297
2 locks held by jfsCommit/94:
 #0: ffff0000d8558920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diFree+0x2cc/0x2648 fs/jfs/jfs_imap.c:886
 #1: ffff0000ddd3a638 (&jfs_ip->rdwrlock/1){.+.+}-{3:3}, at: diFree+0x2e0/0x2648 fs/jfs/jfs_imap.c:891
2 locks held by getty/5932:
 #0: ffff0000d35540a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800094f722f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x41c/0x1228 drivers/tty/n_tty.c:2201
3 locks held by syz-executor149/7710:

=============================================



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

