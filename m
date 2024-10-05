Return-Path: <linux-fsdevel+bounces-31091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A197B991B46
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDDF1C20F77
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C481684A1;
	Sat,  5 Oct 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WonSDtYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512513BC0E;
	Sat,  5 Oct 2024 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728168515; cv=none; b=XU43q/Jpx7GyV3ofR2dkrzrf25NNz5RZ1XGx2L0EEksk6kfl49cmOAPvrJ6E0a8ZxGauuMWupgpADab+sRWqEx5bVcnzFUNgjvQOpD192pmD/d90qlpvgcWqDcg0b+JRwJly+LL2iIB1r4RMnJSnFXdaDpcK6FJ5DeIAJI9Bt9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728168515; c=relaxed/simple;
	bh=fcxhcwCykS7VaBZCUXvsZKD9I3qiLo7RBBc3MRaeHgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsP9sefu6kjxL/HaKCRVkGWgSemtiTwHiicdhTVKL+yZEh/D+AAmRd7YTM1fRGKk2y4UuBoFqaf84OOOTX0W0n4CxSmygQDPaGcXN9B0QCV5ozQKaLFDyVig7IhH7NBLeU29l2R6qMHuBDT7tmQtfbtwd4G3PmOdGkoONSZrOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WonSDtYz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728168514; x=1759704514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fcxhcwCykS7VaBZCUXvsZKD9I3qiLo7RBBc3MRaeHgs=;
  b=WonSDtYzqCT3sPeDxbr4coVaxcgEz9PRUxu4ctDpMBCXvgTg1EUy6J17
   JdfPWTnmc3gTlAxD5aBfi7xgjLkvIiHRRdOlSbZu3V1EShNaJIaAc2508
   1efwT4DmsHMXawk2+BGzg1gtX7YVkoWabXWaYShwwLlkl8NzvWj+4nUAb
   Pr6Ko4fUbSEqrEqudUC2JnEoj8UrkKAARNYqmiQpsiBE7ppwrHokHzncn
   40ftmH75IeRsGMaF21DexjY8RbAHldq0qCB+ITyQ6t4G9EGarAoqiaFGQ
   fyD977m1QXdIb2d78pL9OMNCNVrJgx8+Po+tDCJdNNswZEXWsg2apwZk/
   Q==;
X-CSE-ConnectionGUID: AnewLLSZQVuD+F9p12h19Q==
X-CSE-MsgGUID: 6eQLN/AeTRqacMijOQi6HA==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="27245123"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="27245123"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 15:48:33 -0700
X-CSE-ConnectionGUID: CV2sg/NOQ72FEAJ4t9XQOA==
X-CSE-MsgGUID: jKZffiplSSihmYagvQ5lAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="79643759"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Oct 2024 15:48:29 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxDZb-0003QO-1W;
	Sat, 05 Oct 2024 22:48:27 +0000
Date: Sun, 6 Oct 2024 06:47:29 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com, Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 07/10] tmpfs: Add casefold lookup support
Message-ID: <202410060658.4QOeUy1M-lkp@intel.com>
References: <20241002234444.398367-8-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002234444.398367-8-andrealmeid@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on akpm-mm/mm-everything tytso-ext4/dev linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/libfs-Create-the-helper-function-generic_ci_validate_strict_name/20241003-074711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241002234444.398367-8-andrealmeid%40igalia.com
patch subject: [PATCH v5 07/10] tmpfs: Add casefold lookup support
config: arm-randconfig-001-20241006 (https://download.01.org/0day-ci/archive/20241006/202410060658.4QOeUy1M-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410060658.4QOeUy1M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410060658.4QOeUy1M-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shmem.c:4717:39: warning: 'shmem_ci_dentry_ops' defined but not used [-Wunused-const-variable=]
    4717 | static const struct dentry_operations shmem_ci_dentry_ops = {
         |                                       ^~~~~~~~~~~~~~~~~~~


vim +/shmem_ci_dentry_ops +4717 mm/shmem.c

  4715	
  4716	#if IS_ENABLED(CONFIG_UNICODE)
> 4717	static const struct dentry_operations shmem_ci_dentry_ops = {
  4718		.d_hash = generic_ci_d_hash,
  4719		.d_compare = generic_ci_d_compare,
  4720		.d_delete = always_delete_dentry,
  4721	};
  4722	#endif
  4723	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

