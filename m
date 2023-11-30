Return-Path: <linux-fsdevel+bounces-4403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 926297FF244
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59871C206FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B325100F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avlGWeL7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCFE10D0;
	Thu, 30 Nov 2023 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701353098; x=1732889098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xqtTZvY053veljR4ETMpWFPpHyKU0+OBKnIK2FZ1Hl0=;
  b=avlGWeL7GR+bfL4sLs8D28WpOgVx3rntBWjjPBJdKGaYjItkV057D1h2
   KOMi7hYeHo8KWjIxpO48etDu3gzRVLOK+DyZ9xuI1jhqvQ+Nkua7GL0Dn
   IJlPSXhbEBn7THFH8C90SnkLy7IIrkeaZfnQZgVEGt/pXL291otCBF3jH
   dxwFI85OuM2xLn/6Fo8uOp2ErW9TnNjE8J/LWkuJfrkHHS7gJFmC8slrK
   ZPvJk9lgsOEmFdHxjceNmeS67A3UIFaWUEzdM/rkOGjdtNXr4xmj8jCky
   sZFXw+s3VllVS7etz+dm0bDt4xrcgg+SSMumLp8cPOMra2AqZJgRCYqja
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="226591"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="226591"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1016636131"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="1016636131"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2023 06:03:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8hdz-00025l-1H;
	Thu, 30 Nov 2023 14:03:55 +0000
Date: Thu, 30 Nov 2023 22:03:41 +0800
From: kernel test robot <lkp@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	alex.williamson@redhat.com, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jasowang@redhat.com,
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
	joro@8bytes.org, kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 13/16] iommu: observability of the IOMMU allocations
Message-ID: <202311302108.WERv9oSO-lkp@intel.com>
References: <20231128204938.1453583-14-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128204938.1453583-14-pasha.tatashin@soleen.com>

Hi Pasha,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on awilliam-vfio/for-linus linus/master v6.7-rc3]
[cannot apply to joro-iommu/next awilliam-vfio/next next-20231130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pasha-Tatashin/iommu-vt-d-add-wrapper-functions-for-page-allocations/20231129-054908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231128204938.1453583-14-pasha.tatashin%40soleen.com
patch subject: [PATCH 13/16] iommu: observability of the IOMMU allocations
config: sparc64-randconfig-r054-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302108.WERv9oSO-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311302108.WERv9oSO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311302108.WERv9oSO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/iommufd/iova_bitmap.c:11:
   drivers/iommu/iommufd/../iommu-pages.h: In function '__iommu_alloc_account':
>> drivers/iommu/iommufd/../iommu-pages.h:29:48: error: 'NR_IOMMU_PAGES' undeclared (first use in this function)
      29 |         mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, pgcnt);
         |                                                ^~~~~~~~~~~~~~
   drivers/iommu/iommufd/../iommu-pages.h:29:48: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iommu/iommufd/../iommu-pages.h: In function '__iommu_free_account':
   drivers/iommu/iommufd/../iommu-pages.h:41:48: error: 'NR_IOMMU_PAGES' undeclared (first use in this function)
      41 |         mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, -pgcnt);
         |                                                ^~~~~~~~~~~~~~


vim +/NR_IOMMU_PAGES +29 drivers/iommu/iommufd/../iommu-pages.h

    13	
    14	/*
    15	 * All page allocation that are performed in the IOMMU subsystem must use one of
    16	 * the functions below.  This is necessary for the proper accounting as IOMMU
    17	 * state can be rather large, i.e. multiple gigabytes in size.
    18	 */
    19	
    20	/**
    21	 * __iommu_alloc_account - account for newly allocated page.
    22	 * @pages: head struct page of the page.
    23	 * @order: order of the page
    24	 */
    25	static inline void __iommu_alloc_account(struct page *pages, int order)
    26	{
    27		const long pgcnt = 1l << order;
    28	
  > 29		mod_node_page_state(page_pgdat(pages), NR_IOMMU_PAGES, pgcnt);
    30	}
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

