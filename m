Return-Path: <linux-fsdevel+bounces-28878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDCD96FB53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 20:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B528C900
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8913D62F;
	Fri,  6 Sep 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2fDIbeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980113BAC3
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647938; cv=none; b=OZ3gJr3pK+AaCAL6a2QU0ZLGwwEUqh86z+cYEmQoEoP/LmdcknrcqFD1cNiQ9GGAxhlEIx5wnytUEcLKBblk2I9Zf4iLcBNKeAkDHb2hMpCVTFFrFafF5hQhE5FuLCQmYRN6Wdcsq6M5eF4sN8rhACyLv6U3q+D7CVT65wQdQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647938; c=relaxed/simple;
	bh=1J3QLrWVMC7L0AhRehbJiGKDdCviMdUfsca3cT6CDnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcTkCM9e0BiEm9wcbC6ZVDo8Ju4ZeTvCyng1xSJPKZJ8EuNZV0fS9Hg0ZpjEt8kCXjLG+hkuVb8bQgB+uad/9MZw2UXNsVCiOd05rirDT0IRsgdYIrvnkYowftdU62O5ZEwTyrP6TAKN7I2JY8HC+Kp0SilxQiehaTMOIiG0ISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2fDIbeb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725647935; x=1757183935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1J3QLrWVMC7L0AhRehbJiGKDdCviMdUfsca3cT6CDnc=;
  b=h2fDIbebPsdXnxp5d+L5pwBUXf+VoW7tofanOC6Mc5YTfjne1/z1e47w
   OgaCrBOcpdqCSw/8AQchGe97ZkrusGX167u1oP42BOE7YyVCOKes36XHv
   JLUYSa7PnlhhyYWNtqHCKRTrsBXK9dWOJG+S+D9AKiaoQHoEmjmQqWFXV
   Bgm2KFx1oOEQATGKfueu0lKNKnnKRg+vX1RECkeIqhhkTzYoEBH+aT5qH
   mo/6dItMGL51byn3p6jZjgWn1RXpr802jQWcsuPBfQrqbyBq4VdL6t3lE
   dNRbNgjas+ORDEkDLoVrXOmPY40a4dTLvSsXFivbLVLRllqx+MlGqZyLS
   g==;
X-CSE-ConnectionGUID: Ojc/texNTC2HryXzSOXTyw==
X-CSE-MsgGUID: ISsuLVJtS4eLpLcqLXD2ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24293753"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24293753"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 11:38:53 -0700
X-CSE-ConnectionGUID: r2sTg4V/RGqIdytwInt0og==
X-CSE-MsgGUID: go8MHLLKSxeGjIbJ2niLdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="66066219"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Sep 2024 11:38:50 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smdr6-000Bb1-0Q;
	Fri, 06 Sep 2024 18:38:48 +0000
Date: Sat, 7 Sep 2024 02:37:49 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, josef@toxicpanda.com,
	bernd.schubert@fastmail.fm, sweettea-kernel@dorminy.me,
	kernel-team@meta.com
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
Message-ID: <202409070207.bAwolF9v-lkp@intel.com>
References: <20240905174541.392785-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905174541.392785-1-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-Enable-dynamic-configuration-of-fuse-max-pages-limit-FUSE_MAX_MAX_PAGES/20240906-014722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20240905174541.392785-1-joannelkoong%40gmail.com
patch subject: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max pages limit (FUSE_MAX_MAX_PAGES)
config: arm-randconfig-003-20240907 (https://download.01.org/0day-ci/archive/20240907/202409070207.bAwolF9v-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409070207.bAwolF9v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409070207.bAwolF9v-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/fuse/sysctl.c:28:30: error: macro "fuse_sysctl_register" passed 1 arguments, but takes just 0
      28 | int fuse_sysctl_register(void)
         |                              ^
   In file included from fs/fuse/sysctl.c:9:
   fs/fuse/fuse_i.h:1473:9: note: macro "fuse_sysctl_register" defined here
    1473 | #define fuse_sysctl_register()          (0)
         |         ^~~~~~~~~~~~~~~~~~~~
   fs/fuse/sysctl.c:29:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      29 | {
         | ^
   fs/fuse/sysctl.c:36:33: error: macro "fuse_sysctl_unregister" passed 1 arguments, but takes just 0
      36 | void fuse_sysctl_unregister(void)
         |                                 ^
   fs/fuse/fuse_i.h:1474:9: note: macro "fuse_sysctl_unregister" defined here
    1474 | #define fuse_sysctl_unregister()        do { } while (0)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/sysctl.c:37:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      37 | {
         | ^
>> fs/fuse/sysctl.c:16:25: warning: 'fuse_sysctl_table' defined but not used [-Wunused-variable]
      16 | static struct ctl_table fuse_sysctl_table[] = {
         |                         ^~~~~~~~~~~~~~~~~
>> fs/fuse/sysctl.c:11:33: warning: 'fuse_table_header' defined but not used [-Wunused-variable]
      11 | static struct ctl_table_header *fuse_table_header;
         |                                 ^~~~~~~~~~~~~~~~~


vim +/fuse_sysctl_table +16 fs/fuse/sysctl.c

    10	
  > 11	static struct ctl_table_header *fuse_table_header;
    12	
    13	/* Bound by fuse_init_out max_pages, which is a u16 */
    14	static unsigned int sysctl_fuse_max_pages_limit = 65535;
    15	
  > 16	static struct ctl_table fuse_sysctl_table[] = {
    17		{
    18			.procname	= "max_pages_limit",
    19			.data		= &fuse_max_pages_limit,
    20			.maxlen		= sizeof(fuse_max_pages_limit),
    21			.mode		= 0644,
    22			.proc_handler	= proc_douintvec_minmax,
    23			.extra1		= SYSCTL_ONE,
    24			.extra2		= &sysctl_fuse_max_pages_limit,
    25		},
    26	};
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

