Return-Path: <linux-fsdevel+bounces-34716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57AB9C7FFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 02:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3B3B22D60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 01:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE61E503D;
	Thu, 14 Nov 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbeMh0LV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B571E3DE6;
	Thu, 14 Nov 2024 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547798; cv=none; b=pOwJoZBEHT0oFM8bmI1iJ/zuf8MeHSU/4Ma2HDtG5a3GfBvyTyOg/tonGHHiSy0BfxkNp1z7plZtOHW6O/usXybq7ROqSi6SNhV+kiUT2m+lI7c3ynHB900qbPVZqZOp7b0ygTfZT127QKkfzoULh51ecEOTcT6hX6fjHTGdm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547798; c=relaxed/simple;
	bh=WgsVOWJCyil2uWXX8XBAE1GzISBtQeGgqP5BmlubFfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fpr/jVl2WaBept4i/p7bdYW6yX4s+u9cIjzQiOC/CyByFWHa4EeosWnkF6ke14xQRYm1QlIvC8qHSCpqeeyxXHQOtWAqO1s/C7gysVhTZgxKces0xccIlBmNE9xG0OqTm8xQMSfRrOrpHQYMTYfFwxyZsGvJR8AKay/svIK06wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbeMh0LV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731547797; x=1763083797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WgsVOWJCyil2uWXX8XBAE1GzISBtQeGgqP5BmlubFfM=;
  b=IbeMh0LVbtHt+zVMpUFFAgQ72u8eT4R5/pTOppUHVIj2CR6z69edRIQi
   VuV1rfiVZMtJX0i7CZwruJNErBRC70mUCsGWukGADmfaZWqZEUEe0BMv4
   i4aEInR0qCaPSTgeVQ88kUXC39buBY4PnucKtHHEUcfSwiiASft7hxCU1
   8O0YemPQ11baWdGVbUBEmh0OlOAdZaYDIu0fgFWn6TolCZNjDZDL5i8fu
   Cj1OLT22MdrQzi4QwpRYJ4T8CQfciedlatcpulQ/Ngfd+9WCGzS1PDgwE
   u0Nu3Pq5I01sv1CxxnqfnjJFNYo8OHnIKZPeWeuf4NiJIFGOyzRaHjjlQ
   w==;
X-CSE-ConnectionGUID: sy9YQc8kQNqGqkgTOoUECg==
X-CSE-MsgGUID: xbItfXCrQc27yR5LSPEWGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31239769"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31239769"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 17:29:54 -0800
X-CSE-ConnectionGUID: WCzboegvRzGce8+dZWy1Nw==
X-CSE-MsgGUID: hrz7GM3bTUiM3XnMor00dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88468719"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Nov 2024 17:29:52 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBOg9-00012L-2f;
	Thu, 14 Nov 2024 01:29:49 +0000
Date: Thu, 14 Nov 2024 09:29:41 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	intel-xe@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iov_iter: Provide copy_iomem_to|from_iter()
Message-ID: <202411140935.iEbIWcpc-lkp@intel.com>
References: <20241112200454.2211-2-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112200454.2211-2-michal.wajdeczko@intel.com>

Hi Michal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-xe/drm-xe-next]
[also build test WARNING on brauner-vfs/vfs.all akpm-mm/mm-nonmm-unstable linus/master v6.12-rc7 next-20241113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wajdeczko/iov_iter-Provide-copy_iomem_to-from_iter/20241113-080831
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20241112200454.2211-2-michal.wajdeczko%40intel.com
patch subject: [PATCH v2 1/4] iov_iter: Provide copy_iomem_to|from_iter()
config: x86_64-randconfig-123-20241113 (https://download.01.org/0day-ci/archive/20241114/202411140935.iEbIWcpc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140935.iEbIWcpc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140935.iEbIWcpc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/iov_iter.c:373:47: sparse: sparse: cast removes address space '__iomem' of expression
   lib/iov_iter.c:386:47: sparse: sparse: cast removes address space '__iomem' of expression
>> lib/iov_iter.c:349:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got void * @@
   lib/iov_iter.c:349:33: sparse:     expected void const volatile [noderef] __iomem *
   lib/iov_iter.c:349:33: sparse:     got void *
   lib/iov_iter.c:330:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem * @@     got void * @@
   lib/iov_iter.c:330:37: sparse:     expected void const volatile [noderef] __iomem *
   lib/iov_iter.c:330:37: sparse:     got void *
>> lib/iov_iter.c:362:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem * @@     got void *to @@
   lib/iov_iter.c:362:21: sparse:     expected void volatile [noderef] __iomem *
   lib/iov_iter.c:362:21: sparse:     got void *to
>> lib/iov_iter.c:338:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem * @@     got void * @@
   lib/iov_iter.c:338:24: sparse:     expected void volatile [noderef] __iomem *
   lib/iov_iter.c:338:24: sparse:     got void *

vim +/__iomem +373 lib/iov_iter.c

   333	
   334	static __always_inline
   335	size_t memcpy_iomem_from_iter(void *iter_from, size_t progress, size_t len,
   336				      void *to, void *priv2)
   337	{
 > 338		memcpy_toio(to + progress, iter_from, len);
   339		return 0;
   340	}
   341	
   342	static __always_inline
   343	size_t copy_iomem_to_user_iter(void __user *iter_to, size_t progress,
   344				       size_t len, void *from, void *priv2)
   345	{
   346		unsigned char buf[SMP_CACHE_BYTES];
   347		size_t chunk = min(len, sizeof(buf));
   348	
 > 349		memcpy_fromio(buf, from + progress, chunk);
   350		chunk -= copy_to_user_iter(iter_to, progress, chunk, buf, priv2);
   351		return len - chunk;
   352	}
   353	
   354	static __always_inline
   355	size_t copy_iomem_from_user_iter(void __user *iter_from, size_t progress,
   356					 size_t len, void *to, void *priv2)
   357	{
   358		unsigned char buf[SMP_CACHE_BYTES];
   359		size_t chunk = min(len, sizeof(buf));
   360	
   361		chunk -= copy_from_user_iter(iter_from, progress, chunk, buf, priv2);
 > 362		memcpy_toio(to, buf, chunk);
   363		return len - chunk;
   364	}
   365	
   366	size_t copy_iomem_to_iter(const void __iomem *from, size_t bytes, struct iov_iter *i)
   367	{
   368		if (WARN_ON_ONCE(i->data_source))
   369			return 0;
   370		if (user_backed_iter(i))
   371			might_fault();
   372	
 > 373		return iterate_and_advance(i, bytes, (void *)from,
   374					   copy_iomem_to_user_iter,
   375					   memcpy_iomem_to_iter);
   376	}
   377	EXPORT_SYMBOL(copy_iomem_to_iter);
   378	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

