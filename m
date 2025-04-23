Return-Path: <linux-fsdevel+bounces-47062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD4BA98376
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54D77A4B1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28FF284B4E;
	Wed, 23 Apr 2025 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDF2gUzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3527466A;
	Wed, 23 Apr 2025 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396617; cv=none; b=DMPPlqtcSqmZDMqDwNl6hryMt64Bd/X0Dt9xSuvOzJUirdFWASbtq8yZLqzt4MuMb/OGrAtPQ3R5Vtzm+u37mulkvolmbOMutWnTnWFlENz/xozUol3P3ckpmVaLroigZQKAWgm4Si3ipulP1sjGglSwGQtTZuO4n8tKsMFULeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396617; c=relaxed/simple;
	bh=+k9yqO/s4OaNqrko4uLFiQ6t4We61L1bjrE/LVw5Jcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR2soVJS6LUlRuvFrUyHaB85oi8SE3d2cleQITx6zK3uHuCRyCCvyqo6M770rJU+DVR7ijgJ1mbzLIHv9WTkPTNj6Yp5mmpDTf9q9w8JMOoI9FDaZQfrdCpvUlhoX0Oh07sadODjX8bZ1yb6XrKRecUcoKlor9d3mz3RME64cKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDF2gUzC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745396615; x=1776932615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+k9yqO/s4OaNqrko4uLFiQ6t4We61L1bjrE/LVw5Jcg=;
  b=CDF2gUzCXstymEhEI/jUMZQ9tFpPdLZTm5Eu9vVAFCUbjDY2If1xOIAB
   4vV7QXtw7FGRW/9zm0w6KViA60/T1go1r34fQcPk/oXLq/JOofA8O6eUg
   1VOqRKRCRxLZlXfe39EYuqVa+H52DzCv/zdt/KCC0Fy5tlTh82dFy4gWY
   qe55LeDS5KWxf9FBG75zDxB+RFFHtdqn5EvkTAMRyZ75VlIbFhVgJvg5/
   gQgQK9D15yQkJjkfphRAtTfEZqqU05K8Wy0H1+dtJa64Sv4RavZbYUOJK
   VvgiojJJZD0fZAL/FpQsWmfZ8JraZnGW6yaRoLUaSw7hvc+OZVzYwmGEa
   A==;
X-CSE-ConnectionGUID: Zo21e1MQQKuDIPAb/nrgMg==
X-CSE-MsgGUID: BCgFH1cMSI2UwkPgzfkrNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50809243"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="50809243"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 01:22:04 -0700
X-CSE-ConnectionGUID: /3T1SlrDSG+PlKYOBY46FQ==
X-CSE-MsgGUID: mcZ7cnjoRSuOafvzc1VPVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137114903"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Apr 2025 01:22:01 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7VMl-0001jd-0G;
	Wed, 23 Apr 2025 08:21:59 +0000
Date: Wed, 23 Apr 2025 16:21:32 +0800
From: kernel test robot <lkp@intel.com>
To: xu xin <xu.xin.sc@gmail.com>, xu.xin16@zte.com.cn
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, david@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, wang.yaxin@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH RESEND 6/6] memcontrol-v1: add ksm_profit in
 cgroup/memory.ksm_stat
Message-ID: <202504231523.owjrO2Yy-lkp@intel.com>
References: <20250422112251.3231599-1-xu.xin16@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422112251.3231599-1-xu.xin16@zte.com.cn>

Hi xu,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.15-rc3 next-20250422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xu-xin/memcontrol-rename-mem_cgroup_scan_tasks/20250422-231623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250422112251.3231599-1-xu.xin16%40zte.com.cn
patch subject: [PATCH RESEND 6/6] memcontrol-v1: add ksm_profit in cgroup/memory.ksm_stat
config: i386-buildonly-randconfig-006-20250423 (https://download.01.org/0day-ci/archive/20250423/202504231523.owjrO2Yy-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250423/202504231523.owjrO2Yy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504231523.owjrO2Yy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ksm_process_profit
   >>> referenced by memcontrol-v1.c:1843 (mm/memcontrol-v1.c:1843)
   >>>               mm/memcontrol-v1.o:(evaluate_memcg_ksm_stat) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

