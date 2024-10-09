Return-Path: <linux-fsdevel+bounces-31423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2286E996283
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 10:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEAB1F231BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452F7188CD8;
	Wed,  9 Oct 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FysrNx5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3D175D4C;
	Wed,  9 Oct 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462467; cv=none; b=N5eKUoA0e+8556QQ82gl52/OHcuEMG3wVjXBfpUvH7+pgj+fe7PQGpouzxd4HeGKmI7Pp+XWQbU0uqCi8Qx48bh5Bis1Z1vHaByoxAJeiB7I4FbuG/aWIBPpGTRrGlirSlvAAhSVcg8ye8Idx3ynvGB4VlCV5kA6txioqv3VtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462467; c=relaxed/simple;
	bh=2FpFUMarsu8M9dnnDu129HfHD3t925/h1nSZ+wj/9Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuzb+9+Bs9nB2bO4TNJeqpYjblsuca44rvWSruY8IJ6/rs70uwRoIDTqhlO0vBKD+D94xSebF/ukk1yImw6FqJs9eEDYA7aojroTpckOYdUIFlrR1mOtoAQ+ZdcUDOD2qUs1vXMlSNzB7GIt6ib6+9RolLg5w5Lqk+PDlIJAmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FysrNx5S; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728462466; x=1759998466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2FpFUMarsu8M9dnnDu129HfHD3t925/h1nSZ+wj/9Zg=;
  b=FysrNx5So5QtNPrSQLCyULqkd/LIC9OItNt+nX5DJKeyH2I0aZiqv2XA
   kjV8uqEPZCJUlXEFQns5IFm5Ep6cTNQO/N988aN9t4jCNDPYUbILjKQtE
   wKMhCodZyUVmorD6TPjCEVAH6ff37HlhklBzyE8Gn83F2GsbqFMM/n0fj
   E+NDNKeySOGufCt7j5VV0cC3GZg5D5iMNn9R99WaV15bvVpLVCzTudSEf
   jTupUXRJwtbl8YykwS5LGuKvet0KTfbVNJuBAZGcE2qydFAayAxS94NJK
   ldbEz3X7qEfuLZqK+IgbQlLHGMxmVsggKZnDX5U+j8vLSmZDINin8mPA7
   Q==;
X-CSE-ConnectionGUID: y8g49PEvQjm2LaNhdKe/1w==
X-CSE-MsgGUID: 9OresjWyRiueCJJgPJSDuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45267633"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45267633"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:27:45 -0700
X-CSE-ConnectionGUID: 5uR5IR++R0+M5stWNSg57A==
X-CSE-MsgGUID: g12ceAbYQHeVUjPm3weNgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76137983"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2024 01:27:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syS2m-000904-18;
	Wed, 09 Oct 2024 08:27:40 +0000
Date: Wed, 9 Oct 2024 16:26:47 +0800
From: kernel test robot <lkp@intel.com>
To: Tang Yizhou <yizhou.tang@shopee.com>, jack@suse.cz, hch@infradead.org,
	willy@infradead.org, akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: Re: [PATCH v2 3/3] xfs: Let the max iomap length be consistent with
 the writeback code
Message-ID: <202410091647.eyo14ayt-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241009/202410091647.eyo14ayt-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410091647.eyo14ayt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091647.eyo14ayt-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/xfs/xfs_iomap.c: In function 'xfs_max_map_length':
   fs/xfs/xfs_iomap.c:768:14: error: implicit declaration of function 'inode_to_wb' [-Wimplicit-function-declaration]
     768 |         wb = inode_to_wb(wb);
         |              ^~~~~~~~~~~
>> fs/xfs/xfs_iomap.c:768:12: error: assignment to 'struct bdi_writeback *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     768 |         wb = inode_to_wb(wb);
         |            ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +768 fs/xfs/xfs_iomap.c

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

