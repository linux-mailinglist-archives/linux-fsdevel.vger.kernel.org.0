Return-Path: <linux-fsdevel+bounces-25760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0684194FDF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 08:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE11D28149F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974C3CF7E;
	Tue, 13 Aug 2024 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNzOnwtJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE804317C;
	Tue, 13 Aug 2024 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531097; cv=none; b=Sgx/+7ACIoGRmhU7v+NW7uMvyloxz2E/R+fg/LyuvPhSSTNsGL5V94GCO7QTIdKO3wbWNr/MsZX0kUI3eMeo4uok65x5MvyltH5wgnjXioAz2L432eNrcKGBS9YecQmRioSnslyktAvnKnETJGKp3HtCKkHxBuSMewSnrixO/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531097; c=relaxed/simple;
	bh=bI3QCyj1ouSefMrJYxldIjc9xOGTvnZw7aaw26QGLm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb2kAY8BnnIc/FkAV1NNZPnH3CimJ8SCy59ILw+g0c0FP66g495AYpNvQqawIw9E9LzL9Ed4GY6JcuANhj805BCzDo5e4r8bMJKEbx/DHkTqXIVHJ1rBWBzJepJC12XnuleIenmkle3xstCiVFcQfrKZwvTtNsQOx/EQrP2xndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNzOnwtJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723531094; x=1755067094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bI3QCyj1ouSefMrJYxldIjc9xOGTvnZw7aaw26QGLm0=;
  b=SNzOnwtJFjrxIqgvDIL4Nau3oHUqvcrFSoYQ+r7pfBEBCF2uc3cROI+H
   tnfBqBV68HB07GH2TQmhVP1k6/jP6C+RoJ38yhoKt6JpBtySbuzznMefP
   HffNyQZdwLxeTbpTOoGkmqbpLBC+fVmci7AqeNLEuLrhhk7w6xdVex4oP
   8on5s3NganONucQlnk57QQUT73Qn8iGCrAvyJBCtJ9Cu6Nl9Ttvksfqbg
   66Zm0roXTaupl43JM+aaZNRcXGXEwb1Lt1flizieyomV+WJvlTTpimLjh
   c4SC7NoBiqKwMv6GKglfG6fFtrvT+8+AYg+fZGNVw7f93w/PgZm7Moicv
   A==;
X-CSE-ConnectionGUID: PpAdSaHyQkm/2ZL4jC++GA==
X-CSE-MsgGUID: o3qD3bwzQhKu6M2qJjvyIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21816019"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21816019"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 23:38:13 -0700
X-CSE-ConnectionGUID: 6UhcKNQEQkOFiAUabJw7PA==
X-CSE-MsgGUID: Q6L2i1QFTLy43wvGSJeQpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="63252911"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2024 23:38:11 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdlAW-0000Es-2m;
	Tue, 13 Aug 2024 06:38:08 +0000
Date: Tue, 13 Aug 2024 14:37:52 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs: convert perag lookup to xarray
Message-ID: <202408131403.L5SrjEa7-lkp@intel.com>
References: <20240812063143.3806677-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812063143.3806677-3-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on akpm-mm/mm-nonmm-unstable linus/master v6.11-rc3 next-20240813]
[cannot apply to djwong-xfs/djwong-devel]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/xfs-convert-perag-lookup-to-xarray/20240812-183447
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
patch link:    https://lore.kernel.org/r/20240812063143.3806677-3-hch%40lst.de
patch subject: [PATCH 2/3] xfs: convert perag lookup to xarray
config: x86_64-randconfig-122-20240813 (https://download.01.org/0day-ci/archive/20240813/202408131403.L5SrjEa7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408131403.L5SrjEa7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408131403.L5SrjEa7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_icache.c:1776:9: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got unsigned int enum xfs_icwalk_goal goal @@
   fs/xfs/xfs_icache.c:1776:9: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:1776:9: sparse:     got unsigned int enum xfs_icwalk_goal goal
>> fs/xfs/xfs_icache.c:1776:9: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got unsigned int enum xfs_icwalk_goal goal @@
   fs/xfs/xfs_icache.c:1776:9: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:1776:9: sparse:     got unsigned int enum xfs_icwalk_goal goal
>> fs/xfs/xfs_icache.c:244:51: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got unsigned int tag @@
   fs/xfs/xfs_icache.c:244:51: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:244:51: sparse:     got unsigned int tag
   fs/xfs/xfs_icache.c:286:53: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got unsigned int tag @@
   fs/xfs/xfs_icache.c:286:53: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:286:53: sparse:     got unsigned int tag
>> fs/xfs/xfs_icache.c:1379:9: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got int @@
   fs/xfs/xfs_icache.c:1379:9: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:1379:9: sparse:     got int
>> fs/xfs/xfs_icache.c:1379:9: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got int @@
   fs/xfs/xfs_icache.c:1379:9: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:1379:9: sparse:     got int
   fs/xfs/xfs_icache.c:1509:9: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got int @@
   fs/xfs/xfs_icache.c:1509:9: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:1509:9: sparse:     got int
   fs/xfs/xfs_icache.c:1509:9: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got int @@
   fs/xfs/xfs_icache.c:1509:9: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:1509:9: sparse:     got int
   fs/xfs/xfs_icache.c:1515:9: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got int @@
   fs/xfs/xfs_icache.c:1515:9: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:1515:9: sparse:     got int
   fs/xfs/xfs_icache.c:1515:9: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted xa_mark_t [usertype] @@     got int @@
   fs/xfs/xfs_icache.c:1515:9: sparse:     expected restricted xa_mark_t [usertype]
   fs/xfs/xfs_icache.c:1515:9: sparse:     got int
   fs/xfs/xfs_icache.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:869:25: sparse: sparse: context imbalance in 'xfs_iget_recycle' - unexpected unlock
   fs/xfs/xfs_icache.c:580:28: sparse: sparse: context imbalance in 'xfs_iget_cache_hit' - different lock contexts for basic block

vim +1776 fs/xfs/xfs_icache.c

  1762	
  1763	/* Walk all incore inodes to achieve a given goal. */
  1764	static int
  1765	xfs_icwalk(
  1766		struct xfs_mount	*mp,
  1767		enum xfs_icwalk_goal	goal,
  1768		struct xfs_icwalk	*icw)
  1769	{
  1770		struct xfs_perag	*pag;
  1771		int			error = 0;
  1772		int			last_error = 0;
  1773		unsigned long		index = 0;
  1774	
  1775		rcu_read_lock();
> 1776		xa_for_each_marked(&mp->m_perags, index, pag, goal) {
  1777			if (!atomic_inc_not_zero(&pag->pag_active_ref))
  1778				continue;
  1779			rcu_read_unlock();
  1780	
  1781			error = xfs_icwalk_ag(pag, goal, icw);
  1782			xfs_perag_rele(pag);
  1783	
  1784			rcu_read_lock();
  1785			if (error) {
  1786				last_error = error;
  1787				if (error == -EFSCORRUPTED)
  1788					break;
  1789			}
  1790		}
  1791		rcu_read_unlock();
  1792	
  1793		return last_error;
  1794		BUILD_BUG_ON(XFS_ICWALK_PRIVATE_FLAGS & XFS_ICWALK_FLAGS_VALID);
  1795	}
  1796	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

