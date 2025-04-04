Return-Path: <linux-fsdevel+bounces-45756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C6A7BD0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16EE3A5DC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A51EB1AD;
	Fri,  4 Apr 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rvu9lNEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B211E5B7C;
	Fri,  4 Apr 2025 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771452; cv=none; b=YGcaR9x5wCMugANHUyei/PpmYdfDgxv147cuEqCxPXey0asrnp+KeeljxjZrSOKhi3JF5nib5ra1L0UaBT40kZA6z4DBvKQ8wk2mVLop5ec9wkNp/X6V12hnxFUWETjXZ4kZcf1w5Ivtyj5n0sIEXTe8wvpZA0nV3s3i7Q40UWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771452; c=relaxed/simple;
	bh=xyYjW+AtxZxWbV1o0CQ1AfEjiVHQH5yQ+vFkf737e4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaJU9++3Lpt8aLyabzjUvjL8qIXqP1JtISg92z6iNDAfQT+0CKEPd3IiRy6/Hjzd6y52KTVOC8aFBJFamlQNzZ9/MFF55s1sh84ZuXqfWgMoCGlweu++Bq4LU6v6+9SUYCDWPd5uVfeOseSqc4tc4kYcWZZTVfXG+4ys5S37Zzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rvu9lNEs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743771450; x=1775307450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyYjW+AtxZxWbV1o0CQ1AfEjiVHQH5yQ+vFkf737e4A=;
  b=Rvu9lNEsuKb6Mi9E2RRgu5HYMRyCURp8wKHsILdvqGgRcJ/aXaXmVpUK
   NiuQx+8HzDy8q1dR2at/oYh80PG2OJOLPv+c4GKq1MmG51FxbNz4x2cSw
   27Esuqwrm2ARqlVV/SQpH33o/XXeubcNekXlz87U1HQgztckVdSt+fKvf
   VWWTAlaJ7PnjYM7Vi2sr8McqCLTkoD7YN1nUu5FumdUY2FrCs4/KfWTKa
   Gx+zde9wQywYXFF2lAE/aK4yc1I+iQYjXVGdWlfTW/EzwO/Ln+YoXNPPk
   ocWoY8Gw/PD3Qgum8vyAfwScDtPlQ1RSYrST743e4YB8pmxFXzKalLzfF
   w==;
X-CSE-ConnectionGUID: iV+hXrcjRRylF2DyTMfDIg==
X-CSE-MsgGUID: mVxdKb1cTMe9Np7amYXYXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="56576696"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="56576696"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 05:57:29 -0700
X-CSE-ConnectionGUID: 1mEEHg4vSMmejJnBhYjM6Q==
X-CSE-MsgGUID: 8NydhknOTYy7mydb1oLAjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="158292383"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Apr 2025 05:57:22 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0gbo-0001FP-1P;
	Fri, 04 Apr 2025 12:57:20 +0000
Date: Fri, 4 Apr 2025 20:57:15 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/4] kernel/resource: Provide mem region release for
 SOFT RESERVES
Message-ID: <202504042030.Rs5G4dWd-lkp@intel.com>
References: <20250403183315.286710-2-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403183315.286710-2-terry.bowman@amd.com>

Hi Terry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aae0594a7053c60b82621136257c8b648c67b512]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/kernel-resource-Provide-mem-region-release-for-SOFT-RESERVES/20250404-023601
base:   aae0594a7053c60b82621136257c8b648c67b512
patch link:    https://lore.kernel.org/r/20250403183315.286710-2-terry.bowman%40amd.com
patch subject: [PATCH v3 1/4] kernel/resource: Provide mem region release for SOFT RESERVES
config: i386-buildonly-randconfig-003-20250404 (https://download.01.org/0day-ci/archive/20250404/202504042030.Rs5G4dWd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250404/202504042030.Rs5G4dWd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504042030.Rs5G4dWd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/resource.c:1414: warning: Function parameter or struct member 'busy_check' not described in '__release_mem_region_adjustable'
>> kernel/resource.c:1414: warning: Function parameter or struct member 'res_desc' not described in '__release_mem_region_adjustable'
>> kernel/resource.c:1414: warning: expecting prototype for release_mem_region_adjustable(). Prototype was for __release_mem_region_adjustable() instead


vim +1414 kernel/resource.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  1389  
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1390  #if defined(CONFIG_MEMORY_HOTREMOVE) || defined(CONFIG_CXL_REGION)
825f787bb49676 Toshi Kani        2013-04-29  1391  /**
825f787bb49676 Toshi Kani        2013-04-29  1392   * release_mem_region_adjustable - release a previously reserved memory region
825f787bb49676 Toshi Kani        2013-04-29  1393   * @start: resource start address
825f787bb49676 Toshi Kani        2013-04-29  1394   * @size: resource region size
825f787bb49676 Toshi Kani        2013-04-29  1395   *
825f787bb49676 Toshi Kani        2013-04-29  1396   * This interface is intended for memory hot-delete.  The requested region
825f787bb49676 Toshi Kani        2013-04-29  1397   * is released from a currently busy memory resource.  The requested region
825f787bb49676 Toshi Kani        2013-04-29  1398   * must either match exactly or fit into a single busy resource entry.  In
825f787bb49676 Toshi Kani        2013-04-29  1399   * the latter case, the remaining resource is adjusted accordingly.
825f787bb49676 Toshi Kani        2013-04-29  1400   * Existing children of the busy memory resource must be immutable in the
825f787bb49676 Toshi Kani        2013-04-29  1401   * request.
825f787bb49676 Toshi Kani        2013-04-29  1402   *
825f787bb49676 Toshi Kani        2013-04-29  1403   * Note:
825f787bb49676 Toshi Kani        2013-04-29  1404   * - Additional release conditions, such as overlapping region, can be
825f787bb49676 Toshi Kani        2013-04-29  1405   *   supported after they are confirmed as valid cases.
825f787bb49676 Toshi Kani        2013-04-29  1406   * - When a busy memory resource gets split into two entries, the code
825f787bb49676 Toshi Kani        2013-04-29  1407   *   assumes that all children remain in the lower address entry for
825f787bb49676 Toshi Kani        2013-04-29  1408   *   simplicity.  Enhance this logic when necessary.
825f787bb49676 Toshi Kani        2013-04-29  1409   */
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1410  static void __release_mem_region_adjustable(resource_size_t start,
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1411  					    resource_size_t size,
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1412  					    bool busy_check,
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1413  					    int res_desc)
825f787bb49676 Toshi Kani        2013-04-29 @1414  {
cb8e3c8b4f45e4 David Hildenbrand 2020-10-15  1415  	struct resource *parent = &iomem_resource;
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1416  	struct resource *new_res = NULL;
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1417  	bool alloc_nofail = false;
825f787bb49676 Toshi Kani        2013-04-29  1418  	struct resource **p;
825f787bb49676 Toshi Kani        2013-04-29  1419  	struct resource *res;
825f787bb49676 Toshi Kani        2013-04-29  1420  	resource_size_t end;
825f787bb49676 Toshi Kani        2013-04-29  1421  
825f787bb49676 Toshi Kani        2013-04-29  1422  	end = start + size - 1;
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1423  	if (WARN_ON_ONCE((start < parent->start) || (end > parent->end)))
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1424  		return;
825f787bb49676 Toshi Kani        2013-04-29  1425  
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1426  	/*
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1427  	 * We free up quite a lot of memory on memory hotunplug (esp., memap),
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1428  	 * just before releasing the region. This is highly unlikely to
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1429  	 * fail - let's play save and make it never fail as the caller cannot
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1430  	 * perform any error handling (e.g., trying to re-add memory will fail
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1431  	 * similarly).
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1432  	 */
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1433  retry:
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1434  	new_res = alloc_resource(GFP_KERNEL | (alloc_nofail ? __GFP_NOFAIL : 0));
825f787bb49676 Toshi Kani        2013-04-29  1435  
825f787bb49676 Toshi Kani        2013-04-29  1436  	p = &parent->child;
825f787bb49676 Toshi Kani        2013-04-29  1437  	write_lock(&resource_lock);
825f787bb49676 Toshi Kani        2013-04-29  1438  
825f787bb49676 Toshi Kani        2013-04-29  1439  	while ((res = *p)) {
825f787bb49676 Toshi Kani        2013-04-29  1440  		if (res->start >= end)
825f787bb49676 Toshi Kani        2013-04-29  1441  			break;
825f787bb49676 Toshi Kani        2013-04-29  1442  
825f787bb49676 Toshi Kani        2013-04-29  1443  		/* look for the next resource if it does not fit into */
825f787bb49676 Toshi Kani        2013-04-29  1444  		if (res->start > start || res->end < end) {
825f787bb49676 Toshi Kani        2013-04-29  1445  			p = &res->sibling;
825f787bb49676 Toshi Kani        2013-04-29  1446  			continue;
825f787bb49676 Toshi Kani        2013-04-29  1447  		}
825f787bb49676 Toshi Kani        2013-04-29  1448  
825f787bb49676 Toshi Kani        2013-04-29  1449  		if (!(res->flags & IORESOURCE_MEM))
825f787bb49676 Toshi Kani        2013-04-29  1450  			break;
825f787bb49676 Toshi Kani        2013-04-29  1451  
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1452  		if (busy_check && !(res->flags & IORESOURCE_BUSY)) {
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1453  			p = &res->child;
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1454  			continue;
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1455  		}
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1456  
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1457  		if (res_desc != IORES_DESC_NONE && res->desc != res_desc) {
825f787bb49676 Toshi Kani        2013-04-29  1458  			p = &res->child;
825f787bb49676 Toshi Kani        2013-04-29  1459  			continue;
825f787bb49676 Toshi Kani        2013-04-29  1460  		}
825f787bb49676 Toshi Kani        2013-04-29  1461  
825f787bb49676 Toshi Kani        2013-04-29  1462  		/* found the target resource; let's adjust accordingly */
825f787bb49676 Toshi Kani        2013-04-29  1463  		if (res->start == start && res->end == end) {
825f787bb49676 Toshi Kani        2013-04-29  1464  			/* free the whole entry */
825f787bb49676 Toshi Kani        2013-04-29  1465  			*p = res->sibling;
ebff7d8f270d04 Yasuaki Ishimatsu 2013-04-29  1466  			free_resource(res);
825f787bb49676 Toshi Kani        2013-04-29  1467  		} else if (res->start == start && res->end != end) {
825f787bb49676 Toshi Kani        2013-04-29  1468  			/* adjust the start */
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1469  			WARN_ON_ONCE(__adjust_resource(res, end + 1,
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1470  						       res->end - end));
825f787bb49676 Toshi Kani        2013-04-29  1471  		} else if (res->start != start && res->end == end) {
825f787bb49676 Toshi Kani        2013-04-29  1472  			/* adjust the end */
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1473  			WARN_ON_ONCE(__adjust_resource(res, res->start,
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1474  						       start - res->start));
825f787bb49676 Toshi Kani        2013-04-29  1475  		} else {
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1476  			/* split into two entries - we need a new resource */
825f787bb49676 Toshi Kani        2013-04-29  1477  			if (!new_res) {
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1478  				new_res = alloc_resource(GFP_ATOMIC);
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1479  				if (!new_res) {
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1480  					alloc_nofail = true;
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1481  					write_unlock(&resource_lock);
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1482  					goto retry;
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1483  				}
825f787bb49676 Toshi Kani        2013-04-29  1484  			}
825f787bb49676 Toshi Kani        2013-04-29  1485  			new_res->name = res->name;
825f787bb49676 Toshi Kani        2013-04-29  1486  			new_res->start = end + 1;
825f787bb49676 Toshi Kani        2013-04-29  1487  			new_res->end = res->end;
825f787bb49676 Toshi Kani        2013-04-29  1488  			new_res->flags = res->flags;
43ee493bde78da Toshi Kani        2016-01-26  1489  			new_res->desc = res->desc;
825f787bb49676 Toshi Kani        2013-04-29  1490  			new_res->parent = res->parent;
825f787bb49676 Toshi Kani        2013-04-29  1491  			new_res->sibling = res->sibling;
825f787bb49676 Toshi Kani        2013-04-29  1492  			new_res->child = NULL;
825f787bb49676 Toshi Kani        2013-04-29  1493  
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1494  			if (WARN_ON_ONCE(__adjust_resource(res, res->start,
ec62d04e3fdc4b David Hildenbrand 2020-10-15  1495  							   start - res->start)))
825f787bb49676 Toshi Kani        2013-04-29  1496  				break;
825f787bb49676 Toshi Kani        2013-04-29  1497  			res->sibling = new_res;
825f787bb49676 Toshi Kani        2013-04-29  1498  			new_res = NULL;
825f787bb49676 Toshi Kani        2013-04-29  1499  		}
825f787bb49676 Toshi Kani        2013-04-29  1500  
825f787bb49676 Toshi Kani        2013-04-29  1501  		break;
825f787bb49676 Toshi Kani        2013-04-29  1502  	}
825f787bb49676 Toshi Kani        2013-04-29  1503  
825f787bb49676 Toshi Kani        2013-04-29  1504  	write_unlock(&resource_lock);
ebff7d8f270d04 Yasuaki Ishimatsu 2013-04-29  1505  	free_resource(new_res);
825f787bb49676 Toshi Kani        2013-04-29  1506  }
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1507  #endif
e4ebc182a59bbb Nathan Fontenot   2025-04-03  1508  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

