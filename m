Return-Path: <linux-fsdevel+bounces-65274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FADEBFFA80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 09:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D349456878D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 07:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F862DAFC0;
	Thu, 23 Oct 2025 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJM0RKsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490C2D9487;
	Thu, 23 Oct 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204617; cv=none; b=MWfh3Q2jJsp3bwlMrtUatOak1cA5cgdk9dknA4nYiZLTzaAczXmUt8rDd4qyItdeHzADOj8z68aMPP5NfG11TwDnSWtD4kdjPnGSXwBWv/kgtJvTzOcVHlz9ReUVVGuCmpMJGyVDeFhaphgN6eemHnyI4y+kRZN9Rrq2S+7c/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204617; c=relaxed/simple;
	bh=jf3nAbYYx1dqiRdZtJZ73fVZgh9zX6dPwz1k7DoEuP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKsTMbAxTr24b1EU14+i7B8lK2YLedKg7JzN3tGFvyeNMMvc5XrkSO2ju9fV9qwGFPD8eZeB9K2MU4qK0/V/qn6chzx70FXAHALcKzJ33CWo9UzfA/E9avFlW5DaaRVNcTT6Istk4m2wOpqTEUj1GKyblgsjxAfZpReouZ18zBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJM0RKsm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761204616; x=1792740616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jf3nAbYYx1dqiRdZtJZ73fVZgh9zX6dPwz1k7DoEuP0=;
  b=kJM0RKsmVvFkq/BBmlLtbdW72PDPnJENoJ8IDT04RzKJdJv5z81PvA85
   56eZW+jdIUFWZPaOCZpczRrIPz0C5/Xy0cjnKy+P3S/8jyMn5mcwLTcC+
   cyXpxsPVYEPAdLm1RmxO8MoO9V03Ld2uZ0XqOKIXCBi+4QAWgKIjuC8OU
   JT/YAOYngQOXiRrJ38yDjmHLjCR9JdSzZMGlG93gExkwkM1PiCA5Qlty1
   bnD9iub609+qXkbK/rLos0oSP/CBE1fM3dCJJ7AkVUpSohAeno8O6pcvP
   Cq6FAOAq6O04B9iWAlfe4sQ8PiL8YaSroqDJpXJA2BeDygAGigqDiJUnV
   w==;
X-CSE-ConnectionGUID: BRuBCrYmQwaHspV14MZGuw==
X-CSE-MsgGUID: PWK7tpbWTQu0xIf9FZBRvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63259444"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="63259444"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 00:30:15 -0700
X-CSE-ConnectionGUID: ky6hJtNrSoCbM5jHmaC+9g==
X-CSE-MsgGUID: R+0e4RhuQSujbjtIKQMTZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184148743"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 23 Oct 2025 00:30:09 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBplv-000D9i-1h;
	Thu, 23 Oct 2025 07:30:07 +0000
Date: Thu, 23 Oct 2025 15:29:08 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 10/63] ns: add active reference count
Message-ID: <202510231548.kt6wvifE-lkp@intel.com>
References: <20251022-work-namespace-nstree-listns-v2-10-71a588572371@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-10-71a588572371@kernel.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3a8660878839faadb4f1a6dd72c3179c1df56787]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/libfs-allow-to-specify-s_d_flags/20251023-004014
base:   3a8660878839faadb4f1a6dd72c3179c1df56787
patch link:    https://lore.kernel.org/r/20251022-work-namespace-nstree-listns-v2-10-71a588572371%40kernel.org
patch subject: [PATCH v2 10/63] ns: add active reference count
config: i386-buildonly-randconfig-001-20251023 (https://download.01.org/0day-ci/archive/20251023/202510231548.kt6wvifE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251023/202510231548.kt6wvifE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510231548.kt6wvifE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cred.c:313:21: warning: variable 'new' is uninitialized when used here [-Wuninitialized]
     313 |                 ns_ref_active_get(new->user_ns);
         |                                   ^~~
   include/linux/ns_common.h:258:11: note: expanded from macro 'ns_ref_active_get'
     258 |         do { if (__ns) __ns_ref_active_get(to_ns_common(__ns)); } while (0)
         |                  ^~~~
   kernel/cred.c:292:18: note: initialize the variable 'new' to silence this warning
     292 |         struct cred *new;
         |                         ^
         |                          = NULL
   1 warning generated.


vim +/new +313 kernel/cred.c

   298	
   299		if (
   300	#ifdef CONFIG_KEYS
   301			!p->cred->thread_keyring &&
   302	#endif
   303			clone_flags & CLONE_THREAD
   304		    ) {
   305			p->real_cred = get_cred_many(p->cred, 2);
   306			kdebug("share_creds(%p{%ld})",
   307			       p->cred, atomic_long_read(&p->cred->usage));
   308			inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
   309			/*
   310			 * Each task gets its own active reference, even if
   311			 * CLONE_THREAD shares the cred structure.
   312			 */
 > 313			ns_ref_active_get(new->user_ns);
   314			return 0;
   315		}
   316	
   317		new = prepare_creds();
   318		if (!new)
   319			return -ENOMEM;
   320	
   321		if (clone_flags & CLONE_NEWUSER) {
   322			ret = create_user_ns(new);
   323			if (ret < 0)
   324				goto error_put;
   325			ret = set_cred_ucounts(new);
   326			if (ret < 0)
   327				goto error_put;
   328		}
   329	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

