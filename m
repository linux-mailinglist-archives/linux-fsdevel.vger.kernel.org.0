Return-Path: <linux-fsdevel+bounces-57646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ECFB241D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 08:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327947BCD9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 06:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127212D4B66;
	Wed, 13 Aug 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNvM9MAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E82BE629
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067537; cv=none; b=CH1XsgwzdDwodkXYZyJTUxC+rD02HuZKnRSLjSOOVer7POxg+Wb6C+r/Sr6k+TXT5X5XWZa8J6TgLxeduQjbAgduJoGWSRMXcDrWOJSAJqcOU6zUJfs6WGj+nysVVKDZRjKkzHMO0C2uKVtrOixrlfco+NFRDEV8rC1/LAr+6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067537; c=relaxed/simple;
	bh=hUk3t9Brs/yZfYgqEuDcVscJZPbWDoP8jtXNQTZ+T6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRCLweOsABebXKQ13SKBcXYhAEF83Qrj3Ox33Ld82kwBeQNZUMyl3TpVWKmGdKJAUt/ji5tdJUZsZoft7+x6stev/EgBBf8NMfa8NWz1DI6aVL0Iv2sU17TWkKqWgk4mBGCs4yd3v31S6w18BQp7SOdheczegRymaKLWEJ3UjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNvM9MAb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755067534; x=1786603534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hUk3t9Brs/yZfYgqEuDcVscJZPbWDoP8jtXNQTZ+T6o=;
  b=gNvM9MAbr7zRfYU6aD0pV/C/9f0DVKnU+oSalQzwvUqAGJVhjE1ji8g7
   X/vD4plJRUH2HZ4yQC/zjzRjIewg3ce/Q+uXdsCPIoaQ7stFSEiQBsoDL
   cnp29SqjI/nWl8vTRa63hRyjUxjjHAJTSeRvuCVmXlkfOHaM/P2/lvXAL
   b2wLhG3TMAatbaib+LloLz8zkcRj6vxailA2WzSXkw73aj1D9l14abpZ2
   8yUxAmtRF8bNNKbQSmyclub7nAIJ7PxxMRoseliqMjw1LBwSN/TsAMA6F
   kciODfUc9IT9E07mD/I0+mGCMv1JmnWdsviMc2AcJfhNX1TomD6DhbRzd
   Q==;
X-CSE-ConnectionGUID: 74bP8cUtRZyaZrmO7ADwIw==
X-CSE-MsgGUID: 0E+viln2QsyuBdmG4Yt1tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56562131"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56562131"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 23:45:32 -0700
X-CSE-ConnectionGUID: v67WZlQhTnyaqlZ9fA85aA==
X-CSE-MsgGUID: zJwPJXuCSNe7mn6EDwu+5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="190094771"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.53])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 23:45:28 -0700
Date: Wed, 13 Aug 2025 14:45:25 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, yi1.lai@intel.com,
	ebiederm@xmission.com, jack@suse.cz, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 44/48] copy_tree(): don't link the mounts via mnt_list
Message-ID: <aJw0hU0u9smq8aHq@ly-workstation>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
 <20250630025255.1387419-44-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630025255.1387419-44-viro@zeniv.linux.org.uk>

Hi Al Viro,

Greetings!

I used Syzkaller and found that there is BUG: soft lockup in attach_recursive_mnt in linux-next next-20250812.

After bisection and the first bad commit is:
"
663206854f02 copy_tree(): don't link the mounts via mnt_list
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250813_093835_attach_recursive_mnt
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250813_093835_attach_recursive_mnt/repro.c
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250813_093835_attach_recursive_mnt/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250813_093835_attach_recursive_mnt/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250813_093835_attach_recursive_mnt/bzImage_next-20250812
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250813_093835_attach_recursive_mnt/next-20250812_dmesg.log

"
[   48.594242] watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [repro:724]
[   48.594264] Modules linked in:
[   48.594270] irq event stamp: 442328
[   48.594273] hardirqs last  enabled at (442327): [<ffffffff85da4465>] _raw_spin_unlock_irqrestore+0x35/0x70
[   48.594297] hardirqs last disabled at (442328): [<ffffffff85d749a4>] sysvec_apic_timer_interrupt+0x14/0xd0
[   48.594311] softirqs last  enabled at (442262): [<ffffffff814814ee>] __irq_exit_rcu+0x10e/0x170
[   48.594336] softirqs last disabled at (442257): [<ffffffff814814ee>] __irq_exit_rcu+0x10e/0x170
[   48.594354] CPU: 0 UID: 0 PID: 724 Comm: repro Tainted: G        W           6.17.0-rc1-next-20250812-next-2025081 #1 P
[   48.594367] Tainted: [W]=WARN
[   48.594370] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 044
[   48.594376] RIP: 0010:attach_recursive_mnt+0xf9a/0x1990
[   48.594394] Code: c1 e8 03 80 3c 18 00 0f 85 07 06 00 00 49 8d 7f 10 4d 8b 6f 70 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 855
[   48.594402] RSP: 0018:ff1100001282fbb0 EFLAGS: 00000246
[   48.594409] RAX: 1fe220000537eea2 RBX: dffffc0000000000 RCX: ffffffff820f5a86
[   48.594414] RDX: ff11000014570000 RSI: ffffffff820f5ad8 RDI: ff11000029bf7510
[   48.594419] RBP: ff1100001282fcd0 R08: 0000000000000001 R09: 0000000000000001
[   48.594424] R10: ff11000010902200 R11: ff11000014570e58 R12: ff11000029017c00
[   48.594429] R13: ff11000026b98220 R14: ff110000290b4070 R15: ff11000026b981c0
[   48.594435] FS:  00007f5edc748800(0000) GS:ff110000e3940000(0000) knlGS:0000000000000000
[   48.594441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.594445] CR2: 00007f5edc7491a8 CR3: 000000002110e001 CR4: 0000000000771ef0
[   48.594454] PKRU: 55555554
[   48.594456] Call Trace:
[   48.594460]  <TASK>
[   48.594474]  ? __pfx_attach_recursive_mnt+0x10/0x10
[   48.594488]  ? do_raw_spin_unlock+0x15c/0x210
[   48.594501]  ? _raw_spin_unlock+0x31/0x60
[   48.594511]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   48.594526]  ? clone_mnt+0x755/0xbd0
[   48.594541]  graft_tree+0x190/0x220
[   48.594552]  ? graft_tree+0x190/0x220
[   48.594566]  path_mount+0x1b0a/0x1f70
[   48.594578]  ? lockdep_hardirqs_on+0x89/0x110
[   48.594590]  ? trace_hardirqs_on+0x51/0x60
[   48.594607]  ? __pfx_path_mount+0x10/0x10
[   48.594618]  ? __kasan_slab_free+0x4f/0x60
[   48.594631]  ? kmem_cache_free+0x2ea/0x520
[   48.594643]  ? putname.part.0+0x132/0x180
[   48.594657]  ? putname.part.0+0x137/0x180
[   48.594669]  __x64_sys_mount+0x2a6/0x330
[   48.594680]  ? __x64_sys_mount+0x2a6/0x330
[   48.594694]  ? __pfx___x64_sys_mount+0x10/0x10
[   48.594713]  x64_sys_call+0x2127/0x2180
[   48.594722]  do_syscall_64+0x6d/0x2e0
[   48.594736]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   48.594744] RIP: 0033:0x7f5edc43ee5d
[   48.594755] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 898
[   48.594762] RSP: 002b:00007ffd1a883988 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[   48.594768] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5edc43ee5d
[   48.594773] RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000020000040
[   48.594778] RBP: 00007ffd1a883aa0 R08: 0000000000000000 R09: 0000000000000000
[   48.594782] R10: 0000000000001400 R11: 0000000000000246 R12: 00007ffd1a883bf8
[   48.594787] R13: 00000000004043b3 R14: 0000000000406e08 R15: 00007f5edc795000
[   48.594803]  </TASK>
[   48.594808] Kernel panic - not syncing: softlockup: hung tasks
[   48.615257] CPU: 0 UID: 0 PID: 724 Comm: repro Tainted: G        W    L      6.17.0-rc1-next-20250812-next-2025081 #1 P
[   48.616012] Tainted: [W]=WARN, [L]=SOFTLOCKUP
[   48.616285] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 044
[   48.616983] Call Trace:
[   48.617160]  <IRQ>
[   48.617299]  dump_stack_lvl+0x42/0x150
[   48.617544]  dump_stack+0x19/0x20
[   48.617762]  vpanic+0x6dd/0x770
[   48.617987]  ? __pfx_vpanic+0x10/0x10
[   48.618229]  ? show_trace_log_lvl+0x2c1/0x3c0
[   48.618512]  panic+0xc7/0xd0
[   48.618711]  ? __pfx_panic+0x10/0x10
[   48.618952]  ? watchdog_timer_fn+0x5a0/0x6c0
[   48.619242]  ? watchdog_timer_fn+0x593/0x6c0
[   48.619519]  watchdog_timer_fn+0x5b1/0x6c0
[   48.619779]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   48.620088]  __hrtimer_run_queues+0x6aa/0xb70
[   48.620379]  ? __pfx___hrtimer_run_queues+0x10/0x10
[   48.620696]  hrtimer_interrupt+0x397/0x870
[   48.620979]  __sysvec_apic_timer_interrupt+0x108/0x3b0
[   48.621330]  sysvec_apic_timer_interrupt+0xaf/0xd0
[   48.621631]  </IRQ>
[   48.621773]  <TASK>
[   48.621915]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   48.622253] RIP: 0010:attach_recursive_mnt+0xf9a/0x1990
[   48.622584] Code: c1 e8 03 80 3c 18 00 0f 85 07 06 00 00 49 8d 7f 10 4d 8b 6f 70 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 855
[   48.623711] RSP: 0018:ff1100001282fbb0 EFLAGS: 00000246
[   48.624042] RAX: 1fe220000537eea2 RBX: dffffc0000000000 RCX: ffffffff820f5a86
[   48.624480] RDX: ff11000014570000 RSI: ffffffff820f5ad8 RDI: ff11000029bf7510
[   48.624912] RBP: ff1100001282fcd0 R08: 0000000000000001 R09: 0000000000000001
[   48.625356] R10: ff11000010902200 R11: ff11000014570e58 R12: ff11000029017c00
[   48.625792] R13: ff11000026b98220 R14: ff110000290b4070 R15: ff11000026b981c0
[   48.626262]  ? attach_recursive_mnt+0xf16/0x1990
[   48.626559]  ? attach_recursive_mnt+0xf68/0x1990
[   48.626863]  ? __pfx_attach_recursive_mnt+0x10/0x10
[   48.627188]  ? do_raw_spin_unlock+0x15c/0x210
[   48.627465]  ? _raw_spin_unlock+0x31/0x60
[   48.627724]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   48.628076]  ? clone_mnt+0x755/0xbd0
[   48.628313]  graft_tree+0x190/0x220
[   48.628539]  ? graft_tree+0x190/0x220
[   48.628783]  path_mount+0x1b0a/0x1f70
[   48.629034]  ? lockdep_hardirqs_on+0x89/0x110
[   48.629313]  ? trace_hardirqs_on+0x51/0x60
[   48.629579]  ? __pfx_path_mount+0x10/0x10
[   48.629837]  ? __kasan_slab_free+0x4f/0x60
[   48.630121]  ? kmem_cache_free+0x2ea/0x520
[   48.630384]  ? putname.part.0+0x132/0x180
[   48.630644]  ? putname.part.0+0x137/0x180
[   48.630901]  __x64_sys_mount+0x2a6/0x330
[   48.631186]  ? __x64_sys_mount+0x2a6/0x330
[   48.631452]  ? __pfx___x64_sys_mount+0x10/0x10
[   48.631744]  x64_sys_call+0x2127/0x2180
[   48.632000]  do_syscall_64+0x6d/0x2e0
[   48.632239]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   48.632555] RIP: 0033:0x7f5edc43ee5d
[   48.632787] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 898
[   48.633901] RSP: 002b:00007ffd1a883988 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[   48.634375] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5edc43ee5d
[   48.634812] RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000020000040
[   48.635282] RBP: 00007ffd1a883aa0 R08: 0000000000000000 R09: 0000000000000000
[   48.635711] R10: 0000000000001400 R11: 0000000000000246 R12: 00007ffd1a883bf8
[   48.636154] R13: 00000000004043b3 R14: 0000000000406e08 R15: 00007f5edc795000
[   48.636600]  </TASK>
[   48.636838] Kernel Offset: disabled
[   48.637081] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install
 
On Mon, Jun 30, 2025 at 03:52:51AM +0100, Al Viro wrote:
> The only place that really needs to be adjusted is commit_tree() -
> there we need to iterate through the copy and we might as well
> use next_mnt() for that.  However, in case when our tree has been
> slid under something already mounted (propagation to a mountpoint
> that already has something mounted on it or a 'beneath' move_mount)
> we need to take care not to walk into the overmounting tree.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/mount.h     |  3 +--
>  fs/namespace.c | 60 ++++++++++++++++++++------------------------------
>  fs/pnode.c     |  3 ++-
>  3 files changed, 27 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 08583428b10b..97737051a8b9 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -193,7 +193,7 @@ static inline bool mnt_ns_empty(const struct mnt_namespace *ns)
>  	return RB_EMPTY_ROOT(&ns->mounts);
>  }
>  
> -static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
> +static inline void move_from_ns(struct mount *mnt)
>  {
>  	struct mnt_namespace *ns = mnt->mnt_ns;
>  	WARN_ON(!mnt_ns_attached(mnt));
> @@ -203,7 +203,6 @@ static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
>  		ns->mnt_first_node = rb_next(&mnt->mnt_node);
>  	rb_erase(&mnt->mnt_node, &ns->mounts);
>  	RB_CLEAR_NODE(&mnt->mnt_node);
> -	list_add_tail(&mnt->mnt_list, dt_list);
>  }
>  
>  bool has_locked_children(struct mount *mnt, struct dentry *dentry);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 38a46b32413d..bd6c7da901fc 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1161,34 +1161,6 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
>  	mnt_notify_add(mnt);
>  }
>  
> -/*
> - * vfsmount lock must be held for write
> - */
> -static void commit_tree(struct mount *mnt)
> -{
> -	struct mount *parent = mnt->mnt_parent;
> -	struct mount *m;
> -	LIST_HEAD(head);
> -	struct mnt_namespace *n = parent->mnt_ns;
> -
> -	BUG_ON(parent == mnt);
> -
> -	if (!mnt_ns_attached(mnt)) {
> -		list_add_tail(&head, &mnt->mnt_list);
> -		while (!list_empty(&head)) {
> -			m = list_first_entry(&head, typeof(*m), mnt_list);
> -			list_del(&m->mnt_list);
> -
> -			mnt_add_to_ns(n, m);
> -		}
> -		n->nr_mounts += n->pending_mounts;
> -		n->pending_mounts = 0;
> -	}
> -
> -	make_visible(mnt);
> -	touch_mnt_namespace(n);
> -}
> -
>  static struct mount *next_mnt(struct mount *p, struct mount *root)
>  {
>  	struct list_head *next = p->mnt_mounts.next;
> @@ -1215,6 +1187,27 @@ static struct mount *skip_mnt_tree(struct mount *p)
>  	return p;
>  }
>  
> +/*
> + * vfsmount lock must be held for write
> + */
> +static void commit_tree(struct mount *mnt)
> +{
> +	struct mnt_namespace *n = mnt->mnt_parent->mnt_ns;
> +
> +	if (!mnt_ns_attached(mnt)) {
> +		for (struct mount *m = mnt; m; m = next_mnt(m, mnt))
> +			if (unlikely(mnt_ns_attached(m)))
> +				m = skip_mnt_tree(m);
> +			else
> +				mnt_add_to_ns(n, m);
> +		n->nr_mounts += n->pending_mounts;
> +		n->pending_mounts = 0;
> +	}
> +
> +	make_visible(mnt);
> +	touch_mnt_namespace(n);
> +}
> +
>  /**
>   * vfs_create_mount - Create a mount for a configured superblock
>   * @fc: The configuration context with the superblock attached
> @@ -1831,9 +1824,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
>  	for (p = mnt; p; p = next_mnt(p, mnt)) {
>  		p->mnt.mnt_flags |= MNT_UMOUNT;
>  		if (mnt_ns_attached(p))
> -			move_from_ns(p, &tmp_list);
> -		else
> -			list_move(&p->mnt_list, &tmp_list);
> +			move_from_ns(p);
> +		list_add_tail(&p->mnt_list, &tmp_list);
>  	}
>  
>  	/* Hide the mounts from mnt_mounts */
> @@ -2270,7 +2262,6 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
>  					list_add(&dst_mnt->mnt_expire,
>  						 &src_mnt->mnt_expire);
>  			}
> -			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
>  			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp);
>  			unlock_mount_hash();
>  		}
> @@ -2686,12 +2677,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  		list_del_init(&source_mnt->mnt_expire);
>  	} else {
>  		if (source_mnt->mnt_ns) {
> -			LIST_HEAD(head);
> -
>  			/* move from anon - the caller will destroy */
>  			for (p = source_mnt; p; p = next_mnt(p, source_mnt))
> -				move_from_ns(p, &head);
> -			list_del_init(&head);
> +				move_from_ns(p);
>  		}
>  	}
>  
> diff --git a/fs/pnode.c b/fs/pnode.c
> index cbf5f5746252..81f7599bdac4 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -449,7 +449,8 @@ static void umount_one(struct mount *m, struct list_head *to_umount)
>  {
>  	m->mnt.mnt_flags |= MNT_UMOUNT;
>  	list_del_init(&m->mnt_child);
> -	move_from_ns(m, to_umount);
> +	move_from_ns(m);
> +	list_add_tail(&m->mnt_list, to_umount);
>  }
>  
>  static void remove_from_candidate_list(struct mount *m)
> -- 
> 2.39.5
> 

