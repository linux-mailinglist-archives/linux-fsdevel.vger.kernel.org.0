Return-Path: <linux-fsdevel+bounces-25768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F299F9503FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 13:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5E6282150
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 11:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9661991C6;
	Tue, 13 Aug 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn7MwSWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D52D611;
	Tue, 13 Aug 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549526; cv=none; b=tyuGJ2kfBn8fivVXVS9YFCOnq/KrRK9y2/lnzyTptAtncNyJRLwFChGS539UqKJOa/zVC+8Jda2RyWXjhKVPl9EEP/tfWJZHtZ1CDAkCh/pYsh++RkPzs2CyIW1wY16pviBCEHn99mAdkXezFVhoPi0WIynwHHFa+vAuQbK6tNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549526; c=relaxed/simple;
	bh=4S7bFWnGTGe5F/hKeyLOIxVvEHDSz1EjGPCsdLTcSe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzGkb548IDesyc+8INfqTmFjEvswRS/t8bLK8i8Ec631z/bocRSEmp1BgQZWoM/ptLQSiM5bt0JBS3+HXjL/80Is2rPyTEi4qxm+tYmE133U/Mx8HoMYIrE2S5fZ8GxpAFb8QkHVrsFCat+TD6tEs+kpMngp848NhzltEZwVP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn7MwSWR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723549525; x=1755085525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4S7bFWnGTGe5F/hKeyLOIxVvEHDSz1EjGPCsdLTcSe4=;
  b=Sn7MwSWRGgUxMrgrIYZ79Mb7IvLaGolV72Pgg2dFDa7uFhYo8QSVrFy2
   X3yIVmxHQGob8ZWOZlg/J0EG8wXJgeGWX/jRPMAeMarKEzniKYrivxVSM
   vgTwQTs8DoyEf3CK06USz8QTMhEoRFIVGeR0EdTNF2IyYDKcZN6qV5KFL
   rZuTd/0eXetaANXsMvGgLoyNtq9gw1nG6AM3lCHxYgAt0jByXZaaPtmxY
   5Sl8ThDmaki+pdp5nzHWRaumLBwShnr7pe6bKZyYp+xpTLgi2a4hf85wg
   JWTZHyVmI4LXgyFuFAqBUnk5+VrzpbHhEVdVzPd7T8ihxZ3GXEAsIiZ+R
   A==;
X-CSE-ConnectionGUID: wS6y8s7bTkKKSRIUdmPQEg==
X-CSE-MsgGUID: RkVhylHqS9WbeX0hneKdrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="47109653"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="47109653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:45:24 -0700
X-CSE-ConnectionGUID: CIwk+6DETtaD7q/E3IQgAg==
X-CSE-MsgGUID: MvFldAgNSQeC0+Wgcchl1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="89440581"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Aug 2024 04:45:19 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdpxl-0000Nq-2h;
	Tue, 13 Aug 2024 11:45:17 +0000
Date: Tue, 13 Aug 2024 19:44:55 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: oe-kbuild-all@lists.linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
	Casey Schaufler <casey@schaufler-ca.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] fs,security: Fix file_set_fowner LSM hook inconsistencies
Message-ID: <202408131900.xhbYFHR4-lkp@intel.com>
References: <20240812144936.1616628-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812144936.1616628-1-mic@digikod.net>

Hi Mickaël,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pcmoore-selinux/next]
[also build test WARNING on linus/master v6.11-rc3]
[cannot apply to brauner-vfs/vfs.all next-20240813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micka-l-Sala-n/fs-security-Fix-file_set_fowner-LSM-hook-inconsistencies/20240813-004648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20240812144936.1616628-1-mic%40digikod.net
patch subject: [PATCH] fs,security: Fix file_set_fowner LSM hook inconsistencies
config: x86_64-randconfig-122-20240813 (https://download.01.org/0day-ci/archive/20240813/202408131900.xhbYFHR4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408131900.xhbYFHR4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408131900.xhbYFHR4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/file_table.c:153:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *cred @@     got struct cred const * @@
   fs/file_table.c:153:25: sparse:     expected struct cred const [noderef] __rcu *cred
   fs/file_table.c:153:25: sparse:     got struct cred const *
>> fs/file_table.c:157:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] __rcu *cred @@
   fs/file_table.c:157:36: sparse:     expected struct cred const *cred
   fs/file_table.c:157:36: sparse:     got struct cred const [noderef] __rcu *cred
   fs/file_table.c:69:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] __rcu *cred @@
   fs/file_table.c:69:28: sparse:     expected struct cred const *cred
   fs/file_table.c:69:28: sparse:     got struct cred const [noderef] __rcu *cred
   fs/file_table.c:69:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] __rcu *cred @@
   fs/file_table.c:69:28: sparse:     expected struct cred const *cred
   fs/file_table.c:69:28: sparse:     got struct cred const [noderef] __rcu *cred

vim +153 fs/file_table.c

   147	
   148	static int init_file(struct file *f, int flags, const struct cred *cred)
   149	{
   150		int error;
   151	
   152		f->f_cred = get_cred(cred);
 > 153		f->f_owner.cred = get_cred(cred);
   154		error = security_file_alloc(f);
   155		if (unlikely(error)) {
   156			put_cred(f->f_cred);
 > 157			put_cred(f->f_owner.cred);
   158			return error;
   159		}
   160	
   161		rwlock_init(&f->f_owner.lock);
   162		spin_lock_init(&f->f_lock);
   163		mutex_init(&f->f_pos_lock);
   164		f->f_flags = flags;
   165		f->f_mode = OPEN_FMODE(flags);
   166		/* f->f_version: 0 */
   167	
   168		/*
   169		 * We're SLAB_TYPESAFE_BY_RCU so initialize f_count last. While
   170		 * fget-rcu pattern users need to be able to handle spurious
   171		 * refcount bumps we should reinitialize the reused file first.
   172		 */
   173		atomic_long_set(&f->f_count, 1);
   174		return 0;
   175	}
   176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

