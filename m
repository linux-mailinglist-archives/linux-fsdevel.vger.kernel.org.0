Return-Path: <linux-fsdevel+bounces-31418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16EF9960CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FDB24D18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 07:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4117109B;
	Wed,  9 Oct 2024 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnUWskTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2216631C;
	Wed,  9 Oct 2024 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458746; cv=none; b=PRc84Ku2yR4ocPLITiamhDXL5algg6yq7MrWU+cc4qphw/6iaFz1HJJWU7Yfapu/Claayyj8IVSPKLKEnlQ6yNPa6qvb2RO0Mfjr+2i9Rw88X1cVXYeqrdaIPEeLz5adjEnZc4XYt2fn81As+LxiBjIgsvdQ/iecywkOyBscx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458746; c=relaxed/simple;
	bh=THs6DsM2Xg4UTWWWqLhNNVBQwRFrpO8EbsVy7gJTpJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXqWrVcVd5TP/OoArdxg2kLfCj/li1tBes2RBmYG9crz4g4CIdBjn53/FgEFE3rmFLCBg6S9iPilWn83j5WXRlsgQzcBonmptoNTQHjNeLGNxApamckMUxOo8INthpfO7L9XE9jf6IADjfi8wHTR3dEUhuyqMis4dctLWGPgMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnUWskTQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728458745; x=1759994745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=THs6DsM2Xg4UTWWWqLhNNVBQwRFrpO8EbsVy7gJTpJw=;
  b=WnUWskTQ1RnAAseWjMO4n3YEZ+F5P+dxA1BZWs1cmIG8mHvkxKODKsAT
   mAj/GrnPdStbn3peL7RCGAIFHjDc1GaTdwCe0pv3zV+awhZzRcOje+g0H
   x9IyrbfVTHmN8zHeOP58C93+q4TumZcHv+9zLaCov7kK/Bc1fVb5tqMu/
   7tOA36OEkm1A30MIvCATvgc0TUi4IPiKTXKfoFt/Mn0FjrPQNeKP3cDH9
   p78islm+Ea1P/Trgof2DgS/jby8YR3ZbuOX/l7FNkq9h0RvFHG9fYQh1E
   pKhAtuFboKoE8ff1L4iJaqziSZO0LJBLhEr+kIw3jsyheD/hEeL3OQORD
   w==;
X-CSE-ConnectionGUID: GKZii0FOSMe+Kv7Lrp2fjQ==
X-CSE-MsgGUID: xeyVuUq7T76plEQSsnd8qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27619857"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27619857"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 00:25:41 -0700
X-CSE-ConnectionGUID: KcgUVk6zQhC/pebS0QZcaA==
X-CSE-MsgGUID: 6KHKilN3SGaWaVPjcfJcpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="99482400"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2024 00:25:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syR4j-0008w4-0F;
	Wed, 09 Oct 2024 07:25:37 +0000
Date: Wed, 9 Oct 2024 15:24:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tang Yizhou <yizhou.tang@shopee.com>, jack@suse.cz, hch@infradead.org,
	willy@infradead.org, akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Tang Yizhou <yizhou.tang@shopee.com>
Subject: Re: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with
 the writeback code
Message-ID: <202410091559.uWiy0Oj0-lkp@intel.com>
References: <20241006152849.247152-4-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006152849.247152-4-yizhou.tang@shopee.com>

Hi Tang,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on brauner-vfs/vfs.all xfs-linux/for-next linus/master v6.12-rc2 next-20241008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tang-Yizhou/mm-page-writeback-c-Rename-BANDWIDTH_INTERVAL-to-BW_DIRTYLIMIT_INTERVAL/20241006-225445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241006152849.247152-4-yizhou.tang%40shopee.com
patch subject: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with the writeback code
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241009/202410091559.uWiy0Oj0-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410091559.uWiy0Oj0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091559.uWiy0Oj0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/xfs/xfs_iomap.c:768:7: error: call to undeclared function 'inode_to_wb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     768 |         wb = inode_to_wb(wb);
         |              ^
>> fs/xfs/xfs_iomap.c:768:5: error: incompatible integer to pointer conversion assigning to 'struct bdi_writeback *' from 'int' [-Wint-conversion]
     768 |         wb = inode_to_wb(wb);
         |            ^ ~~~~~~~~~~~~~~~
   2 errors generated.


vim +/inode_to_wb +768 fs/xfs/xfs_iomap.c

   748	
   749	/*
   750	 * We cap the maximum length we map to a sane size to keep the chunks
   751	 * of work done where somewhat symmetric with the work writeback does.
   752	 * This is a completely arbitrary number pulled out of thin air as a
   753	 * best guess for initial testing.
   754	 *
   755	 * Following the logic of writeback_chunk_size(), the length will be
   756	 * rounded to the nearest 4MB boundary.
   757	 *
   758	 * Note that the values needs to be less than 32-bits wide until the
   759	 * lower level functions are updated.
   760	 */
   761	static loff_t
   762	xfs_max_map_length(struct inode *inode, loff_t length)
   763	{
   764		struct bdi_writeback *wb;
   765		long pages;
   766	
   767		spin_lock(&inode->i_lock);
 > 768		wb = inode_to_wb(wb);
   769		pages = min(wb->avg_write_bandwidth / 2,
   770			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
   771		spin_unlock(&inode->i_lock);
   772		pages = round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
   773	
   774		return min_t(loff_t, length, pages * PAGE_SIZE);
   775	}
   776	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

