Return-Path: <linux-fsdevel+bounces-9229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E883F3C0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 05:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF51F22206
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 04:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188109476;
	Sun, 28 Jan 2024 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXPyK6MX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB763D9;
	Sun, 28 Jan 2024 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706416219; cv=none; b=uFBU9PmOzpayJ/rX2EnCrWASkFn9nVeGGRk5Y+4BUxSLALK6hindrNuwTJxfhIaEvjDi6Lpsv+g9bhpYFsvVGgIvLENxVS5vtWPBTMHFQgwYiXPXXsQNTw2v3u3bWDzEdgu0pAcHb5MxIC8Ok7JIL6jIfYXJGWkt2TEpYuxUhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706416219; c=relaxed/simple;
	bh=82WJ+QojB1cPxyI/Ym5sbW8tqYYq8qJcoOqZ+Ywj8As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5z6BMoF7PTVOxl5IIcOJ5BObOuUePKWipPwoIpUs8ZbTwYpEH60xLok6FQeyhPMdHigvsjiu0ssGu8aHL28h6oB1mngL/YHIvsH2bfYh1s7eteZMSXlr8Sw/L8+nfKIvw6C2GqUgRVVswEYClTEfDyn27NhzHR4mzexHjGwh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXPyK6MX; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706416217; x=1737952217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=82WJ+QojB1cPxyI/Ym5sbW8tqYYq8qJcoOqZ+Ywj8As=;
  b=JXPyK6MXcFSbRkff/npSvwudKlAen/NhuwS+1rNkF4JEY3Anu1nwCkFY
   zkM4sQouM/peuRgupTufnptLboml/BIpqIQ0LAWNrqArv2Zn4x+OfkAbx
   A40wi4Y79WXxuPtTiqK4TqiODwBl8Z2bZ9SJPxLKH2vuwrkoRPbF3L8jr
   oKUAubU/ZZNhlTCKLh2tpBUtskIBlAELrMvQZLqi8M3LkLTDCFTGz1n5J
   hQCi5db5GVe1931s5MwHXOAPhLaj5BB7TftbbTD5kXiStG6dfk1wLUawq
   0v9QnaiJTToPfaSNkoiTdUwc8p66qcz+It9TmuKaIMkxarueS6ILzkKYm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="433900316"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433900316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 20:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="910718820"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910718820"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2024 20:30:13 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTwo7-00034i-1R;
	Sun, 28 Jan 2024 04:30:11 +0000
Date: Sun, 28 Jan 2024 12:29:51 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Kent Overstreet <kent.overstreet@linux.dev>, peterz@infradead.org,
	boqun.feng@gmail.com, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/4] pktcdvd: kill mutex_lock_nested() usage
Message-ID: <202401281210.ZqZ0bZlb-lkp@intel.com>
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
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kent-Overstreet/fs-pipe-Convert-to-lockdep_cmp_fn/20240127-101832
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240127020833.487907-3-kent.overstreet%40linux.dev
patch subject: [PATCH 2/4] pktcdvd: kill mutex_lock_nested() usage
config: mips-randconfig-r063-20240127 (https://download.01.org/0day-ci/archive/20240128/202401281210.ZqZ0bZlb-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281210.ZqZ0bZlb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281210.ZqZ0bZlb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/locking/lockdep.c:4925:9: error: call to undeclared function 'cmp_int'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           return cmp_int((unsigned long) a, (unsigned long) b);
                  ^
   kernel/locking/lockdep.c:4925:9: note: did you mean 'smp_init'?
   include/linux/smp.h:225:20: note: 'smp_init' declared here
   static inline void smp_init(void) { }
                      ^
   1 error generated.


vim +/cmp_int +4925 kernel/locking/lockdep.c

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

