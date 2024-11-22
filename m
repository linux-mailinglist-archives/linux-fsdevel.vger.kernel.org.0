Return-Path: <linux-fsdevel+bounces-35538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F639D5892
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 04:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97E7B228C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4161537C9;
	Fri, 22 Nov 2024 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6un4CWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72C23098B;
	Fri, 22 Nov 2024 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732246303; cv=none; b=nBEEwyX7zPvcSETuuqLFYXgaQ5asDbY2LFsz9yBGMddrjX0+J6A5L2SQUyppY3kglUPnxrwbguajJLcV3iXYJSF2tkZGlU0bA0teZ6fUYVShK9uRkZYMyF5rkSAoDuUwaG/2v40zeVXkocE/6XpaKsUvHPmzt40BLG1xfrp06TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732246303; c=relaxed/simple;
	bh=PT+og30acbFtopbcyXmRkZgG31nt6YL5AfWiEoc3v9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8Mf+lmdiQ5gii4b22V/tVSOgJjKzmtTS3t1zMz6X8NxHmOkiNDRczszHFc3gFWDG+8HHEbgMxZjFAumifqshpVkO8XS8VaIH9hzWgoKcjYCb+Om97nUXPYmSBfNvrhjRVF/2az2f14O9pRarr5GJWSNfj6VQDNCJK9Kp0VHH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6un4CWF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732246301; x=1763782301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PT+og30acbFtopbcyXmRkZgG31nt6YL5AfWiEoc3v9c=;
  b=N6un4CWFUrt2HI0bsb6iAfKMdjYZ2Y0TgK39+2XvjOyZiuMtP2TO3DRb
   +NI8dQ4I7BMA/vjgDkILPNA8IcC5hLJhJpHoP4HPTgUfp3CkMli8ZQFn8
   Xw1iej+lg1BSuI7B1U+aHTpSwuJOpEE9NVduXVXEcwwxJAEay13nW/6Tg
   Z3vQe+PakmpMcnau7w1yLPneWKdhdCQuMV0HvgeJx44oUUkZaEpH3y+aA
   9PfwCYfAaf//+3bWLnLYzhW81Jgah7kt0SfifNVVWTnQZ85PiiNEggZQv
   676j38qKjxWQy6xFN4XcVfO3HF3RRcpWVKIWFTC4rfloVnNuhlABkgNMF
   g==;
X-CSE-ConnectionGUID: g/klvT60SaWE89OMMWpEjA==
X-CSE-MsgGUID: 8hYX1Jj6TPKXnvQWjhFHPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32632252"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="32632252"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 19:31:39 -0800
X-CSE-ConnectionGUID: R2+N8KwJRlm1/Y40Y+GzNA==
X-CSE-MsgGUID: HX+G1ulhRGmbttp2DpaCRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="95399663"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Nov 2024 19:31:36 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEKOM-0003dH-1S;
	Fri, 22 Nov 2024 03:31:34 +0000
Date: Fri, 22 Nov 2024 11:31:16 +0800
From: kernel test robot <lkp@intel.com>
To: guanjing <guanjing@cmss.chinamobile.com>, krisman@kernel.org,
	hughd@google.com, akpm@linux-foundation.org, andrealmeid@igalia.com,
	brauner@kernel.org, tytso@mit.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: Re: [PATCH v1] tmpfs: Unsigned expression compared with zero
Message-ID: <202411221128.qSNFAkty-lkp@intel.com>
References: <20241120105150.24008-1-guanjing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120105150.24008-1-guanjing@cmss.chinamobile.com>

Hi guanjing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master next-20241121]
[cannot apply to v6.12]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guanjing/tmpfs-Unsigned-expression-compared-with-zero/20241121-152806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241120105150.24008-1-guanjing%40cmss.chinamobile.com
patch subject: [PATCH v1] tmpfs: Unsigned expression compared with zero
config: arc-randconfig-001-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221128.qSNFAkty-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411221128.qSNFAkty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411221128.qSNFAkty-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/unicode/utf8-core.c:225: warning: Function parameter or struct member 'version_str' not described in 'utf8_parse_version'


vim +225 fs/unicode/utf8-core.c

9d53690f0d4e56 Gabriel Krisman Bertazi 2019-04-25  216  
142fa60f61f938 André Almeida           2024-10-21  217  /**
142fa60f61f938 André Almeida           2024-10-21  218   * utf8_parse_version - Parse a UTF-8 version number from a string
142fa60f61f938 André Almeida           2024-10-21  219   *
142fa60f61f938 André Almeida           2024-10-21  220   * @version: input string
142fa60f61f938 André Almeida           2024-10-21  221   *
fd9b2236cc1a2d guanjing                2024-11-20  222   * Returns 0 on success, negative code on error
142fa60f61f938 André Almeida           2024-10-21  223   */
fd9b2236cc1a2d guanjing                2024-11-20  224  int utf8_parse_version(char *version_str, unsigned int *version)
142fa60f61f938 André Almeida           2024-10-21 @225  {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

