Return-Path: <linux-fsdevel+bounces-58134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B335B29E34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA8C3B8E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11930EF9D;
	Mon, 18 Aug 2025 09:42:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CAE30EF79
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510151; cv=none; b=SyGRBvmzwQ9RnAERndOLiiP2BF63reLKvBdWhlhnvP3x80aPSPqhcTbKDnK71oeVxdZf61RU3JFdCEC69+69e33tClCtpeC835mGbf9ukDE0q2G6O+DL+z9sj+ikckB0FmGyVnzpjcxBudW5y/8wrkEnsb8RxbLLdvMDsmA38nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510151; c=relaxed/simple;
	bh=hlExk0bikRjt6rm84KLuXCDdZhI56FTm0T0tv3xFJDI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cN3J0MsNq26lmJCgKgpvCT14whm1PexET50/kzsqO9bzpMDouWNPQ2bFhv7g9tSqAwtyLYU/pEZbqRiPjqohNIp6MXXBIh1iFRkNKxdNXn3ceDhZQbg1pcVps3Uw/mXIyIZwBbk9JRyoyppy8VnPV56NXybKriXSzSzOUmwuiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88432cb7627so401548639f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 02:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510148; x=1756114948;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wGHxTryICtLob43ykIoK53i3l3ypoaoPwteFMzyRHA=;
        b=It35Dg5o3/qnDCw2OSAC3jqWc6Jm6ostAOLDgK/XrTUYldb0KS478Oc0T/cGGvONG+
         YK0pzZhCqu3Uf6YXnPxc31PAO2xBOpwcP5WbDOZ+1PL9jXShi9Pm5J0u1iHbXbD0hXTu
         9Z+WSCAeZQdi7Q5PAgeqAMfvCeapO085sXBM+3hArrpk3PLbZ0b0QHmOAYH1TVRyYsGp
         7rejSfd/Lp0z7WXnwwM6ZBsJ2MmOpr4k0hY5eZJDyrw8ojAsGGjMpNBgiTzZqZTpYOzk
         0UZXDlm/9emTFkuvlg/Lzy/syOETcMwC8yrhYdt/LzAy7R3gWhFmg+gN/PCl2VjiTicH
         zauw==
X-Forwarded-Encrypted: i=1; AJvYcCV1tVSosh0M+cWpBN75zGD8xevRKUb6GKjuSWeU48VNMJAYXnt8JS77u3SOryix5AD7M7k4RLlxjrouZxxx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6uG55vNstbJfRrLECoMHN4+FOxlOtuhqbcNhJ8sf7lFfZD5D4
	ML0oQ3CNopVbGLKR7CBzB1daxlyuI4Xq1p65Ynpl8O3NYECNOpcKyQdNlczMQsJcErvtZV8q2k7
	sR0dSNCL1VrRp0OToAKMA7SVh/uGRV4vD0ZI4i8SPCxI7FLgV160ez4f3K6o=
X-Google-Smtp-Source: AGHT+IEy+DhZF0kVCFcwYxkEZCvaNAN8vkbPi0qS1D0Zb3xGehBLux0c/k5Qeuv219SQUXlqM/N0D3HZuKAkgonfrZqKlOKyUmIL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60c5:b0:87c:1d65:3aeb with SMTP id
 ca18e2360f4ac-8843e35ceebmr2227386839f.2.1755510148497; Mon, 18 Aug 2025
 02:42:28 -0700 (PDT)
Date: Mon, 18 Aug 2025 02:42:28 -0700
In-Reply-To: <67555b72.050a0220.2477f.0026.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2f584.050a0220.e29e5.009d.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
From: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	haoluo@google.com, jack@suse.cz, jiri@resnulli.us, john.fastabend@gmail.com, 
	jolsa@kernel.org, kerneljasonxing@gmail.com, kpsingh@kernel.org, 
	kuba@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1321eba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cba442580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a1eba2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/43186d9e448c/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=174ba442580000)

The issue was bisected to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1066f9f8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1266f9f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1466f9f8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [syz-executor:6662]
Modules linked in:
irq event stamp: 355416
hardirqs last  enabled at (355415): [<ffff80008b00487c>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:86 [inline]
hardirqs last  enabled at (355415): [<ffff80008b00487c>] exit_to_kernel_mode+0xc0/0xf0 arch/arm64/kernel/entry-common.c:96
hardirqs last disabled at (355416): [<ffff80008b001cbc>] __el1_irq arch/arm64/kernel/entry-common.c:650 [inline]
hardirqs last disabled at (355416): [<ffff80008b001cbc>] el1_interrupt+0x24/0x54 arch/arm64/kernel/entry-common.c:668
softirqs last  enabled at (355404): [<ffff8000803d88a0>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (355404): [<ffff8000803d88a0>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (355387): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
CPU: 1 UID: 0 PID: 6662 Comm: syz-executor Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : propagation_source fs/pnode.c:77 [inline]
pc : change_mnt_propagation+0xec/0x77c fs/pnode.c:114
lr : propagation_source fs/pnode.c:78 [inline]
lr : change_mnt_propagation+0x120/0x77c fs/pnode.c:114
sp : ffff8000a4a07a90
x29: ffff8000a4a07ac0 x28: dfff800000000000 x27: ffff0000efa88b60
x26: ffff0000efa88bb0 x25: 1fffe0001df51176 x24: ffff0000efa88b18
x23: ffff0000f331b238 x22: ffff0000efa88a80 x21: ffff0000efa88a80
x20: 0000000000040000 x19: ffff0000f3339500 x18: 1fffe000337a0688
x17: ffff80008f7be000 x16: ffff80008af6de48 x15: 0000000000000002
x14: 1fffe0001df5116f x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001df51171 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000f33395b8 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : 0000000000000000
x2 : 0000000000000008 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 next_peer fs/pnode.c:19 [inline] (P)
 propagation_source fs/pnode.c:77 [inline] (P)
 change_mnt_propagation+0xec/0x77c fs/pnode.c:114 (P)
 umount_tree+0x7e4/0xbbc fs/namespace.c:1872
 do_umount fs/namespace.c:-1 [inline]
 path_umount+0x90c/0x980 fs/namespace.c:2095
 ksys_umount fs/namespace.c:2118 [inline]
 __do_sys_umount fs/namespace.c:2123 [inline]
 __se_sys_umount fs/namespace.c:2121 [inline]
 __arm64_sys_umount+0x128/0x174 fs/namespace.c:2121
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6746 Comm: syz-executor Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : cpu_relax arch/arm64/include/asm/vdso/processor.h:12 [inline]
pc : path_init+0xdc0/0xe98 fs/namei.c:2537
lr : path_init+0xdc0/0xe98 fs/namei.c:2537
sp : ffff8000a4247680
x29: ffff8000a42476e0 x28: dfff800000000000 x27: 1fffe00019832884
x26: ffff0000cc194420 x25: 0000000000000101 x24: 1ffff00014848f43
x23: ffff80008f745840 x22: ffff8000a4247a1c x21: 0000000000000100
x20: ffff8000a42479e0 x19: 000000000004a017 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008b007230 x15: 0000000000000001
x14: 1ffff00011ee8b08 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700011ee8b09 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000da1e0000 x7 : ffff800080daa4c4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080da8a84
x2 : 0000000000000000 x1 : 0000000000000004 x0 : 0000000000000001
Call trace:
 path_init+0xdc0/0xe98 fs/namei.c:2537 (P)
 path_openat+0x13c/0x2c40 fs/namei.c:4041
 do_filp_open+0x18c/0x36c fs/namei.c:4073
 do_open_execat+0x124/0x4d8 fs/exec.c:783
 alloc_bprm+0x3c/0x548 fs/exec.c:1410
 do_execveat_common+0x168/0x834 fs/exec.c:1811
 do_execve fs/exec.c:1934 [inline]
 __do_sys_execve fs/exec.c:2010 [inline]
 __se_sys_execve fs/exec.c:2005 [inline]
 __arm64_sys_execve+0x9c/0xb4 fs/exec.c:2005
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

