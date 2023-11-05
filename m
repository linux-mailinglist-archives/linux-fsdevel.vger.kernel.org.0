Return-Path: <linux-fsdevel+bounces-1986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ECA7E1355
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 13:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521C7B20E2E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485033E9;
	Sun,  5 Nov 2023 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICCpbzlb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51082584
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 12:35:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB61D9
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 04:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699187709; x=1730723709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gfahQe95L3q9J0wh1Rdh7LihfGe/15Xs2Z7omiap4Rk=;
  b=ICCpbzlbZHX5fKvm5KfNd6NV0YmdGCDYv5QHY6CGOdXFGxLH7CUVFTLO
   cVX145u4mvhFiYMDSdhXtYxBWraDI5i5yEXoFnc6AHsR66DE7ZvVYwjkU
   l8jbeDfyWooQ1B/tAqXKPAuCwHGfO1lTJloZOIh6eCESCvr5JCWE0z0ay
   VBPgVQ1jOTyZX15hrRBdJeobBJppPt8fmTqDxl0IQmaYbcyt7gZMs1+rh
   DbURxNTbkTNMBNLOVbcyxOgXBhQJUAl/kspLLVigmkDVuMMoOCPq3I+ks
   eyefEBc1xQC8EIfPNCtYmrPKkSMV1saVudGKcD34ArqyhVzxoyByKp4PY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="393032550"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="393032550"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 04:35:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="1009271753"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="1009271753"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2023 04:35:07 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzcLJ-0005Qe-0T;
	Sun, 05 Nov 2023 12:35:05 +0000
Date: Sun, 5 Nov 2023 20:33:31 +0800
From: kernel test robot <lkp@intel.com>
To: obuil.liubo@gmail.com, fuse-devel@lists.sourceforge.net
Cc: oe-kbuild-all@lists.linux.dev, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix stale data issue of virtiofs with dax
Message-ID: <202311052017.XxUVgk2W-lkp@intel.com>
References: <20231105063608.68114-1-obuil.liubo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105063608.68114-1-obuil.liubo@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on linus/master v6.6 next-20231103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/obuil-liubo-gmail-com/fuse-fix-stale-data-issue-of-virtiofs-with-dax/20231105-143819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20231105063608.68114-1-obuil.liubo%40gmail.com
patch subject: [PATCH] fuse: fix stale data issue of virtiofs with dax
config: s390-defconfig (https://download.01.org/0day-ci/archive/20231105/202311052017.XxUVgk2W-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311052017.XxUVgk2W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311052017.XxUVgk2W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/fuse/dax.c: In function 'fuse_dax_inode_cleanup_range':
>> fs/fuse/dax.c:392:28: warning: unused variable 'fi' [-Wunused-variable]
     392 |         struct fuse_inode *fi = get_fuse_inode(inode);
         |                            ^~


vim +/fi +392 fs/fuse/dax.c

   387	
   388	/* Callers need to make sure fi->i_mmap_sem is held. */
   389	void fuse_dax_inode_cleanup_range(struct inode *inode, loff_t start)
   390	{
   391		struct fuse_conn *fc = get_fuse_conn(inode);
 > 392		struct fuse_inode *fi = get_fuse_inode(inode);
   393	
   394		inode_reclaim_dmap_range(fc->dax, inode, start, -1);
   395	}
   396	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

