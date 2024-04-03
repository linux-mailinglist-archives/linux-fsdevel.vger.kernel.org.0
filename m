Return-Path: <linux-fsdevel+bounces-16000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B689697E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 10:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C96EB28B25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395687EF0C;
	Wed,  3 Apr 2024 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upvyBIuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18154F8C;
	Wed,  3 Apr 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133988; cv=none; b=QE+y0mwNUaI2ygAcpaxB3DcmdrREk4rsDkA8qog9Rs7gkqAoouoGXoqRtnkHJECrcMIFCfvvMB7YcVi4QxRzfJZUR4te5bNbpk9fUgVuJjzs7ckWMRK5QSEcqCtm8ev7Si5w8vt1gC8yD6fjkWv/6xuiD3+yIZ4VV1Gt/U21sQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133988; c=relaxed/simple;
	bh=ZT/i59N9j5PzcMQFCVDO4gGaC2MjE7oeYcyOWJLfMog=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Kxr5ZuaN1qmhSJunEmP1cekfuvGpO30ad77N9rODY/2JXckrLzeNDrG/q2jylI/xv4uA9JItK/I+ca4McMt2WYI/eNRGztAgEmbVkw16HGNgofhONAj0+LJctBuGlPGl8X/HnrWDAEdaeHpmE9Qjsf888n61onCb40ErG//bh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upvyBIuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226D6C433C7;
	Wed,  3 Apr 2024 08:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133988;
	bh=ZT/i59N9j5PzcMQFCVDO4gGaC2MjE7oeYcyOWJLfMog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=upvyBIuwaovfCMw9ZA4ORu3lYqLkoE7wiuohRUVbpomckkpsrjoPnYbJsLMM9GciF
	 83VM9Tg+dO2sOMdzVbLxHcCfAu1EvAznvhMDg5lXuZx9Q70vyTwrh2GowBgpDFOlFT
	 ahXnLgpbKzULnyTZvte2668Su7eD9XdtTyo7Byld4tKePQ2aHhREdfyu4MgE6/UTVj
	 wJPwBvzgB6Fum36ydD48vxucMMpK5GUBKKUGOgjP0CnmmM3XLgtLThRajdAy0p2oX7
	 CwiM6rV5K0WfHgihFCcMGL4w+x6WmOzddr46zrLCc9Gg+qKm5VAbA3WQ5DOoYfufbk
	 5ol7GOnsszrUA==
Date: Wed, 3 Apr 2024 10:46:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>, 
	syzbot <syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com>, Edward Adam Davis <eadavis@qq.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	amir73il@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [linux-next:master] [fs]  1b43c46297: kernel_BUG_at_mm/usercopy.c
Message-ID: <20240403-mundgerecht-klopapier-e921ceb787ca@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202404031550.f3de0571-lkp@intel.com>
 <000000000000f075b9061520cbbe@google.com>
 <tencent_A7845DD769577306D813742365E976E3A205@qq.com>

On Wed, Apr 03, 2024 at 04:00:50PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel_BUG_at_mm/usercopy.c" on:
> 
> commit: 1b43c4629756a2c4bbbe4170eea1cc869fd8cb91 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 727900b675b749c40ba1f6669c7ae5eb7eb8e837]
> 
> in testcase: trinity
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-04
> 	nr_groups: 5
> 
> 
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +--------------------------------------------------------+------------+------------+
> |                                                        | 16634c0975 | 1b43c46297 |
> +--------------------------------------------------------+------------+------------+
> | kernel_BUG_at_mm/usercopy.c                            | 0          | 11         |
> | invalid_opcode:#[##]                                   | 0          | 11         |
> | EIP:usercopy_abort                                     | 0          | 11         |
> | Kernel_panic-not_syncing:Fatal_exception               | 0          | 11         |
> +--------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202404031550.f3de0571-lkp@intel.com
> 
> 
> [   69.665215][ T3725] ------------[ cut here ]------------
> [   69.665740][ T3725] kernel BUG at mm/usercopy.c:102!
> [   69.666181][ T3725] invalid opcode: 0000 [#1] PREEMPT SMP
> [   69.666687][ T3725] CPU: 1 PID: 3725 Comm: trinity-c2 Tainted: G S      W        N 6.9.0-rc1-00016-g1b43c4629756 #1
> [   69.667623][ T3725] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 69.668555][ T3725] EIP: usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
> [ 69.669040][ T3725] Code: d6 db c2 b9 f0 17 dd c2 eb 0a bf 57 5f e4 c2 b9 11 7f eb c2 ff 75 0c ff 75 08 56 52 53 50 57 51 68 f9 17 dd c2 e8 d3 a5 e9 ff <0f> 0b b8 ec 7a 4c c3 83 c4 24 e8 e4 72 3f 00 55 89 e5 57 56 89 d7
> All code
> ========
>    0:	d6                   	(bad)
>    1:	db c2                	fcmovnb %st(2),%st
>    3:	b9 f0 17 dd c2       	mov    $0xc2dd17f0,%ecx
>    8:	eb 0a                	jmp    0x14
>    a:	bf 57 5f e4 c2       	mov    $0xc2e45f57,%edi
>    f:	b9 11 7f eb c2       	mov    $0xc2eb7f11,%ecx
>   14:	ff 75 0c             	push   0xc(%rbp)
>   17:	ff 75 08             	push   0x8(%rbp)
>   1a:	56                   	push   %rsi
>   1b:	52                   	push   %rdx
>   1c:	53                   	push   %rbx
>   1d:	50                   	push   %rax
>   1e:	57                   	push   %rdi
>   1f:	51                   	push   %rcx
>   20:	68 f9 17 dd c2       	push   $0xffffffffc2dd17f9
>   25:	e8 d3 a5 e9 ff       	call   0xffffffffffe9a5fd
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	b8 ec 7a 4c c3       	mov    $0xc34c7aec,%eax
>   31:	83 c4 24             	add    $0x24,%esp
>   34:	e8 e4 72 3f 00       	call   0x3f731d
>   39:	55                   	push   %rbp
>   3a:	89 e5                	mov    %esp,%ebp
>   3c:	57                   	push   %rdi
>   3d:	56                   	push   %rsi
>   3e:	89 d7                	mov    %edx,%edi
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	b8 ec 7a 4c c3       	mov    $0xc34c7aec,%eax
>    7:	83 c4 24             	add    $0x24,%esp
>    a:	e8 e4 72 3f 00       	call   0x3f72f3
>    f:	55                   	push   %rbp
>   10:	89 e5                	mov    %esp,%ebp
>   12:	57                   	push   %rdi
>   13:	56                   	push   %rsi
>   14:	89 d7                	mov    %edx,%edi
> [   69.670705][ T3725] EAX: 00000062 EBX: c2dd17e3 ECX: 00000001 EDX: 80000001
> [   69.671364][ T3725] ESI: c2dd17e4 EDI: c2e45f57 EBP: c8611efc ESP: c8611ecc
> [   69.671998][ T3725] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010286
> [   69.672652][ T3725] CR0: 80050033 CR2: 08acb828 CR3: 157c1000 CR4: 00040690
> [   69.673240][ T3725] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   69.673814][ T3725] DR6: fffe0ff0 DR7: 00000400
> [   69.674206][ T3725] Call Trace:
> [ 69.674480][ T3725] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
> [ 69.674859][ T3725] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
> [ 69.675236][ T3725] ? __die (arch/x86/kernel/dumpstack.c:435) 
> [ 69.675579][ T3725] ? die (arch/x86/kernel/dumpstack.c:449) 
> [ 69.675904][ T3725] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
> [ 69.676276][ T3725] ? do_error_trap (arch/x86/kernel/traps.c:176) 
> [ 69.676677][ T3725] ? usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
> [ 69.677071][ T3725] ? exc_overflow (arch/x86/kernel/traps.c:252) 
> [ 69.677440][ T3725] ? handle_invalid_op (arch/x86/kernel/traps.c:214) 
> [ 69.677878][ T3725] ? usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
> [ 69.678279][ T3725] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
> [ 69.678677][ T3725] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
> [ 69.679118][ T3725] ? exc_overflow (arch/x86/kernel/traps.c:252) 
> [ 69.679494][ T3725] ? usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
> [ 69.679882][ T3725] ? exc_overflow (arch/x86/kernel/traps.c:252) 
> [ 69.680272][ T3725] ? usercopy_abort (mm/usercopy.c:102 (discriminator 24)) 
> [ 69.680681][ T3725] __check_heap_object (mm/slub.c:5365) 
> [ 69.681121][ T3725] check_heap_object (mm/usercopy.c:196) 
> [ 69.681541][ T3725] __check_object_size (mm/usercopy.c:123 mm/usercopy.c:254) 
> [ 69.681969][ T3725] handle_to_path (include/linux/uaccess.h:183 fs/fhandle.c:203) 
> [ 69.682372][ T3725] __ia32_sys_open_by_handle_at (fs/fhandle.c:226 fs/fhandle.c:267 fs/fhandle.c:258 fs/fhandle.c:258) 
> [ 69.682862][ T3725] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:274) 
> [ 69.683288][ T3725] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
> [   69.683697][ T3725] EIP: 0x80a3392
> [ 69.684006][ T3725] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 c8 a9 ac 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 f0 a9 ac 08 85
> All code
> ========
>    0:	89 c8                	mov    %ecx,%eax
>    2:	c3                   	ret
>    3:	90                   	nop
>    4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>    8:	85 c0                	test   %eax,%eax
>    a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
>   10:	75 d8                	jne    0xffffffffffffffea
>   12:	a1 c8 a9 ac 08 eb d1 	movabs 0x9066d1eb08aca9c8,%eax
>   19:	66 90 
>   1b:	66 90                	xchg   %ax,%ax
>   1d:	66 90                	xchg   %ax,%ax
>   1f:	66 90                	xchg   %ax,%ax
>   21:	66 90                	xchg   %ax,%ax
>   23:	66 90                	xchg   %ax,%ax
>   25:	66 90                	xchg   %ax,%ax
>   27:	90                   	nop
>   28:	cd 80                	int    $0x80
>   2a:*	c3                   	ret		<-- trapping instruction
>   2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
>   31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
>   38:	8b 10                	mov    (%rax),%edx
>   3a:	a3                   	.byte 0xa3
>   3b:	f0                   	lock
>   3c:	a9                   	.byte 0xa9
>   3d:	ac                   	lods   %ds:(%rsi),%al
>   3e:	08                   	.byte 0x8
>   3f:	85                   	.byte 0x85
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	c3                   	ret
>    1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
>    7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
>    e:	8b 10                	mov    (%rax),%edx
>   10:	a3                   	.byte 0xa3
>   11:	f0                   	lock
>   12:	a9                   	.byte 0xa9
>   13:	ac                   	lods   %ds:(%rsi),%al
>   14:	08                   	.byte 0x8
>   15:	85                   	.byte 0x85
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240403/202404031550.f3de0571-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

On Tue, Apr 02, 2024 at 10:54:24AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=148b0003180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=4139435cb1b34cf759c2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1547f529180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e22f0d180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
> BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
> Write of size 36 at addr ffff8880203f2e88 by task syz-executor205/5086
> 
> CPU: 1 PID: 5086 Comm: syz-executor205 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
>  _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
>  copy_from_user include/linux/uaccess.h:183 [inline]
>  handle_to_path fs/fhandle.c:203 [inline]
>  do_handle_open+0x204/0x660 fs/fhandle.c:226
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> RIP: 0033:0x7f81f2e5f269
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcde6f13c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
> RAX: ffffffffffffffda RBX: 00007ffcde6f15a8 RCX: 00007f81f2e5f269
> RDX: 0000000000000000 RSI: 00000000200091c0 RDI: 00000000ffffffff
> RBP: 00007f81f2ed2610 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffcde6f1598 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> Allocated by task 5086:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:4048 [inline]
>  __kmalloc_noprof+0x200/0x410 mm/slub.c:4061
>  kmalloc_noprof include/linux/slab.h:664 [inline]
>  handle_to_path fs/fhandle.c:195 [inline]
>  do_handle_open+0x162/0x660 fs/fhandle.c:226
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> 
> The buggy address belongs to the object at ffff8880203f2e80
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 8 bytes inside of
>  allocated 36-byte region [ffff8880203f2e80, ffff8880203f2ea4)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x203f2
> ksm flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
> page_type: 0xffffefff(slab)
> raw: 00fff80000000000 ffff888015041640 ffffea0000869bc0 dead000000000003
> raw: 0000000000000000 0000000080200020 00000001ffffefff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4542, tgid -909298647 (udevd), ts 4542, free_ts 33444169271
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1490
>  prep_new_page mm/page_alloc.c:1498 [inline]
>  get_page_from_freelist+0x2e7e/0x2f40 mm/page_alloc.c:3454
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4712
>  __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2249
>  allocate_slab+0x5a/0x2e0 mm/slub.c:2412
>  new_slab mm/slub.c:2465 [inline]
>  ___slab_alloc+0xea8/0x1430 mm/slub.c:3599
>  __slab_alloc+0x58/0xa0 mm/slub.c:3684
>  __slab_alloc_node mm/slub.c:3737 [inline]
>  slab_alloc_node mm/slub.c:3915 [inline]
>  __do_kmalloc_node mm/slub.c:4047 [inline]
>  __kmalloc_noprof+0x25e/0x410 mm/slub.c:4061
>  kmalloc_noprof include/linux/slab.h:664 [inline]
>  kzalloc_noprof include/linux/slab.h:775 [inline]
>  tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
>  tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
>  tomoyo_realpath_from_path+0x59e/0x5e0 security/tomoyo/realpath.c:283
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
>  security_inode_getattr+0xd8/0x130 security/security.c:2269
>  vfs_getattr+0x45/0x430 fs/stat.c:173
>  vfs_fstat fs/stat.c:198 [inline]
>  vfs_fstatat+0xd6/0x190 fs/stat.c:300
>  __do_sys_newfstatat fs/stat.c:468 [inline]
>  __se_sys_newfstatat fs/stat.c:462 [inline]
>  __x64_sys_newfstatat+0x125/0x1b0 fs/stat.c:462
>  do_syscall_64+0xfb/0x240
> page last free pid 4548 tgid 4548 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1110 [inline]
>  free_unref_page+0xd3c/0xec0 mm/page_alloc.c:2617
>  __slab_free+0x31b/0x3d0 mm/slub.c:4274
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3867 [inline]
>  slab_alloc_node mm/slub.c:3927 [inline]
>  __do_kmalloc_node mm/slub.c:4047 [inline]
>  __kmalloc_noprof+0x1a9/0x410 mm/slub.c:4061
>  kmalloc_noprof include/linux/slab.h:664 [inline]
>  tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path2_perm+0x3eb/0xbb0 security/tomoyo/file.c:923
>  tomoyo_path_rename+0x198/0x1e0 security/tomoyo/tomoyo.c:300
>  security_path_rename+0x179/0x220 security/security.c:1918
>  do_renameat2+0x94a/0x13f0 fs/namei.c:5027
>  __do_sys_rename fs/namei.c:5087 [inline]
>  __se_sys_rename fs/namei.c:5085 [inline]
>  __x64_sys_rename+0x86/0xa0 fs/namei.c:5085
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> 
> Memory state around the buggy address:
>  ffff8880203f2d80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8880203f2e00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >ffff8880203f2e80: 00 00 00 00 04 fc fc fc fc fc fc fc fc fc fc fc
>                                ^
>  ffff8880203f2f00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>  ffff8880203f2f80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

On Wed, Apr 03, 2024 at 02:54:14PM +0800, Edward Adam Davis wrote:
> [Syzbot reported]
> BUG: KASAN: slab-out-of-bounds in instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
> BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
> Write of size 48 at addr ffff88802b8cbc88 by task syz-executor333/5090
> 
> CPU: 0 PID: 5090 Comm: syz-executor333 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_copy_from_user_before include/linux/instrumented.h:129 [inline]
>  _copy_from_user+0x7b/0xe0 lib/usercopy.c:22
>  copy_from_user include/linux/uaccess.h:183 [inline]
>  handle_to_path fs/fhandle.c:203 [inline]
>  do_handle_open+0x204/0x660 fs/fhandle.c:226
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> [Fix] 
> When copying data to f_handle, the length of the copied data should not include
> the length of "struct file_handle".
> 
> Reported-by: syzbot+4139435cb1b34cf759c2@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/fhandle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 53ed54711cd2..8a7f86c2139a 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -202,7 +202,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	*handle = f_handle;
>  	if (copy_from_user(&handle->f_handle,
>  			   &ufh->f_handle,
> -			   struct_size(ufh, f_handle, f_handle.handle_bytes))) {
> +			   f_handle.handle_bytes)) {

Groan, of course. What a silly mistake. Thanks for the fix.
I'll fold this into:
Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
because this hasn't hit mainline yet and it doesn't make sense to keep
that bug around.

Sorry, that'll mean we drop your patch but I'll give you credit in the
commit log of the original patch.

