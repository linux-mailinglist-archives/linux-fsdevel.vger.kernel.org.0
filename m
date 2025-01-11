Return-Path: <linux-fsdevel+bounces-38948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5ADA0A3C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 14:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF023AA1B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1C1A4AAA;
	Sat, 11 Jan 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZjBtyPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6881922EF;
	Sat, 11 Jan 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736600890; cv=none; b=WcX+Amg9GnbPlKagqM8xq7YbAdQkFnT+RqvS9/Z899BTtfRWdFCKw//BR5SXrZwDcllGnn0fos3IpRfcVOrgZ63xvb+qdReCMKvDnRXZbuYq6IMiV0Ri6SBtGi7yuPXFwsPPMpjwUk1adAawWzhyJojRS90YCgepCGuGKk+8j1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736600890; c=relaxed/simple;
	bh=wdSwZqiGhYyZAx+e2IQorQXp43S0F5s8LS6LS3NEPn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB1/upF1GbSSkNQ077tysBKr6nwEFrQHyCySPCGHLyBxAZsmAMrpmyYwd/zROO4l0W2PnabBk35PT4g3NedulkAognC73pph5QAXQfoK+tPdbFJpzk1m2VCyPTkFxKc4c9BfPcXvnvEjqjsJQvRzIXYlKJ33apHn9H4TZNrg+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZjBtyPN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736600889; x=1768136889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wdSwZqiGhYyZAx+e2IQorQXp43S0F5s8LS6LS3NEPn0=;
  b=GZjBtyPN58OTXZUM6ChEmXOWdLK4whViA66vmRivabd/YMD5R2sThkPz
   c3sYpvZbZDP7Sy4uyNtwrgId9XKMfHF6U77MlJHCSoAy1LM10mgDXPmR+
   42KQ535mMViBIRXfkMz6aFVS279EhVcUGEJmjl8F0aH2EqxGAC2G5L42k
   nd8iHYsUU/gj+nUmZv8UFu8Ypb5Skj7GF8/ruJDkNdMYGk1Q2lhE1a9bY
   xM8W2oCzGBA6MdW+Jg33cIw/oxzwSPdGkG2vnVojCzG7uOzJ9jkgAOdH8
   zFbvoJLcvZlqdRPDpeSX5203zX1P/SWvMbLpjC0A4gm8jWqc6g6vfeGO8
   w==;
X-CSE-ConnectionGUID: XtjCeJpzTrqBCZIGlvUBgw==
X-CSE-MsgGUID: oD6Zp8/eQpyjVG0uuEkS4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="59370306"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="59370306"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 05:08:09 -0800
X-CSE-ConnectionGUID: 3/wqF2ZURhC4WRstUhiavQ==
X-CSE-MsgGUID: 6Lir+QKzQ4WRshUr7vMXAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="104040539"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Jan 2025 05:08:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWbDa-000KfP-2E;
	Sat, 11 Jan 2025 13:07:58 +0000
Date: Sat, 11 Jan 2025 21:07:51 +0800
From: kernel test robot <lkp@intel.com>
To: Andrey Albershteyn <aalbersh@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrey Albershteyn <aalbersh@redhat.com>, linux-api@vger.kernel.org,
	monstr@monstr.eu, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	chris@zankel.net, jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, arnd@arndb.de,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <202501112052.ZJEvfjhd-lkp@intel.com>
References: <20250109174540.893098-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109174540.893098-1-aalbersh@kernel.org>

Hi Andrey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on geert-m68k/for-next powerpc/next powerpc/fixes s390/features linus/master v6.13-rc6 next-20250110]
[cannot apply to geert-m68k/for-linus deller-parisc/for-next jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master tip/x86/asm]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrey-Albershteyn/fs-introduce-getfsxattrat-and-setfsxattrat-syscalls/20250110-014739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250109174540.893098-1-aalbersh%40kernel.org
patch subject: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20250111/202501112052.ZJEvfjhd-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501112052.ZJEvfjhd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501112052.ZJEvfjhd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1615:2: warning: syscall getfsxattrat not implemented [-W#warnings]
    1615 | #warning syscall getfsxattrat not implemented
         |  ^
>> <stdin>:1618:2: warning: syscall setfsxattrat not implemented [-W#warnings]
    1618 | #warning syscall setfsxattrat not implemented
         |  ^
   2 warnings generated.
--
>> <stdin>:1615:2: warning: syscall getfsxattrat not implemented [-W#warnings]
    1615 | #warning syscall getfsxattrat not implemented
         |  ^
>> <stdin>:1618:2: warning: syscall setfsxattrat not implemented [-W#warnings]
    1618 | #warning syscall setfsxattrat not implemented
         |  ^
   2 warnings generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

