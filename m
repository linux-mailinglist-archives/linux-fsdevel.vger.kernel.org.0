Return-Path: <linux-fsdevel+bounces-77091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKKTEcDejmluFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:20:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB2D133F07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E38B30F26C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E331D750;
	Fri, 13 Feb 2026 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cdmls7wx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591B31D393;
	Fri, 13 Feb 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970706; cv=none; b=GLfe/R6GbSpcj2MSScCjR2yuoknw+DtqTzLpnSHB4H/iZ1h0QBJw3OQD25PDKGfge9ywmu/3QjpD0TfMENZY9F8DQofmDlnvsAjJ/6eBmCShchTvru2EqOyBrZ0PlM/LfLEdlnPAsrJCdiSI0WH6mFhGQcClRyUCJPL+HhmbLto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970706; c=relaxed/simple;
	bh=tGUYMLVKjYb+RaTElSaNdtgcFJ7Zdg2coDCV62HXDOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqz7jJQEmFa8AJiN9YOZNRN2cEdlfbugKsU72IIJINDXkldhwwhrUZhko8NZ6oeBUTb8HLKemVRrieiM/5RSvwJhqBl2DxdC7UEXMaDqoH/+WZ0sFErSWLuCI0cpcGw9LxIEEylGFahd00d6KbnwduEQnPbOZjsvKgcH+K2TX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cdmls7wx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770970704; x=1802506704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tGUYMLVKjYb+RaTElSaNdtgcFJ7Zdg2coDCV62HXDOM=;
  b=Cdmls7wxkpecJyHacgbrOOMFh+kFwfFv/VP7vFHySzgBsX6a0r8hoENr
   1m33sNwwFEGOVLUUJQS8ZP8nyUHsq4cfbSGb0dYs8ugabXriVDBq/VEyA
   BTa3TOvFZYKHdWtfYOWutogF0mLJJXgRfllGvCKPV8r9JnaKDB+h4uhAE
   nqcHYlXHy4B0cgjLQbI5UH1efZPe+/e0US7Jol9OFah7tRObnUEMftCYT
   N4IcHDrk+lei/w3gbNxxN6GpbkVF/WTfQ8H6UZMaLoYR74Iy/zLsUvt8p
   MKPsCe19OEDFbhuSks0xuTOeTZTaekQ0vXQ+Z+49TM7Dh5NuSBkVtIfKe
   w==;
X-CSE-ConnectionGUID: O/bzXaVFQeK8/wr5gsm+SA==
X-CSE-MsgGUID: bLJzKoUBQwSoxSc6bK+KBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72059596"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="72059596"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 00:18:24 -0800
X-CSE-ConnectionGUID: NkgbhQfATS+S19r/5LW5qA==
X-CSE-MsgGUID: D1nZS4adRX27eGdz+4RVig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="235832227"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Feb 2026 00:18:21 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqoNX-00000000vE4-1jnX;
	Fri, 13 Feb 2026 08:18:19 +0000
Date: Fri, 13 Feb 2026 16:17:54 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, luisbg@kernel.org,
	salah.triki@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH 1/2] befs: Add FS_IOC_GETFSLABEL ioctl
Message-ID: <202602131600.jVbNpmdD-lkp@intel.com>
References: <20260212231339.644714-2-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212231339.644714-2-ethan.ferguson@zetier.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zetier.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77091-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CCB2D133F07
X-Rspamd-Action: no action

Hi Ethan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 541c43310e85dbf35368b43b720c6724bc8ad8ec]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/befs-Add-FS_IOC_GETFSLABEL-ioctl/20260213-071516
base:   541c43310e85dbf35368b43b720c6724bc8ad8ec
patch link:    https://lore.kernel.org/r/20260212231339.644714-2-ethan.ferguson%40zetier.com
patch subject: [PATCH 1/2] befs: Add FS_IOC_GETFSLABEL ioctl
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260213/202602131600.jVbNpmdD-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260213/202602131600.jVbNpmdD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602131600.jVbNpmdD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/befs/linuxvfs.c:985:54: error: call to undeclared function 'compat_ptr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     985 |         return befs_generic_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
         |                                                             ^
   1 error generated.


vim +/compat_ptr +985 fs/befs/linuxvfs.c

   979	
   980	#ifdef CONFIG_COMPAT
   981	static long befs_generic_compat_ioctl(struct file *filp, unsigned int cmd,
   982					      unsigned long arg)
   983	
   984	{
 > 985		return befs_generic_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
   986	}
   987	#endif
   988	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

