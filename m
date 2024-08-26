Return-Path: <linux-fsdevel+bounces-27239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3595FB04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDD61F245E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA4199381;
	Mon, 26 Aug 2024 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2DlK/86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E66199EAC;
	Mon, 26 Aug 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705676; cv=none; b=KiEw77TgLwKEfbE1KM9oWCX4ooF3VWsJik4LqIofjTYWu2Q+BJwkGz7443yYCiP7VnDXlGRD1AugyV2lLLNP0oTSSbS8tOJ6uip30vgFHNhGskR/ZCplnx5YqqMxB900YgCk88plN86mAhOl0Jdn/xldcDupmXU1JECKc1XWxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705676; c=relaxed/simple;
	bh=k+TQRYD+JH8C/rBpKmaN1zOafqMznb8cVJmo0xOJUb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7tRbjSPCuqrA6x3xfQn3DtrkBE3oE5eZJnAibi3VY3Ut2ODNh6P0XorNAXcmFesaIihULjDFVz147ModhtEKk89tagy8Y8oSvcTyz4DVQtxSJbg9HFk8Ri6s1vtF39dSp9gHQfY/v5lCIQByxNHb1hDKBQdfnncRnbXbOa7hpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2DlK/86; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724705675; x=1756241675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k+TQRYD+JH8C/rBpKmaN1zOafqMznb8cVJmo0xOJUb0=;
  b=J2DlK/86oHBfHi9cG/l1ByHtLKj3KZxVWyFRW2lpjPTPwUn2Lqa2ko9L
   9qp5vgmQ5jZ0Ipzp13mUmK2DcJJ2cDVcJipCleHaF1pgeIyB1spqYVu/I
   OvguD/W5oFbnq//NMxzfNMQ7bJNErR3uth0lmWEalexKpNJLaphoHC9z/
   LjKbG/wVPgE2R6HSWLJM564vO0wy3Qdoqu9dMxLTUyRxldZE+H0sgI967
   u5CXRL3CNKJzrRvQsQm+wuQTXuj31Us+6f4uDS+/KuQO6NbLHXIRQCJph
   PokAMRyIrVNonHmwZqDUQPWCqT93t2MHNlfCMq2n2M7ec1w8vnfc7bPKs
   Q==;
X-CSE-ConnectionGUID: NC8ry6IjSx+8R0uzQmYdxw==
X-CSE-MsgGUID: MHHF64zPQ/mKGm+vU9wZMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23332965"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23332965"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:54:34 -0700
X-CSE-ConnectionGUID: Ns8CnMvxRZ6DEQfFoFoGVg==
X-CSE-MsgGUID: apbdG7+TS1uH63Jl7VN+2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="63365817"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 Aug 2024 13:54:30 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sigjL-000Hai-0L;
	Mon, 26 Aug 2024 20:54:27 +0000
Date: Tue, 27 Aug 2024 04:53:28 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202408270446.6Ew7FPHA-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on tip/sched/core brauner-vfs/vfs.all linus/master v6.11-rc5]
[cannot apply to next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Hocko/bcachefs-do-not-use-PF_MEMALLOC_NORECLAIM/20240826-171013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240826085347.1152675-2-mhocko%40kernel.org
patch subject: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
config: arm-randconfig-003-20240827 (https://download.01.org/0day-ci/archive/20240827/202408270446.6Ew7FPHA-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270446.6Ew7FPHA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270446.6Ew7FPHA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/bcachefs/fs.c:4:
   In file included from fs/bcachefs/bcachefs.h:188:
   In file included from include/linux/bio.h:10:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2198:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/bcachefs/fs.c:248:60: error: too many arguments provided to function-like macro invocation
     248 |         if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v), gfp)) {
         |                                                                   ^
   include/linux/compiler.h:77:10: note: macro 'unlikely' defined here
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |          ^
>> fs/bcachefs/fs.c:248:6: error: use of undeclared identifier 'unlikely'
     248 |         if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v), gfp)) {
         |             ^
>> fs/bcachefs/fs.c:261:60: error: use of undeclared identifier 'GFP_NOWARN'
     261 |         struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWARN | GFP_NOWAIT);
         |                                                                   ^
   1 warning and 3 errors generated.


vim +248 fs/bcachefs/fs.c

   233	
   234	static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c, gfp_t gfp)
   235	{
   236		struct bch_inode_info *inode = kmem_cache_alloc(bch2_inode_cache, gfp);
   237		if (!inode)
   238			return NULL;
   239	
   240		inode_init_once(&inode->v);
   241		mutex_init(&inode->ei_update_lock);
   242		two_state_lock_init(&inode->ei_pagecache_lock);
   243		INIT_LIST_HEAD(&inode->ei_vfs_inode_list);
   244		inode->ei_flags = 0;
   245		mutex_init(&inode->ei_quota_lock);
   246		memset(&inode->ei_devs_need_flush, 0, sizeof(inode->ei_devs_need_flush));
   247	
 > 248		if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v), gfp)) {
   249			kmem_cache_free(bch2_inode_cache, inode);
   250			return NULL;
   251		}
   252	
   253		return inode;
   254	}
   255	
   256	/*
   257	 * Allocate a new inode, dropping/retaking btree locks if necessary:
   258	 */
   259	static struct bch_inode_info *bch2_new_inode(struct btree_trans *trans)
   260	{
 > 261		struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWARN | GFP_NOWAIT);
   262	
   263		if (unlikely(!inode)) {
   264			int ret = drop_locks_do(trans, (inode = __bch2_new_inode(trans->c, GFP_NOFS)) ? 0 : -ENOMEM);
   265			if (ret && inode) {
   266				__destroy_inode(&inode->v);
   267				kmem_cache_free(bch2_inode_cache, inode);
   268			}
   269			if (ret)
   270				return ERR_PTR(ret);
   271		}
   272	
   273		return inode;
   274	}
   275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

