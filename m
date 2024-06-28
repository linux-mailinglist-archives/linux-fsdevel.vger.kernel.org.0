Return-Path: <linux-fsdevel+bounces-22719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676A991B4F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 04:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDED2835BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169241CFAF;
	Fri, 28 Jun 2024 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zm16U8C0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6211CA8A;
	Fri, 28 Jun 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540805; cv=none; b=ANJZUuJnI1ph1yZfwr0aFZHjH3iODC0JnZqm58nGCoftBvgHox+UlRO7UQKKbSNWihjxrELWiEBza6c1YPN3Xi540RyD2NvWCU9v3zTjx4zlWrWae9NVH0H9aRpTbs6oKyP77dc+oMi0CimQ3Yb1he2lSkV7bU2goeePwE+1QM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540805; c=relaxed/simple;
	bh=obqsFiB7moqSeHvfW5MvPa6iwrDiRwuIwVJo+bxnyTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHAeAoFLgnH+VCSKf/j6ZiL8DA2qYGddQ1OQGRgnxuuPFGMBOGbpyId/6L+W9NVU8tqQYXxxQ0jEMzFrs7LDiVOaSmnmyZMUqaN919Kci+oXZ9yLL3LQWnxmrI7uq3d4VFlknyUHEUX4gUxa9oA/6xG8fbL3+01yjNFM468yTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zm16U8C0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719540804; x=1751076804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=obqsFiB7moqSeHvfW5MvPa6iwrDiRwuIwVJo+bxnyTE=;
  b=Zm16U8C0MEB8XwvPsuvHlfcKt5Hhs7FECS2JvRJw+Ye+fkt9OUkS2Y+S
   hjPprj4ViNzNxeAHSme+p7kGvQw1c1ESmqSlbn1bBxdpmH8LPfUVnZPC+
   g/4J68kHyleV541xF/2UB3drbqe6/PgIIL0znFqh4ouuF2QE4rgUs5+6H
   1VdIpoegqBz/dyXCt+fBd8m6R6uRcy4SKcIMcpChBF8KWU8bH4mqgPBXT
   MfmgIPOnsalqLM1QRA43z9ndHSZPDcgDV1OLb37NWMsaC713WtqUgSACT
   ijYRMAXYWCgaLUFHMnIukHoKKDA3SO13Vt7QzAETSa2ex02Srqe6XbRli
   A==;
X-CSE-ConnectionGUID: PxNRixVMQqepwmJdDmIOmw==
X-CSE-MsgGUID: 1uuE+jmARKGZAT5vkVuacQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16528820"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16528820"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 19:13:21 -0700
X-CSE-ConnectionGUID: pmOPOqgFR+mj/xA3+uz33w==
X-CSE-MsgGUID: vu/s+JTeTQGDYAeESN28AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44993946"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Jun 2024 19:13:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN16r-000Gic-2H;
	Fri, 28 Jun 2024 02:13:09 +0000
Date: Fri, 28 Jun 2024 10:12:15 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH 13/13] mm: Remove devmap related functions and page table
 bits
Message-ID: <202406280920.VNwSTzZT-lkp@intel.com>
References: <47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple@nvidia.com>

Hi Alistair,

kernel test robot noticed the following build errors:

[auto build test ERROR on f2661062f16b2de5d7b6a5c42a9a5c96326b8454]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Popple/mm-gup-c-Remove-redundant-check-for-PCI-P2PDMA-page/20240627-191709
base:   f2661062f16b2de5d7b6a5c42a9a5c96326b8454
patch link:    https://lore.kernel.org/r/47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple%40nvidia.com
patch subject: [PATCH 13/13] mm: Remove devmap related functions and page table bits
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240628/202406280920.VNwSTzZT-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326ba38a991250a8587a399a260b0f7af2c9166a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280920.VNwSTzZT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406280920.VNwSTzZT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:7:
   In file included from include/linux/rhashtable-types.h:12:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:79:
   In file included from ./arch/powerpc/include/generated/asm/preempt.h:1:
   In file included from include/asm-generic/preempt.h:5:
   In file included from include/linux/thread_info.h:23:
   In file included from arch/powerpc/include/asm/current.h:13:
   In file included from arch/powerpc/include/asm/paca.h:18:
   In file included from arch/powerpc/include/asm/mmu.h:385:
   In file included from arch/powerpc/include/asm/book3s/64/mmu.h:32:
   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1371:1: error: extraneous closing brace ('}')
    1371 | }
         | ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:


vim +1371 arch/powerpc/include/asm/book3s/64/pgtable.h

953c66c2b22a30 Aneesh Kumar K.V  2016-12-12  1370  
ebd31197931d75 Oliver O'Halloran 2017-06-28 @1371  }
6a1ea36260f69f Aneesh Kumar K.V  2016-04-29  1372  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
ebd31197931d75 Oliver O'Halloran 2017-06-28  1373  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

