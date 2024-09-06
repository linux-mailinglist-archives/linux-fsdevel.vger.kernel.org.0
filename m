Return-Path: <linux-fsdevel+bounces-28882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4205596FC79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 22:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE601C24944
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6081D4618;
	Fri,  6 Sep 2024 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiOKecal"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF91B85E2
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652857; cv=none; b=CiijhZ+Xq2Z8KYJfb3CY3AomhqkK96nTEaqI4GTPDUvJvkT73j9n9OFjl4xoRqHZhAw1AqS7fbocR979RrROPPWHqdX07GeOStE9hIY7zWEj/pbuPlFI+AZD/0414Oi7/TdRYt9eX/lKT3Refaow5+u3M5yD/UBd6nmOJXKt/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652857; c=relaxed/simple;
	bh=yZP4dvb3C45vzv22TJtPlhgJ5+geg7Fn+Of9k7kZUfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvkG/hFPNbS7QKM8OkrkaNUEA0IlPZ2VP6Ek86c1cHnsgjcM4AQ7+zvqJJtd87DJhi8RInHES//gYCrQQRPgWL+gGfx3ObsEOrn05cQ1tIYgGD3azBv+1elrrM2F0wmr5Bw43hJVXPzoDbFC/kSJqkIgdyhizRriOTtwlBwQo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiOKecal; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725652855; x=1757188855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZP4dvb3C45vzv22TJtPlhgJ5+geg7Fn+Of9k7kZUfQ=;
  b=NiOKecalKsHvgev4yY/ehYzRbcTilZszJIRpGMteCUkcIs5aE6G00cHZ
   LB9H6+DWXt7011He6uEdR+UZUinIGyVZ5+eqHM7fvUVpSqEW29gY86zhz
   fOzUG7UTZZT90ctUDS+q5am9s1KtMenI2ofivpf7G+DcF+7axvkbhalRt
   0w5zKFjKcW4vmFHCA3KamxWtssSq5YlByqYbzEH/yqIJGhRFgKFdywuho
   SyVJugdkpiTExMxogrVGYxAFSVJzruILdgTLQhyfliw4cmdLUfxi+2+YT
   qrV1SdtYfOOQOSHS6muaAWGkjfJTpqaluFd6k1OhogEaUm+sTwwCRa02M
   A==;
X-CSE-ConnectionGUID: ytbVgZajQGCQYXvgE7fGpw==
X-CSE-MsgGUID: oTo0oHRrSnG9IOxffbC9jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35018782"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="35018782"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 13:00:55 -0700
X-CSE-ConnectionGUID: frjiE0w/TcSuxjG256Pmjg==
X-CSE-MsgGUID: FOs/K0u7SOCVf6jBOpa8YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66039977"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 06 Sep 2024 13:00:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smf8U-000BfW-1s;
	Fri, 06 Sep 2024 20:00:50 +0000
Date: Sat, 7 Sep 2024 04:00:21 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	josef@toxicpanda.com, bernd.schubert@fastmail.fm,
	sweettea-kernel@dorminy.me, kernel-team@meta.com
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
Message-ID: <202409070339.Pg9v3MA4-lkp@intel.com>
References: <20240905174541.392785-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905174541.392785-1-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-Enable-dynamic-configuration-of-fuse-max-pages-limit-FUSE_MAX_MAX_PAGES/20240906-014722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20240905174541.392785-1-joannelkoong%40gmail.com
patch subject: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max pages limit (FUSE_MAX_MAX_PAGES)
config: arm-randconfig-004-20240907 (https://download.01.org/0day-ci/archive/20240907/202409070339.Pg9v3MA4-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409070339.Pg9v3MA4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409070339.Pg9v3MA4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fuse/sysctl.c:28:26: error: too many arguments provided to function-like macro invocation
   int fuse_sysctl_register(void)
                            ^
   fs/fuse/fuse_i.h:1473:9: note: macro 'fuse_sysctl_register' defined here
   #define fuse_sysctl_register()          (0)
           ^
>> fs/fuse/sysctl.c:28:25: error: expected ';' after top level declarator
   int fuse_sysctl_register(void)
                           ^
                           ;
   fs/fuse/sysctl.c:36:29: error: too many arguments provided to function-like macro invocation
   void fuse_sysctl_unregister(void)
                               ^
   fs/fuse/fuse_i.h:1474:9: note: macro 'fuse_sysctl_unregister' defined here
   #define fuse_sysctl_unregister()        do { } while (0)
           ^
   3 errors generated.


vim +28 fs/fuse/sysctl.c

    27	
  > 28	int fuse_sysctl_register(void)
    29	{
    30		fuse_table_header = register_sysctl("fs/fuse", fuse_sysctl_table);
    31		if (!fuse_table_header)
    32			return -ENOMEM;
    33		return 0;
    34	}
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

