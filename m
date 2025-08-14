Return-Path: <linux-fsdevel+bounces-57855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92DFB25F11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302BD7228CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6F72E7BBE;
	Thu, 14 Aug 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6oXdcgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5125B1D5;
	Thu, 14 Aug 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160658; cv=none; b=U0NGzORRFAzewEZYSjdU8iVCuwSyDk7VhNa2x80k7uNfcXMwViXPYvt594pFWVuN9ZuUXp9TEAYMbrB4r1/VTOqBi9ruDlo7LRHoYOOXqHSWgKjb9jXYNUj4GHmN1rosb/aPReCKD3HrfZDlKljhbP26YHsFkQjnOUdpiI5WrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160658; c=relaxed/simple;
	bh=ySpcFEqW6mx248pQaNRvOQVwo6ykQE7J6nfU5QTBWiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slJqOGX41tRUuJQ5cXF6prlgRCqQGttwE90MwZ1um/md7GUu8OPeZA7QqFr5BYuQGWdO7ssUwBo/B5WyCb0rvwMQtReLe8cOthHiWT4lvf8ti+ZZ2yToEDeelMt20NM0RyHkt48q2WiWxjScwuDQMiX4dKuJ/hiSj58+U9fJ4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6oXdcgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35236C4CEEF;
	Thu, 14 Aug 2025 08:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160656;
	bh=ySpcFEqW6mx248pQaNRvOQVwo6ykQE7J6nfU5QTBWiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6oXdcgVciv/6BykGif5185QIWWX9Vff7Gxpuxu1c1XK1or/K4wIhNhT+pes02G9K
	 zNvEs9K7QoOxvFG6Fw6noFJ20aHFitgr//ZwU3ghWpn8hW+AZTT8MPYTZwBmVsq1BP
	 LtAHwk+FdENWA+tnwN91riEqFzg7OMFUoCJOD8tWN/cLUZAp5E/TlJ4I9v8XQTwYoA
	 +hgzErxjxvLrVN6Sg/aAGfeSYznXOQeiDmqdUmH9KK7FNbXA0BzTgKv7hIbx3uYcaC
	 1Q2vqEreet9nlLsh5+8IyBPu0V3x30wCUzSOutTeO/X0ojmjwMiGayPIX3+Z7mxNOI
	 OH9otFL1/ZPiQ==
Date: Thu, 14 Aug 2025 11:37:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 06/10] mm: update coredump logic to correctly use bitmap
 mm flags
Message-ID: <aJ2gOkevzkXazfvv@kernel.org>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a5075f7e3c5b367d988178c79a3063d12ee53a9.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:15PM +0100, Lorenzo Stoakes wrote:
> The coredump logic is slightly different from other users in that it both
> stores mm flags and additionally sets and gets using masks.
> 
> Since the MMF_DUMPABLE_* flags must remain as they are for uABI reasons,
> and of course these are within the first 32-bits of the flags, it is
> reasonable to provide access to these in the same fashion so this logic can
> all still keep working as it has been.
> 
> Therefore, introduce coredump-specific helpers __mm_flags_get_dumpable()
> and __mm_flags_set_mask_dumpable() for this purpose, and update all core
> dump users of mm flags to use these.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/coredump.c                  |  4 +++-
>  fs/exec.c                      |  2 +-
>  fs/pidfs.c                     |  7 +++++--
>  fs/proc/base.c                 |  8 +++++---
>  include/linux/sched/coredump.h | 21 ++++++++++++++++++++-
>  5 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index fedbead956ed..e5d9d6276990 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1103,8 +1103,10 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
>  		 * We must use the same mm->flags while dumping core to avoid
>  		 * inconsistency of bit flags, since this flag is not protected
>  		 * by any locks.
> +		 *
> +		 * Note that we only care about MMF_DUMP* flags.
>  		 */
> -		.mm_flags = mm->flags,
> +		.mm_flags = __mm_flags_get_dumpable(mm),
>  		.vma_meta = NULL,
>  		.cpu = raw_smp_processor_id(),
>  	};
> diff --git a/fs/exec.c b/fs/exec.c
> index 2a1e5e4042a1..dbac0e84cc3e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1999,7 +1999,7 @@ void set_dumpable(struct mm_struct *mm, int value)
>  	if (WARN_ON((unsigned)value > SUID_DUMP_ROOT))
>  		return;
>  
> -	set_mask_bits(&mm->flags, MMF_DUMPABLE_MASK, value);
> +	__mm_flags_set_mask_dumpable(mm, value);
>  }
>  
>  SYSCALL_DEFINE3(execve,
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index edc35522d75c..5148b7646b7f 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -357,8 +357,11 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  	if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
>  		task_lock(task);
> -		if (task->mm)
> -			kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
> +		if (task->mm) {
> +			unsigned long flags = __mm_flags_get_dumpable(task->mm);
> +
> +			kinfo.coredump_mask = pidfs_coredump_mask(flags);
> +		}
>  		task_unlock(task);
>  	}
>  
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 62d35631ba8c..f0c093c58aaf 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2962,8 +2962,10 @@ static ssize_t proc_coredump_filter_read(struct file *file, char __user *buf,
>  	ret = 0;
>  	mm = get_task_mm(task);
>  	if (mm) {
> +		unsigned long flags = __mm_flags_get_dumpable(mm);
> +
>  		len = snprintf(buffer, sizeof(buffer), "%08lx\n",
> -			       ((mm->flags & MMF_DUMP_FILTER_MASK) >>
> +			       ((flags & MMF_DUMP_FILTER_MASK) >>
>  				MMF_DUMP_FILTER_SHIFT));
>  		mmput(mm);
>  		ret = simple_read_from_buffer(buf, count, ppos, buffer, len);
> @@ -3002,9 +3004,9 @@ static ssize_t proc_coredump_filter_write(struct file *file,
>  
>  	for (i = 0, mask = 1; i < MMF_DUMP_FILTER_BITS; i++, mask <<= 1) {
>  		if (val & mask)
> -			set_bit(i + MMF_DUMP_FILTER_SHIFT, &mm->flags);
> +			mm_flags_set(i + MMF_DUMP_FILTER_SHIFT, mm);
>  		else
> -			clear_bit(i + MMF_DUMP_FILTER_SHIFT, &mm->flags);
> +			mm_flags_clear(i + MMF_DUMP_FILTER_SHIFT, mm);
>  	}
>  
>  	mmput(mm);
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 6eb65ceed213..19ecfcceb27a 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -2,12 +2,29 @@
>  #ifndef _LINUX_SCHED_COREDUMP_H
>  #define _LINUX_SCHED_COREDUMP_H
>  
> +#include <linux/compiler_types.h>
>  #include <linux/mm_types.h>
>  
>  #define SUID_DUMP_DISABLE	0	/* No setuid dumping */
>  #define SUID_DUMP_USER		1	/* Dump as user of process */
>  #define SUID_DUMP_ROOT		2	/* Dump as root */
>  
> +static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)
> +{
> +	/*
> +	 * By convention, dumpable bits are contained in first 32 bits of the
> +	 * bitmap, so we can simply access this first unsigned long directly.
> +	 */
> +	return __mm_flags_get_word(mm);
> +}
> +
> +static inline void __mm_flags_set_mask_dumpable(struct mm_struct *mm, int value)
> +{
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +
> +	set_mask_bits(bitmap, MMF_DUMPABLE_MASK, value);
> +}
> +
>  extern void set_dumpable(struct mm_struct *mm, int value);
>  /*
>   * This returns the actual value of the suid_dumpable flag. For things
> @@ -22,7 +39,9 @@ static inline int __get_dumpable(unsigned long mm_flags)
>  
>  static inline int get_dumpable(struct mm_struct *mm)
>  {
> -	return __get_dumpable(mm->flags);
> +	unsigned long flags = __mm_flags_get_dumpable(mm);
> +
> +	return __get_dumpable(flags);
>  }
>  
>  #endif /* _LINUX_SCHED_COREDUMP_H */
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

