Return-Path: <linux-fsdevel+bounces-50867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A1AD095B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE16C3A7C79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA54221FD3;
	Fri,  6 Jun 2025 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hB6mPt9c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70B21CA03;
	Fri,  6 Jun 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749244236; cv=none; b=qGgEFYPGj2zLEx9W+x6m9YeO/EEynlftECp3VFs7tLGHWKR7PMwKvIfs8ou1Q2YWePiG5tHOilo/k+m2O2qTsxKwCvYohCHTwj96HCxjWTWV5WCct6VVvf27PP4zqLtMueWbefOVozKuCEHNbr2tBlIDBelTi+RRwdOFztue8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749244236; c=relaxed/simple;
	bh=y2vtspK8CJxI3MpPLgfdlVOZRYupmnSMVie6NjOCH5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA03wEZ3lFHk4wO6lXCZmH3crS4IDptzMlPIzgY8IkW7D7OILutrnLlIckKyFv2RgkBzuCM2wks58e5VmvDLzNfAf3TR9S2myFn6N4c30uKuP67iQBWmQEzHbHR3Qb/RgqnCrpIOzM0nFa4HYlOP0lyQtFEMiKH9bZrFifXy+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hB6mPt9c; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749244233; x=1780780233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y2vtspK8CJxI3MpPLgfdlVOZRYupmnSMVie6NjOCH5A=;
  b=hB6mPt9crLaZaLsp9sACufhyIa7Q8xhrnGGq0cuQgGKcLCKvoXgVgUMj
   TRo31ANDqR0FQZua/yBnVas2l6Azevd3T7K7/OxH3zzkMn5xPCiBBwD3G
   cEdH0R0zn8WcJ5wS+h9QfCzRYy96n2GUFOm7xeCMcI9uAXH84WCzpYQwp
   +ui7Q0p8nAJoZxOJc34dXuiDjSGlwLnAFuAW70pKWsSYnm2av0K9jrjKA
   jeaVo+fUMuUB4k8ZP9CnopfOriJvV1y3FpAFdCcKDFkQ20gI6p65vN4Du
   CV5nN3HlQTYEbd6YXMiJmqSTKnAo88DIOy1pF6KBCSQZzthwdWNlOB5kp
   w==;
X-CSE-ConnectionGUID: eu7Xs/CBRD+wFXnbI+VtdA==
X-CSE-MsgGUID: Z33lBAsqSzucXqBjAFtDMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="54033922"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="54033922"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 14:10:33 -0700
X-CSE-ConnectionGUID: RutrD3OaR2ye8qmGShGcXQ==
X-CSE-MsgGUID: nBgAzcy7TrSK6DM00i/rwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="145854439"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 Jun 2025 14:10:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNeKX-0005HB-23;
	Fri, 06 Jun 2025 21:10:25 +0000
Date: Sat, 7 Jun 2025 05:09:53 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel@openvz.org
Subject: Re: [PATCH] locking: detect spin_lock_irq() call with disabled
 interrupts
Message-ID: <202506070405.MCweX7O0-lkp@intel.com>
References: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>

Hi Pavel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on sysctl/sysctl-next akpm-mm/mm-nonmm-unstable tip/master linus/master v6.15 next-20250606]
[cannot apply to mcgrof/sysctl-next tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/locking-detect-spin_lock_irq-call-with-disabled-interrupts/20250606-175911
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20250606095741.46775-1-ptikhomirov%40virtuozzo.com
patch subject: [PATCH] locking: detect spin_lock_irq() call with disabled interrupts
config: arm-randconfig-003-20250606 (https://download.01.org/0day-ci/archive/20250607/202506070405.MCweX7O0-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250607/202506070405.MCweX7O0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506070405.MCweX7O0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm/plat-orion/irq.c:13:
   In file included from include/linux/irq.h:14:
   include/linux/spinlock.h:375:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     375 | DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT,
         | ^
         | int
   include/linux/spinlock.h:375:26: error: a parameter list without types is only allowed in a function definition
     375 | DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT,
         |                          ^
   include/linux/spinlock.h:382:6: error: call to undeclared function 'static_branch_unlikely'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     382 |         if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
         |             ^
   include/linux/spinlock.h:382:30: error: use of undeclared identifier 'debug_spin_lock_irq_with_disabled_interrupts'
     382 |         if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
         |                                     ^
   include/linux/spinlock.h:384:4: error: call to undeclared function 'static_branch_disable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     384 |                         static_branch_disable(&debug_spin_lock_irq_with_disabled_interrupts);
         |                         ^
   include/linux/spinlock.h:384:27: error: use of undeclared identifier 'debug_spin_lock_irq_with_disabled_interrupts'
     384 |                         static_branch_disable(&debug_spin_lock_irq_with_disabled_interrupts);
         |                                                ^
   include/linux/spinlock.h:415:6: error: call to undeclared function 'static_branch_unlikely'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     415 |         if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
         |             ^
   include/linux/spinlock.h:415:30: error: use of undeclared identifier 'debug_spin_lock_irq_with_disabled_interrupts'
     415 |         if (static_branch_unlikely(&debug_spin_lock_irq_with_disabled_interrupts)) {
         |                                     ^
   include/linux/spinlock.h:417:4: error: call to undeclared function 'static_branch_disable'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     417 |                         static_branch_disable(&debug_spin_lock_irq_with_disabled_interrupts);
         |                         ^
   include/linux/spinlock.h:417:27: error: use of undeclared identifier 'debug_spin_lock_irq_with_disabled_interrupts'
     417 |                         static_branch_disable(&debug_spin_lock_irq_with_disabled_interrupts);
         |                                                ^
>> arch/arm/plat-orion/irq.c:37:29: warning: shift count >= width of type [-Wshift-count-overflow]
      37 |         irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_MASK_CACHE,
         |                                    ^~~~~~~~~~~
   include/linux/irq.h:1223:41: note: expanded from macro 'IRQ_MSK'
    1223 | #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
         |                                         ^  ~~~
   1 warning and 10 errors generated.


vim +37 arch/arm/plat-orion/irq.c

f28d7de6bd4d41 Sebastian Hesselbarth 2014-01-16  21  
01eb569823792a Lennert Buytenhek     2008-03-27  22  void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
01eb569823792a Lennert Buytenhek     2008-03-27  23  {
e59347a1d15c0b Thomas Gleixner       2011-04-14  24  	struct irq_chip_generic *gc;
e59347a1d15c0b Thomas Gleixner       2011-04-14  25  	struct irq_chip_type *ct;
01eb569823792a Lennert Buytenhek     2008-03-27  26  
01eb569823792a Lennert Buytenhek     2008-03-27  27  	/*
01eb569823792a Lennert Buytenhek     2008-03-27  28  	 * Mask all interrupts initially.
01eb569823792a Lennert Buytenhek     2008-03-27  29  	 */
01eb569823792a Lennert Buytenhek     2008-03-27  30  	writel(0, maskaddr);
01eb569823792a Lennert Buytenhek     2008-03-27  31  
e59347a1d15c0b Thomas Gleixner       2011-04-14  32  	gc = irq_alloc_generic_chip("orion_irq", 1, irq_start, maskaddr,
f38c02f3b33865 Thomas Gleixner       2011-03-24  33  				    handle_level_irq);
e59347a1d15c0b Thomas Gleixner       2011-04-14  34  	ct = gc->chip_types;
e59347a1d15c0b Thomas Gleixner       2011-04-14  35  	ct->chip.irq_mask = irq_gc_mask_clr_bit;
e59347a1d15c0b Thomas Gleixner       2011-04-14  36  	ct->chip.irq_unmask = irq_gc_mask_set_bit;
e59347a1d15c0b Thomas Gleixner       2011-04-14 @37  	irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_MASK_CACHE,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

