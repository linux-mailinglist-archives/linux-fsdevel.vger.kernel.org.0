Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEB1399FD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 13:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhFCLfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 07:35:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46054 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhFCLfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:35:17 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3E2E01FD4D;
        Thu,  3 Jun 2021 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622720011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8tya0gRA16vqccjCYxDsEZaA/iXon4YBfXX220snnpc=;
        b=jLh4jsJZ6mHJ4E0UU3yQ0vCldT/9pITZuQvPlq47gsoQHLb0o/5mNKepMY7mcMoOe3i/PD
        lGwtxmCfIGb29JOa0LpEhmkKxERHZJoxbu9mHa/U5uC0y+FA+1X2jpW8ZS/SklEn02Q9Sk
        RxNlQDSkt7Wor8sUolGDmz1EeLofUcY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A9384A3B88;
        Thu,  3 Jun 2021 11:33:30 +0000 (UTC)
Date:   Thu, 3 Jun 2021 13:33:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     legion@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
Message-ID: <YLi+CVAmWle9Ecwe@dhcp22.suse.cz>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc linux-api]

On Thu 03-06-21 12:43:07, legion@kernel.org wrote:
> From: Alexey Gladkov <legion@kernel.org>
> 
> The /proc/meminfo contains information regardless of the cgroups
> restrictions. This file is still widely used [1]. This means that all
> these programs will not work correctly inside container [2][3][4]. Some
> programs try to respect the cgroups limits, but not all of them
> implement support for all cgroup versions [5].
> 
> Correct information can be obtained from cgroups, but this requires the
> cgroups to be available inside container and the correct version of
> cgroups to be supported.
> 
> There is lxcfs [6] that emulates /proc/meminfo using fuse to provide
> information regarding cgroups. This patch can help them.
> 
> This patch adds /proc/self/meminfo that contains a subset of
> /proc/meminfo respecting cgroup restrictions.
> 
> We cannot just create /proc/self/meminfo and make a symlink at the old
> location because this will break the existing apparmor rules [7].
> Therefore, the patch adds a separate file with the same format.
> 
> [1] https://codesearch.debian.net/search?q=%2Fproc%2Fmeminfo
> [2] https://sources.debian.org/src/erlang/1:23.2.6+dfsg-1/lib/os_mon/c_src/memsup.c#L300
> [3] https://sources.debian.org/src/p7zip/16.02+dfsg-8/CPP/Windows/System.cpp/#L103
> [4] https://sources.debian.org/src/systemd/247.3-5/src/oom/oomd.c/#L138
> [5] https://sources.debian.org/src/nodejs/12.21.0%7Edfsg-4/deps/uv/src/unix/linux-core.c/#L1059
> [6] https://linuxcontainers.org/lxcfs/
> [7] https://gitlab.com/apparmor/apparmor/-/blob/master/profiles/apparmor.d/abstractions/base#L98
> 
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  fs/proc/base.c             |   2 +
>  fs/proc/internal.h         |   6 ++
>  fs/proc/meminfo.c          | 160 +++++++++++++++++++++++--------------
>  include/linux/memcontrol.h |   2 +
>  include/linux/mm.h         |  15 ++++
>  mm/memcontrol.c            |  80 +++++++++++++++++++
>  mm/page_alloc.c            |  28 ++++---
>  7 files changed, 222 insertions(+), 71 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 58bbf334265b..e95837cf713f 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3269,6 +3269,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #ifdef CONFIG_SECCOMP_CACHE_DEBUG
>  	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
>  #endif
> +	ONE("meminfo",  S_IRUGO, proc_meminfo_show),
>  };
>  
>  static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
> @@ -3602,6 +3603,7 @@ static const struct pid_entry tid_base_stuff[] = {
>  #ifdef CONFIG_SECCOMP_CACHE_DEBUG
>  	ONE("seccomp_cache", S_IRUSR, proc_pid_seccomp_cache),
>  #endif
> +	ONE("meminfo",  S_IRUGO, proc_meminfo_show),
>  };
>  
>  static int proc_tid_base_readdir(struct file *file, struct dir_context *ctx)
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 03415f3fb3a8..a6e8540afbd3 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -241,6 +241,12 @@ extern int proc_net_init(void);
>  static inline int proc_net_init(void) { return 0; }
>  #endif
>  
> +/*
> + * meminfo.c
> + */
> +extern int proc_meminfo_show(struct seq_file *m, struct pid_namespace *ns,
> +		struct pid *pid, struct task_struct *tsk);
> +
>  /*
>   * proc_self.c
>   */
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..3587a79d4b96 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -16,6 +16,9 @@
>  #ifdef CONFIG_CMA
>  #include <linux/cma.h>
>  #endif
> +#ifdef CONFIG_MEMCG
> +#include <linux/memcontrol.h>
> +#endif
>  #include <asm/page.h>
>  #include "internal.h"
>  
> @@ -23,91 +26,112 @@ void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
>  {
>  }
>  
> +static void proc_fill_meminfo(struct meminfo *mi)
> +{
> +	int lru;
> +	long cached;
> +
> +	si_meminfo(&mi->si);
> +	si_swapinfo(&mi->si);
> +
> +	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
> +		mi->pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
> +
> +	cached = global_node_page_state(NR_FILE_PAGES) - total_swapcache_pages() - mi->si.bufferram;
> +	if (cached < 0)
> +		cached = 0;
> +
> +	mi->cached = cached;
> +	mi->swapcached = total_swapcache_pages();
> +	mi->slab_reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
> +	mi->slab_unreclaimable = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
> +	mi->anon_pages = global_node_page_state(NR_ANON_MAPPED);
> +	mi->mapped = global_node_page_state(NR_FILE_MAPPED);
> +	mi->nr_pagetable = global_node_page_state(NR_PAGETABLE);
> +	mi->dirty_pages = global_node_page_state(NR_FILE_DIRTY);
> +	mi->writeback_pages = global_node_page_state(NR_WRITEBACK);
> +}
> +
> +#ifdef CONFIG_MEMCG
> +static inline void fill_meminfo(struct meminfo *mi, struct task_struct *task)
> +{
> +	mem_fill_meminfo(mi, task);
> +}
> +#else
> +static inline void fill_meminfo(struct meminfo *mi, struct task_struct *task)
> +{
> +	proc_fill_meminfo(mi);
> +}
> +#endif
> +
>  static void show_val_kb(struct seq_file *m, const char *s, unsigned long num)
>  {
>  	seq_put_decimal_ull_width(m, s, num << (PAGE_SHIFT - 10), 8);
>  	seq_write(m, " kB\n", 4);
>  }
>  
> +static int meminfo_proc_show_mi(struct seq_file *m, struct meminfo *mi)
> +{
> +	show_val_kb(m, "MemTotal:       ", mi->si.totalram);
> +	show_val_kb(m, "MemFree:        ", mi->si.freeram);
> +	show_val_kb(m, "MemAvailable:   ", si_mem_available_mi(mi));
> +	show_val_kb(m, "Buffers:        ", mi->si.bufferram);
> +	show_val_kb(m, "Cached:         ", mi->cached);
> +	show_val_kb(m, "SwapCached:     ", mi->swapcached);
> +	show_val_kb(m, "Active:         ", mi->pages[LRU_ACTIVE_ANON] + mi->pages[LRU_ACTIVE_FILE]);
> +	show_val_kb(m, "Inactive:       ", mi->pages[LRU_INACTIVE_ANON] + mi->pages[LRU_INACTIVE_FILE]);
> +	show_val_kb(m, "Active(anon):   ", mi->pages[LRU_ACTIVE_ANON]);
> +	show_val_kb(m, "Inactive(anon): ", mi->pages[LRU_INACTIVE_ANON]);
> +	show_val_kb(m, "Active(file):   ", mi->pages[LRU_ACTIVE_FILE]);
> +	show_val_kb(m, "Inactive(file): ", mi->pages[LRU_INACTIVE_FILE]);
> +	show_val_kb(m, "Unevictable:    ", mi->pages[LRU_UNEVICTABLE]);
> +
> +#ifdef CONFIG_HIGHMEM
> +	show_val_kb(m, "HighTotal:      ", mi->si.totalhigh);
> +	show_val_kb(m, "HighFree:       ", mi->si.freehigh);
> +	show_val_kb(m, "LowTotal:       ", mi->si.totalram - mi->si.totalhigh);
> +	show_val_kb(m, "LowFree:        ", mi->si.freeram - mi->si.freehigh);
> +#endif
> +
> +	show_val_kb(m, "SwapTotal:      ", mi->si.totalswap);
> +	show_val_kb(m, "SwapFree:       ", mi->si.freeswap);
> +	show_val_kb(m, "Dirty:          ", mi->dirty_pages);
> +	show_val_kb(m, "Writeback:      ", mi->writeback_pages);
> +
> +	show_val_kb(m, "AnonPages:      ", mi->anon_pages);
> +	show_val_kb(m, "Mapped:         ", mi->mapped);
> +	show_val_kb(m, "Shmem:          ", mi->si.sharedram);
> +	show_val_kb(m, "Slab:           ", mi->slab_reclaimable + mi->slab_unreclaimable);
> +	show_val_kb(m, "SReclaimable:   ", mi->slab_reclaimable);
> +	show_val_kb(m, "SUnreclaim:     ", mi->slab_unreclaimable);
> +	show_val_kb(m, "PageTables:     ", mi->nr_pagetable);
> +
> +	return 0;
> +}
> +
>  static int meminfo_proc_show(struct seq_file *m, void *v)
>  {
> -	struct sysinfo i;
> -	unsigned long committed;
> -	long cached;
> -	long available;
> -	unsigned long pages[NR_LRU_LISTS];
> -	unsigned long sreclaimable, sunreclaim;
> -	int lru;
>  
> -	si_meminfo(&i);
> -	si_swapinfo(&i);
> -	committed = vm_memory_committed();
> +	struct meminfo mi;
>  
> -	cached = global_node_page_state(NR_FILE_PAGES) -
> -			total_swapcache_pages() - i.bufferram;
> -	if (cached < 0)
> -		cached = 0;
> +	proc_fill_meminfo(&mi);
> +	meminfo_proc_show_mi(m, &mi);
>  
> -	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
> -		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
> -
> -	available = si_mem_available();
> -	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
> -	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
> -
> -	show_val_kb(m, "MemTotal:       ", i.totalram);
> -	show_val_kb(m, "MemFree:        ", i.freeram);
> -	show_val_kb(m, "MemAvailable:   ", available);
> -	show_val_kb(m, "Buffers:        ", i.bufferram);
> -	show_val_kb(m, "Cached:         ", cached);
> -	show_val_kb(m, "SwapCached:     ", total_swapcache_pages());
> -	show_val_kb(m, "Active:         ", pages[LRU_ACTIVE_ANON] +
> -					   pages[LRU_ACTIVE_FILE]);
> -	show_val_kb(m, "Inactive:       ", pages[LRU_INACTIVE_ANON] +
> -					   pages[LRU_INACTIVE_FILE]);
> -	show_val_kb(m, "Active(anon):   ", pages[LRU_ACTIVE_ANON]);
> -	show_val_kb(m, "Inactive(anon): ", pages[LRU_INACTIVE_ANON]);
> -	show_val_kb(m, "Active(file):   ", pages[LRU_ACTIVE_FILE]);
> -	show_val_kb(m, "Inactive(file): ", pages[LRU_INACTIVE_FILE]);
> -	show_val_kb(m, "Unevictable:    ", pages[LRU_UNEVICTABLE]);
>  	show_val_kb(m, "Mlocked:        ", global_zone_page_state(NR_MLOCK));
>  
> -#ifdef CONFIG_HIGHMEM
> -	show_val_kb(m, "HighTotal:      ", i.totalhigh);
> -	show_val_kb(m, "HighFree:       ", i.freehigh);
> -	show_val_kb(m, "LowTotal:       ", i.totalram - i.totalhigh);
> -	show_val_kb(m, "LowFree:        ", i.freeram - i.freehigh);
> -#endif
> -
>  #ifndef CONFIG_MMU
>  	show_val_kb(m, "MmapCopy:       ",
>  		    (unsigned long)atomic_long_read(&mmap_pages_allocated));
>  #endif
>  
> -	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> -	show_val_kb(m, "SwapFree:       ", i.freeswap);
> -	show_val_kb(m, "Dirty:          ",
> -		    global_node_page_state(NR_FILE_DIRTY));
> -	show_val_kb(m, "Writeback:      ",
> -		    global_node_page_state(NR_WRITEBACK));
> -	show_val_kb(m, "AnonPages:      ",
> -		    global_node_page_state(NR_ANON_MAPPED));
> -	show_val_kb(m, "Mapped:         ",
> -		    global_node_page_state(NR_FILE_MAPPED));
> -	show_val_kb(m, "Shmem:          ", i.sharedram);
> -	show_val_kb(m, "KReclaimable:   ", sreclaimable +
> +	show_val_kb(m, "KReclaimable:   ", mi.slab_reclaimable +
>  		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
> -	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
> -	show_val_kb(m, "SReclaimable:   ", sreclaimable);
> -	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
>  	seq_printf(m, "KernelStack:    %8lu kB\n",
>  		   global_node_page_state(NR_KERNEL_STACK_KB));
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	seq_printf(m, "ShadowCallStack:%8lu kB\n",
>  		   global_node_page_state(NR_KERNEL_SCS_KB));
>  #endif
> -	show_val_kb(m, "PageTables:     ",
> -		    global_node_page_state(NR_PAGETABLE));
>  
>  	show_val_kb(m, "NFS_Unstable:   ", 0);
>  	show_val_kb(m, "Bounce:         ",
> @@ -115,7 +139,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "WritebackTmp:   ",
>  		    global_node_page_state(NR_WRITEBACK_TEMP));
>  	show_val_kb(m, "CommitLimit:    ", vm_commit_limit());
> -	show_val_kb(m, "Committed_AS:   ", committed);
> +	show_val_kb(m, "Committed_AS:   ", vm_memory_committed());
>  	seq_printf(m, "VmallocTotal:   %8lu kB\n",
>  		   (unsigned long)VMALLOC_TOTAL >> 10);
>  	show_val_kb(m, "VmallocUsed:    ", vmalloc_nr_pages());
> @@ -153,6 +177,20 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> +int proc_meminfo_show(struct seq_file *m, struct pid_namespace *ns,
> +		     struct pid *pid, struct task_struct *task)
> +{
> +	struct meminfo mi;
> +
> +	fill_meminfo(&mi, task);
> +
> +	meminfo_proc_show_mi(m, &mi);
> +	hugetlb_report_meminfo(m);
> +	arch_report_meminfo(m);
> +
> +	return 0;
> +}
> +
>  static int __init proc_meminfo_init(void)
>  {
>  	proc_create_single("meminfo", 0, NULL, meminfo_proc_show);
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c193be760709..4a7e2894954f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1119,6 +1119,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  						gfp_t gfp_mask,
>  						unsigned long *total_scanned);
>  
> +void mem_fill_meminfo(struct meminfo *mi, struct task_struct *task);
> +
>  #else /* CONFIG_MEMCG */
>  
>  #define MEM_CGROUP_ID_SHIFT	0
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c274f75efcf9..7faeaddd5b88 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2467,6 +2467,20 @@ static inline int early_pfn_to_nid(unsigned long pfn)
>  extern int __meminit early_pfn_to_nid(unsigned long pfn);
>  #endif
>  
> +struct meminfo {
> +	struct sysinfo si;
> +	unsigned long pages[NR_LRU_LISTS];
> +	unsigned long cached;
> +	unsigned long swapcached;
> +	unsigned long anon_pages;
> +	unsigned long mapped;
> +	unsigned long nr_pagetable;
> +	unsigned long dirty_pages;
> +	unsigned long writeback_pages;
> +	unsigned long slab_reclaimable;
> +	unsigned long slab_unreclaimable;
> +};
> +
>  extern void set_dma_reserve(unsigned long new_dma_reserve);
>  extern void memmap_init_range(unsigned long, int, unsigned long,
>  		unsigned long, unsigned long, enum meminit_context,
> @@ -2477,6 +2491,7 @@ extern int __meminit init_per_zone_wmark_min(void);
>  extern void mem_init(void);
>  extern void __init mmap_init(void);
>  extern void show_mem(unsigned int flags, nodemask_t *nodemask);
> +extern long si_mem_available_mi(struct meminfo *mi);
>  extern long si_mem_available(void);
>  extern void si_meminfo(struct sysinfo * val);
>  extern void si_meminfo_node(struct sysinfo *val, int nid);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 64ada9e650a5..344b546f9e25 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3750,6 +3750,86 @@ static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
>  	return nr;
>  }
>  
> +static void mem_cgroup_nr_pages(struct mem_cgroup *memcg, int nid, unsigned long *pages)
> +{
> +	struct mem_cgroup *iter;
> +	int i;
> +
> +	for_each_mem_cgroup_tree(iter, memcg) {
> +		for (i = 0; i < NR_LRU_LISTS; i++)
> +			pages[i] += mem_cgroup_node_nr_lru_pages(iter, nid, BIT(i), false);
> +	}
> +}
> +
> +static void mem_cgroup_si_meminfo(struct sysinfo *si, struct task_struct *task)
> +{
> +	unsigned long memtotal, memused, swapsize;
> +	struct mem_cgroup *memcg;
> +	struct cgroup_subsys_state *css;
> +
> +	css = task_css(task, memory_cgrp_id);
> +	memcg = mem_cgroup_from_css(css);
> +
> +	memtotal = READ_ONCE(memcg->memory.max);
> +
> +	if (memtotal != PAGE_COUNTER_MAX) {
> +		memused = page_counter_read(&memcg->memory);
> +
> +		si->totalram = memtotal;
> +		si->freeram = (memtotal > memused ? memtotal - memused : 0);
> +		si->sharedram = memcg_page_state(memcg, NR_SHMEM);
> +
> +		si->bufferram = nr_blockdev_pages();
> +		si->totalhigh = totalhigh_pages();
> +		si->freehigh = nr_free_highpages();
> +		si->mem_unit = PAGE_SIZE;
> +	} else {
> +		si_meminfo(si);
> +		memused = si->totalram - si->freeram;
> +	}
> +
> +	swapsize = READ_ONCE(memcg->memsw.max);
> +
> +	if (swapsize != PAGE_COUNTER_MAX) {
> +		unsigned long swaptotal, swapused;
> +
> +		swaptotal = swapsize - memtotal;
> +		swapused = page_counter_read(&memcg->memsw) - memused;
> +		si->totalswap = swaptotal;
> +		/* Due to global reclaim, memory.memsw.usage can be greater than
> +		 * (memory.memsw.max - memory.max). */
> +		si->freeswap = (swaptotal > swapused ? swaptotal - swapused : 0);
> +	} else {
> +		si_swapinfo(si);
> +	}
> +
> +	css_put(css);
> +}
> +
> +void mem_fill_meminfo(struct meminfo *mi, struct task_struct *task)
> +{
> +	struct cgroup_subsys_state *memcg_css = task_css(task, memory_cgrp_id);
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(memcg_css);
> +	int nid;
> +
> +	memset(&mi->pages, 0, sizeof(mi->pages));
> +
> +	mem_cgroup_si_meminfo(&mi->si, task);
> +
> +	for_each_online_node(nid)
> +		mem_cgroup_nr_pages(memcg, nid, mi->pages);
> +
> +	mi->slab_reclaimable = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B);
> +	mi->slab_unreclaimable = memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
> +	mi->cached = memcg_page_state(memcg, NR_FILE_PAGES);
> +	mi->swapcached = memcg_page_state(memcg, NR_SWAPCACHE);
> +	mi->anon_pages = memcg_page_state(memcg, NR_ANON_MAPPED);
> +	mi->mapped = memcg_page_state(memcg, NR_FILE_MAPPED);
> +	mi->nr_pagetable = memcg_page_state(memcg, NR_PAGETABLE);
> +	mi->dirty_pages = memcg_page_state(memcg, NR_FILE_DIRTY);
> +	mi->writeback_pages = memcg_page_state(memcg, NR_WRITEBACK);
> +}
> +
>  static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  {
>  	struct numa_stat {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..0a3c9dcd2c13 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5551,18 +5551,13 @@ static inline void show_node(struct zone *zone)
>  		printk("Node %d ", zone_to_nid(zone));
>  }
>  
> -long si_mem_available(void)
> +long si_mem_available_mi(struct meminfo *mi)
>  {
>  	long available;
>  	unsigned long pagecache;
>  	unsigned long wmark_low = 0;
> -	unsigned long pages[NR_LRU_LISTS];
>  	unsigned long reclaimable;
>  	struct zone *zone;
> -	int lru;
> -
> -	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
> -		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
>  
>  	for_each_zone(zone)
>  		wmark_low += low_wmark_pages(zone);
> @@ -5571,14 +5566,14 @@ long si_mem_available(void)
>  	 * Estimate the amount of memory available for userspace allocations,
>  	 * without causing swapping.
>  	 */
> -	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
> +	available = mi->si.freeram - totalreserve_pages;
>  
>  	/*
>  	 * Not all the page cache can be freed, otherwise the system will
>  	 * start swapping. Assume at least half of the page cache, or the
>  	 * low watermark worth of cache, needs to stay.
>  	 */
> -	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
> +	pagecache = mi->pages[LRU_ACTIVE_FILE] + mi->pages[LRU_INACTIVE_FILE];
>  	pagecache -= min(pagecache / 2, wmark_low);
>  	available += pagecache;
>  
> @@ -5587,14 +5582,27 @@ long si_mem_available(void)
>  	 * items that are in use, and cannot be freed. Cap this estimate at the
>  	 * low watermark.
>  	 */
> -	reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) +
> -		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
> +	reclaimable = mi->slab_reclaimable + global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
>  	available += reclaimable - min(reclaimable / 2, wmark_low);
>  
>  	if (available < 0)
>  		available = 0;
>  	return available;
>  }
> +
> +long si_mem_available(void)
> +{
> +	struct meminfo mi;
> +	int lru;
> +
> +	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
> +		mi.pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
> +
> +	mi.si.freeram = global_zone_page_state(NR_FREE_PAGES);
> +	mi.slab_reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
> +
> +	return si_mem_available_mi(&mi);
> +}
>  EXPORT_SYMBOL_GPL(si_mem_available);
>  
>  void si_meminfo(struct sysinfo *val)
> -- 
> 2.29.3

-- 
Michal Hocko
SUSE Labs
