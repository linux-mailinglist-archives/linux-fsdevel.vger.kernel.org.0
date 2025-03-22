Return-Path: <linux-fsdevel+bounces-44811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F210AA6CD3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 00:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BFB3B595C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED151EEA38;
	Sat, 22 Mar 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kqg3ts3A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B009443;
	Sat, 22 Mar 2025 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742686032; cv=none; b=ddFloi6DTdyDIvkF8BsIEtmCMFkj1gvgO0bv+6xOi1v2WhSc0CH9dwf8f+L7H76a3wl60bQNVfmDpvg5l7WBCaZQPOcjP2MObJG9oVZlKkYEqyH/ucjaApXYAHwlnAFOAd/46Q0dPD7EU/q5pepTqnNmqyWxUJPwfWNSQehtU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742686032; c=relaxed/simple;
	bh=Pc4EaFka8WBeGBfYm0TdQucMC1+YmV4+nK+iUH4S1XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvgptjZzbR1ezcqqcyWiCcPjcnh2gZ/mC+/luGG2L26pXjzxu1DjrXkDV+7mFob/ENL180nSij3nQ/DYO78ueRBVF35dvA4bA0c5IjuUezCuFaN0Jwyf2s+yXx5X0FjsTzDalnot7Dlf0MBdwdNvIdBUSXCVDsSYpDOAFaTp25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kqg3ts3A; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742686030; x=1774222030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pc4EaFka8WBeGBfYm0TdQucMC1+YmV4+nK+iUH4S1XA=;
  b=Kqg3ts3AWZzzAzDGh4qMGFv5nRL4LZ0xiKV4n/GW9q/dQu4cmy8RjcvH
   pkfHZT5ky03lfc5Vsbddzn2uPUdSq+yQ0uSltSiga+fljfjrWQ2+XHjBA
   +vTrCiIiJt+0fwkTEuxqQ/K/vvfgGtO4zYwvN5YkACCV4Fm6mIBQKXxtH
   xAyU2HhYFio5XOYc0qiWZ9L3MjrgfU8PrjBuoFN4n3j+2b0TbOW3kEs+9
   uCP8rTNMl6mZXlaiv3EBgMHsI81Cl6DfKjXDmdRywpfLho0Gr0IewG/LO
   U4XsZpKOs937irN50Pnzbjrbo0TO5CtqTbjWWMT2+y5+WfQUONQSkNGPw
   Q==;
X-CSE-ConnectionGUID: SE+XXmkPTrigQThEwntsTA==
X-CSE-MsgGUID: NpGosvcJRiSVcP/GSzW9Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11381"; a="47698292"
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="47698292"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 16:27:09 -0700
X-CSE-ConnectionGUID: Y78lcGebR4G74DzfyKPtTA==
X-CSE-MsgGUID: OAAblMt3QSaG9/0EZzoMxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,268,1736841600"; 
   d="scan'208";a="128925105"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 22 Mar 2025 16:27:07 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tw8F6-0002Rx-1t;
	Sat, 22 Mar 2025 23:27:04 +0000
Date: Sun, 23 Mar 2025 07:26:46 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Gao Xiang <xiang@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>
Subject: Re: [PATCH v2 4/9] fs: minix: register an initrd fs detector
Message-ID: <202503230754.YpVap9pi-lkp@intel.com>
References: <20250322-initrd-erofs-v2-4-d66ee4a2c756@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-initrd-erofs-v2-4-d66ee4a2c756@cyberus-technology.de>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 88d324e69ea9f3ae1c1905ea75d717c08bdb8e15]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Stecklina-via-B4-Relay/initrd-remove-ASCII-spinner/20250323-043649
base:   88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
patch link:    https://lore.kernel.org/r/20250322-initrd-erofs-v2-4-d66ee4a2c756%40cyberus-technology.de
patch subject: [PATCH v2 4/9] fs: minix: register an initrd fs detector
config: um-randconfig-002-20250323 (https://download.01.org/0day-ci/archive/20250323/202503230754.YpVap9pi-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250323/202503230754.YpVap9pi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503230754.YpVap9pi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/minix/initrd.c:23:34: error: too many arguments provided to function-like macro invocation
      23 | initrd_fs_detect(detect_minixfs, BLOCK_SIZE);
         |                                  ^
   include/linux/initrd.h:63:9: note: macro 'initrd_fs_detect' defined here
      63 | #define initrd_fs_detect(detectfn)
         |         ^
>> fs/minix/initrd.c:23:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      23 | initrd_fs_detect(detect_minixfs, BLOCK_SIZE);
         | ^
         | int
   2 errors generated.


vim +23 fs/minix/initrd.c

    22	
  > 23	initrd_fs_detect(detect_minixfs, BLOCK_SIZE);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

