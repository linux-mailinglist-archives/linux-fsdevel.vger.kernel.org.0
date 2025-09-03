Return-Path: <linux-fsdevel+bounces-60128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63732B4182D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CF21885F63
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5102EA729;
	Wed,  3 Sep 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhoQaYWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B52DCF55;
	Wed,  3 Sep 2025 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887373; cv=none; b=XIJgmFkCaOCWT+7b5r11V/pmbl2Ld4tOJwh2bLZiO3wX4Ue5GbJ6R4WuGG1PVfsze2B/hKu7KKmyj5W7fVPhAbFFkXbAMSsqJ4Nym1c8nVz6IeE9fvRonz0rhJEzzSAaIh9TIt5rx7wD7vcMILUlOjLwxi2bQL46dHVw18mvQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887373; c=relaxed/simple;
	bh=QdFctaTdCxVBox5X0aH0FPreiOksaazml8cclYfxhvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XArM1MbYW8dU1Dnj7DVVaEOqpd3whkHbyuwt0RG703akzrC3Mzk6gJ1m040ESf+ImsRh0L5v0Wx8wIX/MsUEfyAd+e3tZ5BVURXN5WxLfi7CLSLhFgLoYKU+UAJ17PgzsDk7QlIdu9JitV9g90geR6TD6xOZqbwYG12x5ethEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhoQaYWJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756887371; x=1788423371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QdFctaTdCxVBox5X0aH0FPreiOksaazml8cclYfxhvc=;
  b=mhoQaYWJ4DdfMYwvOo4k2hxhUe5RePS1qI0HkPf7m82MTXUCjiB4zQ+9
   9kQc9mrwNfuETEYHTU4LFcBZpgTD4lB95mqo3HQX8GzRLEx+aR7jg+8+i
   ehHhhFvzYXL6OlUAW2yXV1l4dqT2L6dOxRdFM9MwhPnm9jfCD10MHsosg
   1KVl9SS9CBC4Cq8fvrr/gkjuXeUJS7cUpPakzYymcPDKBVycZWo+fiHlD
   bLSMnYUE0a1SHBjOinW9IzxdYx01Dzupht4tmQwZU2fmfvhXVPrRBNhyS
   UZO12SvRpWAi/NNk/A7lUxHxpQV0E/L4o5lHwWCxCqh535ur3nMWti9Be
   g==;
X-CSE-ConnectionGUID: 1KaJkzlUR3GPnHLY15y8Lg==
X-CSE-MsgGUID: +O7xb6OKRpih+5M1ZMoqGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69894618"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69894618"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:16:11 -0700
X-CSE-ConnectionGUID: Y/WIdI61R2OZCJv3eMVx8g==
X-CSE-MsgGUID: 7pquVhkLTZiX7jQljyftiw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2025 01:16:08 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utieh-0003Z9-1M;
	Wed, 03 Sep 2025 08:15:52 +0000
Date: Wed, 3 Sep 2025 16:13:42 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Christian Brauner <christian@brauner.io>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.com>,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2, udf: update to use mmap_prepare
Message-ID: <202509031521.aEPzyTZp-lkp@intel.com>
References: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902115341.292100-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on gfs2/for-next linus/master v6.17-rc4 next-20250902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/gfs2-udf-update-to-use-mmap_prepare/20250902-200024
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250902115341.292100-1-lorenzo.stoakes%40oracle.com
patch subject: [PATCH] gfs2, udf: update to use mmap_prepare
config: x86_64-randconfig-005-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031521.aEPzyTZp-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031521.aEPzyTZp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031521.aEPzyTZp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/gfs2/file.c:1582:18: error: use of undeclared identifier 'gfs2_mmap'; did you mean 'vfs_mmap'?
    1582 |         .mmap_prepare   = gfs2_mmap,
         |                           ^~~~~~~~~
         |                           vfs_mmap
   include/linux/fs.h:2393:19: note: 'vfs_mmap' declared here
    2393 | static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
         |                   ^
>> fs/gfs2/file.c:1582:18: error: incompatible function pointer types initializing 'int (*)(struct vm_area_desc *)' with an expression of type 'int (struct file *, struct vm_area_struct *)' [-Wincompatible-function-pointer-types]
    1582 |         .mmap_prepare   = gfs2_mmap,
         |                           ^~~~~~~~~
   2 errors generated.


vim +1582 fs/gfs2/file.c

  1574	
  1575	const struct file_operations gfs2_file_fops = {
  1576		.llseek		= gfs2_llseek,
  1577		.read_iter	= gfs2_file_read_iter,
  1578		.write_iter	= gfs2_file_write_iter,
  1579		.iopoll		= iocb_bio_iopoll,
  1580		.unlocked_ioctl	= gfs2_ioctl,
  1581		.compat_ioctl	= gfs2_compat_ioctl,
> 1582		.mmap_prepare	= gfs2_mmap,
  1583		.open		= gfs2_open,
  1584		.release	= gfs2_release,
  1585		.fsync		= gfs2_fsync,
  1586		.lock		= gfs2_lock,
  1587		.flock		= gfs2_flock,
  1588		.splice_read	= copy_splice_read,
  1589		.splice_write	= gfs2_file_splice_write,
  1590		.setlease	= simple_nosetlease,
  1591		.fallocate	= gfs2_fallocate,
  1592		.fop_flags	= FOP_ASYNC_LOCK,
  1593	};
  1594	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

