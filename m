Return-Path: <linux-fsdevel+bounces-27260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACA95FDCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 01:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AC81C2197E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB0419D06C;
	Mon, 26 Aug 2024 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJqV+Uq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19A1482E6;
	Mon, 26 Aug 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724715639; cv=none; b=kb6l5y5BIJqcHHH4i2g60aKS24+rY2w68KDV7f1Hk0E3iD5BV23QYefy+LTYwEWb8oiDaNE1SBqiOYnTeDcTWtb415Mbllg8ajCqdmUhqx4alrxO+mtdh0cTRgDlaujGHX463JfhrrUb9LxySW9zA4AMTSO6YR3x6sTDW7UvPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724715639; c=relaxed/simple;
	bh=571xJqCK4wO/Nkpro048RV+IqOsjkddALvzLZ8d2+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPjK0pKKKFTARJ+tlNi050ai4MeJSHHBgw69qHeKHSx+nrizfY27TtQgb7crLyMyczDDGO0rhCNZwlGJ+s3CCPkshQmhLga3SmVXE7uaA69EQ2M6b919LwcLIEED8c0G1rwZdlH9aDeKVAVAg+6kOIpBpEMZK3yf8TXSTC5Yb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJqV+Uq3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724715637; x=1756251637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=571xJqCK4wO/Nkpro048RV+IqOsjkddALvzLZ8d2+NY=;
  b=UJqV+Uq3LnFLH/UA/DgGXvvjsDppBPEl3ldl5c1oF1ZKE3iy+gQ57Ad9
   2qQpvr6M7OEsecm1K5HA7MnBGkPVozAN1rJ1dbiOe9+ZMrYcNoMGtWV4T
   I4SNzjv5+pu8MtZUlFcK42YNut7lNdjBsaaorQDKrNDrP0fEQ/J9JbLBC
   8iegbfktAaiFpTDfEKEu/sBL48hTwQfGSpyd1/w+ix40653lbY7zYN04V
   1Nl0XEJQJgLInfZE+z0eA5Jf2DFcUxbVp1+soyu3efZ4ziiHZCnbNGNyY
   m6l7DBXtn1UtdAwXw/71b+I9nGmnvIbp/fCR8PrKn/7C0CyeV8Nce+ro2
   Q==;
X-CSE-ConnectionGUID: v5IVfa3STguAPteckh6B3w==
X-CSE-MsgGUID: 45hHCUW2TkSYU/vz+Ke7VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="48555799"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="48555799"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 16:40:36 -0700
X-CSE-ConnectionGUID: AxF7d+MhRQu3PzBd2tU2tw==
X-CSE-MsgGUID: a7uNzrDrRHeEpfI7mJcKAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62646779"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Aug 2024 16:40:33 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sijK3-000Hh8-0X;
	Mon, 26 Aug 2024 23:40:31 +0000
Date: Tue, 27 Aug 2024 07:40:09 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, krisman@kernel.org,
	Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH 1/5] tmpfs: Add casefold lookup support
Message-ID: <202408270609.Nj6iM21E-lkp@intel.com>
References: <20240823173332.281211-2-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823173332.281211-2-andrealmeid@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/tmpfs-Add-casefold-lookup-support/20240826-135457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240823173332.281211-2-andrealmeid%40igalia.com
patch subject: [PATCH 1/5] tmpfs: Add casefold lookup support
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240827/202408270609.Nj6iM21E-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270609.Nj6iM21E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270609.Nj6iM21E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shmem.c:4874:23: warning: 'shmem_lookup' defined but not used [-Wunused-function]
    4874 | static struct dentry *shmem_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
         |                       ^~~~~~~~~~~~


vim +/shmem_lookup +4874 mm/shmem.c

  4873	
> 4874	static struct dentry *shmem_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
  4875	{
  4876		if (dentry->d_name.len > NAME_MAX)
  4877			return ERR_PTR(-ENAMETOOLONG);
  4878	
  4879		/*
  4880		 * For now, VFS can't deal with case-insensitive negative dentries, so
  4881		 * we prevent them from being created
  4882		 */
  4883		if (IS_CASEFOLDED(dir))
  4884			return NULL;
  4885	
  4886		d_add(dentry, NULL);
  4887	
  4888		return NULL;
  4889	}
  4890	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

