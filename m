Return-Path: <linux-fsdevel+bounces-34715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793789C7FFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 02:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EE11F2277C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 01:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939121E412A;
	Thu, 14 Nov 2024 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gy9Rn2zx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E11E3DC4;
	Thu, 14 Nov 2024 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547797; cv=none; b=oyq5P7LHF9YdRnhxqIYC0yXq7/49toWj+dMDbsUzX/g+UmYzr9YL2OVT89s8k2oyO/HciTGcxbTcICizwM23u3+N27I325PknqsbrB2LqOwPd5GuX0e9Os3kUU0YsTuxXJVSnUcJoHAuUxnYm18+jRl4OR3fRNYGKk4KVf15eoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547797; c=relaxed/simple;
	bh=U4LWyp7oJNaY5Yh9s6TiGRN+bfgXwxV0//mlV5BDLk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/z0R/pWgxdUMdVpFLp8/OlBsA2Ok1uq5aH7tGvw02vVV3dFSqENtFbs4TMunCLc2jfqLFU4mmiHXJ9b1xyLxXIkkuVZsKtq9rwUZ9E9HT5ImqwtwYEgdcx2KcmUbtx2NzkeHXFRqAXiufDDn4fLWFOoM2jRW6+PCIrfUtI0/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gy9Rn2zx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731547795; x=1763083795;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U4LWyp7oJNaY5Yh9s6TiGRN+bfgXwxV0//mlV5BDLk0=;
  b=gy9Rn2zxfwqF7IQ5pff/Tw2JCKw/+4TbIicoT67WNCFBsO7cAwgKn+tT
   gk9RY6Rd3WhycJINfZx8CKOIJqh2SbjW5wQJTrzPV2YPQy0I/05q8jh26
   D8MSULi5HtGjOVjcFXkXgTdZyroVmlqMv6N86zudZYydSzEFOb2yQlrfX
   +E9lF5S2i9DwjTaEAEgMU4pYxebe/gnV3mNM6dx5leL0iEN1o69qybCU7
   YGimFX+LgTQTs8Q968Wy9zYEvtFPIMiQjvO6M/tVxr20bLLHJ4Vtdzo+f
   +IcC5JcjwPnZ2rvU0A6Sa6r5CNNV7gHj63I7HUVpoys+B71zEF3zHr7qd
   Q==;
X-CSE-ConnectionGUID: PqBWzrNORJuXPf5T/VVGCw==
X-CSE-MsgGUID: iRo0cKFpQCGijGK2vqQqUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31239759"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31239759"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 17:29:54 -0800
X-CSE-ConnectionGUID: PKFP/Z5wQT2aRHhsDUM/Wg==
X-CSE-MsgGUID: LxTBu1dyTA22jRE/02sWgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88468709"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 Nov 2024 17:29:52 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBOg9-00012N-2k;
	Thu, 14 Nov 2024 01:29:49 +0000
Date: Thu, 14 Nov 2024 09:29:42 +0800
From: kernel test robot <lkp@intel.com>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-nfs@vger.kernel.org,
	Erin Shepherd <erin.shepherd@e43.eu>
Subject: Re: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH
 check
Message-ID: <202411140905.a0ntnQQG-lkp@intel.com>
References: <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-pidfs_fh-v2-2-9a4d28155a37@e43.eu>

Hi Erin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 14b6320953a3f856a3f93bf9a0e423395baa593d]

url:    https://github.com/intel-lab-lkp/linux/commits/Erin-Shepherd/pseudofs-add-support-for-export_ops/20241114-020539
base:   14b6320953a3f856a3f93bf9a0e423395baa593d
patch link:    https://lore.kernel.org/r/20241113-pidfs_fh-v2-2-9a4d28155a37%40e43.eu
patch subject: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH check
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20241114/202411140905.a0ntnQQG-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140905.a0ntnQQG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140905.a0ntnQQG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/fhandle.c: In function 'may_decode_fh':
>> fs/fhandle.c:242:41: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     242 |         struct export_operations *nop = root->mnt->mnt_sb->s_export_op;
         |                                         ^~~~


vim +/const +242 fs/fhandle.c

   237	
   238	static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
   239					 unsigned int o_flags)
   240	{
   241		struct path *root = &ctx->root;
 > 242		struct export_operations *nop = root->mnt->mnt_sb->s_export_op;
   243	
   244		if (nop && nop->flags & EXPORT_OP_UNRESTRICTED_OPEN)
   245			return true;
   246	
   247		if (capable(CAP_DAC_READ_SEARCH))
   248			return true;
   249	
   250		/*
   251		 * Allow relaxed permissions of file handles if the caller has the
   252		 * ability to mount the filesystem or create a bind-mount of the
   253		 * provided @mountdirfd.
   254		 *
   255		 * In both cases the caller may be able to get an unobstructed way to
   256		 * the encoded file handle. If the caller is only able to create a
   257		 * bind-mount we need to verify that there are no locked mounts on top
   258		 * of it that could prevent us from getting to the encoded file.
   259		 *
   260		 * In principle, locked mounts can prevent the caller from mounting the
   261		 * filesystem but that only applies to procfs and sysfs neither of which
   262		 * support decoding file handles.
   263		 *
   264		 * Restrict to O_DIRECTORY to provide a deterministic API that avoids a
   265		 * confusing api in the face of disconnected non-dir dentries.
   266		 *
   267		 * There's only one dentry for each directory inode (VFS rule)...
   268		 */
   269		if (!(o_flags & O_DIRECTORY))
   270			return false;
   271	
   272		if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
   273			ctx->flags = HANDLE_CHECK_PERMS;
   274		else if (is_mounted(root->mnt) &&
   275			 ns_capable(real_mount(root->mnt)->mnt_ns->user_ns,
   276				    CAP_SYS_ADMIN) &&
   277			 !has_locked_children(real_mount(root->mnt), root->dentry))
   278			ctx->flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
   279		else
   280			return false;
   281	
   282		/* Are we able to override DAC permissions? */
   283		if (!ns_capable(current_user_ns(), CAP_DAC_READ_SEARCH))
   284			return false;
   285	
   286		ctx->fh_flags = EXPORT_FH_DIR_ONLY;
   287		return true;
   288	}
   289	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

