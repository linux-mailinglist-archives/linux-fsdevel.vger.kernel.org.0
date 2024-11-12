Return-Path: <linux-fsdevel+bounces-34420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5B9C525C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832982834FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513EC20EA5B;
	Tue, 12 Nov 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gn8QF6ar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D561AB535;
	Tue, 12 Nov 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404841; cv=none; b=mkhoyV2X5CKy1G0xe8sbIdBUOe9E/XtjHjwra6n9aJoRzYHpaSZA2/a0So4QZdV5JcNia5b5dvizLVboWOed2i2oQbMTZY4bHKXGAxN1ylrwH40yUQzlzxkMfa+XX7t5HjP2YiXWx0g98uYV0UkA9N7WLV+SvAJF2ZVEF25PP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404841; c=relaxed/simple;
	bh=RgQLgKteT7/0JHP5evKwF5/pwbWHfdTs6vICOeDbino=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPtJklZcw5wTR1yIKtzXgbpG5xLM8HWE3yxSH8AIZdjanRT38ygcXWHMt9LP0eGhlfxzZbUMYser6UkXBQiOEvwxqaBE5Sz0h0l0bd9PhlOzb9Pxm/BZXlbAIgsx9C+gAxtQLfdo1eBUEffQO2eP5r5uRx1X2fsf8n/pFwvp6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gn8QF6ar; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731404840; x=1762940840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RgQLgKteT7/0JHP5evKwF5/pwbWHfdTs6vICOeDbino=;
  b=gn8QF6arubF+BTDFCkP+Ny3pOomr4NTy3C/k9nEeQ23O45v+IXlosz/K
   0uTiu9gJeG0wNmT5+3fE1dB+KzsN/1fHIfv3L8pMGIwJj8OYw1ZKbj5/b
   QuCXfg+DXPgwvUg1TVtImu6uWXQZHkNk1n89HB85ZjexgfN1WueQY2VAN
   d9zXa6yja+aWzy/gtulInWPAcevs2qbnuAgWXbMPoXkKvrWFWk73bFcpE
   9dTsW627MQM7s0XUwQdf4UdUoptPrC9H+z99J1JyWDm1FagegnM6hAD3Q
   vHoJ0A2VVtYKSYVCkaBf8/mkglrbSv1Ebew/lb/dj9lQGHaHp8p++2zwk
   A==;
X-CSE-ConnectionGUID: UzQRFlTZRWOEbCAhaewW8g==
X-CSE-MsgGUID: jpKLXKdqRMmnt9n2twKpwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31383943"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31383943"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:47:19 -0800
X-CSE-ConnectionGUID: cjOcukJIT+iEm5UhVBFeeA==
X-CSE-MsgGUID: iQePexooTqeMVx3w9gipNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="92318207"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Nov 2024 01:47:12 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAnUL-0000gd-0p;
	Tue, 12 Nov 2024 09:47:09 +0000
Date: Tue, 12 Nov 2024 17:47:06 +0800
From: kernel test robot <lkp@intel.com>
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v8 12/29] riscv/shstk: If needed allocate a new shadow
 stack on clone
Message-ID: <202411121717.INT1geTN-lkp@intel.com>
References: <20241111-v5_user_cfi_series-v8-12-dce14aa30207@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-v5_user_cfi_series-v8-12-dce14aa30207@rivosinc.com>

Hi Deepak,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 64f7b77f0bd9271861ed9e410e9856b6b0b21c48]

url:    https://github.com/intel-lab-lkp/linux/commits/Deepak-Gupta/mm-Introduce-ARCH_HAS_USER_SHADOW_STACK/20241112-050530
base:   64f7b77f0bd9271861ed9e410e9856b6b0b21c48
patch link:    https://lore.kernel.org/r/20241111-v5_user_cfi_series-v8-12-dce14aa30207%40rivosinc.com
patch subject: [PATCH v8 12/29] riscv/shstk: If needed allocate a new shadow stack on clone
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20241112/202411121717.INT1geTN-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121717.INT1geTN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121717.INT1geTN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/process.c:17:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/riscv/kernel/process.c:245:36: warning: expression result unused [-Wunused-value]
     245 |                 ssp ? set_active_shstk(p, ssp) : 0;
         |                                                  ^
   2 warnings generated.


vim +245 arch/riscv/kernel/process.c

   209	
   210	int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
   211	{
   212		unsigned long clone_flags = args->flags;
   213		unsigned long usp = args->stack;
   214		unsigned long tls = args->tls;
   215		unsigned long ssp = 0;
   216		struct pt_regs *childregs = task_pt_regs(p);
   217	
   218		/* Ensure all threads in this mm have the same pointer masking mode. */
   219		if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM) && p->mm && (clone_flags & CLONE_VM))
   220			set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
   221	
   222		memset(&p->thread.s, 0, sizeof(p->thread.s));
   223	
   224		/* p->thread holds context to be restored by __switch_to() */
   225		if (unlikely(args->fn)) {
   226			/* Kernel thread */
   227			memset(childregs, 0, sizeof(struct pt_regs));
   228			/* Supervisor/Machine, irqs on: */
   229			childregs->status = SR_PP | SR_PIE;
   230	
   231			p->thread.s[0] = (unsigned long)args->fn;
   232			p->thread.s[1] = (unsigned long)args->fn_arg;
   233		} else {
   234			/* allocate new shadow stack if needed. In case of CLONE_VM we have to */
   235			ssp = shstk_alloc_thread_stack(p, args);
   236			if (IS_ERR_VALUE(ssp))
   237				return PTR_ERR((void *)ssp);
   238	
   239			*childregs = *(current_pt_regs());
   240			/* Turn off status.VS */
   241			riscv_v_vstate_off(childregs);
   242			if (usp) /* User fork */
   243				childregs->sp = usp;
   244			/* if needed, set new ssp */
 > 245			ssp ? set_active_shstk(p, ssp) : 0;
   246			if (clone_flags & CLONE_SETTLS)
   247				childregs->tp = tls;
   248			childregs->a0 = 0; /* Return value of fork() */
   249			p->thread.s[0] = 0;
   250		}
   251		p->thread.riscv_v_flags = 0;
   252		if (has_vector())
   253			riscv_v_thread_alloc(p);
   254		p->thread.ra = (unsigned long)ret_from_fork;
   255		p->thread.sp = (unsigned long)childregs; /* kernel sp */
   256		return 0;
   257	}
   258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

