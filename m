Return-Path: <linux-fsdevel+bounces-68735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13338C64882
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1A93A4FD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178138DF9;
	Mon, 17 Nov 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nR7o+vQS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7335CBA5;
	Mon, 17 Nov 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387888; cv=none; b=sSKdOXpIsuLbN7Zx/RZJcm1Zh1DoPpGaG6qNyF1vr5yGYBVtiUUglvugbE3RmxU8OQ9ESYUvtHy0WFU0UiJ8HpXLOs5PcLh71BiTK9U8/oyyPlDixmPW3zT7zgCIH1QKXtlLKCZyf2y0x2le+jq6JYqLS1hdhJ7DU5PmnPxR30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387888; c=relaxed/simple;
	bh=aOOep/LMZyjCFb+0figw9x6/fU0tp4jqTN9xUA9l1RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7BQdvWKDEUSffVSX0iux2VVJ+XWsIMuQDhH7LZTRpH36p2DKFNILXZpsoSoi5JQ99yB1BJu0900urXnLDxCKP9L4epr9sHTZXJG/6FKSl3Fa0YtgSF7mO1xa4eourXSnrxjXO4sedOiflUubTeMO479/VKTrEY3hpRLj+TWioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nR7o+vQS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763387887; x=1794923887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aOOep/LMZyjCFb+0figw9x6/fU0tp4jqTN9xUA9l1RY=;
  b=nR7o+vQSL/4iihVMG4+mtmM6f087KkQ0eko1Popij5LLyE84Oer1B76b
   bgeu167rkqjj3vJl0yFKNAuiobPpl73mzwZ7+paOrtA5Aiu30LwXW5iwU
   pKL4nHBnFdDMIHwqrVAdb4jrZvLoGphnt2nyDPb8Pk1VroenZgGt6RRLb
   NY8vf1TRUho6ZMeY/RHvXzSaw6h3jGkIfwjLBAalwOU+YqanyjE+PUa8p
   aoNS6ZWLHOumoSb0JTIuEsCXHLXReQQLkUvKBngOmQpryrgIhS+0BkGWi
   M97rIyepxEY3xPMBrpeZdNMmoopU814jaEZXHMbA9cLz4UpVqItNL2VAP
   w==;
X-CSE-ConnectionGUID: QpBlt1yeQT69rwarQR4D1A==
X-CSE-MsgGUID: v4g5jzvwTeCKcbkA2fdBOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="88034659"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="88034659"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 05:58:06 -0800
X-CSE-ConnectionGUID: poikwz5BTcuAOY6uTKtFlw==
X-CSE-MsgGUID: GFanoOrsSq6EKzc2fr1N6w==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Nov 2025 05:58:04 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKzk2-0000ch-0F;
	Mon, 17 Nov 2025 13:58:02 +0000
Date: Mon, 17 Nov 2025 21:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ye Bin <yebin@huaweicloud.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH v2 2/3] sysctl: add support for drop_caches for
 individual filesystem
Message-ID: <202511172139.326qNHOk-lkp@intel.com>
References: <20251117112735.4170831-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117112735.4170831-3-yebin@huaweicloud.com>

Hi Ye,

kernel test robot noticed the following build errors:

[auto build test ERROR on viro-vfs/for-next]
[also build test ERROR on linus/master brauner-vfs/vfs.all v6.18-rc6 next-20251117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ye-Bin/vfs-introduce-reclaim_icache_sb-and-reclaim_dcache_sb-helper/20251117-193502
base:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-next
patch link:    https://lore.kernel.org/r/20251117112735.4170831-3-yebin%40huaweicloud.com
patch subject: [PATCH v2 2/3] sysctl: add support for drop_caches for individual filesystem
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20251117/202511172139.326qNHOk-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251117/202511172139.326qNHOk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511172139.326qNHOk-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/drop_caches.c: In function 'drop_fs_caches':
>> fs/drop_caches.c:107:25: error: implicit declaration of function 'syscall_set_return_value'; did you mean 'syscall_get_return_value'? [-Wimplicit-function-declaration]
     107 |                         syscall_set_return_value(current,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
         |                         syscall_get_return_value


vim +107 fs/drop_caches.c

    91	
    92	static void drop_fs_caches(struct callback_head *twork)
    93	{
    94		int ret;
    95		struct super_block *sb;
    96		static bool suppress;
    97		struct drop_fs_caches_work *work = container_of(twork,
    98				struct drop_fs_caches_work, task_work);
    99		unsigned int ctl = work->ctl;
   100		dev_t dev = work->dev;
   101	
   102		if (work->path) {
   103			struct path path;
   104	
   105			ret = kern_path(work->path, LOOKUP_FOLLOW, &path);
   106			if (ret) {
 > 107				syscall_set_return_value(current,
   108							 current_pt_regs(),
   109							 0, ret);
   110				goto out;
   111			}
   112			dev = path.dentry->d_sb->s_dev;
   113			/* Make this file's dentry and inode recyclable */
   114			path_put(&path);
   115		}
   116	
   117		sb = user_get_super(dev, false);
   118		if (!sb) {
   119			syscall_set_return_value(current, current_pt_regs(), 0,
   120						 -EINVAL);
   121			goto out;
   122		}
   123	
   124		if (ctl & BIT(0)) {
   125			lru_add_drain_all();
   126			drop_pagecache_sb(sb, NULL);
   127			count_vm_event(DROP_PAGECACHE);
   128		}
   129	
   130		if (ctl & BIT(1)) {
   131			reclaim_dcache_sb(sb);
   132			reclaim_icache_sb(sb);
   133			count_vm_event(DROP_SLAB);
   134		}
   135	
   136		if (!READ_ONCE(suppress)) {
   137			pr_info("%s (%d): %s: %d %u:%u\n", current->comm,
   138				task_pid_nr(current), __func__, ctl,
   139				MAJOR(sb->s_dev), MINOR(sb->s_dev));
   140	
   141			if (ctl & BIT(2))
   142				WRITE_ONCE(suppress, true);
   143		}
   144	
   145		drop_super(sb);
   146	out:
   147		kfree(work->path);
   148		kfree(work);
   149	}
   150	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

