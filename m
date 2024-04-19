Return-Path: <linux-fsdevel+bounces-17265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056A8AA638
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 02:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999101F21CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 00:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8607E2;
	Fri, 19 Apr 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAP7qSZn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C9385
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 00:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486640; cv=none; b=YTSMz11ixPBMsvuroDskxj4VouFGDMkkv5p4f1QGqeUXZbuL7TyqW6/or+m14LwuYWT86FGrZwy95exvmqh/tu8E5X4MfL94eJwexVcL8z2PUJkW8Xa1A+3X7CX6Di59g17k7Nfyf/QAQUWAivhkuYR4RzBrxH3PRNBpPYZobq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486640; c=relaxed/simple;
	bh=KuPMpVwUgnSUFnRUWRDeRwToaXoQtFfEFGyQl/W3lf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX0A26bhVXnkGvDU7u8Na/IGK7F9aepZQiGZnJFJ00O7Srdj6ujum3WaD4THhdJzST9VEeA5V8ZLG/Tm26CBnE2zuc1NoJumTIHiDggPqgFDThRmniOMckNDrk7MksVprGO8HcPwh855pCif0PfPCbqJfCoDZBlD248YIQWPIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAP7qSZn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713486638; x=1745022638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KuPMpVwUgnSUFnRUWRDeRwToaXoQtFfEFGyQl/W3lf8=;
  b=MAP7qSZns9bGZw5jLSkp0PivrmSMf7MLupHEBUUjhh9mwbHFthAeu4ho
   6lnv8ByzYMzgdsx7RlxLIXWQG/pkgazXirA7zlk94ZIc5JriS+uR6y0OY
   RXRBYvmV7DmYi33VvhPFsWte+b5wbG/ymF7St59J7e0yek8ERoRW15NoG
   vjYXTIkqSYm62fPB6MSkmra7ZSc8UuZ5Xc4mDAc3ZOyvSB1lIM1tl8x6H
   Ij8Gxq0FgojVCVndXWH5wbgzXpLM9sERkop4+JjT0NOVQUSAL8fq/ctDr
   sZk/VqbkiE2NpIh8zwhQw9jfCRqVF8ZK4CqnKrKkCNJ0vWhBbJp6nGlf4
   w==;
X-CSE-ConnectionGUID: VAtZY1iyROidDtHuU/pzTg==
X-CSE-MsgGUID: rYAoZznLRIOTdQVHQ8E1mQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9231205"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9231205"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 17:30:38 -0700
X-CSE-ConnectionGUID: BxKEu7MZTpmK+2XkJmCZEg==
X-CSE-MsgGUID: 5IltU5jWQdehjC+e1RyR8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23212547"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 18 Apr 2024 17:30:36 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxc9B-0009PG-14;
	Fri, 19 Apr 2024 00:30:33 +0000
Date: Fri, 19 Apr 2024 08:30:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/10] ntfs3: Use a folio to read UpCase
Message-ID: <202404190823.2p1A9tNE-lkp@intel.com>
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
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240419/202404190823.2p1A9tNE-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190823.2p1A9tNE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190823.2p1A9tNE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/pagemap.h:11,
                    from lib/buildid.c:7:
   include/linux/highmem.h: In function 'memcpy_from_folio_le16':
>> include/linux/highmem.h:484:22: error: 'i' undeclared (first use in this function)
     484 |                 for (i = 0; i < chunk / sizeof(*to); i++)
         |                      ^
   include/linux/highmem.h:484:22: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/linux/tcp.h:17,
                    from include/linux/ipv6.h:101,
                    from include/net/addrconf.h:61,
                    from lib/vsprintf.c:41:
   include/linux/highmem.h: In function 'memcpy_from_folio_le16':
>> include/linux/highmem.h:484:22: error: 'i' undeclared (first use in this function)
     484 |                 for (i = 0; i < chunk / sizeof(*to); i++)
         |                      ^
   include/linux/highmem.h:484:22: note: each undeclared identifier is reported only once for each function it appears in
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


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

