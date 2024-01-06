Return-Path: <linux-fsdevel+bounces-7502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A86825F4D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 12:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29BC284478
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D866FAE;
	Sat,  6 Jan 2024 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvgLnnCw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D96AA3;
	Sat,  6 Jan 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704538842; x=1736074842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2X/qUnvON1PyMX3HuXoxp4vXuL7aKUw6vkNMr+e6tJw=;
  b=dvgLnnCwkEEqEn3Fjh5AlHdyGL1mrIV+msxbkDOMwhrbhGipV8NTG6pY
   PfQSaEQkZv+tqu5Ty7KDRIb3BkZbfqycf71fVfg4LdGgUvvfcXzuF1w6A
   ae5uD6KvXihQuLVTMr7GCs39+CPRCtJd33KwRZx6YF6iJOknUF60qZhwo
   KE1vxJN5LwzxEDKh01fb9YvgerRUlTvl/bjDCFmz0Nqx3R4MKUnNXKXv4
   QVDQ8mmejv0gkzD+iqgs96fjFL03o9D2UNghNFJFxOBGDchc0s2pjH8ws
   PE+Br15zFKhxGGYYwW/nimtOOEh/OsdX1cowqx6B8G1CVjtlL+RO7eDNV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="11005365"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="11005365"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 03:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="904365585"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="904365585"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Jan 2024 03:00:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM4Pf-0002Nn-1G;
	Sat, 06 Jan 2024 11:00:23 +0000
Date: Sat, 6 Jan 2024 18:59:56 +0800
From: kernel test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	kexec@lists.infradead.org, hbathini@linux.ibm.com, arnd@arndb.de,
	ignat@cloudflare.com, eric_devolder@yahoo.com,
	viro@zeniv.linux.org.uk, ebiederm@xmission.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/5] kexec_core: move kdump related codes from
 crash_core.c to kexec_core.c
Message-ID: <202401061800.3XPSaPsa-lkp@intel.com>
References: <20240105103305.557273-2-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105103305.557273-2-bhe@redhat.com>

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc8]
[cannot apply to powerpc/next powerpc/fixes tip/x86/core arm64/for-next/core next-20240105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/kexec_core-move-kdump-related-codes-from-crash_core-c-to-kexec_core-c/20240105-223735
base:   linus/master
patch link:    https://lore.kernel.org/r/20240105103305.557273-2-bhe%40redhat.com
patch subject: [PATCH 1/5] kexec_core: move kdump related codes from crash_core.c to kexec_core.c
config: x86_64-randconfig-104-20240106 (https://download.01.org/0day-ci/archive/20240106/202401061800.3XPSaPsa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061800.3XPSaPsa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061800.3XPSaPsa-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:11,
                    from include/linux/bitmap.h:12,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from arch/x86/kernel/crash.c:18:
   arch/x86/kernel/crash.c: In function 'fill_up_crash_elf_data':
>> include/linux/overflow.h:293:23: error: invalid application of 'sizeof' to incomplete type 'struct crash_mem'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                       ^
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
>> include/linux/overflow.h:277:38: error: invalid use of undefined type 'struct crash_mem'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                      ^~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:22,
                    from arch/x86/kernel/crash.c:17:
   include/linux/overflow.h:277:69: error: invalid use of undefined type 'struct crash_mem'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                     ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:228:51: note: in expansion of macro '__same_type'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:277:50: note: in expansion of macro '__must_be_array'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:277:69: error: invalid use of undefined type 'struct crash_mem'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                     ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:228:51: note: in expansion of macro '__same_type'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:277:50: note: in expansion of macro '__must_be_array'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:228:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/overflow.h:277:50: note: in expansion of macro '__must_be_array'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:278:44: error: invalid use of undefined type 'struct crash_mem'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                            ^~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:278:75: error: invalid use of undefined type 'struct crash_mem'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                           ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:228:51: note: in expansion of macro '__same_type'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:278:56: note: in expansion of macro '__must_be_array'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:278:75: error: invalid use of undefined type 'struct crash_mem'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                           ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:228:51: note: in expansion of macro '__same_type'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:278:56: note: in expansion of macro '__must_be_array'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:228:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/overflow.h:278:56: note: in expansion of macro '__must_be_array'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:294:32: error: invalid application of 'sizeof' to incomplete type 'struct crash_mem'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                ^
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
>> include/linux/overflow.h:277:38: error: invalid use of undefined type 'struct crash_mem'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                      ^~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:277:69: error: invalid use of undefined type 'struct crash_mem'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                     ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:228:51: note: in expansion of macro '__same_type'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:277:50: note: in expansion of macro '__must_be_array'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:277:69: error: invalid use of undefined type 'struct crash_mem'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                                     ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:228:51: note: in expansion of macro '__same_type'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:277:50: note: in expansion of macro '__must_be_array'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:228:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/overflow.h:277:50: note: in expansion of macro '__must_be_array'
     277 |                 (count) * sizeof(*(p)->member) + __must_be_array((p)->member),  \
         |                                                  ^~~~~~~~~~~~~~~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:278:44: error: invalid use of undefined type 'struct crash_mem'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                            ^~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:278:75: error: invalid use of undefined type 'struct crash_mem'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                           ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:228:51: note: in expansion of macro '__same_type'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:278:56: note: in expansion of macro '__must_be_array'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/overflow.h:278:75: error: invalid use of undefined type 'struct crash_mem'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                                           ^~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/compiler.h:228:51: note: in expansion of macro '__same_type'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                                   ^~~~~~~~~~~
   include/linux/overflow.h:278:56: note: in expansion of macro '__must_be_array'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:228:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/overflow.h:278:56: note: in expansion of macro '__must_be_array'
     278 |                 size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
         |                                                        ^~~~~~~~~~~~~~~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c:154:24: note: in expansion of macro 'struct_size'
     154 |         cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
         |                        ^~~~~~~~~~~
>> arch/x86/kernel/crash.c:158:13: error: invalid use of undefined type 'struct crash_mem'
     158 |         cmem->max_nr_ranges = nr_ranges;
         |             ^~
   arch/x86/kernel/crash.c:159:13: error: invalid use of undefined type 'struct crash_mem'
     159 |         cmem->nr_ranges = 0;
         |             ^~
   arch/x86/kernel/crash.c: In function 'elf_header_exclude_ranges':
>> arch/x86/kernel/crash.c:173:15: error: implicit declaration of function 'crash_exclude_mem_range' [-Werror=implicit-function-declaration]
     173 |         ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
         |               ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/crash.c: In function 'prepare_elf64_ram_headers_callback':
   arch/x86/kernel/crash.c:193:13: error: invalid use of undefined type 'struct crash_mem'
     193 |         cmem->ranges[cmem->nr_ranges].start = res->start;
         |             ^~
   arch/x86/kernel/crash.c:193:26: error: invalid use of undefined type 'struct crash_mem'
     193 |         cmem->ranges[cmem->nr_ranges].start = res->start;
         |                          ^~
   arch/x86/kernel/crash.c:194:13: error: invalid use of undefined type 'struct crash_mem'
     194 |         cmem->ranges[cmem->nr_ranges].end = res->end;
         |             ^~
   arch/x86/kernel/crash.c:194:26: error: invalid use of undefined type 'struct crash_mem'
     194 |         cmem->ranges[cmem->nr_ranges].end = res->end;
         |                          ^~
   arch/x86/kernel/crash.c:195:13: error: invalid use of undefined type 'struct crash_mem'
     195 |         cmem->nr_ranges++;
         |             ^~
   arch/x86/kernel/crash.c: In function 'prepare_elf_headers':
   arch/x86/kernel/crash.c:221:30: error: invalid use of undefined type 'struct crash_mem'
     221 |         *nr_mem_ranges = cmem->nr_ranges;
         |                              ^~
>> arch/x86/kernel/crash.c:224:16: error: implicit declaration of function 'crash_prepare_elf64_headers'; did you mean 'prepare_elf_headers'? [-Werror=implicit-function-declaration]
     224 |         ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                prepare_elf_headers
   cc1: some warnings being treated as errors


vim +293 include/linux/overflow.h

610b15c50e86eb Kees Cook           2018-05-07  262  
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  263  /**
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  264   * flex_array_size() - Calculate size of a flexible array member
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  265   *                     within an enclosing structure.
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  266   * @p: Pointer to the structure.
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  267   * @member: Name of the flexible array member.
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  268   * @count: Number of elements in the array.
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  269   *
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  270   * Calculates size of a flexible array of @count number of @member
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  271   * elements, at the end of structure @p.
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  272   *
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  273   * Return: number of bytes needed or SIZE_MAX on overflow.
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  274   */
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  275  #define flex_array_size(p, member, count)				\
230f6fa2c1db6a Kees Cook           2022-02-09  276  	__builtin_choose_expr(__is_constexpr(count),			\
230f6fa2c1db6a Kees Cook           2022-02-09 @277  		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
230f6fa2c1db6a Kees Cook           2022-02-09  278  		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
b19d57d0f3cc6f Gustavo A. R. Silva 2020-06-08  279  
e1be43d9b5d0d1 Kees Cook           2021-09-18  280  /**
e1be43d9b5d0d1 Kees Cook           2021-09-18  281   * struct_size() - Calculate size of structure with trailing flexible array.
e1be43d9b5d0d1 Kees Cook           2021-09-18  282   * @p: Pointer to the structure.
e1be43d9b5d0d1 Kees Cook           2021-09-18  283   * @member: Name of the array member.
e1be43d9b5d0d1 Kees Cook           2021-09-18  284   * @count: Number of elements in the array.
e1be43d9b5d0d1 Kees Cook           2021-09-18  285   *
d67790ddf0219a Kees Cook           2023-05-22  286   * Calculates size of memory needed for structure of @p followed by an
e1be43d9b5d0d1 Kees Cook           2021-09-18  287   * array of @count number of @member elements.
e1be43d9b5d0d1 Kees Cook           2021-09-18  288   *
e1be43d9b5d0d1 Kees Cook           2021-09-18  289   * Return: number of bytes needed or SIZE_MAX on overflow.
e1be43d9b5d0d1 Kees Cook           2021-09-18  290   */
e1be43d9b5d0d1 Kees Cook           2021-09-18  291  #define struct_size(p, member, count)					\
230f6fa2c1db6a Kees Cook           2022-02-09  292  	__builtin_choose_expr(__is_constexpr(count),			\
230f6fa2c1db6a Kees Cook           2022-02-09 @293  		sizeof(*(p)) + flex_array_size(p, member, count),	\
230f6fa2c1db6a Kees Cook           2022-02-09  294  		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
e1be43d9b5d0d1 Kees Cook           2021-09-18  295  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

