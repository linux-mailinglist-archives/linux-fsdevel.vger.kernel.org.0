Return-Path: <linux-fsdevel+bounces-58797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EFDB31860
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD5A1C82682
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A62FC034;
	Fri, 22 Aug 2025 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fY2Ll00Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AC2FC00E;
	Fri, 22 Aug 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867165; cv=none; b=HczlzOJIPXztTDV/Sxf23XyV7h+Y2VcUAEGhdEL1U+G5E7aEtVaPzwHEA29WYm4LM62x0r2fTbn4iT3I2AS1TSuAyAh/RNuywUNVLKjWLZk2fvQuyEZl98glgbkS0e+DASiA5pBY2xDNawhuFUe3F5RiFKjM3RnTifpNh1nCD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867165; c=relaxed/simple;
	bh=SPEn7P3mjkWhID617eIY0l+bYfag61lfCySYeoLUzIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/tq37sia6aiSiqwiYTe2VKYADioplFzc/q7vQoVjCqRDrZZv6vGA1qGUrwXqkQvK1IJOmdBpKIREH/A1HWTCVeEcZfzof9OXY8PbCn3HDdQ5bIbrPswSL/txIulfir7JP+qsRWQUjLsKC5Dn7Fykz8hMbK5NeweWkbqGiSV18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fY2Ll00Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755867162; x=1787403162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SPEn7P3mjkWhID617eIY0l+bYfag61lfCySYeoLUzIs=;
  b=fY2Ll00Ze4JaH0RsxomjY5kF9BZ0PuFxwBhZfOePPf6o66mir7004RHa
   CD2zpaYt1Iq85O0SELHBuS1WFvs0dgRzdChsK1ZO/Mr98WRNJfwH0A9xW
   ReJWJMoHizc0B3z7Rfg3iVnYo3VPNHBYhl1DVjbiHhWumyxMC6Y0SH1Xe
   37WEbDZ95Urn6OkxIrJlC4+nl3wXsczFhUr1QimgI4CpEeBDk8jYdvE1o
   92KrL4j3PpplTcX1T6bx+QEFbN6xcb/AOvu1HnDWzEAkrwRqSSW3Javip
   72sTienAisroHCoTwMIIA01Uh+pO8RTtncBHQBGS+jmptldyS3hOPdcjZ
   A==;
X-CSE-ConnectionGUID: CKpvkZe2RZ6GbQTzIGqgmw==
X-CSE-MsgGUID: MrUdWte5Qh22Uz7TknZuJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57191227"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57191227"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:52:42 -0700
X-CSE-ConnectionGUID: Z3/yPDQiRuS5zxcdPa/slQ==
X-CSE-MsgGUID: W3HnWrRlQDmSxTL4bCDOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169104621"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 22 Aug 2025 05:52:40 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upRFQ-000LHr-1P;
	Fri, 22 Aug 2025 12:52:07 +0000
Date: Fri, 22 Aug 2025 20:50:50 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 03/16] Introduce wake_up_key()
Message-ID: <202508222051.JpjiLYJb-lkp@intel.com>
References: <20250822000818.1086550-4-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822000818.1086550-4-neil@brown.name>

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next linus/master v6.17-rc2 next-20250822]
[cannot apply to tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/VFS-discard-err2-in-filename_create/20250822-081444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250822000818.1086550-4-neil%40brown.name
patch subject: [PATCH v2 03/16] Introduce wake_up_key()
config: sh-randconfig-r073-20250822 (https://download.01.org/0day-ci/archive/20250822/202508222051.JpjiLYJb-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508222051.JpjiLYJb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508222051.JpjiLYJb-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpio/gpiolib-cdev.c: In function 'linereq_put_event':
>> drivers/gpio/gpiolib-cdev.c:596:2: error: 'else' without a previous 'if'
     596 |  else
         |  ^~~~
   drivers/gpio/gpiolib-cdev.c: In function 'lineevent_irq_thread':
   drivers/gpio/gpiolib-cdev.c:2018:2: error: 'else' without a previous 'if'
    2018 |  else
         |  ^~~~
   drivers/gpio/gpiolib-cdev.c: In function 'lineinfo_changed_func':
   drivers/gpio/gpiolib-cdev.c:2536:2: error: 'else' without a previous 'if'
    2536 |  else
         |  ^~~~


vim +596 drivers/gpio/gpiolib-cdev.c

a0dda508bd66b9e Bartosz Golaszewski 2023-08-17  581  
73e0341992b68bb Kent Gibson         2020-09-28  582  static void linereq_put_event(struct linereq *lr,
73e0341992b68bb Kent Gibson         2020-09-28  583  			      struct gpio_v2_line_event *le)
73e0341992b68bb Kent Gibson         2020-09-28  584  {
73e0341992b68bb Kent Gibson         2020-09-28  585  	bool overflow = false;
73e0341992b68bb Kent Gibson         2020-09-28  586  
0ebeaab4d59eb37 Kent Gibson         2023-12-19  587  	scoped_guard(spinlock, &lr->wait.lock) {
73e0341992b68bb Kent Gibson         2020-09-28  588  		if (kfifo_is_full(&lr->events)) {
73e0341992b68bb Kent Gibson         2020-09-28  589  			overflow = true;
73e0341992b68bb Kent Gibson         2020-09-28  590  			kfifo_skip(&lr->events);
73e0341992b68bb Kent Gibson         2020-09-28  591  		}
73e0341992b68bb Kent Gibson         2020-09-28  592  		kfifo_in(&lr->events, le, 1);
0ebeaab4d59eb37 Kent Gibson         2023-12-19  593  	}
73e0341992b68bb Kent Gibson         2020-09-28  594  	if (!overflow)
73e0341992b68bb Kent Gibson         2020-09-28  595  		wake_up_poll(&lr->wait, EPOLLIN);
73e0341992b68bb Kent Gibson         2020-09-28 @596  	else
73e0341992b68bb Kent Gibson         2020-09-28  597  		pr_debug_ratelimited("event FIFO is full - event dropped\n");
73e0341992b68bb Kent Gibson         2020-09-28  598  }
73e0341992b68bb Kent Gibson         2020-09-28  599  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

