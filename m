Return-Path: <linux-fsdevel+bounces-49598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C2FABFDA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 22:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10C17B5BF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 20:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA428FA98;
	Wed, 21 May 2025 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWWZj7R6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6E280CE3;
	Wed, 21 May 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857798; cv=none; b=IMq/y4Efsv19laDtXVkm9nZspY/ykn1qQMnDF7DjUbdBEeLeBp6wDO0bwFQg1RXNuYCoLSc+cunxpa7oyigSKu6SkMSYGbPcSK62fugfnqwsPnIYZJag7UJAk1m9JyEOcy/R/7fqtiCQmlxOo5xJ1U/j9B5vM1lx5bG9LSn3hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857798; c=relaxed/simple;
	bh=c/lBvX1t0gd9nnoWFybO/osjBDzkiXG4M59v4FZ8sf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy7VHtaVmEb1HBryVWpldctvQMgNLsbm3Av2CbAhGnyhCxeKITNQ/u1chCc9SaWVqfiW0YhUfUZII3viSKf2HCyz4m7pwGiolbmVxJhTMWcBHU5+yrmXdOVpCcNO8LJVy/pPamn2VxjRLSGef+8xBDbOL3Kin/7/V2+biZfORXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWWZj7R6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747857796; x=1779393796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/lBvX1t0gd9nnoWFybO/osjBDzkiXG4M59v4FZ8sf8=;
  b=mWWZj7R6p1Vh7kllJhmVHa7xhtd4hebgxuCp5MhJ+xH9Dy30pYMxGX7p
   E2EHHu0qjhEtadQdeFU/ghSqY/coYE54TUg7bTavXkq65p+Nn1O++gPdG
   bmWTlE//JGNW3TUekdnZH9/O1K+LSiqxQkbFb2v2wEhPuqYg1iGXIZSLN
   2KzbCTiL8ZcEbxk1tNXLcmf7UgRap9IaoJIChubiQG2rFCMnU1KAkabuO
   ESfe1J5vxQU8kKUkoUcKi1Vj3ci6wkwFZvH/fwiq/XbOWyj9CbIO/vdsr
   pZt7B7+bOrTWfd3WXU0LplXEMoIZnanNuW0pExrE7XpjN5PmJCUa4/zrI
   Q==;
X-CSE-ConnectionGUID: 7JYa0CTQQZmFJ2Xheg2tJQ==
X-CSE-MsgGUID: Fa0PApTkSGCrreJYA9DnQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49559854"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49559854"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:03:15 -0700
X-CSE-ConnectionGUID: 3Bdhf4yrTLmOUTqYJ8mFWA==
X-CSE-MsgGUID: LOiko2IMQqO7hPfwYYrSYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140132394"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 May 2025 13:03:09 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHped-000OZc-0Q;
	Wed, 21 May 2025 20:03:07 +0000
Date: Thu, 22 May 2025 04:02:41 +0800
From: kernel test robot <lkp@intel.com>
To: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, bhupesh@igalia.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	oliver.sang@intel.com, lkp@intel.com, laoar.shao@gmail.com,
	pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de
Subject: Re: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <202505220326.5yDQHjnt-lkp@intel.com>
References: <20250521062337.53262-3-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521062337.53262-3-bhupesh@igalia.com>

Hi Bhupesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on tip/sched/core akpm-mm/mm-everything linus/master v6.15-rc7 next-20250521]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250521-142443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250521062337.53262-3-bhupesh%40igalia.com
patch subject: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm' to a more safer implementation
config: arc-randconfig-002-20250522 (https://download.01.org/0day-ci/archive/20250522/202505220326.5yDQHjnt-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505220326.5yDQHjnt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505220326.5yDQHjnt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/coredump.c:20:
   fs/coredump.c: In function 'do_coredump':
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:655:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure(
       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:730:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure("Core dump to %s aborted: "
       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:725:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure("Core dump to %s aborted: "
       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:618:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure("over core_pipe_limit, skipping core dump");
       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:642:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure("|%s pipe failed", cn.corename);
       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:625:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure("%s failed to allocate memory", __func__);
       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:611:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:591:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure("format_corename failed, aborting core");
       ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:752:4: note: in expansion of macro 'coredump_report_failure'
       coredump_report_failure("Core dump to |%s disabled", cn.corename);
       ^~~~~~~~~~~~~~~~~~~~~~~
   fs/coredump.c: In function 'validate_coredump_safety':
>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
      comm[TASK_COMM_LEN] = '\0'; \
      ~~~~^~~~~~~~~~~~~~~
   include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
    #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
                                              ^~~~~~~~~~~~~~~~~
   fs/coredump.c:1006:3: note: in expansion of macro 'coredump_report_failure'
      coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
      ^~~~~~~~~~~~~~~~~~~~~~~


vim +57 include/linux/coredump.h

    46	
    47	/*
    48	 * Logging for the coredump code, ratelimited.
    49	 * The TGID and comm fields are added to the message.
    50	 */
    51	
    52	#define __COREDUMP_PRINTK(Level, Format, ...) \
    53		do {	\
    54			char comm[TASK_COMM_LEN];	\
    55			/* This will always be NUL terminated. */ \
    56			memcpy(comm, current->comm, TASK_COMM_LEN); \
  > 57			comm[TASK_COMM_LEN] = '\0'; \
    58			printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
    59				task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
    60		} while (0)	\
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

