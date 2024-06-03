Return-Path: <linux-fsdevel+bounces-20781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61D8D7AD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB707B21BB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 04:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD32C697;
	Mon,  3 Jun 2024 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rdh8KwsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD824A08;
	Mon,  3 Jun 2024 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717389580; cv=none; b=r2jYfhGjSPVaTEqxbpBLG70Ce1Vl2PL01AeFK0YCSQDyIEgCsCPvDyGMiLoBhAPzGOBd3IPDq5/mHf2xVRsq+WDSVKq0m5EsLAL5aAQz28zekdT9BUQBZttfPsr7wanVCR3Q5mo1LisEJB/Ci8TrmRq5HmijqOP/9tVkBLa54Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717389580; c=relaxed/simple;
	bh=mmxiUMbaaQpISNm7DUxBngqFyA7lzsyvpGql6s9suLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIXpxOLh15hp/pNCxKiQB28tN+B71mhTTV+efLRVWR1o9wdbZY8+xtsDqueNGMVQiFfTxtSilZrx+9K7LEeqdTW0HwTPQ0I8yIir/Xg7CT1YCECN73wWrbSrQY7ookMurQNyd3wsfVzOv9zPsJW+ud7BMwviMfa+Wn75Rndrmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rdh8KwsP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717389579; x=1748925579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mmxiUMbaaQpISNm7DUxBngqFyA7lzsyvpGql6s9suLw=;
  b=Rdh8KwsP2mi8oi13XNpCEZ05Gf+84zaJbyOOZb5cWlUgf/G03JlNgEdH
   MhRWY5PLewRP53Y9ItB2yM91eB46I79yReDEx8kpW6icTXE9AVraD5/Jx
   m7RrdRlshBBUYBTKzvryKrw2ODv9bfOTsyPaYGWZ8Ld4rnWCzVZ4QLCIu
   hD89XQJwb1hN4qrC72F14sh4a3coeCZrsV2hA4+taspifxCe+Wlgx5anA
   P/9NjDLllMpC1nFV3doWhTNl+5i4+q+lQL6B5YDmrfWrLeeSo+kfufKu4
   hblLnbVDBp06M5rJAwz0sPw68+yJZ2s/j6mgcrsJLJYRxZpSPW7eHC1eY
   w==;
X-CSE-ConnectionGUID: 5dtZgN/hSkWvrXY6cyQfLw==
X-CSE-MsgGUID: QEFZEbx0QTuMrqUlkU/i/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13988344"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="13988344"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 21:39:38 -0700
X-CSE-ConnectionGUID: Hyb4cl2cTOGyetGmFtMZ1g==
X-CSE-MsgGUID: WbZLiAmjTPei0x3AmwcJtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="41846183"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 02 Jun 2024 21:39:35 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDzTo-000L1x-1R;
	Mon, 03 Jun 2024 04:39:32 +0000
Date: Mon, 3 Jun 2024 12:38:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>, brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>, linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/5] fs: sys_ringbuffer
Message-ID: <202406031256.z8k8v6AW-lkp@intel.com>
References: <20240603003306.2030491-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603003306.2030491-4-kent.overstreet@linux.dev>

Hi Kent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linus/master v6.10-rc2]
[cannot apply to akpm-mm/mm-nonmm-unstable tip/x86/asm akpm-mm/mm-everything next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kent-Overstreet/darray-lift-from-bcachefs/20240603-083536
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240603003306.2030491-4-kent.overstreet%40linux.dev
patch subject: [PATCH 3/5] fs: sys_ringbuffer
config: i386-buildonly-randconfig-002-20240603 (https://download.01.org/0day-ci/archive/20240603/202406031256.z8k8v6AW-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240603/202406031256.z8k8v6AW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406031256.z8k8v6AW-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/ringbuffer_sys.h:5:10: fatal error: 'uapi/linux/types.h' file not found
       5 | #include <uapi/linux/types.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

