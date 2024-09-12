Return-Path: <linux-fsdevel+bounces-29172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0069769BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F211F223A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9531AB6CB;
	Thu, 12 Sep 2024 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O26BmLT1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE01A7248;
	Thu, 12 Sep 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145767; cv=none; b=MaQATg+93F7+t2UrEM5UDyop9qhgjfZs7VO++nN/D6aL6ubN5ovDQvhiprw3SiFvU1XswAngmSlXIQH+X/KAzoHNFBE0oBAa7DW0KFQN9+7tF7Xm+xY9Bw8UhgmpMdIh20WpY0KgSQEOgPSoOmRu85kb9h75KV+SLm4ixUS6spA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145767; c=relaxed/simple;
	bh=dGAeN13W305HmHWI3EX/D8HuXsJ0/ArD+TPGFFRkJWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0qC9o5J55MjQzG8L/FueGY5XB5Ln8jtGV0+DKYAHlx1pouYes3IAPcZ4qzxol4vN/8HLPGiXEvyHBVH9EQAbOqLMVzrROldj2zdBp5V0tTGhazyWVc3jHGK9/ijnYyXh3zPuKRPxZA8EUcMJcgXl2oGYbAKoHtrRYxL1+LR364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O26BmLT1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726145766; x=1757681766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGAeN13W305HmHWI3EX/D8HuXsJ0/ArD+TPGFFRkJWc=;
  b=O26BmLT11xQkPEg2j4iiQfRO7P7eCpOxFubEKLYhufoK32MpIotRlFT/
   gc1nBMeXC33LtKqV1Ga5U6daDXD631sV99KaeNRBJ/7Qyaelnv4yV/Hug
   DZyhkdjgF4NgIh7DEPnF2VHfKdEb37UPMqMbDy+0ciU/mnk4zqTa3dI0W
   LNInF5GVtgD7gm1jjFniX23yyaefPCCFPrkXPMjKRWvB12LNvEEFIS5F5
   6GarpdUBdOcpT1a0ORXCv7IvxAGou7R7ilDKPsftKQVDZWTXEOvDQIqsY
   QPsHbpvuIdM84dIhLFxQVkvbJed5kZ9RGdtsmVQttWm3tV+TkZ+/BNf59
   Q==;
X-CSE-ConnectionGUID: o5fa1vgBSgqPZtfhvXAw8Q==
X-CSE-MsgGUID: wUp8rTUdSb2i0alozszfIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="47506309"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="47506309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 05:56:06 -0700
X-CSE-ConnectionGUID: WI5ZxRdPS1OSvF46W9f0Ng==
X-CSE-MsgGUID: 42Lg1Wh1Q/6X9fgClrychQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="98523065"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Sep 2024 05:56:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sojMb-0005Ay-0r;
	Thu, 12 Sep 2024 12:55:57 +0000
Date: Thu, 12 Sep 2024 20:55:23 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, Alistair Popple <apopple@nvidia.com>,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/12] mm: Remove devmap related functions and page table
 bits
Message-ID: <202409122016.5i2hNKRU-lkp@intel.com>
References: <39b1a78aa16ebe5db1c4b723e44fbdd217d302ac.1725941415.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b1a78aa16ebe5db1c4b723e44fbdd217d302ac.1725941415.git-series.apopple@nvidia.com>

Hi Alistair,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6f1833b8208c3b9e59eff10792667b6639365146]

url:    https://github.com/intel-lab-lkp/linux/commits/Alistair-Popple/mm-gup-c-Remove-redundant-check-for-PCI-P2PDMA-page/20240910-121806
base:   6f1833b8208c3b9e59eff10792667b6639365146
patch link:    https://lore.kernel.org/r/39b1a78aa16ebe5db1c4b723e44fbdd217d302ac.1725941415.git-series.apopple%40nvidia.com
patch subject: [PATCH 12/12] mm: Remove devmap related functions and page table bits
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240912/202409122016.5i2hNKRU-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409122016.5i2hNKRU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409122016.5i2hNKRU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:32,
                    from arch/powerpc/include/asm/mmu.h:377,
                    from arch/powerpc/include/asm/paca.h:18,
                    from arch/powerpc/include/asm/current.h:13,
                    from include/linux/thread_info.h:23,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/alloc_tag.h:11,
                    from include/linux/rhashtable-types.h:12,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from arch/powerpc/kernel/asm-offsets.c:12:
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1390:1: error: expected identifier or '(' before '}' token
    1390 | }
         | ^
   make[3]: *** [scripts/Makefile.build:117: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1193: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1390 arch/powerpc/include/asm/book3s/64/pgtable.h

953c66c2b22a30 Aneesh Kumar K.V  2016-12-12  1389  
ebd31197931d75 Oliver O'Halloran 2017-06-28 @1390  }
6a1ea36260f69f Aneesh Kumar K.V  2016-04-29  1391  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
ebd31197931d75 Oliver O'Halloran 2017-06-28  1392  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

