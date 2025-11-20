Return-Path: <linux-fsdevel+bounces-69272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C90B6C76301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 21:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E798E4E1DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3696C34E750;
	Thu, 20 Nov 2025 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gd6+ReOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE333D6E6;
	Thu, 20 Nov 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670142; cv=none; b=IqvotWF1YfhJIMXgq+4bTrUoh+kt7qd5M0GJiHwG/yHx3qJJLLKxAn9erW4Yrt5BI1YHjNS/PG61OqQgGPjalE5CMjk0yOL/TBqukSOq8M2UEZZiEwqCqOnaFjjG5KWMsSGUDE4QQnNkcGpGbwDs1pfBAXiISeHB/m0Z/YSUc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670142; c=relaxed/simple;
	bh=IIjNXmxsCQvExGI6pwxUj0v63rRpN+xaKbXaacnUje0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T10ODCEb11YPYN24M36wt40XuiOUAq1hzMlDqfuxIrKY3w8YWW0tBBZM96IBJ0fP6tdJEjlErWTGd8Ia0SEFqCO5zP3hLL45514ZELFsT64D2ub43zdT7WSzTNe0dCbUU26+XuS8CrKGY2a+26OF/xyey3MvJn7c1CPvYBie8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gd6+ReOT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763670142; x=1795206142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IIjNXmxsCQvExGI6pwxUj0v63rRpN+xaKbXaacnUje0=;
  b=gd6+ReOTj5EZn2Mh9Bv2vXwEtMNLi+rm+7R4EOG8rGQXxYjVp3bAhs4g
   abfmh3Z2hBP0sZDOAc/dMqvwMxycxtnr+5Lc3KkLpyHR1j85hY8elEWJo
   L9WlbpZsx9u9Ft91x2GlxqJNyb6DW/txoGCjRVkAK9xz7Tv88ns3Wb98/
   /EmFM+BYKwwdOsewoW6njedF90Ok9tq7sK4lBng43sFpS2u6hYxccvdFG
   tuX3bSusJaCcS3od5jJvZOIsWFMZvRaYUTNRImFrid60JiOTe/r68R+tl
   yFcWEmI+XTn7YB9Fcjw9kON0hjv/6I5s9mQ3O/U5Ew/n1MenBAnd63bt+
   g==;
X-CSE-ConnectionGUID: Ot8590eNSMSrDwFNMY7yYg==
X-CSE-MsgGUID: 3UrrP/KJQY+9r8GrqgeeSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="77224512"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="77224512"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 12:22:21 -0800
X-CSE-ConnectionGUID: 6C1LP+SMTQS2yG2jUAy5QA==
X-CSE-MsgGUID: xvx7Lhn0RaS+CqXzcboOtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="222123473"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2025 12:22:14 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMBAR-0004Wx-1T;
	Thu, 20 Nov 2025 20:22:11 +0000
Date: Fri, 21 Nov 2025 04:21:51 +0800
From: kernel test robot <lkp@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg KH <greg@kroah.com>,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 6/9] cxl/region: Add register_dax flag to defer DAX
 setup
Message-ID: <202511210343.c0vb4NRc-lkp@intel.com>
References: <20251120031925.87762-7-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120031925.87762-7-Smita.KoralahalliChannabasappa@amd.com>

Hi Smita,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 211ddde0823f1442e4ad052a2f30f050145ccada]

url:    https://github.com/intel-lab-lkp/linux/commits/Smita-Koralahalli/dax-hmem-e820-resource-Defer-Soft-Reserved-insertion-until-hmem-is-ready/20251120-112457
base:   211ddde0823f1442e4ad052a2f30f050145ccada
patch link:    https://lore.kernel.org/r/20251120031925.87762-7-Smita.KoralahalliChannabasappa%40amd.com
patch subject: [PATCH v4 6/9] cxl/region: Add register_dax flag to defer DAX setup
config: sparc64-randconfig-6002-20251120 (https://download.01.org/0day-ci/archive/20251121/202511210343.c0vb4NRc-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511210343.c0vb4NRc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511210343.c0vb4NRc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/cxl/core/region.c:2544 function parameter 'register_dax' not described in 'devm_cxl_add_region'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

