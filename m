Return-Path: <linux-fsdevel+bounces-66643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B16C27301
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 00:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C8C3AF3D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1118932D0CF;
	Fri, 31 Oct 2025 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLosEy4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4C32AAA6;
	Fri, 31 Oct 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953531; cv=none; b=MABFPNufSdtW2L/zq7Ed2H/0gGMfffvVwSooV4gkzW37TJNo+A6nCLjOEzazID4JQy3pgTWdsx1HpAqS/l35tJB3O+3uvGeC5o7OiTXhqJz8NVRgA3dtdnE3vqClBTRyTTbHYQ3z1ZaCrYZgBHA3Wiw0kYE7s8x+FbE0vDgFayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953531; c=relaxed/simple;
	bh=MwRqjYevjHFcBpDOSWwiArO9qAZtX88K8HrrBcDQxzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ewv9RcUdMNNYgRCA/8bsRY857wj+dnJV8N3lwy9FbcmsxTpCKGq4QDZaq4VcEE65EETMv/igkZeBUQ9S1ab2qriMoN6l733CjwwOorIzoUnRDWEkyg8NGfjMUr84htsytaU7qP+pHeKPuhF5VEcv9eXa1jZP0r/lSbeI+3bnkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLosEy4N; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761953530; x=1793489530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MwRqjYevjHFcBpDOSWwiArO9qAZtX88K8HrrBcDQxzY=;
  b=NLosEy4N/rgKsrx+16421kLXQsiiIPfYovUXHLdm4jClOSxMxuO0jjNU
   T8NypExJ43hiSa43mjWJrJ80b5C9rjIyNPkDuNZTNHz/wHyXnOsVNKqhU
   CmjN9Zz46UO6Ne2onrHwRXGmANJT5O+FdmdBgBRGVhvFWzJoD7y08TpKZ
   x9nY8R3v96pdVO6cC+FlA3YRm4kqdjaBd44wD+oew+WweEb4t93fKGibl
   634//YUGWI3NOyZwDrndRRe5Er1LN43liCkSwxBZBEX7GY4cUs0ewnm9S
   h/wznW89roTKLHVj+vyv9IyqAqgLP0qlieHJEU2yuKeb0OOpvV7Snepxm
   w==;
X-CSE-ConnectionGUID: RckVz+bUSGGq8kGKIGL0/w==
X-CSE-MsgGUID: BAdpuifDSEW1ruYWDg2RGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="75469904"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="75469904"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 16:32:09 -0700
X-CSE-ConnectionGUID: IeMUZ8jbTCebYwi2GKEtAg==
X-CSE-MsgGUID: MHEqQcFDQjOm8xC89SORPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="209912693"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 31 Oct 2025 16:32:07 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEybE-000Nik-20;
	Fri, 31 Oct 2025 23:32:04 +0000
Date: Sat, 1 Nov 2025 07:30:27 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, torvalds@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
Message-ID: <202511010706.nuASkMjZ-lkp@intel.com>
References: <20251031174220.43458-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031174220.43458-4-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on linus/master brauner-vfs/vfs.all v6.18-rc3 next-20251031]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/x86-fix-access_ok-and-valid_user_address-using-wrong-USER_PTR_MAX-in-modules/20251101-054539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251031174220.43458-4-mjguzik%40gmail.com
patch subject: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20251101/202511010706.nuASkMjZ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511010706.nuASkMjZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511010706.nuASkMjZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:1016,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/alpha/kernel/asm-offsets.c:11:
>> include/linux/fs.h:54:10: fatal error: asm/runtime-const-accessors.h: No such file or directory
      54 | #include <asm/runtime-const-accessors.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/Makefile.build:182: arch/alpha/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +54 include/linux/fs.h

    51	
    52	#include <asm/byteorder.h>
    53	#ifndef MODULE
  > 54	#include <asm/runtime-const-accessors.h>
    55	#endif
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

