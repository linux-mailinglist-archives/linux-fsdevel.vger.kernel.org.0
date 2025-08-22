Return-Path: <linux-fsdevel+bounces-58838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E10AB31FED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4FC5655E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E324679E;
	Fri, 22 Aug 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpGC63Vt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F2023ABB3;
	Fri, 22 Aug 2025 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878089; cv=none; b=Z12VqAWStGJHvi8l75KmpaCcKESecRthOy53bA5plF4IIwmw0QYjDetkZqI1xm9ze4RjyBjsDfIUQtsoRyNyRjiPkD72y45U5ORdCOmBnwHwrcTbTSWgPCw2okfTjYXzwEE86Wzi6aTtPC1xuMIeRCXlMlvI7Rs/e+DfdlV669Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878089; c=relaxed/simple;
	bh=5CpJwtN4YU5k7r9j3IGFBd2WOJPPnufcGTcQczlLJ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIlBEtdavTvPmc5ao9pWCNay0j74SBmgh8WmkL++IWOWpAbggzOkAnZBlVn+Adq/d4mI5QbM6u0IM68kkY5j5urL/x3Izcx+kdJJJo49O4tmrJ530oN86DExtGOnLNn5ZJeJwF8VDi5qOJEMbi23EqbTFr7nKAOaCt+2St1NM28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpGC63Vt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755878088; x=1787414088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5CpJwtN4YU5k7r9j3IGFBd2WOJPPnufcGTcQczlLJ9I=;
  b=bpGC63Vt+pd+y1AmDD00O7WQqQ9inJQwnikOeJUi2fpXp6mmFCJM026e
   u8nWzyLdooBV0tzBGJAYm3BBHvrDRRFo0gROvPFy6Z0bR9bxeDITJSUAx
   41fc+pD6IAaxmZJxb5p/ZGy239+KuTZxm4nbtKv2DvsjzhtN3N+LfgopY
   JHSjs2bqcrO/ROiVbUBflIhqJ6b4s+PNAZK0HWB/Q8Uc7xbGShNF3SR6v
   bMNeZmUBFSrL4cmCBDJX6xwnzxd/BOzNqb9jzAbPETZBIgCpnP7maaI3t
   bYtsZ5XE5zUHsPWMAxD51Lj9aGdBLwla0dplqsnK88Zf2N82BadHaDf8C
   Q==;
X-CSE-ConnectionGUID: VolCIYbrRRyHpuRgXV02qg==
X-CSE-MsgGUID: eOVFqXX0Rz6CV6ax0JmdPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75772699"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="75772699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 08:54:45 -0700
X-CSE-ConnectionGUID: 5XhtKKiRRh65vNnD+8r4dg==
X-CSE-MsgGUID: T79+0M6mTB2gSjfwwlp2sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199620288"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Aug 2025 08:54:44 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upU6D-000LUr-1f;
	Fri, 22 Aug 2025 15:54:41 +0000
Date: Fri, 22 Aug 2025 23:53:46 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, linkinjeon@kernel.org,
	sj1557.seo@samsung.com, yuezhang.mo@sony.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH v3 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Message-ID: <202508222315.aWhqo6ik-lkp@intel.com>
References: <20250821150926.1025302-2-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821150926.1025302-2-ethan.ferguson@zetier.com>

Hi Ethan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.17-rc2 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/exfat-Add-support-for-FS_IOC_-GET-SET-FSLABEL/20250821-231649
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250821150926.1025302-2-ethan.ferguson%40zetier.com
patch subject: [PATCH v3 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
config: s390-randconfig-001-20250822 (https://download.01.org/0day-ci/archive/20250822/202508222315.aWhqo6ik-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d26ea02060b1c9db751d188b2edb0059a9eb273d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508222315.aWhqo6ik-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508222315.aWhqo6ik-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:37:9: warning: '__SANITIZE_THREAD__' macro redefined [-Wmacro-redefined]
      37 | #define __SANITIZE_THREAD__
         |         ^
   <built-in>:368:9: note: previous definition is here
     368 | #define __SANITIZE_THREAD__ 1
         |         ^
>> fs/exfat/super.c:727:6: warning: variable 'bh' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     727 |         if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/exfat/super.c:757:6: note: uninitialized use occurs here
     757 |         if (bh) {
         |             ^~
   fs/exfat/super.c:727:2: note: remove the 'if' if its condition is always false
     727 |         if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     728 |                 ret = -EINVAL;
         |                 ~~~~~~~~~~~~~~
     729 |                 goto cleanup;
         |                 ~~~~~~~~~~~~~
     730 |         }
         |         ~
   fs/exfat/super.c:724:24: note: initialize the variable 'bh' to silence this warning
     724 |         struct buffer_head *bh;
         |                               ^
         |                                = NULL
   2 warnings generated.


vim +727 fs/exfat/super.c

   718	
   719	int exfat_write_volume_label(struct super_block *sb,
   720				     struct exfat_uni_name *uniname)
   721	{
   722		int ret, i;
   723		struct exfat_sb_info *sbi = EXFAT_SB(sb);
   724		struct buffer_head *bh;
   725		struct exfat_dentry *ep;
   726	
 > 727		if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
   728			ret = -EINVAL;
   729			goto cleanup;
   730		}
   731	
   732		ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, true);
   733		if (ret < 0)
   734			goto cleanup;
   735	
   736		ret = exfat_alloc_volume_label(sb);
   737		if (ret < 0)
   738			goto cleanup;
   739	
   740		memcpy(sbi->volume_label, uniname->name,
   741		       uniname->name_len * sizeof(short));
   742	
   743		mutex_lock(&sbi->s_lock);
   744		for (i = 0; i < uniname->name_len; i++)
   745			ep->dentry.volume_label.volume_label[i] =
   746				cpu_to_le16(sbi->volume_label[i]);
   747		// Fill the rest of the str with 0x0000
   748		for (; i < EXFAT_VOLUME_LABEL_LEN; i++)
   749			ep->dentry.volume_label.volume_label[i] = 0x0000;
   750	
   751		ep->dentry.volume_label.char_count = uniname->name_len;
   752		mutex_unlock(&sbi->s_lock);
   753	
   754		ret = 0;
   755	
   756	cleanup:
   757		if (bh) {
   758			exfat_update_bh(bh, true);
   759			brelse(bh);
   760		}
   761	
   762		return ret;
   763	}
   764	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

