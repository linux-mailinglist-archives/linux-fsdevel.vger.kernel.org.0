Return-Path: <linux-fsdevel+bounces-63823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D914BBCED3C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 02:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E64402599
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 00:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E343AC1C;
	Sat, 11 Oct 2025 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VppAqar+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54531288D0;
	Sat, 11 Oct 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760143192; cv=none; b=ZOrt3QGCYc3pZOUMOfB6z0xah4dnd476CGYzTVxpdyS8wvw10V79sEYZ2tEOu9BktLGzzfVbW54OnCnHBCo2ON3yRkLQg8mVbOufxEyZM5+c9rYZTTzneCTAMN4ZwYo2/sX/PJ27trSFQGRsJ7yWAWAviCycb5TeSlFe12goAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760143192; c=relaxed/simple;
	bh=3WZMGE84ie4C++BzAywiY54anJ7ajFY4nUNbpZUz3/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDYSBZ/3YYLsLZdajeiR2DPoOcBUKm9g1Jw4KRBVSwgPT0vPoRwAlomhS/t744s25nkI0SEC61sIlkmcjZ2Cx2xX6c0i8znSdIpKAL6byw0rq3v1XfmYVfxKuTJBbJNPQwmIG3tC7/RJJOVkjAe8QFaSw3moZWZIptPYZx7E3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VppAqar+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760143190; x=1791679190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3WZMGE84ie4C++BzAywiY54anJ7ajFY4nUNbpZUz3/c=;
  b=VppAqar+uRozJzVIbvc0ntnvcKFRKhvFu6wzZEqWENAIVDbdUexiqNre
   v1Lb9dZ824DSTGGaKYkgay7tojG/Zbg57d6TQHGdFOItKem4R+xAaSdRN
   uctkQLpuv+MfyGNyYAx9wR9B+fJlffNLEb8x8F24mihczvGJPgh9/USZC
   g64aR6XBf2gjTHQ1Zf3KLlP60pBPl53H7P54WyykeaN6/jbduZZr9qSYv
   hxYEulO5s2IYvdEJwNGMps/+6VQ0fXowPEtB87jJdbrrQN+5c5E/rifyG
   xa1RnEdLKtGKXu7IKBJ4RgAStxTjHIFW/Wyy/rAwZ3RBQUPI/Kb4h+MHa
   A==;
X-CSE-ConnectionGUID: mfwlrmgHROKHl/69IpZ6AQ==
X-CSE-MsgGUID: Ca7Fi1e6S2O7wITwSv489Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62067003"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62067003"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 17:39:49 -0700
X-CSE-ConnectionGUID: SD3AyhJoS8q/jAeJ2WMHuw==
X-CSE-MsgGUID: 6XtPKSO+T3qohp3M8bZxKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180791567"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Oct 2025 17:39:46 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7NeB-0003Kp-2l;
	Sat, 11 Oct 2025 00:39:43 +0000
Date: Sat, 11 Oct 2025 08:39:08 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Acs <acsjakub@amazon.de>, aliceryhl@google.com, djwong@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jhubbard@nvidia.com, acsjakub@amazon.de,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	chengming.zhou@linux.dev, david@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, peterx@redhat.com,
	rust-for-linux@vger.kernel.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH] mm: use enum for vm_flags
Message-ID: <202510110802.EXLvwqhL-lkp@intel.com>
References: <20251008125427.68735-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008125427.68735-1-acsjakub@amazon.de>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Acs/mm-use-enum-for-vm_flags/20251010-124738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251008125427.68735-1-acsjakub%40amazon.de
patch subject: [PATCH] mm: use enum for vm_flags
config: parisc-randconfig-r072-20251011 (https://download.01.org/0day-ci/archive/20251011/202510110802.EXLvwqhL-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110802.EXLvwqhL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110802.EXLvwqhL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/elf.h:6,
                    from include/linux/module.h:20,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from include/linux/static_call.h:135,
                    from include/linux/tracepoint.h:22,
                    from include/linux/mm.h:39,
                    from include/linux/pid_namespace.h:7,
                    from include/linux/nsfs.h:9,
                    from include/linux/proc_ns.h:8,
                    from init/version.c:18:
>> arch/parisc/include/asm/elf.h:320: warning: "ELF_OSABI" redefined
    #define ELF_OSABI  ELFOSABI_LINUX
    
   In file included from include/linux/elfnote.h:62,
                    from include/linux/build-salt.h:4,
                    from init/version.c:11:
   include/uapi/linux/elf.h:386: note: this is the location of the previous definition
    #define ELF_OSABI ELFOSABI_NONE
    


vim +/ELF_OSABI +320 arch/parisc/include/asm/elf.h

^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  308  
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  309  
71d577db01a517 arch/parisc/include/asm/elf.h Helge Deller   2018-04-11  310  #define elf_check_arch(x)		\
71d577db01a517 arch/parisc/include/asm/elf.h Helge Deller   2018-04-11  311  	((x)->e_machine == EM_PARISC && (x)->e_ident[EI_CLASS] == ELF_CLASS)
71d577db01a517 arch/parisc/include/asm/elf.h Helge Deller   2018-04-11  312  #define compat_elf_check_arch(x)	\
71d577db01a517 arch/parisc/include/asm/elf.h Helge Deller   2018-04-11  313  	((x)->e_machine == EM_PARISC && (x)->e_ident[EI_CLASS] == ELFCLASS32)
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  314  
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  315  /*
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  316   * These are used to set parameters in the core dumps.
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  317   */
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  318  #define ELF_DATA	ELFDATA2MSB
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  319  #define ELF_ARCH	EM_PARISC
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16 @320  #define ELF_OSABI 	ELFOSABI_LINUX
^1da177e4c3f41 include/asm-parisc/elf.h      Linus Torvalds 2005-04-16  321  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

