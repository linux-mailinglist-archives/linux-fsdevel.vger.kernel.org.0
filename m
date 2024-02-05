Return-Path: <linux-fsdevel+bounces-10258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5518A8498D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25B2B24B25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331D1864D;
	Mon,  5 Feb 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CswdhMFg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E118E06
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132571; cv=none; b=NrXF+yWouMnKUBkDYpZ6Im7fcJQo9jXuELpwPLCSF6JggBTszS33CVflTRMvzEhMIgrqCnXQi7bKdh8n9GNHB0d6XKy7COH5MmGAdYpkSjM70n9PK+hCRDpumUObqtOKToyEyUjPMDUBQ4BuEV2c2Idna50RBxGsdEXkrYl+OPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132571; c=relaxed/simple;
	bh=uF1gkyIrxXJK/4Bkw/24aNFO4Q92fF8zob3eSfbJaBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hisgeu/nuWJEmmz1Du4i3PlhTNDQry6TdxJ0meQeFk2wzsub7cyQ/K/EAclkOte+nVFkpL57RFWSi8j5x8cHjXKtkvsqhEfqF0IdSnRos2avZ7Hh3oXCEV4KzeuftotVBSx3RtGiWCxuN5Qq8126n41l9HBmSJcyGWRMWJQDKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CswdhMFg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707132569; x=1738668569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uF1gkyIrxXJK/4Bkw/24aNFO4Q92fF8zob3eSfbJaBw=;
  b=CswdhMFgi9LYJkALPNpinr5c2YxB5uU5o2bON+qy0tZmEBzSWABWs8q6
   9I2+U5BK7ENQynkO4UKefgXL1BHEX0CRJCFhjNUwtIRYk3Mtp7akB4Ynh
   wLu9HuD0xNJvJma0hZn25g97bJpdDlM0PXFxzYgdlcI3h88wpRgqa8mzt
   AhGjVJb9AQObGdFEdmv5VkJ4T5OyTfSmC6ril+JqnCygtTcbOruaLzUa8
   eal8fVkLGOBGf7+tS90hTDsqhpl1VIXTYbreLVSArGJliYOO6mYrdEnTg
   T9OvfEbakDaOkFVG83YD4IlmrLKmqYPRAeH3HZ38JtmUlegP6/voEfD/0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="658644"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="658644"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 03:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="693581"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Feb 2024 03:29:26 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWxAB-0000RU-0P;
	Mon, 05 Feb 2024 11:29:23 +0000
Date: Mon, 5 Feb 2024 19:29:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/13] jfs: Convert drop_metapage and remove_metapage to
 take a folio
Message-ID: <202402051937.xQSqcqKO-lkp@intel.com>
References: <20240201224605.4055895-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201224605.4055895-7-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on kleikamp-shaggy/jfs-next]
[also build test ERROR on linus/master v6.8-rc3 next-20240205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/jfs-Convert-metapage_read_folio-to-use-folio-APIs/20240202-064805
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/20240201224605.4055895-7-willy%40infradead.org
patch subject: [PATCH 06/13] jfs: Convert drop_metapage and remove_metapage to take a folio
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240205/202402051937.xQSqcqKO-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240205/202402051937.xQSqcqKO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402051937.xQSqcqKO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/jfs/jfs_metapage.c:128:24: error: incompatible pointer types passing 'struct page *' to parameter of type 'struct folio *' [-Werror,-Wincompatible-pointer-types]
     128 |                 folio_detach_private(&folio->page);
         |                                      ^~~~~~~~~~~~
   include/linux/pagemap.h:508:56: note: passing argument to parameter 'folio' here
     508 | static inline void *folio_detach_private(struct folio *folio)
         |                                                        ^
   1 error generated.


vim +128 fs/jfs/jfs_metapage.c

   114	
   115	static inline void remove_metapage(struct folio *folio, struct metapage *mp)
   116	{
   117		struct meta_anchor *a = mp_anchor(&folio->page);
   118		int l2mp_blocks = L2PSIZE - folio->mapping->host->i_blkbits;
   119		int index;
   120	
   121		index = (mp->index >> l2mp_blocks) & (MPS_PER_PAGE - 1);
   122	
   123		BUG_ON(a->mp[index] != mp);
   124	
   125		a->mp[index] = NULL;
   126		if (--a->mp_count == 0) {
   127			kfree(a);
 > 128			folio_detach_private(&folio->page);
   129			kunmap(&folio->page);
   130		}
   131	}
   132	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

