Return-Path: <linux-fsdevel+bounces-23583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3792ECEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36981F23019
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320116D4C8;
	Thu, 11 Jul 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwXesrys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E316B751;
	Thu, 11 Jul 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716037; cv=none; b=WOUmAzMuVLNa9SNmT+IGaK/PFzOOTGlywfNB1z4cnFm1b/RqO6ApSiSmME6WPG1gCL7+UtY2ZKRenZocwJuFfv5zVK8jsmddviWG4b7z46wcg0dfvTir4YiOF49AE2dx7XOecD5YgzvW9LOsxQtU1tTIWwEyRzbyagvrnjhxifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716037; c=relaxed/simple;
	bh=IYE7TF5GPQCsMlRCRju9rEM/n7XLffQV6C/YMIyNOw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvQ8whyOn8RQgQ365cURZ/GuU99ANe3nTIbkN8mXxRExXt68/P3zPiO/Yd80YIsl7HJwtEWKTDbrxyUyOs3qy65qTDaXLwsvQLeczk3hU4rY3gM8aU0ebM+ojnsub3LbYJv/VCAPdk/4uMKS3Xe+u12geOITsrANYoxorLpXt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwXesrys; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720716035; x=1752252035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYE7TF5GPQCsMlRCRju9rEM/n7XLffQV6C/YMIyNOw0=;
  b=OwXesrys/sfg0h2O0G8Et4/pDFvNRzeDgnxWwH3YkVZpFBWDtBp4QaLo
   CXrrUnPEw3ydwV1jB4j1E0zz9EeKlvfE+T6+hCx7O02SqDzCCDlw0GW3z
   cHQAsWFsBowr7kW7RiF0119DcGLQM1+TYWkAVKdO7Dm7gbeyTK65CY1FW
   0iBzEEZlYRms0w0IgfInU+UzCgMyduUvdv6GJwLULf5becLv38BdhWzV7
   FtnZwsl8bT+DIH9WDV9APyevkku68BzIdq6p8quvK9ajPy4FsVZ7y7xIV
   ABfLb0wi5B+1LbNoI3kY0yJ0XtawsB0AgAy4QpI+HiGQy416pRTUohWID
   g==;
X-CSE-ConnectionGUID: Y2E+JcFeR1KWSXFdDBxcdw==
X-CSE-MsgGUID: bL7Ak0TkSh+0jsLu22GiuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28720091"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28720091"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 09:40:34 -0700
X-CSE-ConnectionGUID: ucJ40MeFS3il9dJX34SceQ==
X-CSE-MsgGUID: NMeMvg0VR4uTFoTfaaCtxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48689853"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2024 09:40:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRwqM-000ZVi-1G;
	Thu, 11 Jul 2024 16:40:30 +0000
Date: Fri, 12 Jul 2024 00:40:25 +0800
From: kernel test robot <lkp@intel.com>
To: kovalev@altlinux.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, aivazian.tigran@gmail.com,
	stable@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lvc-patches@linuxtesting.org, dutyrok@altlinux.org,
	kovalev@altlinux.org,
	syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Subject: Re: [PATCH fs/bfs 1/2] bfs: fix null-ptr-deref in bfs_move_block
Message-ID: <202407120052.Al11h5ur-lkp@intel.com>
References: <20240710191118.40431-2-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710191118.40431-2-kovalev@altlinux.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc7 next-20240711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/kovalev-altlinux-org/bfs-fix-null-ptr-deref-in-bfs_move_block/20240711-072644
base:   linus/master
patch link:    https://lore.kernel.org/r/20240710191118.40431-2-kovalev%40altlinux.org
patch subject: [PATCH fs/bfs 1/2] bfs: fix null-ptr-deref in bfs_move_block
config: arm-randconfig-001-20240711 (https://download.01.org/0day-ci/archive/20240712/202407120052.Al11h5ur-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407120052.Al11h5ur-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407120052.Al11h5ur-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/bfs/file.c:15:
   In file included from include/linux/buffer_head.h:12:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2258:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/bfs/file.c:44:6: warning: variable 'err' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      44 |         if (unlikely(!new)) {
         |             ^~~~~~~~~~~~~~
   include/linux/compiler.h:77:22: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/bfs/file.c:53:9: note: uninitialized use occurs here
      53 |         return err;
         |                ^~~
   fs/bfs/file.c:44:2: note: remove the 'if' if its condition is always true
      44 |         if (unlikely(!new)) {
         |         ^~~~~~~~~~~~~~~~~~~
   fs/bfs/file.c:38:9: note: initialize the variable 'err' to silence this warning
      38 |         int err;
         |                ^
         |                 = 0
   2 warnings generated.


vim +44 fs/bfs/file.c

    33	
    34	static int bfs_move_block(unsigned long from, unsigned long to,
    35						struct super_block *sb)
    36	{
    37		struct buffer_head *bh, *new;
    38		int err;
    39	
    40		bh = sb_bread(sb, from);
    41		if (!bh)
    42			return -EIO;
    43		new = sb_getblk(sb, to);
  > 44		if (unlikely(!new)) {
    45			err = -EIO;
    46			goto out_err_new;
    47		}
    48		memcpy(new->b_data, bh->b_data, bh->b_size);
    49		mark_buffer_dirty(new);
    50		brelse(new);
    51	out_err_new:
    52		bforget(bh);
    53		return err;
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

