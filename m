Return-Path: <linux-fsdevel+bounces-17267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB28AA672
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 03:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BD0283999
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 01:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752B710F1;
	Fri, 19 Apr 2024 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWzFNJjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692265F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 01:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489177; cv=none; b=jV2OHxFch5NLwIbTpC8g8fqYo5XflNMmeXVlD+7sBKllWRc+hKChM/cSn0nGNMlUm6FRwf1qW87rp9NQjEVHbeqGb0I8kcVhTWcCz+LMq/Yr8D9CN3TpC87uNxuwZJHGg+mnbyXFClmstcpcDqc4sbjYvEx4v8bscZGH4RFAKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489177; c=relaxed/simple;
	bh=UrVZcXyuwhb2Y/0nnniH6U0OkjOJo1iNln9z3EeYTuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbGippjr3qOSl3bm7ua+287Bxz2Yq7aSQKGGUAcs6hkPnagW1t3fk/X29fjXPAhVUVqYQjq3IuZxhKxxvI8vyINXozKtLURbBgqB6bU0dbymXX2wd26jqDLc/f1C6fM0npNNo3Q9Ro+R0P373+H1hoDb33PsjAw4WNBwyrc7tsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWzFNJjF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713489175; x=1745025175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UrVZcXyuwhb2Y/0nnniH6U0OkjOJo1iNln9z3EeYTuI=;
  b=IWzFNJjFfMek4sGoiEJ2HX7xrIGr9gQ6LtpVZ9ek2e+k9xT7GiOKBTxd
   SBEv25Ww05sWJaYsjEqDB1ez5n5xMuv1sgH8It1Tfx9QUuzI7MwwZ++kO
   YS4wLYlaljInScii92ysh+FdV/yHcw/T4vQedUXKrpy0lVnoUivB9QYtU
   9mAvTQ46mbuPQWd3tfOW90Kzl/xmGlK/8cqrY3oMivcprkNBYlKzCwktz
   qwP5+zZW6TwsUqQCWfvkHpZAOmrPMkBUoWSF/Ur5FYbyUkAl9Hmj3awDH
   to1cM1W4kQLft1E+OnVbDN72n9mFjx3XWR3UAWhzPFQNqXz8h0rQZuULH
   g==;
X-CSE-ConnectionGUID: qCpX9qt+QcaeVrsu8P6Ggg==
X-CSE-MsgGUID: K8NJpOcZQuyBW36jW5DrFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12854844"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="12854844"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 18:12:54 -0700
X-CSE-ConnectionGUID: mbD2S+GfRwGaitbFZNqctg==
X-CSE-MsgGUID: 90WyE5UHQOm2XMlqedKTxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23677099"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 18 Apr 2024 18:12:51 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxco5-0009Qy-0O;
	Fri, 19 Apr 2024 01:12:49 +0000
Date: Fri, 19 Apr 2024 09:12:23 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/10] ntfs3: Use a folio to read UpCase
Message-ID: <202404190841.KPS2VQgB-lkp@intel.com>
References: <20240417170941.797116-9-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417170941.797116-9-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9-rc4]
[cannot apply to next-20240418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/ntfs3-Convert-ntfs_read_folio-to-use-a-folio/20240418-011140
base:   linus/master
patch link:    https://lore.kernel.org/r/20240417170941.797116-9-willy%40infradead.org
patch subject: [PATCH 08/10] ntfs3: Use a folio to read UpCase
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240419/202404190841.KPS2VQgB-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190841.KPS2VQgB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190841.KPS2VQgB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:19:
   In file included from include/linux/msi.h:27:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:19:
   In file included from include/linux/msi.h:27:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:19:
   In file included from include/linux/msi.h:27:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:41:
   In file included from include/linux/kvm_para.h:5:
   In file included from include/uapi/linux/kvm_para.h:37:
   In file included from arch/s390/include/asm/kvm_para.h:25:
   In file included from arch/s390/include/asm/diag.h:12:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
>> include/linux/highmem.h:484:8: error: use of undeclared identifier 'i'
     484 |                 for (i = 0; i < chunk / sizeof(*to); i++)
         |                      ^
   include/linux/highmem.h:484:15: error: use of undeclared identifier 'i'
     484 |                 for (i = 0; i < chunk / sizeof(*to); i++)
         |                             ^
   include/linux/highmem.h:484:40: error: use of undeclared identifier 'i'
     484 |                 for (i = 0; i < chunk / sizeof(*to); i++)
         |                                                      ^
   13 warnings and 3 errors generated.
   make[3]: *** [scripts/Makefile.build:117: arch/s390/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1197: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/i +484 include/linux/highmem.h

   469	
   470	#ifdef __BIG_ENDIAN
   471	static inline void memcpy_from_folio_le16(u16 *to, struct folio *folio,
   472			size_t offset, size_t len)
   473	{
   474		VM_BUG_ON(offset + len > folio_size(folio));
   475	
   476		do {
   477			const __le16 *from = kmap_local_folio(folio, offset);
   478			size_t chunk = len;
   479	
   480			if (folio_test_highmem(folio) &&
   481			    chunk > PAGE_SIZE - offset_in_page(offset))
   482				chunk = PAGE_SIZE - offset_in_page(offset);
   483	
 > 484			for (i = 0; i < chunk / sizeof(*to); i++)
   485				*to++ = le16_to_cpu(*from++);
   486			kunmap_local(from);
   487	
   488			to += chunk / sizeof(*to);
   489			offset += chunk;
   490			len -= chunk;
   491		} while (len > 0);
   492	}
   493	#else
   494	static inline void memcpy_from_folio_le16(u16 *to, struct folio *folio,
   495			size_t offset, size_t len)
   496	{
   497		memcpy_from_folio((char *)to, folio, offset, len);
   498	}
   499	#endif
   500	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

