Return-Path: <linux-fsdevel+bounces-34003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3B9C19BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 11:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B8E2880E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 10:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC41E131A;
	Fri,  8 Nov 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayTXJQQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8513A27D;
	Fri,  8 Nov 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060126; cv=none; b=keUup+a5t5ESJ5+e/giFWty5rCLvs/wPQGmxggJA6eqj2YXH68z0EFNifoRTmqo07uj9/SB5Lh1TlwCA8tDdyXRqgY6Zwrrcb4gEy8Rpx8sBi/XWYBBCqyx4aRZdYSTcF+diy9tVTSdGvay3eSWIVk48i4uPuagcK/UA4iq73sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060126; c=relaxed/simple;
	bh=vNPTOO3/Q878nn/1s8YQUcfCEdeZMqU82Y10Eyz5/Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCpkKTE2GB+qpEm9bJ0M68Ln+jFQrlQF85gcwMWr14Qaj1kfEIg81xpYk70znC+rna+z87+Fc18FU7shR3SzwMKzvwOvZL5r0xvXNfPV2cxZPlIND3ddh+nGzfbHzIwJAhn6jrHYbjOQ7zQnfx9c5+i/Z0zwt1oFG5AIF5AaTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayTXJQQi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731060124; x=1762596124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vNPTOO3/Q878nn/1s8YQUcfCEdeZMqU82Y10Eyz5/Cw=;
  b=ayTXJQQiIsIKI/ytcl0to2r5LJpqZyI2/9p8ymUft8bBJ2wxqdGz+//g
   2XdAlj2Fn1n9iwBfOHF4i71PphFxCxvJVSmOdUk8AwZPKzajHOajGV3vB
   +zONvhWkvCboFM9Y+3uo8c4CP9SgIeIoQzt91VvENlOBjWGbwe9umf8hM
   l5cSDjc37wPhpxVVwxqORaAcTBTDGNCuaQ87B/E8tkq77/nPsa0zq/5k+
   DQUqBFEUXI7S8OaIVeLOvqns5e55EWYs1g2Sc1GduTqLmGWhAf9v+Khc6
   OBDZ0mDQeFF5JII8ulrYdCGB/P4oedvJfsVjwMt9mcQa9Ohx4f6N1KwDJ
   A==;
X-CSE-ConnectionGUID: yN1d52jAR0iUibMOST19bA==
X-CSE-MsgGUID: hcAzluHSQ7W1RsntsGZ32A==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34722203"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="34722203"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 02:02:03 -0800
X-CSE-ConnectionGUID: j7dM2lqaSKmcfpBXCRNMMA==
X-CSE-MsgGUID: N4REgU5dS/W2IKojCKP0Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85876821"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Nov 2024 02:01:59 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9LoS-000rI0-14;
	Fri, 08 Nov 2024 10:01:56 +0000
Date: Fri, 8 Nov 2024 18:01:31 +0800
From: kernel test robot <lkp@intel.com>
To: Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Stas Sergeev <stsp2@yandex.ru>,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] procfs: implement PROCFS_SET_GROUPS ioctl
Message-ID: <202411081749.pXnGtt8H-lkp@intel.com>
References: <20241107215821.1514623-3-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107215821.1514623-3-stsp2@yandex.ru>

Hi Stas,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.12-rc6 next-20241107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stas-Sergeev/procfs-avoid-some-usages-of-seq_file-private-data/20241108-060856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241107215821.1514623-3-stsp2%40yandex.ru
patch subject: [PATCH 2/2] procfs: implement PROCFS_SET_GROUPS ioctl
config: arc-randconfig-001-20241108 (https://download.01.org/0day-ci/archive/20241108/202411081749.pXnGtt8H-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081749.pXnGtt8H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411081749.pXnGtt8H-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/proc/base.c: In function 'do_proc_setgroups':
>> fs/proc/base.c:891:15: error: implicit declaration of function 'set_current_groups'; did you mean 'get_current_groups'? [-Werror=implicit-function-declaration]
     891 |         err = set_current_groups(gi);
         |               ^~~~~~~~~~~~~~~~~~
         |               get_current_groups
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +891 fs/proc/base.c

   870	
   871	static int do_proc_setgroups(const struct cred *task_cred,
   872				     const struct cred *cur_cred,
   873				     const struct cred *f_cred)
   874	{
   875		struct group_info *cgi = get_group_info(cur_cred->group_info);
   876		struct group_info *gi = get_group_info(task_cred->group_info);
   877		int err;
   878	
   879		/* Make sure groups didn't change since file open. */
   880		err = -EPERM;
   881		if (f_cred->group_info != gi)
   882			goto out_gi;
   883		/* Don't error if the process is setting the same list again. */
   884		err = 0;
   885		if (cgi == gi)
   886			goto out_gi;
   887	
   888		err = -EPERM;
   889		if (!can_borrow_groups(cur_cred, f_cred))
   890			goto out_gi;
 > 891		err = set_current_groups(gi);
   892	
   893	out_gi:
   894		put_group_info(gi);
   895		put_group_info(cgi);
   896		return err;
   897	}
   898	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

