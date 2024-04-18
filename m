Return-Path: <linux-fsdevel+bounces-17260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567D58AA239
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FBE1C20EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A53E17AD74;
	Thu, 18 Apr 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvQfS8Vx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45AD17AD64;
	Thu, 18 Apr 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465852; cv=none; b=mVuSu/K83UKk5HvaPrBRRRR8Yf1XHHB+pGLgLhsQkDXxIw/sG8Cu7A7tNqiYp9b2aYe4xHjbct88LIChxZb1PMxbZmnVfJm98LBH2Fbct8+KI3cv3ZocsVidEiHFWqmUYCwwk8BExOXzLYsDbF3zPD5NnEa3wCVIOezfyP3pGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465852; c=relaxed/simple;
	bh=kUsQR+VGi9VA365WkzSziP4+P51fPUAYTZqTSXcvJMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2bZPMFLM8E742rUgdmntDno2m8FreRDG0oITVjakmKBEc3bA98HbBMkjJbiHtOJEZ5gV3LKF2LSnoFRgMLnT/cb5SooLotkKiXMkPFgAsa/KZhh239dGrEgYOQTuVgRN8wdtv/3RsknNZFYCzYHJOJkuN8VBaKxA+5MFLYR3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvQfS8Vx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713465851; x=1745001851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kUsQR+VGi9VA365WkzSziP4+P51fPUAYTZqTSXcvJMA=;
  b=SvQfS8VxJzWbfpiamrl/Zd9FCWvEYmeFMYWbjPJcj1KezcwZG6QYLLxZ
   dzQSMPOmGjjhGLz+J6Flk5gjmfU+OY/hygy/KblQ080Z//X2OKSURF2u8
   cP0Sccw0bmMJITyR5dXpzpwuhpCHBbk0Dl/qUEJZRCyOaasejE9tNtzLG
   Q1NW2f9rj6HVfvNXbv/QfoeZPqK8/P890qoM8bxqHoWQc2xhvuuETzDa4
   i7NB/+SiHER4enEnZQTdIWHeIAvc8ety16ahscO6I4kNQ+t7iiC6k63zr
   LT2kFh0RBkaHCqkRFdEC3iIXTYoY2ul5XAN9js4tntAWzctFqEVc0+zS8
   w==;
X-CSE-ConnectionGUID: yXEusdL/RvePgUPmFtnUYw==
X-CSE-MsgGUID: 4F3muI1ATWyQccqREN2aug==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20460464"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="20460464"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 11:43:54 -0700
X-CSE-ConnectionGUID: 2MTt0cwISmqHbGHHuvZ73A==
X-CSE-MsgGUID: en64Xcu0Qyq0Xdm5EpcPjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23595768"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 18 Apr 2024 11:43:50 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxWjb-00096U-1P;
	Thu, 18 Apr 2024 18:43:47 +0000
Date: Fri, 19 Apr 2024 02:43:16 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 6/8] mm/swap: get the swap file offset directly
Message-ID: <202404190204.cy1pBxFg-lkp@intel.com>
References: <20240417160842.76665-7-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417160842.76665-7-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on ceph-client/testing]
[also build test ERROR on ceph-client/for-linus trondmy-nfs/linux-next konis-nilfs2/upstream jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev cifs/for-next linus/master v6.9-rc4 next-20240418]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/NFS-remove-nfs_page_lengthg-and-usage-of-page_index/20240418-001343
base:   https://github.com/ceph/ceph-client.git testing
patch link:    https://lore.kernel.org/r/20240417160842.76665-7-ryncsn%40gmail.com
patch subject: [PATCH 6/8] mm/swap: get the swap file offset directly
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240419/202404190204.cy1pBxFg-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190204.cy1pBxFg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190204.cy1pBxFg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/shmem.c:43:
   mm/swap.h: In function 'swap_file_pos':
>> mm/swap.h:12:25: error: implicit declaration of function 'swp_offset'; did you mean 'pmd_offset'? [-Werror=implicit-function-declaration]
      12 |         return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
         |                         ^~~~~~~~~~
         |                         pmd_offset
   In file included from mm/shmem.c:68:
   include/linux/swapops.h: At top level:
>> include/linux/swapops.h:107:23: error: conflicting types for 'swp_offset'; have 'long unsigned int(swp_entry_t)'
     107 | static inline pgoff_t swp_offset(swp_entry_t entry)
         |                       ^~~~~~~~~~
   mm/swap.h:12:25: note: previous implicit declaration of 'swp_offset' with type 'int()'
      12 |         return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
         |                         ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from mm/show_mem.c:19:
   mm/swap.h: In function 'swap_file_pos':
>> mm/swap.h:12:25: error: implicit declaration of function 'swp_offset'; did you mean 'pmd_offset'? [-Werror=implicit-function-declaration]
      12 |         return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
         |                         ^~~~~~~~~~
         |                         pmd_offset
   cc1: some warnings being treated as errors


vim +12 mm/swap.h

     9	
    10	static inline loff_t swap_file_pos(swp_entry_t entry)
    11	{
  > 12		return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
    13	}
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

