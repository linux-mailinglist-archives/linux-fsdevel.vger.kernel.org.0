Return-Path: <linux-fsdevel+bounces-69042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E4CC6CABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 05:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 285DA4E6CEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 04:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1762E92BB;
	Wed, 19 Nov 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHrgQ5ki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ECA1A3029;
	Wed, 19 Nov 2025 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763525278; cv=none; b=uDA2ev3wD81i55uI5ldvJD10nZGN9dyzi2eHH50BnrcsbQiuzM4U3uvbUbuSqaFusJZ4ke/7jUWsUDtytQdhpsHs138xJ9N9S5fLy3D/lVjoIC9/JLPL8LCN8//xhCQYZWFXdRDlVla1GAZGZ5lUNx1vHmcmHRB2wmQ7nZ7jzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763525278; c=relaxed/simple;
	bh=PXKxhAplBz4aozmWWBxa9fj9MVAkQZ0bQvNiMyEJolY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww4fdbW3ms7q7XnU5VLF6twwnRQbvBAdNS0Mf4pf8W9YbNP5VAO+RuzzfUGUX/4amDHPmNKM4B+b89pCVCCJuJYkWZsTgJV2qT4vcDs1nftbff3KERO+MZ7wBIjNXSuDOsr4ainC68Rq120xJ2ZSzyEYH0WytySLPuZIUQbDJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHrgQ5ki; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763525276; x=1795061276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PXKxhAplBz4aozmWWBxa9fj9MVAkQZ0bQvNiMyEJolY=;
  b=kHrgQ5kiZu/YvlCcIgwDviwh+X7txz5ZwZ3KtNRgFAthwEAgU6u2JU/J
   cHVnS26wuEJw0sRTaeJj8HKRS19UYnIWouqat/K450JR8zpufTwkyq4dF
   Y7Q1HoBR6KYiGeXYsFC2VL4wqf5FqGM2bgTkFQL7hPJezdkIVv+D6/9kQ
   SziXeYMqxopAuSxz9CJRmR5XKJKjp5B0ql1iE0H4E7v4O2Ak3RWg/NeoW
   b9pH4I4o+29wwbM3bD1OT3eVF8uNXqbhGAqQTln9nbgexlus9n9zxu0Zm
   i24xgZ9POWhMMplSyaqqlb/s6Jdzw+F1xSlOaB0yAfet3wYyzu8gMZ4jA
   Q==;
X-CSE-ConnectionGUID: dLfJyAg/SiCXm+o59+1WJQ==
X-CSE-MsgGUID: yJVbCbGnRvC9NYiFOQoMnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="82949473"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="82949473"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 20:07:56 -0800
X-CSE-ConnectionGUID: 7cG798WRRMSFzKCCqLAXtg==
X-CSE-MsgGUID: 7VRbNMovSve5IWrMkcNf1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="228279822"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Nov 2025 20:07:55 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLZU0-0002RL-0u;
	Wed, 19 Nov 2025 04:07:52 +0000
Date: Wed, 19 Nov 2025 12:07:46 +0800
From: kernel test robot <lkp@intel.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [PATCH] fs/ntfs3: check for shutdown in fsync
Message-ID: <202511191144.MLx5UTO4-lkp@intel.com>
References: <20251118130705.411336-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118130705.411336-1-almaz.alexandrovich@paragon-software.com>

Hi Konstantin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.18-rc6 next-20251118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Komarov/fs-ntfs3-check-for-shutdown-in-fsync/20251118-210835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251118130705.411336-1-almaz.alexandrovich%40paragon-software.com
patch subject: [PATCH] fs/ntfs3: check for shutdown in fsync
config: arm-randconfig-001-20251119 (https://download.01.org/0day-ci/archive/20251119/202511191144.MLx5UTO4-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191144.MLx5UTO4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511191144.MLx5UTO4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ntfs3/file.c:1381:5: warning: no previous prototype for 'ntfs_file_fsync' [-Wmissing-prototypes]
    int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
        ^~~~~~~~~~~~~~~
   fs/ntfs3/file.c:1415:12: warning: initialized field overwritten [-Woverride-init]
     .fsync  = ntfs_file_fsync,
               ^~~~~~~~~~~~~~~
   fs/ntfs3/file.c:1415:12: note: (near initialization for 'ntfs_file_operations.fsync')


vim +/ntfs_file_fsync +1381 fs/ntfs3/file.c

  1377	
  1378	/*
  1379	 * ntfs_file_fsync - file_operations::fsync
  1380	 */
> 1381	int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  1382	{
  1383		struct inode *inode = file_inode(file);
  1384		if (unlikely(ntfs3_forced_shutdown(inode->i_sb)))
  1385			return -EIO;
  1386	
  1387		return generic_file_fsync(file, start, end, datasync);
  1388	}
  1389	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

