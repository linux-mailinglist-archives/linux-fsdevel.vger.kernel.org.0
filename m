Return-Path: <linux-fsdevel+bounces-64564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769CBEC7CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 06:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A4BB4F4D5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 04:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5F266B56;
	Sat, 18 Oct 2025 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HS4FFp+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B423183A;
	Sat, 18 Oct 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762837; cv=none; b=q3LGJIRBx2CItqO7vkLhldAR67sXoeCoTH/OXjq9cI298ewyIxtRF5OEJU+J7f8h9cZRJFkusb5qahsZ9zba1XS+N6EmgiyUx1KbeYFtVPp4ErWv+9T0yPnJ0x9OQ4ayt1b4wco+Hm4R57sxSqUSwmg0txrXzg2c3Fp3fyLk3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762837; c=relaxed/simple;
	bh=VxEiGxEpqNGiOxmfppZ5EdKGKFhkf4LgSqXDCj9LQJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVJSQ6wUUlenBX32Zz/LxnybZiBQJ4b0InQpvywCu9Ym8KoqmvwMStkda5uqiUxZoyAQVIlCzKSziRVBQdP1E7fsS7wplip4UvU72C4+HfmATuQSmBQKLJXSr+rFkpZ87cJZ8b0/MB2x6fBMgeIec6rEis/H7h/aBrNuZXYRQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HS4FFp+B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760762836; x=1792298836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VxEiGxEpqNGiOxmfppZ5EdKGKFhkf4LgSqXDCj9LQJI=;
  b=HS4FFp+BPstNggTCYPup1KB5q4k0d/X8qv+Mm1IFOQ5vvG9ZatnAzEGd
   GEjAZJF/QZdQQq0oKrjshhxwDgvdL2QPTkHQ3rggUhmfq9S2CRpgHVUWE
   lCeubUGT3EtYx8mfpSxvROnH0MKXOkLw8jOYeWivI96aXbPvOAhCyXMcm
   XSuky9AnmkaYgiSxZef8l2ZA0eWq/K0gQkEtKUbd3d5k5KDjOEsZUnYgu
   iOijAMksYmudcX8ScSBwY2uQJGdkgHXRhT1VFwaKUehLXdfWxSYFLs/3x
   C0igwbCK+ugdjkrgXg6/uhjNzaob3aYBeIf54pcx9m5ZyPrEo9FM7haNr
   Q==;
X-CSE-ConnectionGUID: CB+NSmYWQ7umclSENi6gAg==
X-CSE-MsgGUID: sNMYC//JSx+j6aHaiSVjjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62887613"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="62887613"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 21:47:15 -0700
X-CSE-ConnectionGUID: l+D+wMBVRre07wjM8mJ+OQ==
X-CSE-MsgGUID: u/osHsXdTsqLlmkLee4BKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="182445076"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 17 Oct 2025 21:47:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9yqM-00084J-1K;
	Sat, 18 Oct 2025 04:47:04 +0000
Date: Sat, 18 Oct 2025 12:46:49 +0800
From: kernel test robot <lkp@intel.com>
To: Kiryl Shutsemau <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <202510181215.jcL2gJMQ-lkp@intel.com>
References: <20251017141536.577466-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141536.577466-1-kirill@shutemov.name>

Hi Kiryl,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiryl-Shutsemau/mm-filemap-Implement-fast-short-reads/20251017-221655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251017141536.577466-1-kirill%40shutemov.name
patch subject: [PATCH] mm/filemap: Implement fast short reads
config: i386-defconfig (https://download.01.org/0day-ci/archive/20251018/202510181215.jcL2gJMQ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181215.jcL2gJMQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181215.jcL2gJMQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/filemap.c:2753:22: warning: stack frame size (1096) exceeds limit (1024) in 'filemap_read_fast' [-Wframe-larger-than]
    2753 | static noinline bool filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
         |                      ^
   1 warning generated.


vim +/filemap_read_fast +2753 mm/filemap.c

  2752	
> 2753	static noinline bool filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
  2754					       ssize_t *already_read)
  2755	{
  2756		struct address_space *mapping = iocb->ki_filp->f_mapping;
  2757		struct file_ra_state *ra = &iocb->ki_filp->f_ra;
  2758		char buffer[FAST_READ_BUF_SIZE];
  2759		size_t count;
  2760	
  2761		if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE)
  2762			return false;
  2763	
  2764		if (iov_iter_count(iter) > sizeof(buffer))
  2765			return false;
  2766	
  2767		count = iov_iter_count(iter);
  2768	
  2769		/* Let's see if we can just do the read under RCU */
  2770		rcu_read_lock();
  2771		count = filemap_read_fast_rcu(mapping, iocb->ki_pos, buffer, count);
  2772		rcu_read_unlock();
  2773	
  2774		if (!count)
  2775			return false;
  2776	
  2777		count = copy_to_iter(buffer, count, iter);
  2778		if (unlikely(!count))
  2779			return false;
  2780	
  2781		iocb->ki_pos += count;
  2782		ra->prev_pos = iocb->ki_pos;
  2783		file_accessed(iocb->ki_filp);
  2784		*already_read += count;
  2785	
  2786		return !iov_iter_count(iter);
  2787	}
  2788	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

