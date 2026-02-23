Return-Path: <linux-fsdevel+bounces-77980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gC6hMtSCnGkKIwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:39:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E1C179F3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9247D303C80A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4C3148BF;
	Mon, 23 Feb 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbVgKdin"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271B313539;
	Mon, 23 Feb 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864395; cv=none; b=UtDXxBQyUV3lNYWg5lGtDOkzM3aWkjCURoCyeG6jpUOHIPVJx9XPBPuUvQJWmWHtBkoDzSdz62smZwTu9OU5wyBv32qcVHuYdQuZZL8k5/dZMxS9xb2IypCSNtsgfgO2eQM9wWvFAvpzEDKADrItmUMUWZ9bsXNVgNXzqS3GzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864395; c=relaxed/simple;
	bh=Lx3d4xCCjQqM4hNnnOHqhZ8wgehpmy9M0RqpkyDnTVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq6xcnQ8yfEVqHYjENDXHpbmMw6nlHYgXgCCTKmEaGcS1EMuYYxt9+wL0l3UMNkDdDFq1uH9g/40Zji/ja94/jbWzxTuY6mMY0MS0JD/jUzKywiPdI+7xUv4BfwqpLVmpTttk2G8Ke2xulA8seKCQnt7vB56BsKv/bbbVFiILU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbVgKdin; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771864393; x=1803400393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lx3d4xCCjQqM4hNnnOHqhZ8wgehpmy9M0RqpkyDnTVI=;
  b=RbVgKdin5k0nOa4HFFL1/iWa1oHoI6xfuA880M76MiopqObWHb9LekNB
   n16nRFCeVZKEV9L+h8XdBiQiuhhkOhBbLUaGHd+Sg4PWx8EHdeKckE8Dn
   kTVZSXiBOvEIxeh7prWkiQnXD5beRv/ditPdlE01dRUTsD9OyWxmE7+Uz
   FqS1IQ89m5QmRwT+xik/aFtGRoMFmhV3x5Y6JZFDltnAZamtA+7/ncwPy
   wEtkRFpr5dizWPsgquliSfx+XZHHd9D5HMxzhgstLfVhs7de8NvTxYyHF
   Nh8Vxh4Jkx5lldPkSOnKdSnO37SNN3ROML+WCQjtGpDf6kVZV3bRFcTgJ
   g==;
X-CSE-ConnectionGUID: Cr+AFm8URAq2RF3kH4o7bw==
X-CSE-MsgGUID: 68ALZjEXTDCpWzNUgVKNPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="75473023"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="75473023"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 08:33:13 -0800
X-CSE-ConnectionGUID: 5eDstWmVSTuQYmT8trOspg==
X-CSE-MsgGUID: xW3CMIadS5CwrtommhN3PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213951680"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 23 Feb 2026 08:33:10 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vuYrr-000000000XF-2ez3;
	Mon, 23 Feb 2026 16:33:07 +0000
Date: Tue, 24 Feb 2026 00:32:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>, jlayton@kernel.org,
	chuck.lever@oracle.com, alex.aring@gmail.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	arnd@arndb.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jkoolstra@xs4all.nl
Subject: Re: [PATCH] Add support for empty path in openat and openat2 syscalls
Message-ID: <202602240038.MTqLbuRR-lkp@intel.com>
References: <20260223151652.582048-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223151652.582048-1-jkoolstra@xs4all.nl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,xs4all.nl];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-77980-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl,kernel.org,oracle.com,gmail.com,zeniv.linux.org.uk,suse.cz,arndb.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url]
X-Rspamd-Queue-Id: 48E1C179F3A
X-Rspamd-Action: no action

Hi Jori,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v7.0-rc1 next-20260220]
[cannot apply to arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jori-Koolstra/Add-support-for-empty-path-in-openat-and-openat2-syscalls/20260223-232002
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260223151652.582048-1-jkoolstra%40xs4all.nl
patch subject: [PATCH] Add support for empty path in openat and openat2 syscalls
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20260224/202602240038.MTqLbuRR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260224/202602240038.MTqLbuRR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602240038.MTqLbuRR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   fs/fcntl.c: In function 'fcntl_init':
>> include/linux/compiler_types.h:705:45: error: call to '__compiletime_assert_393' declared with attribute error: BUILD_BUG_ON failed: 21 - 1 != HWEIGHT32( (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) | __FMODE_EXEC)
     705 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:686:25: note: in definition of macro '__compiletime_assert'
     686 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:705:9: note: in expansion of macro '_compiletime_assert'
     705 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
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


vim +/__compiletime_assert_393 +705 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  691  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  692  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  693  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  694  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  695  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  696   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  697   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  698   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  699   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  700   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  701   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  702   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  703   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  704  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @705  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  706  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

