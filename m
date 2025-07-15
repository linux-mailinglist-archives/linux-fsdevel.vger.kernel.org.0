Return-Path: <linux-fsdevel+bounces-54959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78ABB05AE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8060F172BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B512E1C58;
	Tue, 15 Jul 2025 13:09:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27353145355
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584966; cv=none; b=Q2LPYaGL1YYOwcPcgH9q7hxrj/gYCyAkVY/JfCXoIhe1DhT2cGFN6DV7YbRZaD+R/HOGxrdiQcIuodQz9/Kdmxg5CS6IGewowEr5riGaUFDq7z9b7Rh58qYYRbrobolKGVT/BaxxCnunksSYXP4N8cXJRr9zN14CJd+OY4HMNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584966; c=relaxed/simple;
	bh=djF+zPGKM8JtGU9a35ywnIIaA/Y7bfws5UsdU90/5YE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ivKRacpAoeeH7pg/eNdDiuAPvFjsofRreHM9fkhFWKZp5LhoO25tCPi+YaFv2kmppqZM3xMdSOsVfIQr3DlAxg+EGZDGucOYb8zUnR32w4eNkAVuUeJjRTFhm6nt+9PMbJlja6arbV+FbNxDoZRIP8MWwJ2REKUGuOBAtGu0DQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so561541239f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752584964; x=1753189764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7lMbOmndqVY+BYfCySLtcIi0O/Fdj4Vy8dOUynDUIU=;
        b=LUz8f5i0CcdI955oJa7o/yTolMxFBuzhhbM5IRqhuy/L2SZW4CJ8iB67XO8JKQTfiI
         VfTlVFCpSZO6RCvNJofjVZMiS368MvFeCYU0C6URZxCc9a68F6MEuKpAM0Y0XFIh10sW
         jfNu1cTpWZ8Dvt1Rbsj6O7YKrDaT8lKk06nGuS36NZ6ULbcz1KWna6/2K+oLwJEWoXd1
         FTqDZ+KbhrCItYp9c5mHv77E2hdI9grzxNkTdnPR0JKDTwfItgglddutCwyUDBiZG9Px
         PD0PiL8KHqUSsocxJWDluJPeCzgqvFsP5Of5D/GuEROvb+5FhxGr7AHq0n4/7V2gwBPT
         SIRg==
X-Forwarded-Encrypted: i=1; AJvYcCXRDmj7CQ62XfJO511CPz8KfyAy9DRO/b18iAMBbC/hvQpm+jheXXSGmIFy+1z63gBQN6vcLcaGFgxsPwe1@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZoQYPtuodgrnzGXDXPkAChUC+u16Sw915JqEz6zOZlSuRtq2
	+iBQEUUs2WxPxGGpFrOHOD9Mrve/SyTH3yxZ9WrWJmHTmpHMRm29eWg/UB/jidaIIQTHjm61AoX
	PdE/Bfccqm7Mk0QvH8KpFoG/E2bAgYYDxOO9XTz/uF1mbgLh90xLB841FE+w=
X-Google-Smtp-Source: AGHT+IHSqmd2FLGYLv1ftVR+Y4fO+Xrf5bszMEVgqnFkxLVVr7F2ULal8RMS/drct7yUa684W0t4mErpITqHtQAJfBNN9UCsfBjp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60c3:b0:879:674e:2c73 with SMTP id
 ca18e2360f4ac-87977f54b53mr2031258339f.4.1752584964207; Tue, 15 Jul 2025
 06:09:24 -0700 (PDT)
Date: Tue, 15 Jul 2025 06:09:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68765304.a00a0220.105e77.0000.GAE@google.com>
Subject: [syzbot] [bcachefs?] [squashfs?] INFO: task hung in
 truncate_inode_pages_final (2)
From: syzbot <syzbot+760777ae7038cad77437@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ec4801305969 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1323ba8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=760777ae7038cad77437
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d38d82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130ba0f0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64d8dc107d9d/disk-ec480130.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/31280b2dee28/vmlinux-ec480130.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b3f9fb3d09f8/Image-ec480130.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9b3f4e51e5f9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+760777ae7038cad77437@syzkaller.appspotmail.com

INFO: task syz-executor:6656 blocked for more than 143
INFO: task syz-executor:6656 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc5-syzkaller-gec4801305969 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:6656  tgid:6656  ppid:1      task_flags:0x400140 flags:0x00000019
Call trace:
 __switch_to+0x414/0x834 arch/arm64/kernel/process.c:742 (T)
 context_switch kernel/sched/core.c:5401 [inline]
 __schedule+0x1414/0x2a28 kernel/sched/core.c:6790
 __schedule_loop kernel/sched/core.c:6868 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:6883
 io_schedule+0x84/0xf0 kernel/sched/core.c:7728
 folio_wait_bit_common+0x56c/0x9e0 mm/filemap.c:1317
 __folio_lock mm/filemap.c:1675 [inline]
 folio_lock include/linux/pagemap.h:1114 [inline]
 __filemap_get_folio+0x1ec/0xc38 mm/filemap.c:1928
 truncate_inode_pages_range+0x38c/0xe18 mm/truncate.c:388
 truncate_inode_pages mm/truncate.c:460 [inline]
 truncate_inode_pages_final+0x8c/0xbc mm/truncate.c:495
 evict+0x420/0x928 fs/inode.c:812
 dispose_list fs/inode.c:852 [inline]
 evict_inodes+0x650/0x6e8 fs/inode.c:906
 generic_shutdown_super+0xa0/0x2b8 fs/super.c:628
 kill_block_super+0x44/0x90 fs/super.c:1755
 deactivate_locked_super+0xc4/0x12c fs/super.c:474
 deactivate_super+0xe0/0x100 fs/super.c:507
 cleanup_mnt+0x31c/0x3ac fs/namespace.c:1417
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1424
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x174/0x1f4 arch/arm64/kernel/entry-common.c:155
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:173 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:182 [inline]
 el0_svc+0xb8/0x180 arch/arm64/kernel/entry-common.c:880
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Showing all locks held in the system:
3 locks held by kworker/u8:1/14:
1 lock held by khungtaskd/32:
 #0: ffff80008f8599c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:330
2 locks held by pr/ttyAMA0/43:
2 locks held by getty/6289:
 #0: ffff0000d314d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80009ba2e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x34c/0xfa4 drivers/tty/n_tty.c:2222
1 lock held by syz-executor/6656:
 #0: ffff0000c8c7e0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000c8c7e0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000c8c7e0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506
1 lock held by syz-executor/6739:
 #0: ffff0000dbe180e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000dbe180e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000dbe180e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506
1 lock held by syz-executor/6760:
 #0: ffff0000c90c20e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000c90c20e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000c90c20e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506
1 lock held by syz-executor/6787:
 #0: ffff0000d3e2a0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000d3e2a0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000d3e2a0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506
1 lock held by syz-executor/6808:
 #0: ffff0000d89180e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000d89180e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000d89180e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506
1 lock held by syz-executor/6839:
 #0: ffff0000f2aba0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000f2aba0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000f2aba0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506
1 lock held by syz-executor/6876:
 #0: ffff0000dd8f40e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000dd8f40e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000dd8f40e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506
1 lock held by syz-executor/6909:
 #0: ffff0000eac320e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000eac320e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000eac320e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506
1 lock held by syz-executor/6942:
 #0: ffff0000d65fa0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock fs/super.c:57 [inline]
 #0: ffff0000d65fa0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: __super_lock_excl fs/super.c:72 [inline]
 #0: ffff0000d65fa0e0 (&type->s_umount_key#54){+.+.}-{4:4}, at: deactivate_super+0xd8/0x100 fs/super.c:506

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

