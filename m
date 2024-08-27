Return-Path: <linux-fsdevel+bounces-27269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B095FEFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4885AB219A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C92168B1;
	Tue, 27 Aug 2024 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1A4zhe3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9EDDAB;
	Tue, 27 Aug 2024 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725428; cv=none; b=D+LQiyiRBRk83bA5TnJub+ubjZjqM9Rt9kPs9w3wRPIoyFDn8X1GNi23KUiCal9fWIQoPAiUJTCNa/pgAB8HVtBUTxwOPqw6wflXnJy8rS8dDtbyHw6XFvuu28qbM1LfX4F4jv6h7aTKlC2A+KW4hSK2KMapSt+poZgbIqKMEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725428; c=relaxed/simple;
	bh=1+sHOJGfAv3d8ge8kXJJwvkdj5TiGGUN6rNeh4kdWzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv3XuUaGzICdx89PxMsY09Cl+2WLI6OUOwlGSh/GfUq9wj0XFvlj3Nj1pDWl4KLO+S+G+2+cQjiVJ89MA7weqgXB7uVY2J2OqxZo5pwdrSXaC2+p0H9MN3KMTIyHF8fhKpsb2rrnylXfzEI89xCn9Gn4xPkc73ccVYPjuZ7akmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1A4zhe3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724725427; x=1756261427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+sHOJGfAv3d8ge8kXJJwvkdj5TiGGUN6rNeh4kdWzM=;
  b=M1A4zhe3yTZNflLhbG7GSdsVzujX9nL9sUuOi8ZGQU/cMInAKriu32pG
   RmfS998aIAWecf66wksr4UoN8SEKC44/UKpV4imJ9ls80hPlM+FSbhGPm
   nQU5E9Dwu24NJ/q1Ky6lEdJ2k49gBhu2mzTJZtyPva5R2skSybNnMW3yP
   WB0URQsHfd1eUoGhrRPcrd4ZQBgGKohh7g4jSmRSaRjP77bk7yTk5rWRJ
   Vp3KxH4FYsa2h7FrAVQnLT/CU6JbyJH/nkArIs43ZwcYOmYB57vV9VfyI
   ureM/1wq3Amas4crp77qmYLA1QDXFbVlOEp7Hv55m/i6qWY9rlqiZfC1O
   g==;
X-CSE-ConnectionGUID: u66o9mkAQOGQP1YquD/rkg==
X-CSE-MsgGUID: 89UwY8CeQE6FzCLIiKLTwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34588685"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="34588685"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 19:23:46 -0700
X-CSE-ConnectionGUID: YwZL9LciQSqndo2/dXftPg==
X-CSE-MsgGUID: t1P2njC9S/CqMPyGYv+p4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="85898308"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Aug 2024 19:23:43 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1silrw-000HnO-0L;
	Tue, 27 Aug 2024 02:23:40 +0000
Date: Tue, 27 Aug 2024 10:23:07 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <202408271041.5IWf4ZQC-lkp@intel.com>
References: <20240826085347.1152675-2-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826085347.1152675-2-mhocko@kernel.org>

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tip/sched/core brauner-vfs/vfs.all linus/master v6.11-rc5]
[cannot apply to next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Hocko/bcachefs-do-not-use-PF_MEMALLOC_NORECLAIM/20240826-171013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240826085347.1152675-2-mhocko%40kernel.org
patch subject: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
config: i386-buildonly-randconfig-003-20240827 (https://download.01.org/0day-ci/archive/20240827/202408271041.5IWf4ZQC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271041.5IWf4ZQC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408271041.5IWf4ZQC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> security/security.c:664: warning: Function parameter or struct member 'gfp' not described in 'lsm_inode_alloc'
>> security/security.c:1586: warning: Function parameter or struct member 'gfp' not described in 'security_inode_alloc'


vim +664 security/security.c

33bf60cabcc768 Casey Schaufler 2018-11-12  654  
afb1cbe37440c7 Casey Schaufler 2018-09-21  655  /**
afb1cbe37440c7 Casey Schaufler 2018-09-21  656   * lsm_inode_alloc - allocate a composite inode blob
afb1cbe37440c7 Casey Schaufler 2018-09-21  657   * @inode: the inode that needs a blob
afb1cbe37440c7 Casey Schaufler 2018-09-21  658   *
afb1cbe37440c7 Casey Schaufler 2018-09-21  659   * Allocate the inode blob for all the modules
afb1cbe37440c7 Casey Schaufler 2018-09-21  660   *
afb1cbe37440c7 Casey Schaufler 2018-09-21  661   * Returns 0, or -ENOMEM if memory can't be allocated.
afb1cbe37440c7 Casey Schaufler 2018-09-21  662   */
b2ce84652b3193 Michal Hocko    2024-08-26  663  int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
afb1cbe37440c7 Casey Schaufler 2018-09-21 @664  {
afb1cbe37440c7 Casey Schaufler 2018-09-21  665  	if (!lsm_inode_cache) {
afb1cbe37440c7 Casey Schaufler 2018-09-21  666  		inode->i_security = NULL;
afb1cbe37440c7 Casey Schaufler 2018-09-21  667  		return 0;
afb1cbe37440c7 Casey Schaufler 2018-09-21  668  	}
afb1cbe37440c7 Casey Schaufler 2018-09-21  669  
b2ce84652b3193 Michal Hocko    2024-08-26  670  	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, gfp);
afb1cbe37440c7 Casey Schaufler 2018-09-21  671  	if (inode->i_security == NULL)
afb1cbe37440c7 Casey Schaufler 2018-09-21  672  		return -ENOMEM;
afb1cbe37440c7 Casey Schaufler 2018-09-21  673  	return 0;
afb1cbe37440c7 Casey Schaufler 2018-09-21  674  }
afb1cbe37440c7 Casey Schaufler 2018-09-21  675  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

