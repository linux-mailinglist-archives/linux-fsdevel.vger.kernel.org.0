Return-Path: <linux-fsdevel+bounces-58740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE50B30D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 06:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B873B3459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164AE2690D1;
	Fri, 22 Aug 2025 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ME2tEbbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECE4C79;
	Fri, 22 Aug 2025 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835333; cv=none; b=ftTQw//uohXDEo2dxrQl3OpZB1mYUmfzkdWAqX7OdfVq4KADesnI889z3jz8vRQu/F4Nd/uIAe57/KMHx4y8grTKb5SwagLOskp7ZTa1BNU6xR+opgQBg2X9s18dn43yr94beZGU5NUqiVCltzuZDshQLuIdEeqfsFGmArfY8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835333; c=relaxed/simple;
	bh=/2ROtHmJaUr9LhJbv1++PQhIJX2V9C+1ND0616Z6a24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8Vk/1jIO11nkd/YhRNFitK/LX5AMeZkKLmJwmLyYc4MZ7eO9mLd0rjkJE5yxaEyFFzPa6A+9YSfBZE1CESDi/mlL6jUPmv2niPRqwlbr4Qbj39cLDk9kzniQKrnu7P6chH+czP5MxgEdqxrto9mwEp3y7UpOJ1Jx9md2tGdznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ME2tEbbv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755835332; x=1787371332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/2ROtHmJaUr9LhJbv1++PQhIJX2V9C+1ND0616Z6a24=;
  b=ME2tEbbveJiTW4jdCGO2fupVttYZUHzsdx4XQaSBnqhmfbUczoTL38+O
   QZAryClPx/tzwdlAfe5ES7zO3m7uxu9UQSYJDAbpJoaHRUaQo/zqzhpRo
   DNQCFalIWdZWDzPRoqDoxlvbrk8pDWXb/sbYiGPmPZY4KTpnjKtqeCRsW
   +3tr1XA2sAOThdLaWsT5P4kj0BSu5myfPegKF8H6ldqLXDcpz4LfxPGJ8
   8+gXP4BUV/ThWG6m8u2HLwNlWJ2npMAFzd2J7/fxM8PnUwTfNAKKKCkuk
   TtcvQ5YH5YgmnrAA1v987D5YJmdbrFDMrwDaLN+PDvoPh8cd5EOmbp/mP
   w==;
X-CSE-ConnectionGUID: lULCvBr3RtGcngP/jnDofw==
X-CSE-MsgGUID: AEfzbNM0ThOXg1C+V4Xt8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57339843"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57339843"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 21:02:04 -0700
X-CSE-ConnectionGUID: HoNmLB6YRbmMZ5elSlrDeg==
X-CSE-MsgGUID: VVHpgrRVTgiUxTAicaXTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168804505"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 21 Aug 2025 21:01:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upIxI-000Ktb-17;
	Fri, 22 Aug 2025 04:01:12 +0000
Date: Fri, 22 Aug 2025 11:59:51 +0800
From: kernel test robot <lkp@intel.com>
To: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bhupesh@igalia.com,
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
Subject: Re: [PATCH v8 3/5] treewide: Replace 'get_task_comm()' with
 'strscpy_pad()'
Message-ID: <202508221127.LiaxcbdW-lkp@intel.com>
References: <20250821102152.323367-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821102152.323367-4-bhupesh@igalia.com>

Hi Bhupesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5303936d609e09665deda94eaedf26a0e5c3a087]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250821-182426
base:   5303936d609e09665deda94eaedf26a0e5c3a087
patch link:    https://lore.kernel.org/r/20250821102152.323367-4-bhupesh%40igalia.com
patch subject: [PATCH v8 3/5] treewide: Replace 'get_task_comm()' with 'strscpy_pad()'
config: x86_64-buildonly-randconfig-001-20250822 (https://download.01.org/0day-ci/archive/20250822/202508221127.LiaxcbdW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508221127.LiaxcbdW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221127.LiaxcbdW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/panthor/panthor_sched.c:3420:2: error: call to undeclared function 'get_task_comm'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3420 |         get_task_comm(group->task_info.comm, task);
         |         ^
   drivers/gpu/drm/panthor/panthor_sched.c:3420:2: note: did you mean 'get_task_mm'?
   include/linux/sched/mm.h:151:26: note: 'get_task_mm' declared here
     151 | extern struct mm_struct *get_task_mm(struct task_struct *task);
         |                          ^
   1 error generated.


vim +/get_task_comm +3420 drivers/gpu/drm/panthor/panthor_sched.c

de85488138247d Boris Brezillon 2024-02-29  3414  
33b9cb6dcda252 Chia-I Wu       2025-07-17  3415  static void group_init_task_info(struct panthor_group *group)
33b9cb6dcda252 Chia-I Wu       2025-07-17  3416  {
33b9cb6dcda252 Chia-I Wu       2025-07-17  3417  	struct task_struct *task = current->group_leader;
33b9cb6dcda252 Chia-I Wu       2025-07-17  3418  
33b9cb6dcda252 Chia-I Wu       2025-07-17  3419  	group->task_info.pid = task->pid;
33b9cb6dcda252 Chia-I Wu       2025-07-17 @3420  	get_task_comm(group->task_info.comm, task);
33b9cb6dcda252 Chia-I Wu       2025-07-17  3421  }
33b9cb6dcda252 Chia-I Wu       2025-07-17  3422  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

