Return-Path: <linux-fsdevel+bounces-26340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA19957CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 07:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB7284648
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC914885B;
	Tue, 20 Aug 2024 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E39hgtQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD55446A2;
	Tue, 20 Aug 2024 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724132903; cv=none; b=QY0WHcUE/sFFXcGpMxd3FOnQvLZwjHlbS7fkkggYKdlsGu15Bc6T634ACVh6S3arwSu6aQmn/SWMnpp+dFEEfIngAHSOU8FLgL3S+pnuadIdZ/rtm66FpeFllEw//cGJq2DUAg3vdryhhopkATrOskN0vTknt1xZggNJo+LtiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724132903; c=relaxed/simple;
	bh=gv+hKaGYdHMk0eVQWtWattcub6DIfj1wjr3E3zSOb7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7xes/q3ISG3OGRXT9EywNIIBUdyjoax3JBC4SLbnglul2le6tfYrx8/Aq3FK/BYt4Drx4eOxoBC7r47guahbe9f6aCbR1NYfjiGNBZM0TT93UInaPQbmaSg3EIPET7hGtogUPdRaWNM5Gz5/EixqCqDKzMFH0MvEkxp+BRoVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E39hgtQ2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724132902; x=1755668902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gv+hKaGYdHMk0eVQWtWattcub6DIfj1wjr3E3zSOb7Y=;
  b=E39hgtQ2P+T2rILY+5Ixj8dMMP/5tCskdhbaRKZbjY7qWxJ+w4mGt5rv
   DdBwcXpGT7JEBVc/EvADoe+34IKxkR6YZogChfwh2nVQ/JL2tjseY3SbN
   PmscJY7y/kXMiHnlk8WHSO2YRxNn91NDFaUdqZ/Y2uyHgC85XaZCoBOdp
   tkTvUWqRtSlwp9qV5gi0VHNANFOneNbGIefQW9yN8nsYbCZZK3FFDkZ0N
   CYwFxTd8WZeKB1BNMVGrbYJNb2FsqcHy9x0U9Op9tJ3TZDmKj2Oz4Zgsj
   wlHAgvqLufKrGV99bLLbEI0dggEW0ofVcSQ5TJpAGFmSFEjJm0fVausJc
   A==;
X-CSE-ConnectionGUID: 4dSaWZ3RShuLDbChYTrw2g==
X-CSE-MsgGUID: pdfkoS0WSr6rYqIidnHVuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26162694"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26162694"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 22:48:20 -0700
X-CSE-ConnectionGUID: G8bRx6cVRdubJjNFl9mSyA==
X-CSE-MsgGUID: j/UbvyPBS+yuOvgpJX5F6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60759313"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Aug 2024 22:48:18 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgHj5-0009lu-33;
	Tue, 20 Aug 2024 05:48:15 +0000
Date: Tue, 20 Aug 2024 13:47:26 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] Introduce atomic_dec_and_wake_up_var().
Message-ID: <202408201216.GvF1K3RG-lkp@intel.com>
References: <20240819053605.11706-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819053605.11706-3-neilb@suse.de>

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on gfs2/for-next device-mapper-dm/for-next linus/master v6.11-rc4 next-20240819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/i915-remove-wake_up-on-I915_RESET_MODESET/20240819-134414
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20240819053605.11706-3-neilb%40suse.de
patch subject: [PATCH 2/9] Introduce atomic_dec_and_wake_up_var().
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240820/202408201216.GvF1K3RG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201216.GvF1K3RG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201216.GvF1K3RG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/i915/i915_request.c:2277:
   drivers/gpu/drm/i915/selftests/i915_request.c: In function 'wake_all':
>> drivers/gpu/drm/i915/selftests/i915_request.c:1533:16: error: implicit declaration of function 'atomic_dec_and_wakeup_var'; did you mean 'atomic_dec_and_wake_up_var'? [-Werror=implicit-function-declaration]
    1533 |         return atomic_dec_and_wakeup_var(&i915->selftest.counter);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                atomic_dec_and_wake_up_var
   cc1: some warnings being treated as errors


vim +1533 drivers/gpu/drm/i915/selftests/i915_request.c

  1530	
  1531	static bool wake_all(struct drm_i915_private *i915)
  1532	{
> 1533		return atomic_dec_and_wakeup_var(&i915->selftest.counter);
  1534	}
  1535	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

