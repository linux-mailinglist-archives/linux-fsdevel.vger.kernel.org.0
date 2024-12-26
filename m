Return-Path: <linux-fsdevel+bounces-38132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EB9FC77C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 03:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016A31628D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 02:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC836F9FE;
	Thu, 26 Dec 2024 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aB96WMBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F11C6B4
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735178635; cv=none; b=dMWBtQwYU9YltFLvjx3vb1wZ/pBdA+wM7c+L9wIFkRveUkEG5NJGmeM21WcJA5SC90GwAxpCFdWGXxXaF7vCyelCVnpdyyDcw/CILE+Q5N88Eo0J7cKHFBpI6p26OJl9zvWU4NEZptv7CLkfZzHQDQb5wFNiECm03813JjrJwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735178635; c=relaxed/simple;
	bh=1qCnwQf01MjidK75TCkTvPRxN/FQkCigCy9g6X76eM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=htgDNtwEd+VHVP7xhsY611w40p4tfXU82X4+cX0CnOxyPjjDxbpYl0aBUVW7pO6p+q5jk6xeML15WRUf/1MDU4r3hr6+kPkaJWJ0J0mUZ0yjjueIoS0PVlBhSdqSBG/AIlRW6Jy3wtJ/qneOGEXpA0SqCYB1k64L82Q1d8imR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aB96WMBU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735178633; x=1766714633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1qCnwQf01MjidK75TCkTvPRxN/FQkCigCy9g6X76eM4=;
  b=aB96WMBUeLQSnkHt1G1qffwJOO424BfxdGGtFsFOJS+Ja6f6ql/ayc48
   A8k2ow4SgGNZeEPOQtd3PjDdIRzGr+4t7iYbpqpCGxKXWwbQM7ed5LRR3
   woYSuc9WETB0frWVP5C+b/K7hr9ThzXaIUXjY30F4Fh8Id0vv+IBBzcOa
   aig44+XZcUFZHyzSNOb80sB6VGilGAMoE2Xou9XDLt0Z1CCfa2LqOKPCO
   a3PG2Dbgrrpb7+2XgdIWRo/MD+jVWCR43IfN0+OeyEVQXHKeTa5LeQ4sf
   T7IUWmfyuW0j77VtyNW6G2nJSLAmY4zdEFfjM7VHw1IAuYzvURUvP1GNI
   A==;
X-CSE-ConnectionGUID: pwz/yYMkSpGvWU1YxwM3PQ==
X-CSE-MsgGUID: MwumF9DlT7qSt4t1KcUrkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="46976608"
X-IronPort-AV: E=Sophos;i="6.12,264,1728975600"; 
   d="scan'208";a="46976608"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 18:03:53 -0800
X-CSE-ConnectionGUID: SdOEKf4BSJqoGRohpAOqAg==
X-CSE-MsgGUID: 8BzOvSS5SoGPvCVMJWH2vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123088722"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Dec 2024 18:03:52 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQdE5-0002Ha-37;
	Thu, 26 Dec 2024 02:03:49 +0000
Date: Thu, 26 Dec 2024 10:03:22 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.debugfs 17/18] mm/slub.c:7576:70: error: macro
 "debugfs_create_file" passed 6 arguments, but takes just 5
Message-ID: <202412260912.PLXDHzVz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.debugfs
head:   e98a67d7c1e4a22fa9b851507e25ecdc5b8cea6d
commit: 3c2d1b64cb4320860923a2097f5891efa2d7060e [17/18] slub: don't mess with ->d_name
config: arc-randconfig-001-20241226 (https://download.01.org/0day-ci/archive/20241226/202412260912.PLXDHzVz-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241226/202412260912.PLXDHzVz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412260912.PLXDHzVz-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/slub.c: In function 'debugfs_slab_add':
>> mm/slub.c:7576:70: error: macro "debugfs_create_file" passed 6 arguments, but takes just 5
    7576 |                 (void *)(unsigned long)TRACK_FREE, &slab_debugfs_fops);
         |                                                                      ^
   In file included from mm/slub.c:46:
   include/linux/debugfs.h:125: note: macro "debugfs_create_file" defined here
     125 | #define debugfs_create_file(name, mode, parent, data, fops)                     \
         | 
>> mm/slub.c:7575:9: error: 'debugfs_create_file' undeclared (first use in this function); did you mean 'debugfs_create_xul'?
    7575 |         debugfs_create_file("free_traces", 0400, slab_cache_dir, s,
         |         ^~~~~~~~~~~~~~~~~~~
         |         debugfs_create_xul
   mm/slub.c:7575:9: note: each undeclared identifier is reported only once for each function it appears in


vim +/debugfs_create_file +7576 mm/slub.c

  7562	
  7563	static void debugfs_slab_add(struct kmem_cache *s)
  7564	{
  7565		struct dentry *slab_cache_dir;
  7566	
  7567		if (unlikely(!slab_debugfs_root))
  7568			return;
  7569	
  7570		slab_cache_dir = debugfs_create_dir(s->name, slab_debugfs_root);
  7571	
  7572		debugfs_create_file_aux("alloc_traces", 0400, slab_cache_dir, s,
  7573			(void *)(unsigned long)TRACK_ALLOC, &slab_debugfs_fops);
  7574	
> 7575		debugfs_create_file("free_traces", 0400, slab_cache_dir, s,
> 7576			(void *)(unsigned long)TRACK_FREE, &slab_debugfs_fops);
  7577	}
  7578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

