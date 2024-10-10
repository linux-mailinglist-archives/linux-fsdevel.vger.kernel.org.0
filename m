Return-Path: <linux-fsdevel+bounces-31511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF60997CBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 07:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121B61F231EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 05:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E51192D62;
	Thu, 10 Oct 2024 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYYjZ8LO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE718C03D
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539454; cv=none; b=qy6ZxZRQEgzgVbRaawOxulEklZ8FIBui/WLH61rufl9HhUqXnKeAObGfrla8qHAhsaun3K3evoeU3U1gDWFCmpK/lf4xEDBRS3prvgSjYGgnom1uYtfO3cY3WcsNTSkT6J6bZUdZ4AcgnaMqCZW4/WOmuZkT+wBo9hitCF91wRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539454; c=relaxed/simple;
	bh=AmA6sqkOCSne/bl7i0P6cizwJB9nJBNvrv4IdKyPL/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KdN8m8B3Fxupk/fKa45tIbNk/ZHa7dPiZqntIZUzS3zhhtYBSm8/W5rMctX7aTj+m4s+vZB7m2e35rvdnEjRJEvzv8EC70ZI5nuLuqIXytxSaS61+FzTLxWtTfV7LiKBAXZ1Toiuwsor5E5TNjaVSJvYmDaDwekZuhnIN/hCqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYYjZ8LO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728539451; x=1760075451;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AmA6sqkOCSne/bl7i0P6cizwJB9nJBNvrv4IdKyPL/w=;
  b=BYYjZ8LOy1T6rHOCmRFekI60ucohTvFdB153dtLwGPrmOjH8OnGd4iE4
   MpAWW+8mFQ9LdMSVYEDuva1gRrt7YVTN6siaKQ6xQeVq0tOzzFLYsdzF8
   9Hprm9YtCIzxAzff1pdMrmYXCVu97D+MKEBCmJSDx/tAGp/vpkJf9RLRE
   e14jmZA9XOgNiF5KOXRNjrClXEB/xDuYqhmyWOELHXmQHIvfkODoamlaR
   ezI9Y9CshoNMmqvO1CtmNTPtHnmviFbwPTcjYPgsqd4dN+qXCQTRkfTpY
   Fkw6GrCs0PLE1du1BH9GyVKnuAVPWn9KqA0lh0e8Wi7FBCgS3QcadttDi
   w==;
X-CSE-ConnectionGUID: nH0R4RKwQzeb1NhH1U9lCQ==
X-CSE-MsgGUID: xFqCCLVcRfigEBYVuUVrNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27824330"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="27824330"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 22:50:51 -0700
X-CSE-ConnectionGUID: Gxfx00wJQXS2HYMwN8vjAg==
X-CSE-MsgGUID: /Ij/Pl05SS6iabzdQc3VWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76799202"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2024 22:50:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sym4V-000AEr-1D;
	Thu, 10 Oct 2024 05:50:47 +0000
Date: Thu, 10 Oct 2024 13:49:55 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.statx 1/3] fs/stat.c:770:11: warning: variable
 'lflags' set but not used
Message-ID: <202410101304.S1BUv98j-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.statx
head:   6bf8aea1847ea450c5bc8de1b7ef194c70e417ff
commit: 8b3d898afb729019f0627a61f34622d115f54581 [1/3] getname_maybe_null() - the third variant of pathname copy-in
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241010/202410101304.S1BUv98j-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101304.S1BUv98j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101304.S1BUv98j-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/stat.c:770:11: warning: variable 'lflags' set but not used [-Wunused-but-set-variable]
     770 |         unsigned lflags;
         |                  ^
   1 warning generated.


vim +/lflags +770 fs/stat.c

0ef625bba6fb2b Mateusz Guzik 2024-06-25  751  
a528d35e8bfcc5 David Howells 2017-01-31  752  /**
a528d35e8bfcc5 David Howells 2017-01-31  753   * sys_statx - System call to get enhanced stats
a528d35e8bfcc5 David Howells 2017-01-31  754   * @dfd: Base directory to pathwalk from *or* fd to stat.
0ef625bba6fb2b Mateusz Guzik 2024-06-25  755   * @filename: File to stat or either NULL or "" with AT_EMPTY_PATH
a528d35e8bfcc5 David Howells 2017-01-31  756   * @flags: AT_* flags to control pathwalk.
a528d35e8bfcc5 David Howells 2017-01-31  757   * @mask: Parts of statx struct actually required.
a528d35e8bfcc5 David Howells 2017-01-31  758   * @buffer: Result buffer.
a528d35e8bfcc5 David Howells 2017-01-31  759   *
1e2f82d1e9d122 David Howells 2017-04-26  760   * Note that fstat() can be emulated by setting dfd to the fd of interest,
0ef625bba6fb2b Mateusz Guzik 2024-06-25  761   * supplying "" (or preferably NULL) as the filename and setting AT_EMPTY_PATH
0ef625bba6fb2b Mateusz Guzik 2024-06-25  762   * in the flags.
a528d35e8bfcc5 David Howells 2017-01-31  763   */
a528d35e8bfcc5 David Howells 2017-01-31  764  SYSCALL_DEFINE5(statx,
a528d35e8bfcc5 David Howells 2017-01-31  765  		int, dfd, const char __user *, filename, unsigned, flags,
a528d35e8bfcc5 David Howells 2017-01-31  766  		unsigned int, mask,
a528d35e8bfcc5 David Howells 2017-01-31  767  		struct statx __user *, buffer)
a528d35e8bfcc5 David Howells 2017-01-31  768  {
1b6fe6e0dfecf8 Stefan Roesch 2022-02-25  769  	int ret;
0ef625bba6fb2b Mateusz Guzik 2024-06-25 @770  	unsigned lflags;
8b3d898afb7290 Al Viro       2024-10-07  771  	struct filename *name = getname_maybe_null(filename, flags);
1b6fe6e0dfecf8 Stefan Roesch 2022-02-25  772  
0ef625bba6fb2b Mateusz Guzik 2024-06-25  773  	/*
0ef625bba6fb2b Mateusz Guzik 2024-06-25  774  	 * Short-circuit handling of NULL and "" paths.
0ef625bba6fb2b Mateusz Guzik 2024-06-25  775  	 *
0ef625bba6fb2b Mateusz Guzik 2024-06-25  776  	 * For a NULL path we require and accept only the AT_EMPTY_PATH flag
0ef625bba6fb2b Mateusz Guzik 2024-06-25  777  	 * (possibly |'d with AT_STATX flags).
0ef625bba6fb2b Mateusz Guzik 2024-06-25  778  	 *
0ef625bba6fb2b Mateusz Guzik 2024-06-25  779  	 * However, glibc on 32-bit architectures implements fstatat as statx
0ef625bba6fb2b Mateusz Guzik 2024-06-25  780  	 * with the "" pathname and AT_NO_AUTOMOUNT | AT_EMPTY_PATH flags.
0ef625bba6fb2b Mateusz Guzik 2024-06-25  781  	 * Supporting this results in the uglification below.
0ef625bba6fb2b Mateusz Guzik 2024-06-25  782  	 */
0ef625bba6fb2b Mateusz Guzik 2024-06-25  783  	lflags = flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
8b3d898afb7290 Al Viro       2024-10-07  784  	if (!name)
0ef625bba6fb2b Mateusz Guzik 2024-06-25  785  		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
0ef625bba6fb2b Mateusz Guzik 2024-06-25  786  
1b6fe6e0dfecf8 Stefan Roesch 2022-02-25  787  	ret = do_statx(dfd, name, flags, mask, buffer);
1b6fe6e0dfecf8 Stefan Roesch 2022-02-25  788  	putname(name);
1b6fe6e0dfecf8 Stefan Roesch 2022-02-25  789  
1b6fe6e0dfecf8 Stefan Roesch 2022-02-25  790  	return ret;
a528d35e8bfcc5 David Howells 2017-01-31  791  }
a528d35e8bfcc5 David Howells 2017-01-31  792  

:::::: The code at line 770 was first introduced by commit
:::::: 0ef625bba6fb2bc0c8ed2aab9524fdf423f67dd5 vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)

:::::: TO: Mateusz Guzik <mjguzik@gmail.com>
:::::: CC: Christian Brauner <brauner@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

