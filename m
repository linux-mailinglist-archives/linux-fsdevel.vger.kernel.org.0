Return-Path: <linux-fsdevel+bounces-73525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F012D1C209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 03:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB608301E901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 02:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260652FD7B1;
	Wed, 14 Jan 2026 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyNju1Oh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AE2E401;
	Wed, 14 Jan 2026 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357623; cv=none; b=X2xfTsb13wybnR3GirZfS3XyNWIFdh0OUmlxMMO5sMew4muVMFX1RWPRwscK3XYV9fEQSFQVLoHm183vXPazR+bUvMRHVFptsAJqd3wzIDnoyxvMDwgOGE6mBMwcual0M4dtMR3+UPW2alYMd90lmAdcsNgW/jQA/NQdxLc0Mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357623; c=relaxed/simple;
	bh=98FYcdnmtld0LV4tKVtmnYrJ5aXGiOWyci7erj16KoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmwMtD/tihOGI7vIcgc/8RkfaeqUEPhS9BPqvrcnS+yfJ87Uwbi5KYtmQ3sncOrf0jzGXtv0dn2jayOoO590yKFzz3C5sTstTxDgoEKA+oB9gUQkDuJncH5D2SUole+apMnfFy7po59OO1x0PFOHxtxuXiWDBOWy4wu7MLE2pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyNju1Oh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768357622; x=1799893622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=98FYcdnmtld0LV4tKVtmnYrJ5aXGiOWyci7erj16KoU=;
  b=QyNju1Ohi+y4X44trw+OK5UL6XwWRd1b7KEHj53BkHClyKphnIEq4aFj
   kY73A9X5XK1zKfiPf3QxzUiIrmNFick8WdyPVfodSG6EUmxj+CUWpJU1R
   eekCXL0Q4aRSx6kt5Zqu1wHcPWq7OPdg5Pk5iBVYCjA0+t0eVleXa3Vyg
   ivQ7jsG1kiourYXmPa7jXo3xb5EFgw4ptwvewR1LL51nW4QOGnQuerayX
   jMOBZTttGY7Mg9NC/gxApIw3NpQw04QocSuhzmzPjWUmiLd7tBy372zbw
   sImpOXN6ZR0t/34N8CWLyWYpZIJ1WT+zrNjrMITNn/aNbORaeppLD+KyL
   g==;
X-CSE-ConnectionGUID: nqgl5wXRT/qorHAiCmB+jQ==
X-CSE-MsgGUID: kL7rA03qQ+m4U8qi2HUj7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73493075"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="73493075"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 18:27:01 -0800
X-CSE-ConnectionGUID: PyFOs07MQGu43NN71Stoww==
X-CSE-MsgGUID: 04Kcg0Z1SkG/tsgoGejWnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209397185"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 18:26:59 -0800
Date: Wed, 14 Jan 2026 10:26:55 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: make insert_inode_locked() wait for inode destruction
Message-ID: <aWb+7/g7Nz1zfFSp@ly-workstation>
References: <20260111083843.651167-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111083843.651167-1-mjguzik@gmail.com>

On Sun, Jan 11, 2026 at 09:38:42AM +0100, Mateusz Guzik wrote:
> This is the only routine which instead skipped instead of waiting.
> 
> The current behavior is arguably a bug as it results in a corner case
> where the inode hash can have *two* matching inodes, one of which is on
> its way out.
> 
> Ironing out this difference is an incremental step towards sanitizing
> the API.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/inode.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f8904f813372..3b838f07cb40 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1832,16 +1832,13 @@ int insert_inode_locked(struct inode *inode)
>  	while (1) {
>  		struct inode *old = NULL;
>  		spin_lock(&inode_hash_lock);
> +repeat:
>  		hlist_for_each_entry(old, head, i_hash) {
>  			if (old->i_ino != ino)
>  				continue;
>  			if (old->i_sb != sb)
>  				continue;
>  			spin_lock(&old->i_lock);
> -			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> -				spin_unlock(&old->i_lock);
> -				continue;
> -			}
>  			break;
>  		}
>  		if (likely(!old)) {
> @@ -1852,6 +1849,11 @@ int insert_inode_locked(struct inode *inode)
>  			spin_unlock(&inode_hash_lock);
>  			return 0;
>  		}
> +		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> +			__wait_on_freeing_inode(old, true);
> +			old = NULL;
> +			goto repeat;
> +		}
>  		if (unlikely(inode_state_read(old) & I_CREATING)) {
>  			spin_unlock(&old->i_lock);
>  			spin_unlock(&inode_hash_lock);
> -- 
> 2.48.1
>

Hi Mateusz Guzik,

Greetings!

I used Syzkaller and found that there is WARNING: bad unlock balance in __wait_on_freeing_inode in linux-next next-20260113.

After bisection and the first bad commit is:
"
757b907b3ead fs: make insert_inode_locked() wait for inode destruction
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/260113_160659___wait_on_freeing_inode
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/260113_160659___wait_on_freeing_inode/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/260113_160659___wait_on_freeing_inode/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/260113_160659___wait_on_freeing_inode/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/260113_160659___wait_on_freeing_inode/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/260113_160659___wait_on_freeing_inode/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/260113_160659___wait_on_freeing_inode/bzImage_0f853ca2a798ead9d24d39cad99b0966815c582a
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/260113_160659___wait_on_freeing_inode/0f853ca2a798ead9d24d39cad99b0966815c582a_dmesg.log

"
[   57.740820] =====================================
[   57.741171] WARNING: bad unlock balance detected!
[   57.741521] 6.19.0-rc5-next-20260113-0f853ca2a798 #1 Not tainted
[   57.741960] -------------------------------------
[   57.742317] repro/663 is trying to release lock (rcu_read_lock) at:
[   57.742831] [<ffffffff821343ea>] __wait_on_freeing_inode+0x13a/0x3b0
[   57.743361] but there are no more locks to release!
[   57.743744]
[   57.743744] other info that might help us debug this:
[   57.744238] 4 locks held by repro/663:
[   57.744531]  #0: ffff888012d42408 (sb_writers#3){.+.+}-{0:0}, at: filename_create+0x122/0x460
[   57.745228]  #1: ffff88802685d9f0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_create+0x1e6/0x460
[   57.746024]  #2: ffff888012d54950 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1042/0x1550
[   57.746741]  #3: ffffffff87416918 (inode_hash_lock){+.+.}-{3:3}, at: insert_inode_locked+0xf4/0x860
[   57.747472]
[   57.747472] stack backtrace:
[   57.747831] CPU: 1 UID: 0 PID: 663 Comm: repro Not tainted 6.19.0-rc5-next-20260113-0f853ca2a798 #1 PREEMPT(lazy)
[   57.747849] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org4
[   57.747860] Call Trace:
[   57.747873]  <TASK>
[   57.747882]  dump_stack_lvl+0xea/0x150
[   57.747932]  ? __wait_on_freeing_inode+0x13a/0x3b0
[   57.747946]  dump_stack+0x19/0x20
[   57.747965]  print_unlock_imbalance_bug+0x121/0x140
[   57.748003]  ? __wait_on_freeing_inode+0x13a/0x3b0
[   57.748017]  lock_release+0x211/0x2a0
[   57.748031]  __wait_on_freeing_inode+0x13f/0x3b0
[   57.748046]  ? __pfx___wait_on_freeing_inode+0x10/0x10
[   57.748060]  ? do_raw_spin_lock+0x140/0x280
[   57.748081]  ? __pfx_var_wake_function+0x10/0x10
[   57.748097]  ? __this_cpu_preempt_check+0x21/0x30
[   57.748117]  ? lock_is_held_type+0xef/0x150
[   57.748138]  insert_inode_locked+0x26c/0x860
[   57.748155]  __ext4_new_inode+0x1c4a/0x5230
[   57.748192]  ? __pfx___ext4_new_inode+0x10/0x10
[   57.748211]  ? __pfx___dquot_initialize+0x10/0x10
[   57.748238]  ? ext4_lookup+0xe7/0x710
[   57.748254]  ? __this_cpu_preempt_check+0x21/0x30
[   57.748269]  ext4_mkdir+0x360/0xb70
[   57.748285]  ? __pfx_ext4_mkdir+0x10/0x10
[   57.748296]  ? security_inode_permission+0xb8/0x220
[   57.748327]  ? inode_permission+0x39d/0x690
[   57.748341]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   57.748372]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   57.748391]  vfs_mkdir+0x6d1/0xbe0
[   57.748409]  do_mkdirat+0x48e/0x610
[   57.748424]  ? __pfx_do_mkdirat+0x10/0x10
[   57.748434]  ? strncpy_from_user+0x198/0x290
[   57.748473]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   57.748490]  ? do_getname+0x19e/0x3e0
[   57.748503]  __x64_sys_mkdir+0x70/0x90
[   57.748515]  x64_sys_call+0x1f87/0x21b0
[   57.748540]  do_syscall_64+0x6d/0x1180
[   57.748560]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   57.748572] RIP: 0033:0x7f0700a3e7bb
[   57.748596] Code: 73 01 c3 48 8b 0d 65 b6 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f8
[   57.748607] RSP: 002b:00007ffd03360d18 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
[   57.748625] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0700a3e7bb
[   57.748635] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffd03360d20
[   57.748641] RBP: 00007ffd03360d60 R08: 0000000000000000 R09: 00007ffd03360ab5
[   57.748648] R10: 0000000000000169 R11: 0000000000000206 R12: 00007ffd03360e88
[   57.748655] R13: 0000000000401bd1 R14: 0000000000403e08 R15: 00007f0700d78000
[   57.748686]  </TASK>
[   57.767776] ------------[ cut here ]------------
[   57.768140] WARNING: kernel/rcu/tree_plugin.h:443 at __rcu_read_unlock+0x2da/0x620, CPU#1: repro/663
[   57.768917] Modules linked in:
[   57.769205] CPU: 1 UID: 0 PID: 663 Comm: repro Not tainted 6.19.0-rc5-next-20260113-0f853ca2a798 #1 PREEMPT(lazy)
[   57.770002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org4
[   57.770904] RIP: 0010:__rcu_read_unlock+0x2da/0x620
[   57.771347] Code: c7 43 58 01 00 00 00 bf 09 00 00 00 e8 9f d2 d9 ff 4d 85 f6 0f 84 13 fe ff ff e8 21 10 29 00 fb 0f0
[   57.772820] RSP: 0018:ffff88801a1cf958 EFLAGS: 00010286
[   57.773242] RAX: 00000000ffffffff RBX: ffff88801c31cb00 RCX: ffffffff8167cc23
[   57.773815] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff88801c31d33c
[   57.774380] RBP: ffff88801a1cf980 R08: 0000000000000000 R09: fffffbfff0eaed8c
[   57.774950] R10: 0000000080000001 R11: 6162206b63617473 R12: ffff88801c31cb00
[   57.775556] R13: ffff88801c31cb00 R14: 0000000000000001 R15: 0000000000000001
[   57.776114] FS:  00007f0700d2b740(0000) GS:ffff8880e317a000(0000) knlGS:0000000000000000
[   57.776749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.777196] CR2: 00000000313712d8 CR3: 00000000174b6005 CR4: 0000000000770ef0
[   57.777760] PKRU: 55555554
[   57.777996] Call Trace:
[   57.778206]  <TASK>
[   57.778848]  __wait_on_freeing_inode+0x144/0x3b0
[   57.779549]  ? __pfx___wait_on_freeing_inode+0x10/0x10
[   57.780006]  ? do_raw_spin_lock+0x140/0x280
[   57.780785]  ? __pfx_var_wake_function+0x10/0x10
[   57.781516]  ? __this_cpu_preempt_check+0x21/0x30
[   57.782096]  ? lock_is_held_type+0xef/0x150
[   57.783066]  insert_inode_locked+0x26c/0x860
[   57.784411]  __ext4_new_inode+0x1c4a/0x5230
[   57.786492]  ? __pfx___ext4_new_inode+0x10/0x10
[   57.787249]  ? __pfx___dquot_initialize+0x10/0x10
[   57.787692]  ? ext4_lookup+0xe7/0x710
[   57.788736]  ? __this_cpu_preempt_check+0x21/0x30
[   57.789906]  ext4_mkdir+0x360/0xb70
[   57.791512]  ? __pfx_ext4_mkdir+0x10/0x10
[   57.791878]  ? security_inode_permission+0xb8/0x220
[   57.792653]  ? inode_permission+0x39d/0x690
[   57.793027]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   57.793494]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   57.794522]  vfs_mkdir+0x6d1/0xbe0
[   57.795734]  do_mkdirat+0x48e/0x610
[   57.796959]  ? __pfx_do_mkdirat+0x10/0x10
[   57.797316]  ? strncpy_from_user+0x198/0x290
[   57.798228]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   57.798770]  ? do_getname+0x19e/0x3e0
[   57.799756]  __x64_sys_mkdir+0x70/0x90
[   57.800330]  x64_sys_call+0x1f87/0x21b0
[   57.800783]  do_syscall_64+0x6d/0x1180
[   57.801468]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   57.801912] RIP: 0033:0x7f0700a3e7bb
[   57.802246] Code: 73 01 c3 48 8b 0d 65 b6 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f8
[   57.803723] RSP: 002b:00007ffd03360d18 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
[   57.804334] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0700a3e7bb
[   57.804903] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffd03360d20
[   57.805473] RBP: 00007ffd03360d60 R08: 0000000000000000 R09: 00007ffd03360ab5
[   57.806030] R10: 0000000000000169 R11: 0000000000000206 R12: 00007ffd03360e88
[   57.806599] R13: 0000000000401bd1 R14: 0000000000403e08 R15: 00007f0700d78000
[   57.808920]  </TASK>
[   57.809108] irq event stamp: 253367
[   57.809384] hardirqs last  enabled at (253367): [<ffffffff85f3bbe5>] _raw_spin_unlock_irqrestore+0x35/0x70
[   57.810226] hardirqs last disabled at (253366): [<ffffffff85f3b890>] _raw_spin_lock_irqsave+0x70/0x80
[   57.810996] softirqs last  enabled at (253362): [<ffffffff8131c2e1>] kernel_fpu_end+0x71/0x90
[   57.811769] softirqs last disabled at (253360): [<ffffffff8131db8f>] kernel_fpu_begin_mask+0x1df/0x320
[   57.812549] ---[ end trace 0000000000000000 ]---
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
 

