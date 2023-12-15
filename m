Return-Path: <linux-fsdevel+bounces-6162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE898813F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 02:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC531C21F33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 01:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B94110F;
	Fri, 15 Dec 2023 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuJluONs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8536ED2;
	Fri, 15 Dec 2023 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702603859; x=1734139859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bo4CQbjDhFgPpZxFoaEvDAhRSz9PVVm5QEWsB3l+Hvk=;
  b=XuJluONsDon84bZ/4wBMxn5QUNTntsBWx4gm1jbxm+wZHrbyY0LB6YkT
   W73nuNOAj5hzJtHhBuQlriKvImG7sUXGW1UaV5zYtVHSwtc8d78D58g4s
   MaErkP1PpDGJuhh+pFBRB1bj9DqIQHZInyVclEvLuctD2DSaOkWYYI+kk
   V+dN5G+i00N64SGZCJB4IUzEJSDipmoYXIZtp2CF8Yte/NJ5jlMLRHikf
   LGBKy+z0rZ8jG7GZzMBYAF5r4mePqD8Rcc8/2VautMPmCdw+CNKGt1yB3
   u7ZhNyI4pbuIuiHhLTRFfwrfHcotwlrJwyXOhjSO3P3bGPsCJJdkajq/q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="399050762"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="399050762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:30:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897960014"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="897960014"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2023 17:30:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDx2N-000Mwz-31;
	Fri, 15 Dec 2023 01:30:47 +0000
Date: Fri, 15 Dec 2023 09:30:24 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
	tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com,
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com,
	honggyu.kim@sk.com, vtavarespetr@micron.com, peterz@infradead.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com
Subject: Re: [PATCH v3 09/11] mm/mempolicy: add get_mempolicy2 syscall
Message-ID: <202312150958.WYyFWIdr-lkp@intel.com>
References: <20231213224118.1949-10-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213224118.1949-10-gregory.price@memverge.com>

Hi Gregory,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on deller-parisc/for-next powerpc/next powerpc/fixes s390/features jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master linus/master v6.7-rc5]
[cannot apply to geert-m68k/for-next geert-m68k/for-linus tip/x86/asm next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231214-064236
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231213224118.1949-10-gregory.price%40memverge.com
patch subject: [PATCH v3 09/11] mm/mempolicy: add get_mempolicy2 syscall
config: x86_64-randconfig-002-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150958.WYyFWIdr-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150958.WYyFWIdr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150958.WYyFWIdr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __x64_sys_get_mempolicy2
   >>> referenced by syscall_64.c
   >>>               arch/x86/entry/syscall_64.o:(sys_call_table) in archive vmlinux.a
   >>> did you mean: __x64_sys_get_mempolicy
   >>> defined in: vmlinux.a(kernel/sys_ni.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

