Return-Path: <linux-fsdevel+bounces-66452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF677C1F97A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBC542201C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15353546EC;
	Thu, 30 Oct 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4HVyVuN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2433F38D;
	Thu, 30 Oct 2025 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820560; cv=none; b=tDZEuMeLSF34trGT7UruVueHufB7CiepbGQx6OM0TdfD7gotkQgRpj37kXpal9dTIO05k4GKZJPnPvbgvnLxjW5Pvk/EM5L/PKliUyrkXMy7sPpo3w7Tc5WQeCdlnA/4XeEgoZMZK0ihpNkuS1QkDiZEXemRv7rtqVXwumnqb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820560; c=relaxed/simple;
	bh=2tLmz2RfagcHvJXfShoCwKo3Od5ndbpSAsQ3/2PwjG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxCqkr+cS4xyy0bUd1bTVmz20hF9UTv76ec5DeWpR4doJ19ts7blloKRFGCNx7w6KqhIxvn2jIOVTsI4vitKbfCJngCUse9apD35233usvnX5QckMhJi+I5gRD26gm5eAyKM2QZEKZYTcanU0TCLTQWSzXkLtrjWXMikiQxqMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4HVyVuN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761820556; x=1793356556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2tLmz2RfagcHvJXfShoCwKo3Od5ndbpSAsQ3/2PwjG8=;
  b=k4HVyVuNkrLjfFy1yNAyJIAVx8Li/yCWdA6LxcFjfWpoepArZShX70L+
   f8Fn9gi9hmEmCS4WCsELr75NE7L057l5AFT8G94bu1A1RlQwKvvLKflfY
   3A+b9ZdT3PFkKtLC0FY5zm3N5QeiCRgyDypgqcyUA2dgg+U4AhlKOKJE5
   B8Gc2T5Huv1dNBUOQ9l0oi+B/SunH7+5ymfHDI0xMIV3V72odpI3Il56M
   4vDNycuPEEfz0NQ5RKA869sra/oodqNeB8g0PVxM8tKljPDFMtxAWEZXq
   tfSh2IiF96n9xrgLGVf07mqAuLILSz+N7XbcdtkxAYAps4nEZh0OoLuOg
   Q==;
X-CSE-ConnectionGUID: 7xQp7H6jSA2sYJvRmidfbg==
X-CSE-MsgGUID: tE6o33GWRtG3hkiPUuNMzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74558063"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="74558063"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 03:35:56 -0700
X-CSE-ConnectionGUID: ekCfp4eET3mJZLKFjZ9v3w==
X-CSE-MsgGUID: 6CppBvM4TBmk47j9dudZdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186007838"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2025 03:35:54 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEQ0W-000Lq0-1f;
	Thu, 30 Oct 2025 10:35:52 +0000
Date: Thu, 30 Oct 2025 18:34:58 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2] fs: hide names_cachep behind runtime access machinery
Message-ID: <202510301819.TojcyrUJ-lkp@intel.com>
References: <20251030085949.787504-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030085949.787504-1-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on linus/master brauner-vfs/vfs.all linux/master v6.18-rc3 next-20251030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/fs-hide-names_cachep-behind-runtime-access-machinery/20251030-170230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251030085949.787504-1-mjguzik%40gmail.com
patch subject: [PATCH v2] fs: hide names_cachep behind runtime access machinery
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20251030/202510301819.TojcyrUJ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251030/202510301819.TojcyrUJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510301819.TojcyrUJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:19,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from fs/namei.c:20:
   fs/namei.c: In function 'getname_flags':
>> include/linux/fs.h:2965:33: error: implicit declaration of function 'runtime_const_ptr' [-Wimplicit-function-declaration]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/alloc_tag.h:239:16: note: in definition of macro 'alloc_hooks_tag'
     239 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   fs/namei.c:146:18: note: in expansion of macro '__getname'
     146 |         result = __getname();
         |                  ^~~~~~~~~
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:239:16: note: in definition of macro 'alloc_hooks_tag'
     239 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   fs/namei.c:146:18: note: in expansion of macro '__getname'
     146 |         result = __getname();
         |                  ^~~~~~~~~
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:243:24: note: in definition of macro 'alloc_hooks_tag'
     243 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   fs/namei.c:146:18: note: in expansion of macro '__getname'
     146 |         result = __getname();
         |                  ^~~~~~~~~
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:246:24: note: in definition of macro 'alloc_hooks_tag'
     246 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   fs/namei.c:146:18: note: in expansion of macro '__getname'
     146 |         result = __getname();
         |                  ^~~~~~~~~
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
   In file included from fs/namei.c:22:
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:163:25: note: in expansion of macro '__putname'
     163 |                         __putname(result);
         |                         ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:169:25: note: in expansion of macro '__putname'
     169 |                         __putname(result);
         |                         ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:191:25: note: in expansion of macro '__putname'
     191 |                         __putname(kname);
         |                         ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:197:25: note: in expansion of macro '__putname'
     197 |                         __putname(kname);
         |                         ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:203:25: note: in expansion of macro '__putname'
     203 |                         __putname(kname);
         |                         ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:208:25: note: in expansion of macro '__putname'
     208 |                         __putname(kname);
         |                         ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
   fs/namei.c: In function 'getname_kernel':
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:239:16: note: in definition of macro 'alloc_hooks_tag'
     239 |         typeof(_do_alloc) _res;                                         \
         |                ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   fs/namei.c:249:18: note: in expansion of macro '__getname'
     249 |         result = __getname();
         |                  ^~~~~~~~~
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:243:24: note: in definition of macro 'alloc_hooks_tag'
     243 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   fs/namei.c:249:18: note: in expansion of macro '__getname'
     249 |         result = __getname();
         |                  ^~~~~~~~~
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_alloc_noprof' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/alloc_tag.h:246:24: note: in definition of macro 'alloc_hooks_tag'
     246 |                 _res = _do_alloc;                                       \
         |                        ^~~~~~~~~
   include/linux/slab.h:739:49: note: in expansion of macro 'alloc_hooks'
     739 | #define kmem_cache_alloc(...)                   alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
         |                                                 ^~~~~~~~~~~
   include/linux/fs.h:2968:33: note: in expansion of macro 'kmem_cache_alloc'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                 ^~~~~~~~~~~~~~~~
   include/linux/fs.h:2968:50: note: in expansion of macro '__names_cachep'
    2968 | #define __getname()             kmem_cache_alloc(__names_cachep, GFP_KERNEL)
         |                                                  ^~~~~~~~~~~~~~
   fs/namei.c:249:18: note: in expansion of macro '__getname'
     249 |         result = __getname();
         |                  ^~~~~~~~~
   include/linux/slab.h:737:50: note: expected 'struct kmem_cache *' but argument is of type 'int'
     737 | void *kmem_cache_alloc_noprof(struct kmem_cache *cachep,
         |                               ~~~~~~~~~~~~~~~~~~~^~~~~~
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:261:25: note: in expansion of macro '__putname'
     261 |                         __putname(result);
         |                         ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:267:17: note: in expansion of macro '__putname'
     267 |                 __putname(result);
         |                 ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
   fs/namei.c: In function 'putname':
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:294:17: note: in expansion of macro '__putname'
     294 |                 __putname(name->name);
         |                 ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
>> include/linux/fs.h:2965:33: error: passing argument 1 of 'kmem_cache_free' makes pointer from integer without a cast [-Wint-conversion]
    2965 | #define __names_cachep          runtime_const_ptr(names_cachep)
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 |
         |                                 int
   include/linux/fs.h:2969:49: note: in expansion of macro '__names_cachep'
    2969 | #define __putname(name)         kmem_cache_free(__names_cachep, (void *)(name))
         |                                                 ^~~~~~~~~~~~~~
   fs/namei.c:297:17: note: in expansion of macro '__putname'
     297 |                 __putname(name);
         |                 ^~~~~~~~~
   include/linux/slab.h:774:41: note: expected 'struct kmem_cache *' but argument is of type 'int'
     774 | void kmem_cache_free(struct kmem_cache *s, void *objp);
         |                      ~~~~~~~~~~~~~~~~~~~^
..


vim +/runtime_const_ptr +2965 include/linux/fs.h

  2958	
  2959	/*
  2960	 * XXX The runtime_const machinery does not support modules at the moment.
  2961	 */
  2962	#ifdef MODULE
  2963	#define __names_cachep		names_cachep
  2964	#else
> 2965	#define __names_cachep		runtime_const_ptr(names_cachep)
  2966	#endif
  2967	
> 2968	#define __getname()		kmem_cache_alloc(__names_cachep, GFP_KERNEL)
  2969	#define __putname(name)		kmem_cache_free(__names_cachep, (void *)(name))
  2970	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

