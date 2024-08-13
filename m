Return-Path: <linux-fsdevel+bounces-25746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E794094FB3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17292817CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B8D14A84;
	Tue, 13 Aug 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mATUPb69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04B79F2;
	Tue, 13 Aug 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513384; cv=none; b=HHnxNTyNpdRHVGj9s/gWqeLkF79AL9gZa4AdO0+5aydDV4dUqmQ7H9OK3JS8cVg36w4Wn+Tah26jxYJGWultOajI/eKr1XkfoYX8if4U4zTHj5nkmJ/x81F1eGBNdUC6QUZ9MwJlhVXmkHG5vjVJeLizjmciS5tiGL1N7dPnWM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513384; c=relaxed/simple;
	bh=X98D4Hrp5gavWx2LzLv+TL5jOo0DwAnTckze8fwwUI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN1UW+p6z6fMoMOMK2kZZeXZMP7GFgzAflIxZnNr8Ycxo1n4aSWZJrLmYOo15KCZXTJC4Gb8Tuzjgv1pSDKDFlZHXjiI0HHwlPHIhv4gB5wNfJDF/LI/OB5qy+i7KrY1IFq1JSJcWc9+fa6lxznkKBWM3W8ke3gaXG6JEnNi3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mATUPb69; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723513381; x=1755049381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X98D4Hrp5gavWx2LzLv+TL5jOo0DwAnTckze8fwwUI0=;
  b=mATUPb69D7qHkNTl34Rjj3VNFHHjJDCNrvVNLk2wdZRe329g31Fmv3bZ
   6p3xHI2FZg0cIlhYTzhdCBLGQdanmd8atbU6U6gADjt4RSi+lUe9kDBaa
   Wekj8JXxqmEWXaVeiTaAKTLZvPb1wxAQTPn+TfiU9PHBIbhEQKTQjn3X7
   WXR4zape0i6JS1ILEm2sSC5m4hqQtxGJyB2IyVdNXBXyAM3AydW25kkuN
   Tk9hjD/bfJ5bV5sFNwHA6QyI2xQOYnfJzaocxmRzE0MBpoznk6375xTCf
   DFdBjRE9Ta1E4Q2KWJyggEAxuJ+c+cxoIbcw8UeimJDj/d0X0acZw/q7W
   A==;
X-CSE-ConnectionGUID: 1PlY5Fb5Tq6/B5dDRNG2Kw==
X-CSE-MsgGUID: ryJD+P2xQcOza0S9yd1/Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21523511"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="21523511"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:42:59 -0700
X-CSE-ConnectionGUID: Jfpnp7LUSI+t5ms0ej9Jnw==
X-CSE-MsgGUID: NufWMK8ARDG0V1gu4xElxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="81733530"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2024 18:42:56 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdgYm-000CJ5-2G;
	Tue, 13 Aug 2024 01:42:52 +0000
Date: Tue, 13 Aug 2024 09:42:28 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202408130900.y6a7Si8X-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-003-20240813 (https://download.01.org/0day-ci/archive/20240813/202408130900.y6a7Si8X-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408130900.y6a7Si8X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408130900.y6a7Si8X-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:10: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:31: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:510:22: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:498:23: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:490:9: note: expanded from macro '__compiletime_assert'
     490 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:466:13: note: expanded from macro '__unqual_scalar_typeof'
     466 |                 _Generic((x),                                           \
         |                           ^
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:473:15: note: expanded from macro '__unqual_scalar_typeof'
     473 |                          default: (x)))
         |                                    ^
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:527:53: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
>> fs/fcntl.c:250:14: error: cannot take the address of an rvalue of type 'const struct cred *'
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                     ^               ~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:747:28: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                            ^                     ~
   include/linux/rcupdate.h:675:2: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |         ^                        ~
   include/linux/rcupdate.h:527:43: note: expanded from macro '__rcu_dereference_check'
     527 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^         ~
   include/asm-generic/rwonce.h:50:2: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^           ~
   include/asm-generic/rwonce.h:44:70: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                       ^ ~
>> fs/fcntl.c:250:43: error: member reference type 'struct fown_struct' is not a pointer; did you mean to use '.'?
     250 |         fown_cred = rcu_dereference(filp->f_owner->cred);
         |                                     ~~~~~~~~~~~~~^~
         |                                                  .
   include/linux/rcupdate.h:747:50: note: expanded from macro 'rcu_dereference'
     747 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
         |                                                  ^
   include/linux/rcupdate.h:675:27: note: expanded from macro 'rcu_dereference_check'
     675 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
         |                                  ^
   include/linux/rcupdate.h:530:12: note: expanded from macro '__rcu_dereference_check'
     530 |         ((typeof(*p) __force __kernel *)(local)); \
         |                   ^
   12 errors generated.


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

