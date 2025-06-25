Return-Path: <linux-fsdevel+bounces-52858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ABAAE79BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DE04A178D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7CD21FF37;
	Wed, 25 Jun 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KV4oh9td"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AA4215F6B;
	Wed, 25 Jun 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839300; cv=none; b=O5MWDfb4k6hgWoHzDJw1YFoUp2KOmzjiOPqHOuKDZZUpEe+DcdO6n09SF/uMhnX2/0k/YGRwVHUwDbcX9DYDUkzc0BP6tb/jUTACE8mjPwFIs9u1Jdrrz3mPJ14DlXpXhvLoreVrmkQrEAyHNofLvNQMG497Ie0Uv1b0fUVwy44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839300; c=relaxed/simple;
	bh=v5Y8MCI2gC3RhLjDqlgfq7G8zV71aKSw/KVVVjWMPR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCEsdqsm2mh5DlKPA9CugJ7nenHZD2sqz/Ttne0U2NQ9/rVWZtugWKw5rmiBtK8Y+YiSLJMlO5nY12nHOxJZykNtpZtBm5PQFrfgUgLE4MUY4rQR3ml2dBy4YFgPnqg6IvK8XK9BAnXpEWYcdl/RNar3hEsgU205x+0vuXV00+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KV4oh9td; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750839298; x=1782375298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v5Y8MCI2gC3RhLjDqlgfq7G8zV71aKSw/KVVVjWMPR8=;
  b=KV4oh9tdM9aNWnli8hNwczvzSn0NZVGGrE5nOW/OZ8o5NkO2vTN4F4QR
   WR8FQa3NrX78oJzTxBeFlJLF0U/QZ5jw8JHKkEMK7/vJa4h5ySJukzmE5
   DtddjBQjFAA3/uoawIl2c8MuCQqSIE5dashXnlOjTeANoKMdaOEFc1fIZ
   SN7EwCEnF+0kXvwOYUwquSv4OEmbAn8s+zfoGKjaS6fYXUosrvmuGGTGo
   +1Mvr/cLuEeiIZLJPsluqkfRtvTLbmezBtYl4qnDVA7EA3B2Fm4+RCptk
   oVhwzUDCCuH2yBvjPqsusjs8rX+yrirzNwyMds1ZlVcnAn4HNV5UDwvbG
   A==;
X-CSE-ConnectionGUID: Dd7QP+gSSoqYQ1S+Tgyjbw==
X-CSE-MsgGUID: 9MTU1nc2Rim9HP3f1UE6Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53066208"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53066208"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:14:57 -0700
X-CSE-ConnectionGUID: m2My5347RwSd7+FzFrPGNQ==
X-CSE-MsgGUID: 5lWrWidiSGuLzY61iyhghg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="183182255"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.35.3])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:14:53 -0700
Date: Wed, 25 Jun 2025 16:14:49 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
	yi1.lai@intel.com
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
Message-ID: <aFuv+bNk4LyqaSNU@ly-workstation>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-9-yi.zhang@huaweicloud.com>

Hi Zhang Yi,

Greetings!

I used Syzkaller and found that there is general protection fault in try_to_unmap_one in linux-next next-20250623.

After bisection and the first bad commit is:
"
7ac67301e82f ext4: enable large folio for regular file
"

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250624_222435_try_to_unmap_one
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250624_222435_try_to_unmap_one/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250624_222435_try_to_unmap_one/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250624_222435_try_to_unmap_one/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250624_222435_try_to_unmap_one/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250624_222435_try_to_unmap_one/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250624_222435_try_to_unmap_one/bzImage_86731a2a651e58953fc949573895f2fa6d456841
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250624_222435_try_to_unmap_one/86731a2a651e58953fc949573895f2fa6d456841_dmesg.log

"
[   48.166741] Injecting memory failure for pfn 0x28c00 at process virtual address 0x20ffc000
[   48.167878] Memory failure: 0x28c00: Sending SIGBUS to repro:668 due to hardware memory corruption
[   48.169079] Memory failure: 0x28c00: recovery action for unsplit thp: Failed
[   48.657334] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASI
[   48.658081] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   48.658561] CPU: 0 UID: 0 PID: 675 Comm: repro Not tainted 6.16.0-rc3-86731a2a651e #1 PREEMPT(voluntary)
[   48.659153] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org4
[   48.659862] RIP: 0010:try_to_unmap_one+0x4ef/0x3860
[   48.660204] Code: f5 a5 ff 48 8b 9d 78 ff ff ff 49 8d 46 18 48 89 85 70 fe ff ff 48 85 db 0f 84 96 1a 00 00 e8 c8 f58
[   48.661345] RSP: 0018:ffff88801a55ebc0 EFLAGS: 00010246
[   48.661685] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81e1a1a1
[   48.662136] RDX: ffff888014502540 RSI: ffffffff81e186c8 RDI: 0000000000000005
[   48.662584] RBP: ffff88801a55ed90 R08: 0000000000000001 R09: ffffed10034abd3b
[   48.663030] R10: 0000000000000000 R11: ffff888014503398 R12: 0000000020e00000
[   48.663490] R13: ffffea0000a30000 R14: ffffea0000a30000 R15: dffffc0000000000
[   48.663950] FS:  00007f2e4c104740(0000) GS:ffff8880e3562000(0000) knlGS:0000000000000000
[   48.664464] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.664836] CR2: 0000000021000000 CR3: 00000000115ae003 CR4: 0000000000770ef0
[   48.665297] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   48.665756] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   48.666210] PKRU: 55555554
[   48.666398] Call Trace:
[   48.666569]  <TASK>
[   48.666729]  ? __pfx_try_to_unmap_one+0x10/0x10
[   48.667048]  __rmap_walk_file+0x2a5/0x4a0
[   48.667324]  rmap_walk+0x16b/0x1f0
[   48.667563]  try_to_unmap+0x12f/0x140
[   48.667818]  ? __pfx_try_to_unmap+0x10/0x10
[   48.668104]  ? __pfx_try_to_unmap_one+0x10/0x10
[   48.668408]  ? __pfx_folio_not_mapped+0x10/0x10
[   48.668713]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
[   48.669066]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   48.669438]  unmap_poisoned_folio+0x130/0x500
[   48.669743]  shrink_folio_list+0x44f/0x3d90
[   48.670036]  ? stack_depot_save_flags+0x445/0xa40
[   48.670366]  ? __this_cpu_preempt_check+0x21/0x30
[   48.670711]  ? lockdep_hardirqs_on+0x89/0x110
[   48.671014]  ? __pfx_shrink_folio_list+0x10/0x10
[   48.671325]  ? is_bpf_text_address+0x94/0x1b0
[   48.671628]  ? debug_smp_processor_id+0x20/0x30
[   48.671937]  ? is_bpf_text_address+0x9e/0x1b0
[   48.672232]  ? kernel_text_address+0xd3/0xe0
[   48.672538]  ? __kernel_text_address+0x16/0x50
[   48.672845]  ? unwind_get_return_address+0x65/0xb0
[   48.673178]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   48.673540]  ? arch_stack_walk+0xa1/0xf0
[   48.673826]  reclaim_folio_list+0xe2/0x4c0
[   48.674104]  ? check_path.constprop.0+0x28/0x50
[   48.674422]  ? __pfx_reclaim_folio_list+0x10/0x10
[   48.674750]  ? folio_isolate_lru+0x38c/0x590
[   48.675047]  reclaim_pages+0x393/0x560
[   48.675306]  ? __pfx_reclaim_pages+0x10/0x10
[   48.675605]  ? do_raw_spin_unlock+0x15c/0x210
[   48.675900]  madvise_cold_or_pageout_pte_range+0x1cac/0x2800
[   48.676287]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
[   48.676687]  ? lock_is_held_type+0xef/0x150
[   48.676975]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
[   48.677372]  walk_pgd_range+0xe2d/0x2420
[   48.677654]  ? __pfx_walk_pgd_range+0x10/0x10
[   48.677955]  __walk_page_range+0x177/0x810
[   48.678236]  ? find_vma+0xc4/0x140
[   48.678478]  ? __pfx_find_vma+0x10/0x10
[   48.678746]  ? __this_cpu_preempt_check+0x21/0x30
[   48.679062]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   48.679428]  walk_page_range_mm+0x39f/0x770
[   48.679718]  ? __pfx_walk_page_range_mm+0x10/0x10
[   48.680038]  ? __this_cpu_preempt_check+0x21/0x30
[   48.680355]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   48.680713]  ? mlock_drain_local+0x27f/0x4b0
[   48.681006]  walk_page_range+0x70/0xa0
[   48.681263]  ? __kasan_check_write+0x18/0x20
[   48.681562]  madvise_do_behavior+0x13e3/0x35f0
[   48.681874]  ? copy_vma_and_data+0x353/0x7d0
[   48.682169]  ? __pfx_madvise_do_behavior+0x10/0x10
[   48.682497]  ? __pfx_arch_get_unmapped_area_topdown+0x10/0x10
[   48.682885]  ? __this_cpu_preempt_check+0x21/0x30
[   48.683203]  ? lock_is_held_type+0xef/0x150
[   48.683494]  ? __lock_acquire+0x412/0x22a0
[   48.683789]  ? __this_cpu_preempt_check+0x21/0x30
[   48.684108]  ? lock_acquire+0x180/0x310
[   48.684381]  ? __pfx_down_read+0x10/0x10
[   48.684656]  ? __lock_acquire+0x412/0x22a0
[   48.684953]  ? __pfx___do_sys_mremap+0x10/0x10
[   48.685257]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[   48.685603]  do_madvise+0x193/0x2b0
[   48.685852]  ? do_madvise+0x193/0x2b0
[   48.686122]  ? __pfx_do_madvise+0x10/0x10
[   48.686401]  ? __this_cpu_preempt_check+0x21/0x30
[   48.686715]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   48.687154]  ? lockdep_hardirqs_on+0x89/0x110
[   48.687457]  ? trace_hardirqs_on+0x51/0x60
[   48.687751]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   48.688162]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[   48.688492]  ? ktime_get_coarse_real_ts64+0xad/0xf0
[   48.688823]  ? __audit_syscall_entry+0x39c/0x500
[   48.689134]  __x64_sys_madvise+0xb2/0x120
[   48.689411]  ? syscall_trace_enter+0x14d/0x280
[   48.689720]  x64_sys_call+0x19ac/0x2150
[   48.689987]  do_syscall_64+0x6d/0x2e0
[   48.690248]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   48.690583] RIP: 0033:0x7f2e4be3ee5d
[   48.690842] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d8
[   48.692016] RSP: 002b:00007ffeb3fe8e68 EFLAGS: 00000217 ORIG_RAX: 000000000000001c
[   48.692503] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2e4be3ee5d
[   48.692978] RDX: 0000000000000015 RSI: 0000000000c00000 RDI: 0000000020400000
[   48.693435] RBP: 00007ffeb3fe8e80 R08: 00007ffeb3fe8e80 R09: 00007ffeb3fe8e80
[   48.693886] R10: 0000000020fc6000 R11: 0000000000000217 R12: 00007ffeb3fe8fd8
[   48.694344] R13: 00000000004018e5 R14: 0000000000403e08 R15: 00007f2e4c151000
[   48.694811]  </TASK>
[   48.694967] Modules linked in:
[   48.695320] ---[ end trace 0000000000000000 ]---
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


On Mon, May 12, 2025 at 02:33:19PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Besides fsverity, fscrypt, and the data=journal mode, ext4 now supports
> large folios for regular files. Enable this feature by default. However,
> since we cannot change the folio order limitation of mappings on active
> inodes, setting the journal=data mode via ioctl on an active inode will
> not take immediate effect in non-delalloc mode.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/ext4.h      |  1 +
>  fs/ext4/ext4_jbd2.c |  3 ++-
>  fs/ext4/ialloc.c    |  3 +++
>  fs/ext4/inode.c     | 20 ++++++++++++++++++++
>  4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..2fad90c30493 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2993,6 +2993,7 @@ int ext4_walk_page_buffers(handle_t *handle,
>  				     struct buffer_head *bh));
>  int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  				struct buffer_head *bh);
> +bool ext4_should_enable_large_folio(struct inode *inode);
>  #define FALL_BACK_TO_NONDELALLOC 1
>  #define CONVERT_INLINE_DATA	 2
>  
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 135e278c832e..b3e9b7bd7978 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -16,7 +16,8 @@ int ext4_inode_journal_mode(struct inode *inode)
>  	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
>  	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
>  	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
> -	    !test_opt(inode->i_sb, DELALLOC))) {
> +	    !test_opt(inode->i_sb, DELALLOC) &&
> +	    !mapping_large_folio_support(inode->i_mapping))) {
>  		/* We do not support data journalling for encrypted data */
>  		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
>  			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index e7ecc7c8a729..4938e78cbadc 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1336,6 +1336,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		}
>  	}
>  
> +	if (ext4_should_enable_large_folio(inode))
> +		mapping_set_large_folios(inode->i_mapping);
> +
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  
>  	err = ext4_mark_inode_dirty(handle, inode);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 29eccdf8315a..7fd3921cfe46 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4774,6 +4774,23 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>  	return -EFSCORRUPTED;
>  }
>  
> +bool ext4_should_enable_large_folio(struct inode *inode)
> +{
> +	struct super_block *sb = inode->i_sb;
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return false;
> +	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> +	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +		return false;
> +	if (ext4_has_feature_verity(sb))
> +		return false;
> +	if (ext4_has_feature_encrypt(sb))
> +		return false;
> +
> +	return true;
> +}
> +
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  			  ext4_iget_flags flags, const char *function,
>  			  unsigned int line)
> @@ -5096,6 +5113,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		ret = -EFSCORRUPTED;
>  		goto bad_inode;
>  	}
> +	if (ext4_should_enable_large_folio(inode))
> +		mapping_set_large_folios(inode->i_mapping);
> +
>  	ret = check_igot_inode(inode, flags, function, line);
>  	/*
>  	 * -ESTALE here means there is nothing inherently wrong with the inode,
> -- 
> 2.46.1
> 

