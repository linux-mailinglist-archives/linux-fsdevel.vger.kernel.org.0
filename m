Return-Path: <linux-fsdevel+bounces-27222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E4695FA01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9061F23C44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1A199395;
	Mon, 26 Aug 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e77UMpO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586454648;
	Mon, 26 Aug 2024 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701952; cv=none; b=WOi+H6zXYHW7REj19KmPTOQ38wUUDzzszXWijRGNs6Isn4gSPi+0pDghmzaY5pAWy6bf4cVhB9o3qiiIwXDgkWnHWqif04igcHZlhI3D9cipz/CBbGlCTnLvtEQPW5zr2K6+wOq/qWImYqXGhrpRfIKXo5oDCt8DQglFW1kF/88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701952; c=relaxed/simple;
	bh=lDV6G6IK1uYgrXaIRBZ2JSuYByw2/GsqdtN+OxIArF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/HCZ51IPzTtZ+qTYrpRsDshPzhAHf1qrlLlerskQ2HytD7bb9G6kmxotldfLo5CUA1jJANfQuE+Prg+NhJq2H7csr2nK0NqbleAhf3ED91QhU1YFeH9F+FaYvu7srIKAllOiQb9uuiSagAsW1s6QkdohQjnxiriJ+6J3bsWxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e77UMpO0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724701951; x=1756237951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lDV6G6IK1uYgrXaIRBZ2JSuYByw2/GsqdtN+OxIArF4=;
  b=e77UMpO0AahJgZvV78AVbPKE55U44HdZ9ScKAXc9pR5n8tRTuRziwvyh
   uS1mSm4xBJ3UROL+T+6ghlK0TDWjjMyEqRBf2sOqxEb1e1d0rqE4b93GO
   z2dpWUcs41aLqTsE/V395Cal0Lk4tagP9AuNuSyrW6NKKow+AruY2kvIe
   xl9X0igVuU+ywXLNh+6BcGDHLlqs3XSMPERX6kU6niPx8Bwj9ob0AL1Xp
   H7YltEjTU3LFd5HCT6oLSvj9okuTVvk3UgkmJT8eofHtj2n5mqO0CQXxy
   5Wi6LukNFDr9pfWXzMT3PTbS3JrTcy3lhFc/wWmLhv2cDu14LQjZqJq3W
   w==;
X-CSE-ConnectionGUID: UNTCXOakRY+P7jYIl7MCZg==
X-CSE-MsgGUID: +MRwIC6oSiqTOnlCw2tgJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="22669375"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="22669375"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 12:52:30 -0700
X-CSE-ConnectionGUID: e+DpcGouTzCr8iWRirBe+A==
X-CSE-MsgGUID: bgxsFWqcTj6B1mjzJ2UiAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66952618"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Aug 2024 12:52:25 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siflH-000HY2-1y;
	Mon, 26 Aug 2024 19:52:23 +0000
Date: Tue, 27 Aug 2024 03:52:12 +0800
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
Message-ID: <202408270304.AUPHM0xo-lkp@intel.com>
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
config: arc-randconfig-001-20240827 (https://download.01.org/0day-ci/archive/20240827/202408270304.AUPHM0xo-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270304.AUPHM0xo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270304.AUPHM0xo-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/bcachefs/fs.c: In function '__bch2_new_inode':
>> fs/bcachefs/fs.c:248:70: error: macro "unlikely" passed 2 arguments, but takes just 1
     248 |         if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v), gfp)) {
         |                                                                      ^
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/backing-dev-defs.h:5,
                    from fs/bcachefs/bcachefs.h:186,
                    from fs/bcachefs/fs.c:4:
   include/linux/compiler.h:77: note: macro "unlikely" defined here
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         | 
>> fs/bcachefs/fs.c:248:13: error: 'unlikely' undeclared (first use in this function)
     248 |         if (unlikely(inode_init_always_gfp(c->vfs_sb, &inode->v), gfp)) {
         |             ^~~~~~~~
   fs/bcachefs/fs.c:248:13: note: each undeclared identifier is reported only once for each function it appears in
   fs/bcachefs/fs.c: In function 'bch2_new_inode':
>> fs/bcachefs/fs.c:261:67: error: 'GFP_NOWARN' undeclared (first use in this function); did you mean 'GFP_NOWAIT'?
     261 |         struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWARN | GFP_NOWAIT);
         |                                                                   ^~~~~~~~~~
         |                                                                   GFP_NOWAIT


vim +/unlikely +248 fs/bcachefs/fs.c

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

