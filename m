Return-Path: <linux-fsdevel+bounces-28885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31D396FD8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 23:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BB91F21F1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B7915958D;
	Fri,  6 Sep 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FI7IC73z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC5158A00
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659586; cv=none; b=Rze3vIHXC9S5p6xpgU7LZ1ykvYyNaCnjDKyDOxCaJaXpPRRCDl/N/g9nElEkErws9HAYK6Pn25frEJf6KD1nB4dhlDMAgje8gGwFCxtSIqzHapmyLeH326dRxGzdHhGdn8bC+ybQIZzTp0w6PvuR8CzxMvg49qSHrUcO7zIOH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659586; c=relaxed/simple;
	bh=ChXqD8a53++EF7MfJqJwbBM6458Bp+61DtjHQo7CeTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzLZexlxDruhQe5lPNYXqAWViQy/zB78t2Jw3U5c7vTRAPxIri/U0rsQpBtEPdbEp19Lk4ft6XWgtjaK+IBK13JX4yJCD4KuyUU14JyJ1NvTb4nFSspX3fQkCMxoUaaVq4h0YWj7o5oENNAffs2GGmpmXGg05gqCsL7SZ9/Ehck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FI7IC73z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725659583; x=1757195583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ChXqD8a53++EF7MfJqJwbBM6458Bp+61DtjHQo7CeTY=;
  b=FI7IC73z9GrvLhFsioBu/g/67d78uRfCdtU3DsNUN4eIeBFAKXulE10B
   +u2MOYkQO6mU/+c6C9W3qvuEFFQVWALuGSFlwDq9PujPF0k34Wb0h1xsb
   18pEqHQLhkpyvVMyROOHILc9GpnUmloosqZWcXcHUEDBnMOc57Tjv04ZE
   4ZLjzsTTtAP3Ge2P2qdPu/xznnuPwhjR9QCc3jhKgUk7mBB0JOFT9utj6
   6rDII+q6206ppvD+ubc6lJXviolH42JdFhh9f1DFcC5clYO/ukpP5QDrE
   SKzLfBKD4LiAQbvHwabDH8wQ/qHbcDxLXgH4aRsFI8Wb61C5fyqW5vMSq
   w==;
X-CSE-ConnectionGUID: goe0kD/2SiyYNTsjduSY5Q==
X-CSE-MsgGUID: obEgw6qpR+SG6xXZrlcBqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24627662"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="24627662"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 14:53:03 -0700
X-CSE-ConnectionGUID: HtPUhkhwTqGdr2/euIBQ9w==
X-CSE-MsgGUID: zNuizZeuS6iiaJFmHXMJ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="66813650"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 06 Sep 2024 14:53:00 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smgsz-000Blp-1E;
	Fri, 06 Sep 2024 21:52:57 +0000
Date: Sat, 7 Sep 2024 05:52:51 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	josef@toxicpanda.com, bernd.schubert@fastmail.fm,
	sweettea-kernel@dorminy.me, kernel-team@meta.com
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
Message-ID: <202409070557.u6rI9J9K-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-Enable-dynamic-configuration-of-fuse-max-pages-limit-FUSE_MAX_MAX_PAGES/20240906-014722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20240905174541.392785-1-joannelkoong%40gmail.com
patch subject: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max pages limit (FUSE_MAX_MAX_PAGES)
config: hexagon-randconfig-001-20240907 (https://download.01.org/0day-ci/archive/20240907/202409070557.u6rI9J9K-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409070557.u6rI9J9K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409070557.u6rI9J9K-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/fuse/sysctl.c:9:
   In file included from fs/fuse/fuse_i.h:22:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/fuse/sysctl.c:9:
   In file included from fs/fuse/fuse_i.h:23:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/fuse/sysctl.c:9:
   In file included from fs/fuse/fuse_i.h:23:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/fuse/sysctl.c:9:
   In file included from fs/fuse/fuse_i.h:23:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   fs/fuse/sysctl.c:28:26: error: too many arguments provided to function-like macro invocation
      28 | int fuse_sysctl_register(void)
         |                          ^
   fs/fuse/fuse_i.h:1473:9: note: macro 'fuse_sysctl_register' defined here
    1473 | #define fuse_sysctl_register()          (0)
         |         ^
   fs/fuse/sysctl.c:28:25: error: expected ';' after top level declarator
      28 | int fuse_sysctl_register(void)
         |                         ^
         |                         ;
   fs/fuse/sysctl.c:36:29: error: too many arguments provided to function-like macro invocation
      36 | void fuse_sysctl_unregister(void)
         |                             ^
   fs/fuse/fuse_i.h:1474:9: note: macro 'fuse_sysctl_unregister' defined here
    1474 | #define fuse_sysctl_unregister()        do { } while (0)
         |         ^
>> fs/fuse/sysctl.c:36:6: error: variable has incomplete type 'void'
      36 | void fuse_sysctl_unregister(void)
         |      ^
   fs/fuse/sysctl.c:36:28: error: expected ';' after top level declarator
      36 | void fuse_sysctl_unregister(void)
         |                            ^
         |                            ;
   7 warnings and 5 errors generated.


vim +/void +36 fs/fuse/sysctl.c

    35	
  > 36	void fuse_sysctl_unregister(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

