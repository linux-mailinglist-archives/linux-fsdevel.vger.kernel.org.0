Return-Path: <linux-fsdevel+bounces-29344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED39785C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039BD1C22D32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D878C9C;
	Fri, 13 Sep 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKcfzZ+k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6247A73;
	Fri, 13 Sep 2024 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244952; cv=none; b=WICoFuIg2nEp1AqLpcKmQiRFuSp62hipicEEBcbTD/cmZtXZ/f74CvmLJEhx8qsyhoKnMgkgjxMi5qj5aqrCbj0jn0alv+T1qSDdI+e20iZz97yMMUspUSNMLnolrG6j8T/HdVtoLhmLGKAapkjpS94uFenufYoqW/BK6vuzK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244952; c=relaxed/simple;
	bh=zt6YDVIJBQlscpsFRYZrbf10aHXuw1R+1KoafjSJfv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnohp8mSUgnVOnPGzJkxLNj5vz183MjkYL/GzAxNSOcvGNqlvphJHAl9Sc+td7Km2PUbd5vQn7txdKD+uf4Vxnm8aeNkeP3rtuGmApQO+A0maCcxLfY/C2CBb8kcOkSsuiXUIaBbugujZw3+wn57giVyU7uNE0Wykgbp8yVzmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKcfzZ+k; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726244950; x=1757780950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zt6YDVIJBQlscpsFRYZrbf10aHXuw1R+1KoafjSJfv4=;
  b=PKcfzZ+k13Y6SnJVr8S93XFpkxXGH/WtgndPPr0l9h+yB9g+tbkZZCij
   JHnSbGaLTOlCD0Mvir7gIKJGsCYogFrVImj0hyZfmP5OhIHoUcjwC6mtK
   TBJGxmxKnjG2654o5GxmlHx5mko+MG8TKfoOYavkJ+KD3Ip/xNv+HHHr+
   eMkA/6nxXdTpMvQEHLt26oKDEwfrhmIZYbpdvrQv1AYbT99mLQoQLNlTI
   BOGogkKDhkyoAW8wS6IZIbBYAXFc7ovC/2o73OPXul3WAe7P0xQV9qIgr
   Pm7Q3VflRs5jwVoB7rdf8SjkVmEOZklhbt2Kqss27eWzveedToUUkcZJc
   w==;
X-CSE-ConnectionGUID: qktNX/EVQ6WXaKCbsFKsNg==
X-CSE-MsgGUID: lF8pinTtTN26u1IBhAHTPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25351539"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25351539"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 09:29:10 -0700
X-CSE-ConnectionGUID: rnfIE1ShQfKzaYXHTB9tWQ==
X-CSE-MsgGUID: 6mZWlgEZRXKQnRpThbMQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98962460"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Sep 2024 09:29:05 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp9AM-0006gi-2x;
	Fri, 13 Sep 2024 16:29:02 +0000
Date: Sat, 14 Sep 2024 00:28:04 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com, Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v4 07/10] tmpfs: Add casefold lookup support
Message-ID: <202409140037.lwGxfq6h-lkp@intel.com>
References: <20240911144502.115260-8-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911144502.115260-8-andrealmeid@igalia.com>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on tytso-ext4/dev brauner-vfs/vfs.all linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/libfs-Create-the-helper-function-generic_ci_validate_strict_name/20240911-224740
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240911144502.115260-8-andrealmeid%40igalia.com
patch subject: [PATCH v4 07/10] tmpfs: Add casefold lookup support
config: i386-buildonly-randconfig-005-20240913 (https://download.01.org/0day-ci/archive/20240914/202409140037.lwGxfq6h-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140037.lwGxfq6h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140037.lwGxfq6h-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/shmem.c:4723:18: error: use of undeclared identifier 'fscrypt_d_revalidate'
    4723 |         .d_revalidate = fscrypt_d_revalidate,
         |                         ^
   1 error generated.


vim +/fscrypt_d_revalidate +4723 mm/shmem.c

  4717	
  4718	#if IS_ENABLED(CONFIG_UNICODE)
  4719	static const struct dentry_operations shmem_ci_dentry_ops = {
  4720		.d_hash = generic_ci_d_hash,
  4721		.d_compare = generic_ci_d_compare,
  4722	#ifdef CONFIG_FS_ENCRYPTION
> 4723		.d_revalidate = fscrypt_d_revalidate,
  4724	#endif
  4725		.d_delete = always_delete_dentry,
  4726	};
  4727	#endif
  4728	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

