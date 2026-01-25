Return-Path: <linux-fsdevel+bounces-75387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MoXGFn1DdmmXOQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 17:23:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8548168F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 605CC30062FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878930DD13;
	Sun, 25 Jan 2026 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNm+x/Cs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD121018A;
	Sun, 25 Jan 2026 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769358197; cv=none; b=U+xExA3O2iwG9tiOS0f9/DoY18jnEt//OwI3l4KYOfdTWuVECxJMYGF2clG6tdo6jOBMKaSAjwakZJlc33TJfepWnhmCcJpMGigHDjM+YQJ204LMRZLYhS+0DM+z62uHlBsQ3sAC2NZyRhsdXX67SUJBvr+qx3BqqVcmS4VVz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769358197; c=relaxed/simple;
	bh=Q+C3PlAHFFClJm32UkwPQpUTYsed3vglsbB5dFYDyRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj0F30Jc/+HrTdFHaGa54kuL3vtn+puZAGpBjPwSbTGTVeo5coT+Dz4/AKnYMIEFwbQhTqQYDwWDkITtpHT3Pa/NzPDyTBkVEa6awqXeoeMwhj7FcFVWTm7scl3YfJ8oE+EKPkCqr6izbaCMEx+pa8Oj0xwe1fu34VO/AaAVhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNm+x/Cs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769358197; x=1800894197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q+C3PlAHFFClJm32UkwPQpUTYsed3vglsbB5dFYDyRs=;
  b=dNm+x/Cs+Am3DUCamFiuMVJifM+DPqHxrN9iOjB2jO/ggYqUKUnrQuDh
   6sjPgEI5H1AKCyDaWt8p3P9wqAnFvIP65FLtHSCP7qUBQmCB0deLiaPzk
   ujmQfyYfQoXVc2B0fyhiuDwgnmziyPmYuC3BL5NkJ3/9YHNZ+YLFaV9FV
   5Ktk644qm9kK+dgUoWRmXuWZ+GEp+2eOZPJ9iXYsvwmIKVaimeJ+HzzeI
   ReDmjzmEM9HNRGHoryO9IXgagFKkfohyl29lB4vMSwqe+ofeK94FMBU48
   nQ9XRm0NG1O374tSQR41H82rUmykfVmnJevoPiDTEBkaI0xFsUAGEIuY2
   A==;
X-CSE-ConnectionGUID: BjHZMqhgSCOby/u3yHSE8w==
X-CSE-MsgGUID: 6Phhh9RHQIWlx7teFmav2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="81180954"
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="81180954"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 08:23:16 -0800
X-CSE-ConnectionGUID: 16wwdm3mQgyBkh2BeM+bEg==
X-CSE-MsgGUID: SlVq3XsoS6CgXeqEGfs4hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="211947092"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jan 2026 08:23:13 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vk2tK-00000000WBG-3BZ1;
	Sun, 25 Jan 2026 16:23:10 +0000
Date: Mon, 26 Jan 2026 00:22:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com,
	arnd@arndb.de
Subject: Re: [PATCH 1/2] open: new O_REGULAR flag support
Message-ID: <202601260042.TRDQjGeu-lkp@intel.com>
References: <20260125141518.59493-2-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125141518.59493-2-dorjoychy111@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-75387-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8E8548168F
X-Rspamd-Action: no action

Hi Dorjoy,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on shuah-kselftest/next shuah-kselftest/fixes linus/master arnd-asm-generic/master v6.19-rc6 next-20260123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dorjoy-Chowdhury/open-new-O_REGULAR-flag-support/20260125-221826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260125141518.59493-2-dorjoychy111%40gmail.com
patch subject: [PATCH 1/2] open: new O_REGULAR flag support
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260126/202601260042.TRDQjGeu-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260126/202601260042.TRDQjGeu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601260042.TRDQjGeu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   fs/fcntl.c: In function 'fcntl_init':
>> include/linux/compiler_types.h:631:45: error: call to '__compiletime_assert_389' declared with attribute error: BUILD_BUG_ON failed: 21 - 1 != HWEIGHT32( (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) | __FMODE_EXEC)
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:612:25: note: in definition of macro '__compiletime_assert'
     612 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:631:9: note: in expansion of macro '_compiletime_assert'
     631 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   fs/fcntl.c:1172:9: note: in expansion of macro 'BUILD_BUG_ON'
    1172 |         BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_389 +631 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  617  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  618  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  619  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  620  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  621  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  622   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  623   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  624   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  625   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  626   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  627   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  628   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  629   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  630  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @631  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  632  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

