Return-Path: <linux-fsdevel+bounces-9230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018F683F465
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 07:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5FA1C2215F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9D8D51D;
	Sun, 28 Jan 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CypHp5od"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EA8F68;
	Sun, 28 Jan 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424561; cv=none; b=Gh0JZ+uhIH+YvPYWLxqB5p4E5kU/l7HsVMcZkyul28VW7lhgTCI16PoqWwCqZUE7sDQ+9Pv5F6hIo2wLGCS3wZ7XkSN30kTR50uX0Urkxv8ZYEHE8EHRZ3FxU0R6R+JfJC9mFJ6uIlM++noHBpYkAeh2AkGHDxUgoyR96P5nTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424561; c=relaxed/simple;
	bh=Y0KyCo+35BWc8oGfVah4O/KZ+KcNek3uewoK+eI1Tos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs3RGDzbvqQ7lav/OlFwF7Sno/4XHSoB9fdMTmu+D/HHQE4vWZvcny8q2d6f5WZmt6C3dvQ6o8LKUD2kFfRhcD5tU9xr3arjiJRCHFyZRqL88n5K3IoA7937SvERkCfqTfzcX/T1Rm/5dlbi60u5ew1v1Hfnlnr6R921BvTbWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CypHp5od; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424560; x=1737960560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y0KyCo+35BWc8oGfVah4O/KZ+KcNek3uewoK+eI1Tos=;
  b=CypHp5odxgSGE289FkK/p8UOvEiteY8cMhqg/Qkf6bBiA/XezHzr8wP+
   ib0QwE8Ynaz2KvRo0wi4Y5O78Xfw2rMV0VucOd3caD7xTHzfHs5Zq6cHf
   BZF6n35hGHMAX4sFk5YJYQswztjXfDALpDV5yE5g5CINr4MhXUNVXKGcT
   vxK1+kHCgXhGpXkvAkp6z/Zpbd0xHw/Zr2cfULXwaVv+dBxdFHMYYTwUw
   oePMXr6Mr1EqapjdH5+wt0NWlTA+gh+kDtQWaN8HtTnIMLDJaOgIC5npc
   0ztRuOxSjcQf3UEiGNSWi471m7hU7m1fQv6nLQY01dzfrviKyXMJ2kgIq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2612197"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2612197"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3045776"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Jan 2024 22:49:17 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTyyg-0003Ak-1t;
	Sun, 28 Jan 2024 06:49:14 +0000
Date: Sun, 28 Jan 2024 14:48:35 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Kent Overstreet <kent.overstreet@linux.dev>, peterz@infradead.org,
	boqun.feng@gmail.com, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/4] pktcdvd: kill mutex_lock_nested() usage
Message-ID: <202401281405.72SjSYnP-lkp@intel.com>
References: <20240127020833.487907-3-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127020833.487907-3-kent.overstreet@linux.dev>

Hi Kent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on net/main net-next/main linus/master v6.8-rc1 next-20240125]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kent-Overstreet/fs-pipe-Convert-to-lockdep_cmp_fn/20240127-101832
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240127020833.487907-3-kent.overstreet%40linux.dev
patch subject: [PATCH 2/4] pktcdvd: kill mutex_lock_nested() usage
config: x86_64-randconfig-161-20240127 (https://download.01.org/0day-ci/archive/20240128/202401281405.72SjSYnP-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281405.72SjSYnP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281405.72SjSYnP-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/locking/lockdep.c: In function 'lockdep_ptr_order_cmp_fn':
>> kernel/locking/lockdep.c:4925:9: error: implicit declaration of function 'cmp_int'; did you mean 'smp_init'? [-Werror=implicit-function-declaration]
    4925 |  return cmp_int((unsigned long) a, (unsigned long) b);
         |         ^~~~~~~
         |         smp_init
   cc1: some warnings being treated as errors


vim +4925 kernel/locking/lockdep.c

  4920	
  4921	#ifdef CONFIG_PROVE_LOCKING
  4922	int lockdep_ptr_order_cmp_fn(const struct lockdep_map *a,
  4923				     const struct lockdep_map *b)
  4924	{
> 4925		return cmp_int((unsigned long) a, (unsigned long) b);
  4926	}
  4927	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

