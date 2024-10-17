Return-Path: <linux-fsdevel+bounces-32187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3984D9A20AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1ADF288EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF2E6BFC0;
	Thu, 17 Oct 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOcOCskp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BE1D5CC2;
	Thu, 17 Oct 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163245; cv=none; b=mtzImNv5to9vwlBxc6fMcwyZKvjUvthTZJ3kCk+vnoud47rdeQOsmqUmXbBYF7+uQjnjzK1UR8GpPcv3MW5wyJZmYq/pOHbmbeXw+SLneJNWGmyGSebt4zIQ9M03I8SEPPyU9rlitUp7KHZs7hy1oas5xOVEv6VDG7jDbQpXt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163245; c=relaxed/simple;
	bh=FC0Lxn6ChxB9i3JUJTg/0kuxPgCMromX4ji/2uy2t5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbkmtrZWH9hOMTL+loTUSDfNUDSnWfdWpuQiGsNBvj6rtoZ8vWuLZGnXUxa2mHCvZR3pXqcmleqQNS1k86QjMBKFMDZ526z9b7qc4wXxmgexJoVSTFUSJQV7QYDQxnTR/qt2zm0CUbulsblBM90Puq3wPatslK/BvwyT34J5xcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOcOCskp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729163242; x=1760699242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FC0Lxn6ChxB9i3JUJTg/0kuxPgCMromX4ji/2uy2t5A=;
  b=MOcOCskpxDmtsJs14Asv0wKqDo8/cUORFk4ugE1Uul2sxdTAq/sLL+bH
   +moFco3I+7HeDdaPsHHMfbTKABkxdDFfbRue9OsfDqPA5hqpARczwEmT3
   ji+cTd3Ooc3c05RoflfT/20doX3sWStZbLTC1y10or+WUl3JkSuUrAFCQ
   /WpsFNxdTbM0V8TvwBWTAV+YD1tzZhHLBc1J9vEtWWjfUG2ANWP3KX57B
   gl2THDlMZSpGKNcZQ83p3+UjdR4Kd9QFy70FTjAS5ehRnN75R/Cs5I1eT
   fjU9uGKmQF7RKZ/Q3RnyseXR9cjbHElLJic+LzkNeJ8gdr2Mdhhs2YqtK
   g==;
X-CSE-ConnectionGUID: 8ls4BSpyQReIS5zd2OCUKQ==
X-CSE-MsgGUID: Tx9nqYc7QxOoKQBp8avIFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="31511700"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="31511700"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:07:21 -0700
X-CSE-ConnectionGUID: lnCM6PewTuiAapcXonE70g==
X-CSE-MsgGUID: 9BgmUhdnQ0aqJ9sGXdEq3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="109328173"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Oct 2024 04:07:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1OLa-000MDz-0o;
	Thu, 17 Oct 2024 11:07:14 +0000
Date: Thu, 17 Oct 2024 19:07:05 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	rppt@kernel.org, david@redhat.com, yosryahmed@google.com,
	shakeel.butt@linux.dev, Andrii Nakryiko <andrii@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <202410171803.RRmMX9xL-lkp@intel.com>
References: <20241016221629.1043883-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016221629.1043883-1-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/lib-buildid-handle-memfd_secret-files-in-build_id_parse/20241017-061747
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20241016221629.1043883-1-andrii%40kernel.org
patch subject: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20241017/202410171803.RRmMX9xL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171803.RRmMX9xL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171803.RRmMX9xL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/buildid.c:5:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> lib/buildid.c:79:7: error: call to undeclared function 'kernel_page_present'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      79 |             !kernel_page_present(&r->folio->page) ||
         |              ^
   1 warning and 1 error generated.


vim +/kernel_page_present +79 lib/buildid.c

    58	
    59	static int freader_get_folio(struct freader *r, loff_t file_off)
    60	{
    61		/* check if we can just reuse current folio */
    62		if (r->folio && file_off >= r->folio_off &&
    63		    file_off < r->folio_off + folio_size(r->folio))
    64			return 0;
    65	
    66		freader_put_folio(r);
    67	
    68		r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
    69	
    70		/* if sleeping is allowed, wait for the page, if necessary */
    71		if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
    72			filemap_invalidate_lock_shared(r->file->f_mapping);
    73			r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
    74						    NULL, r->file);
    75			filemap_invalidate_unlock_shared(r->file->f_mapping);
    76		}
    77	
    78		if (IS_ERR(r->folio) ||
  > 79		    !kernel_page_present(&r->folio->page) ||
    80		    !folio_test_uptodate(r->folio)) {
    81			if (!IS_ERR(r->folio))
    82				folio_put(r->folio);
    83			r->folio = NULL;
    84			return -EFAULT;
    85		}
    86	
    87		r->folio_off = folio_pos(r->folio);
    88		r->addr = kmap_local_folio(r->folio, 0);
    89	
    90		return 0;
    91	}
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

