Return-Path: <linux-fsdevel+bounces-18609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC588BAC00
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26481C21AA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E091534E0;
	Fri,  3 May 2024 11:58:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245D1514E4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737506; cv=none; b=QylKjj/YiTAgZx0JOhyryXVrIaTQQNmbH7+IJmFMGxIUkZazW0l4afUR+g1TuOgNODGx4pD4f404wAK0DyhXwJ/umSfc1JjnGL+ghz8u9GWKadEiiXh+8FiKMkjo3cGqebSYR94FlBeY5d9U54RCPDbOrfAfDIwEjWJs5h5asfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737506; c=relaxed/simple;
	bh=YaifA61orL93F1z51xxGDPNVb/aBwr7JGokIH5e29SY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SaEeJyWWoi58YedWmGSyGPLLFQaA0q8BJDAJJWHLAhhAzZgFnUgQAglTqGCgz5R/Xa9IV+FGyQFaVCSY/iyWtQ+UQG0/4LtC50s88u5UcwcTVFZdYDMsKJGysBV8A7r8UJwDxCChi1G+ighAeWoRcQt99pvwM2Dr8HWXUlWvE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so944320839f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 04:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714737503; x=1715342303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOhPRJgVEitnomUm+1knlzOavziwEOygxrwj9usYCWU=;
        b=FGx5t9E+sOXioEbajNAXLLsRJQKfQv8z0CPFrLomnnoh7lM2rmMXyxMgQcYx8ZEh14
         sYdEJOZCMTgeIfTaDDWUT9kSsjBwPFFdGjJD0IyacGuJENjAV0Mg06OseKaEUmQRagJ7
         /y660XEJxA2cbT2DvEm2vsgZWkmvFHJXNfNby4iuAwRMz9YWysnm4bLaf2eSApa7RS3M
         A09uMlIP9vS44W1uXR9jXl9BDeDtUuxgPSMgQ4R0hO3MZYYW1JTRLHhTllPVWLvQ6k3g
         U5QF2/JXsxDuObx04I+J/ASYLIH2tKc4bZQ7qM9RMbyLLpesGQPOH0qdbFTKtC1NrNzM
         fbNw==
X-Forwarded-Encrypted: i=1; AJvYcCUz5bDW+GAFybMpks2SUBxgOnPv5dA2ZahFKRyZ8WyZ6or63vLLnDm1GEREKpj3dnPGwn1VZcy5H0zW1N7XYmO0ABOTcQfAzCTRjrcuTQ==
X-Gm-Message-State: AOJu0Yzjmgjh+kibYjYmBAlI0atzZwtCWjAOgnw0ZF7lf4mHqv+S+PV+
	biHNnzgerOh0yOyIrnrLLm3zBHxdkHLVALZq1yB5UosFHCK9kSsqYM+lLturHf4iITxzxUsg2tC
	KLNBW8061oZMQCguNspJvFQnb+voNCeti334kJJiRNsKRLAd/tY8/A1Y=
X-Google-Smtp-Source: AGHT+IHMxlg4LR0Y29EJqqi3eoweYexP6RgQEfebTgHVsVzOhdGsRLogeDIf/2LIdRIUaNyfpSp79eneZEQi7HCh5IBZ5muqC19g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c03:b0:7da:19cb:1c7f with SMTP id
 w3-20020a0566022c0300b007da19cb1c7fmr108039iov.0.1714737503279; Fri, 03 May
 2024 04:58:23 -0700 (PDT)
Date: Fri, 03 May 2024 04:58:23 -0700
In-Reply-To: <0000000000009d99ed06178b29b5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4312c06178b6f62@google.com>
Subject: Re: [syzbot] [bcachefs?] BUG: unable to handle kernel paging request
 in bch2_fs_btree_key_cache_exit
From: syzbot <syzbot+a35cdb62ec34d44fb062@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6a71d2909427 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=157bb450980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
dashboard link: https://syzkaller.appspot.com/bug?extid=a35cdb62ec34d44fb062
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124d68a7180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c77d21fa1405/disk-6a71d290.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/429fcd369816/vmlinux-6a71d290.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3d8a4b85112/Image-6a71d290.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5eb4d59a9b9e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a35cdb62ec34d44fb062@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
workqueue: Failed to create a rescuer kthread for wq "bcachefs": -EINTR
bcachefs (1e246536-b1b3-4f86-83c2-3dfcc2979a4c): shutdown complete
Unable to handle kernel paging request at virtual address ffff7000249ff210
KASAN: probably wild-memory-access in range [0xffff800124ff9080-0xffff800124ff9087]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001ad5bd000
[ffff7000249ff210] pgd=0000000000000000, p4d=000000023e882003, pud=000000023e880003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6351 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80401005 (Nzcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : bch2_fs_btree_key_cache_exit+0x7ec/0xfcc fs/bcachefs/btree_key_cache.c:974
lr : bch2_fs_btree_key_cache_exit+0x78c/0xfcc fs/bcachefs/btree_key_cache.c:970
sp : ffff8000a19f6e80
x29: ffff8000a19f6f50 x28: 1fffe0001df60010
 x27: ffff0000efb044b0
x26: 1ffff0001433ede0 x25: dfff800000000000 x24: 1ffff0001168e5d4
x23: 0000000000000000 x22: ffff800124ff9080 x21: ffff8000a19f6f00
x20: ffff80008ee81218
 x19: dfff800000000000 x18: ffff8000a19f6960
x17: 0000000000017999 x16: ffff8000802896e4 x15: 0000000000000001
x14: 1fffe0001df60898 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001df60899 x10: 0000000000ff0100 x9 : 0000000000000003
x8 : 1ffff000249ff210 x7 : ffff80008275d4e8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008275d4f8
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000008
Call trace:
 bch2_fs_btree_key_cache_exit+0x7ec/0xfcc fs/bcachefs/btree_key_cache.c:974
 __bch2_fs_free fs/bcachefs/super.c:562 [inline]
 bch2_fs_release+0x1e0/0x564 fs/bcachefs/super.c:609
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2a8/0x41c lib/kobject.c:737
 bch2_fs_free+0x288/0x2f0 fs/bcachefs/super.c:674
 bch2_fs_alloc+0xe4c/0x1c60 fs/bcachefs/super.c:965
 bch2_fs_open+0x740/0xb64 fs/bcachefs/super.c:2080
 bch2_mount+0x558/0xe10 fs/bcachefs/fs.c:1900
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
 vfs_get_tree+0x90/0x288 fs/super.c:1779
 do_new_mount+0x278/0x900 fs/namespace.c:3352
 path_mount+0x590/0xe04 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3875
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: f90027e8 d343fec8 11000d29 f9002be8 (38f36908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f90027e8 	str	x8, [sp, #72]
   4:	d343fec8 	lsr	x8, x22, #3
   8:	11000d29 	add	w9, w9, #0x3
   c:	f9002be8 	str	x8, [sp, #80]
* 10:	38f36908 	ldrsb	w8, [x8, x19] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

