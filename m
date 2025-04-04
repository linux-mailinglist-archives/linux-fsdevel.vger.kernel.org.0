Return-Path: <linux-fsdevel+bounces-45770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A51A7BE8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF61189948D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E721F239B;
	Fri,  4 Apr 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTn0bPkJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC01CEAB2;
	Fri,  4 Apr 2025 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775117; cv=none; b=rjLH4EaI8BiEn/L5nDRixOlZkpEuVtbAbB3DHGEkwDEhsYWNMxcLQtUy9Of4Gfzge2aI4wVe1IpKrTrDNmC0dilcKhkF4Wi1z6py+vxNp428Fb678Bq7iF1gTFq6KqFGW0EUA58p2Fosn1Ibn9s7hVQ6uhMKuARHM/oMHjVY6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775117; c=relaxed/simple;
	bh=NG7H7hLS4WQavrvWJPizCU0NvDUAAmaYN/JZ7/I5PN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnhSqfHIMd0F/n7ySAPqKCWkDmS0OARIe7KbfryzcS17nNR88md59D1/2qS9ZM50Ly5zimBMXC300CTmwk3rresABk6cVY7mdC3R/Ce6QVXW+jIg/p49SGvEf+MZCXlpdwKrelR8HCEhfxehIpxQiz09mEXpYu79CnU/FB9oHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTn0bPkJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743775114; x=1775311114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NG7H7hLS4WQavrvWJPizCU0NvDUAAmaYN/JZ7/I5PN4=;
  b=hTn0bPkJyAeMWAx4OFS+4Xd5yFNYpb/1tuXfCW4OTCgP/xeMOehSpu5L
   0lfbFouU/6BFkOW0U/y8VhYoEha2UygdWF6ao/DIorbgyP4GrPYFa5yYJ
   k56D646P6axwYRRIniRyDI599CIdsb9X6ZDsnDgaaqHdjLFFji4oExLHk
   sS+uR+yFaIfJtIpfrdQcWD3+bgM/Jo0aw3hRZ3G6FbvUcBI262yA7h5iA
   hT877O6AXKFr3k2y+EAA1jgAp/ZLx7WpjIYIN5fJ2SWaSjOqdMml67yEt
   MJJDu3sFlHGFdfJUoTIivz+wJ7fS1xXnHRCDCfhwcH8tZGR+rtxn01sX9
   Q==;
X-CSE-ConnectionGUID: xusNnNDHTQCEyqFtcHXi6Q==
X-CSE-MsgGUID: dclFPhzYTTmD1Bed3CjQYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="45232313"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="45232313"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 06:58:34 -0700
X-CSE-ConnectionGUID: XOMIdkoDTHShP7SLQujMJA==
X-CSE-MsgGUID: +7NvfFxGQFSbrm+JYdjdRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127256509"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Apr 2025 06:58:27 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0hYu-0001H5-2T;
	Fri, 04 Apr 2025 13:58:24 +0000
Date: Fri, 4 Apr 2025 21:58:06 +0800
From: kernel test robot <lkp@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, willy@infradead.org,
	jack@suse.cz, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
	ming.li@zohomail.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com,
	huang.ying.caritas@gmail.com, yaoxt.fnst@fujitsu.com,
	peterz@infradead.org, gregkh@linuxfoundation.org,
	quic_jjohnson@quicinc.com, ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
	mika.westerberg@linux.intel.com, akpm@linux-foundation.org,
	gourry@gourry.net, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 2/4] cxl: Update Soft Reserved resources upon region
 creation
Message-ID: <202504042103.wFCRBR7K-lkp@intel.com>
References: <20250403183315.286710-3-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403183315.286710-3-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build errors:

[auto build test ERROR on aae0594a7053c60b82621136257c8b648c67b512]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/kernel-resource-Provide-mem-region-release-for-SOFT-RESERVES/20250404-023601
base:   aae0594a7053c60b82621136257c8b648c67b512
patch link:    https://lore.kernel.org/r/20250403183315.286710-3-terry.bowman%40amd.com
patch subject: [PATCH v3 2/4] cxl: Update Soft Reserved resources upon region creation
config: hexagon-randconfig-001-20250404 (https://download.01.org/0day-ci/archive/20250404/202504042103.wFCRBR7K-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250404/202504042103.wFCRBR7K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504042103.wFCRBR7K-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cxl/core/suspend.c:7:
>> drivers/cxl/cxlpci.h:126:2: error: call to undeclared function 'pcie_capability_read_word'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
           ^
   1 error generated.


vim +/pcie_capability_read_word +126 drivers/cxl/cxlpci.h

e0c818e00443ce Robert Richter 2024-02-16  116  
4d07a05397c8c1 Dave Jiang     2023-12-21  117  /*
4d07a05397c8c1 Dave Jiang     2023-12-21  118   * CXL v3.0 6.2.3 Table 6-4
4d07a05397c8c1 Dave Jiang     2023-12-21  119   * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
4d07a05397c8c1 Dave Jiang     2023-12-21  120   * mode, otherwise it's 68B flits mode.
4d07a05397c8c1 Dave Jiang     2023-12-21  121   */
4d07a05397c8c1 Dave Jiang     2023-12-21  122  static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
4d07a05397c8c1 Dave Jiang     2023-12-21  123  {
4d07a05397c8c1 Dave Jiang     2023-12-21  124  	u16 lnksta2;
4d07a05397c8c1 Dave Jiang     2023-12-21  125  
4d07a05397c8c1 Dave Jiang     2023-12-21 @126  	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
4d07a05397c8c1 Dave Jiang     2023-12-21  127  	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
4d07a05397c8c1 Dave Jiang     2023-12-21  128  }
4d07a05397c8c1 Dave Jiang     2023-12-21  129  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

