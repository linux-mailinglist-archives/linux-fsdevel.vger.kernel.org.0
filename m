Return-Path: <linux-fsdevel+bounces-30450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544C198B7AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A711F237A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A319B3F3;
	Tue,  1 Oct 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFcdhCaq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E819ABA4
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772967; cv=none; b=luldgHyLnEEcB7KaRWKlTMk8ww/QD95f6o34E8oVr7pCfHg9KrFCMJsB6ZhU+mGvgpxC5Xi3rQZ4vzWnKBLTuuVb5xMd9jSFTYtErl4J5Le+WxJTca9XOfvRdt3utly/+yxPm5Oj4QdxNADjeSDZV5uZm8fgJSjWMJs3Fx/QtpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772967; c=relaxed/simple;
	bh=1giabMPVJrOvRlMW+6XM6eGErOYpuaNvGDFzDoGtf78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cn9xMVgJ76trTHX5qshIm0qLd7ppDjkWAdoeL9OTwSZwxnAQqMP4OyR9X+3uXA+X+YzS0GmixEbWqxD66OFCQ0vt9glrh/MPi988o8RRovlSUKl61kWQDH/h0WUmnq9a8nMN0UqU3xW5hZoK0sgnceFr75cIybjmdV7wiTnUxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFcdhCaq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727772965; x=1759308965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1giabMPVJrOvRlMW+6XM6eGErOYpuaNvGDFzDoGtf78=;
  b=lFcdhCaqp0lLXelg7Fgof09t9i9IbWitiBjvTh3DyJkuFh9ngnNMAlqP
   IvuYc2ST4fngD4btMR0l6XA/E5PqIZAVyUjIjAZgzFVi9JWAToc1rD/rf
   d8mhQdwCg37XvS/2GyDNnPwlnMfGDwOsYTPl+/TBRWKgC38rvmu90nglH
   TzRK3j7Kmir5OxNAJBfM/ibtSczq7mkCkvN10um5LC9oG8iPhesnT5uXN
   YjHiEFRZ3LDcpHRw90vrjh71VABysISN/VngV9peDbwSslUwbuFQYrmaR
   UJvwNzXscELPpvswz8u6kS2q6zdRf5cI3PPwTr5Qva4il5FbRSdOFiSEJ
   Q==;
X-CSE-ConnectionGUID: AvtRFIiXTzGcSoZCC0lVpA==
X-CSE-MsgGUID: NWf7ZABwSk29u3nKPQJ3Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="14514629"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="14514629"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:56:04 -0700
X-CSE-ConnectionGUID: nwOuroyfS1qcWSWvC7v5lA==
X-CSE-MsgGUID: F+jxqAurS3uqfwAwMIJltQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78329991"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2024 01:56:03 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svYfo-000QT3-24;
	Tue, 01 Oct 2024 08:56:00 +0000
Date: Tue, 1 Oct 2024 16:55:24 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.headers.unaligned 1/2]
 arch/arc/include/asm/mmu.h:17:71: warning: 'struct pt_regs' declared inside
 parameter list will not be visible outside of this definition or declaration
Message-ID: <202410011645.0amHktP2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.headers.unaligned
head:   c7aa4ea3d081865b7d8257c33ebda97fe5126211
commit: 70d37bd7ed08618d65508490d0cea88cb270fb71 [1/2] arc, parisc: get rid of private asm/unaligned.h
config: arc-randconfig-001-20241001 (https://download.01.org/0day-ci/archive/20241001/202410011645.0amHktP2-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410011645.0amHktP2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011645.0amHktP2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arc/include/asm/pgtable.h:14,
                    from include/linux/pgtable.h:6,
                    from include/asm-generic/io.h:1048,
                    from arch/arc/include/asm/io.h:232,
                    from arch/arc/plat-axs10x/axs10x.c:12:
>> arch/arc/include/asm/mmu.h:17:71: warning: 'struct pt_regs' declared inside parameter list will not be visible outside of this definition or declaration
      17 | extern void do_tlb_overlap_fault(unsigned long, unsigned long, struct pt_regs *);
         |                                                                       ^~~~~~~


vim +17 arch/arc/include/asm/mmu.h

f1f3347da9440e Vineet Gupta 2013-01-18  16  
4d3696801bad2a Vineet Gupta 2023-08-12 @17  extern void do_tlb_overlap_fault(unsigned long, unsigned long, struct pt_regs *);
4d3696801bad2a Vineet Gupta 2023-08-12  18  

:::::: The code at line 17 was first introduced by commit
:::::: 4d3696801bad2a037832c15a8d21dfe0c529d9cd ARC: -Wmissing-prototype warning fixes

:::::: TO: Vineet Gupta <vgupta@kernel.org>
:::::: CC: Vineet Gupta <vgupta@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

