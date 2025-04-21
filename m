Return-Path: <linux-fsdevel+bounces-46812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED3A95465
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FD51895653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23BA1EB5CD;
	Mon, 21 Apr 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X52SlFLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2B71E32D9
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253346; cv=none; b=Z0/gCtO9mA1hdTci5JDVjZOdYa8Dku4ZCGv82+q4huNGgiFNUWkGZu/Ur6spbkvlTAEf07kHKCUeI2j/ATenUtrwU7uD1PuhS8n59eOhlFA2kn8HON3Rz2OoXzJEjkTKnQW5H4TQwbrLq6ltrnky6XHwQYNjSny9iJ1buYbPUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253346; c=relaxed/simple;
	bh=BIzR/H1F8de4lehses21qFDRgo7tYE5kewNC7o51Z8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phbqNwlTgOmtiIL67hwfZxxfPfmOaLrg6bOZ/IJTV+NZ2cCRsn0jOoGal2uMsuFunrg6ZzjSHaFUxxp/Rvz3Vw7voAerOg1i1syvrezArDrk4sAJ9SFwVhyWS4TLS5SvJbpm6rtkyXVB7Yt7oCegOuutKehCU0gUNS0nQDqxMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X52SlFLw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745253345; x=1776789345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BIzR/H1F8de4lehses21qFDRgo7tYE5kewNC7o51Z8s=;
  b=X52SlFLwD1hLRJS1smY85Gj3ga0YREWNEUKRR/utFGj5JviXD6+t9v5y
   yRzTnuxwU32p6FO3bo/4lDv1RnZVuzdw4ujUXlAnhDyUcdS0IRtIzEvsV
   yKP2hDoCG0O/Zzo7QOitzLnRlGGcErUFUDUSAaojxFCkf0LlO0Dc9+o6A
   /kIhHCEEfnShEmKXt0UgmqsFcw17tIrMMF7O+ZJDRFR3chyR9N0IA/vyO
   IbFX2DSPBh2qgj+GpEIi2ABr8KzF862XcLLZPaDyREGNkcKDLVOUXpQ9D
   Ci6jiWenl33NLyn+5rXQT4VG6hMx8M81bFNmbs4bjqjeam4jICxtZ+opW
   Q==;
X-CSE-ConnectionGUID: WuGN6gS1SL2F73EhItugzA==
X-CSE-MsgGUID: WhqpG+Q4SL+GZB3xKrgf0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="72183697"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="72183697"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 09:35:44 -0700
X-CSE-ConnectionGUID: Wh3D6qZUReScpja4mF35IQ==
X-CSE-MsgGUID: 7PHXhzACSmiMwrQIePfuug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="132726322"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 21 Apr 2025 09:35:41 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6u7P-0000El-1V;
	Mon, 21 Apr 2025 16:35:39 +0000
Date: Tue, 22 Apr 2025 00:34:53 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Sandeen <sandeen@redhat.com>,
	linux-f2fs-devel@lists.sourceforge.net
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org, chao@kernel.org, lihongbo22@huawei.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 5/7] f2fs: separate the options parsing and options
 checking
Message-ID: <202504220033.8EDCfvWU-lkp@intel.com>
References: <20250420154647.1233033-6-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420154647.1233033-6-sandeen@redhat.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.15-rc3]
[also build test WARNING on linus/master]
[cannot apply to jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev next-20250417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Sandeen/f2fs-Add-fs-parameter-specifications-for-mount-options/20250421-220156
base:   v6.15-rc3
patch link:    https://lore.kernel.org/r/20250420154647.1233033-6-sandeen%40redhat.com
patch subject: [PATCH 5/7] f2fs: separate the options parsing and options checking
config: arc-randconfig-001-20250421 (https://download.01.org/0day-ci/archive/20250422/202504220033.8EDCfvWU-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250422/202504220033.8EDCfvWU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504220033.8EDCfvWU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:7,
                    from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from fs/f2fs/super.c:8:
   fs/f2fs/super.c: In function 'handle_mount_opt':
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   fs/f2fs/f2fs.h:1871:33: note: in expansion of macro 'KERN_ERR'
    1871 |         f2fs_printk(sbi, false, KERN_ERR fmt, ##__VA_ARGS__)
         |                                 ^~~~~~~~
   fs/f2fs/super.c:763:25: note: in expansion of macro 'f2fs_err'
     763 |                         f2fs_err(NULL, "inline xattr size is out of range: %lu ~ %lu",
         |                         ^~~~~~~~
   fs/f2fs/super.c:718:15: warning: unused variable 'name' [-Wunused-variable]
     718 |         char *name;
         |               ^~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a7 Joe Perches 2012-07-30  4  
04d2c8c83d0e3ac Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3ac Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3ac Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

