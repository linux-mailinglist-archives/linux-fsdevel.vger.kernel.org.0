Return-Path: <linux-fsdevel+bounces-63794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15298BCDEEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 18:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF69189D910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728032FBE14;
	Fri, 10 Oct 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfhmElBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52E2FBDF4;
	Fri, 10 Oct 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112842; cv=none; b=sljU9wZ3OGnVstpG/KOJpN+6+zh4gygJ3eVH7+B2WPDDHiLkrR4123tnjt+RBPAbxkgsjhwpVnvB3ve8TiJoBPdeIaB5+ZXFzbP/WJeSUQKDoLnNNSdgRsY9rAJIy2/5brHDjHGiVSr9O/ExRvBYpYehInnxSuubAZPO4Gjss+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112842; c=relaxed/simple;
	bh=r8lG5PY+ABtxRfWMyUbSWrVWqHmAuGupMmW6GEw4j5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAQHoTp0QQpm5B4wjY0pMFjLC98+xKtT9x9Cqs0Qu3VgxpAevYhsKyMxriFagfCrvXQs9GR/+HLfCfBPWycVZ92TMIRB2r7DDYEYiR2GnaKuihBIalbj2WPHg+9Ic77BHIRtvZFHNppAplyqSxYdpCw5o1Cz3n+dLgtueg9Navk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfhmElBt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760112842; x=1791648842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r8lG5PY+ABtxRfWMyUbSWrVWqHmAuGupMmW6GEw4j5Y=;
  b=lfhmElBt19IAvY4DGSmlZR+RS51UCWg2nMB7ejd7OLt6TLxScuHEK1DQ
   hI8xEIUv3VMj3X8ksNNBTn/AUuK9svzKxBzb/5WbKrM1jof3VMVw63JBT
   jygFuPE3kpgt4pAGD/Ff2TraGkTQZ9UNxhKG+7Qlf++ur0yY2iSRy4Ofb
   pfhFQe+mdwA/8aBB7pX6UOXs8pt11Cqgvn/zWZLl9Pc64P2gAFmLnLYtz
   zL4pLt7NIqKfpJqtzYp1EMQH4Zt992CY5sQ1PXGcVDa8J7MjB2lEu1kyA
   2pnQOgjo9MixzbKhYwC6yq4ewGKNyTM+FDLsGNBKNDKp/G1uIv5FnrefI
   g==;
X-CSE-ConnectionGUID: k01LGS7US3Gb+f3iehsPyA==
X-CSE-MsgGUID: 5RVA9CzLQKy/abSXZ8pPVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62037854"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62037854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 09:14:01 -0700
X-CSE-ConnectionGUID: RYXnv2CBR1qMJeNJz+4Dmg==
X-CSE-MsgGUID: GvanR2LkQ1m8cCrFDCZc5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="211961209"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Oct 2025 09:13:57 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7Fkh-0002wj-1D;
	Fri, 10 Oct 2025 16:13:55 +0000
Date: Sat, 11 Oct 2025 00:13:50 +0800
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>, acsjakub@amazon.de
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, chengming.zhou@linux.dev,
	david@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com,
	xu.xin16@zte.com.cn, rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] mm: use enum for vm_flags
Message-ID: <202510110039.N3gHQwXj-lkp@intel.com>
References: <20251007162136.1885546-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007162136.1885546-1-aliceryhl@google.com>

Hi Alice,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Alice-Ryhl/mm-use-enum-for-vm_flags/20251010-095004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251007162136.1885546-1-aliceryhl%40google.com
patch subject: [PATCH] mm: use enum for vm_flags
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20251011/202510110039.N3gHQwXj-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110039.N3gHQwXj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110039.N3gHQwXj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/pagewalk.h:5,
                    from fs/proc/task_mmu.c:2:
   fs/proc/task_mmu.c: In function 'show_smap_vma_flags':
>> include/linux/mm.h:353:24: warning: "VM_HIGH_ARCH_3" is not defined, evaluates to 0 [-Wundef]
     353 | # define VM_PKEY_BIT3  VM_HIGH_ARCH_3
         |                        ^~~~~~~~~~~~~~
   fs/proc/task_mmu.c:1184:5: note: in expansion of macro 'VM_PKEY_BIT3'
    1184 | #if VM_PKEY_BIT3
         |     ^~~~~~~~~~~~


vim +/VM_HIGH_ARCH_3 +353 include/linux/mm.h

63c17fb8e5a46a Dave Hansen 2016-02-12  346  
5212213aa5a235 Ram Pai     2018-03-27  347  #ifdef CONFIG_ARCH_HAS_PKEYS
8f62c883222c9e Dave Hansen 2016-02-12  348  # define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
9f82f15ddfdd60 Joey Gouly  2024-08-22  349  # define VM_PKEY_BIT0  VM_HIGH_ARCH_0
9f82f15ddfdd60 Joey Gouly  2024-08-22  350  # define VM_PKEY_BIT1  VM_HIGH_ARCH_1
8f62c883222c9e Dave Hansen 2016-02-12  351  # define VM_PKEY_BIT2  VM_HIGH_ARCH_2
9f82f15ddfdd60 Joey Gouly  2024-08-22  352  #if CONFIG_ARCH_PKEY_BITS > 3
8f62c883222c9e Dave Hansen 2016-02-12 @353  # define VM_PKEY_BIT3  VM_HIGH_ARCH_3
9f82f15ddfdd60 Joey Gouly  2024-08-22  354  #else
9f82f15ddfdd60 Joey Gouly  2024-08-22  355  # define VM_PKEY_BIT3  0
9f82f15ddfdd60 Joey Gouly  2024-08-22  356  #endif
9f82f15ddfdd60 Joey Gouly  2024-08-22  357  #if CONFIG_ARCH_PKEY_BITS > 4
2c9e0a6fa2bb75 Ram Pai     2018-03-27  358  # define VM_PKEY_BIT4  VM_HIGH_ARCH_4
2c9e0a6fa2bb75 Ram Pai     2018-03-27  359  #else
2c9e0a6fa2bb75 Ram Pai     2018-03-27  360  # define VM_PKEY_BIT4  0
8f62c883222c9e Dave Hansen 2016-02-12  361  #endif
5212213aa5a235 Ram Pai     2018-03-27  362  #endif /* CONFIG_ARCH_HAS_PKEYS */
5212213aa5a235 Ram Pai     2018-03-27  363  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

