Return-Path: <linux-fsdevel+bounces-34004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67F9C19BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1D288395
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB71E25E1;
	Fri,  8 Nov 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuXYXlpc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C91DACA1;
	Fri,  8 Nov 2024 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060127; cv=none; b=ignJ7JEfG0ZvshmTFUY+ezZezQWV9sZWVBCNsrDP/YzhhFsC8qU7/Jskx4pnCvuRfD2NXeRvOxe5afpKrRvZavAm4K54ajPRNu1O/OxyiGYMWXjtfszLLjis9BZamAlHtp1TVq7tQeDYkrltrauJf9HYdZ/D7X33CqO3tnNgWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060127; c=relaxed/simple;
	bh=gHWJICSiRxTdrMlSAEib7G0w9VRQZBlYMnDIyscdeNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqM3sPRGc8xVAPgKKVbUu9MphgiTkAJyaGBb/zKQzEG9rA1ncmiWp4ZiKPeN38NehOyN6vkUGzC4bifbX8KpOwuwJIscluZWerp5mJBOgfBVGmxmyO69yLSfWn1jb3zmgHs/vMoeD3PIy/Xk1xm3KE84ZYB5FDv0UYjG6+iZhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuXYXlpc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731060126; x=1762596126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gHWJICSiRxTdrMlSAEib7G0w9VRQZBlYMnDIyscdeNE=;
  b=iuXYXlpcWaV/eSVf9Pa7OhQNpVTSsECBfSKwvfo7xQx0BjzinHWrwCrB
   N8uiG2+C/UtqZVCdgdATphAPsrk36tYBED6gQPocX5b3YGh7tcG2B+7Qh
   acugmOW/AgJ/3VNQS3cYWv7bt7LVf+/IgSqVHfd00BcXwE197NwmeDC7n
   ZeK8pSAe/a9pJDwVgwGgNDObDDzTIoDHf3NVz3LdScFjk97H/J84fowU8
   oYFUyAg/2FWMDR61c1BN9fhx5smBhsiKvzQvhFIz5K3kW7vJA1VtgxQcc
   whK9vtZVFI3E9vN5r5R8Im3UEo+Bu7HNrxFKQQ6xo68QV7v18oilS0iY6
   Q==;
X-CSE-ConnectionGUID: p/afS65uSu6hppmTQyuX9w==
X-CSE-MsgGUID: dRplWjfnTq6/EAJDhbrWcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34722224"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="34722224"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 02:02:03 -0800
X-CSE-ConnectionGUID: iqPiGiDuQUeJehsmqANIsQ==
X-CSE-MsgGUID: LcKUpnWLRiKiJhTMelJ9yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85876820"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Nov 2024 02:01:59 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9LoS-000rI3-18;
	Fri, 08 Nov 2024 10:01:56 +0000
Date: Fri, 8 Nov 2024 18:01:30 +0800
From: kernel test robot <lkp@intel.com>
To: Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Stas Sergeev <stsp2@yandex.ru>,
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
Message-ID: <202411081700.kAQXSC2u-lkp@intel.com>
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
[also build test ERROR on linus/master v6.12-rc6 next-20241108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stas-Sergeev/procfs-avoid-some-usages-of-seq_file-private-data/20241108-060856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241107215821.1514623-3-stsp2%40yandex.ru
patch subject: [PATCH 2/2] procfs: implement PROCFS_SET_GROUPS ioctl
config: x86_64-buildonly-randconfig-004-20241108 (https://download.01.org/0day-ci/archive/20241108/202411081700.kAQXSC2u-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081700.kAQXSC2u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411081700.kAQXSC2u-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/proc/base.c:66:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/proc/base.c:891:8: error: call to undeclared function 'set_current_groups'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     891 |         err = set_current_groups(gi);
         |               ^
   1 warning and 1 error generated.


vim +/set_current_groups +891 fs/proc/base.c

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

