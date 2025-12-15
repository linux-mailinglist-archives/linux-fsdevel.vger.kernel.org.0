Return-Path: <linux-fsdevel+bounces-71284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B54CBC75A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 05:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3EDB300698E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B0299A94;
	Mon, 15 Dec 2025 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A39NEfM5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F1215F42
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765772473; cv=none; b=PJF2HCt8aDjrvmYIdWmBaSSKo4RS9lcjTqZbc1kv7d4yXgY/lJSMhF/feBuFGFpFHrAKxYGtn/C+MZ/b9x1vJQ9HuyqsYw6g0vFnZ9en+sUNtz3zOYSiC+euAEQf6OID6bhvBbnYT1qZvmMXOHpSUvQjineGI1OKqxblzjHAQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765772473; c=relaxed/simple;
	bh=Q8Qk1iCCrrcXFGVhw4xA9hBiZlmnKGr9dlArpPLenbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UKAwAs+lZvJ0LmgxAyZqk7YIBqljd0qSwYAB9TroQIA4NEftEgTDKU9eFReZMoGwiO7Qbci1VBxNTbv+5nEkkWQbPwldj3YDhRk2SWZQGQ05/S0MWZB2jID2itYyweuG0H1tM3WXHfgt9q4JTHbvC13241sP7yKExFGhLWm6ayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A39NEfM5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765772472; x=1797308472;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q8Qk1iCCrrcXFGVhw4xA9hBiZlmnKGr9dlArpPLenbE=;
  b=A39NEfM5ETc8clG+kvdJ/bRQrK6X+UZbUsosqx7nfqmfwQ1SXghpHMHz
   +0GOl9qJmRVlPKUTAr3x0GpHu/ab4TNAb2AZXovmaLRRhZtBNMr7j56/+
   1zz6rGB0ZzWNE+s/EG5h9R7B6dJC9uLa0oipErIqn0R75mehpkpT627QV
   0nSiYHFnwg7s1jTSRSVzK/J3SxF+BnSijE3AJCrhU+fG0LBuUJSlXojKL
   weBr/ml11dnNEXJSqlfS+p4bAuSe5dgXbYCrGufqqijTWV0MpOpC7fwAP
   McYdv8YLfOz6dY1deAN/V6Jpvt2UjXqLdmaRjicpWQqxKLk2edCMZe6Ci
   Q==;
X-CSE-ConnectionGUID: XUD7+xJ1T5uzOPx7+fCOFA==
X-CSE-MsgGUID: tzIO4YPrROGTKXQrM0/lHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78785604"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78785604"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 20:21:11 -0800
X-CSE-ConnectionGUID: z2F8jwtaR8eKkyWi3ITIOw==
X-CSE-MsgGUID: 00ioez7SQkqdthTPhoCA+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202122621"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Dec 2025 20:21:10 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vV055-000000009mg-44I7;
	Mon, 15 Dec 2025 04:21:07 +0000
Date: Mon, 15 Dec 2025 12:21:01 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.filename 58/59] arch/alpha/kernel/osf_sys.c:474:15:
 error: conflicting types for 'devname'; have 'char *'
Message-ID: <202512151226.9GRRkjbx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.filename
head:   80f54c1d0854abf4e9a7e32147ef643ebbea427d
commit: 5d0a59eaa522c2fd896cb6ddd6e3c0e3e2fa1b49 [58/59] alpha: switch osf_mount() to strndup_user()
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20251215/202512151226.9GRRkjbx-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251215/202512151226.9GRRkjbx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512151226.9GRRkjbx-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/alpha/kernel/osf_sys.c: In function 'osf_cdfs_mount':
>> arch/alpha/kernel/osf_sys.c:474:15: error: conflicting types for 'devname'; have 'char *'
     474 |         char *devname __free(kfree) = NULL;
         |               ^~~~~~~
   arch/alpha/kernel/osf_sys.c:473:26: note: previous declaration of 'devname' with type 'struct filename *'
     473 |         struct filename *devname;
         |                          ^~~~~~~


vim +474 arch/alpha/kernel/osf_sys.c

   467	
   468	static int
   469	osf_cdfs_mount(const char __user *dirname,
   470		       struct cdfs_args __user *args, int flags)
   471	{
   472		struct cdfs_args tmp;
   473		struct filename *devname;
 > 474		char *devname __free(kfree) = NULL;
   475	
   476		if (copy_from_user(&tmp, args, sizeof(tmp)))
   477			return -EFAULT;
   478		devname = strndup_user(tmp.devname, PATH_MAX);
   479		if (IS_ERR(devname))
   480			return PTR_ERR(devname);
   481		return do_mount(devname, dirname, "iso9660", flags, NULL);
   482	}
   483	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

