Return-Path: <linux-fsdevel+bounces-36421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F8F9E3952
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB126285D16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271C1B414E;
	Wed,  4 Dec 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzXSkvbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D021ABEDC;
	Wed,  4 Dec 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313356; cv=none; b=UNxoEMFR83d38toCVhrKEqDvzunxCj3xq5hgSV0NdHaC7ppAYAAESZ9esVX7l7Bokgf16yovpnqn0Fg+8SOqIFQ92O0yVwtSVCwUFwtlnoYEDuGGhJ/XMe1HGPhrP4Gju3zS6BR8nwKcq7GemBXg+Zw741DK9TAeu/9IFf+vWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313356; c=relaxed/simple;
	bh=b9+hThTl0irJhkh03Sww3rGHMjhjdRXKbCidlcCmBws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd4Y1og/28U9TsU8X0n5Qj2JgbB7iKlMGuM8/lULlNVAdcn2ONn/5veatIV22tQ5IW0JMSnE34FEj5Fc5KELC5zA0+v5BoRB7N7Z0qpW2ti4wWMKWTkEhqqzi+QSEFvJS/KU6OqZYJmge9UoRCjHifOS6UAVXvUXuPD+2/eZ+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzXSkvbM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733313355; x=1764849355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9+hThTl0irJhkh03Sww3rGHMjhjdRXKbCidlcCmBws=;
  b=lzXSkvbM1vuvwTqC9Y3vRvBY0vv/T+N3ijlzGPK39bdQ4P5vHw2XcQfx
   MjkCo7T4ozeeUIOGayRYgHXB8Ba7CaoR+UFgTHUr5knUGtt8wvoWD1cKP
   PDbG8cAb6KzcRWhpz9LoCOGhTdftPUVxT0PMd6L/oQDWaiGpE+szbcJ1a
   4a8Gb2H4GX8ryI34pNeNWB9N9jzsiQ9cEOcGw5eJpb0fEte5r5vDuz8HF
   g3kYPm/X5dFczeT7RpcWOmTVm4fHPJwi98OxG6XR64CrFjW8D8AjAKKiD
   HhSNDRgcV1bz1SirI8LPDX0Ei6O/QQPPzNWxbG4ig6IPhMWRFxCvwz7pd
   w==;
X-CSE-ConnectionGUID: eEamoEYMTXWwr9Zb6l2wdg==
X-CSE-MsgGUID: A246P8OqSiuM4kYJ1cuQAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33824306"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="33824306"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:55:53 -0800
X-CSE-ConnectionGUID: GAfJM3ckRdSWF3hqDqblhg==
X-CSE-MsgGUID: fQuMZ+ddSAuzRmSw93Ualg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98733643"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Dec 2024 03:55:50 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tInyt-0002zB-0m;
	Wed, 04 Dec 2024 11:55:47 +0000
Date: Wed, 4 Dec 2024 19:55:16 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vma: move brk() internals to mm/vma.c
Message-ID: <202412041907.3DXYQrz6-lkp@intel.com>
References: <3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-vma-move-brk-internals-to-mm-vma-c/20241204-115150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/3d24b9e67bb0261539ca921d1188a10a1b4d4357.1733248985.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 1/5] mm/vma: move brk() internals to mm/vma.c
config: mips-allnoconfig (https://download.01.org/0day-ci/archive/20241204/202412041907.3DXYQrz6-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041907.3DXYQrz6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041907.3DXYQrz6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/cacheflush.h:13,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/backing-dev.h:16,
                    from mm/vma_internal.h:12,
                    from mm/vma.c:7:
   mm/vma.c: In function 'do_brk_flags':
>> include/linux/mm.h:450:44: error: 'READ_IMPLIES_EXEC' undeclared (first use in this function)
     450 | #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
         |                                            ^~~~~~~~~~~~~~~~~
   include/linux/mm.h:453:55: note: in expansion of macro 'TASK_EXEC'
     453 | #define VM_DATA_FLAGS_TSK_EXEC  (VM_READ | VM_WRITE | TASK_EXEC | \
         |                                                       ^~~~~~~~~
   arch/mips/include/asm/page.h:215:33: note: in expansion of macro 'VM_DATA_FLAGS_TSK_EXEC'
     215 | #define VM_DATA_DEFAULT_FLAGS   VM_DATA_FLAGS_TSK_EXEC
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   mm/vma.c:2503:18: note: in expansion of macro 'VM_DATA_DEFAULT_FLAGS'
    2503 |         flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
         |                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:450:44: note: each undeclared identifier is reported only once for each function it appears in
     450 | #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
         |                                            ^~~~~~~~~~~~~~~~~
   include/linux/mm.h:453:55: note: in expansion of macro 'TASK_EXEC'
     453 | #define VM_DATA_FLAGS_TSK_EXEC  (VM_READ | VM_WRITE | TASK_EXEC | \
         |                                                       ^~~~~~~~~
   arch/mips/include/asm/page.h:215:33: note: in expansion of macro 'VM_DATA_FLAGS_TSK_EXEC'
     215 | #define VM_DATA_DEFAULT_FLAGS   VM_DATA_FLAGS_TSK_EXEC
         |                                 ^~~~~~~~~~~~~~~~~~~~~~
   mm/vma.c:2503:18: note: in expansion of macro 'VM_DATA_DEFAULT_FLAGS'
    2503 |         flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
         |                  ^~~~~~~~~~~~~~~~~~~~~


vim +/READ_IMPLIES_EXEC +450 include/linux/mm.h

a8bef8ff6ea15fa Mel Gorman        2010-05-24  449  
c62da0c35d58518 Anshuman Khandual 2020-04-10 @450  #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
c62da0c35d58518 Anshuman Khandual 2020-04-10  451  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

