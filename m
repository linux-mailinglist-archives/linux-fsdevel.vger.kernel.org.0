Return-Path: <linux-fsdevel+bounces-29369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E21978C7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 03:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A90B25F71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 01:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7550DD268;
	Sat, 14 Sep 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC1SMSZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888FC8831;
	Sat, 14 Sep 2024 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726278885; cv=none; b=kv5nVEldfpTF2nLDCDi0gPz0Put8dJrSh850GOsE/5GeGcw6P/l4dxV5RomRT56qHReThiH/FujWtKXDbZckPL56MXjClfE5SgHAJ+2QlLNFRNEnxY2eGZUOEZ8TQvqZxkIhq60AHJnaTEeosQ1CqDDnPV5idqdC1sVTmmxg93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726278885; c=relaxed/simple;
	bh=TLXeBUebCUeA7FDBNQ7Y62aN1d7vguuNY9Dg5smqFKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf6j/9hDU9Wils1i+gnr3e+06dTBfEhU5klVzfjbAGL1c6WWHemPCuMgc1YVyRUIpCfPXcaMBsE/TaiOTdfaP5mt6s1GDcCglkkGcCB0gJoFbP6eHIAUeekoAZ+oP7t1vD9gzuOtbLGb8+gB9V9aO/Cr1Du6F73nN0MZuuBBaS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC1SMSZg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726278883; x=1757814883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TLXeBUebCUeA7FDBNQ7Y62aN1d7vguuNY9Dg5smqFKw=;
  b=iC1SMSZgdTYS74S2jZF/JMBSqTmam9t/3GowyHLIlo2320k77tgoS55c
   RcQPnOjND0CCjccScVkbxtvDUPV+w+dZk2CGfNAloPbjxoMLXuQuNOC2I
   SriMuKI7dLkfULM2eD4rHoCrand4uXmTLISYNpxSmLLbzLTG8k7trkob9
   nHG6o3PRqbEB9ZugGv84hsOeTYzKzQxHYT8HsSyGk86UlZwdBNQiIhTAs
   rLulAQMARBSrKPqejtxvc019bdBBqEGSxztrqEICcw+XG7XbVSTmYUM07
   C/XuaWomrpNqCgvvvTfuI/ZHe15R72YIIc7mVDS8SbGFdqQq+vGr0wm6L
   A==;
X-CSE-ConnectionGUID: S58WrIBpSYq6GuzfB8cOnw==
X-CSE-MsgGUID: /GTPAQsvScqjnTtbTf5hhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25392356"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25392356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 18:54:42 -0700
X-CSE-ConnectionGUID: 8/RVo9fwTHKmd/RxSkbmmA==
X-CSE-MsgGUID: 6noWOEqXTIaiVBZhuyPnbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="72381126"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Sep 2024 18:54:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spHzc-0007Eu-2R;
	Sat, 14 Sep 2024 01:54:32 +0000
Date: Sat, 14 Sep 2024 09:54:31 +0800
From: kernel test robot <lkp@intel.com>
To: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
	palmer@sifive.com, conor@kernel.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, corbet@lwn.net,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, robh@kernel.org,
	krzk+dt@kernel.org, oleg@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
	arnd@arndb.de, ebiederm@xmission.com, kees@kernel.org,
	Liam.Howlett@oracle.com, vbabka@suse.cz
Subject: Re: [PATCH v4 16/30] riscv/shstk: If needed allocate a new shadow
 stack on clone
Message-ID: <202409140913.73qFCOmB-lkp@intel.com>
References: <20240912231650.3740732-17-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912231650.3740732-17-debug@rivosinc.com>

Hi Deepak,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on shuah-kselftest/fixes tip/x86/core robh/for-next tip/smp/core kees/for-next/execve linus/master v6.11-rc7]
[cannot apply to akpm-mm/mm-everything next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Deepak-Gupta/mm-Introduce-ARCH_HAS_USER_SHADOW_STACK/20240913-072124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20240912231650.3740732-17-debug%40rivosinc.com
patch subject: [PATCH v4 16/30] riscv/shstk: If needed allocate a new shadow stack on clone
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240914/202409140913.73qFCOmB-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140913.73qFCOmB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140913.73qFCOmB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:37:
   In file included from arch/riscv/include/asm/processor.h:17:
>> arch/riscv/include/asm/usercfi.h:44:15: warning: no previous prototype for function 'get_shstk_base' [-Wmissing-prototypes]
      44 | unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
         |               ^
   arch/riscv/include/asm/usercfi.h:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      44 | unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
         | ^
         | static 
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:2233:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   2 warnings generated.
--
   In file included from arch/riscv/kernel/soc.c:7:
   In file included from include/linux/pgtable.h:6:
   In file included from arch/riscv/include/asm/pgtable.h:9:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:37:
   In file included from arch/riscv/include/asm/processor.h:17:
>> arch/riscv/include/asm/usercfi.h:44:15: warning: no previous prototype for function 'get_shstk_base' [-Wmissing-prototypes]
      44 | unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
         |               ^
   arch/riscv/include/asm/usercfi.h:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      44 | unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
         | ^
         | static 
   1 warning generated.
--
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:56:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/riscv/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/riscv/include/asm/thread_info.h:37:
   In file included from arch/riscv/include/asm/processor.h:17:
>> arch/riscv/include/asm/usercfi.h:44:15: warning: no previous prototype for function 'get_shstk_base' [-Wmissing-prototypes]
      44 | unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
         |               ^
   arch/riscv/include/asm/usercfi.h:44:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      44 | unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
         | ^
         | static 
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:2233:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   2 warnings generated.


vim +/get_shstk_base +44 arch/riscv/include/asm/usercfi.h

    43	
  > 44	unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
    45	{
    46		return 0;
    47	}
    48	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

