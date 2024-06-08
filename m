Return-Path: <linux-fsdevel+bounces-21281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22629901154
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688C2B219EB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE957178372;
	Sat,  8 Jun 2024 11:33:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D144C65
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jun 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717846386; cv=none; b=cNcB4oeUMQ7HxuWk2965Q4hf7GErFHhz8R/2hz3XaHbiXBSOp2L1Pme8wFSkRL/+nccuKk+xatxMmgvds71II5wEw3tEyYzT+wtuiMILBihieNxMys2W9c1bl6+Y9m3QTLgjtARq8cfkuyn8x1uRDiqXn4krtZPwI1vPhen6X9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717846386; c=relaxed/simple;
	bh=ioKFoWS0zKvhtaD7se9vWkDCsp6PPUPNXowTybKg+/E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jR+FAjRuIezQSgLPxJAU1GRXWetI853nWzBb1fEvngH6lQ0ybtvfgKvefeiXwY97ho4lOw1azetUErgfl02GeBVAPSUN48AvJczpGMcqpI0aRt/wIuxlWXlyMbBmqG5rkYBrd2I2d1mUT2V0TKrFO5cORbCppfaUF/dBMM8e0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eafdb25dbbso362518739f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jun 2024 04:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717846384; x=1718451184;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWule08IBG9wwrb7pQJ+RO4vHjsx59FjaNfXSwOb16o=;
        b=K8Qf7fbo4M2hrt6lFpAFBRpBmpKRDcy61RiZY7TE3lmmOc8hToy5dF/uRpXzPGfCGy
         oAMy4FkMdaBk0Oz7o5DZnCxlDKYcV6fXempbEt0tBnwqRXV1PfiqMTrrXnj2KPSsNwOs
         2w4ozvWUTCG5ETXObth0h0lj9EvhYLJFBuz+rsZSKIXSczpNAPmHk/yzBIr+3jiIKixe
         ulSIRWjkYXHI2+w2MFCHR3RGcBlzFcoBeRLw7WBveI8b8qTZZNhRPAWf61NejRl4L/25
         yZZFKu0sbPEQ15dKn7UcfD7c7KfxwPtjjiXGoHvwyCjSRyAw53hYGVyGVgwGpaUJmlna
         kKhA==
X-Forwarded-Encrypted: i=1; AJvYcCXuAUqaVmqTVqtt3SfnneCzzeSzYGisl0ser2FsAylEOVm1atZmAxguVSLSHeyfVZvARxQkfvSYiZN0Eyul/5f/wejv7Pycrzko86OGMg==
X-Gm-Message-State: AOJu0YykGWLkQ2GbyTfGWNYX/0hx6OUhqWD0zxtL6ISCVGiIvatsZetr
	K5URUq3GmtSkyUNau8B5b3HmTPr9MM3xN6n5Hm37f8fhdbv7k/mZUPsi/AmWmrbKYBBa1XnUSr5
	9mts0j6qa+PXgAGGzJNxH8K+hr6IT3qvmuxTjytdqBp6FvgW1K794e2w=
X-Google-Smtp-Source: AGHT+IEJLINNw1X7KJ7FpSqNGQSQ73nxM5deyrgdxeRbBMTT+EFxLbAE89oovCKijdVHLowZA32TyxqeGLK48kb0UoaTyPnMJ9g2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1583:b0:7e2:b00:2239 with SMTP id
 ca18e2360f4ac-7eb5712aae7mr11623439f.0.1717846383908; Sat, 08 Jun 2024
 04:33:03 -0700 (PDT)
Date: Sat, 08 Jun 2024 04:33:03 -0700
In-Reply-To: <6720af76-6504-4337-99f4-01db93913d0b@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007de759061a5f4796@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_revalidate_dentry
From: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To: chao@kernel.org, glider@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 memory: 36984K
[   50.182299][    T1] Write protecting the kernel read-only data: 262144k
[   50.230344][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1860K
[   51.888217][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   51.898420][    T1] x86/mm: Checking user space page tables
[   53.414268][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   53.423551][    T1] Failed to set sysctl parameter 'kernel.hung_task_all=
_cpu_backtrace=3D1': parameter not found
[   53.444612][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   53.456544][    T1] Run /sbin/init as init process
[   54.990987][ T4448] mount (4448) used greatest stack depth: 8080 bytes l=
eft
[   55.063339][ T4449] EXT4-fs (sda1): re-mounted 5941fea2-f5fa-4b4e-b5ef-9=
af118b27b95 r/w. Quota mode: none.
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   55.407814][ T4452] mount (4452) used greatest stack depth: 5536 bytes l=
eft
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   59.268897][ T4482] udevd[4482]: starting ve=
rsion 3.2.11
[   62.847262][ T4483] udevd[4483]: starting eudev-3.2.11
[   62.860816][ T4482] udevd (4482) used greatest stack depth: 5296 bytes l=
eft
done
Starting system message bus: [  101.638329][ T4678] dbus-uuidgen (4678) use=
d greatest stack depth: 5288 bytes left
done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:98:24:4c:28:99:7c:d9:70:fe:51:ca:fe:56:33:2c:7d
forked to background, child pid 4695
[  110.050686][ T4696] 8021q: adding VLAN 0 to HW filter on device bond0
[  110.117239][ T4696] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
[  111.294758][ T4772] ssh-keygen (4772) used greatest stack depth: 4480 by=
tes left
Starting sshd: [  111.635136][  T779] cfg80211: failed to load regulatory.d=
b
OK


syzkaller

syzkaller login: [  113.824166][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  113.831324][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd=
0
[  113.838490][    C0]  receive_buf+0x25e3/0x5fd0
[  113.843430][    C0]  virtnet_poll+0xd1c/0x23c0
[  113.848241][    C0]  __napi_poll+0xe7/0x980
[  113.852660][    C0]  net_rx_action+0x82a/0x1850
[  113.857539][    C0]  handle_softirqs+0x1d8/0x810
[  113.862472][    C0]  __irq_exit_rcu+0x68/0x120
[  113.867263][    C0]  irq_exit_rcu+0x12/0x20
[  113.871748][    C0]  common_interrupt+0x94/0xa0
[  113.876625][    C0]  asm_common_interrupt+0x2b/0x40
[  113.881816][    C0]  __sanitizer_cov_trace_pc+0x0/0x70
[  113.887395][    C0]  update_stack_state+0x64/0x270
[  113.892486][    C0]  unwind_next_frame+0x19a/0x470
[  113.897959][    C0]  arch_stack_walk+0x1ec/0x2d0
[  113.902980][    C0]  stack_trace_save+0xaa/0xe0
[  113.908072][    C0]  kmsan_internal_poison_memory+0x49/0x90
[  113.913988][    C0]  kmsan_slab_alloc+0xdf/0x160
[  113.918925][    C0]  kmem_cache_alloc_noprof+0x637/0xb20
[  113.924598][    C0]  mas_alloc_nodes+0x4a3/0xf00
[  113.929579][    C0]  mas_preallocate+0x183c/0x2730
[  113.934818][    C0]  mmap_region+0x2ca2/0x4460
[  113.939784][    C0]  do_mmap+0xfc5/0x1a40
[  113.944442][    C0]  vm_mmap_pgoff+0x23b/0x5a0
[  113.949284][    C0]  ksys_mmap_pgoff+0x16e/0x7a0
[  113.954302][    C0]  __x64_sys_mmap+0x1a8/0x240
[  113.959245][    C0]  x64_sys_call+0x1bbf/0x3b50
[  113.964185][    C0]  do_syscall_64+0xcf/0x1e0
[  113.969036][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  113.975180][    C0]=20
[  113.977671][    C0] Uninit was created at:
[  113.982057][    C0]  __alloc_pages_noprof+0x9d6/0xe70
[  113.987558][    C0]  alloc_pages_mpol_noprof+0x299/0x990
[  113.993311][    C0]  alloc_pages_noprof+0x1bf/0x1e0
[  113.998471][    C0]  skb_page_frag_refill+0x2bf/0x7c0
[  114.003973][    C0]  virtnet_rq_alloc+0x43/0xbb0
[  114.008926][    C0]  try_fill_recv+0x3f0/0x2f50
[  114.013776][    C0]  virtnet_open+0x1cc/0xb00
[  114.018581][    C0]  __dev_open+0x546/0x6f0
[  114.023118][    C0]  __dev_change_flags+0x309/0x9a0
[  114.028352][    C0]  dev_change_flags+0x8e/0x1d0
[  114.033326][    C0]  devinet_ioctl+0x13ec/0x22c0
[  114.038533][    C0]  inet_ioctl+0x4bd/0x6d0
[  114.042936][    C0]  sock_do_ioctl+0xb7/0x540
[  114.047801][    C0]  sock_ioctl+0x727/0xd70
[  114.052237][    C0]  __se_sys_ioctl+0x261/0x450
[  114.057137][    C0]  __x64_sys_ioctl+0x96/0xe0
[  114.061972][    C0]  x64_sys_call+0x1883/0x3b50
[  114.067162][    C0]  do_syscall_64+0xcf/0x1e0
[  114.071823][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.077958][    C0]=20
[  114.080379][    C0] CPU: 0 PID: 4812 Comm: dhcpcd-run-hook Not tainted 6=
.9.0-syzkaller-10230-g4d30ff38e3f9 #0
[  114.090739][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.101012][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  114.108227][    C0] Disabling lock debugging due to kernel taint
[  114.114572][    C0] Kernel panic - not syncing: kmsan.panic set ...
[  114.121098][    C0] CPU: 0 PID: 4812 Comm: dhcpcd-run-hook Tainted: G   =
 B              6.9.0-syzkaller-10230-g4d30ff38e3f9 #0
[  114.132804][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 04/02/2024
[  114.142969][    C0] Call Trace:
[  114.146437][    C0]  <IRQ>
[  114.149434][    C0]  dump_stack_lvl+0x216/0x2d0
[  114.154230][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.160181][    C0]  dump_stack+0x1e/0x30
[  114.164457][    C0]  panic+0x4e2/0xcd0
[  114.168670][    C0]  ? kmsan_get_metadata+0xb1/0x1d0
[  114.173913][    C0]  kmsan_report+0x2d5/0x2e0
[  114.178526][    C0]  ? is_last_task_frame+0x1d8/0x420
[  114.183941][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.189335][    C0]  ? __msan_warning+0x95/0x120
[  114.194328][    C0]  ? receive_buf+0x25e3/0x5fd0
[  114.199215][    C0]  ? virtnet_poll+0xd1c/0x23c0
[  114.204468][    C0]  ? __napi_poll+0xe7/0x980
[  114.209197][    C0]  ? net_rx_action+0x82a/0x1850
[  114.214155][    C0]  ? handle_softirqs+0x1d8/0x810
[  114.219313][    C0]  ? __irq_exit_rcu+0x68/0x120
[  114.224187][    C0]  ? irq_exit_rcu+0x12/0x20
[  114.228797][    C0]  ? common_interrupt+0x94/0xa0
[  114.233835][    C0]  ? asm_common_interrupt+0x2b/0x40
[  114.239212][    C0]  ? __pfx___sanitizer_cov_trace_pc+0x10/0x10
[  114.245388][    C0]  ? update_stack_state+0x64/0x270
[  114.250627][    C0]  ? unwind_next_frame+0x19a/0x470
[  114.255886][    C0]  ? arch_stack_walk+0x1ec/0x2d0
[  114.260934][    C0]  ? stack_trace_save+0xaa/0xe0
[  114.265911][    C0]  ? kmsan_internal_poison_memory+0x49/0x90
[  114.272008][    C0]  ? kmsan_slab_alloc+0xdf/0x160
[  114.277047][    C0]  ? kmem_cache_alloc_noprof+0x637/0xb20
[  114.282820][    C0]  ? mas_alloc_nodes+0x4a3/0xf00
[  114.287876][    C0]  ? mas_preallocate+0x183c/0x2730
[  114.293206][    C0]  ? mmap_region+0x2ca2/0x4460
[  114.298092][    C0]  ? do_mmap+0xfc5/0x1a40
[  114.302532][    C0]  ? vm_mmap_pgoff+0x23b/0x5a0
[  114.307418][    C0]  ? ksys_mmap_pgoff+0x16e/0x7a0
[  114.312494][    C0]  ? __x64_sys_mmap+0x1a8/0x240
[  114.317451][    C0]  ? x64_sys_call+0x1bbf/0x3b50
[  114.322507][    C0]  ? do_syscall_64+0xcf/0x1e0
[  114.327358][    C0]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.333581][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.338899][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.344227][    C0]  ? page_to_skb+0xdae/0x1620
[  114.349019][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.354526][    C0]  __msan_warning+0x95/0x120
[  114.359242][    C0]  receive_buf+0x25e3/0x5fd0
[  114.364049][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.369356][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.375284][    C0]  virtnet_poll+0xd1c/0x23c0
[  114.380002][    C0]  ? __pfx_virtnet_poll+0x10/0x10
[  114.385130][    C0]  __napi_poll+0xe7/0x980
[  114.389562][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.394870][    C0]  net_rx_action+0x82a/0x1850
[  114.399646][    C0]  ? sched_clock_cpu+0x55/0x870
[  114.404604][    C0]  ? __pfx_net_rx_action+0x10/0x10
[  114.409827][    C0]  handle_softirqs+0x1d8/0x810
[  114.414700][    C0]  __irq_exit_rcu+0x68/0x120
[  114.419381][    C0]  irq_exit_rcu+0x12/0x20
[  114.423803][    C0]  common_interrupt+0x94/0xa0
[  114.428576][    C0]  </IRQ>
[  114.431555][    C0]  <TASK>
[  114.434531][    C0]  asm_common_interrupt+0x2b/0x40
[  114.439653][    C0] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70
[  114.445825][    C0] Code: f6 e8 04 58 80 00 5b 41 5e 5d c3 cc cc cc cc 8=
b 3a e8 74 ea 92 00 eb e3 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 <f3> 0f 1e fa 55 48 89 e5 48 8b 45 08 65 48 8b 0c 25 80 5e 0a 00 65
[  114.465551][    C0] RSP: 0018:ffff888121413348 EFLAGS: 00000286
[  114.471907][    C0] RAX: ffff888116394cc0 RBX: ffff888121413428 RCX: fff=
f888116394180
[  114.480131][    C0] RDX: 0000000000000000 RSI: ffff888121413ed0 RDI: fff=
f888121413ed0
[  114.488297][    C0] RBP: ffff888121413368 R08: ffffea000000000f R09: fff=
f888121410000
[  114.496384][    C0] R10: ffff888121413428 R11: ffffffff81936f80 R12: fff=
f888121413e50
[  114.504462][    C0] R13: ffff888121413480 R14: ffff888121413ed0 R15: fff=
f888116394cc0
[  114.512556][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  114.518864][    C0]  ? decode_frame_pointer+0x19/0x80
[  114.524160][    C0]  update_stack_state+0x64/0x270
[  114.529362][    C0]  unwind_next_frame+0x19a/0x470
[  114.534440][    C0]  arch_stack_walk+0x1ec/0x2d0
[  114.539328][    C0]  ? __x64_sys_mmap+0x1a8/0x240
[  114.544459][    C0]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  114.550766][    C0]  stack_trace_save+0xaa/0xe0
[  114.555558][    C0]  kmsan_internal_poison_memory+0x49/0x90
[  114.561409][    C0]  ? kmsan_internal_poison_memory+0x49/0x90
[  114.567444][    C0]  ? kmsan_slab_alloc+0xdf/0x160
[  114.572748][    C0]  ? kmem_cache_alloc_noprof+0x637/0xb20
[  114.578571][    C0]  ? mas_alloc_nodes+0x4a3/0xf00
[  114.583901][    C0]  ? mas_preallocate+0x183c/0x2730
[  114.589207][    C0]  ? mmap_region+0x2ca2/0x4460
[  114.594137][    C0]  ? do_mmap+0xfc5/0x1a40
[  114.598572][    C0]  ? vm_mmap_pgoff+0x23b/0x5a0
[  114.603459][    C0]  ? ksys_mmap_pgoff+0x16e/0x7a0
[  114.608513][    C0]  ? __x64_sys_mmap+0x1a8/0x240
[  114.613461][    C0]  ? __kernel_text_address+0x2a/0xa0
[  114.618867][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.624169][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.629464][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.635372][    C0]  ? kmem_cache_alloc_noprof+0x67/0xb20
[  114.641123][    C0]  ? filter_irq_stacks+0x60/0x1a0
[  114.646435][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.652006][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.658172][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.663506][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.669455][    C0]  kmsan_slab_alloc+0xdf/0x160
[  114.674337][    C0]  kmem_cache_alloc_noprof+0x637/0xb20
[  114.679907][    C0]  ? mas_alloc_nodes+0x4a3/0xf00
[  114.685004][    C0]  mas_alloc_nodes+0x4a3/0xf00
[  114.689945][    C0]  mas_preallocate+0x183c/0x2730
[  114.695111][    C0]  ? kmsan_get_shadow_origin_ptr+0x4d/0xb0
[  114.701089][    C0]  mmap_region+0x2ca2/0x4460
[  114.705900][    C0]  ? cap_mmap_addr+0x326/0x490
[  114.711067][    C0]  do_mmap+0xfc5/0x1a40
[  114.715362][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.720773][    C0]  vm_mmap_pgoff+0x23b/0x5a0
[  114.725483][    C0]  ksys_mmap_pgoff+0x16e/0x7a0
[  114.730543][    C0]  ? kmsan_get_metadata+0x146/0x1d0
[  114.735871][    C0]  __x64_sys_mmap+0x1a8/0x240
[  114.740657][    C0]  x64_sys_call+0x1bbf/0x3b50
[  114.745454][    C0]  do_syscall_64+0xcf/0x1e0
[  114.750047][    C0]  ? clear_bhb_loop+0x25/0x80
[  114.754827][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  114.760872][    C0] RIP: 0033:0x7f2869f18b74
[  114.765415][    C0] Code: 63 08 44 89 e8 5b 41 5c 41 5d c3 41 89 ca 41 f=
7 c1 ff 0f 00 00 74 0c c7 05 f5 46 01 00 16 00 00 00 eb 17 b8 09 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f
[  114.785329][    C0] RSP: 002b:00007ffcbfc0e7f8 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000009
[  114.793956][    C0] RAX: ffffffffffffffda RBX: 00000000000003d8 RCX: 000=
07f2869f18b74
[  114.802084][    C0] RDX: 0000000000000003 RSI: 0000000000002000 RDI: 000=
0000000000000
[  114.810199][    C0] RBP: 0000000000002000 R08: 00000000ffffffff R09: 000=
0000000000000
[  114.818331][    C0] R10: 0000000000000022 R11: 0000000000000246 R12: 000=
07f2869ca1218
[  114.826406][    C0] R13: 00007f2869ca1248 R14: 00007f2869f2cab0 R15: 000=
07f2869e22b10
[  114.834505][    C0]  </TASK>
[  114.838107][    C0] Kernel Offset: disabled
[  114.842503][    C0] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build255802096=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at 25905f5d0a
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D25905f5d0a2a7883bd33491997556193582c6059 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20240301-171218'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"25905f5d0a2a7883bd3349199755619358=
2c6059\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D1056f66a980000


Tested on:

commit:         4d30ff38 hfs: fix to initialize .tz_secondswest in hfs..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.=
git misc
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D48182e7cc446d35=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3ae6be33a50b5aae4=
dab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

