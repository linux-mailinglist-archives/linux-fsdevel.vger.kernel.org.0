Return-Path: <linux-fsdevel+bounces-49693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CEEAC14F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 21:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1954E29DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819392BEC5B;
	Thu, 22 May 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Cll4vntr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B014C5AF;
	Thu, 22 May 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943207; cv=none; b=UMq+HAncRb5vZYSatvYO6/AJXPNGMxBzxl+Xdb91/LiwuqmuvIc1YMT61Ec+7K/+r+lgFHBCU2fJ3wz/GwvS8q1fpLzsvab/KPylLqRZuO7p8ReMzcPeRqlCXEXx9ijo8yophP6Nix/lAns4ygenTVypuq6qzqbSYfgiy5Z930o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943207; c=relaxed/simple;
	bh=5VIQ59seO6MMcA2e64dfxzNyomkj44DCQXxI//+MMs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWKt4zLRZfBbRx6pRFFfaTYOq2PXcPzfQ+WEwEt/QYjlAA6+vSIrzdqaHOZc0Uaf8mivKOkNCTTbHcZL2nWoamWvphPf6a4eRHwOdD1Hywmv9GDAaXJkHuBf29oLgXhVK7G9MD0mxMaeuWR2kFowZQPsv5KWzdZSBMKQ4j3iQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Cll4vntr; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qeZlnXYF3mBRhpPdC9Jj7FrmO4B5jYVsug5/mB2ATrk=; b=Cll4vntrWxDQHGd06wM/5/FPon
	d/xHRk/fvEtuUYRc6hg8+jQOGB/wQa4NEPh8TtKTEEnD8JI8UKykDQkvNNqg9Ar01RtAFWBHlmHRd
	o69Saiy5TK1TRu77be7AvDco+WSd5iszqybMsZU6wMcJil9CpM+F4RJvOrZh8vdAeSm1nPbuNrJG/
	nMfJTosrIPc45cS5N2xeGCNE/JDUeq6Hyo0BiVtO2sPbcN3SwdOw+6qlhAVB9LN6q0ww43EK1DoBF
	SJ4Ltp7uoeVb3MPzhJp/wcfm9jI0G8wMiHg5EEzMLu79hdRHvG/5fpl4Pj30Ej2FFCwr2xUD/CMfw
	HP1hjY0A==;
Received: from [223.233.76.245] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uIBsF-00Bryb-K6; Thu, 22 May 2025 21:46:39 +0200
Message-ID: <24840570-913e-1603-eb92-baefd4758784@igalia.com>
Date: Fri, 23 May 2025 01:16:31 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Bhupesh <bhupesh@igalia.com>,
 akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, laoar.shao@gmail.com,
 pmladek@suse.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de
References: <20250521062337.53262-3-bhupesh@igalia.com>
 <202505220326.5yDQHjnt-lkp@intel.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <202505220326.5yDQHjnt-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/22/25 1:32 AM, kernel test robot wrote:
> Hi Bhupesh,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on trace/for-next]
> [also build test WARNING on tip/sched/core akpm-mm/mm-everything linus/master v6.15-rc7 next-20250521]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250521-142443
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> patch link:    https://lore.kernel.org/r/20250521062337.53262-3-bhupesh%40igalia.com
> patch subject: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm' to a more safer implementation
> config: arc-randconfig-002-20250522 (https://download.01.org/0day-ci/archive/20250522/202505220326.5yDQHjnt-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505220326.5yDQHjnt-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505220326.5yDQHjnt-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     In file included from fs/coredump.c:20:
>     fs/coredump.c: In function 'do_coredump':
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:655:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure(
>         ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:730:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure("Core dump to %s aborted: "
>         ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:725:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure("Core dump to %s aborted: "
>         ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:618:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure("over core_pipe_limit, skipping core dump");
>         ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:642:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure("|%s pipe failed", cn.corename);
>         ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:625:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure("%s failed to allocate memory", __func__);
>         ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:611:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
>         ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:591:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure("format_corename failed, aborting core");
>         ^~~~~~~~~~~~~~~~~~~~~~~
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:752:4: note: in expansion of macro 'coredump_report_failure'
>         coredump_report_failure("Core dump to |%s disabled", cn.corename);
>         ^~~~~~~~~~~~~~~~~~~~~~~
>     fs/coredump.c: In function 'validate_coredump_safety':
>>> include/linux/coredump.h:57:7: warning: array subscript 16 is above array bounds of 'char[16]' [-Warray-bounds]
>        comm[TASK_COMM_LEN] = '\0'; \
>        ~~~~^~~~~~~~~~~~~~~
>     include/linux/coredump.h:63:43: note: in expansion of macro '__COREDUMP_PRINTK'
>      #define coredump_report_failure(fmt, ...) __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>                                                ^~~~~~~~~~~~~~~~~
>     fs/coredump.c:1006:3: note: in expansion of macro 'coredump_report_failure'
>        coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
>        ^~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +57 include/linux/coredump.h
>
>      46	
>      47	/*
>      48	 * Logging for the coredump code, ratelimited.
>      49	 * The TGID and comm fields are added to the message.
>      50	 */
>      51	
>      52	#define __COREDUMP_PRINTK(Level, Format, ...) \
>      53		do {	\
>      54			char comm[TASK_COMM_LEN];	\
>      55			/* This will always be NUL terminated. */ \
>      56			memcpy(comm, current->comm, TASK_COMM_LEN); \
>    > 57			comm[TASK_COMM_LEN] = '\0'; \
>      58			printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
>      59				task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
>      60		} while (0)	\
>      61	
>

Thanks, I will fix these in v5.

Regards,
Bhupesh

