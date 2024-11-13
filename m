Return-Path: <linux-fsdevel+bounces-34706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7543A9C7E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 23:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B61284C4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76B2AE84;
	Wed, 13 Nov 2024 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5mRqkTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24616189F50;
	Wed, 13 Nov 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538251; cv=none; b=cqWzhw3Hmb7UmuZJ+3wKVn5ArrPSvc2J1hU0UyOvwjMcDjZ1idroMdAfIV05K9Zd13+R+3cfjwEkzy7goTQSgPjRruxquDNSZ1+6PrVjR7oK6mCQSj78lwKbbhEiOEyZ0lSBBtmT12T5SEq6cThQcKkZYHQMhyxSZdQ71vCWuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538251; c=relaxed/simple;
	bh=CYdGGDWei4FClN5/v5jTSMS1CfPN4qDt7+CJVB8J8vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+PIFwzmW8+RHXH+FkFsOmXK7veZSP5nF8RxdIVoMPL1D1Cr+DEPD85oTfOT+uwP/XZOC3t+kj1HgRGsg3Nwf9WaTS4F1DDLn5k3fGBeTECmA0y9hzTplStN+hG0iZT46AAZESatMoUeQqn3Id1JVjcZoPrCR2r6gvr2oYSb2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5mRqkTn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731538249; x=1763074249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYdGGDWei4FClN5/v5jTSMS1CfPN4qDt7+CJVB8J8vQ=;
  b=j5mRqkTnuluF+5brLKAoV5ggTMeVTNM+B0rl3k1FEsMuJcRIIQF/bLdG
   mW84cysYJTRuKk24Vfu7LvTGui+FvHg5nfMrwCh1wik0r6xVrEPIwXuGD
   JpJUHjMR29pVyQ4heTNGbSgtC3cBhTHVj3LHBVCl/CpKJ1/JCygnBpLL+
   YubWAUApR9erWo5bnRDyuuGY9V+EWEsJbykXQeKlPT9AVIGzuDG6TJ502
   kwUDkHeZdeCe1qeEir8H8BDHX4s9uKpzPi7cbuHBEtg+NBE03dxf9unEZ
   y2H4iYudGK4icUL2D+i59XiCDk8ztBzcrkcEXH6UnG0/CyGzpXZSBr74u
   Q==;
X-CSE-ConnectionGUID: E8LpMdDNSO6haXz1jS5nSg==
X-CSE-MsgGUID: puxRHosTSFqsXUod6Hwi1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="30862603"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="30862603"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 14:50:48 -0800
X-CSE-ConnectionGUID: GFIBXakPTKK+vdZihgFWfw==
X-CSE-MsgGUID: fQSc/1U1QhCMkC7OS8ilzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88806293"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 13 Nov 2024 14:50:45 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBMCB-0000nz-0T;
	Wed, 13 Nov 2024 22:50:43 +0000
Date: Thu, 14 Nov 2024 06:50:27 +0800
From: kernel test robot <lkp@intel.com>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-nfs@vger.kernel.org,
	Erin Shepherd <erin.shepherd@e43.eu>
Subject: Re: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH
 check
Message-ID: <202411140603.E03vXsdz-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 14b6320953a3f856a3f93bf9a0e423395baa593d]

url:    https://github.com/intel-lab-lkp/linux/commits/Erin-Shepherd/pseudofs-add-support-for-export_ops/20241114-020539
base:   14b6320953a3f856a3f93bf9a0e423395baa593d
patch link:    https://lore.kernel.org/r/20241113-pidfs_fh-v2-2-9a4d28155a37%40e43.eu
patch subject: [PATCH v2 2/3] exportfs: allow fs to disable CAP_DAC_READ_SEARCH check
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241114/202411140603.E03vXsdz-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140603.E03vXsdz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140603.E03vXsdz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/fhandle.c:2:
   In file included from include/linux/syscalls.h:93:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:6:
   In file included from include/linux/ring_buffer.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/fhandle.c:242:28: error: initializing 'struct export_operations *' with an expression of type 'const struct export_operations *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     242 |         struct export_operations *nop = root->mnt->mnt_sb->s_export_op;
         |                                   ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +242 fs/fhandle.c

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

