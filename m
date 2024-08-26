Return-Path: <linux-fsdevel+bounces-27128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 792EA95ECD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3CC1C2178F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D8142915;
	Mon, 26 Aug 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMqQu3GE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0A13F441;
	Mon, 26 Aug 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663600; cv=none; b=eO1or5xvMkMNQB3lRBIDA2PfQMeBhhh5+F0mf78SpERKIuyxDLqkQlsytsBxpda7WdYCn82RKZDonTtnvAreJz2ZaHUEnpvl+c/6axVynH5BsT5CIsw3PmSrOl9Ky/BNVDDWaaD+mT5Hre6oqNYuStQDt/urhG8hLghRB7mARS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663600; c=relaxed/simple;
	bh=4nA4jNEDm6SLdH7kYlQhANzKqtqdhCy8HMruQkw4a38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPXOn8HRfCZgXmZkH5qoTjpYeX+arC8QZcMmhoCZsTZ57DHSSwt1dgGp1q3paWrkO7CE4kYNvR0OBYmaxrFJ6etbG3Tv/VFISjlysMwQRwR+qJkJctwUKirLugQswXZDAXpobIi4U8J+wKxGaqvCRMAXg7b4zptfo78C72DJa0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMqQu3GE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724663599; x=1756199599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4nA4jNEDm6SLdH7kYlQhANzKqtqdhCy8HMruQkw4a38=;
  b=YMqQu3GE+SO+wcb5Rr20FBi1LawGEh2sWdvNzJFXpg7hDS2FH+Qe6U+H
   tY3aDZi2FZ9z1Wb3EPcyyBYzOaTUMYk3vP02A5aN3Yqa6ZrRyEVsUwNXP
   gVSvvCVEeVxulB7e8Hy8GIB2QHcrwCvBV0gJdn/cTNePyf6EKh+mXK0FG
   ewE145e13oaOoWz9CI1R0EqnhMDfn4NcIWamYRY3xzjRnJJzrNmDoXBVE
   H1F0yXTcmR1PN6puiK/sz76GavwDsdxsLzsoFwgr5d0AhfDn2Q3oH6dBp
   LRCqr6Sst7OZnkV+t8FbHE4m33Vk/T8uFQzjgyFiYQuSQVGjCvoNN2+cV
   w==;
X-CSE-ConnectionGUID: VDTinndkQ+a7Czynw8oB4Q==
X-CSE-MsgGUID: pe2uhRrUQSO2qFDj3THYKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="40544221"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="40544221"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 02:12:53 -0700
X-CSE-ConnectionGUID: Nox2pa3eRfOZXOnsj0pspg==
X-CSE-MsgGUID: yZyvcUs2SMG63Lg3QNqQZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="62288980"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Aug 2024 02:12:51 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siVmK-000GoG-1W;
	Mon, 26 Aug 2024 09:12:48 +0000
Date: Mon, 26 Aug 2024 17:12:19 +0800
From: kernel test robot <lkp@intel.com>
To: sergii.boryshchenko@globallogic.com, dushistov@mail.ru
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
Subject: Re: [PATCH] ufs: Remove redundant inode number check from
 ufs_nfs_get_inode
Message-ID: <202408261605.ARxTA9jX-lkp@intel.com>
References: <20240822142610.129668-1-sergii.boryshchenko@globallogic.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822142610.129668-1-sergii.boryshchenko@globallogic.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on viro-vfs/for-next v6.11-rc5 next-20240823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sergii-boryshchenko-globallogic-com/ufs-Remove-redundant-inode-number-check-from-ufs_nfs_get_inode/20240826-120030
base:   linus/master
patch link:    https://lore.kernel.org/r/20240822142610.129668-1-sergii.boryshchenko%40globallogic.com
patch subject: [PATCH] ufs: Remove redundant inode number check from ufs_nfs_get_inode
config: arc-randconfig-001-20240826 (https://download.01.org/0day-ci/archive/20240826/202408261605.ARxTA9jX-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240826/202408261605.ARxTA9jX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408261605.ARxTA9jX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ufs/super.c: In function 'ufs_nfs_get_inode':
>> fs/ufs/super.c:101:37: warning: unused variable 'uspi' [-Wunused-variable]
     101 |         struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
         |                                     ^~~~


vim +/uspi +101 fs/ufs/super.c

^1da177e4c3f41 Linus Torvalds  2005-04-16   98  
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15   99  static struct inode *ufs_nfs_get_inode(struct super_block *sb, u64 ino, u32 generation)
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  100  {
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15 @101  	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  102  	struct inode *inode;
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  103  
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  104  	inode = ufs_iget(sb, ino);
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  105  	if (IS_ERR(inode))
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  106  		return ERR_CAST(inode);
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  107  	if (generation && inode->i_generation != generation) {
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  108  		iput(inode);
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  109  		return ERR_PTR(-ESTALE);
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  110  	}
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  111  	return inode;
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  112  }
f3e2a520f5fb1a Alexey Dobriyan 2009-12-15  113  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

