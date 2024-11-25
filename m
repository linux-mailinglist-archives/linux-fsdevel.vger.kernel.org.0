Return-Path: <linux-fsdevel+bounces-35772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327E9D83FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 12:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D48D289C95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ADA195B33;
	Mon, 25 Nov 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekP2l7bX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D46193086;
	Mon, 25 Nov 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532508; cv=none; b=eUSKVRObtuKTqKgaxL4Qbds7pNEupfPN1TgO7U5y3MDWZ7hHSvOSKsSiesQm1LpRPrK4uzu6Pot0vJjsjz/ViH+QJl/+1WmU0+ULBB0yF3ItBKS1N3a8d3dIsQVmYpPr8I333BpPijK3HSieSYxwjCoPkU2RBDSPcaLJrF/EBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532508; c=relaxed/simple;
	bh=T/UU+rrT+tPh3M85iNCZvELpys75SfWLzM9o42mtaR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzaae57F+qE618vNQGWkS4S9E6QNqnyJRK5k3aTXEjhww99A1cJdLJgXJ9BUkorQe+sBQqC9Zov2pREkDKqFMyMkFPqJ18C9tobKgbO9uxQsU2L7t07nzAGL4bvY3V4NF4jkJ6i+P7CTRzMdcbGqyEpAm4i8PLSuhxIZIQgIZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekP2l7bX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732532506; x=1764068506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T/UU+rrT+tPh3M85iNCZvELpys75SfWLzM9o42mtaR8=;
  b=ekP2l7bXbpkxFP4gsRSxQU5T5VTPLO/iMgFXuUA3A16mlBMb4+2hH3kf
   PNdUM2TvWdvubKn6VtK4Dn1TfZpQjijEb7WuUwp4h9uFp4RiGeye9saN0
   3O3SyJmKbA9vh0AOiyLD4o8qXoTs1qTIhfj3/VSnn0Fsyn0niq+0npq8o
   cTjqj0Mw1gLo0IfDgdbEC7X0omSfYcZeZaKiJYbKJUaIU+TOdl7IUfhhD
   8gbsSVuhf72vL8nURQYy50fZCekCqbPyjZZJWgdNB2ltPp+K4e/5HT3rN
   aJvkwSc0LjsS/RZt27SQgm8xv8PuaiNB1nf2spWcJTbeWrrnXQ5/+ELdI
   A==;
X-CSE-ConnectionGUID: ELFnvTxUTnCjVWuUJWQHvQ==
X-CSE-MsgGUID: iBwx3q3pRPmTz9l+wkxv1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="43290717"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43290717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 03:01:46 -0800
X-CSE-ConnectionGUID: WRgJmM8ETMW+viEZnd9lEA==
X-CSE-MsgGUID: 4UuiGSoXQg+oFmbkppG6Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="96289499"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2024 03:01:41 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFWqY-0006BI-01;
	Mon, 25 Nov 2024 11:01:38 +0000
Date: Mon, 25 Nov 2024 19:01:14 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@meta.com, andrii@kernel.org,
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
Message-ID: <202411251801.nLqLjFGW-lkp@intel.com>
References: <20241122225958.1775625-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122225958.1775625-2-song@kernel.org>

Hi Song,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jack-fs/fsnotify]
[also build test WARNING on linus/master v6.12 next-20241125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/fanotify-Introduce-fanotify-filter/20241125-110818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
patch link:    https://lore.kernel.org/r/20241122225958.1775625-2-song%40kernel.org
patch subject: [PATCH v3 fanotify 1/2] fanotify: Introduce fanotify filter
config: i386-randconfig-001-20241125 (https://download.01.org/0day-ci/archive/20241125/202411251801.nLqLjFGW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251801.nLqLjFGW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251801.nLqLjFGW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/notify/fanotify/fanotify_filter.c: In function 'fanotify_filter_add':
>> fs/notify/fanotify/fanotify_filter.c:226:55: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     226 |                         if (copy_from_user(init_args, (void __user *)args.init_args,
         |                                                       ^


vim +226 fs/notify/fanotify/fanotify_filter.c

   156	
   157	/*
   158	 * fanotify_filter_add - Add a filter to fsnotify_group.
   159	 *
   160	 * Add a filter from filter_list to a fsnotify_group.
   161	 *
   162	 * @group:	fsnotify_group that will have add
   163	 * @argp:	fanotify_filter_args that specifies the filter
   164	 *		and the init arguments of the filter.
   165	 *
   166	 * Returns:
   167	 *	0	- on success;
   168	 *	-EEXIST	- filter of the same name already exists.
   169	 */
   170	int fanotify_filter_add(struct fsnotify_group *group,
   171				struct fanotify_filter_args __user *argp)
   172	{
   173		struct fanotify_filter_hook *filter_hook;
   174		struct fanotify_filter_ops *filter_ops;
   175		struct fanotify_filter_args args;
   176		void *init_args = NULL;
   177		int ret = 0;
   178	
   179		ret = copy_from_user(&args, argp, sizeof(args));
   180		if (ret)
   181			return -EFAULT;
   182	
   183		if (args.init_args_size > FAN_FILTER_ARGS_MAX)
   184			return -EINVAL;
   185	
   186		args.name[FAN_FILTER_NAME_MAX - 1] = '\0';
   187	
   188		fsnotify_group_lock(group);
   189	
   190		if (rcu_access_pointer(group->fanotify_data.filter_hook)) {
   191			fsnotify_group_unlock(group);
   192			return -EBUSY;
   193		}
   194	
   195		filter_hook = kzalloc(sizeof(*filter_hook), GFP_KERNEL);
   196		if (!filter_hook) {
   197			ret = -ENOMEM;
   198			goto out;
   199		}
   200	
   201		spin_lock(&filter_list_lock);
   202		filter_ops = fanotify_filter_find(args.name);
   203		if (!filter_ops || !try_module_get(filter_ops->owner)) {
   204			spin_unlock(&filter_list_lock);
   205			ret = -ENOENT;
   206			goto err_free_hook;
   207		}
   208		spin_unlock(&filter_list_lock);
   209	
   210		if (!capable(CAP_SYS_ADMIN) && (filter_ops->flags & FAN_FILTER_F_SYS_ADMIN_ONLY)) {
   211			ret = -EPERM;
   212			goto err_module_put;
   213		}
   214	
   215		if (filter_ops->filter_init) {
   216			if (args.init_args_size != filter_ops->init_args_size) {
   217				ret = -EINVAL;
   218				goto err_module_put;
   219			}
   220			if (args.init_args_size) {
   221				init_args = kzalloc(args.init_args_size, GFP_KERNEL);
   222				if (!init_args) {
   223					ret = -ENOMEM;
   224					goto err_module_put;
   225				}
 > 226				if (copy_from_user(init_args, (void __user *)args.init_args,
   227						   args.init_args_size)) {
   228					ret = -EFAULT;
   229					goto err_free_args;
   230				}
   231	
   232			}
   233			ret = filter_ops->filter_init(group, filter_hook, init_args);
   234			if (ret)
   235				goto err_free_args;
   236			kfree(init_args);
   237		}
   238		filter_hook->ops = filter_ops;
   239		rcu_assign_pointer(group->fanotify_data.filter_hook, filter_hook);
   240	
   241	out:
   242		fsnotify_group_unlock(group);
   243		return ret;
   244	
   245	err_free_args:
   246		kfree(init_args);
   247	err_module_put:
   248		module_put(filter_ops->owner);
   249	err_free_hook:
   250		kfree(filter_hook);
   251		goto out;
   252	}
   253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

