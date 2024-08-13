Return-Path: <linux-fsdevel+bounces-25743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FDE94FB1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E61C21055
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB438BEF;
	Tue, 13 Aug 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ax95sYAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC66FB6;
	Tue, 13 Aug 2024 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512781; cv=none; b=YkOdA5kGxbK6xlVeZauTwWnnRFHXW+xX/iZENGO6eXWmmIeVXjTLfnrwv4V7e6/hu6Mk95H3CzTyslLqPQOum960FxeceXmapC61dEGOugkzxAyCIvPNH428PaOtt4mx7Sae+AkAfrzIxdbdcwrPArGZtH5SRuZGXJ549Y0JZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512781; c=relaxed/simple;
	bh=d7rkJa+XgKxkxXo29e6j20CjYOG0j9txtHC5RxiHnks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8KHcKUISxdWjullKosb8Zil0Mx7++QrA7/pIBLSE6Q7Ns6La9/Dt8iI/PHgAUr83HXNkGWvCqucCcve9lVXpVORDN1cPbRGBqTfIffz73RjlmpvN+ViZWWrJ4q2phfcc1aWDJXWemfRLHyHYy88EOH94oxjvLUlbPme+4w4u34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ax95sYAr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723512779; x=1755048779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d7rkJa+XgKxkxXo29e6j20CjYOG0j9txtHC5RxiHnks=;
  b=ax95sYArbJcYGRZsrFX530r8ue+bGDIlGPRf5+4GgL1aVx8hpE6O0vfX
   3R1yirTaFeaiCindtRj68s8oT1AV2C91Mp9ID+2xCbUj7+4Zter+i/WDS
   KUHRMRWeeNfwxSERjf7zGt9KyhZmeRpmZ4EfRsAKdRXBeq2mATvQajplg
   Q5BMNMOJJ+fdzKcKi0MyA+5r+/ISDkc2Ys7HZkq8QsnQcuObxV820bglS
   3DdOcajjPHap0g7GigZjlXg/E8sk0Yfu2N6dzmgcuVlkBvBmmCij9KYPM
   LxOBd9cqvzAMUMJXPkbh12t82xAjkhG+xIAR2TisHS8Q5UT/UEEiV8D9s
   w==;
X-CSE-ConnectionGUID: tmLXarl7SWu3gdFr1Eyalw==
X-CSE-MsgGUID: /ITsAU3SR7etaNlPCTLooA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21211777"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21211777"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:32:58 -0700
X-CSE-ConnectionGUID: yqZViuuYRGOeieZx5mh1iw==
X-CSE-MsgGUID: przRYNljRdivCmlLgYdkrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="58171078"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 12 Aug 2024 18:32:54 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdgP6-000CIh-1c;
	Tue, 13 Aug 2024 01:32:52 +0000
Date: Tue, 13 Aug 2024 09:32:10 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: oe-kbuild-all@lists.linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
	Casey Schaufler <casey@schaufler-ca.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] fs,security: Fix file_set_fowner LSM hook inconsistencies
Message-ID: <202408130919.naHeqbVw-lkp@intel.com>
References: <20240812144936.1616628-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812144936.1616628-1-mic@digikod.net>

Hi Mickaël,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v6.11-rc3 next-20240812]
[cannot apply to brauner-vfs/vfs.all]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/fs-security-Fix-file_set_fowner-LSM-hook-inconsistencies/20240813-004648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20240812144936.1616628-1-mic%40digikod.net
patch subject: [PATCH] fs,security: Fix file_set_fowner LSM hook inconsistencies
config: i386-buildonly-randconfig-002-20240813 (https://download.01.org/0day-ci/archive/20240813/202408130919.naHeqbVw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408130919.naHeqbVw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408130919.naHeqbVw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/rculist.h:11,
                    from include/linux/dcache.h:8,
                    from include/linux/fs.h:8,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:82,
                    from fs/fcntl.c:8:
   fs/fcntl.c: In function 'f_getowner_uids':
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/rcupdate.h:527:17: note: in definition of macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/rcupdate.h:527:38: note: in definition of macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
   In file included from <command-line>:
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/compiler_types.h:490:23: note: in definition of macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:527:50: note: in expansion of macro 'READ_ONCE'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:675:9: note: in expansion of macro '__rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/compiler_types.h:490:23: note: in definition of macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:527:50: note: in expansion of macro 'READ_ONCE'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:675:9: note: in expansion of macro '__rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/compiler_types.h:490:23: note: in definition of macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:527:50: note: in expansion of macro 'READ_ONCE'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:675:9: note: in expansion of macro '__rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/compiler_types.h:490:23: note: in definition of macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:527:50: note: in expansion of macro 'READ_ONCE'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:675:9: note: in expansion of macro '__rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/compiler_types.h:490:23: note: in definition of macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:527:50: note: in expansion of macro 'READ_ONCE'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:675:9: note: in expansion of macro '__rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/compiler_types.h:466:27: note: in definition of macro '__unqual_scalar_typeof'
     466 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/rcupdate.h:527:50: note: in expansion of macro 'READ_ONCE'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:675:9: note: in expansion of macro '__rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:305,
                    from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from include/linux/fs.h:5:
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/linux/rcupdate.h:527:50: note: in expansion of macro 'READ_ONCE'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:675:9: note: in expansion of macro '__rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~
>> fs/fcntl.c:250:50: error: invalid type argument of '->' (have 'struct fown_struct')
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                                  ^~
   include/linux/rcupdate.h:530:19: note: in definition of macro '__rcu_dereference_check'
     530 |         ((typeof(*p) __force __kernel *)(local)); \
         |                   ^
   include/linux/rcupdate.h:747:28: note: in expansion of macro 'rcu_dereference_check'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^~~~~~~~~~~~~~~~~~~~~
   fs/fcntl.c:250:21: note: in expansion of macro 'rcu_dereference'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^~~~~~~~~~~~~~~


vim +250 fs/fcntl.c

   239	
   240	#ifdef CONFIG_CHECKPOINT_RESTORE
   241	static int f_getowner_uids(struct file *filp, unsigned long arg)
   242	{
   243		struct user_namespace *user_ns = current_user_ns();
   244		uid_t __user *dst = (void __user *)arg;
   245		const struct cred *fown_cred;
   246		uid_t src[2];
   247		int err;
   248	
   249		rcu_read_lock();
 > 250		fown_cred = rcu_dereference(filp->f_owner->cred);
   251		src[0] = from_kuid(user_ns, fown_cred->uid);
   252		src[1] = from_kuid(user_ns, fown_cred->euid);
   253		rcu_read_unlock();
   254	
   255		err  = put_user(src[0], &dst[0]);
   256		err |= put_user(src[1], &dst[1]);
   257	
   258		return err;
   259	}
   260	#else
   261	static int f_getowner_uids(struct file *filp, unsigned long arg)
   262	{
   263		return -EINVAL;
   264	}
   265	#endif
   266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

