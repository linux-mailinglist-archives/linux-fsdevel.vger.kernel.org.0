Return-Path: <linux-fsdevel+bounces-30642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2092298CB9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 05:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C685B282643
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3F17543;
	Wed,  2 Oct 2024 03:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKc5COFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A214A90;
	Wed,  2 Oct 2024 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840576; cv=none; b=lhEXIChMrsj7dPhmn8YP5vckwZP+p9bbz5ftFXrrS1IQ/NzUlE2PSlPrMQNrQrosEyHAkZPdDHpzMsfL73fIVvW0bqUWKvJusVUHt+MeLEi48hQYyomOb92GBeV9khMmF9peZ5bOMmkAZGmCROT8J283bX/Kw3Ssa2gUtr3lKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840576; c=relaxed/simple;
	bh=buUUeJ25SskC0nnHY7Tu4z10pN1ny1ns5pYoPM4hSk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy50eH1cWS+0083NBz3bb2fVf1hfYJnDDxcI+64OGs7EBgGTtr8kn7w7mRTU9AjLbgi572Hs/eS5+KgVL3OlxmPrxh3xdZ7Rl9kMBR7PWn+q77pNZTD+qKwuMpsbWMOXv2gn5C66+NhxZFoa8nCQtVipuXo1PxLBYRMFuiSMDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKc5COFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D63C4CEC6;
	Wed,  2 Oct 2024 03:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727840575;
	bh=buUUeJ25SskC0nnHY7Tu4z10pN1ny1ns5pYoPM4hSk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKc5COFYRfEJHWp6WOzqGsYZD+MC0CHm+hT9Xv2bVvMEDGWI8lI9tzdczznv/Y53q
	 2bFoYuh6G3I0pcj4kgoKP8mwCDRfZHG9ijMq29GBq2TpEr0K4VnKmcuc5Hkrht8rGa
	 dzQCNiP3w0Fvf4fzw/b0INbP8CL3XnyW/rYMEvAQjgPgB9wIEyihzBtkFgn9dkPxTu
	 pIbsHtr9/O3ffv//FX6YnYL+G07vsNyhiUdYb3CfjkYwSOKBqttASNqLzkqWHyWg/f
	 Lr5/e5nlYQzRusCOEMiuTxLlopx0ns08aHm8WfMsVy86wBqCmZTqanea1O0QVPRXZY
	 f+pZskSbII9gQ==
Date: Tue, 1 Oct 2024 20:42:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, morbo@google.com
Subject: Re: [PATCH] acl: Annotate struct posix_acl with __counted_by()
Message-ID: <20241002034252.GA2770260@thelio-3990X>
References: <202409260949.a1254989-oliver.sang@intel.com>
 <3D0816D1-0807-4D37-8D5F-3C55CA910FAA@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D0816D1-0807-4D37-8D5F-3C55CA910FAA@linux.dev>

On Thu, Sep 26, 2024 at 02:21:42PM +0200, Thorsten Blum wrote:
> On 26. Sep 2024, at 03:46, kernel test robot <oliver.sang@intel.com> wrote:
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_lib/string_helpers.c:#__fortify_report" on:
> > 
> > commit: 3d2d832826325210abb9849ee96634bf5a197517 ("[PATCH] acl: Annotate struct posix_acl with __counted_by()")
> > url: https://github.com/intel-lab-lkp/linux/commits/Thorsten-Blum/acl-Annotate-struct-posix_acl-with-__counted_by/20240924-054002
> > base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
> > patch link: https://lore.kernel.org/all/20240923213809.235128-2-thorsten.blum@linux.dev/
> > patch subject: [PATCH] acl: Annotate struct posix_acl with __counted_by()
> > 
> > in testcase: boot
> > 
> > compiler: clang-18
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > +---------------------------------------------------+------------+------------+
> > |                                                   | c72f8f06a2 | 3d2d832826 |
> > +---------------------------------------------------+------------+------------+
> > | boot_successes                                    | 18         | 0          |
> > | boot_failures                                     | 0          | 18         |
> > | WARNING:at_lib/string_helpers.c:#__fortify_report | 0          | 18         |
> > | RIP:__fortify_report                              | 0          | 18         |
> > | kernel_BUG_at_lib/string_helpers.c                | 0          | 18         |
> > | Oops:invalid_opcode:#[##]KASAN                    | 0          | 18         |
> > | RIP:__fortify_panic                               | 0          | 18         |
> > | Kernel_panic-not_syncing:Fatal_exception          | 0          | 18         |
> > +---------------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com
> > 
> > 
> > [   25.825642][  T121] ------------[ cut here ]------------
> > [   25.826209][  T121] kmemdup: detected buffer overflow: 72 byte read of buffer size 68
> > [ 25.826866][ T121] WARNING: CPU: 0 PID: 121 at lib/string_helpers.c:1030 __fortify_report (lib/string_helpers.c:1029) 
> > [   25.827588][  T121] Modules linked in:
> > [   25.827895][  T121] CPU: 0 UID: 0 PID: 121 Comm: systemd-tmpfile Not tainted 6.11.0-rc6-00294-g3d2d83282632 #1
> > [   25.828870][  T121] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [ 25.829661][ T121] RIP: 0010:__fortify_report (lib/string_helpers.c:1029) 
> > [ 25.830093][ T121] Code: f6 c5 01 49 8b 37 48 c7 c0 00 8a 56 86 48 c7 c1 20 8a 56 86 48 0f 44 c8 48 c7 c7 80 87 56 86 4c 89 f2 49 89 d8 e8 d1 37 dd fe <0f> 0b 5b 41 5e 41 5f 5d 31 c0 31 c9 31 ff 31 d2 31 f6 45 31 c0 c3
> > All code
> > ========
> >   0: f6 c5 01              test   $0x1,%ch
> >   3: 49 8b 37              mov    (%r15),%rsi
> >   6: 48 c7 c0 00 8a 56 86 mov    $0xffffffff86568a00,%rax
> >   d: 48 c7 c1 20 8a 56 86 mov    $0xffffffff86568a20,%rcx
> >  14: 48 0f 44 c8           cmove  %rax,%rcx
> >  18: 48 c7 c7 80 87 56 86 mov    $0xffffffff86568780,%rdi
> >  1f: 4c 89 f2              mov    %r14,%rdx
> >  22: 49 89 d8              mov    %rbx,%r8
> >  25: e8 d1 37 dd fe        call   0xfffffffffedd37fb
> >  2a:* 0f 0b                 ud2 <-- trapping instruction
> >  2c: 5b                    pop    %rbx
> >  2d: 41 5e                 pop    %r14
> >  2f: 41 5f                 pop    %r15
> >  31: 5d                    pop    %rbp
> >  32: 31 c0                 xor    %eax,%eax
> >  34: 31 c9                 xor    %ecx,%ecx
> >  36: 31 ff                 xor    %edi,%edi
> >  38: 31 d2                 xor    %edx,%edx
> >  3a: 31 f6                 xor    %esi,%esi
> >  3c: 45 31 c0              xor    %r8d,%r8d
> >  3f: c3                    ret
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >   0: 0f 0b                 ud2
> >   2: 5b                    pop    %rbx
> >   3: 41 5e                 pop    %r14
> >   5: 41 5f                 pop    %r15
> >   7: 5d                    pop    %rbp
> >   8: 31 c0                 xor    %eax,%eax
> >   a: 31 c9                 xor    %ecx,%ecx
> >   c: 31 ff                 xor    %edi,%edi
> >   e: 31 d2                 xor    %edx,%edx
> >  10: 31 f6                 xor    %esi,%esi
> >  12: 45 31 c0              xor    %r8d,%r8d
> >  15: c3                    ret
> > [   25.831566][  T121] RSP: 0018:ffffc90001e6f8a0 EFLAGS: 00010246
> > [   25.832052][  T121] RAX: 0000000000000000 RBX: 0000000000000044 RCX: 0000000000000000
> > [   25.832705][  T121] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > [   25.833348][  T121] RBP: 000000000000001c R08: 0000000000000000 R09: 0000000000000000
> > [   25.833964][  T121] R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920003cdf27
> > [   25.834570][  T121] R13: dffffc0000000000 R14: 0000000000000048 R15: ffffffff86568730
> > [   25.835152][  T121] FS:  00007f994a290440(0000) GS:ffffffff87eba000(0000) knlGS:0000000000000000
> > [   25.835834][  T121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   25.836385][  T121] CR2: 0000561875daa188 CR3: 0000000160dd0000 CR4: 00000000000406f0
> > [   25.837005][  T121] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   25.837609][  T121] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   25.838212][  T121] Call Trace:
> > [   25.838482][  T121]  <TASK>
> > [ 25.838717][ T121] ? __warn (kernel/panic.c:242) 
> > [ 25.839053][ T121] ? __fortify_report (lib/string_helpers.c:1029) 
> > [ 25.839436][ T121] ? __fortify_report (lib/string_helpers.c:1029) 
> > [ 25.839816][ T121] ? report_bug (lib/bug.c:?) 
> > [ 25.840206][ T121] ? handle_bug (arch/x86/kernel/traps.c:239) 
> > [ 25.840551][ T121] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
> > [ 25.840932][ T121] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
> > [ 25.841336][ T121] ? __fortify_report (lib/string_helpers.c:1029) 
> > [ 25.841732][ T121] __fortify_panic (lib/string_helpers.c:1037) 
> > [ 25.842094][ T121] __posix_acl_chmod (include/linux/fortify-string.h:751) 
> > [ 25.842493][ T121] ? make_vfsgid (fs/mnt_idmapping.c:122) 
> > [ 25.842837][ T121] ? capable_wrt_inode_uidgid (include/linux/mnt_idmapping.h:193 kernel/capability.c:480 kernel/capability.c:499) 
> > [ 25.843285][ T121] posix_acl_chmod (fs/posix_acl.c:624) 
> > [ 25.843671][ T121] shmem_setattr (mm/shmem.c:1240) 
> > [ 25.844039][ T121] ? ns_to_timespec64 (include/linux/math64.h:29 kernel/time/time.c:529) 
> > [ 25.844456][ T121] ? inode_set_ctime_current (fs/inode.c:2331) 
> > [ 25.844894][ T121] ? shmem_xattr_handler_set (mm/shmem.c:1173) 
> > [ 25.845322][ T121] ? rcu_read_lock_any_held (kernel/rcu/update.c:388) 
> > [ 25.845736][ T121] ? security_inode_setattr (security/security.c:?) 
> > [ 25.846157][ T121] ? shmem_xattr_handler_set (mm/shmem.c:1173) 
> > [ 25.846582][ T121] notify_change (fs/attr.c:?) 
> > [ 25.846952][ T121] chmod_common (fs/open.c:653) 
> > [ 25.847315][ T121] ? __ia32_sys_chroot (fs/open.c:637) 
> > [ 25.847709][ T121] ? user_path_at (fs/namei.c:3019) 
> > [ 25.848068][ T121] ? kmem_cache_free (mm/slub.c:4474) 
> > [ 25.848489][ T121] do_fchmodat (fs/open.c:701) 
> > [ 25.848842][ T121] ? do_faccessat (fs/open.c:686) 
> > [ 25.849210][ T121] ? print_irqtrace_events (kernel/locking/lockdep.c:4311) 
> > [ 25.849640][ T121] __x64_sys_chmod (fs/open.c:725 fs/open.c:723 fs/open.c:723) 
> > [ 25.850010][ T121] do_syscall_64 (arch/x86/entry/common.c:?) 
> > [ 25.850371][ T121] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:?) 
> > [ 25.850790][ T121] ? tracer_hardirqs_off (kernel/trace/trace_irqsoff.c:?) 
> > [ 25.851208][ T121] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:?) 
> > [ 25.851621][ T121] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:619) 
> > [ 25.852040][ T121] ? print_irqtrace_events (kernel/locking/lockdep.c:4311) 
> > [ 25.852522][ T121] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > [ 25.852917][ T121] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > [ 25.853285][ T121] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > [ 25.853667][ T121] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > [ 25.854053][ T121] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
> > [ 25.854445][ T121] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> > [   25.854921][  T121] RIP: 0033:0x7f994adcdc47
> > [ 25.855282][ T121] Code: eb d9 e8 9c 04 02 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 5f 00 00 00 0f 05 c3 0f 1f 84 00 00 00 00 00 b8 5a 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 a1 0d 00 f7 d8 64 89 01 48
> > All code
> > ========
> >   0: eb d9                 jmp    0xffffffffffffffdb
> >   2: e8 9c 04 02 00        call   0x204a3
> >   7: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
> >   e: 00 00 00 
> >  11: 66 90                 xchg   %ax,%ax
> >  13: b8 5f 00 00 00        mov    $0x5f,%eax
> >  18: 0f 05                 syscall
> >  1a: c3                    ret
> >  1b: 0f 1f 84 00 00 00 00 nopl   0x0(%rax,%rax,1)
> >  22: 00 
> >  23: b8 5a 00 00 00        mov    $0x5a,%eax
> >  28: 0f 05                 syscall
> >  2a:* 48 3d 01 f0 ff ff     cmp    $0xfffffffffffff001,%rax <-- trapping instruction
> >  30: 73 01                 jae    0x33
> >  32: c3                    ret
> >  33: 48 8b 0d 89 a1 0d 00 mov    0xda189(%rip),%rcx        # 0xda1c3
> >  3a: f7 d8                 neg    %eax
> >  3c: 64 89 01              mov    %eax,%fs:(%rcx)
> >  3f: 48                    rex.W
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >   0: 48 3d 01 f0 ff ff     cmp    $0xfffffffffffff001,%rax
> >   6: 73 01                 jae    0x9
> >   8: c3                    ret
> >   9: 48 8b 0d 89 a1 0d 00 mov    0xda189(%rip),%rcx        # 0xda199
> >  10: f7 d8                 neg    %eax
> >  12: 64 89 01              mov    %eax,%fs:(%rcx)
> >  15: 48                    rex.W
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240926/202409260949.a1254989-oliver.sang@intel.com
> 
> This seems to be related to [1] and __builtin_dynamic_object_size().
> 
> Compared to GCC, Clang's __bdos() is off by 4 bytes.
> 
> I made a small PoC: https://godbolt.org/z/vvK9PE1Yq
> 
> Thanks,
> Thorsten
> 
> [1] https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
> Cc: Bill Wendling

This should probably be reverted or dropped like that change was because
this breaks boot for me on when UBSAN_BOUNDS is enabled (like it is for
Fedora's configuration now, which I use for some machines).

It looks like Bill is working on a fix:

https://github.com/llvm/llvm-project/pull/110487

I see a bit of discussion going on there so I have not tried to verify
if that fix addresses both reported issues. I wonder if we should stop
trying to add __counted_by() annotations until this issue is fully
addressed, backported, and accounted for in the kernel sources? It seems
like this is relatively easy to trip up (at least from my perspective,
since I have hit this twice in the past couple of months) and only
released versions of clang have __counted_by(), so those users are more
likely to get hit with this issue. I do not think too many people test
with tip of tree GCC (or maybe they do but not with UBSAN_BOUNDS
enabled).

Cheers,
Nathan

