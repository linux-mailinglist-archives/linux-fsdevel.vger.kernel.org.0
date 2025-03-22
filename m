Return-Path: <linux-fsdevel+bounces-44812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865A5A6CD3D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 00:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06C17A61AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C751EEA3C;
	Sat, 22 Mar 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlm/kBhm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E881C5D62;
	Sat, 22 Mar 2025 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742686033; cv=none; b=pgf0ncrlhYwXHnl1TxxBOb8W1Qbxjsrr76PUKfaFHzufC+rTziCQWA77Z3gGj49PJvZ5rvLnSKWa/vE3cfIYzDacjp+lD6Jie4zcNyBYElfxkTZp+V2G8pzck9np0fYCKamgZyuoA16XtaEwxhaO+vPLyXEa0D7Ml+HKdGN/nZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742686033; c=relaxed/simple;
	bh=HtOa37cx/H9hJIAL1yKGAH93P+7CkYj34IpV2IECwOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJwzS/cdi3qhJ6iRxHSiHoIuaCINo/YECfnhS5NpqVkMmF9zzrB2Y1ago92Q+Et5nxlTfzJ8+Gp5pldyw90UhjZdU7BHz1uTeNn0v9aq4bJFo3VK+AUFpTUk32eObDQ6FBox1f+F2eburfVVDv76Sw7QoI9J0kVDgigwyogVw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlm/kBhm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742686030; x=1774222030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HtOa37cx/H9hJIAL1yKGAH93P+7CkYj34IpV2IECwOg=;
  b=mlm/kBhmSGM1vwLAVpICCu5fkmN5yRAaW7FDpdfqbpFi1tH3++CJWE+T
   ttJ1oq3uSIdAVxvqf/Wpzz2XzVmzyZlZHGntBPyFntLuoSXAKE/x+K/wU
   lnPtYiX0o87fx6UCShYwYt4fh387xT2+5MPWdpjsCKSrz2hjpqJQdZeV7
   LNZP7myrt6/A7juARnbkZam9AvcKaBdIZJ47FvZUk7o4Pudz551WpPT+S
   4V9cywG6MnJzP9hXb63K4RsU6w42tngL7QlzJs9pCAyRU3v42Ztm0//ff
   ktgKXQRaQpLw10fdqkGY48JKlWC7LQbsnlYsvOtfQMetZ067JTCuq3HCS
   A==;
X-CSE-ConnectionGUID: SZYSQaORQ4iGpeU0UAcF1A==
X-CSE-MsgGUID: DCXGq9foSdOgrEdN6n22OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="66385233"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="66385233"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 16:27:10 -0700
X-CSE-ConnectionGUID: yJNrLWFySMWgkFMoXETkXQ==
X-CSE-MsgGUID: Q/4tgiyyTT2XVEND3y7xFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="127854080"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 Mar 2025 16:27:07 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw8F6-0002S0-1x;
	Sat, 22 Mar 2025 23:27:04 +0000
Date: Sun, 23 Mar 2025 07:26:45 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Gao Xiang <xiang@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>
Subject: Re: [PATCH v2 6/9] fs: romfs: register an initrd fs detector
Message-ID: <202503230701.JV9cV28A-lkp@intel.com>
References: <20250322-initrd-erofs-v2-6-d66ee4a2c756@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-initrd-erofs-v2-6-d66ee4a2c756@cyberus-technology.de>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Stecklina-via-B4-Relay/initrd-remove-ASCII-spinner/20250323-043649
base:   88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
patch link:    https://lore.kernel.org/r/20250322-initrd-erofs-v2-6-d66ee4a2c756%40cyberus-technology.de
patch subject: [PATCH v2 6/9] fs: romfs: register an initrd fs detector
config: i386-buildonly-randconfig-002-20250323 (https://download.01.org/0day-ci/archive/20250323/202503230701.JV9cV28A-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503230701.JV9cV28A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503230701.JV9cV28A-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> fs/romfs/initrd.c:22:33: error: macro "initrd_fs_detect" passed 2 arguments, but takes just 1
      22 | initrd_fs_detect(detect_romfs, 0);
         |                                 ^
   In file included from fs/romfs/initrd.c:4:
   include/linux/initrd.h:63: note: macro "initrd_fs_detect" defined here
      63 | #define initrd_fs_detect(detectfn)
         | 
>> fs/romfs/initrd.c:22:1: warning: data definition has no type or storage class
      22 | initrd_fs_detect(detect_romfs, 0);
         | ^~~~~~~~~~~~~~~~
>> fs/romfs/initrd.c:22:1: error: type defaults to 'int' in declaration of 'initrd_fs_detect' [-Werror=implicit-int]
>> fs/romfs/initrd.c:8:22: warning: 'detect_romfs' defined but not used [-Wunused-function]
       8 | static size_t __init detect_romfs(void *block_data)
         |                      ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/initrd_fs_detect +22 fs/romfs/initrd.c

     2	
     3	#include <linux/fs.h>
   > 4	#include <linux/initrd.h>
     5	#include <linux/magic.h>
     6	#include <linux/romfs_fs.h>
     7	
   > 8	static size_t __init detect_romfs(void *block_data)
     9	{
    10		struct romfs_super_block *romfsb
    11			= (struct romfs_super_block *)block_data;
    12		BUILD_BUG_ON(sizeof(*romfsb) > BLOCK_SIZE);
    13	
    14		/* The definitions of ROMSB_WORD* already handle endianness. */
    15		if (romfsb->word0 != ROMSB_WORD0 ||
    16		    romfsb->word1 != ROMSB_WORD1)
    17			return 0;
    18	
    19		return be32_to_cpu(romfsb->size);
    20	}
    21	
  > 22	initrd_fs_detect(detect_romfs, 0);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

