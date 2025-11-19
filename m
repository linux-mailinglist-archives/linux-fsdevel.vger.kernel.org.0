Return-Path: <linux-fsdevel+bounces-69038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9EDC6C5B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 03:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 71DC72989A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DE7283142;
	Wed, 19 Nov 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiGkeake"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B028134C
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518787; cv=none; b=fgPM4O+j1+CWPU/ABBlXb7Zk6WiCWYBM8XQQr4sHLvsep7UuqVrEEAD+KhEeGUHAxOaQZsh9gLpFXbt5ku/aiVYdK+ImA0reBVArNcuiNfbLRHZgOE3FDx6Os4x36I1mLZ317qMC44ivjbbd4Ekg0sfWWYZU/wDYj3ZmudTLPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518787; c=relaxed/simple;
	bh=x4fsNKLODk4xY43RQL9Z083LN/fJNbxsVGa9jR/CsCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEeFeBt8lmBpbvsKjvmBeEF6NdSqj9fvLEthiZUgbo6qv9GNCcm+C0NQV5ICsHwXei+CTHx5XNCrgy/pL7CRU8FIyLxDXRSO8NmE/S8KDloq+6DkkQJfHl+tWla+5ugPNa/MhhoPnP7LhcyKX5Doyzi5cx2hc9ZOoMi/YN4uDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiGkeake; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763518786; x=1795054786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x4fsNKLODk4xY43RQL9Z083LN/fJNbxsVGa9jR/CsCg=;
  b=iiGkeakeq7KCNhgMt0DXX7OHrPB8R10p+r6BLv1H4mQjuksxKDIaJupI
   oPdhImwQ0UaY2HkWhnelDmUeBmT2C3pTUlyWTvay0OvdqRVY2T3/rCVUN
   FfBvTv/7oKrg7YhHwybbTXRqstArRrJG1EN80oiig7BIH9TSHEmyOmbxV
   qpCVh4T+2ZrhlondZMzS685OwJWn/sSgXH0wRUL96WQosQejdQXjrxAzp
   Nzub6f8ltXEOaX67xxQdSEBwVeaLBgK6xZ3snLntee7tMeptBnvnThq+y
   3Pnt4wx8GD1K+druSuqg+ER1+FSayFgLP/507ULzkIbjyMbTib1ApwNO4
   Q==;
X-CSE-ConnectionGUID: PjXtCuEeTc2Zi6VwShVktQ==
X-CSE-MsgGUID: aBxw80mcSuCPVLj4bkekqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65257007"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65257007"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 18:19:46 -0800
X-CSE-ConnectionGUID: VDWR0AucRSCVkceEYfMb7Q==
X-CSE-MsgGUID: edC4kfhzQEOTvK/LkfE7mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214307012"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Nov 2025 18:19:43 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLXnJ-0002Lr-0d;
	Wed, 19 Nov 2025 02:19:41 +0000
Date: Wed, 19 Nov 2025 10:19:25 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Add uoff_t
Message-ID: <202511190917.pXdJRhD8-lkp@intel.com>
References: <20251118152935.3735484-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118152935.3735484-1-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on arnd-asm-generic/master linus/master v6.18-rc6 next-20251118]
[cannot apply to brauner-vfs/vfs.all]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Add-uoff_t/20251118-233038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251118152935.3735484-1-willy%40infradead.org
patch subject: [PATCH] fs: Add uoff_t
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251119/202511190917.pXdJRhD8-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511190917.pXdJRhD8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511190917.pXdJRhD8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/shmem.c:5810:6: error: conflicting types for 'shmem_truncate_range'
    5810 | void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
         |      ^
   include/linux/shmem_fs.h:129:6: note: previous declaration is here
     129 | void shmem_truncate_range(struct inode *inode, loff_t start, uoff_t end);
         |      ^
   mm/shmem.c:5838:16: warning: unused variable 'flags' [-Wunused-variable]
    5838 |         unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
         |                       ^~~~~
   1 warning and 1 error generated.


vim +/shmem_truncate_range +5810 mm/shmem.c

c01d5b300774d13 Hugh Dickins 2016-07-26  5809  
41ffe5d5ceef7f7 Hugh Dickins 2011-08-03 @5810  void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
94c1e62df4494b7 Hugh Dickins 2011-06-27  5811  {
41ffe5d5ceef7f7 Hugh Dickins 2011-08-03  5812  	truncate_inode_pages_range(inode->i_mapping, lstart, lend);
94c1e62df4494b7 Hugh Dickins 2011-06-27  5813  }
94c1e62df4494b7 Hugh Dickins 2011-06-27  5814  EXPORT_SYMBOL_GPL(shmem_truncate_range);
94c1e62df4494b7 Hugh Dickins 2011-06-27  5815  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

