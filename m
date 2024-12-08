Return-Path: <linux-fsdevel+bounces-36706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC09E85E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 16:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B6518850C3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9050915382E;
	Sun,  8 Dec 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="HhebDKCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28071E4AE;
	Sun,  8 Dec 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733671556; cv=none; b=q8vzGqMgt6N32RiYnXFGhX8kcOfhgpXsLBanPr0VUGJe4AgET7IiNhF/xmiCkm4coO2PjUp31mxyZM4AnxnhTosiePa8H6aYAiQ3AO/hFNKVgmDuwtuFerR1dYZFXA69BPozyoGk4LuL3f2XkUOdyRFjnWalqOF+S2FEp33H5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733671556; c=relaxed/simple;
	bh=OaqbjMXhERe14Tf73UK6Z5TP5gtgvJIYzfb1MT8C7+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rs33ZGUBmrBIm+OwQvvFK5Uu8plQxAkQRPMzFjpOvPc3Lq7shwbDNY4fly3XwBaQZeyfYHkEY5VdKRWdsqtVnugz+u7dArKN+XZztn2Sh9yjxONUvgnhcRRwEXA2dMX3Frk13bGLh40Ps6U17WCtaF6DQmvjvIWjrocX4+u+t/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=HhebDKCt; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733671523; x=1734276323; i=spasswolf@web.de;
	bh=HNBg1Ow9TOBMlbKpQkFYyPgiVIqI6OP/+OYbKwEqBZY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HhebDKCtLgMdttxjQ2SVKUKq1sxvudTCHrxTOlAB34Rf/76lxHngSQ+jPYXsa5Hc
	 XFqXGe5ac/9zgZrmUEqSaXMZ2Y/+Sc91SUf6yE2oIt29OoAD+9YAXIlXHlK7dD+LI
	 mZBL6YGS4U6LKkp+gb971Ql4gLP1qMOHnmpHH2zM3hBfVEgRQ0TBSvy9IwplSYD6K
	 j4spT4i9zdFru3ta4z6lrPxRoeqfWojgbitGZBjjtIB6hBGX5uOKvySSUBpOnMpVb
	 Gj5JlDg/pm+UzwJuhKAO65r4lfCmqg7vMkNGVvPKZKFlmEvwYf0Er11DSeHSo3Q3H
	 JV5JdhzR1zWPBVTNwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MlbLM-1u2gJl2PLu-00ovH1; Sun, 08 Dec 2024 16:25:23 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: commit 0790303ec869 leads to cpu stall without CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
Date: Sun,  8 Dec 2024 16:25:19 +0100
Message-ID: <20241208152520.3559-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vrjAnARBzUs+W2Z3SxfLkmvhBcxuE7uVQECMTMOYI2ZKrKDBGwX
 MJMvHCWO+yzfOOeMkbEulrDjoNk72RZlk2u0WMQ6o4C6X2g4/HIN1a9fdWnYxNCDQQyzijL
 R6BlG9DgqsH3Xdxo69gw5Bk8jGvqBs7WoQ9jR77Kto65d2jlNbPz+0VH608i4sN7jRDVENg
 EDJvNCGqBgIallciHmcsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6Cx1JXlZS0E=;p6TVaIZ0Miu/+SBXrLbz0bIRuo0
 fJjLXYJVCjMAWIqcGOUeN4SD62aFUsQ0xc66fcUCteXJKIrvNbdt68x7zLd6JGku19lfrnese
 OvebMCaBSfQDkr0EoymVq63TW6LCTXYFkvSrlb48TmJPYWDXIFlQkX4va8+/6s4Ivzmof8rno
 qON3yrXx/qu0XHjNB0yJiJ9AisQm/vu1V5SFHPOPLVxiw28P4aOZYT0PLnc2LUR30WL13Vqfd
 /8XBikmEd/eeAAsTZuiuVYFjHxi9ac5x16zjoFkynS91ZjdHq++LxYSsHZahxACRxR9Ql6pfj
 TetwF51cJyeZVv/9dSnkbnsm0kFrC9l6w7oqxzLRDycgcQvyxEFvAf2AmgebRt2MKgnjPi6F5
 bFfL1GFu3y5uqrliitqFOuHt1fmkTsO5ZDZcS2GUVg3pkC6e5biGWSJ62cMgzdkz+YcCkjVOA
 ugLmjXX5RFNuQ0vSXhWORKLJ3p4spTtlho7lnnI0grv19eSFbofBYH7PfXmiwz2vpJwXkC3bn
 aWLSzQTvYx/tN6df6pe9y5apNfug6Y19hxRa5i9jkcS23x3SM6daTw3n1wo4PWYHA50PalXXn
 a38gQkEivYMTPugiTTJOkha7RhHYmMaYEbqNE9a80WxjGXLXW2wq53tFKW+qVEJg5s7OV+ttS
 vyBt99E28lckrn65geLokUKEZBt57iqOHXQVFEC8Qy7iKiXaM00mUwih3EHy2+TbHqg2kRXKU
 FmZI9pgPupFrRg5Z9JJSw38i0Up1LxxXZB9KysICuQWM+W5FFwALfhB2OiJreVXpxNI042EAJ
 qxN4ady/twL/6BK7LnPrVSQ/DEYHtWiQHQkGNqd9GJD8AY6ks+xOzC5uIJzKvawIxZFDD6GY8
 1WqgIQcHhO1RRAgL4kpRIK2cVF0ZXVInJiQ88F8eufusBi1KLLNbDvG83Sl8QK9OO420rbl88
 XowbPUG47fTnASHqXxVdNjw4V2aSB2bAjjgqcVTCpVtAILAKRIzAVdmDoVjwLHHAhWkM0Barr
 xkFphcMGJ8Qc9BToHTrmmleRyEnRfpdDFJVrYuM83FejlXQR3IYl5EWBTQyKkKcGXDAEn0qpP
 t+8Dvl1VI=

Since linux-next-20241206 booting my debian unstable system hangs before s=
tarting gdm.
After some time these messages appear in /var/log/kern.log:

[    C2] rcu: INFO: rcu_preempt self-detected stall on CPU
[    C2] rcu: 	2-....: (1 GPs behind) idle=3D1ba4/1/0x4000000000000000 sof=
tirq=3D0/0 fqs=3D4621 rcuc=3D21006 jiffies(starved)
[    C2] rcu: 	(t=3D21001 jiffies g=3D805 q=3D2596 ncpus=3D16)
[    C2] CPU: 2 UID: 0 PID: 1318 Comm: ntpd Not tainted 6.13.0-rc1-next-20=
241206-master #631
[    C2] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-158L, BIOS E158LAMS.107 11/10/2021
[    C2] RIP: 0010:filemap_fault+0x9b7/0xc90
[    C2] Code: 2f 4d ec ff 41 8b 94 24 c8 00 00 00 e9 39 f9 ff ff 49 8b 17=
 a8 08 0f 85 c2 f7 ff ff 45 84 d2 0f 85 a6 01 00 00 f0 41 80 37 01 <0f> 88=
 8c 01 00 00 4d 85 ed 0f 84 d4 00 00 00 49 81 ff 00 f0 ff ff
[    C2] RSP: 0018:ffffb573c689fc10 EFLAGS: 00000202
[    C2] RAX: 0000000000000000 RBX: ffff9ffec13fa918 RCX: 0000000000000000
[    C2] RDX: 4000000000000021 RSI: ffff9ffec1716100 RDI: ffff9ffec13fa950
[    C2] RBP: 0000000000000014 R08: 0000000000000020 R09: 0000000000000013
[    C2] R10: 0000000000000001 R11: ffffebb6c901ff00 R12: 0000000000000000
[    C2] R13: 0000000000000000 R14: ffffb573c689fd08 R15: ffffebb6c901ff00
[    C2] FS:  00007f80bedee740(0000) GS:ffffa00cee480000(0000) knlGS:00000=
00000000000
[    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    C2] CR2: 00007f80bf14b020 CR3: 000000010506e000 CR4: 0000000000750ef0
[    C2] PKRU: 55555554
[    C2] Call Trace:
[    C2]  <IRQ>
[    C2]  ? rcu_dump_cpu_stacks+0x10d/0x140
[    C2]  ? rcu_sched_clock_irq+0x337/0xb10
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  ? update_load_avg+0x77/0x6b0
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  ? update_process_times+0x7c/0xb0
[    C2]  ? tick_nohz_handler+0x8a/0x140
[    C2]  ? __pfx_tick_nohz_handler+0x10/0x10
[    C2]  ? __hrtimer_run_queues+0x135/0x200
[    C2]  ? hrtimer_interrupt+0xf5/0x210
[    C2]  ? __sysvec_apic_timer_interrupt+0x4e/0x60
[    C2]  ? sysvec_apic_timer_interrupt+0x64/0x80
[    C2]  </IRQ>
[    C2]  <TASK>
[    C2]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    C2]  ? filemap_fault+0x9b7/0xc90
[    C2]  __do_fault+0x2c/0xb0
[    C2]  do_fault+0x3a7/0x5e0
[    C2]  __handle_mm_fault+0x24c/0x310
[    C2]  handle_mm_fault+0x96/0x290
[    C2]  __get_user_pages+0x2c3/0xf70
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  ? __set_cpus_allowed_ptr+0x4e/0xa0
[    C2]  populate_vma_page_range+0x77/0xc0
[    C2]  __mm_populate+0xa7/0x140
[    C2]  __do_sys_mlockall+0x14b/0x170
[    C2]  do_syscall_64+0x5f/0x1a0
[    C2]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    C2] RIP: 0033:0x7f80beff66f7
[    C2] Code: 73 01 c3 48 8b 0d 29 a7 0d 00 f7 d8 64 89 01 48 83 c8 ff c3=
 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 97 00 00 00 0f 05 <48> 3d=
 01 f0 ff ff 73 01 c3 48 8b 0d f9 a6 0d 00 f7 d8 64 89 01 48
[    C2] RSP: 002b:00007ffee81b1558 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00097
[    C2] RAX: ffffffffffffffda RBX: 00007ffee81b1778 RCX: 00007f80beff66f7
[    C2] RDX: 00007ffee81b1580 RSI: 0000000000000008 RDI: 0000000000000003
[    C2] RBP: 0000000000000009 R08: 0000000000000000 R09: 0000000000000001
[    C2] R10: 0000000000000000 R11: 0000000000000246 R12: 000055964d1337e0
[    C2] R13: 000055964d1143b0 R14: 000055964d123b04 R15: 00000000ffffffff
[    C2]  </TASK>
[    C2] rcu: INFO: rcu_preempt self-detected stall on CPU
[    C2] rcu: 	2-....: (1 GPs behind) idle=3D1ba4/1/0x4000000000000000 sof=
tirq=3D0/0 fqs=3D18463 rcuc=3D84010 jiffies(starved)
[    C2] rcu: 	(t=3D84005 jiffies g=3D805 q=3D2653 ncpus=3D16)
[    C2] CPU: 2 UID: 0 PID: 1318 Comm: ntpd Not tainted 6.13.0-rc1-next-20=
241206-master #631
[    C2] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/=
MS-158L, BIOS E158LAMS.107 11/10/2021
[    C2] RIP: 0010:filemap_map_pages+0x1ce/0x510
[    C2] Code: 89 44 24 20 c1 e3 08 e8 e0 b4 03 00 48 83 44 24 40 01 f0 ff=
 45 34 09 5c 24 70 48 8b 44 24 20 f0 80 75 00 01 0f 88 d4 01 00 00 <f0> ff=
 08 0f 84 be 01 00 00 48 8b 54 24 18 48 8b 74 24 48 48 8d 7c
[    C2] RSP: 0018:ffffb573c689fbd8 EFLAGS: 00000202
[    C2] RAX: ffffebb6c6122074 RBX: 000000000000001f RCX: 0000000000000010
[    C2] RDX: 0000000184881025 RSI: 000055964d0c6000 RDI: ffff9ffe46ef1860
[    C2] RBP: ffffebb6c6122040 R08: ffffb573c689fd68 R09: 000055964d0c6000
[    C2] R10: 0000000000000000 R11: 00007f80bedfdfff R12: ffff9ffec1716100
[    C2] R13: ffff9ffe46424630 R14: ffff9ffe44872280 R15: ffffb573c689fd08
[    C2] FS:  00007f80bedee740(0000) GS:ffffa00cee480000(0000) knlGS:00000=
00000000000
[    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    C2] CR2: 00007f80bf14b020 CR3: 000000010506e000 CR4: 0000000000750ef0
[    C2] PKRU: 55555554
[    C2] Call Trace:
[    C2]  <IRQ>
[    C2]  ? rcu_dump_cpu_stacks+0x10d/0x140
[    C2]  ? rcu_sched_clock_irq+0x337/0xb10
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  ? update_load_avg+0x77/0x6b0
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  ? update_process_times+0x7c/0xb0
[    C2]  ? tick_nohz_handler+0x8a/0x140
[    C2]  ? __pfx_tick_nohz_handler+0x10/0x10
[    C2]  ? __hrtimer_run_queues+0x135/0x200
[    C2]  ? hrtimer_interrupt+0xf5/0x210
[    C2]  ? __sysvec_apic_timer_interrupt+0x4e/0x60
[    C2]  ? sysvec_apic_timer_interrupt+0x64/0x80
[    C2]  </IRQ>
[    C2]  <TASK>
[    C2]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    C2]  ? filemap_map_pages+0x1ce/0x510
[    C2]  ? filemap_map_pages+0xe6/0x510
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  ? filemap_fault+0x1af/0xc90
[    C2]  do_fault+0x378/0x5e0
[    C2]  __handle_mm_fault+0x24c/0x310
[    C2]  handle_mm_fault+0x96/0x290
[    C2]  __get_user_pages+0x2c3/0xf70
[    C2]  ? srso_alias_return_thunk+0x5/0xfbef5
[    C2]  populate_vma_page_range+0x77/0xc0
[    C2]  __mm_populate+0xa7/0x140
[    C2]  __do_sys_mlockall+0x14b/0x170
[    C2]  do_syscall_64+0x5f/0x1a0
[    C2]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    C2] RIP: 0033:0x7f80beff66f7
[    C2] Code: 73 01 c3 48 8b 0d 29 a7 0d 00 f7 d8 64 89 01 48 83 c8 ff c3=
 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 97 00 00 00 0f 05 <48> 3d=
 01 f0 ff ff 73 01 c3 48 8b 0d f9 a6 0d 00 f7 d8 64 89 01 48
[    C2] RSP: 002b:00007ffee81b1558 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00097
[    C2] RAX: ffffffffffffffda RBX: 00007ffee81b1778 RCX: 00007f80beff66f7
[    C2] RDX: 00007ffee81b1580 RSI: 0000000000000008 RDI: 0000000000000003
[    C2] RBP: 0000000000000009 R08: 0000000000000000 R09: 0000000000000001
[    C2] R10: 0000000000000000 R11: 0000000000000246 R12: 000055964d1337e0
[    C2] R13: 000055964d1143b0 R14: 000055964d123b04 R15: 00000000ffffffff
[    C2]  </TASK>
[  T165] INFO: task systemd:1 blocked for more than 61 seconds.
[  T165]       Not tainted 6.13.0-rc1-next-20241206-master #631
[  T165] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
[  T165] task:systemd         state:D stack:0     pid:1     tgid:1     ppi=
d:0      flags:0x00000002
[  T165] Call Trace:
[  T165]  <TASK>
[  T165]  __schedule+0x29c/0x1190
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? rt_mutex_setprio+0x195/0x510
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  rt_mutex_schedule+0x1b/0x30
[  T165]  rt_mutex_slowlock_block.constprop.0+0x3b/0x160
[  T165]  __rt_mutex_slowlock_locked.constprop.0.isra.0+0xb3/0x130
[  T165]  rt_mutex_slowlock.constprop.0+0x46/0xa0
[  T165]  cgroup_kn_lock_live+0x42/0xc0
[  T165]  cgroup_rmdir+0x12/0x40
[  T165]  kernfs_iop_rmdir+0x4e/0x70
[  T165]  vfs_rmdir+0x96/0x200
[  T165]  do_rmdir+0x17b/0x190
[  T165]  __x64_sys_rmdir+0x3a/0x70
[  T165]  do_syscall_64+0x5f/0x1a0
[  T165]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T165] RIP: 0033:0x7f8c60bf1557
[  T165] RSP: 002b:00007ffdbc907268 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00054
[  T165] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8c60bf1557
[  T165] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00005603c85da320
[  T165] RBP: 00007f8c6106b456 R08: 0000000000000000 R09: 0000000000000000
[  T165] R10: 0000000000000007 R11: 0000000000000246 R12: 00005603c8498fb0
[  T165] R13: 0000000000000001 R14: 0000000000000000 R15: 00005603c85da320
[  T165]  </TASK>
[  T165] INFO: task kworker/u64:3:149 blocked for more than 61 seconds.
[  T165]       Not tainted 6.13.0-rc1-next-20241206-master #631
[  T165] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
[  T165] task:kworker/u64:3   state:D stack:0     pid:149   tgid:149   ppi=
d:2      flags:0x00004000
[  T165] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
[  T165] Call Trace:
[  T165]  <TASK>
[  T165]  __schedule+0x29c/0x1190
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? get_nohz_timer_target+0x21/0x140
[  T165]  schedule+0x22/0xd0
[  T165]  schedule_timeout+0xa9/0xe0
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? sched_clock_cpu+0xf/0x1d0
[  T165]  __wait_for_common+0x91/0x190
[  T165]  ? __pfx_schedule_timeout+0x10/0x10
[  T165]  wait_for_completion_state+0x1c/0x40
[  T165]  __wait_rcu_gp+0x179/0x180
[  T165]  synchronize_rcu_normal.part.0+0x35/0x60
[  T165]  ? __pfx_call_rcu_hurry+0x10/0x10
[  T165]  ? __pfx_wakeme_after_rcu+0x10/0x10
[  T165]  __ieee80211_scan_completed+0xa9/0x310 [mac80211]
[  T165]  ieee80211_scan_work+0x111/0x540 [mac80211]
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  cfg80211_wiphy_work+0x9e/0xc0 [cfg80211]
[  T165]  process_one_work+0x161/0x270
[  T165]  worker_thread+0x30a/0x440
[  T165]  ? __pfx_worker_thread+0x10/0x10
[  T165]  kthread+0xcd/0x100
[  T165]  ? __pfx_kthread+0x10/0x10
[  T165]  ret_from_fork+0x2f/0x50
[  T165]  ? __pfx_kthread+0x10/0x10
[  T165]  ret_from_fork_asm+0x1a/0x30
[  T165]  </TASK>
[  T165] INFO: task kworker/7:2:388 blocked for more than 61 seconds.
[  T165]       Not tainted 6.13.0-rc1-next-20241206-master #631
[  T165] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
[  T165] task:kworker/7:2     state:D stack:0     pid:388   tgid:388   ppi=
d:2      flags:0x00004000
[  T165] Workqueue: events do_free_init
[  T165] Call Trace:
[  T165]  <TASK>
[  T165]  __schedule+0x29c/0x1190
[  T165]  schedule+0x22/0xd0
[  T165]  schedule_timeout+0xa9/0xe0
[  T165]  ? __remove_hrtimer+0x34/0x90
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? sched_clock_cpu+0xf/0x1d0
[  T165]  __wait_for_common+0x91/0x190
[  T165]  ? __pfx_schedule_timeout+0x10/0x10
[  T165]  wait_for_completion_state+0x1c/0x40
[  T165]  __wait_rcu_gp+0x179/0x180
[  T165]  synchronize_rcu_normal.part.0+0x35/0x60
[  T165]  ? __pfx_call_rcu_hurry+0x10/0x10
[  T165]  ? __pfx_wakeme_after_rcu+0x10/0x10
[  T165]  do_free_init+0x14/0x50
[  T165]  process_one_work+0x161/0x270
[  T165]  worker_thread+0x30a/0x440
[  T165]  ? __pfx_worker_thread+0x10/0x10
[  T165]  kthread+0xcd/0x100
[  T165]  ? __pfx_kthread+0x10/0x10
[  T165]  ret_from_fork+0x2f/0x50
[  T165]  ? __pfx_kthread+0x10/0x10
[  T165]  ret_from_fork_asm+0x1a/0x30
[  T165]  </TASK>
[  T165] INFO: task wpa_supplicant:1027 blocked for more than 61 seconds.
[  T165]       Not tainted 6.13.0-rc1-next-20241206-master #631
[  T165] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
[  T165] task:wpa_supplicant  state:D stack:0     pid:1027  tgid:1027  ppi=
d:1      flags:0x00000002
[  T165] Call Trace:
[  T165]  <TASK>
[  T165]  __schedule+0x29c/0x1190
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? rt_mutex_setprio+0x195/0x510
[  T165]  rt_mutex_schedule+0x1b/0x30
[  T165]  rt_mutex_slowlock_block.constprop.0+0x3b/0x160
[  T165]  __rt_mutex_slowlock_locked.constprop.0.isra.0+0xb3/0x130
[  T165]  rt_mutex_slowlock.constprop.0+0x46/0xa0
[  T165]  nl80211_pre_doit+0xa2/0x260 [cfg80211]
[  T165]  genl_family_rcv_msg_doit+0xcf/0x140
[  T165]  genl_rcv_msg+0x188/0x290
[  T165]  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211]
[  T165]  ? __pfx_nl80211_abort_scan+0x10/0x10 [cfg80211]
[  T165]  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211]
[  T165]  ? __pfx_genl_rcv_msg+0x10/0x10
[  T165]  netlink_rcv_skb+0x4e/0x100
[  T165]  genl_rcv+0x23/0x30
[  T165]  netlink_unicast+0x249/0x3a0
[  T165]  netlink_sendmsg+0x216/0x470
[  T165]  __sock_sendmsg+0x78/0x80
[  T165]  ____sys_sendmsg+0x23b/0x2e0
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? copy_msghdr_from_user+0xe6/0x170
[  T165]  ___sys_sendmsg+0x7f/0xd0
[  T165]  ? rt_spin_lock+0x37/0xb0
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? do_anonymous_page+0x418/0x5d0
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? netlink_setsockopt+0x262/0x420
[  T165]  __sys_sendmsg+0x63/0xc0
[  T165]  do_syscall_64+0x5f/0x1a0
[  T165]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T165] RIP: 0033:0x7fe32a392970
[  T165] RSP: 002b:00007ffc292500f8 EFLAGS: 00000202 ORIG_RAX: 00000000000=
0002e
[  T165] RAX: ffffffffffffffda RBX: 000055ccd6337a00 RCX: 00007fe32a392970
[  T165] RDX: 0000000000000000 RSI: 00007ffc29250130 RDI: 0000000000000006
[  T165] RBP: 000055ccd63b3760 R08: 0000000000000004 R09: 0000000000000001
[  T165] R10: 00007ffc29250214 R11: 0000000000000202 R12: 000055ccd6337ce0
[  T165] R13: 00007ffc29250130 R14: 0000000000000000 R15: 00007ffc29250214
[  T165]  </TASK>
[  T165] INFO: task systemd:1293 blocked for more than 61 seconds.
[  T165]       Not tainted 6.13.0-rc1-next-20241206-master #631
[  T165] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
[  T165] task:systemd         state:D stack:0     pid:1293  tgid:1293  ppi=
d:1      flags:0x00004002
[  T165] Call Trace:
[  T165]  <TASK>
[  T165]  __schedule+0x29c/0x1190
[  T165]  schedule+0x22/0xd0
[  T165]  schedule_timeout+0xa9/0xe0
[  T165]  __wait_for_common+0x91/0x190
[  T165]  ? __pfx_schedule_timeout+0x10/0x10
[  T165]  wait_for_completion_state+0x1c/0x40
[  T165]  __wait_rcu_gp+0x179/0x180
[  T165]  synchronize_rcu_normal.part.0+0x35/0x60
[  T165]  ? __pfx_call_rcu_hurry+0x10/0x10
[  T165]  ? __pfx_wakeme_after_rcu+0x10/0x10
[  T165]  rcu_sync_enter+0x54/0x110
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  ? srso_alias_return_thunk+0x5/0xfbef5
[  T165]  percpu_down_write+0x16/0xd0
[  T165]  cgroup_update_dfl_csses+0x242/0x290
[  T165]  cgroup_subtree_control_write+0x3c5/0x410
[  T165]  kernfs_fop_write_iter+0x139/0x1f0
[  T165]  vfs_write+0x251/0x410
[  T165]  ksys_write+0x65/0xe0
[  T165]  do_syscall_64+0x5f/0x1a0
[  T165]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  T165] RIP: 0033:0x7fbc77c27f90
[  T165] RSP: 002b:00007ffdd1824288 EFLAGS: 00000202 ORIG_RAX: 00000000000=
00001
[  T165] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fbc77c27f90
[  T165] RDX: 0000000000000005 RSI: 0000564aad4827d0 RDI: 0000000000000021
[  T165] RBP: 0000564aad4827d0 R08: 00007fbc77d0bac0 R09: 0000000000000001
[  T165] R10: 00007fbc77d0bb70 R11: 0000000000000202 R12: 0000000000000005
[  T165] R13: 0000564aad4b85f0 R14: 00007fbc77d09ea0 R15: 00000000fffffff7
[  T165]  </TASK>

I bisected this between linux-6.13-rc1 and linux-20241206 and found this a=
s
offending commit:
0790303ec869 ("fsnotify: generate pre-content permission event on page fau=
lt")

I also noticed that only a part of the commit causes the issue, and revert=
ing
that part solves it in linux-next-20241206:

commit 6207000b72058b45bb03f0975fbbbcd9dae06238
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Sun Dec 8 01:51:59 2024 +0100

    mm: filemap: partially revert commit 790303ec869

    Reverting this part of commit 790303ec869 is enough
    to fix the issue.

    Signed-off-by: Bert Karwatzki <spasswolf@web.de>

diff --git a/mm/filemap.c b/mm/filemap.c
index 23e001f5cd0f..9bf2fc833f3c 100644
=2D-- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3419,37 +3419,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * or because readahead was otherwise unable to retrieve it.
 	 */
 	if (unlikely(!folio_test_uptodate(folio))) {
-		/*
-		 * If this is a precontent file we have can now emit an event to
-		 * try and populate the folio.
-		 */
-		if (!(vmf->flags & FAULT_FLAG_TRIED) &&
-		    unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
-			loff_t pos =3D folio_pos(folio);
-			size_t count =3D folio_size(folio);
-
-			/* We're NOWAIT, we have to retry. */
-			if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
-				folio_unlock(folio);
-				goto out_retry;
-			}
-
-			if (mapping_locked)
-				filemap_invalidate_unlock_shared(mapping);
-			mapping_locked =3D false;
-
-			folio_unlock(folio);
-			fpin =3D maybe_unlock_mmap_for_io(vmf, fpin);
-			if (!fpin)
-				goto out_retry;
-
-			error =3D fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos,
-							count);
-			if (error)
-				ret =3D VM_FAULT_SIGBUS;
-			goto out_retry;
-		}
-
 		/*
 		 * If the invalidate lock is not held, the folio was in cache
 		 * and uptodate and now it is not. Strange but possible since we


Then I took a closer look at the function called in the problematic code a=
nd noticed
that fsnotify_file_area_perm(), is a NOOP when CONFIG_FANOTIFY_ACCESS_PERM=
ISSIONS
is not set (which was the case in my .config). This also explains why this=
 was not
found before, as distributional .config file have this option enabled.
Setting the option to y solves the issue, too

Another solution is to compile the problematic code conditionally:

diff --git a/mm/filemap.c b/mm/filemap.c
index 23e001f5cd0f..94d4eff59e3c 100644
=2D-- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3423,6 +3423,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		 * If this is a precontent file we have can now emit an event to
 		 * try and populate the folio.
 		 */
+#ifdef CONFIG_FANOTIFY_ACCESS_PERM
 		if (!(vmf->flags & FAULT_FLAG_TRIED) &&
 		    unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
 			loff_t pos =3D folio_pos(folio);
@@ -3449,6 +3450,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 				ret =3D VM_FAULT_SIGBUS;
 			goto out_retry;
 		}
+#endif

 		/*
 		 * If the invalidate lock is not held, the folio was in cache


Bert Karwatzki

