Return-Path: <linux-fsdevel+bounces-73182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E6D108C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 05:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 470F2300EDE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 04:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82730C615;
	Mon, 12 Jan 2026 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGIivZfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEC30BF6F;
	Mon, 12 Jan 2026 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191302; cv=none; b=mOrClQF0a/ukYA8/z6TdnjyhazF3ms0B/SEKkqoP6PQ8Bpw3gol8Bu0SIgRZCX6rq8uViII3406POkcD77LtYzu6bVYTRgJrmkdxaEfelV5vYotbfc//ojuV4Q80MyqwKfjOd0uDxMySR7XSA/vjLbRpNeIWX7+gnJxgrFzZupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191302; c=relaxed/simple;
	bh=lu1CRJQHNLT2lEZm8W8z6eDoycBU4B0tgxfCG2tr0rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhOq3LdPLV29W7GNysFe1GCSb0E9O0kX4+MOV5BYqv32DwVSLtU0BTW+MHZJeObfpXamgSuB5UtGStbRCKeb1p3TziSNlR95y7OYbyRk2P1gYLYuzy4hL+hbUrZF4ecqOgKpvmEzeXifY6WKKKRs/yhzI0vMgVjzZoY9rklZkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGIivZfh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768191300; x=1799727300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lu1CRJQHNLT2lEZm8W8z6eDoycBU4B0tgxfCG2tr0rk=;
  b=FGIivZfhxzM5fSQXJsbrqgwKrb68bOvFj/3AumxZimqIeHXk2eIXZuce
   YlZYgBGWpQ16X8g/phuOt2ufgh1qXxyDsU1KLLdQAIOdASemIPhZ3kDs9
   J2G4dZ5jqba5EtxcJ54/4gCXMkKvbuPzBToaaIMFdJlsL6H9VqDzR9wZ0
   3E1/l2aTl6upISqN4hplgyahOrCbAvUFzlknnuMO70bbCPPO3qt20jtxl
   LicwiuzkQRCjxt+12PSAhqlyP05Um++P5n8X2R0/+qHN3nYshrPa0y/V8
   lf0shxVM9CDrZjjVOxdGvlkwnqcjbUl2pcgCpeeXlkZD0nkj01vwc8yie
   g==;
X-CSE-ConnectionGUID: trCtvpyjQ/uBLWml4WeKXw==
X-CSE-MsgGUID: 6jOWp+kbQGea1MMv5fB+FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69514391"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69514391"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 20:14:59 -0800
X-CSE-ConnectionGUID: 6VfZfiHYQOK0o9Ts92d6mQ==
X-CSE-MsgGUID: anpd0ddSQlea4YLXWjlPyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="241518095"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Jan 2026 20:14:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vf9KN-00000000CyG-2KZV;
	Mon, 12 Jan 2026 04:14:51 +0000
Date: Mon, 12 Jan 2026 12:14:26 +0800
From: kernel test robot <lkp@intel.com>
To: Francois Dugast <francois.dugast@intel.com>,
	intel-xe@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [PATCH v4 3/7] fs/dax: Use free_zone_device_folio_prepare()
 helper
Message-ID: <202601121151.afcnEvLk-lkp@intel.com>
References: <20260111205820.830410-4-francois.dugast@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111205820.830410-4-francois.dugast@intel.com>

Hi Francois,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-tip/drm-tip]
[also build test WARNING on linus/master v6.19-rc4 next-20260109]
[cannot apply to drm-misc/drm-misc-next akpm-mm/mm-everything powerpc/topic/ppc-kvm pci/next pci/for-linus akpm-mm/mm-nonmm-unstable brauner-vfs/vfs.all daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francois-Dugast/mm-zone_device-Add-order-argument-to-folio_free-callback/20260112-050347
base:   https://gitlab.freedesktop.org/drm/tip.git drm-tip
patch link:    https://lore.kernel.org/r/20260111205820.830410-4-francois.dugast%40intel.com
patch subject: [PATCH v4 3/7] fs/dax: Use free_zone_device_folio_prepare() helper
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260112/202601121151.afcnEvLk-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601121151.afcnEvLk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601121151.afcnEvLk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/dax.c:384:6: warning: unused variable 'order' [-Wunused-variable]
     384 |         int order, i;
         |             ^~~~~
>> fs/dax.c:384:13: warning: unused variable 'i' [-Wunused-variable]
     384 |         int order, i;
         |                    ^
   2 warnings generated.


vim +/order +384 fs/dax.c

38607c62b34b46 Alistair Popple 2025-02-28  380  
38607c62b34b46 Alistair Popple 2025-02-28  381  static inline unsigned long dax_folio_put(struct folio *folio)
6061b69b9a550a Shiyang Ruan    2022-06-03  382  {
38607c62b34b46 Alistair Popple 2025-02-28  383  	unsigned long ref;
38607c62b34b46 Alistair Popple 2025-02-28 @384  	int order, i;
38607c62b34b46 Alistair Popple 2025-02-28  385  
38607c62b34b46 Alistair Popple 2025-02-28  386  	if (!dax_folio_is_shared(folio))
38607c62b34b46 Alistair Popple 2025-02-28  387  		ref = 0;
38607c62b34b46 Alistair Popple 2025-02-28  388  	else
38607c62b34b46 Alistair Popple 2025-02-28  389  		ref = --folio->share;
38607c62b34b46 Alistair Popple 2025-02-28  390  
38607c62b34b46 Alistair Popple 2025-02-28  391  	if (ref)
38607c62b34b46 Alistair Popple 2025-02-28  392  		return ref;
38607c62b34b46 Alistair Popple 2025-02-28  393  
ae869c69ed0719 Matthew Brost   2026-01-11  394  	free_zone_device_folio_prepare(folio);
16900426586032 Shiyang Ruan    2022-12-01  395  
38607c62b34b46 Alistair Popple 2025-02-28  396  	return ref;
16900426586032 Shiyang Ruan    2022-12-01  397  }
16900426586032 Shiyang Ruan    2022-12-01  398  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

