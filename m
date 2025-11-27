Return-Path: <linux-fsdevel+bounces-70076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D71AC8FFDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 20:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C04E4553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C9302CB4;
	Thu, 27 Nov 2025 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6bCagyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66FF23EABB;
	Thu, 27 Nov 2025 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270449; cv=none; b=lKZU1mRiNI8nsZoaW1lArrmRoVKjf1whHY29WpGCS6d6jtEmFlliqnxJqG+XlKSkgm5U8hnDQ6lme55TuwR4+rtWv0xQwUIritbVyCPH+gSwRHKRVe77BNtKoPxkKRE7kvonCzC7V2u+TvlztmGiuUFHju2MAKDgJ5htEIu0gxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270449; c=relaxed/simple;
	bh=ibJyM056T8UZwla7AY/4UvkPMuimmJY3SdHg2ySi9xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb3wjpleTuTLaP9Yn6qWtKECF3AelvhBESs21vTD5fwZdMb2UEr8CbNm419HFsxkXp1zYBe+NHvHyrepQXHNoEtrla371ZJMv8/fGvGM875qoSI8tD2O2BNoe8JQ7f12MGePUa+ZzWHUaZU0QNIXBpmPcwe7Rq55gEFCbFQ5buU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6bCagyt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764270448; x=1795806448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ibJyM056T8UZwla7AY/4UvkPMuimmJY3SdHg2ySi9xA=;
  b=R6bCagytV3qBNZwwBV9i57IR0yc+WtwmZV8WdEsixrk6zEhVyNWzdukd
   8mcgg60Lm66AXDCthC2uw6lqxC4GiielNHWQ/M9h9G4EVO4mnT4jOeVDr
   wGfNK2Q1ihgeZBltyKsIJnI7Ar2OUP6MUmwauVs9QGmBXJfT3YET20mm+
   DPoUk3YZMsXe7R0tfK7psOWK2+inbUsY3rb2Nl+7hdKsug/TE8Q2fopvj
   18FT0DncVZomMiUHQtsaKyj9xTcRIocv5H8iEs6fWr03ZuKVL/vk8mGCA
   HI8a1ptTj1fbKmKrIsQ4rwK2oobTKa/wY8aDJT0NjetDv63VNWLcxuV74
   g==;
X-CSE-ConnectionGUID: deBUZqSkRBu4y0xMVcn+XQ==
X-CSE-MsgGUID: uT0VXC+ZTX+I7lJYTYm+JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66480997"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="66480997"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:07:27 -0800
X-CSE-ConnectionGUID: XhDSF54NSwaFX6MQUt1kLA==
X-CSE-MsgGUID: RTFps8NmSXCsxd4DiTWq4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; 
   d="scan'208";a="192550326"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 27 Nov 2025 11:07:23 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOhKr-000000005Xp-2RXc;
	Thu, 27 Nov 2025 19:07:21 +0000
Date: Fri, 28 Nov 2025 03:07:07 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kernel-team@meta.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Allow const char * from LSM hooks as
 kfunc const string arguments
Message-ID: <202511280214.sckLyHDU-lkp@intel.com>
References: <20251127005011.1872209-6-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127005011.1872209-6-song@kernel.org>

Hi Song,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/bpf-Allow-const-char-from-LSM-hooks-as-kfunc-const-string-arguments/20251127-125352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20251127005011.1872209-6-song%40kernel.org
patch subject: [PATCH bpf-next 1/3] bpf: Allow const char * from LSM hooks as kfunc const string arguments
config: loongarch-randconfig-001-20251127 (https://download.01.org/0day-ci/archive/20251128/202511280214.sckLyHDU-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b3428bb966f1de8aa48375ffee0eba04ede133b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251128/202511280214.sckLyHDU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511280214.sckLyHDU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:9655:14: warning: unused variable 'tname' [-Wunused-variable]
    9655 |         const char *tname;
         |                     ^~~~~
   1 warning generated.


vim +/tname +9655 kernel/bpf/verifier.c

  9649	
  9650	/* Check for const string passed in as input to the bpf program. */
  9651	static int check_reg_const_str_arg(struct bpf_reg_state *reg)
  9652	{
  9653		const struct btf *btf;
  9654		const struct btf_type *t;
> 9655		const char *tname;
  9656	
  9657		if (base_type(reg->type) != PTR_TO_BTF_ID)
  9658			return -EINVAL;
  9659	
  9660		btf = reg->btf;
  9661		t = btf_type_by_id(btf, reg->btf_id);
  9662		if (!t)
  9663			return -EINVAL;
  9664	
  9665		if (btf_type_is_const_char_ptr(btf, t))
  9666			return 0;
  9667		return -EINVAL;
  9668	}
  9669	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

