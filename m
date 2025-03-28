Return-Path: <linux-fsdevel+bounces-45214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC590A74C5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 15:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65BD18871F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25641B6CE9;
	Fri, 28 Mar 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Z0npusDx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48161B4244
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171624; cv=none; b=OPU2nRjr6HVapWy9FtcVpNYjf5EFh5Wa6aHX9JbA11vfImpHLR+aAYXPTi+PuLa/xvXiNmhb+OF3vc1Gm/IUE8VtfH+JcF+O91tH2kIl1okD7AllnF9rlN09l2kaXyb0QJQP6hWGOOfG0brgj0zgnzaiEH+v/dGzJMnQ6Yftlrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171624; c=relaxed/simple;
	bh=tCiUrUdCF2LourYFrLD46zAIiUJklcnRNi2hRVIDCGU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=awNBjiS/1Z41Wpw1ryQHxTQUEP2/UnyecFBAPAod8eBHxV4KJduLgGCo+MFyro7RJBkaHMK9mx0UXVRKstpAXhpLHjdUFJVQiJ15tWbOU30/zJuNEnytAqQTgejRJicqnBXX5YtOAAVmjzVLL+WvQUc/r1TC5QN833MYLO1Vn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Z0npusDx; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZPMrc4s9kzKJ0;
	Fri, 28 Mar 2025 15:11:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1743171072;
	bh=NFpUu6WrzhfUSQQIQTu0ReypD0HxLWchYWLFvMJMHMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z0npusDx073v2JnL3O5Irx8nSpTz8f0cgOlbn2l2iSzLaE7891FHnwk3Dm/eI1pzY
	 itkSGtdwwOK+ht2kDo0Xy75kfoq0ARYA2jK6v/SixjaUXzpI/bVYJiKiDQGA52Fqzr
	 OhjOHxNi4s0C5q3od047kGO5VwvrA6SVbzc0FjKk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZPMrb3BTZzbVQ;
	Fri, 28 Mar 2025 15:11:11 +0100 (CET)
Date: Fri, 28 Mar 2025 15:11:10 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [linux-next:master] [landlock]  9d65581539:
 WARNING:suspicious_RCU_usage
Message-ID: <20250328.aLawah0saice@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326.yee0ba6Yai3m@digikod.net>
 <Z+ZrSPZph9cDvUR4@xsang-OptiPlex-9020>
X-Infomaniak-Routing: alpha

On Fri, Mar 28, 2025 at 05:26:32PM +0800, Oliver Sang wrote:
> hi, Mickaël Salaün,
> 
> On Fri, Mar 28, 2025 at 09:31:15AM +0100, Mickaël Salaün wrote:
> > On Fri, Mar 28, 2025 at 02:05:59PM +0800, Oliver Sang wrote:
> > > hi, Mickaël Salaün,
> > > 
> > > On Fri, Mar 28, 2025 at 11:00:37AM +0800, Oliver Sang wrote:
> > > > hi, Mickaël Salaün,
> > > > 
> > > > On Thu, Mar 27, 2025 at 07:41:08PM +0100, Mickaël Salaün wrote:
> > > > > Hi Olivier,
> > > > > 
> > > > > I pushed an updated yesterday in linux-next that should fix this issue
> > > > > and this other issue too:
> > > > > https://lore.kernel.org/all/20250326.yee0ba6Yai3m@digikod.net/
> > > > > 
> > > > > Could you please confirm that these issues are really fixed? Or
> > > > > otherwise, please let me know when I should expect (or not) an email
> > > > > from kernel test robot. :)
> > > > 
> > > > ok, we've started the tests for both issues. upon the commit:
> > > > db8da9da41bce (tag: next-20250327, linux-next/master) Add linux-next specific files for 20250327
> > > 
> > > sorry that due to unknown reason, we cannot build sucessfully upon db8da9da41bce
> > > for both tests (which are using randconfig). could you give us the commit-id
> > > of your fix? we could try test upon that fix commit again.
> > 
> > The new commit is 18eb75f3af40 ("landlock: Always allow signals between
> > threads of the same process").
> 
> it turned out the build failure is due to my typo. shamed...
> 
> we finished tests still upon db8da9da41bce, for the WARNING:suspicious_RCU_usage
> issue in this report, we run the tests 20 times, cannot reproduce now.
> 
> for the random issues we reported in
> https://lore.kernel.org/all/202503261534.22d970e8-lkp@intel.com/
> now we cannot reproduce it with db8da9da41bce by 500 runs.

Yes, that makes sense with my fix.

> 
> we think both issues are solved.
> 
> and since db8da9da41bce includes the 18eb75f3af40, we won't test again upon
> 18eb75f3af40. thanks!

Thanks for the confirmation!

> 
> 
> > 
> > > 
> > > > 
> > > > if this is not the correct commit to check, please let us know. thanks!
> > > > 
> > > > > 
> > > > > Regards,
> > > > >  Mickaël
> > > > > 
> > > > > On Wed, Mar 26, 2025 at 04:00:12PM +0800, kernel test robot wrote:
> > > > > > 
> > > > > > hi, Mickaël Salaün,
> > > > > > 
> > > > > > we just reported a random
> > > > > > "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN"
> > > > > > issue in
> > > > > > https://lore.kernel.org/all/202503261534.22d970e8-lkp@intel.com/
> > > > > > 
> > > > > > now we noticed this commit is also in linux-next/master.
> > > > > > 
> > > > > > we don't have enough knowledge to check the difference, but we found a
> > > > > > persistent issue for this commit.
> > > > > > 
> > > > > > 6d9ac5e4d70eba3e 9d65581539252fdb1666917a095
> > > > > > ---------------- ---------------------------
> > > > > >        fail:runs  %reproduction    fail:runs
> > > > > >            |             |             |
> > > > > >            :6          100%           6:6     dmesg.WARNING:suspicious_RCU_usage
> > > > > >            :6          100%           6:6     dmesg.boot_failures
> > > > > >            :6          100%           6:6     dmesg.kernel/pid.c:#suspicious_rcu_dereference_check()usage
> > > > > > 
> > > > > > below full report FYI.
> > > > > > 
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
> > > > > > 
> > > > > > commit: 9d65581539252fdb1666917a09549c13090fe9e5 ("landlock: Always allow signals between threads of the same process")
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > > 
> > > > > > [test failed on linux-next/master eb4bc4b07f66f01618d9cb1aa4eaef59b1188415]
> > > > > > 
> > > > > > in testcase: trinity
> > > > > > version: trinity-x86_64-ba2360ed-1_20241228
> > > > > > with following parameters:
> > > > > > 
> > > > > > 	runtime: 300s
> > > > > > 	group: group-00
> > > > > > 	nr_groups: 5
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > config: x86_64-randconfig-101-20250325
> > > > > > compiler: gcc-12
> > > > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > > > > 
> > > > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > the same patch/commit), kindly add following tags
> > > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > > | Closes: https://lore.kernel.org/oe-lkp/202503261510.f9652c11-lkp@intel.com
> > > > > > 
> > > > > > 
> > > > > > [  166.893101][ T3747] WARNING: suspicious RCU usage
> > > > > > [  166.893462][ T3747] 6.14.0-rc5-00006-g9d6558153925 #1 Not tainted
> > > > > > [  166.893895][ T3747] -----------------------------
> > > > > > [  166.894239][ T3747] kernel/pid.c:414 suspicious rcu_dereference_check() usage!
> > > > > > [  166.894747][ T3747]
> > > > > > [  166.894747][ T3747] other info that might help us debug this:
> > > > > > [  166.894747][ T3747]
> > > > > > [  166.895450][ T3747]
> > > > > > [  166.895450][ T3747] rcu_scheduler_active = 2, debug_locks = 1
> > > > > > [  166.896030][ T3747] 3 locks held by trinity-c2/3747:
> > > > > > [ 166.896415][ T3747] #0: ffff888114a5a930 (&group->mark_mutex){+.+.}-{4:4}, at: fcntl_dirnotify (include/linux/sched/mm.h:332 include/linux/sched/mm.h:386 include/linux/fsnotify_backend.h:279 fs/notify/dnotify/dnotify.c:329) 
> > > > > > [ 166.897165][ T3747] #1: ffff888148bbea60 (&mark->lock){+.+.}-{3:3}, at: fcntl_dirnotify (fs/notify/dnotify/dnotify.c:349) 
> > > > > > [ 166.897831][ T3747] #2: ffff888108a53220 (&f_owner->lock){....}-{3:3}, at: __f_setown (fs/fcntl.c:137) 
> > > > > > [  166.898481][ T3747]
> > > > > > [  166.898481][ T3747] stack backtrace:
> > > > > > [  166.898901][ T3747] CPU: 0 UID: 65534 PID: 3747 Comm: trinity-c2 Not tainted 6.14.0-rc5-00006-g9d6558153925 #1
> > > > > > [  166.898908][ T3747] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > > > > [  166.898912][ T3747] Call Trace:
> > > > > > [  166.898916][ T3747]  <TASK>
> > > > > > [ 166.898921][ T3747] dump_stack_lvl (lib/dump_stack.c:123) 
> > > > > > [ 166.898932][ T3747] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6848) 
> > > > > > [ 166.898945][ T3747] pid_task (kernel/pid.c:414 (discriminator 11)) 
> > > > > > [ 166.898954][ T3747] hook_file_set_fowner (security/landlock/fs.c:1651 (discriminator 9)) 
> > > > > > [ 166.898963][ T3747] security_file_set_fowner (arch/x86/include/asm/atomic.h:23 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:457 (discriminator 4) include/linux/jump_label.h:262 (discriminator 4) security/security.c:3062 (discriminator 4)) 
> > > > > > [ 166.898969][ T3747] __f_setown (fs/fcntl.c:145) 
> > > > > > [ 166.898980][ T3747] fcntl_dirnotify (fs/notify/dnotify/dnotify.c:233 fs/notify/dnotify/dnotify.c:371) 
> > > > > > [ 166.898996][ T3747] do_fcntl (fs/fcntl.c:539) 
> > > > > > [ 166.899002][ T3747] ? f_getown (fs/fcntl.c:448) 
> > > > > > [ 166.899007][ T3747] ? check_prev_add (kernel/locking/lockdep.c:3862) 
> > > > > > [ 166.899011][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > > > > > [ 166.899023][ T3747] ? syscall_exit_to_user_mode (include/linux/entry-common.h:361 kernel/entry/common.c:220) 
> > > > > > [ 166.899038][ T3747] __x64_sys_fcntl (fs/fcntl.c:591 fs/fcntl.c:576 fs/fcntl.c:576) 
> > > > > > [ 166.899050][ T3747] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
> > > > > > [ 166.899062][ T3747] ? find_held_lock (kernel/locking/lockdep.c:5341) 
> > > > > > [ 166.899072][ T3747] ? __lock_release+0x10b/0x440 
> > > > > > [ 166.899076][ T3747] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
> > > > > > [ 166.899082][ T3747] ? reacquire_held_locks (kernel/locking/lockdep.c:5502) 
> > > > > > [ 166.899087][ T3747] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4470) 
> > > > > > [ 166.899093][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > > > > > [ 166.899099][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > > > > > [ 166.899111][ T3747] ? syscall_exit_to_user_mode (include/linux/entry-common.h:361 kernel/entry/common.c:220) 
> > > > > > [ 166.899119][ T3747] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:4409) 
> > > > > > [ 166.899124][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > > > > > [ 166.899129][ T3747] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4470) 
> > > > > > [ 166.899134][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> > > > > > [ 166.899139][ T3747] ? do_int80_emulation (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 arch/x86/entry/common.c:230) 
> > > > > > [ 166.899149][ T3747] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> > > > > > [  166.899155][ T3747] RIP: 0033:0x7f55ad007719
> > > > > > [ 166.899159][ T3747] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
> > > > > > All code
> > > > > > ========
> > > > > >    0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
> > > > > >    6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
> > > > > >    d:	00 00 00 
> > > > > >   10:	90                   	nop
> > > > > >   11:	48 89 f8             	mov    %rdi,%rax
> > > > > >   14:	48 89 f7             	mov    %rsi,%rdi
> > > > > >   17:	48 89 d6             	mov    %rdx,%rsi
> > > > > >   1a:	48 89 ca             	mov    %rcx,%rdx
> > > > > >   1d:	4d 89 c2             	mov    %r8,%r10
> > > > > >   20:	4d 89 c8             	mov    %r9,%r8
> > > > > >   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
> > > > > >   28:	0f 05                	syscall
> > > > > >   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
> > > > > >   30:	73 01                	jae    0x33
> > > > > >   32:	c3                   	ret
> > > > > >   33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
> > > > > >   3a:	f7 d8                	neg    %eax
> > > > > >   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
> > > > > >   3f:	48                   	rex.W
> > > > > > 
> > > > > > Code starting with the faulting instruction
> > > > > > ===========================================
> > > > > >    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
> > > > > >    6:	73 01                	jae    0x9
> > > > > >    8:	c3                   	ret
> > > > > >    9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
> > > > > >   10:	f7 d8                	neg    %eax
> > > > > >   12:	64 89 01             	mov    %eax,%fs:(%rcx)
> > > > > >   15:	48                   	rex.W
> > > > > > [  166.899164][ T3747] RSP: 002b:00007ffff6eefb48 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
> > > > > > [  166.899168][ T3747] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f55ad007719
> > > > > > [  166.899172][ T3747] RDX: 0000000000000027 RSI: 0000000000000402 RDI: 0000000000000043
> > > > > > [  166.899174][ T3747] RBP: 00007f55ab92f058 R08: 0000000099999999 R09: 00000000377dd000
> > > > > > [  166.899177][ T3747] R10: 0000000084848484 R11: 0000000000000246 R12: 0000000000000048
> > > > > > [  166.899180][ T3747] R13: 00007f55acf036c0 R14: 00007f55ab92f058 R15: 00007f55ab92f000
> > > > > > [  166.899203][ T3747]  </TASK>
> > > > > > 
> > > > > > 
> > > > > > The kernel config and materials to reproduce are available at:
> > > > > > https://download.01.org/0day-ci/archive/20250326/202503261510.f9652c11-lkp@intel.com
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > -- 
> > > > > > 0-DAY CI Kernel Test Service
> > > > > > https://github.com/intel/lkp-tests/wiki
> > > > > > 
> > > > > > 

