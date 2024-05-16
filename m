Return-Path: <linux-fsdevel+bounces-19628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C618C7EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 01:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E041C21855
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 23:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A62C85D;
	Thu, 16 May 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vj7jXEjv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C42249F7;
	Thu, 16 May 2024 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900694; cv=none; b=V0RQ3x9ZaHGT2a+UbkD4RWSGeSZxvx2F4/Pf6bwLdA6W0LjSVF7u7RiZakTzm3r857n1fdwZMa90/UMXR9e4EO1hnD70YOIs6UETacFZsukOCqOzqmCFcrD3dOidCXI5WvNxuNWUDrClDWjxYWSzdxv6+NGgljQhhZsEKDwwPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900694; c=relaxed/simple;
	bh=nh4nGr+gQ6wnevCjIVCmzspYxt6MCbloYi4F9t67PIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+OmpzkiLyLa3/ogWjSCSAZpQL1gHL3s1+EKJuFtqd+b/ALTkp0PKHn4rvDG7pBcx7VYJwd0UVaP9fiBAI05LqM2u7qQDLxOIVo2AUDr5w3gR0pnHCsaQvhgYNx3sIu9fqH9W7ZhRQvMCzzdpLN7X81Inq+xbs7Sry4BzOIL4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vj7jXEjv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715900693; x=1747436693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nh4nGr+gQ6wnevCjIVCmzspYxt6MCbloYi4F9t67PIg=;
  b=Vj7jXEjva+EPdM5lqBvLwDq/Nqx79yO3kynUcy2fXe0np6p7P4sEW2Bd
   sVo8KoWG0N9l3p8h+b/jERr5W8eSGLfKFhpdcV6i27ws3vXNbhmfq14DZ
   4qFumpK8kbfO/urKBmLvxpoQSS/l0fPgqF2ha0jyIpzyFqHV7d2o6rqpX
   n2nn0C4bmUMiGLaFFpr4PF4PtZoYKOa+fj/DQbd9zjbUQGCkEkkB0I7l1
   TfroctM87xz+JnpcVCuhObg9g0diiSmM6Y2+QGiq2dZUFIlwaQSH/i5Gb
   /ZukLeQN9F0KDkNqE353MHpONZWS7eVfGshfVqP0LleJx10dLYy6JLX6f
   g==;
X-CSE-ConnectionGUID: JBuN+R9nT7GY6p160paclw==
X-CSE-MsgGUID: OfnCxF1jTj6N5yjPAom1Yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12266918"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="12266918"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 16:04:52 -0700
X-CSE-ConnectionGUID: +k415JnMQi+FptgiSeOfPw==
X-CSE-MsgGUID: bl9Y4xyLRXy+FsAFUdig8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="36499893"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 May 2024 16:04:45 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7k9S-000Exl-1e;
	Thu, 16 May 2024 23:04:42 +0000
Date: Fri, 17 May 2024 07:03:46 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/3] iomap: pass blocksize to iomap_truncate_page()
Message-ID: <202405170624.liC4qYj3-lkp@intel.com>
References: <20240516073001.1066373-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516073001.1066373-2-yi.zhang@huaweicloud.com>

Hi Zhang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.9 next-20240516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/iomap-pass-blocksize-to-iomap_truncate_page/20240516-154238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240516073001.1066373-2-yi.zhang%40huaweicloud.com
patch subject: [PATCH v2 1/3] iomap: pass blocksize to iomap_truncate_page()
config: arm-randconfig-r111-20240517 (https://download.01.org/0day-ci/archive/20240517/202405170624.liC4qYj3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240517/202405170624.liC4qYj3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170624.liC4qYj3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/iomap/buffered-io.c:1453:28: sparse: sparse: incompatible types in comparison expression (different signedness):
   fs/iomap/buffered-io.c:1453:28: sparse:    long long *
   fs/iomap/buffered-io.c:1453:28: sparse:    unsigned long long [usertype] *

vim +1453 fs/iomap/buffered-io.c

  1446	
  1447	int
  1448	iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
  1449			bool *did_zero, const struct iomap_ops *ops)
  1450	{
  1451		loff_t start = pos;
  1452		unsigned int off = is_power_of_2(blocksize) ? (pos & (blocksize - 1)) :
> 1453				   do_div(pos, blocksize);
  1454	
  1455		/* Block boundary? Nothing to do */
  1456		if (!off)
  1457			return 0;
  1458		return iomap_zero_range(inode, start, blocksize - off, did_zero, ops);
  1459	}
  1460	EXPORT_SYMBOL_GPL(iomap_truncate_page);
  1461	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

