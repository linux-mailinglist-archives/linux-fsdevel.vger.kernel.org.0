Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E0C2DAE12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 14:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgLONgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 08:36:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:45814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbgLONgB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:36:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608039314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0ZZlFIFNjZLjI1zJKZsoEml0sOwnDtgK026kYKenBI=;
        b=Z6ZxxODUV2XHWmRmYCV1o9D/nJq+SiPOW/aVOWIkMz7l8JSXApKVfT7woLR4dunzRE3lHN
        bXNP2YJ/wA77wTuYlDWHXlsn7YrOnOYBxfsmB3r0/ill/VsLwPkkVG+GZK8GpOcIsm4WT6
        EsTvSABPjTzw/lP1Dj2nyEqnl2U4TGA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 632F9AF45;
        Tue, 15 Dec 2020 13:35:14 +0000 (UTC)
Date:   Tue, 15 Dec 2020 14:35:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 7/7] mm: memcontrol: make the slab calculation
 consistent
Message-ID: <20201215133514.GP32193@dhcp22.suse.cz>
References: <20201208041847.72122-1-songmuchun@bytedance.com>
 <20201208041847.72122-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208041847.72122-8-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-12-20 12:18:47, Muchun Song wrote:
> Although the ratio of the slab is one, we also should read the ratio
> from the related memory_stats instead of hard-coding. And the local
> variable of size is already the value of slab_unreclaimable. So we
> do not need to read again.
>
> We can drop the ratio in struct memory_stat. This can make the code
> clean and simple. And get rid of the awkward mix of static and runtime
> initialization of the memory_stats table.

This changelog doesn't explain, what is the problem, why do we care and
why the additional code is worthwile.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 112 ++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 73 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a40797a27f87..841ea37cc123 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1511,49 +1511,78 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
>  
>  struct memory_stat {
>  	const char *name;
> -	unsigned int ratio;
>  	unsigned int idx;
>  };
>  
>  static const struct memory_stat memory_stats[] = {
> -	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
> -	{ "file", PAGE_SIZE, NR_FILE_PAGES },
> -	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> -	{ "pagetables", PAGE_SIZE, NR_PAGETABLE },
> -	{ "percpu", 1, MEMCG_PERCPU_B },
> -	{ "sock", PAGE_SIZE, MEMCG_SOCK },
> -	{ "shmem", PAGE_SIZE, NR_SHMEM },
> -	{ "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> -	{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> -	{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> +	{ "anon",			NR_ANON_MAPPED			},
> +	{ "file",			NR_FILE_PAGES			},
> +	{ "kernel_stack",		NR_KERNEL_STACK_KB		},
> +	{ "pagetables",			NR_PAGETABLE			},
> +	{ "percpu",			MEMCG_PERCPU_B			},
> +	{ "sock",			MEMCG_SOCK			},
> +	{ "shmem",			NR_SHMEM			},
> +	{ "file_mapped",		NR_FILE_MAPPED			},
> +	{ "file_dirty",			NR_FILE_DIRTY			},
> +	{ "file_writeback",		NR_WRITEBACK			},
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
> -	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
> -	{ "shmem_thp", PAGE_SIZE, NR_SHMEM_THPS },
> +	{ "anon_thp",			NR_ANON_THPS			},
> +	{ "file_thp",			NR_FILE_THPS			},
> +	{ "shmem_thp",			NR_SHMEM_THPS			},
>  #endif
> -	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> -	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> -	{ "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> -	{ "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> -	{ "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> -
> -	/*
> -	 * Note: The slab_reclaimable and slab_unreclaimable must be
> -	 * together and slab_reclaimable must be in front.
> -	 */
> -	{ "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> -	{ "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> +	{ "inactive_anon",		NR_INACTIVE_ANON		},
> +	{ "active_anon",		NR_ACTIVE_ANON			},
> +	{ "inactive_file",		NR_INACTIVE_FILE		},
> +	{ "active_file",		NR_ACTIVE_FILE			},
> +	{ "unevictable",		NR_UNEVICTABLE			},
> +	{ "slab_reclaimable",		NR_SLAB_RECLAIMABLE_B		},
> +	{ "slab_unreclaimable",		NR_SLAB_UNRECLAIMABLE_B		},
>  
>  	/* The memory events */
> -	{ "workingset_refault_anon", 1, WORKINGSET_REFAULT_ANON },
> -	{ "workingset_refault_file", 1, WORKINGSET_REFAULT_FILE },
> -	{ "workingset_activate_anon", 1, WORKINGSET_ACTIVATE_ANON },
> -	{ "workingset_activate_file", 1, WORKINGSET_ACTIVATE_FILE },
> -	{ "workingset_restore_anon", 1, WORKINGSET_RESTORE_ANON },
> -	{ "workingset_restore_file", 1, WORKINGSET_RESTORE_FILE },
> -	{ "workingset_nodereclaim", 1, WORKINGSET_NODERECLAIM },
> +	{ "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
> +	{ "workingset_refault_file",	WORKINGSET_REFAULT_FILE		},
> +	{ "workingset_activate_anon",	WORKINGSET_ACTIVATE_ANON	},
> +	{ "workingset_activate_file",	WORKINGSET_ACTIVATE_FILE	},
> +	{ "workingset_restore_anon",	WORKINGSET_RESTORE_ANON		},
> +	{ "workingset_restore_file",	WORKINGSET_RESTORE_FILE		},
> +	{ "workingset_nodereclaim",	WORKINGSET_NODERECLAIM		},
>  };
>  
> +/* Translate stat items to the correct unit for memory.stat output */
> +static int memcg_page_state_unit(int item)
> +{
> +	int unit;
> +
> +	switch (item) {
> +	case MEMCG_PERCPU_B:
> +	case NR_SLAB_RECLAIMABLE_B:
> +	case NR_SLAB_UNRECLAIMABLE_B:
> +	case WORKINGSET_REFAULT_ANON:
> +	case WORKINGSET_REFAULT_FILE:
> +	case WORKINGSET_ACTIVATE_ANON:
> +	case WORKINGSET_ACTIVATE_FILE:
> +	case WORKINGSET_RESTORE_ANON:
> +	case WORKINGSET_RESTORE_FILE:
> +	case WORKINGSET_NODERECLAIM:
> +		unit = 1;
> +		break;
> +	case NR_KERNEL_STACK_KB:
> +		unit = SZ_1K;
> +		break;
> +	default:
> +		unit = PAGE_SIZE;
> +		break;
> +	}
> +
> +	return unit;
> +}
> +
> +static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
> +						    int item)
> +{
> +	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
> +}
> +
>  static char *memory_stat_format(struct mem_cgroup *memcg)
>  {
>  	struct seq_buf s;
> @@ -1577,13 +1606,12 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>  		u64 size;
>  
> -		size = memcg_page_state(memcg, memory_stats[i].idx);
> -		size *= memory_stats[i].ratio;
> +		size = memcg_page_state_output(memcg, memory_stats[i].idx);
>  		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
>  
>  		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
> -			size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
> -			       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
> +			size += memcg_page_state_output(memcg,
> +							NR_SLAB_RECLAIMABLE_B);
>  			seq_buf_printf(&s, "slab %llu\n", size);
>  		}
>  	}
> @@ -6377,6 +6405,12 @@ static int memory_stat_show(struct seq_file *m, void *v)
>  }
>  
>  #ifdef CONFIG_NUMA
> +static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
> +						     int item)
> +{
> +	return lruvec_page_state(lruvec, item) * memcg_page_state_unit(item);
> +}
> +
>  static int memory_numa_stat_show(struct seq_file *m, void *v)
>  {
>  	int i;
> @@ -6394,8 +6428,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
>  			struct lruvec *lruvec;
>  
>  			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> -			size = lruvec_page_state(lruvec, memory_stats[i].idx);
> -			size *= memory_stats[i].ratio;
> +			size = lruvec_page_state_output(lruvec,
> +							memory_stats[i].idx);
>  			seq_printf(m, " N%d=%llu", nid, size);
>  		}
>  		seq_putc(m, '\n');
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
