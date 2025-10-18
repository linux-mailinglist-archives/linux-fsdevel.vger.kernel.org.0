Return-Path: <linux-fsdevel+bounces-64563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F01BEC6A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 05:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DCBD4E45F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3003284690;
	Sat, 18 Oct 2025 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVcZqKcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95015247DE1;
	Sat, 18 Oct 2025 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760759694; cv=none; b=HpQYTqquXrZBYENncO1lqlKzNKUVBMKYBgoqsxaRGebpYIPtAE/kw0If6KsxI83zQhDnNNbEwqJh0x1yEO21LRyukhELtbiiTv1JpiB+Or+vCKauVayz7IIienJdiHfL05EF40sHsVHlXovAJrclA+diceAN1ffrx2JskrBimH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760759694; c=relaxed/simple;
	bh=okI3RpJTLrRj1PrupblKZE/45kDzmQjlxy+SRy5hI2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aatsT6q3t6sLN1ZpD4sx9pHwAM5cPAlLNUmeGyHYmcPqKC04J9uaDVX9IKr8olA/jyXRvc6ERCHYq9o5IY2laAxRIaog2AlstT/zn+GmQApp4UN4VD4KSqD+Nhlv3WY2flVtEMbatRQFUP+t+X8uRuxkH9iFxz7KHsmSRNX/XjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVcZqKcT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760759693; x=1792295693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=okI3RpJTLrRj1PrupblKZE/45kDzmQjlxy+SRy5hI2c=;
  b=UVcZqKcT+U1pGxYRoU59hxOsc2CW6I7s9rc1IFp11Ktqx08d/uxtcrDD
   nO8LeAOSuPQLzhXSJ3J2RRNDTDwA7a85AIKUmtTmswvZpxw7YQiAkX08Y
   nipc9086raT7SXj/W/PmQZRaw3JWUpZXQcw0dJTS7NcegV2pIntn4UdnZ
   JxMc44JcC06M5UpxzBy51P3Fi/hHwLY6Gj+m1m0tBFyVMb8GR5muC5CVh
   i7IhgKn3oTlV0X4Y/wc1rqQm3cd7gCrNPyHpaL0YZpZJjQhXzKWkFRjp7
   AFyXsSUwHQpR1B3xhAFzR4DGWV0A7GPlM7dWLbNbwqzoxaZ/pZNeE9uCc
   Q==;
X-CSE-ConnectionGUID: uGRK606hR7yo24GMjT9fbA==
X-CSE-MsgGUID: owfeXXZlTt+vXPUNzll7CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63017958"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="63017958"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 20:54:52 -0700
X-CSE-ConnectionGUID: lfkJnemmRKGrlC6HZMrttw==
X-CSE-MsgGUID: kKFSxIhlRyyzUPXhaFL+Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="182703077"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 17 Oct 2025 20:54:49 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9y1m-00082V-1y;
	Sat, 18 Oct 2025 03:54:46 +0000
Date: Sat, 18 Oct 2025 11:54:28 +0800
From: kernel test robot <lkp@intel.com>
To: Kiryl Shutsemau <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <202510181107.YiEpGvU3-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251018/202510181107.YiEpGvU3-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181107.YiEpGvU3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181107.YiEpGvU3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/filemap.c: In function 'filemap_read_fast':
>> mm/filemap.c:2787:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    2787 | }
         | ^


vim +2787 mm/filemap.c

  2752	
  2753	static noinline bool filemap_read_fast(struct kiocb *iocb, struct iov_iter *iter,
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
> 2787	}
  2788	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

