Return-Path: <linux-fsdevel+bounces-54067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CFAFADD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 09:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60FC17F132
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A4728B3EB;
	Mon,  7 Jul 2025 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqXGh+98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75430285CBD;
	Mon,  7 Jul 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875049; cv=none; b=Di/xsOCRThCrivIiQaQdaHmmZDRbTwSzC6a3IStxKrA53sLQLIySOJu34E6MCRpItQcQWWjJkph/cp10juoVS04LdgMhnfF74as2suvvsyfN0nRTWkq/I47NAZXcCXHEKRotRRfodDaqeTuYd70Dicfi9IW2PM6hGnH6tCa1SKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875049; c=relaxed/simple;
	bh=NgImrN6amk2YtYswbo5+SrMae2P5F6NxO2Duvw5AbHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l11vpo25qYBl5jKhSs5rZ+NbZMMaM2Y0JrMXxLcJmSnKpTVf5Z0lP3X9y2BwPhXV65/sTFsZCnQl3viO9PMzcPzHn4JaZJrTIf9jJYS79YN1QoDqRAEMdLIKoCC0CUOuMn6N7V3h4i/bvnaSWy4mO8UxHC7pSVk06233fU+S+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqXGh+98; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875047; x=1783411047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NgImrN6amk2YtYswbo5+SrMae2P5F6NxO2Duvw5AbHw=;
  b=PqXGh+98CIjiuyi0bguWob/TGW9981XdocQcEgoPnJ+Ai7pIULcA+Vb7
   ytMdrjlI1uyQAPrC2DTvCiJKFfyVcgzz4WhV0kga/KraotSLLGjzlz1v0
   2HM7E4Vexk63ksiSvGlZoEwyVfDcwpQUQznLPKAykZivnFrsu9/sBkqs7
   dKkA3w+QuTf2lEZeLn0oP4J3u8lQgZjKddnyhAabOxAKZUlDVOb2mJV96
   yE+W6t1vEeRbnP/kbSXziJT58bGMmbtczmdYRH9KCFIsnq0OyI+nDFd2F
   8X9QWEJoMA1RTOB1M3AQY8XrY5Osr7bC68Y1GWzDy4MVzOvWpMo2FX+uu
   Q==;
X-CSE-ConnectionGUID: v4WBFwQ3S26RiYG89X91Dg==
X-CSE-MsgGUID: y/aBGctWReGQe8djyKXKdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65151082"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="65151082"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 00:57:23 -0700
X-CSE-ConnectionGUID: STh4V0D9QkC8zr+WktbP7Q==
X-CSE-MsgGUID: y9rrMQGzT32AhN6S68zIFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="155625886"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Jul 2025 00:57:20 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYgiz-0000Ff-0v;
	Mon, 07 Jul 2025 07:57:17 +0000
Date: Mon, 7 Jul 2025 15:56:53 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 05/10] mm/mremap: use an explicit uffd failure path for
 mremap
Message-ID: <202507071505.e2HFMCH2-lkp@intel.com>
References: <be3e068c77107d385d89eae634317cb59e04e5ba.1751865330.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be3e068c77107d385d89eae634317cb59e04e5ba.1751865330.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-mremap-perform-some-simple-cleanups/20250707-133132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/be3e068c77107d385d89eae634317cb59e04e5ba.1751865330.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 05/10] mm/mremap: use an explicit uffd failure path for mremap
config: i386-buildonly-randconfig-002-20250707 (https://download.01.org/0day-ci/archive/20250707/202507071505.e2HFMCH2-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250707/202507071505.e2HFMCH2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507071505.e2HFMCH2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/mremap.c:1739:3: error: call to undeclared function 'mremap_userfaultfd_fail'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1739 |                 mremap_userfaultfd_fail(vrm->uf);
         |                 ^
   mm/mremap.c:1739:3: note: did you mean 'mremap_userfaultfd_prep'?
   include/linux/userfaultfd_k.h:363:20: note: 'mremap_userfaultfd_prep' declared here
     363 | static inline void mremap_userfaultfd_prep(struct vm_area_struct *vma,
         |                    ^
   1 error generated.


vim +/mremap_userfaultfd_fail +1739 mm/mremap.c

  1731	
  1732	static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
  1733	{
  1734		struct mm_struct *mm = current->mm;
  1735	
  1736		/* Regardless of success/failure, we always notify of any unmaps. */
  1737		userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
  1738		if (failed)
> 1739			mremap_userfaultfd_fail(vrm->uf);
  1740		else
  1741			mremap_userfaultfd_complete(vrm->uf, vrm->addr,
  1742				vrm->new_addr, vrm->old_len);
  1743		userfaultfd_unmap_complete(mm, vrm->uf_unmap);
  1744	}
  1745	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

