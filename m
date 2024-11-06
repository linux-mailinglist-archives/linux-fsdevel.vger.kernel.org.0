Return-Path: <linux-fsdevel+bounces-33813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFC39BF5C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A54283E71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D52208988;
	Wed,  6 Nov 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNijy397"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C220820D;
	Wed,  6 Nov 2024 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919411; cv=none; b=nlTDxrDmlQKqH6ZyYVyKIMeH+dMxOMHxq1HJ2rqzTxG3ngN/kR8e2VY2HzLpGNaSTD3TuZFFx7n7NOZj8zZCTAWNe/GNAiZji6A7rbJnMsyW7wtAeAiPmr8VV+7bQ247gk90eNSkhEzZH1oPMACsTiHeaaYeDKfwe6oTeBlAmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919411; c=relaxed/simple;
	bh=hyMv01gLmOo95GlTaKcxVke3e6gveNY0nSXI8qWLs/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkRqu9ANopvElSABGMx6hDBGhXusEq3DLihVusoxQDrlTOhmZKw7kWh77THx4B2p9UrYYeBeNjLbkVr/GcwejgGCwFqLSfDhhqOZ2qxVcNR1BaCN064tRNPlUvzAMzFr2GYm4Tq3M5fET2z5D6phPGgoGCNXy52hGQUgC5NshEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNijy397; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730919410; x=1762455410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hyMv01gLmOo95GlTaKcxVke3e6gveNY0nSXI8qWLs/U=;
  b=nNijy397f7M5gzMgCSRjgyuyX2sZ1owdmEQm7DO9SYh5kSF9PwBeWBQR
   Gn4qPqfQw7dc37+04rPDrY1byDfh1Qsf3f20Sw+O5YNJU29Uq0/KVJtH8
   xpz58CLhn8ePWeItGsVrFyoPAp4AhwtPFb0cl2IJj/CF49MdY7vl6FBms
   f+kaMGBaFwJOgm5mnBnXAfQCxxbzmv+nYXDbbhL+zA89cVf+z1l4t6vNV
   uasxrPtXcapH1eamk2c7UxH01PYjwIMmsBSMJVwcHnGlxMjW+7nEOD62f
   7+IwbRnu5EsShfSry1R4or+Jut5Yx0nD6FM2R/yQJHmQCLQrQfQTvYfM4
   A==;
X-CSE-ConnectionGUID: 5yglTmrqR0e1PG9eYOu54g==
X-CSE-MsgGUID: 5zlORu1qRFiJuKn3pya3ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="41357896"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="41357896"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:56:49 -0800
X-CSE-ConnectionGUID: x7Xr4cpgR3+Y1QCOQpWbtg==
X-CSE-MsgGUID: ux6hEzz2S0iV5lh/+fFXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89289554"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Nov 2024 10:56:32 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8lCg-000pJS-1e;
	Wed, 06 Nov 2024 18:56:30 +0000
Date: Thu, 7 Nov 2024 02:56:30 +0800
From: kernel test robot <lkp@intel.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, brauner@kernel.org,
	amir73il@gmail.com, hu1.chen@intel.com
Cc: oe-kbuild-all@lists.linux.dev, miklos@szeredi.hu,
	malini.bhandaru@intel.com, tim.c.chen@intel.com,
	mikko.ylinen@intel.com, linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH overlayfs-next v3 1/4] cred: Add a light version of
 override/revert_creds()
Message-ID: <202411070234.EOrhSGRU-lkp@intel.com>
References: <20241105193514.828616-2-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105193514.828616-2-vinicius.gomes@intel.com>

Hi Vinicius,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20241105]
[also build test WARNING on v6.12-rc6]
[cannot apply to brauner-vfs/vfs.all linus/master v6.12-rc6 v6.12-rc5 v6.12-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vinicius-Costa-Gomes/cred-Add-a-light-version-of-override-revert_creds/20241106-033748
base:   next-20241105
patch link:    https://lore.kernel.org/r/20241105193514.828616-2-vinicius.gomes%40intel.com
patch subject: [PATCH overlayfs-next v3 1/4] cred: Add a light version of override/revert_creds()
config: x86_64-randconfig-121-20241106 (https://download.01.org/0day-ci/archive/20241107/202411070234.EOrhSGRU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070234.EOrhSGRU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070234.EOrhSGRU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/cred.c:104:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cred.c:104:9: sparse:    struct cred *
   kernel/cred.c:104:9: sparse:    struct cred const [noderef] __rcu *
   kernel/cred.c:105:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cred.c:105:9: sparse:    struct cred *
   kernel/cred.c:105:9: sparse:    struct cred const [noderef] __rcu *
   kernel/cred.c:121:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic64_t const [usertype] *v @@     got struct atomic64_t const [noderef] __rcu * @@
   kernel/cred.c:121:9: sparse:     expected struct atomic64_t const [usertype] *v
   kernel/cred.c:121:9: sparse:     got struct atomic64_t const [noderef] __rcu *
   kernel/cred.c:124:22: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/cred.c:127:17: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/cred.c:218:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] __rcu *cred @@
   kernel/cred.c:218:13: sparse:     expected struct cred const *old
   kernel/cred.c:218:13: sparse:     got struct cred const [noderef] __rcu *cred
   kernel/cred.c:305:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] __rcu *cred @@
   kernel/cred.c:305:47: sparse:     expected struct cred const *cred
   kernel/cred.c:305:47: sparse:     got struct cred const [noderef] __rcu *cred
   kernel/cred.c:305:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *real_cred @@     got struct cred const * @@
   kernel/cred.c:305:30: sparse:     expected struct cred const [noderef] __rcu *real_cred
   kernel/cred.c:305:30: sparse:     got struct cred const *
   kernel/cred.c:306:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic64_t const [usertype] *v @@     got struct atomic64_t const [noderef] __rcu * @@
   kernel/cred.c:306:17: sparse:     expected struct atomic64_t const [usertype] *v
   kernel/cred.c:306:17: sparse:     got struct atomic64_t const [noderef] __rcu *
   kernel/cred.c:344:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *real_cred @@     got struct cred const * @@
   kernel/cred.c:344:32: sparse:     expected struct cred const [noderef] __rcu *real_cred
   kernel/cred.c:344:32: sparse:     got struct cred const *
   kernel/cred.c:395:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] __rcu *real_cred @@
   kernel/cred.c:395:38: sparse:     expected struct cred const *old
   kernel/cred.c:395:38: sparse:     got struct cred const [noderef] __rcu *real_cred
   kernel/cred.c:400:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/cred.c:400:9: sparse:    struct cred const [noderef] __rcu *
   kernel/cred.c:400:9: sparse:    struct cred const *
   kernel/cred.c:519:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *override @@     got struct cred const [noderef] __rcu *cred @@
   kernel/cred.c:519:46: sparse:     expected struct cred const *override
   kernel/cred.c:519:46: sparse:     got struct cred const [noderef] __rcu *cred
   kernel/cred.c:301:19: sparse: sparse: dereference of noderef expression
   kernel/cred.c: note: in included file:
>> include/linux/cred.h:182:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *old @@     got struct cred const [noderef] __rcu *cred @@
   include/linux/cred.h:182:41: sparse:     expected struct cred const *old
   include/linux/cred.h:182:41: sparse:     got struct cred const [noderef] __rcu *cred

vim +182 include/linux/cred.h

   174	
   175	/*
   176	 * Override creds without bumping reference count. Caller must ensure
   177	 * reference remains valid or has taken reference. Almost always not the
   178	 * interface you want. Use override_creds()/revert_creds() instead.
   179	 */
   180	static inline const struct cred *override_creds_light(const struct cred *override_cred)
   181	{
 > 182		const struct cred *old = current->cred;
   183	
   184		rcu_assign_pointer(current->cred, override_cred);
   185		return old;
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

