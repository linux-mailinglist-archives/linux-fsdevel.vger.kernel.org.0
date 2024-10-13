Return-Path: <linux-fsdevel+bounces-31816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19A99B8BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 09:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190FA1F21DCD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD90139D0B;
	Sun, 13 Oct 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnVxtK1V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51D130499;
	Sun, 13 Oct 2024 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728803983; cv=none; b=px9A+P/7H6FcWnacBeHfQoUm5OOTGA8Nk9Qh0uk0RtXTuBd8oJ9skSwhs+yPy/EJUXQFAYq3gssqX7YXjHEUk74dDtwIB44A07JJOZPWeBAmRsXfuKxgr/oj7bIxnIJXt9ofckvy6mFNd3HMQL6e3QalvS2umUinvCqwwwQBlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728803983; c=relaxed/simple;
	bh=JgOnFrW/x2wobU/QOV9Xr3KMhlIeLCAqasnl24lt0kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVXVCYia+3g4hlJhqXAnWiD+qdJe9w7gePtAUznF/Xvskx6EUytz1SzYXVOa1ySAxQRsfo7TmehtgqHrQMjnYYoH9pFrh1YUYwL+jzDZRrQIymxmBBrlp1LMmHFy1Y4sLFj66ch1Hm+x/MOTn7a/iTM2jkPfWmWfwtjtE3t328k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnVxtK1V; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728803981; x=1760339981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JgOnFrW/x2wobU/QOV9Xr3KMhlIeLCAqasnl24lt0kM=;
  b=nnVxtK1VA+pzaYid2mAScV/7Uk0BjUQDi5tNXXAjmSjQNFxnjhasUhJg
   KIF+iAL6YilCspPGr20ka7MVngVBcHG4Qj1yU0DbMXlcR1cCER4HKtBmh
   Davw53E7VbITNwE46/GX48gELlxaiiEKKqAo1Wjz0yH+1QOOBsCtvB9ie
   Kqz+wN6yYYfiCMo9fxdw2ox1f7hLAxE92XEqgSTitV2olmdose+BEsxmF
   iJaIMHiYgpzlTPGmYwQUtcUgKjbVOM4o1xAZ51nDn6OVKhk9oQiWNxSCe
   4kGP0bEt+47pL9mvpRmZbqtkK0BYbUUBgEDzgBSUzzEvMeVI2a5OSy/TX
   g==;
X-CSE-ConnectionGUID: MzSv3EshSTSoTfiMk/s9pw==
X-CSE-MsgGUID: kaXv83KaS9GpxLs1hBxMLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39546706"
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="39546706"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 00:19:40 -0700
X-CSE-ConnectionGUID: +ngZ8aIlQ8C07dlEJb99Jw==
X-CSE-MsgGUID: ICcsmWFfRTWxLTbB1OYGww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="77294182"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 Oct 2024 00:19:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szst6-000EAh-3B;
	Sun, 13 Oct 2024 07:19:36 +0000
Date: Sun, 13 Oct 2024 15:19:00 +0800
From: kernel test robot <lkp@intel.com>
To: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, christian@brauner.io,
	linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v11] pidfd: add ioctl to retrieve pid info
Message-ID: <202410131455.zyQFJN9p-lkp@intel.com>
References: <20241010155401.2268522-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010155401.2268522-1-luca.boccassi@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b]

url:    https://github.com/intel-lab-lkp/linux/commits/luca-boccassi-gmail-com/pidfd-add-ioctl-to-retrieve-pid-info/20241010-235621
base:   8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
patch link:    https://lore.kernel.org/r/20241010155401.2268522-1-luca.boccassi%40gmail.com
patch subject: [PATCH v11] pidfd: add ioctl to retrieve pid info
config: alpha-randconfig-r054-20241013 (https://download.01.org/0day-ci/archive/20241013/202410131455.zyQFJN9p-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410131455.zyQFJN9p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131455.zyQFJN9p-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/pidfs.c: In function 'pidfd_info':
>> fs/pidfs.c:162:34: error: 'pids_cgrp_id' undeclared (first use in this function); did you mean 'misc_cgrp_id'?
     162 |         cgrp = task_cgroup(task, pids_cgrp_id);
         |                                  ^~~~~~~~~~~~
         |                                  misc_cgrp_id
   fs/pidfs.c:162:34: note: each undeclared identifier is reported only once for each function it appears in


vim +162 fs/pidfs.c

   129	
   130		if (!uinfo)
   131			return -EINVAL;
   132		if (usize < sizeof(struct pidfd_info))
   133			return -EINVAL; /* First version, no smaller struct possible */
   134	
   135		if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
   136			return -EFAULT;
   137	
   138		c = get_task_cred(task);
   139		if (!c)
   140			return -ESRCH;
   141	
   142		/* Unconditionally return identifiers and credentials, the rest only on request */
   143	
   144		user_ns = current_user_ns();
   145		kinfo.ruid = from_kuid_munged(user_ns, c->uid);
   146		kinfo.rgid = from_kgid_munged(user_ns, c->gid);
   147		kinfo.euid = from_kuid_munged(user_ns, c->euid);
   148		kinfo.egid = from_kgid_munged(user_ns, c->egid);
   149		kinfo.suid = from_kuid_munged(user_ns, c->suid);
   150		kinfo.sgid = from_kgid_munged(user_ns, c->sgid);
   151		kinfo.fsuid = from_kuid_munged(user_ns, c->fsuid);
   152		kinfo.fsgid = from_kgid_munged(user_ns, c->fsgid);
   153		kinfo.request_mask |= PIDFD_INFO_CREDS;
   154		put_cred(c);
   155	
   156	#ifdef CONFIG_CGROUPS
   157		/*
   158		 * The cgroup id cannot be retrieved anymore after the task has exited
   159		 * (even if it has not been reaped yet), contrary to other fields. Set
   160		 * the flag only if we can still access it. */
   161		rcu_read_lock();
 > 162		cgrp = task_cgroup(task, pids_cgrp_id);
   163		if (cgrp) {
   164			kinfo.cgroupid = cgroup_id(cgrp);
   165			kinfo.request_mask |= PIDFD_INFO_CGROUPID;
   166		}
   167		rcu_read_unlock();
   168	#endif
   169	
   170		/*
   171		 * Copy pid/tgid last, to reduce the chances the information might be
   172		 * stale. Note that it is not possible to ensure it will be valid as the
   173		 * task might return as soon as the copy_to_user finishes, but that's ok
   174		 * and userspace expects that might happen and can act accordingly, so
   175		 * this is just best-effort. What we can do however is checking that all
   176		 * the fields are set correctly, or return ESRCH to avoid providing
   177		 * incomplete information. */
   178	
   179		kinfo.ppid = task_ppid_nr_ns(task, NULL);
   180		kinfo.tgid = task_tgid_vnr(task);
   181		kinfo.pid = task_pid_vnr(task);
   182		kinfo.request_mask |= PIDFD_INFO_PID;
   183	
   184		if (kinfo.pid == 0 || kinfo.tgid == 0 || (kinfo.ppid == 0 && kinfo.pid != 1))
   185			return -ESRCH;
   186	
   187		/*
   188		 * If userspace and the kernel have the same struct size it can just
   189		 * be copied. If userspace provides an older struct, only the bits that
   190		 * userspace knows about will be copied. If userspace provides a new
   191		 * struct, only the bits that the kernel knows about will be copied.
   192		 */
   193		if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
   194			return -EFAULT;
   195	
   196		return 0;
   197	}
   198	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

