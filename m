Return-Path: <linux-fsdevel+bounces-24413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D8893F129
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DCB284B97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99B1420DF;
	Mon, 29 Jul 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTz/vxVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47A13FD84;
	Mon, 29 Jul 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245395; cv=none; b=PpG9YUdNWrKHpFBc3c+jdor5SvJ/3HXS4QnWAZ9WiGU42xN1UqBhurl5dgTG3u0ZoWfSCExXVKX/tM+bUt4dz5XtHcvREZeJ7iRpOAQeYyToacxuumHM1LMoIorn+DFQQLXXiL0isjK6BO6M/bRmiliLdC+0sibLnIKQTr6hIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245395; c=relaxed/simple;
	bh=Okn6Hh7a8OxqdINhFpBMmcm+OFNUZUiCDEeJ7M45+Ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oYTi/9yTvzqBsJT95RdEpn/rLbh75h8czmABeXug2cp2z1mYhH4ZkIxU+qEgDpUIRDC3gPjjzawRZplVvSJE8T6fXOufheX6XihqrKWCK6BPReAoJ311LPm3P62WdakKBy5tiM/eQYiU9U0jxsPXAYL2D+N28iVWmi8N/qOQnB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTz/vxVb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722245393; x=1753781393;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Okn6Hh7a8OxqdINhFpBMmcm+OFNUZUiCDEeJ7M45+Ag=;
  b=FTz/vxVbdaVtlhCyuYMslzKkZUiFuUBaYzqYn9LrxwM15kb81n5LYetM
   u7VHgOIu1LDwy0B5gMcIjYhG2xkV89m95/lanGRU6mClaQjBMp6CiycTv
   +RV+IypDCFxOdg8RqH8CjdPkkisJ7K8Z0kDfryjJ7hZ4OYurt7Whr1JSM
   EN6dnqQR22gMSvmC0FzEipdP/2tDKz5w6rXpL3JCUx17ODXSAzQhZB6Jy
   2kV73zLRiWhEGliUX6QnhJpNc17gu8W0wMxg4X8vnotDuKQEjEIlvpImC
   2n78RUR9F4iFSH8pImfwcL8f4atWWFngoy8XNQ0XBmnXM5kEw6QiC8JNS
   A==;
X-CSE-ConnectionGUID: k4/ihfkhQ3+IZH/Ye47bnQ==
X-CSE-MsgGUID: jEc1onOnT3mXlMbfxXEiBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30606920"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30606920"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 02:29:52 -0700
X-CSE-ConnectionGUID: si+UUBxSQyyqZAevhhfeqw==
X-CSE-MsgGUID: D2TdvVJKRvC0UDCGKJ8A3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="54513537"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.185])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 02:29:46 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
 alexei.starovoitov@gmail.com, rostedt@goodmis.org,
 catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH resend v4 00/11] Improve the copy of task comm
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240729023719.1933-1-laoar.shao@gmail.com>
Date: Mon, 29 Jul 2024 12:29:43 +0300
Message-ID: <87bk2gzgu0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 29 Jul 2024, Yafang Shao <laoar.shao@gmail.com> wrote:
> Hello Andrew,
>
> Is it appropriate for you to apply this to the mm tree?
>
> Using {memcpy,strncpy,strcpy,kstrdup} to copy the task comm relies on the
> length of task comm. Changes in the task comm could result in a destination
> string that is overflow. Therefore, we should explicitly ensure the destination
> string is always NUL-terminated, regardless of the task comm. This approach
> will facilitate future extensions to the task comm.

Why are we normalizing calling double-underscore prefixed functions all
over the place? i.e. __get_task_comm().

get_task_comm() is widely used. At a glance, looks like it could be used
in many of the patches here too.


BR,
Jani.


>
> As suggested by Linus [0], we can identify all relevant code with the
> following git grep command:
>
>   git grep 'memcpy.*->comm\>'
>   git grep 'kstrdup.*->comm\>'
>   git grep 'strncpy.*->comm\>'
>   git grep 'strcpy.*->comm\>'
>
> PATCH #2~#4:   memcpy
> PATCH #5~#6:   kstrdup
> PATCH #7~#9:   strncpy
> PATCH #10~#11: strcpy
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/ [0]
>
> Changes:
> v3->v4:
> - Rename __kstrndup() to __kmemdup_nul() and define it inside mm/util.c
>   (Matthew)
> - Remove unused local varaible (Simon)
>
> v2->v3: https://lore.kernel.org/all/20240621022959.9124-1-laoar.shao@gmail.com/
> - Deduplicate code around kstrdup (Andrew)
> - Add commit log for dropping task_lock (Catalin)
>
> v1->v2: https://lore.kernel.org/bpf/20240613023044.45873-1-laoar.shao@gmail.com/
> - Add comment for dropping task_lock() in __get_task_comm() (Alexei)
> - Drop changes in trace event (Steven)
> - Fix comment on task comm (Matus)
>
> v1: https://lore.kernel.org/all/20240602023754.25443-1-laoar.shao@gmail.com/
>
> Yafang Shao (11):
>   fs/exec: Drop task_lock() inside __get_task_comm()
>   auditsc: Replace memcpy() with __get_task_comm()
>   security: Replace memcpy() with __get_task_comm()
>   bpftool: Ensure task comm is always NUL-terminated
>   mm/util: Fix possible race condition in kstrdup()
>   mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
>   mm/kmemleak: Replace strncpy() with __get_task_comm()
>   tsacct: Replace strncpy() with __get_task_comm()
>   tracing: Replace strncpy() with __get_task_comm()
>   net: Replace strcpy() with __get_task_comm()
>   drm: Replace strcpy() with __get_task_comm()
>
>  drivers/gpu/drm/drm_framebuffer.c     |  2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.c |  2 +-
>  fs/exec.c                             | 10 ++++-
>  include/linux/sched.h                 |  4 +-
>  kernel/auditsc.c                      |  6 +--
>  kernel/trace/trace.c                  |  2 +-
>  kernel/trace/trace_events_hist.c      |  2 +-
>  kernel/tsacct.c                       |  2 +-
>  mm/kmemleak.c                         |  8 +---
>  mm/util.c                             | 61 ++++++++++++---------------
>  net/ipv6/ndisc.c                      |  2 +-
>  security/lsm_audit.c                  |  4 +-
>  security/selinux/selinuxfs.c          |  2 +-
>  tools/bpf/bpftool/pids.c              |  2 +
>  14 files changed, 51 insertions(+), 58 deletions(-)

-- 
Jani Nikula, Intel

