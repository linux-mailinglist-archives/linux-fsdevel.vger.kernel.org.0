Return-Path: <linux-fsdevel+bounces-6486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90F81876C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 13:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEDC285F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 12:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCA179B0;
	Tue, 19 Dec 2023 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXHt0E33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100518E25;
	Tue, 19 Dec 2023 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702988746; x=1734524746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nOywJRc0wAtqCFpYw86gMOujKnRir0lc3ARZNSoc0P0=;
  b=EXHt0E33Mur7Hm+9MSxKx8PLY2mWHt/CMiUPt5m8YCinSU1PEzdrYxMz
   TzPvgUZ5oNd+dUI0H8E+JvDdcVm/utHWjFnzFdiP4oW4oGZCIl1ggSDo8
   86o6vR4xhet9ZlP3AThb/EHcgm0HoDkNMME8mjS9Gya7vUmZUE3f2bkkk
   uoik5DAP2Sn9GwLWXtE2ZFwSnLc4zCBP7skA7NwDGnf9lnOzOTw5Xvjao
   L7b/NQOf2rDR7ZescnjATHmUhdOojmO1qgGz5lJUKoYy46IyWLhL5zQpJ
   N9vP9TQWx+vNannkLSydxaT4tujoVT3tJJ7u2K44up6S5Tt4ltAB01BJq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2878899"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2878899"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 04:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="17589275"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 Dec 2023 04:25:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFZAE-0005Ip-39;
	Tue, 19 Dec 2023 12:25:34 +0000
Date: Tue, 19 Dec 2023 20:24:56 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com,
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com,
	honggyu.kim@sk.com, vtavarespetr@micron.com, peterz@infradead.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com
Subject: Re: [PATCH v4 10/11] mm/mempolicy: add the mbind2 syscall
Message-ID: <202312192014.47Qm5xxc-lkp@intel.com>
References: <20231218194631.21667-11-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218194631.21667-11-gregory.price@memverge.com>

Hi Gregory,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools/perf-tools]
[also build test ERROR on linus/master v6.7-rc6]
[cannot apply to perf-tools-next/perf-tools-next tip/perf/core acme/perf/core next-20231219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231219-074837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools
patch link:    https://lore.kernel.org/r/20231218194631.21667-11-gregory.price%40memverge.com
patch subject: [PATCH v4 10/11] mm/mempolicy: add the mbind2 syscall
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231219/202312192014.47Qm5xxc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312192014.47Qm5xxc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312192014.47Qm5xxc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> aarch64-linux-ld: arch/arm64/kernel/sys32.o:(.rodata+0xe58): undefined reference to `__arm64_sys_get_mbind2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

