Return-Path: <linux-fsdevel+bounces-10057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F91E8475F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA72A1C25555
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502901474BE;
	Fri,  2 Feb 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrNXQJ3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823445BF3
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894346; cv=none; b=c1yzSgv83ftrShIEixbTKGFUZezVd8FBq7aRjEgPfFRg90xVjuU57/KaxfEZL277U7OqImVDJhZrlx8tedVQmt6V8qPEQzyrKSvQNUgIZf+4vVZK7XtD1urAI5zFmtLYGPnlc1GAmsa3/Lc/ADPC1FjzrIgV51mWCLHYWHZKC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894346; c=relaxed/simple;
	bh=mJgq3ofmCoWHQ4kNSmvNlxA1eQkDiJKs+jlZfxisP+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtvSHk38ZRqaZCjVforeIl7FrzE/UB1tJwbKPzGOE77hzxi/GcCCHU7ztus52Wo/kkUIlS57ziyzE5VkVOWBjytFWz5ywqc7zVKV9sJZZHOtNfdASKEM6Uwh23wLe9/GdmnUDSk9zXUDD+chUDmQtcbYheX1lopR1GofSutEIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrNXQJ3X; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706894345; x=1738430345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mJgq3ofmCoWHQ4kNSmvNlxA1eQkDiJKs+jlZfxisP+I=;
  b=MrNXQJ3XUt0nuWCJa9PbdmYBFFmOKzEEKL5xAhtY4k9ge2gtVMTSOVrD
   28wzi4KePn/ixfl3ZGGPnCGfManO5SsBJwSnP5HKrmSL1LYpdrBC0eARx
   8itJ+1Njei2uVKiNLdXSFLx9lVs2MvNBK4LFHB0AEODpg/lwhWk604os3
   4f50b3J7oNNNcv429+nnwxO8OgIHsByWnjnWrWAIsE6Jzm2zqTx3s8NR5
   XBjzlG8yh7ddXPXp8FR8e1Th5/OoADhyZ+XvWCVnLQr2cFsS0uQS4JQ/F
   BUfJSk+31bJ04uXGht3xgGH6cVIKFbqutL4u3J4yKeGgoUItAanOi48ag
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="116503"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="116503"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:19:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="129837"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2024 09:19:01 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVxBq-00045q-2J;
	Fri, 02 Feb 2024 17:18:58 +0000
Date: Sat, 3 Feb 2024 01:18:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/13] jfs: Convert drop_metapage and remove_metapage to
 take a folio
Message-ID: <202402030124.yWFowXZd-lkp@intel.com>
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
[also build test ERROR on linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/jfs-Convert-metapage_read_folio-to-use-folio-APIs/20240202-064805
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/20240201224605.4055895-7-willy%40infradead.org
patch subject: [PATCH 06/13] jfs: Convert drop_metapage and remove_metapage to take a folio
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240203/202402030124.yWFowXZd-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402030124.yWFowXZd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030124.yWFowXZd-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/jfs/jfs_metapage.c: In function 'remove_metapage':
>> fs/jfs/jfs_metapage.c:128:38: error: passing argument 1 of 'folio_detach_private' from incompatible pointer type [-Werror=incompatible-pointer-types]
     128 |                 folio_detach_private(&folio->page);
         |                                      ^~~~~~~~~~~~
         |                                      |
         |                                      struct page *
   In file included from include/linux/buffer_head.h:15,
                    from fs/jfs/jfs_metapage.c:14:
   include/linux/pagemap.h:508:56: note: expected 'struct folio *' but argument is of type 'struct page *'
     508 | static inline void *folio_detach_private(struct folio *folio)
         |                                          ~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors


vim +/folio_detach_private +128 fs/jfs/jfs_metapage.c

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

