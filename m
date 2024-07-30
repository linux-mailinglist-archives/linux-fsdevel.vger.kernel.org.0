Return-Path: <linux-fsdevel+bounces-24591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC46940D31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 11:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C192827DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 09:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A140194A49;
	Tue, 30 Jul 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCuWauIr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F101946CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330893; cv=none; b=beJ+0F4j5YGjqD/LeJ5ww2UY8NrWCL3CwzYKhWJw3zD4WIUdUU7O6/SAw+bviWkTZBcdpGLkow8AGPIdDeiVsdk21mGSrnmANPz38YwKax+2guefpVZz+TE6bAHFfcKPLgTt0PR/kqIM/HKmQV5KHpUwAMN4EroKw3yoBokT6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330893; c=relaxed/simple;
	bh=ijWKSCdA74gjYFReCBLXJjMYhaTomAgxVlWH4j0iGqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFykVUUbF2UTw74ziALXLx4+0PCZnAcy4PEreBNsu/cD+YluQzzuFNUsM7SCUa4a7pYCnqviQ9gU6HkD8tjiG3z/yXyPgItWbniA7EGuw9KrjZGfWRH01c3y9x+Zu+OJgiVFD5K3AipT4AAX6TMyD7gtq/nhjEmzF2FbMtyfSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCuWauIr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722330892; x=1753866892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ijWKSCdA74gjYFReCBLXJjMYhaTomAgxVlWH4j0iGqk=;
  b=oCuWauIrDk8Pn/+YMspWRT9cUJzBmTcEOdwKi+9txQuRmfhbwidOn4CV
   Dui6Kzzb7rwj/9eHcEmADkM4awBpm8+SsN4FOkidemmTI24cdutRo0Vs6
   F8HT8H0hV7bfqfe66wUYxQQ+THwaGriBbgvbpsNgKMaPdG2DUDZCOCJyH
   /uLJBgIfp3G7Qyh5+vO3PlTu+Q6DpNN9uLBUAQ5UOycEKeaUMq80p5d1l
   I+LFvMFM9L72YY3Fj8Pqo39vYK7Pvbix7rzLcKEpXzBJ24peFxZqcFwnk
   IrdmiPy/sSE6qhBTtgjv/n4d87Gx/OsGqyfHoIMrHsNo9xZhnuRd7xKgo
   g==;
X-CSE-ConnectionGUID: 6NeqlidUSseBCg2HarTfYQ==
X-CSE-MsgGUID: RCXhNIr7SVCWf1rfIzf2ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23050523"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23050523"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:14:45 -0700
X-CSE-ConnectionGUID: bosgiiEqTdiFoSdyUr+9Sw==
X-CSE-MsgGUID: sqr9FxHSQSeE7n0KzNcomw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58900677"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jul 2024 02:14:31 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYiw9-000shg-1C;
	Tue, 30 Jul 2024 09:14:29 +0000
Date: Tue, 30 Jul 2024 17:14:09 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	josef@toxicpanda.com, bernd.schubert@fastmail.fm,
	laoar.shao@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
Message-ID: <202407301619.Mja5LwBe-lkp@intel.com>
References: <20240730002348.3431931-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730002348.3431931-3-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v6.11-rc1 next-20240730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-add-optional-kernel-enforced-timeout-for-requests/20240730-085106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20240730002348.3431931-3-joannelkoong%40gmail.com
patch subject: [PATCH v2 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
config: i386-buildonly-randconfig-006-20240730 (https://download.01.org/0day-ci/archive/20240730/202407301619.Mja5LwBe-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407301619.Mja5LwBe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407301619.Mja5LwBe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fuse/sysctl.c:30:26: error: too many arguments provided to function-like macro invocation
      30 | int fuse_sysctl_register(void)
         |                          ^
   fs/fuse/fuse_i.h:1501:9: note: macro 'fuse_sysctl_register' defined here
    1501 | #define fuse_sysctl_register()          (0)
         |         ^
>> fs/fuse/sysctl.c:30:25: error: expected ';' after top level declarator
      30 | int fuse_sysctl_register(void)
         |                         ^
         |                         ;
   fs/fuse/sysctl.c:38:29: error: too many arguments provided to function-like macro invocation
      38 | void fuse_sysctl_unregister(void)
         |                             ^
   fs/fuse/fuse_i.h:1502:9: note: macro 'fuse_sysctl_unregister' defined here
    1502 | #define fuse_sysctl_unregister()        do { } while (0)
         |         ^
>> fs/fuse/sysctl.c:38:6: error: variable has incomplete type 'void'
      38 | void fuse_sysctl_unregister(void)
         |      ^
   fs/fuse/sysctl.c:38:28: error: expected ';' after top level declarator
      38 | void fuse_sysctl_unregister(void)
         |                            ^
         |                            ;
   5 errors generated.


vim +30 fs/fuse/sysctl.c

    29	
  > 30	int fuse_sysctl_register(void)
    31	{
    32		fuse_table_header = register_sysctl("fs/fuse", fuse_sysctl_table);
    33		if (!fuse_table_header)
    34			return -ENOMEM;
    35		return 0;
    36	}
    37	
  > 38	void fuse_sysctl_unregister(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

