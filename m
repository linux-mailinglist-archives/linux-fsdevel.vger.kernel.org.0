Return-Path: <linux-fsdevel+bounces-29354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B749787C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 20:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F046E286D27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B92132121;
	Fri, 13 Sep 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqCOrKOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2A12C465;
	Fri, 13 Sep 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251920; cv=none; b=sU8wvO1reI4Udd1fX9dC8n1nZ+r9fG/F7BCDzmR909KIzTlzwkKs+16p+9j2XY/OZoOqXdfQRQetID5mpSGr+vHGiMsrNIf6aI7xb5AHHtxLlCK0a8ufRGAYAIoJEAfMg0Z8OF+UEsY1bSzT5XrzWpOey6ABIE7D4pNbjmor6fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251920; c=relaxed/simple;
	bh=ZP5Sr3pIISCAUY6csIxUxy+RYfNU+Q4zrM+AyHqj3zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJO4bv4j9oGvFGBziPTcmbEoCA5SD60Q0c1OOirMQBgVcdq8SrddGjdS7F8BMMJq0DwCiUiTcAyinLcaVQpOV/xtqBu4T3cizYgCnTlQ3CjFQoPLDd5d97Gs+WHmDTItUQh4lymadlzKT+c5517j0es0E0dwh8CzrfzinLAlrmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqCOrKOt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726251918; x=1757787918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZP5Sr3pIISCAUY6csIxUxy+RYfNU+Q4zrM+AyHqj3zk=;
  b=CqCOrKOtuc4KXD7IoEfkQIiV4kwh9Bs9pLQDnkGRCRfiOV5+Z5VPk67M
   U/FeFoSCjEpdfFG6D7Q8VSm0fPOurHb2EHyodWOLhkMCmMX8aadlswH7V
   ov2uPuYwLVlG/kS1pAhlh4IvQXloYLFqdcRzo45N+KtcwYwfz98NHkupZ
   rKp/C4fj2UJ4WK913wU8MmxwMMJYzmJScYmebU1kkGSuRVHQTpXr66QWk
   Pc9jhejzT49vNGN8dEkBwKLxH6Dy6lKE7BvGzx/z65P54SbppZcbgc8uq
   4q5IQl+ysTerh8X+3Lulg7K4VZNWnkYdsKOpn+slHnPGXtTsdgwxTWSQH
   g==;
X-CSE-ConnectionGUID: namvzSXhQYiJjnASJizmlA==
X-CSE-MsgGUID: ID1oSx0rR4S0hVbTuFvHOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25317602"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25317602"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 11:25:17 -0700
X-CSE-ConnectionGUID: qKVgOJ7vRz+xuOlNQcQR/g==
X-CSE-MsgGUID: O8ITvqYkRYS8xm4R/TpOuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72262328"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Sep 2024 11:25:13 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spAyl-0006p4-2y;
	Fri, 13 Sep 2024 18:25:11 +0000
Date: Sat, 14 Sep 2024 02:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com, Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v4 07/10] tmpfs: Add casefold lookup support
Message-ID: <202409140236.RR9Gbvqh-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tytso-ext4/dev brauner-vfs/vfs.all linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/libfs-Create-the-helper-function-generic_ci_validate_strict_name/20240911-224740
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240911144502.115260-8-andrealmeid%40igalia.com
patch subject: [PATCH v4 07/10] tmpfs: Add casefold lookup support
config: csky-randconfig-002-20240913 (https://download.01.org/0day-ci/archive/20240914/202409140236.RR9Gbvqh-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140236.RR9Gbvqh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140236.RR9Gbvqh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/shmem.c:4719:39: warning: 'shmem_ci_dentry_ops' defined but not used [-Wunused-const-variable=]
    4719 | static const struct dentry_operations shmem_ci_dentry_ops = {
         |                                       ^~~~~~~~~~~~~~~~~~~


vim +/shmem_ci_dentry_ops +4719 mm/shmem.c

  4717	
  4718	#if IS_ENABLED(CONFIG_UNICODE)
> 4719	static const struct dentry_operations shmem_ci_dentry_ops = {
  4720		.d_hash = generic_ci_d_hash,
  4721		.d_compare = generic_ci_d_compare,
  4722	#ifdef CONFIG_FS_ENCRYPTION
  4723		.d_revalidate = fscrypt_d_revalidate,
  4724	#endif
  4725		.d_delete = always_delete_dentry,
  4726	};
  4727	#endif
  4728	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

