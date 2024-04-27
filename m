Return-Path: <linux-fsdevel+bounces-17955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D328B43CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 04:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116A8B2275F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 02:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4743A1CA;
	Sat, 27 Apr 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iu7eeWHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796B38DD3;
	Sat, 27 Apr 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714184008; cv=none; b=lo0oHMiCGayxhiye/ZAH72vk66y3QkX6D3E390CQdBSzVrl2TsMlzRwHpLZR2psd/1LKIj16rYT7m6cRSR3HemuC51RJgLVRKMzNBeU6TxdbtRw/z6Vq86txWvewEP0RoSDm1aPmSBYutg4ZplvYWjXflmwcFAlr4ytOfzHx3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714184008; c=relaxed/simple;
	bh=mUMUrbQLiUpX9NYt2dA5/tf55Sg+3Kcz3fQlfMcnBZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCjQKJ138w1RUPpKAJU8tnAO0hJP9hUedcjh+bz8npnCMt1yFrB/IvId3Y5GXFlHlASxxhGfmr4WDrcRFJwzGIkobXW+UklO1Oj4Kq0f4z+fIVLMBLEtpwZfCOFIvuNBK2pJJpfJld07fK1UimWuX8AuWhtP6RyWnZaBav0KYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iu7eeWHu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714184007; x=1745720007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mUMUrbQLiUpX9NYt2dA5/tf55Sg+3Kcz3fQlfMcnBZc=;
  b=Iu7eeWHuRCx0cAlUwMw+Z/IA75Qh64rw+x2aaQrtNOkfFtUvFfIni3th
   QOHYrw7PMy1KkefpuFitBSQp2jQLNSfyiuz6Qhm3jNVIJRp7fSRe3B8bg
   VcJO8pNrVi2jf2BK14RMZD2jDZPbm06fWSf/p9rjplGvyqmHH/SZS/H68
   vt+xI1M5xNFYaAIUMwBvb/Nj5LocboQ+LsebdQtapIIKqahaXnn6ZomOo
   XuQ3DsiOI0FqeHc7QNUPQzAPfR9+K6sYx77ta4vPAMl0JWfuzws3Wwv1y
   by+2AFs3QOmts0W80xgwP8azuWmE32DPisjW9pa5PKj5v4qrlyQ5JJcHC
   A==;
X-CSE-ConnectionGUID: t2MQr63tSvy+4NQFLLcaBg==
X-CSE-MsgGUID: LioEa0Y1TyWit1hvYBa/UQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9807451"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="9807451"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 19:13:26 -0700
X-CSE-ConnectionGUID: wFzIK+9URxC4/DWnIoBvmQ==
X-CSE-MsgGUID: 8TidxXTOQ6KewX51Jb2KBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="30228341"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 19:13:21 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0XZ0-0004ZK-1O;
	Sat, 27 Apr 2024 02:13:18 +0000
Date: Sat, 27 Apr 2024 10:12:33 +0800
From: kernel test robot <lkp@intel.com>
To: Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Stas Sergeev <stsp2@yandex.ru>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	Arnd Bergmann <arnd@arndb.de>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Pavel Begunkov <asml.silence@gmail.com>, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 2/3] open: add O_CRED_ALLOW flag
Message-ID: <202404270923.bAeBIJt1-lkp@intel.com>
References: <20240426133310.1159976-3-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426133310.1159976-3-stsp2@yandex.ru>

Hi Stas,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9-rc5 next-20240426]
[cannot apply to arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stas-Sergeev/fs-reorganize-path_openat/20240426-214030
base:   linus/master
patch link:    https://lore.kernel.org/r/20240426133310.1159976-3-stsp2%40yandex.ru
patch subject: [PATCH v5 2/3] open: add O_CRED_ALLOW flag
config: parisc-allnoconfig (https://download.01.org/0day-ci/archive/20240427/202404270923.bAeBIJt1-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240427/202404270923.bAeBIJt1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404270923.bAeBIJt1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   fs/fcntl.c: In function 'fcntl_init':
>> include/linux/compiler_types.h:449:45: error: call to '__compiletime_assert_297' declared with attribute error: BUILD_BUG_ON failed: 22 - 1 != HWEIGHT32( (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) | __FMODE_EXEC | __FMODE_NONOTIFY)
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:430:25: note: in definition of macro '__compiletime_assert'
     430 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:449:9: note: in expansion of macro '_compiletime_assert'
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   fs/fcntl.c:1042:9: note: in expansion of macro 'BUILD_BUG_ON'
    1042 |         BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_297 +449 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  435  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  436  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  437  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  438  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  439  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  440   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  441   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  442   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  443   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  444   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  445   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  446   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  447   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  448  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @449  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  450  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

