Return-Path: <linux-fsdevel+bounces-55205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE9AB08430
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 07:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45204A5377
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 05:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7921C8604;
	Thu, 17 Jul 2025 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diJPZEhu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1277BA27
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728790; cv=none; b=IfSgYVOXd+nYT7KpPqA9X7Pw3aFLrwnUHmfyZvb8DfcpR2QjHzDCiB9WLF8loLdNkA3wKgXAKTDjdJXsB405ZGwLFlHLTn1Nd3/p7D250NPkrlbOapqrs9XyE8Cqg2f08rsY4wM1Fl4fz+STb5MSp2eDBnXjtmWstBz2Wu6dOLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728790; c=relaxed/simple;
	bh=2uCisOsA7yvdlT3BTjJzS938jeM0Ye+TlSw6NaxMwt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAyJK2MRh8DwgcL7MHLQIgiMwmB9qGWTNclsCJ3xiEB4oOXxsAHBWtCMcFAMAlspIDZU89ICWbSXhDIF/4KOrElkrWcTFSdqhrCnYjQ6GIFFoEeiB3L+OVq6FCQKpzRV+W8q6PJrpwzPddnHUBrgK/q3aCIEB1niH0FHFjHNKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diJPZEhu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752728789; x=1784264789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2uCisOsA7yvdlT3BTjJzS938jeM0Ye+TlSw6NaxMwt0=;
  b=diJPZEhuBwPhpXeLAZJTmTQ5wb35uDSd6HLnYMjnMktpT2Xxu3iJ2hWo
   vnfU9y78KGaSwQYtkOhNE21zjiVEzqRxRpj/iCkjuZrTYafW5R2Euio3W
   /jkpwaAYCQJTs7BNEcKS4+NnB93+hA3U3FbXa1bgq5x3wbPBqi2D5B2fu
   mWrmiuFUe7JpdxdoHUaFMs7BYz8EGkJd2zAgeLYOixzw9c+cCjadVULky
   Tkk0Osrk6NBzku9BJYGvJ3MrhjZQsTpiCckvGIaPJdmipuYW8NYXduJbY
   yyubtLALYJOPpskS1hH8A4QHhrpMdaceMyrdmngQ+dLtegS8BIC8EbFaR
   Q==;
X-CSE-ConnectionGUID: uIQmDV0JQnqSX+tZH2eEkw==
X-CSE-MsgGUID: UlmEvQcNTaCknMobX5D0Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55078128"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="55078128"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 22:06:28 -0700
X-CSE-ConnectionGUID: rfUnNzD2SyyZmVD7USRUEw==
X-CSE-MsgGUID: AUfRILhhRlSdwSbooEHCNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="157498806"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Jul 2025 22:06:26 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucGp5-000DAJ-0P;
	Thu, 17 Jul 2025 05:06:23 +0000
Date: Thu, 17 Jul 2025 13:05:44 +0800
From: kernel test robot <lkp@intel.com>
To: Alex <alex.fcyrx@gmail.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, torvalds@linux-foundation.org,
	paulmck@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	Alex <alex.fcyrx@gmail.com>
Subject: Re: [PATCH] fs: Remove obsolete logic in i_size_read/write
Message-ID: <202507171216.eCtc7zAl-lkp@intel.com>
References: <20250716125304.1189790-1-alex.fcyrx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716125304.1189790-1-alex.fcyrx@gmail.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.16-rc6 next-20250716]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex/fs-Remove-obsolete-logic-in-i_size_read-write/20250716-205449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250716125304.1189790-1-alex.fcyrx%40gmail.com
patch subject: [PATCH] fs: Remove obsolete logic in i_size_read/write
config: i386-buildonly-randconfig-001-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171216.eCtc7zAl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171216.eCtc7zAl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171216.eCtc7zAl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'i_size_read',
       inlined from 'do_shmat' at ipc/shm.c:1614:9:
>> include/linux/compiler_types.h:568:45: error: call to '__compiletime_assert_451' declared with attribute error: Need native word sized stores/loads for atomicity.
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:549:25: note: in definition of macro '__compiletime_assert'
     549 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:571:9: note: in expansion of macro 'compiletime_assert'
     571 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:69:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      69 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   include/linux/fs.h:960:16: note: in expansion of macro 'smp_load_acquire'
     960 |         return smp_load_acquire(&inode->i_size);
         |                ^~~~~~~~~~~~~~~~
   In function 'i_size_read',
       inlined from 'ksys_shmdt' at ipc/shm.c:1783:11:
>> include/linux/compiler_types.h:568:45: error: call to '__compiletime_assert_451' declared with attribute error: Need native word sized stores/loads for atomicity.
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:549:25: note: in definition of macro '__compiletime_assert'
     549 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:571:9: note: in expansion of macro 'compiletime_assert'
     571 |         compiletime_assert(__native_word(t),                            \
         |         ^~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:69:9: note: in expansion of macro 'compiletime_assert_atomic_type'
      69 |         compiletime_assert_atomic_type(*p);                             \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^~~~~~~~~~~~~~~~~~
   include/linux/fs.h:960:16: note: in expansion of macro 'smp_load_acquire'
     960 |         return smp_load_acquire(&inode->i_size);
         |                ^~~~~~~~~~~~~~~~


vim +/__compiletime_assert_451 +568 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  554  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  555  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  556  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  557  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  559   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  560   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  561   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  562   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  563   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  564   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  565   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  566   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  567  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @568  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  569  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

