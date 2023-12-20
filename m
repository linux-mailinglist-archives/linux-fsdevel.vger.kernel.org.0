Return-Path: <linux-fsdevel+bounces-6537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1468195EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 01:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616891C24DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9523DD;
	Wed, 20 Dec 2023 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPBvIxB6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F7F9FB;
	Wed, 20 Dec 2023 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703033324; x=1734569324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XBIC58myc3ASs9hyCERLWBAimfb3eQYpoSIUk/hXRFI=;
  b=NPBvIxB6udD+HyUi24EZ3ZHtCXU8L37k+YMRksFFANRIoRgjh78qhBwv
   qz+xoj49eBQJflp28HDcaSu7hVDC3kpKS6WOZ6u5GtVZuwZ5FlXNZzuGf
   9NwziIw6bsQUCFfrw/LJt8PHuwuj4guV2WpWjEpY3Xmq4kcHKEQEnBKX0
   cwQUS9PZwUMAV1GhS8FY9EhJaEnXJcJYm5u1QAPiObEa80j7i7S8YaVOd
   KePiBhuPZaWtVRpOfRsgF4ulrXuW439sgYwkHcgMFpnaIW2xVspFfj5Fq
   ruC943DD8EJcqzc88FlZIAjp1mZ+LCebKkbGx1RGkHKDApGNoBxgN1pKE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2961325"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2961325"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 16:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="769409417"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="769409417"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Dec 2023 16:48:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFklC-00068l-0C;
	Wed, 20 Dec 2023 00:48:30 +0000
Date: Wed, 20 Dec 2023 08:48:00 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
	tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com,
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com,
	honggyu.kim@sk.com, vtavarespetr@micron.com, peterz@infradead.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com
Subject: Re: [PATCH v4 10/11] mm/mempolicy: add the mbind2 syscall
Message-ID: <202312200802.cGZtboPs-lkp@intel.com>
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
config: arm64-randconfig-003-20231219 (https://download.01.org/0day-ci/archive/20231220/202312200802.cGZtboPs-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 5ac12951b4e9bbfcc5791282d0961ec2b65575e9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312200802.cGZtboPs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200802.cGZtboPs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __arm64_sys_get_mbind2
   >>> referenced by sys32.c
   >>>               arch/arm64/kernel/sys32.o:(compat_sys_call_table) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

