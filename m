Return-Path: <linux-fsdevel+bounces-19813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975BF8C9E9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4986C2846A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D1136997;
	Mon, 20 May 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSu6kHd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D0C54789;
	Mon, 20 May 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214412; cv=none; b=ZjZxicGXroRB7tcIVtBoSOtafPHjEap5GPRDX9GdDfU6NvxCnqRtYqVWAvQRLoKOlyn/eJ5e+BOjXJmz2fsDeYI3LlgtmBNFX8yLWKCFw18oK2aIWFKSrVPpnvooRhxHoJsPyaW7Ibx7tfavVp5Jf5QjT1NBb3KE37qFEAJ3ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214412; c=relaxed/simple;
	bh=HEi4o6f1GohHdJ5VdC2hzu1APLIt6YSrw4Kf+Y5ungM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh4jzJVvFb91JJ0vfwi/BfW0Bqw86A4vqAH3B8FIMZch9uztKQ8ZtYr4j02Ytd9dKn2mh91cjBvGj0luWFB2TCgvR/2hke49wpXRm1xjFSP4dNw4OEwzqI+vFdcVyR6tZF9jL8CD89uQmO/yOy+HZWmBM23pmsg/kYVeWhH4tIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSu6kHd/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716214411; x=1747750411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HEi4o6f1GohHdJ5VdC2hzu1APLIt6YSrw4Kf+Y5ungM=;
  b=HSu6kHd/KCy5k0qL8HBx2fEAiNdcWYn3QPVJ7jdWktEMcIFnrdcpEDeV
   ZbAsWOcnUIYm2ZUzGj4rJ+JyNSzSMD1vWknkvx5c4fvNfBit/Y9b6a+p6
   mZ5wdN1Cf9dAZzcLyMleGpOmIjiEFC4fVKS8qfoB2Za/8uIiS4VQd2qMF
   FPFO76VF59zcsfuGW68X431kdd/jhhcG77/5TU5HQ3pcyhSzRfmyMXmBr
   5Nw76EqY1PlDZ4gRxA135YF7wlrenOws0l0lMV/2hWdKYb51UHHwNSnj7
   klv/ijEsfZTjA9/J0+hq6wHtRwOaPh/sC0fH8tKqrK9SB+VOkP8URetCp
   g==;
X-CSE-ConnectionGUID: jdR1eJMxRNGXQM6Qnzq76Q==
X-CSE-MsgGUID: utXKgrZXS9GfHIWx9eyC/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12519662"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="12519662"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 07:13:30 -0700
X-CSE-ConnectionGUID: 2Esy9xhMR6yAN+3OekAtrQ==
X-CSE-MsgGUID: lwbaqOKqTVC9M006gPJSTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="32415929"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2024 07:13:27 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s93lU-0004t6-2A;
	Mon, 20 May 2024 14:13:24 +0000
Date: Mon, 20 May 2024 22:13:21 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>
Cc: oe-kbuild-all@lists.linux.dev, Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
Message-ID: <202405202157.xE9dP8fI-lkp@intel.com>
References: <20240520021615.741800-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520021615.741800-1-keescook@chromium.org>

Hi Kees,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/execve]
[also build test ERROR on kees/for-next/pstore kees/for-next/kspp brauner-vfs/vfs.all linus/master v6.9 next-20240520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/exec-Avoid-pathological-argc-envc-and-bprm-p-values/20240520-101851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20240520021615.741800-1-keescook%40chromium.org
patch subject: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
config: i386-randconfig-004-20240520 (https://download.01.org/0day-ci/archive/20240520/202405202157.xE9dP8fI-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405202157.xE9dP8fI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405202157.xE9dP8fI-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/exec.o: in function `exec_test_bprm_stack_limits':
>> fs/exec_test.c:98:(.text+0xdfc): undefined reference to `kunit_binary_assert_format'
>> ld: fs/exec_test.c:98:(.text+0xe0c): undefined reference to `__kunit_do_failed_assertion'
>> ld: fs/exec_test.c:99:(.text+0xe56): undefined reference to `kunit_binary_assert_format'
   ld: fs/exec_test.c:99:(.text+0xe66): undefined reference to `__kunit_do_failed_assertion'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FB_IOMEM_HELPERS
   Depends on [n]: HAS_IOMEM [=y] && FB_CORE [=n]
   Selected by [m]:
   - DRM_XE_DISPLAY [=y] && HAS_IOMEM [=y] && DRM_XE [=m] && DRM_XE [=m]=m


vim +98 fs/exec_test.c

    85	
    86	static void exec_test_bprm_stack_limits(struct kunit *test)
    87	{
    88		/* Double-check the constants. */
    89		KUNIT_EXPECT_EQ(test, _STK_LIM, SZ_8M);
    90		KUNIT_EXPECT_EQ(test, ARG_MAX, 32 * SZ_4K);
    91	
    92		for (int i = 0; i < ARRAY_SIZE(bprm_stack_limits_results); i++) {
    93			const struct bprm_stack_limits_result *result = &bprm_stack_limits_results[i];
    94			struct linux_binprm bprm = result->bprm;
    95			int rc;
    96	
    97			rc = bprm_stack_limits(&bprm);
  > 98			KUNIT_EXPECT_EQ_MSG(test, rc, result->expected_rc, "on loop %d", i);
  > 99			KUNIT_EXPECT_EQ_MSG(test, bprm.argmin, result->expected_argmin, "on loop %d", i);
   100		}
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

