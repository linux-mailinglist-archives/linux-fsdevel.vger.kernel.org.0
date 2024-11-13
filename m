Return-Path: <linux-fsdevel+bounces-34591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CF9C67AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 04:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7838F1F24EE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 03:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A694166F1B;
	Wed, 13 Nov 2024 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxYBvwR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDE165EE8;
	Wed, 13 Nov 2024 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731467795; cv=none; b=Iain4bTfkW/Kp4KDEeIaqZDbIQmgGQtjLaM/b39zGCk1iwVbOSLPu3/LRj/qhmkXm1rlXr1mUuPHdGEXQxo72IiEUAnPOrW4xajKxdX6czZjGp93F40OtU8vprnfTnekpKQLxOzBbpE+o+b3zSOSw/GtZDNCyaMmcbeR0hfh8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731467795; c=relaxed/simple;
	bh=qBVrdESAIEn3UxPJ5TLFxbP3smtFST1npGdqYvR9qKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwV0VLDYQEsknihnBKAaCvI5j/gJATFQAgIF//t9Z79gWAl67Bk260wKEYl85i0YiMViJxvFILrx3Kp3KMSR8JVnHWQaWfWOMrS3bbqcv16rc6SsQz6tlQFS6EAyRDEkL9f+f01mP/RrgHNBB3YcnVs4sePUAzHCqytSD4S4IPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxYBvwR0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731467794; x=1763003794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qBVrdESAIEn3UxPJ5TLFxbP3smtFST1npGdqYvR9qKk=;
  b=RxYBvwR0UG9u+V1nwWGHXIAeps9ml46tpBZBFJHUNiiVHubZ6SIagWBp
   yz0jZVegEsAYpt3B5l1dmF62c9LJwJDU1sKY/zHd0lGzE6fSTme4/Jr35
   +fM33JSJ/UcdHzpwkdF4quF87KTH9hiZvZ3J8eaLYyoNIq7As2Ss56c9K
   WBEGG+gmi63J7ZUf4UwAZ5lofkEZeK8vdS7/0CERnTVSMAWEce9VW7fza
   sV7joS2mT57vG2QJxLKYOPplQwL6RplKF4UGAJMLl1AIIxs8bZanVu51D
   l7zROVdCJa1cAuc/iZzd7CeZqcjey6y3xjdTyS4p4sAfpQLmaaS+JAoi8
   A==;
X-CSE-ConnectionGUID: OUN5Pkt2Qrqjn582QeD0BA==
X-CSE-MsgGUID: X2Dw345PSz6hurYqR9kRSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48793870"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48793870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 19:16:32 -0800
X-CSE-ConnectionGUID: 8Gj/hxArQh+urshGKHK6pA==
X-CSE-MsgGUID: AipellR5SWGIt6T73UXu/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="125249489"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Nov 2024 19:16:24 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB3ri-0001yX-1D;
	Wed, 13 Nov 2024 03:16:22 +0000
Date: Wed, 13 Nov 2024 11:15:51 +0800
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
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v8 24/29] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Message-ID: <202411131001.zfDosm7U-lkp@intel.com>
References: <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>

Hi Deepak,

kernel test robot noticed the following build errors:

[auto build test ERROR on 64f7b77f0bd9271861ed9e410e9856b6b0b21c48]

url:    https://github.com/intel-lab-lkp/linux/commits/Deepak-Gupta/mm-Introduce-ARCH_HAS_USER_SHADOW_STACK/20241112-050530
base:   64f7b77f0bd9271861ed9e410e9856b6b0b21c48
patch link:    https://lore.kernel.org/r/20241111-v5_user_cfi_series-v8-24-dce14aa30207%40rivosinc.com
patch subject: [PATCH v8 24/29] riscv: enable kernel access to shadow stack memory via FWFT sbi call
config: riscv-randconfig-r063-20241113 (https://download.01.org/0day-ci/archive/20241113/202411131001.zfDosm7U-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411131001.zfDosm7U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411131001.zfDosm7U-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:744:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     744 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
     104 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:752:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     752 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:760:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     760 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:769:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     769 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:778:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:787:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     787 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from arch/riscv/kernel/asm-offsets.c:12:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1115:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1115 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> arch/riscv/kernel/asm-offsets.c:520:23: error: use of undeclared identifier 'SBI_EXT_FWFT'
     520 |         DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
         |                              ^
>> arch/riscv/kernel/asm-offsets.c:521:27: error: use of undeclared identifier 'SBI_EXT_FWFT_SET'
     521 |         DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
         |                                  ^
>> arch/riscv/kernel/asm-offsets.c:522:32: error: use of undeclared identifier 'SBI_FWFT_SHADOW_STACK'
     522 |         DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
         |                                       ^
>> arch/riscv/kernel/asm-offsets.c:523:33: error: use of undeclared identifier 'SBI_FWFT_SET_FLAG_LOCK'
     523 |         DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
         |                                        ^
   14 warnings and 4 errors generated.
   make[3]: *** [scripts/Makefile.build:102: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/SBI_EXT_FWFT +520 arch/riscv/kernel/asm-offsets.c

    95	
    96		DEFINE(PT_SIZE, sizeof(struct pt_regs));
    97		OFFSET(PT_EPC, pt_regs, epc);
    98		OFFSET(PT_RA, pt_regs, ra);
    99		OFFSET(PT_FP, pt_regs, s0);
   100		OFFSET(PT_S0, pt_regs, s0);
   101		OFFSET(PT_S1, pt_regs, s1);
   102		OFFSET(PT_S2, pt_regs, s2);
   103		OFFSET(PT_S3, pt_regs, s3);
   104		OFFSET(PT_S4, pt_regs, s4);
   105		OFFSET(PT_S5, pt_regs, s5);
   106		OFFSET(PT_S6, pt_regs, s6);
   107		OFFSET(PT_S7, pt_regs, s7);
   108		OFFSET(PT_S8, pt_regs, s8);
   109		OFFSET(PT_S9, pt_regs, s9);
   110		OFFSET(PT_S10, pt_regs, s10);
   111		OFFSET(PT_S11, pt_regs, s11);
   112		OFFSET(PT_SP, pt_regs, sp);
   113		OFFSET(PT_TP, pt_regs, tp);
   114		OFFSET(PT_A0, pt_regs, a0);
   115		OFFSET(PT_A1, pt_regs, a1);
   116		OFFSET(PT_A2, pt_regs, a2);
   117		OFFSET(PT_A3, pt_regs, a3);
   118		OFFSET(PT_A4, pt_regs, a4);
   119		OFFSET(PT_A5, pt_regs, a5);
   120		OFFSET(PT_A6, pt_regs, a6);
   121		OFFSET(PT_A7, pt_regs, a7);
   122		OFFSET(PT_T0, pt_regs, t0);
   123		OFFSET(PT_T1, pt_regs, t1);
   124		OFFSET(PT_T2, pt_regs, t2);
   125		OFFSET(PT_T3, pt_regs, t3);
   126		OFFSET(PT_T4, pt_regs, t4);
   127		OFFSET(PT_T5, pt_regs, t5);
   128		OFFSET(PT_T6, pt_regs, t6);
   129		OFFSET(PT_GP, pt_regs, gp);
   130		OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
   131		OFFSET(PT_STATUS, pt_regs, status);
   132		OFFSET(PT_BADADDR, pt_regs, badaddr);
   133		OFFSET(PT_CAUSE, pt_regs, cause);
   134	
   135		OFFSET(SUSPEND_CONTEXT_REGS, suspend_context, regs);
   136	
   137		OFFSET(HIBERN_PBE_ADDR, pbe, address);
   138		OFFSET(HIBERN_PBE_ORIG, pbe, orig_address);
   139		OFFSET(HIBERN_PBE_NEXT, pbe, next);
   140	
   141		OFFSET(KVM_ARCH_GUEST_ZERO, kvm_vcpu_arch, guest_context.zero);
   142		OFFSET(KVM_ARCH_GUEST_RA, kvm_vcpu_arch, guest_context.ra);
   143		OFFSET(KVM_ARCH_GUEST_SP, kvm_vcpu_arch, guest_context.sp);
   144		OFFSET(KVM_ARCH_GUEST_GP, kvm_vcpu_arch, guest_context.gp);
   145		OFFSET(KVM_ARCH_GUEST_TP, kvm_vcpu_arch, guest_context.tp);
   146		OFFSET(KVM_ARCH_GUEST_T0, kvm_vcpu_arch, guest_context.t0);
   147		OFFSET(KVM_ARCH_GUEST_T1, kvm_vcpu_arch, guest_context.t1);
   148		OFFSET(KVM_ARCH_GUEST_T2, kvm_vcpu_arch, guest_context.t2);
   149		OFFSET(KVM_ARCH_GUEST_S0, kvm_vcpu_arch, guest_context.s0);
   150		OFFSET(KVM_ARCH_GUEST_S1, kvm_vcpu_arch, guest_context.s1);
   151		OFFSET(KVM_ARCH_GUEST_A0, kvm_vcpu_arch, guest_context.a0);
   152		OFFSET(KVM_ARCH_GUEST_A1, kvm_vcpu_arch, guest_context.a1);
   153		OFFSET(KVM_ARCH_GUEST_A2, kvm_vcpu_arch, guest_context.a2);
   154		OFFSET(KVM_ARCH_GUEST_A3, kvm_vcpu_arch, guest_context.a3);
   155		OFFSET(KVM_ARCH_GUEST_A4, kvm_vcpu_arch, guest_context.a4);
   156		OFFSET(KVM_ARCH_GUEST_A5, kvm_vcpu_arch, guest_context.a5);
   157		OFFSET(KVM_ARCH_GUEST_A6, kvm_vcpu_arch, guest_context.a6);
   158		OFFSET(KVM_ARCH_GUEST_A7, kvm_vcpu_arch, guest_context.a7);
   159		OFFSET(KVM_ARCH_GUEST_S2, kvm_vcpu_arch, guest_context.s2);
   160		OFFSET(KVM_ARCH_GUEST_S3, kvm_vcpu_arch, guest_context.s3);
   161		OFFSET(KVM_ARCH_GUEST_S4, kvm_vcpu_arch, guest_context.s4);
   162		OFFSET(KVM_ARCH_GUEST_S5, kvm_vcpu_arch, guest_context.s5);
   163		OFFSET(KVM_ARCH_GUEST_S6, kvm_vcpu_arch, guest_context.s6);
   164		OFFSET(KVM_ARCH_GUEST_S7, kvm_vcpu_arch, guest_context.s7);
   165		OFFSET(KVM_ARCH_GUEST_S8, kvm_vcpu_arch, guest_context.s8);
   166		OFFSET(KVM_ARCH_GUEST_S9, kvm_vcpu_arch, guest_context.s9);
   167		OFFSET(KVM_ARCH_GUEST_S10, kvm_vcpu_arch, guest_context.s10);
   168		OFFSET(KVM_ARCH_GUEST_S11, kvm_vcpu_arch, guest_context.s11);
   169		OFFSET(KVM_ARCH_GUEST_T3, kvm_vcpu_arch, guest_context.t3);
   170		OFFSET(KVM_ARCH_GUEST_T4, kvm_vcpu_arch, guest_context.t4);
   171		OFFSET(KVM_ARCH_GUEST_T5, kvm_vcpu_arch, guest_context.t5);
   172		OFFSET(KVM_ARCH_GUEST_T6, kvm_vcpu_arch, guest_context.t6);
   173		OFFSET(KVM_ARCH_GUEST_SEPC, kvm_vcpu_arch, guest_context.sepc);
   174		OFFSET(KVM_ARCH_GUEST_SSTATUS, kvm_vcpu_arch, guest_context.sstatus);
   175		OFFSET(KVM_ARCH_GUEST_HSTATUS, kvm_vcpu_arch, guest_context.hstatus);
   176		OFFSET(KVM_ARCH_GUEST_SCOUNTEREN, kvm_vcpu_arch, guest_csr.scounteren);
   177	
   178		OFFSET(KVM_ARCH_HOST_ZERO, kvm_vcpu_arch, host_context.zero);
   179		OFFSET(KVM_ARCH_HOST_RA, kvm_vcpu_arch, host_context.ra);
   180		OFFSET(KVM_ARCH_HOST_SP, kvm_vcpu_arch, host_context.sp);
   181		OFFSET(KVM_ARCH_HOST_GP, kvm_vcpu_arch, host_context.gp);
   182		OFFSET(KVM_ARCH_HOST_TP, kvm_vcpu_arch, host_context.tp);
   183		OFFSET(KVM_ARCH_HOST_T0, kvm_vcpu_arch, host_context.t0);
   184		OFFSET(KVM_ARCH_HOST_T1, kvm_vcpu_arch, host_context.t1);
   185		OFFSET(KVM_ARCH_HOST_T2, kvm_vcpu_arch, host_context.t2);
   186		OFFSET(KVM_ARCH_HOST_S0, kvm_vcpu_arch, host_context.s0);
   187		OFFSET(KVM_ARCH_HOST_S1, kvm_vcpu_arch, host_context.s1);
   188		OFFSET(KVM_ARCH_HOST_A0, kvm_vcpu_arch, host_context.a0);
   189		OFFSET(KVM_ARCH_HOST_A1, kvm_vcpu_arch, host_context.a1);
   190		OFFSET(KVM_ARCH_HOST_A2, kvm_vcpu_arch, host_context.a2);
   191		OFFSET(KVM_ARCH_HOST_A3, kvm_vcpu_arch, host_context.a3);
   192		OFFSET(KVM_ARCH_HOST_A4, kvm_vcpu_arch, host_context.a4);
   193		OFFSET(KVM_ARCH_HOST_A5, kvm_vcpu_arch, host_context.a5);
   194		OFFSET(KVM_ARCH_HOST_A6, kvm_vcpu_arch, host_context.a6);
   195		OFFSET(KVM_ARCH_HOST_A7, kvm_vcpu_arch, host_context.a7);
   196		OFFSET(KVM_ARCH_HOST_S2, kvm_vcpu_arch, host_context.s2);
   197		OFFSET(KVM_ARCH_HOST_S3, kvm_vcpu_arch, host_context.s3);
   198		OFFSET(KVM_ARCH_HOST_S4, kvm_vcpu_arch, host_context.s4);
   199		OFFSET(KVM_ARCH_HOST_S5, kvm_vcpu_arch, host_context.s5);
   200		OFFSET(KVM_ARCH_HOST_S6, kvm_vcpu_arch, host_context.s6);
   201		OFFSET(KVM_ARCH_HOST_S7, kvm_vcpu_arch, host_context.s7);
   202		OFFSET(KVM_ARCH_HOST_S8, kvm_vcpu_arch, host_context.s8);
   203		OFFSET(KVM_ARCH_HOST_S9, kvm_vcpu_arch, host_context.s9);
   204		OFFSET(KVM_ARCH_HOST_S10, kvm_vcpu_arch, host_context.s10);
   205		OFFSET(KVM_ARCH_HOST_S11, kvm_vcpu_arch, host_context.s11);
   206		OFFSET(KVM_ARCH_HOST_T3, kvm_vcpu_arch, host_context.t3);
   207		OFFSET(KVM_ARCH_HOST_T4, kvm_vcpu_arch, host_context.t4);
   208		OFFSET(KVM_ARCH_HOST_T5, kvm_vcpu_arch, host_context.t5);
   209		OFFSET(KVM_ARCH_HOST_T6, kvm_vcpu_arch, host_context.t6);
   210		OFFSET(KVM_ARCH_HOST_SEPC, kvm_vcpu_arch, host_context.sepc);
   211		OFFSET(KVM_ARCH_HOST_SSTATUS, kvm_vcpu_arch, host_context.sstatus);
   212		OFFSET(KVM_ARCH_HOST_HSTATUS, kvm_vcpu_arch, host_context.hstatus);
   213		OFFSET(KVM_ARCH_HOST_SSCRATCH, kvm_vcpu_arch, host_sscratch);
   214		OFFSET(KVM_ARCH_HOST_STVEC, kvm_vcpu_arch, host_stvec);
   215		OFFSET(KVM_ARCH_HOST_SCOUNTEREN, kvm_vcpu_arch, host_scounteren);
   216	
   217		OFFSET(KVM_ARCH_TRAP_SEPC, kvm_cpu_trap, sepc);
   218		OFFSET(KVM_ARCH_TRAP_SCAUSE, kvm_cpu_trap, scause);
   219		OFFSET(KVM_ARCH_TRAP_STVAL, kvm_cpu_trap, stval);
   220		OFFSET(KVM_ARCH_TRAP_HTVAL, kvm_cpu_trap, htval);
   221		OFFSET(KVM_ARCH_TRAP_HTINST, kvm_cpu_trap, htinst);
   222	
   223		/* F extension */
   224	
   225		OFFSET(KVM_ARCH_FP_F_F0, kvm_cpu_context, fp.f.f[0]);
   226		OFFSET(KVM_ARCH_FP_F_F1, kvm_cpu_context, fp.f.f[1]);
   227		OFFSET(KVM_ARCH_FP_F_F2, kvm_cpu_context, fp.f.f[2]);
   228		OFFSET(KVM_ARCH_FP_F_F3, kvm_cpu_context, fp.f.f[3]);
   229		OFFSET(KVM_ARCH_FP_F_F4, kvm_cpu_context, fp.f.f[4]);
   230		OFFSET(KVM_ARCH_FP_F_F5, kvm_cpu_context, fp.f.f[5]);
   231		OFFSET(KVM_ARCH_FP_F_F6, kvm_cpu_context, fp.f.f[6]);
   232		OFFSET(KVM_ARCH_FP_F_F7, kvm_cpu_context, fp.f.f[7]);
   233		OFFSET(KVM_ARCH_FP_F_F8, kvm_cpu_context, fp.f.f[8]);
   234		OFFSET(KVM_ARCH_FP_F_F9, kvm_cpu_context, fp.f.f[9]);
   235		OFFSET(KVM_ARCH_FP_F_F10, kvm_cpu_context, fp.f.f[10]);
   236		OFFSET(KVM_ARCH_FP_F_F11, kvm_cpu_context, fp.f.f[11]);
   237		OFFSET(KVM_ARCH_FP_F_F12, kvm_cpu_context, fp.f.f[12]);
   238		OFFSET(KVM_ARCH_FP_F_F13, kvm_cpu_context, fp.f.f[13]);
   239		OFFSET(KVM_ARCH_FP_F_F14, kvm_cpu_context, fp.f.f[14]);
   240		OFFSET(KVM_ARCH_FP_F_F15, kvm_cpu_context, fp.f.f[15]);
   241		OFFSET(KVM_ARCH_FP_F_F16, kvm_cpu_context, fp.f.f[16]);
   242		OFFSET(KVM_ARCH_FP_F_F17, kvm_cpu_context, fp.f.f[17]);
   243		OFFSET(KVM_ARCH_FP_F_F18, kvm_cpu_context, fp.f.f[18]);
   244		OFFSET(KVM_ARCH_FP_F_F19, kvm_cpu_context, fp.f.f[19]);
   245		OFFSET(KVM_ARCH_FP_F_F20, kvm_cpu_context, fp.f.f[20]);
   246		OFFSET(KVM_ARCH_FP_F_F21, kvm_cpu_context, fp.f.f[21]);
   247		OFFSET(KVM_ARCH_FP_F_F22, kvm_cpu_context, fp.f.f[22]);
   248		OFFSET(KVM_ARCH_FP_F_F23, kvm_cpu_context, fp.f.f[23]);
   249		OFFSET(KVM_ARCH_FP_F_F24, kvm_cpu_context, fp.f.f[24]);
   250		OFFSET(KVM_ARCH_FP_F_F25, kvm_cpu_context, fp.f.f[25]);
   251		OFFSET(KVM_ARCH_FP_F_F26, kvm_cpu_context, fp.f.f[26]);
   252		OFFSET(KVM_ARCH_FP_F_F27, kvm_cpu_context, fp.f.f[27]);
   253		OFFSET(KVM_ARCH_FP_F_F28, kvm_cpu_context, fp.f.f[28]);
   254		OFFSET(KVM_ARCH_FP_F_F29, kvm_cpu_context, fp.f.f[29]);
   255		OFFSET(KVM_ARCH_FP_F_F30, kvm_cpu_context, fp.f.f[30]);
   256		OFFSET(KVM_ARCH_FP_F_F31, kvm_cpu_context, fp.f.f[31]);
   257		OFFSET(KVM_ARCH_FP_F_FCSR, kvm_cpu_context, fp.f.fcsr);
   258	
   259		/* D extension */
   260	
   261		OFFSET(KVM_ARCH_FP_D_F0, kvm_cpu_context, fp.d.f[0]);
   262		OFFSET(KVM_ARCH_FP_D_F1, kvm_cpu_context, fp.d.f[1]);
   263		OFFSET(KVM_ARCH_FP_D_F2, kvm_cpu_context, fp.d.f[2]);
   264		OFFSET(KVM_ARCH_FP_D_F3, kvm_cpu_context, fp.d.f[3]);
   265		OFFSET(KVM_ARCH_FP_D_F4, kvm_cpu_context, fp.d.f[4]);
   266		OFFSET(KVM_ARCH_FP_D_F5, kvm_cpu_context, fp.d.f[5]);
   267		OFFSET(KVM_ARCH_FP_D_F6, kvm_cpu_context, fp.d.f[6]);
   268		OFFSET(KVM_ARCH_FP_D_F7, kvm_cpu_context, fp.d.f[7]);
   269		OFFSET(KVM_ARCH_FP_D_F8, kvm_cpu_context, fp.d.f[8]);
   270		OFFSET(KVM_ARCH_FP_D_F9, kvm_cpu_context, fp.d.f[9]);
   271		OFFSET(KVM_ARCH_FP_D_F10, kvm_cpu_context, fp.d.f[10]);
   272		OFFSET(KVM_ARCH_FP_D_F11, kvm_cpu_context, fp.d.f[11]);
   273		OFFSET(KVM_ARCH_FP_D_F12, kvm_cpu_context, fp.d.f[12]);
   274		OFFSET(KVM_ARCH_FP_D_F13, kvm_cpu_context, fp.d.f[13]);
   275		OFFSET(KVM_ARCH_FP_D_F14, kvm_cpu_context, fp.d.f[14]);
   276		OFFSET(KVM_ARCH_FP_D_F15, kvm_cpu_context, fp.d.f[15]);
   277		OFFSET(KVM_ARCH_FP_D_F16, kvm_cpu_context, fp.d.f[16]);
   278		OFFSET(KVM_ARCH_FP_D_F17, kvm_cpu_context, fp.d.f[17]);
   279		OFFSET(KVM_ARCH_FP_D_F18, kvm_cpu_context, fp.d.f[18]);
   280		OFFSET(KVM_ARCH_FP_D_F19, kvm_cpu_context, fp.d.f[19]);
   281		OFFSET(KVM_ARCH_FP_D_F20, kvm_cpu_context, fp.d.f[20]);
   282		OFFSET(KVM_ARCH_FP_D_F21, kvm_cpu_context, fp.d.f[21]);
   283		OFFSET(KVM_ARCH_FP_D_F22, kvm_cpu_context, fp.d.f[22]);
   284		OFFSET(KVM_ARCH_FP_D_F23, kvm_cpu_context, fp.d.f[23]);
   285		OFFSET(KVM_ARCH_FP_D_F24, kvm_cpu_context, fp.d.f[24]);
   286		OFFSET(KVM_ARCH_FP_D_F25, kvm_cpu_context, fp.d.f[25]);
   287		OFFSET(KVM_ARCH_FP_D_F26, kvm_cpu_context, fp.d.f[26]);
   288		OFFSET(KVM_ARCH_FP_D_F27, kvm_cpu_context, fp.d.f[27]);
   289		OFFSET(KVM_ARCH_FP_D_F28, kvm_cpu_context, fp.d.f[28]);
   290		OFFSET(KVM_ARCH_FP_D_F29, kvm_cpu_context, fp.d.f[29]);
   291		OFFSET(KVM_ARCH_FP_D_F30, kvm_cpu_context, fp.d.f[30]);
   292		OFFSET(KVM_ARCH_FP_D_F31, kvm_cpu_context, fp.d.f[31]);
   293		OFFSET(KVM_ARCH_FP_D_FCSR, kvm_cpu_context, fp.d.fcsr);
   294	
   295		/*
   296		 * THREAD_{F,X}* might be larger than a S-type offset can handle, but
   297		 * these are used in performance-sensitive assembly so we can't resort
   298		 * to loading the long immediate every time.
   299		 */
   300		DEFINE(TASK_THREAD_RA_RA,
   301			  offsetof(struct task_struct, thread.ra)
   302			- offsetof(struct task_struct, thread.ra)
   303		);
   304		DEFINE(TASK_THREAD_SP_RA,
   305			  offsetof(struct task_struct, thread.sp)
   306			- offsetof(struct task_struct, thread.ra)
   307		);
   308		DEFINE(TASK_THREAD_S0_RA,
   309			  offsetof(struct task_struct, thread.s[0])
   310			- offsetof(struct task_struct, thread.ra)
   311		);
   312		DEFINE(TASK_THREAD_S1_RA,
   313			  offsetof(struct task_struct, thread.s[1])
   314			- offsetof(struct task_struct, thread.ra)
   315		);
   316		DEFINE(TASK_THREAD_S2_RA,
   317			  offsetof(struct task_struct, thread.s[2])
   318			- offsetof(struct task_struct, thread.ra)
   319		);
   320		DEFINE(TASK_THREAD_S3_RA,
   321			  offsetof(struct task_struct, thread.s[3])
   322			- offsetof(struct task_struct, thread.ra)
   323		);
   324		DEFINE(TASK_THREAD_S4_RA,
   325			  offsetof(struct task_struct, thread.s[4])
   326			- offsetof(struct task_struct, thread.ra)
   327		);
   328		DEFINE(TASK_THREAD_S5_RA,
   329			  offsetof(struct task_struct, thread.s[5])
   330			- offsetof(struct task_struct, thread.ra)
   331		);
   332		DEFINE(TASK_THREAD_S6_RA,
   333			  offsetof(struct task_struct, thread.s[6])
   334			- offsetof(struct task_struct, thread.ra)
   335		);
   336		DEFINE(TASK_THREAD_S7_RA,
   337			  offsetof(struct task_struct, thread.s[7])
   338			- offsetof(struct task_struct, thread.ra)
   339		);
   340		DEFINE(TASK_THREAD_S8_RA,
   341			  offsetof(struct task_struct, thread.s[8])
   342			- offsetof(struct task_struct, thread.ra)
   343		);
   344		DEFINE(TASK_THREAD_S9_RA,
   345			  offsetof(struct task_struct, thread.s[9])
   346			- offsetof(struct task_struct, thread.ra)
   347		);
   348		DEFINE(TASK_THREAD_S10_RA,
   349			  offsetof(struct task_struct, thread.s[10])
   350			- offsetof(struct task_struct, thread.ra)
   351		);
   352		DEFINE(TASK_THREAD_S11_RA,
   353			  offsetof(struct task_struct, thread.s[11])
   354			- offsetof(struct task_struct, thread.ra)
   355		);
   356	
   357		DEFINE(TASK_THREAD_F0_F0,
   358			  offsetof(struct task_struct, thread.fstate.f[0])
   359			- offsetof(struct task_struct, thread.fstate.f[0])
   360		);
   361		DEFINE(TASK_THREAD_F1_F0,
   362			  offsetof(struct task_struct, thread.fstate.f[1])
   363			- offsetof(struct task_struct, thread.fstate.f[0])
   364		);
   365		DEFINE(TASK_THREAD_F2_F0,
   366			  offsetof(struct task_struct, thread.fstate.f[2])
   367			- offsetof(struct task_struct, thread.fstate.f[0])
   368		);
   369		DEFINE(TASK_THREAD_F3_F0,
   370			  offsetof(struct task_struct, thread.fstate.f[3])
   371			- offsetof(struct task_struct, thread.fstate.f[0])
   372		);
   373		DEFINE(TASK_THREAD_F4_F0,
   374			  offsetof(struct task_struct, thread.fstate.f[4])
   375			- offsetof(struct task_struct, thread.fstate.f[0])
   376		);
   377		DEFINE(TASK_THREAD_F5_F0,
   378			  offsetof(struct task_struct, thread.fstate.f[5])
   379			- offsetof(struct task_struct, thread.fstate.f[0])
   380		);
   381		DEFINE(TASK_THREAD_F6_F0,
   382			  offsetof(struct task_struct, thread.fstate.f[6])
   383			- offsetof(struct task_struct, thread.fstate.f[0])
   384		);
   385		DEFINE(TASK_THREAD_F7_F0,
   386			  offsetof(struct task_struct, thread.fstate.f[7])
   387			- offsetof(struct task_struct, thread.fstate.f[0])
   388		);
   389		DEFINE(TASK_THREAD_F8_F0,
   390			  offsetof(struct task_struct, thread.fstate.f[8])
   391			- offsetof(struct task_struct, thread.fstate.f[0])
   392		);
   393		DEFINE(TASK_THREAD_F9_F0,
   394			  offsetof(struct task_struct, thread.fstate.f[9])
   395			- offsetof(struct task_struct, thread.fstate.f[0])
   396		);
   397		DEFINE(TASK_THREAD_F10_F0,
   398			  offsetof(struct task_struct, thread.fstate.f[10])
   399			- offsetof(struct task_struct, thread.fstate.f[0])
   400		);
   401		DEFINE(TASK_THREAD_F11_F0,
   402			  offsetof(struct task_struct, thread.fstate.f[11])
   403			- offsetof(struct task_struct, thread.fstate.f[0])
   404		);
   405		DEFINE(TASK_THREAD_F12_F0,
   406			  offsetof(struct task_struct, thread.fstate.f[12])
   407			- offsetof(struct task_struct, thread.fstate.f[0])
   408		);
   409		DEFINE(TASK_THREAD_F13_F0,
   410			  offsetof(struct task_struct, thread.fstate.f[13])
   411			- offsetof(struct task_struct, thread.fstate.f[0])
   412		);
   413		DEFINE(TASK_THREAD_F14_F0,
   414			  offsetof(struct task_struct, thread.fstate.f[14])
   415			- offsetof(struct task_struct, thread.fstate.f[0])
   416		);
   417		DEFINE(TASK_THREAD_F15_F0,
   418			  offsetof(struct task_struct, thread.fstate.f[15])
   419			- offsetof(struct task_struct, thread.fstate.f[0])
   420		);
   421		DEFINE(TASK_THREAD_F16_F0,
   422			  offsetof(struct task_struct, thread.fstate.f[16])
   423			- offsetof(struct task_struct, thread.fstate.f[0])
   424		);
   425		DEFINE(TASK_THREAD_F17_F0,
   426			  offsetof(struct task_struct, thread.fstate.f[17])
   427			- offsetof(struct task_struct, thread.fstate.f[0])
   428		);
   429		DEFINE(TASK_THREAD_F18_F0,
   430			  offsetof(struct task_struct, thread.fstate.f[18])
   431			- offsetof(struct task_struct, thread.fstate.f[0])
   432		);
   433		DEFINE(TASK_THREAD_F19_F0,
   434			  offsetof(struct task_struct, thread.fstate.f[19])
   435			- offsetof(struct task_struct, thread.fstate.f[0])
   436		);
   437		DEFINE(TASK_THREAD_F20_F0,
   438			  offsetof(struct task_struct, thread.fstate.f[20])
   439			- offsetof(struct task_struct, thread.fstate.f[0])
   440		);
   441		DEFINE(TASK_THREAD_F21_F0,
   442			  offsetof(struct task_struct, thread.fstate.f[21])
   443			- offsetof(struct task_struct, thread.fstate.f[0])
   444		);
   445		DEFINE(TASK_THREAD_F22_F0,
   446			  offsetof(struct task_struct, thread.fstate.f[22])
   447			- offsetof(struct task_struct, thread.fstate.f[0])
   448		);
   449		DEFINE(TASK_THREAD_F23_F0,
   450			  offsetof(struct task_struct, thread.fstate.f[23])
   451			- offsetof(struct task_struct, thread.fstate.f[0])
   452		);
   453		DEFINE(TASK_THREAD_F24_F0,
   454			  offsetof(struct task_struct, thread.fstate.f[24])
   455			- offsetof(struct task_struct, thread.fstate.f[0])
   456		);
   457		DEFINE(TASK_THREAD_F25_F0,
   458			  offsetof(struct task_struct, thread.fstate.f[25])
   459			- offsetof(struct task_struct, thread.fstate.f[0])
   460		);
   461		DEFINE(TASK_THREAD_F26_F0,
   462			  offsetof(struct task_struct, thread.fstate.f[26])
   463			- offsetof(struct task_struct, thread.fstate.f[0])
   464		);
   465		DEFINE(TASK_THREAD_F27_F0,
   466			  offsetof(struct task_struct, thread.fstate.f[27])
   467			- offsetof(struct task_struct, thread.fstate.f[0])
   468		);
   469		DEFINE(TASK_THREAD_F28_F0,
   470			  offsetof(struct task_struct, thread.fstate.f[28])
   471			- offsetof(struct task_struct, thread.fstate.f[0])
   472		);
   473		DEFINE(TASK_THREAD_F29_F0,
   474			  offsetof(struct task_struct, thread.fstate.f[29])
   475			- offsetof(struct task_struct, thread.fstate.f[0])
   476		);
   477		DEFINE(TASK_THREAD_F30_F0,
   478			  offsetof(struct task_struct, thread.fstate.f[30])
   479			- offsetof(struct task_struct, thread.fstate.f[0])
   480		);
   481		DEFINE(TASK_THREAD_F31_F0,
   482			  offsetof(struct task_struct, thread.fstate.f[31])
   483			- offsetof(struct task_struct, thread.fstate.f[0])
   484		);
   485		DEFINE(TASK_THREAD_FCSR_F0,
   486			  offsetof(struct task_struct, thread.fstate.fcsr)
   487			- offsetof(struct task_struct, thread.fstate.f[0])
   488		);
   489	
   490		/*
   491		 * We allocate a pt_regs on the stack when entering the kernel.  This
   492		 * ensures the alignment is sane.
   493		 */
   494		DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
   495	
   496		OFFSET(KERNEL_MAP_VIRT_ADDR, kernel_mapping, virt_addr);
   497		OFFSET(SBI_HART_BOOT_TASK_PTR_OFFSET, sbi_hart_boot_data, task_ptr);
   498		OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_ptr);
   499	
   500		DEFINE(STACKFRAME_SIZE_ON_STACK, ALIGN(sizeof(struct stackframe), STACK_ALIGN));
   501		OFFSET(STACKFRAME_FP, stackframe, fp);
   502		OFFSET(STACKFRAME_RA, stackframe, ra);
   503	
   504	#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
   505		DEFINE(FREGS_SIZE_ON_STACK, ALIGN(sizeof(struct ftrace_regs), STACK_ALIGN));
   506		DEFINE(FREGS_EPC,	    offsetof(struct ftrace_regs, epc));
   507		DEFINE(FREGS_RA,	    offsetof(struct ftrace_regs, ra));
   508		DEFINE(FREGS_SP,	    offsetof(struct ftrace_regs, sp));
   509		DEFINE(FREGS_S0,	    offsetof(struct ftrace_regs, s0));
   510		DEFINE(FREGS_T1,	    offsetof(struct ftrace_regs, t1));
   511		DEFINE(FREGS_A0,	    offsetof(struct ftrace_regs, a0));
   512		DEFINE(FREGS_A1,	    offsetof(struct ftrace_regs, a1));
   513		DEFINE(FREGS_A2,	    offsetof(struct ftrace_regs, a2));
   514		DEFINE(FREGS_A3,	    offsetof(struct ftrace_regs, a3));
   515		DEFINE(FREGS_A4,	    offsetof(struct ftrace_regs, a4));
   516		DEFINE(FREGS_A5,	    offsetof(struct ftrace_regs, a5));
   517		DEFINE(FREGS_A6,	    offsetof(struct ftrace_regs, a6));
   518		DEFINE(FREGS_A7,	    offsetof(struct ftrace_regs, a7));
   519	#endif
 > 520		DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
 > 521		DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
 > 522		DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
 > 523		DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

