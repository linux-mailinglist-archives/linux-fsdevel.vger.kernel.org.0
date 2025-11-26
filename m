Return-Path: <linux-fsdevel+bounces-69873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD28C8959D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498643B2F31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 10:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FF631B838;
	Wed, 26 Nov 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcxCeMcv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85531AF33;
	Wed, 26 Nov 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153777; cv=none; b=FPSazhbKz8VlQ76fHipoYqgtq0zyAejwNmTwbtSsIb1dqyC9UPzyb1FukAcjDAa6qy/sy1xcPzTWu/HAxKu5E+ieV1m1EfF6+yBdnmApW7gNiKATQwmYaVNVND5RCMf85Jpe9/VECVH31KsVk1CmRjmzr5x8Xhy+RMMXmWha45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153777; c=relaxed/simple;
	bh=lbpZf9gg/RcL75ufLv278uL0wL+ezAd+BmzUYqMcMf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maz0v5EPe+uMB6/FdOINrvGPpm0CNMyLp6OgfjjLPdDkBu76v8yKcWOHqDVYxAQgzij1lOGVPDzcsrhnCXBeeUJ1Gb6KKHAsfC+8fDFAxSkH1HDRp3W2y7WiGBh4+k0+eUTIS+orsd9qAhkmy1HdrHZH5351kIMoQWd5aY7+QRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcxCeMcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEF7C113D0;
	Wed, 26 Nov 2025 10:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153777;
	bh=lbpZf9gg/RcL75ufLv278uL0wL+ezAd+BmzUYqMcMf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcxCeMcvJQHMi1iiutCQRXYS2XFOyjsUtZsWrkE/Dh+pXe/7hA7oNNq2GWVe+4GEP
	 TJH2jeGIrebRwSGb+ngB0bZEDBmcfi2aOSx2josMWsuuIEZy/gByYTREW3TVhp0khp
	 Hb/ejwQYl45W0VLUYg3E4mEvoZTo4tGb/F/N13DELJG9VIUxyuzYISWWIXi9dU40RI
	 a1AaE7AzCBflH5CGAUA69ywVw9u31sV+lL6CDNQnGwwQ297xzePm5sF7if0KFSLH+u
	 pAr2fUjA5J0j6tTKSyTuPswsTOMfINKG4JP14kfc7hGrcjDj/RiCtalOe7lLlCnKN8
	 EEO0AUHMOZPpQ==
Date: Wed, 26 Nov 2025 11:42:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [VFS/nfsd/cachefiles/ovl]  7ab96df840:
 WARNING:at_fs/dcache.c:#umount_check
Message-ID: <20251126-beerdigen-spanplatten-d86d4e9eaaa7@brauner>
References: <202511252132.2c621407-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202511252132.2c621407-lkp@intel.com>

On Tue, Nov 25, 2025 at 09:48:18PM +0800, kernel test robot wrote:
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_fs/dcache.c:#umount_check" on:
> 
> commit: 7ab96df840e60eb933abfe65fc5fe44e72f16dc0 ("VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]

Neil, can you please take a look at this soon?
I plan on sending the batch of PRs for this cycle on Friday.

> 
> in testcase: filebench
> version: filebench-x86_64-22620e6-1_20251009
> with following parameters:
> 
> 	disk: 1SSD
> 	fs: ext4
> 	fs2: nfsv4
> 	test: ratelimcopyfiles.f
> 	cpufreq_governor: performance
> 
> 
> 
> config: x86_64-rhel-9.4
> compiler: gcc-14
> test machine: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202511252132.2c621407-lkp@intel.com
> 
> 
> Unmount[  252.448780][T17295] ------------[ cut here ]------------
> [  252.455068][T17295] WARNING: CPU: 114 PID: 17295 at fs/dcache.c:1590 umount_check (fs/dcache.c:1590 (discriminator 1) fs/dcache.c:1580 (discriminator 1))
> m - /opt/rootfs.[  252.540436][T17295] CPU: 114 UID: 0 PID: 17295 Comm: umount Tainted: G S                  6.18.0-rc1-00004-g7ab96df840e6 #1 VOLUNTARY
> [  252.553273][T17295] Tainted: [S]=CPU_OUT_OF_SPEC
> [  252.558205][T17295] Hardware name: Intel Corporation ............/S9200WKBRD2, BIOS SE5C620.86B.0D.01.0552.060220191912 06/02/2019
> [  252.558206][T17295] RIP: 0010:umount_check (fs/dcache.c:1590 (discriminator 1) fs/dcache.c:1580 (discriminator 1))
> [  252.575407][T17295] Code: 8d 88 a0 03 00 00 48 8b 40 28 4c 8b 08 48 8b 46 30 48 85 c0 74 04 48 8b 50 40 51 48 c7 c7 88 3b ad 82 48 89 f1 e8 27 07 c0 ff <0f> 0b 58 31 c0 c3 cc cc cc cc 41 83 f8 01 75 bf eb aa 0f 1f 44 00
> All code
> ========
>    0:	8d 88 a0 03 00 00    	lea    0x3a0(%rax),%ecx
>    6:	48 8b 40 28          	mov    0x28(%rax),%rax
>    a:	4c 8b 08             	mov    (%rax),%r9
>    d:	48 8b 46 30          	mov    0x30(%rsi),%rax
>   11:	48 85 c0             	test   %rax,%rax
>   14:	74 04                	je     0x1a
>   16:	48 8b 50 40          	mov    0x40(%rax),%rdx
>   1a:	51                   	push   %rcx
>   1b:	48 c7 c7 88 3b ad 82 	mov    $0xffffffff82ad3b88,%rdi
>   22:	48 89 f1             	mov    %rsi,%rcx
>   25:	e8 27 07 c0 ff       	call   0xffffffffffc00751
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	58                   	pop    %rax
>   2d:	31 c0                	xor    %eax,%eax
>   2f:	c3                   	ret
>   30:	cc                   	int3
>   31:	cc                   	int3
>   32:	cc                   	int3
>   33:	cc                   	int3
>   34:	41 83 f8 01          	cmp    $0x1,%r8d
>   38:	75 bf                	jne    0xfffffffffffffff9
>   3a:	eb aa                	jmp    0xffffffffffffffe6
>   3c:	0f                   	.byte 0xf
>   3d:	1f                   	(bad)
>   3e:	44                   	rex.R
> 	...
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	58                   	pop    %rax
>    3:	31 c0                	xor    %eax,%eax
>    5:	c3                   	ret
>    6:	cc                   	int3
>    7:	cc                   	int3
>    8:	cc                   	int3
>    9:	cc                   	int3
>    a:	41 83 f8 01          	cmp    $0x1,%r8d
>    e:	75 bf                	jne    0xffffffffffffffcf
>   10:	eb aa                	jmp    0xffffffffffffffbc
>   12:	0f                   	.byte 0xf
>   13:	1f                   	(bad)
>   14:	44                   	rex.R
> 	...
> [  252.575410][T17295] RSP: 0018:ffffc9003672bb88 EFLAGS: 00010282
> [  252.601300][T17295] RAX: 0000000000000000 RBX: ffff88ac4c0c55c0 RCX: 0000000000000027
> [  252.601301][T17295] RDX: ffff888c5009c1c8 RSI: 0000000000000001 RDI: ffff888c5009c1c0
> [  252.601303][T17295] RBP: ffff8881e925da40 R08: 0000000000000000 R09: ffffc9003672b958
> [  252.625337][T17295] R10: ffff88ac7fc33fa8 R11: 0000000000000003 R12: ffffffff81748d50
> [  252.625338][T17295] R13: ffff8881e925da40 R14: ffff88ac4c0c9200 R15: ffff88ac4c0c9280
> [  252.625339][T17295] FS:  00007ffff7bfb840(0000) GS:ffff888ccc272000(0000) knlGS:0000000000000000
> [  252.625340][T17295] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  252.625341][T17295] CR2: 00007ffff7ec97a0 CR3: 00000001ce11e005 CR4: 00000000007726f0
> [  252.625342][T17295] PKRU: 55555554
> [  252.625343][T17295] Call Trace:
> [  252.625345][T17295]  <TASK>
> [  252.625348][T17295]  d_walk (fs/dcache.c:1322)
> [  252.625353][T17295]  shrink_dcache_for_umount (include/linux/spinlock.h:351 fs/dcache.c:601 fs/dcache.c:1606 fs/dcache.c:1621)
> [  252.625357][T17295]  generic_shutdown_super (fs/super.c:621)
> [  252.689813][T17295]  kill_block_super (fs/super.c:1723)
> [  252.689817][T17295] ext4_kill_sb (fs/ext4/super.c:7405) ext4
> [  252.699584][T17295]  deactivate_locked_super (fs/super.c:434 fs/super.c:475)
> Unmount[  252.704921][T17295]  cleanup_mnt (fs/namespace.c:242 fs/namespace.c:1328)
> [  252.704926][T17295]  task_work_run (include/linux/sched.h:2092 kernel/task_work.c:229)
> - Legacy Locks D[  252.727385][T17295]  ? __cond_resched (kernel/sched/core.c:7477)
> irectory /run/lo[  252.733357][T17295]  ? generic_fillattr (fs/stat.c:99)
> [  252.739669][T17295]  ? _copy_to_user (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:147 include/linux/uaccess.h:197 lib/usercopy.c:26)
> [  252.744854][T17295]  ? cp_new_stat (fs/stat.c:506 (discriminator 1))
> [  252.744857][T17295]  ? __do_sys_newfstatat (fs/stat.c:546 (discriminator 1))
> [  252.744861][T17295]  ? do_syscall_64 (arch/x86/include/asm/jump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/context_tracking.h:41 include/linux/irq-entry-common.h:261 include/linux/entry-common.h:212 arch/x86/entry/syscall_64.c:100)
> [  252.759380][T17295]  ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548)
> [  252.764099][T17295]  ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548)
> [  252.764101][T17295]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [  252.774744][T17295] RIP: 0033:0x7ffff7e54217
> [  252.779199][T17295] Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 b1 5b 0d 00 f7 d8 64 89 02 b8
> All code
> ========
>    0:	0d 00 f7 d8 64       	or     $0x64d8f700,%eax
>    5:	89 02                	mov    %eax,(%rdx)
>    7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
>    c:	c3                   	ret
>    d:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
>   13:	31 f6                	xor    %esi,%esi
>   15:	e9 09 00 00 00       	jmp    0x23
>   1a:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
>   21:	00 00 
>   23:	b8 a6 00 00 00       	mov    $0xa6,%eax
>   28:	0f 05                	syscall
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>   30:	77 01                	ja     0x33
>   32:	c3                   	ret
>   33:	48 8b 15 b1 5b 0d 00 	mov    0xd5bb1(%rip),%rdx        # 0xd5beb
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 02             	mov    %eax,%fs:(%rdx)
>   3f:	b8                   	.byte 0xb8
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 01                	ja     0x9
>    8:	c3                   	ret
>    9:	48 8b 15 b1 5b 0d 00 	mov    0xd5bb1(%rip),%rdx        # 0xd5bc1
>   10:	f7 d8                	neg    %eax
>   12:	64 89 02             	mov    %eax,%fs:(%rdx)
>   15:	b8                   	.byte 0xb8
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251125/202511252132.2c621407-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

