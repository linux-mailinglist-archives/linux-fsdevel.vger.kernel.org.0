Return-Path: <linux-fsdevel+bounces-26249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 212FD9567C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 12:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9650E1F2296D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3099148FE0;
	Mon, 19 Aug 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvXj4eut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB851553BB;
	Mon, 19 Aug 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061856; cv=none; b=AAI6JmIRUBJDPBoelzon6jf8Zb0UUltrtJKfhnkHQbjDkF3Q9r5MkanzHnWAY5uVO3Yx50GmGd/PdicqVYKFNnQIFX7g97F+ckmxVGFbWwGHH/YsKidUez4rtoPdYXAzaV2Me7myj2vb7wuQVvveHJB5nP9ppauoq2v0KbT85F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061856; c=relaxed/simple;
	bh=YFXdZGG+wmqAjbO6cDVg+8rRzifklT5Rfnm6SBZ9e+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWvhIwXTcZ5SR+u3BJ+g+XMmkxWJoRe8iPUrtpJ0tQisHl8h2VdP17co5DlGkSGKuIxm70F6qPpxZwkikOvk6cBhWoVQGNvckoSSsPSEKKK1gYyC4dozqlTKRRxB7/G4eQ3QHE7sUx4UJXKRaUosY0A8fQRN9PSrsqZOpWMZC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvXj4eut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5275EC32782;
	Mon, 19 Aug 2024 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724061855;
	bh=YFXdZGG+wmqAjbO6cDVg+8rRzifklT5Rfnm6SBZ9e+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FvXj4eutcw+JqtBilmG2sahl0+IdVP2Z6pAD++jNhqM4ithU/RwhI86YGlcXdj+x3
	 M1baCds4rjVWgRFua4t8E5lV5Swtvo/zfXPoOoppqtn9xfFD3HdGsUl0rLXXVEray2
	 xzJl3vrwR/vC7rRzeq4/6z+g+JRuQEBXdQHR2M/vYwxORkx5U5+yMd5a4KN+yeluxr
	 Mga/fY1JxVLmPf19/zbJyCuzOQTysufP/3c9+lfoJQIDdXxsOHyTDUUuqYcXCEvwt+
	 6KGbsOIbvJyEAH0GYbPahRWFPN5gWbhAQC9+4UVNxsszUgzO4WjMQjYdaWb7WvFoea
	 DKvOlAYmTyakA==
Message-ID: <7d6d44078a6f7e5216a0c61f3c38e4e7cecd25ed.camel@kernel.org>
Subject: Re: [brauner-vfs:vfs.misc.jeff] [[DRAFT UNTESTED] fs] 6a0f6c435f:
 BUG:kernel_NULL_pointer_dereference,address
From: Jeff Layton <jlayton@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Christian Brauner
	 <christianvanbrauner@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Date: Mon, 19 Aug 2024 06:04:14 -0400
In-Reply-To: <202408191554.44eda558-lkp@intel.com>
References: <202408191554.44eda558-lkp@intel.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 16:23 +0800, kernel test robot wrote:
>=20
> Hello,
>=20
> we noticed this is a "[DRAFT UNTESTED]" patch, below report just FYI what=
 we
> observed in our tests.
>=20
>=20
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" o=
n:
>=20
> commit: 6a0f6c435fb1bbc61b7319146c520b872bb3d86d ("[DRAFT UNTESTED] fs: t=
ry an opportunistic lookup for O_CREAT opens too")
> https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.misc.jeff
>=20

This is an earlier version of this patch. It had a bug in it where it
didn't properly check for IS_ERR returns from lookup_fast. The current
version fixes this, so I think we can disregard this report.
=20
> in testcase: trinity
> version: trinity-x86_64-bba80411-1_20240603
> with following parameters:
>=20
> 	runtime: 300s
> 	group: group-02
> 	nr_groups: 5
>=20
>=20
>=20
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
> +---------------------------------------------+------------+------------+
> >                                             | 619d77cf74 | 6a0f6c435f |
> +---------------------------------------------+------------+------------+
> > boot_successes                              | 6          | 0          |
> > boot_failures                               | 0          | 6          |
> > BUG:kernel_NULL_pointer_dereference,address | 0          | 6          |
> > Oops                                        | 0          | 6          |
> > RIP:open_last_lookups                       | 0          | 6          |
> > Kernel_panic-not_syncing:Fatal_exception    | 0          | 6          |
> +---------------------------------------------+------------+------------+
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202408191554.44eda558-lkp@intel.=
com
>=20
>=20
> [   67.376606][ T6760] BUG: kernel NULL pointer dereference, address: 000=
000000000005e
> [   67.377423][ T6760] #PF: supervisor read access in kernel mode
> [   67.377976][ T6760] #PF: error_code(0x0000) - not-present page
> [   67.378502][ T6760] PGD 16b2ea067 P4D 16b2ea067 PUD 0
> [   67.378978][ T6760] Oops: Oops: 0000 [#1] PREEMPT SMP
> [   67.379444][ T6760] CPU: 0 UID: 65534 PID: 6760 Comm: trinity-c4 Taint=
ed: G                T  6.11.0-rc1-00022-g6a0f6c435fb1 #1
> [   67.380468][ T6760] Tainted: [T]=3DRANDSTRUCT
> [ 67.380817][ T6760] RIP: 0010:open_last_lookups (fs/namei.c:3633 fs/name=
i.c:3660)=20
> [ 67.381294][ T6760] Code: c8 03 89 47 34 48 89 df 48 89 54 24 08 e8 ee e=
b ff ff 8b 34 24 48 8b 54 24 08 49 89 c7 85 f6 74 50 48 85 c0 0f 84 0b 01 0=
0 00 <48> 83 78 68 00 0f 84 f3 03 00 00 48 3d 00 f0 ff ff 77 14 8b 43 14
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	c8 03 89 47          	enter  $0x8903,$0x47
>    4:	34 48                	xor    $0x48,%al
>    6:	89 df                	mov    %ebx,%edi
>    8:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
>    d:	e8 ee eb ff ff       	call   0xffffffffffffec00
>   12:	8b 34 24             	mov    (%rsp),%esi
>   15:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
>   1a:	49 89 c7             	mov    %rax,%r15
>   1d:	85 f6                	test   %esi,%esi
>   1f:	74 50                	je     0x71
>   21:	48 85 c0             	test   %rax,%rax
>   24:	0f 84 0b 01 00 00    	je     0x135
>   2a:*	48 83 78 68 00       	cmpq   $0x0,0x68(%rax)		<-- trapping instruc=
tion
>   2f:	0f 84 f3 03 00 00    	je     0x428
>   35:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>   3b:	77 14                	ja     0x51
>   3d:	8b 43 14             	mov    0x14(%rbx),%eax
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	48 83 78 68 00       	cmpq   $0x0,0x68(%rax)
>    5:	0f 84 f3 03 00 00    	je     0x3fe
>    b:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>   11:	77 14                	ja     0x27
>   13:	8b 43 14             	mov    0x14(%rbx),%eax
> [   67.382823][ T6760] RSP: 0018:ffff8881a5407d20 EFLAGS: 00010286
> [   67.383333][ T6760] RAX: fffffffffffffff6 RBX: ffff8881a5407db0 RCX: 0=
000000000000000
> [   67.384026][ T6760] RDX: ffff8881a5407ed4 RSI: 0000000000000040 RDI: 0=
000000000000000
> [   67.384726][ T6760] RBP: 0000000000000000 R08: 0000000000000000 R09: 0=
000000000000000
> [   67.385415][ T6760] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff88816b431200
> [   67.386090][ T6760] R13: 0000000000008241 R14: ffff8881a544d9c0 R15: f=
ffffffffffffff6
> [   67.386767][ T6760] FS:  00007fe3bc195740(0000) GS:ffff88842fc00000(00=
00) knlGS:0000000000000000
> [   67.387496][ T6760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   67.388081][ T6760] CR2: 000000000000005e CR3: 000000016b376000 CR4: 0=
0000000000406f0
> [   67.388799][ T6760] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [   67.389519][ T6760] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [   67.390229][ T6760] Call Trace:
> [   67.390532][ T6760]  <TASK>
> [ 67.390796][ T6760] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/ke=
rnel/dumpstack.c:434)=20
> [ 67.391153][ T6760] ? page_fault_oops (arch/x86/mm/fault.c:715)=20
> [ 67.391591][ T6760] ? exc_page_fault (arch/x86/include/asm/paravirt.h:68=
7 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/=
fault.c:1539)=20
> [ 67.392027][ T6760] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.=
h:623)=20
> [ 67.392485][ T6760] ? open_last_lookups (fs/namei.c:3633 fs/namei.c:3660=
)=20
> [ 67.392930][ T6760] ? link_path_walk+0x247/0x280=20
> [ 67.393496][ T6760] path_openat (fs/namei.c:3942 (discriminator 1))=20
> [ 67.393876][ T6760] do_filp_open (fs/namei.c:3972)=20
> [ 67.394267][ T6760] ? simple_attr_release (fs/libfs.c:1617)=20
> [ 67.394754][ T6760] ? alloc_fd (fs/file.c:560 (discriminator 10))=20
> [ 67.395155][ T6760] ? lock_release (kernel/locking/lockdep.c:466 kernel/=
locking/lockdep.c:5782)=20
> [ 67.395585][ T6760] do_sys_openat2 (fs/open.c:1416)=20
> [ 67.396012][ T6760] __x64_sys_openat (fs/open.c:1442)=20
> [ 67.396453][ T6760] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/e=
ntry/common.c:83)=20
> [ 67.396873][ T6760] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry=
_64.S:130)=20
> [   67.397426][ T6760] RIP: 0033:0x7fe3bc28ff01
> [ 67.397838][ T6760] Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 4=
9 80 3d ea 26 0e 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0=
f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	75 57                	jne    0x59
>    2:	89 f0                	mov    %esi,%eax
>    4:	25 00 00 41 00       	and    $0x410000,%eax
>    9:	3d 00 00 41 00       	cmp    $0x410000,%eax
>    e:	74 49                	je     0x59
>   10:	80 3d ea 26 0e 00 00 	cmpb   $0x0,0xe26ea(%rip)        # 0xe2701
>   17:	74 6d                	je     0x86
>   19:	89 da                	mov    %ebx,%edx
>   1b:	48 89 ee             	mov    %rbp,%rsi
>   1e:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
>   23:	b8 01 01 00 00       	mov    $0x101,%eax
>   28:	0f 05                	syscall
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trappin=
g instruction
>   30:	0f 87 93 00 00 00    	ja     0xc9
>   36:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
>   3b:	64                   	fs
>   3c:	48                   	rex.W
>   3d:	2b                   	.byte 0x2b
>   3e:	14 25                	adc    $0x25,%al
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	0f 87 93 00 00 00    	ja     0x9f
>    c:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
>   11:	64                   	fs
>   12:	48                   	rex.W
>   13:	2b                   	.byte 0x2b
>   14:	14 25                	adc    $0x25,%al
> [   67.399602][ T6760] RSP: 002b:00007ffdc391cab0 EFLAGS: 00000202 ORIG_R=
AX: 0000000000000101
> [   67.400397][ T6760] RAX: ffffffffffffffda RBX: 0000000000000241 RCX: 0=
0007fe3bc28ff01
> [   67.401128][ T6760] RDX: 0000000000000241 RSI: 000055acb903417a RDI: 0=
0000000ffffff9c
> [   67.401835][ T6760] RBP: 000055acb903417a R08: 0000000000000004 R09: 0=
000000000000001
> [   67.402551][ T6760] R10: 00000000000001b6 R11: 0000000000000202 R12: 0=
00055acb903417a
> [   67.403261][ T6760] R13: 000055acb903cfa2 R14: 0000000000000001 R15: 0=
000000000000000
> [   67.403999][ T6760]  </TASK>
> [   67.404281][ T6760] Modules linked in: crc32_pclmul crc32c_intel polyv=
al_clmulni polyval_generic ghash_clmulni_intel sha1_ssse3 ipmi_msghandler s=
erio_raw
> [   67.405542][ T6760] CR2: 000000000000005e
> [   67.405992][ T6760] ---[ end trace 0000000000000000 ]---
> [ 67.406504][ T6760] RIP: 0010:open_last_lookups (fs/namei.c:3633 fs/name=
i.c:3660)=20
> [ 67.406987][ T6760] Code: c8 03 89 47 34 48 89 df 48 89 54 24 08 e8 ee e=
b ff ff 8b 34 24 48 8b 54 24 08 49 89 c7 85 f6 74 50 48 85 c0 0f 84 0b 01 0=
0 00 <48> 83 78 68 00 0f 84 f3 03 00 00 48 3d 00 f0 ff ff 77 14 8b 43 14
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	c8 03 89 47          	enter  $0x8903,$0x47
>    4:	34 48                	xor    $0x48,%al
>    6:	89 df                	mov    %ebx,%edi
>    8:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
>    d:	e8 ee eb ff ff       	call   0xffffffffffffec00
>   12:	8b 34 24             	mov    (%rsp),%esi
>   15:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
>   1a:	49 89 c7             	mov    %rax,%r15
>   1d:	85 f6                	test   %esi,%esi
>   1f:	74 50                	je     0x71
>   21:	48 85 c0             	test   %rax,%rax
>   24:	0f 84 0b 01 00 00    	je     0x135
>   2a:*	48 83 78 68 00       	cmpq   $0x0,0x68(%rax)		<-- trapping instruc=
tion
>   2f:	0f 84 f3 03 00 00    	je     0x428
>   35:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>   3b:	77 14                	ja     0x51
>   3d:	8b 43 14             	mov    0x14(%rbx),%eax
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	48 83 78 68 00       	cmpq   $0x0,0x68(%rax)
>    5:	0f 84 f3 03 00 00    	je     0x3fe
>    b:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>   11:	77 14                	ja     0x27
>   13:	8b 43 14             	mov    0x14(%rbx),%eax
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240819/202408191554.44eda558-lk=
p@intel.com
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

