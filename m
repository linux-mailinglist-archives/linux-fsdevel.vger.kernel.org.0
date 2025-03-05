Return-Path: <linux-fsdevel+bounces-43271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA87A5032F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B27B3A7166
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1875D24F5A9;
	Wed,  5 Mar 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzU8d31u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1124E014;
	Wed,  5 Mar 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187335; cv=none; b=KbH++NGijC9uo16jDdrUHUjfBXavcskwyWm031J9Plw8r7R3wopJVOFUpbu819ZU6JWq/0HcMZsBB3RygLOkqSQ9P2iX+B9x/GnRgUDkEw4HRXXpJGJ/3lCSloXAlfs1gMBeLhOOPxZb2wtmPQ3qNaw7muhOkCD1qFRpbhcQl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187335; c=relaxed/simple;
	bh=e3oBTYdyUXsbOwDIkrX87IO9OyOkNlF6VSWAGvwLoCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJhU55Vfy6+j3al1kURF+zS7I/lF1bCGXRCrQbfak2BwCLI6Ekb2zDPgG8lzF3hTzFuDlJdbrjcAlnH39wnoZ/tV79fGAyPEmZlXyki5rSC150j3hQcfX5Ds2mbQAWPsDjYnGaC8oPy65aLrzVxoLBdE4Zn3r/NiYN9YaGYEFRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzU8d31u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741187334; x=1772723334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e3oBTYdyUXsbOwDIkrX87IO9OyOkNlF6VSWAGvwLoCU=;
  b=gzU8d31uRG1P1I1EkKxY0atxBlyneFkG6BH56nlJs2PRggLKWLoPbT36
   PTpch0OuxfLmyKtsLQlXAGoTbptU6RwBj8fn9fmarwrCc2UMJmZBVJCHa
   MzfiGaQCOiQ44IrX34XSFifwXlXCfs6BZ/ggoJMHacIldLrBydGlmLg7S
   IO1KjK2Z8rf7jB/uXJy4Ab1qXgtgQZXlCdEGFaccf/zfb+y9a0Y8ytoQk
   DFRPA9i5FVSPZPZXFHMEfaesjqhF18Ecqqc0InvtALelLoNzf3gTceeF2
   rc4q4zWb+fTQsfNLm4CiG8lvMZgRh75QU2PfSYJrAc2JLyJU9Hrp9B6G9
   Q==;
X-CSE-ConnectionGUID: ekp3QyvCSJ+QmThPjx/gIw==
X-CSE-MsgGUID: Rpxn+t2gSd2/JPY1Du5Bjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42293617"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42293617"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:08:53 -0800
X-CSE-ConnectionGUID: Bhr/kYI6SFu0ljZczH300g==
X-CSE-MsgGUID: yT8QzywsSYGjsQgMiXKFBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149658320"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 05 Mar 2025 07:08:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpqMa-000L7m-1d;
	Wed, 05 Mar 2025 15:08:48 +0000
Date: Wed, 5 Mar 2025 23:08:22 +0800
From: kernel test robot <lkp@intel.com>
To: Seyediman Seyedarab <imandevel@gmail.com>, jack@suse.cz,
	amir73il@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Seyediman Seyedarab <ImanDevel@gmail.com>
Subject: Re: [PATCH] inotify: disallow watches on unsupported filesystems
Message-ID: <202503052203.vK0McbRm-lkp@intel.com>
References: <20250304080044.7623-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304080044.7623-1-ImanDevel@gmail.com>

Hi Seyediman,

kernel test robot noticed the following build errors:

[auto build test ERROR on jack-fs/fsnotify]
[also build test ERROR on linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Seyediman-Seyedarab/inotify-disallow-watches-on-unsupported-filesystems/20250304-160213
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
patch link:    https://lore.kernel.org/r/20250304080044.7623-1-ImanDevel%40gmail.com
patch subject: [PATCH] inotify: disallow watches on unsupported filesystems
config: powerpc-randconfig-001-20250305 (https://download.01.org/0day-ci/archive/20250305/202503052203.vK0McbRm-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052203.vK0McbRm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503052203.vK0McbRm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/notify/inotify/inotify_user.c:702:33: error: use of undeclared identifier 'unwatchable_fs'; did you mean 'is_unwatchable_fs'?
     702 |         for (int i = 0; i < ARRAY_SIZE(unwatchable_fs); i++)
         |                                        ^~~~~~~~~~~~~~
         |                                        is_unwatchable_fs
   include/linux/array_size.h:11:33: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                 ^
   fs/notify/inotify/inotify_user.c:700:20: note: 'is_unwatchable_fs' declared here
     700 | static inline bool is_unwatchable_fs(struct inode *inode)
         |                    ^
>> fs/notify/inotify/inotify_user.c:702:33: error: use of undeclared identifier 'unwatchable_fs'; did you mean 'is_unwatchable_fs'?
     702 |         for (int i = 0; i < ARRAY_SIZE(unwatchable_fs); i++)
         |                                        ^~~~~~~~~~~~~~
         |                                        is_unwatchable_fs
   include/linux/array_size.h:11:48: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                ^
   fs/notify/inotify/inotify_user.c:700:20: note: 'is_unwatchable_fs' declared here
     700 | static inline bool is_unwatchable_fs(struct inode *inode)
         |                    ^
>> fs/notify/inotify/inotify_user.c:702:22: error: subscript of pointer to function type 'bool (struct inode *)' (aka '_Bool (struct inode *)')
     702 |         for (int i = 0; i < ARRAY_SIZE(unwatchable_fs); i++)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:47: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                               ^~~~~
>> fs/notify/inotify/inotify_user.c:702:33: error: use of undeclared identifier 'unwatchable_fs'; did you mean 'is_unwatchable_fs'?
     702 |         for (int i = 0; i < ARRAY_SIZE(unwatchable_fs); i++)
         |                                        ^~~~~~~~~~~~~~
         |                                        is_unwatchable_fs
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^
   include/linux/compiler.h:249:65: note: expanded from macro '__must_be_array'
     249 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
         |                                                                      ^
   include/linux/compiler_types.h:483:63: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/compiler.h:245:79: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     245 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   fs/notify/inotify/inotify_user.c:700:20: note: 'is_unwatchable_fs' declared here
     700 | static inline bool is_unwatchable_fs(struct inode *inode)
         |                    ^
>> fs/notify/inotify/inotify_user.c:702:33: error: use of undeclared identifier 'unwatchable_fs'; did you mean 'is_unwatchable_fs'?
     702 |         for (int i = 0; i < ARRAY_SIZE(unwatchable_fs); i++)
         |                                        ^~~~~~~~~~~~~~
         |                                        is_unwatchable_fs
   include/linux/array_size.h:11:75: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                                           ^
   include/linux/compiler.h:249:71: note: expanded from macro '__must_be_array'
     249 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
         |                                                                            ^
   include/linux/compiler_types.h:483:74: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/compiler.h:245:79: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     245 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   fs/notify/inotify/inotify_user.c:700:20: note: 'is_unwatchable_fs' declared here
     700 | static inline bool is_unwatchable_fs(struct inode *inode)
         |                    ^
>> fs/notify/inotify/inotify_user.c:702:22: error: subscript of pointer to function type 'bool (struct inode *)' (aka '_Bool (struct inode *)')
     702 |         for (int i = 0; i < ARRAY_SIZE(unwatchable_fs); i++)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:249:70: note: expanded from macro '__must_be_array'
     249 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(__same_type((a), &(a)[0]), "must be array")
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:483:74: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/compiler.h:245:79: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     245 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   fs/notify/inotify/inotify_user.c:703:31: error: use of undeclared identifier 'unwatchable_fs'; did you mean 'is_unwatchable_fs'?
     703 |                 if (inode->i_sb->s_magic == unwatchable_fs[i])
         |                                             ^~~~~~~~~~~~~~
         |                                             is_unwatchable_fs
   fs/notify/inotify/inotify_user.c:700:20: note: 'is_unwatchable_fs' declared here
     700 | static inline bool is_unwatchable_fs(struct inode *inode)
         |                    ^
   fs/notify/inotify/inotify_user.c:703:31: error: subscript of pointer to function type 'bool (struct inode *)' (aka '_Bool (struct inode *)')
     703 |                 if (inode->i_sb->s_magic == unwatchable_fs[i])
         |                                             ^~~~~~~~~~~~~~
   8 errors generated.


vim +702 fs/notify/inotify/inotify_user.c

   698	
   699	
   700	static inline bool is_unwatchable_fs(struct inode *inode)
   701	{
 > 702		for (int i = 0; i < ARRAY_SIZE(unwatchable_fs); i++)
   703			if (inode->i_sb->s_magic == unwatchable_fs[i])
   704				return true;
   705		return false;
   706	}
   707	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

