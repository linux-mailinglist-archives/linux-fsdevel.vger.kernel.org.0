Return-Path: <linux-fsdevel+bounces-45078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3446CA71613
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC89D188AE10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257321DE3C1;
	Wed, 26 Mar 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0wvB8FyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE61DCB09
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989937; cv=none; b=kxi0gSvO3gcQhqJ3N2lylm0MuLXLv6bt2TMfmK8djY/NMpJ5QOvg7fub8GrNNVrJkc7AxZikGhOLxSw9RMkUBvfRwTbTw6k7101rGYxdQXsBh3pAeo24UOEZvlWvcpIEc24zRBehKcZBKvt4fQxxpawWQdIU2XNN6oPgXzhSu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989937; c=relaxed/simple;
	bh=8cyDx9wVP/Gy2xluNiBapMP4xm1cu9Oyl4Ndi5zL45E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmi6miIdpf9fqPjc1tBSiDdDtJQc6tzvdoiIZDNbjpC99bMmhmhnRATUCA+KNJTDFy5dbQHVlQVRXm89LgtkbItT2eoaqBHHtRyhw9YyUz/BtsuNadOocch/EyfKICHmr7snVNjs3oJGzNXTCInbukSYNvHP3Ka0RqcKQMHwC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0wvB8FyH; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZN4s00QK7zC9p;
	Wed, 26 Mar 2025 12:52:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742989923;
	bh=SCpArMTAtLmBGImoCXFsMK89FrGt8j+KSIC6OMtvA1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0wvB8FyHGIvCZCra4QbCqRIFs1M37LGJb5M8pAiWmZWgl/ylVXkAKlWe4ix6jY8id
	 jAciPlX98Sn9na1bE57WBdftcs+r8+PsDijqrox7b4w1GzHF7RrG0A4YwNGd8qjjqf
	 6rvYOpfnwDqqbtXX+BoEvPO3m/rgSYi500+0QP1A=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZN4rz06gdzS4t;
	Wed, 26 Mar 2025 12:52:02 +0100 (CET)
Date: Wed, 26 Mar 2025 12:51:59 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 5/8] landlock: Always allow signals between threads of
 the same process
Message-ID: <20250326.yee0ba6Yai3m@digikod.net>
References: <20250318161443.279194-6-mic@digikod.net>
 <202503261534.22d970e8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202503261534.22d970e8-lkp@intel.com>
X-Infomaniak-Routing: alpha

Thanks for the report.

I assumed __f_setown() was only called in an RCU read-side critical section but
that's not the case (e.g. fcntl_dirnotify).  I moved the pid_task() call in a
dedicated function to protect it with an RCU guard.  Here is the new hunk:


@@ -1628,21 +1630,46 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
        return -EACCES;
 }

-static void hook_file_set_fowner(struct file *file)
+/*
+ * Always allow sending signals between threads of the same process.  This
+ * ensures consistency with hook_task_kill().
+ */
+static bool control_current_fowner(struct fown_struct *const fown)
 {
-       struct landlock_ruleset *new_dom, *prev_dom;
+       struct task_struct *p;

        /*
         * Lock already held by __f_setown(), see commit 26f204380a3c ("fs: Fix
         * file_set_fowner LSM hook inconsistencies").
         */
-       lockdep_assert_held(&file_f_owner(file)->lock);
-       new_dom = landlock_get_current_domain();
-       landlock_get_ruleset(new_dom);
+       lockdep_assert_held(&fown->lock);
+
+       /*
+        * Some callers (e.g. fcntl_dirnotify) may not be in an RCU read-side
+        * critical section.
+        */
+       guard(rcu)();
+       p = pid_task(fown->pid, fown->pid_type);
+       if (!p)
+               return true;
+
+       return !same_thread_group(p, current);
+}
+
+static void hook_file_set_fowner(struct file *file)
+{
+       struct landlock_ruleset *prev_dom;
+       struct landlock_ruleset *new_dom = NULL;
+
+       if (control_current_fowner(file_f_owner(file))) {
+               new_dom = landlock_get_current_domain();
+               landlock_get_ruleset(new_dom);
+       }
+
        prev_dom = landlock_file(file)->fown_domain;
        landlock_file(file)->fown_domain = new_dom;

-       /* Called in an RCU read-side critical section. */
+       /* May be called in an RCU read-side critical section. */
        landlock_put_ruleset_deferred(prev_dom);
 }


This other report gives more details:
https://lore.kernel.org/all/202503261510.f9652c11-lkp@intel.com/


On Wed, Mar 26, 2025 at 03:51:50PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN" on:
> 
> commit: b9fb5bfdb361fd6d945c09c93d351740310a26c7 ("[PATCH v2 5/8] landlock: Always allow signals between threads of the same process")
> url: https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/landlock-Move-code-to-ease-future-backports/20250319-003737
> patch link: https://lore.kernel.org/all/20250318161443.279194-6-mic@digikod.net/
> patch subject: [PATCH v2 5/8] landlock: Always allow signals between threads of the same process
> 
> in testcase: trinity
> version: trinity-x86_64-ba2360ed-1_20241228
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-03
> 	nr_groups: 5
> 
> 
> 
> config: x86_64-randconfig-005-20250325
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> we noticed the issue happens randomly (35 times out of 200 runs as below).
> but parent keeps clean.
> 
> 
> 37897789c51dd898 b9fb5bfdb361fd6d945c09c93d3
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :200         18%          35:200   dmesg.KASAN:null-ptr-deref_in_range[#-#]
>            :200         18%          35:200   dmesg.Kernel_panic-not_syncing:Fatal_exception
>            :200         18%          35:200   dmesg.Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN
>            :200         18%          35:200   dmesg.RIP:hook_file_set_fowner
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202503261534.22d970e8-lkp@intel.com
> 
> 
> [  354.738531][  T222]
> [  355.199494][  T222] [main] 2245715 iterations. [F:1644455 S:601688 HI:11581]
> [  355.199514][  T222]
> [  355.934630][  T222] [main] 2273938 iterations. [F:1665198 S:609188 HI:11581]
> [  355.934650][  T222]
> [  356.308897][ T3147] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000151: 0000 [#1] SMP KASAN
> [  356.309510][ T3147] KASAN: null-ptr-deref in range [0x0000000000000a88-0x0000000000000a8f]
> [  356.309910][ T3147] CPU: 1 UID: 65534 PID: 3147 Comm: trinity-c2 Not tainted 6.14.0-rc5-00005-gb9fb5bfdb361 #1 145c38dc5407add8933da653ccf9cf31d58da93c
> [  356.310560][ T3147] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 356.311050][ T3147] RIP: 0010:hook_file_set_fowner (kbuild/src/consumer/include/linux/sched/signal.h:707 (discriminator 9) kbuild/src/consumer/security/landlock/fs.c:1651 (discriminator 9)) 
> [ 356.311345][ T3147] Code: 49 8b 7c 24 50 65 4c 8b 25 e7 e4 0c 7e e8 52 63 33 ff 48 ba 00 00 00 00 00 fc ff df 48 8d b8 88 0a 00 00 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 7e 02 00 00 49 8d bc 24 88 0a 00 00 4c 8b a8 88
> All code
> ========
>    0:	49 8b 7c 24 50       	mov    0x50(%r12),%rdi
>    5:	65 4c 8b 25 e7 e4 0c 	mov    %gs:0x7e0ce4e7(%rip),%r12        # 0x7e0ce4f4
>    c:	7e 
>    d:	e8 52 63 33 ff       	call   0xffffffffff336364
>   12:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
>   19:	fc ff df 
>   1c:	48 8d b8 88 0a 00 00 	lea    0xa88(%rax),%rdi
>   23:	48 89 f9             	mov    %rdi,%rcx
>   26:	48 c1 e9 03          	shr    $0x3,%rcx
>   2a:*	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)		<-- trapping instruction
>   2e:	0f 85 7e 02 00 00    	jne    0x2b2
>   34:	49 8d bc 24 88 0a 00 	lea    0xa88(%r12),%rdi
>   3b:	00 
>   3c:	4c                   	rex.WR
>   3d:	8b                   	.byte 0x8b
>   3e:	a8 88                	test   $0x88,%al
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
>    4:	0f 85 7e 02 00 00    	jne    0x288
>    a:	49 8d bc 24 88 0a 00 	lea    0xa88(%r12),%rdi
>   11:	00 
>   12:	4c                   	rex.WR
>   13:	8b                   	.byte 0x8b
>   14:	a8 88                	test   $0x88,%al
> [  356.312254][ T3147] RSP: 0018:ffffc9000883fd20 EFLAGS: 00010002
> [  356.312556][ T3147] RAX: 0000000000000000 RBX: ffff88816ee4c700 RCX: 0000000000000151
> [  356.312933][ T3147] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000a88
> [  356.313310][ T3147] RBP: ffffc9000883fd48 R08: 0000000000000000 R09: 0000000000000000
> [  356.313687][ T3147] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88814f0c8000
> [  356.314063][ T3147] R13: ffff88814f92b700 R14: ffff888161e71450 R15: ffff888161e71408
> [  356.314440][ T3147] FS:  00007f3c72136740(0000) GS:ffff8883af000000(0000) knlGS:0000000000000000
> [  356.314879][ T3147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  356.315194][ T3147] CR2: 00007f3c708bd000 CR3: 0000000165606000 CR4: 00000000000406f0
> [  356.315573][ T3147] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  356.315950][ T3147] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  356.316334][ T3147] Call Trace:
> [  356.316498][ T3147]  <TASK>
> [ 356.316645][ T3147] ? show_regs (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:479) 
> [ 356.316859][ T3147] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
> [ 356.317066][ T3147] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751 kbuild/src/consumer/arch/x86/kernel/traps.c:693) 
> [ 356.317349][ T3147] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:574) 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250326/202503261534.22d970e8-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 

