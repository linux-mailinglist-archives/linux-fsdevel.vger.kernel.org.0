Return-Path: <linux-fsdevel+bounces-19821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5238C9F7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D4E28166E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8820136E0E;
	Mon, 20 May 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVCTz/TH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9D1E49D;
	Mon, 20 May 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218255; cv=none; b=pw8u+axqL1z8n/x55FcavwuN5Y7YNtjCPp4V5DNK6XaUEV6bjAI213C5+4khwUTTl1SoQb3GNCHT7k/BkkaVpZG804gBVqWxRKqaoNq/zus0TnG/y9+oL8eedI7Kamnd+oEVqT6FzXWUb9BaKmDulsvYhS2ezhgX5HVQSlOAZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218255; c=relaxed/simple;
	bh=Fk3TdpMwWcq77n1yGGGEGm8bSTFyy93wDKKzCOOfQP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoZQfEyp8j1IjBvlk0+JhzSs2xd87lt15SII0EvYctXjqGh6zfx1ENE8Cof6rdYMiuLn/jPANGtFJRe2cW6eZABsZ17JFt+dVsjXDoN+/ZaJwOFci4SW4z+valVapS/afrsulNUfjAW3otRBl9UE08rsXdr6FprOcLRxy9YI+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVCTz/TH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716218254; x=1747754254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fk3TdpMwWcq77n1yGGGEGm8bSTFyy93wDKKzCOOfQP0=;
  b=QVCTz/THGhdokdkri6Mp4tLTPCiC3fpstT4B2cMHJSDfQDjK6W22uW20
   rsriwbwL2VBxdhPXld3yter1sIY2rEBZPbI5Y8XkrnDi5fWAWcIuwDYF/
   F7Jn12kevu+y9NArVF2M57IT7CX4xcmnHmnmvH4tEglEuYU38IGaZO9/E
   mJhzE3wJA4wo8Uj7stCoLkfcx92wiEGLZC7rm9O3O4YsLUezM50LUGfp2
   lBx0Ec8nnwpG5M9jmReDMNLmEzfUeVv21Eriit5u8s5x2nITtr2GJHmEs
   T0/DO78bPNi1js80ZrVEL3uafr+jZSGNC3xyKr0TT9nY/7YLcC2JYytsH
   A==;
X-CSE-ConnectionGUID: EArVxg4RS5a90X9d4ac5Ww==
X-CSE-MsgGUID: Pq4/yApeT66LDxyrBBV/yg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="29863067"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="29863067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 08:17:33 -0700
X-CSE-ConnectionGUID: ay76jzxJRpSklShU4H633w==
X-CSE-MsgGUID: 0zYvbH3sTda2dVjmleOTIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="69996880"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 20 May 2024 08:17:29 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s94lT-0004vQ-1l;
	Mon, 20 May 2024 15:17:27 +0000
Date: Mon, 20 May 2024 23:17:03 +0800
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
Message-ID: <202405202231.3Q9gWCar-lkp@intel.com>
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
[also build test ERROR on kees/for-next/pstore kees/for-next/kspp brauner-vfs/vfs.all linus/master vfs-idmapping/for-next v6.9 next-20240520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/exec-Avoid-pathological-argc-envc-and-bprm-p-values/20240520-101851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20240520021615.741800-1-keescook%40chromium.org
patch subject: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20240520/202405202231.3Q9gWCar-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405202231.3Q9gWCar-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405202231.3Q9gWCar-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: fs/exec.o: in function `exec_test_bprm_stack_limits':
   exec.c:(.text+0x1904): undefined reference to `kunit_binary_assert_format'
>> nios2-linux-ld: exec.c:(.text+0x192c): undefined reference to `kunit_binary_assert_format'
>> nios2-linux-ld: exec.c:(.text+0x19e8): undefined reference to `__kunit_do_failed_assertion'
>> exec.c:(.text+0x19e8): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'
   nios2-linux-ld: exec.c:(.text+0x1a28): undefined reference to `__kunit_do_failed_assertion'
   exec.c:(.text+0x1a28): relocation truncated to fit: R_NIOS2_CALL26 against `__kunit_do_failed_assertion'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

