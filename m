Return-Path: <linux-fsdevel+bounces-19624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684828C7D4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55A1B2462D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77376157488;
	Thu, 16 May 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9QZRkvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58D156F29;
	Thu, 16 May 2024 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715887978; cv=none; b=TLfYeV0z/jVPcx2zJloXE9JQXSMex209Pras4jOXk1UjRtE9Pz5f4uah82r9jEjqYjNJmQA4CEZ7wAcP2VLtecBKVA4saQVBD5EbASwc7vNV/VM4PRR1oRpTqYrk5jXDZcTP2Ys9qDfG/whV8PQn6VB0w1q9qgwi9VgYcPq0OcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715887978; c=relaxed/simple;
	bh=F+2v2+xUF084Tonn2JxepjXqiHplTniHyiir7MNmqac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6myKIOTFxRFtT86UHCJRdKsjU+OB1xhEGaKCCkcNWYa6apoqKgson1FVZ5XEktDdU4uHCs9t59JwAuoRVPeDQ/szCN1d63atz3yZBo8fg0FQtGJ6Oot6pDcOZLC+1PdjkYKZG8S/rWXmmdgXWuEi/UeUDtrYtv/6DqEuXXNKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9QZRkvs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715887977; x=1747423977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+2v2+xUF084Tonn2JxepjXqiHplTniHyiir7MNmqac=;
  b=A9QZRkvsq9b6lOKRWN/OOBkt4k3qE3Ezldx1nnkHfHFTmGOaUVwAG5BM
   /T1AQZAlBOqZkv0Y5IKw0ZIZwwygnI1z1NclL4UKpm00r0xwiqmghhEaP
   ANlT03790ODc4uKlAojBaGyi42fDa+jAjbHBo4+HO7FNDIE3yePTV8L6h
   Kt8WTdzd0x5V8XUC/l7hhJWpaWWq3rl9/VAAojxpDO1SiaFH5SrloSnge
   9X1dlFlLh4jM9jW7Er6UR+MRKiChZqXbFgA6rf55KDTsUyt6xJNQyGllE
   HvtNLqhNx8/4OzDOPyKU2+fpedfNAI/J0Xy1w1AA3RlTebeTvGOqyxDmo
   A==;
X-CSE-ConnectionGUID: eC2FWTFySQ6yf6CoZM7ljQ==
X-CSE-MsgGUID: KOWs2NU0RUa6fRgd3J4QeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29534717"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="29534717"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 12:32:56 -0700
X-CSE-ConnectionGUID: 4nkztOPnTliFpzBhonI88g==
X-CSE-MsgGUID: Ep0hYkanRwyYg79M2JjH/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31468887"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 May 2024 12:32:52 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7gqQ-000Ehd-0w;
	Thu, 16 May 2024 19:32:50 +0000
Date: Fri, 17 May 2024 03:31:51 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
	yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/3] iomap: pass blocksize to iomap_truncate_page()
Message-ID: <202405170356.gLrF2NDl-lkp@intel.com>
References: <20240516073001.1066373-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516073001.1066373-2-yi.zhang@huaweicloud.com>

Hi Zhang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.9 next-20240516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/iomap-pass-blocksize-to-iomap_truncate_page/20240516-154238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240516073001.1066373-2-yi.zhang%40huaweicloud.com
patch subject: [PATCH v2 1/3] iomap: pass blocksize to iomap_truncate_page()
config: arm-davinci_all_defconfig (https://download.01.org/0day-ci/archive/20240517/202405170356.gLrF2NDl-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d3455f4ddd16811401fa153298fadd2f59f6914e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405170356.gLrF2NDl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170356.gLrF2NDl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/iomap/buffered-io.c:9:
   In file included from include/linux/iomap.h:7:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/iomap/buffered-io.c:1453:7: warning: comparison of distinct pointer types ('typeof ((pos)) *' (aka 'long long *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
    1453 |                            do_div(pos, blocksize);
         |                            ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
   2 warnings generated.


vim +1453 fs/iomap/buffered-io.c

  1446	
  1447	int
  1448	iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
  1449			bool *did_zero, const struct iomap_ops *ops)
  1450	{
  1451		loff_t start = pos;
  1452		unsigned int off = is_power_of_2(blocksize) ? (pos & (blocksize - 1)) :
> 1453				   do_div(pos, blocksize);
  1454	
  1455		/* Block boundary? Nothing to do */
  1456		if (!off)
  1457			return 0;
  1458		return iomap_zero_range(inode, start, blocksize - off, did_zero, ops);
  1459	}
  1460	EXPORT_SYMBOL_GPL(iomap_truncate_page);
  1461	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

