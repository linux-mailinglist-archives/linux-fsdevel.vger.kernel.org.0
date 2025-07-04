Return-Path: <linux-fsdevel+bounces-53979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EE4AF9AEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715B5547B52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576B91DF725;
	Fri,  4 Jul 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkOsofo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599512E36EB
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751655333; cv=none; b=UmVjAtK5T3O3EYIaiqdf/+jELbYS73Vt9BdW+oMOhYOdTLyEQ2EcFkaJZGbXSLdLhEt9lcSpI6wt9QjXx0NiJA2r7FcN1pDyxVAfWU8aVlnXw8CSyfjb5BxQziJSOh6rvRCegQnZQFFpFlpdRWfweIpc2lyJtQQ6hFB83HTpL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751655333; c=relaxed/simple;
	bh=Fk5jakoXn2e6nt19R7Pr6NifkZ40uMcZscnajWxh3S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm5la4awF8fI8JrsP/NnUP2taDAAWrlwypXiqSXoYG8t+iQcePo1K11THLYv8NAhIC+eXJFWfpvPlln/GPwazlH+OWPEmlo2HFUau5eiQjIQtXxWa1niCLWGNoDtpktQp6jjBLNlTNZd26175/xszdf7rnrbF9nWJ7Y/y3dvFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkOsofo+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751655332; x=1783191332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fk5jakoXn2e6nt19R7Pr6NifkZ40uMcZscnajWxh3S8=;
  b=BkOsofo+qBZhnpOHQCEDcCJXLUCr4P1SomODfWGE5tOORF/Kx6It+uEb
   8eZ0PXOtnIWKtfuFXCBHue5lgCEJeGRmI6eGpjIrecJk7bMFKLGOBw4XP
   +WN/vCcLPK/nKSi+57IHqWuBn3NLfGYg1S74JRl9T6TVc8ZzR+wxPArBg
   cc6r3NqXfxwgNBZj38eDQ2doAohexZapkBpgJ0Mp/hu4WfuFu3zcQjYbo
   yG7WjHVkO9FLvUDxKRWH3/Xaht8vem+Kcyr8rKL9vIunEuQ4ChlOonEiT
   ZO8+Uyyna63DTVKw5Vb3ciAquWiYEeBCHxK/SMrKHpfsAK6NOWdnMyrDX
   A==;
X-CSE-ConnectionGUID: p3NBu0brSD2wNTtWLVTOyA==
X-CSE-MsgGUID: Wf01ISbBSTqcQUsPe+eECw==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53209019"
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; 
   d="scan'208";a="53209019"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 11:55:31 -0700
X-CSE-ConnectionGUID: I2SOwTtXS6CzpSiaIzlm5w==
X-CSE-MsgGUID: bVfM+X/qRw6J2HQVkeV0Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; 
   d="scan'208";a="191869526"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Jul 2025 11:55:29 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXlZH-00040F-1B;
	Fri, 04 Jul 2025 18:55:27 +0000
Date: Sat, 5 Jul 2025 02:55:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] fuse: Use filemap_invalidate_pages()
Message-ID: <202507050209.rVvcbaHY-lkp@intel.com>
References: <20250703192459.3381327-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703192459.3381327-2-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-fuse/for-next]
[also build test ERROR on linus/master v6.16-rc4 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fuse-Use-filemap_invalidate_pages/20250704-032629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20250703192459.3381327-2-willy%40infradead.org
patch subject: [PATCH 1/1] fuse: Use filemap_invalidate_pages()
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20250705/202507050209.rVvcbaHY-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507050209.rVvcbaHY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507050209.rVvcbaHY-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "filemap_invalidate_pages" [fs/fuse/fuse.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

