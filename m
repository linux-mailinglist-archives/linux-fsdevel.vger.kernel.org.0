Return-Path: <linux-fsdevel+bounces-6137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580F813B47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF279282304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C56A359;
	Thu, 14 Dec 2023 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k85baBYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978B6A32A;
	Thu, 14 Dec 2023 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702584500; x=1734120500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nQZaAPlzIhWS5ZONexlJhNtWCCnMIrfTLdkPryy2dwY=;
  b=k85baBYPGxpVuhmnbc8/5NdROhfAh1sWpBqb0FtgN3N+KS3fdkKqb991
   68kJibc1IlRfzvNi3m5giDxsuQf05NgUypTMEirMc762sniQHM2MQgrCi
   wnYlUPMRUWThPg8vPpXbV44zShYDy5z4R6QoFURNdiwkNnEqk0pYtmT4o
   UGEYjjH9XwNgBSVL/DsiuEG83xbIF1vZTYjmbHd9MYJUtkrxrhAcEoIX+
   1oekGYMNIpZuhOpReeMwx8PrB67V1PGa1Vwkhim+O5jCPVKEmdPTHRBWG
   HAq6JS4x5fiJFo5LapP8k0jDaQbpyzbJqFbJ+eXjzdyz+ACsq3uTXF4eP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392356795"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="392356795"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 12:08:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="778009672"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="778009672"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2023 12:08:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDs09-000MZC-2A;
	Thu, 14 Dec 2023 20:08:09 +0000
Date: Fri, 15 Dec 2023 04:07:44 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mhocko@kernel.org,
	tj@kernel.org, ying.huang@intel.com, gregory.price@memverge.com,
	corbet@lwn.net, rakie.kim@sk.com, hyeongtak.ji@sk.com,
	honggyu.kim@sk.com, vtavarespetr@micron.com, peterz@infradead.org,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, Hasan.Maruf@amd.com, seungjun.ha@samsung.com
Subject: Re: [PATCH v3 08/11] mm/mempolicy: add set_mempolicy2 syscall
Message-ID: <202312150311.RPwbE1sK-lkp@intel.com>
References: <20231213224118.1949-9-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213224118.1949-9-gregory.price@memverge.com>

Hi Gregory,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on deller-parisc/for-next powerpc/next powerpc/fixes s390/features jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master linus/master v6.7-rc5]
[cannot apply to geert-m68k/for-next geert-m68k/for-linus tip/x86/asm next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231214-064236
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231213224118.1949-9-gregory.price%40memverge.com
patch subject: [PATCH v3 08/11] mm/mempolicy: add set_mempolicy2 syscall
config: um-randconfig-002-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150311.RPwbE1sK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150311.RPwbE1sK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150311.RPwbE1sK-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_write':
   pcap-dbus.o:(.text+0x2432f): undefined reference to `dbus_message_demarshal'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24345): undefined reference to `dbus_connection_send'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2434e): undefined reference to `dbus_connection_flush'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24356): undefined reference to `dbus_message_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x243a4): undefined reference to `dbus_error_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_read':
   pcap-dbus.o:(.text+0x243f0): undefined reference to `dbus_connection_pop_message'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24412): undefined reference to `dbus_connection_pop_message'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24428): undefined reference to `dbus_connection_read_write'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24492): undefined reference to `dbus_message_is_signal'
   /usr/bin/ld: pcap-dbus.o:(.text+0x244ae): undefined reference to `dbus_message_marshal'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24516): undefined reference to `dbus_free'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_cleanup':
   pcap-dbus.o:(.text+0x2457c): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: arch/um/drivers/pcap.o: in function `dbus_activate':
   pcap-dbus.o:(.text+0x24626): undefined reference to `dbus_connection_open'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2463e): undefined reference to `dbus_bus_register'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2472c): undefined reference to `dbus_bus_add_match'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24734): undefined reference to `dbus_error_is_set'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2477b): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x247ac): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x247bd): undefined reference to `dbus_bus_add_match'
   /usr/bin/ld: pcap-dbus.o:(.text+0x247c5): undefined reference to `dbus_error_is_set'
   /usr/bin/ld: pcap-dbus.o:(.text+0x247fe): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2480a): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24836): undefined reference to `dbus_bus_get'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24872): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24885): undefined reference to `dbus_connection_set_max_received_size'
   /usr/bin/ld: pcap-dbus.o:(.text+0x24896): undefined reference to `dbus_connection_unref'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2490c): undefined reference to `dbus_error_free'
   /usr/bin/ld: pcap-dbus.o:(.text+0x2494a): undefined reference to `dbus_error_free'
>> /usr/bin/ld: arch/x86/um/sys_call_table_64.o:(.rodata+0xe48): undefined reference to `sys_set_mempolicy2'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

