Return-Path: <linux-fsdevel+bounces-22696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E64091B27B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 01:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9E5283557
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD941A2C3D;
	Thu, 27 Jun 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxNCqxjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BABF50297;
	Thu, 27 Jun 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719529531; cv=none; b=Ep3xYoUSzKuDaRQoJTUVztyxbE3LMhkbNMsNPmzQo2JB8X1EAwegib/u2p1PZfWMCd/ffuojAXG7qdv5G9n4Z1CM9MrGdhMs1TFdJlntB2AFSYMo/h6b+ILrkvgf52plt5JgXDMUgEQHWjHjcEmW4f+Wx3b0H5c8Ro3UWNDNKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719529531; c=relaxed/simple;
	bh=+naB5/Q042PFFIXI5mElAZ8RiZyXqp0O9pcDtXADfas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfxDymuN7P8wRZY8ytb9LO4N55W+FQrQmM94GsqDmIe8vpVuZTbAJ1iTYOBUL+Pzg+oqV2EhDFa8x0bfKSDwZVrGtU8ix9rH7R4BcdxXWVncegYCNZbuONGA3uZ8NSI+lJ+W06Y5flxfvQ3j9FZuL49UdnGIY0XGkkR3RjEsPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxNCqxjM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719529528; x=1751065528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+naB5/Q042PFFIXI5mElAZ8RiZyXqp0O9pcDtXADfas=;
  b=YxNCqxjMvp1TVv7e3RYGxMe58CoF8hDaViA99vtgjL3Ayb2qrcuBRkBf
   jm9l2uCveUeuOtzn8GV5AYj7ppHnAMr6+CJNLF9otqYy4KM+AcIpW1jdz
   Uepw/2PsytLcUf5xlF7yHjIvxJ2Bk0pz3dDficHb+HfsmYuUq+InOoK32
   acUmlERiksdhNd8aZVzJBGyTS9mmD+dHtsAWI9ir9f0b8YKxosAGHUZbb
   a2W4aK1Tw0CsgxKI4qCV82rO4IOAoXEMbElRoXicHa9BVblb004NC7APT
   e0UBSZoOEjKvspZBKoUXGeJ2iaezWf31jHsct5W38yHhnH237HEOib99x
   Q==;
X-CSE-ConnectionGUID: ruzR2WtBQnaWSwcH2/CGiw==
X-CSE-MsgGUID: LABWpI5EQliDTtgJutK6lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20456938"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="20456938"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:05:27 -0700
X-CSE-ConnectionGUID: TA8xWjJQSumhP3m4MOnxKA==
X-CSE-MsgGUID: DnUjlU0JRaaOI2HUnzZ+pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44384637"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 27 Jun 2024 16:05:20 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMyB4-000Gbt-16;
	Thu, 27 Jun 2024 23:05:18 +0000
Date: Fri, 28 Jun 2024 07:04:47 +0800
From: kernel test robot <lkp@intel.com>
To: Alistair Popple <apopple@nvidia.com>, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca
Cc: oe-kbuild-all@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
	ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
	peterx@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com
Subject: Re: [PATCH 13/13] mm: Remove devmap related functions and page table
 bits
Message-ID: <202406280658.1pp5cW2f-lkp@intel.com>
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
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240628/202406280658.1pp5cW2f-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280658.1pp5cW2f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406280658.1pp5cW2f-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                    from arch/powerpc/include/asm/book3s/64/mmu.h:32,
                    from arch/powerpc/include/asm/mmu.h:385,
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
>> arch/powerpc/include/asm/book3s/64/pgtable.h:1371:1: error: expected identifier or '(' before '}' token
    1371 | }
         | ^
   make[3]: *** [scripts/Makefile.build:117: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1371 arch/powerpc/include/asm/book3s/64/pgtable.h

953c66c2b22a30 Aneesh Kumar K.V  2016-12-12  1370  
ebd31197931d75 Oliver O'Halloran 2017-06-28 @1371  }
6a1ea36260f69f Aneesh Kumar K.V  2016-04-29  1372  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
ebd31197931d75 Oliver O'Halloran 2017-06-28  1373  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

