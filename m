Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0776250B74B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447489AbiDVMa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiDVMa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:30:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6806056C27;
        Fri, 22 Apr 2022 05:28:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0F6FC1F745;
        Fri, 22 Apr 2022 12:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650630484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NFjKDOpABJHRIxw0TYxlJyyUYk2rVUx2NABXdGw59hw=;
        b=eU+jKeekea5RxUZW6HIGzmrZC40OwawfZ3nKfEqK7FH/3dj9Sz+68uCxba2WFY+ULD/oPH
        KlhAFBKDTe+13b9sHBqxXNmknfWppxSfzXutPvXO9p3+Qc4TgRxXPpVlOOjFv77Wmz9z96
        xt5a51+F5BQOAlvQfmmtvCe2xb+etA8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD12A2C141;
        Fri, 22 Apr 2022 12:28:03 +0000 (UTC)
Date:   Fri, 22 Apr 2022 14:28:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev
Subject: Re: [PATCH v2 3/8] mm/memcontrol.c: Convert to printbuf
Message-ID: <YmKfU20B5GIS1e3v@dhcp22.suse.cz>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-9-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421234837.3629927-9-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-04-22 19:48:32, Kent Overstreet wrote:
> This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
> simalar to seq_buf except that it heap allocates the string buffer:
> here, we were already heap allocating the buffer with kmalloc() so the
> conversion is trivial.

What is the advantage of changing a well tested seq_buf with a different
way to do the same thing here?

I do not see this to be a noticeable simplification of the existing
code. The only advantage I can see is that the string storage allocation
is implicit and it would expand in case we ever overflow over a single
page. But is this really worth the code churn?

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  mm/memcontrol.c | 68 ++++++++++++++++++++++++-------------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 36e9f38c91..4cb0b7bc1c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -61,7 +61,7 @@
>  #include <linux/file.h>
>  #include <linux/tracehook.h>
>  #include <linux/psi.h>
> -#include <linux/seq_buf.h>
> +#include <linux/printbuf.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -1436,13 +1436,9 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
>  
>  static char *memory_stat_format(struct mem_cgroup *memcg)
>  {
> -	struct seq_buf s;
> +	struct printbuf buf = PRINTBUF;
>  	int i;
>  
> -	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> -	if (!s.buffer)
> -		return NULL;
> -
>  	/*
>  	 * Provide statistics on the state of the memory subsystem as
>  	 * well as cumulative event counters that show past behavior.
> @@ -1459,49 +1455,51 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  		u64 size;
>  
>  		size = memcg_page_state_output(memcg, memory_stats[i].idx);
> -		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
> +		pr_buf(&buf, "%s %llu\n", memory_stats[i].name, size);
>  
>  		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
>  			size += memcg_page_state_output(memcg,
>  							NR_SLAB_RECLAIMABLE_B);
> -			seq_buf_printf(&s, "slab %llu\n", size);
> +			pr_buf(&buf, "slab %llu\n", size);
>  		}
>  	}
>  
>  	/* Accumulated memory events */
>  
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
> -		       memcg_events(memcg, PGFAULT));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
> -		       memcg_events(memcg, PGMAJFAULT));
> -	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
> -		       memcg_events(memcg, PGREFILL));
> -	seq_buf_printf(&s, "pgscan %lu\n",
> -		       memcg_events(memcg, PGSCAN_KSWAPD) +
> -		       memcg_events(memcg, PGSCAN_DIRECT));
> -	seq_buf_printf(&s, "pgsteal %lu\n",
> -		       memcg_events(memcg, PGSTEAL_KSWAPD) +
> -		       memcg_events(memcg, PGSTEAL_DIRECT));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
> -		       memcg_events(memcg, PGACTIVATE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
> -		       memcg_events(memcg, PGDEACTIVATE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREE),
> -		       memcg_events(memcg, PGLAZYFREE));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
> -		       memcg_events(memcg, PGLAZYFREED));
> +	pr_buf(&buf, "%s %lu\n", vm_event_name(PGFAULT),
> +	       memcg_events(memcg, PGFAULT));
> +	pr_buf(&buf, "%s %lu\n", vm_event_name(PGMAJFAULT),
> +	       memcg_events(memcg, PGMAJFAULT));
> +	pr_buf(&buf, "%s %lu\n",  vm_event_name(PGREFILL),
> +	       memcg_events(memcg, PGREFILL));
> +	pr_buf(&buf, "pgscan %lu\n",
> +	       memcg_events(memcg, PGSCAN_KSWAPD) +
> +	       memcg_events(memcg, PGSCAN_DIRECT));
> +	pr_buf(&buf, "pgsteal %lu\n",
> +	       memcg_events(memcg, PGSTEAL_KSWAPD) +
> +	       memcg_events(memcg, PGSTEAL_DIRECT));
> +	pr_buf(&buf, "%s %lu\n", vm_event_name(PGACTIVATE),
> +	       memcg_events(memcg, PGACTIVATE));
> +	pr_buf(&buf, "%s %lu\n", vm_event_name(PGDEACTIVATE),
> +	       memcg_events(memcg, PGDEACTIVATE));
> +	pr_buf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREE),
> +	       memcg_events(memcg, PGLAZYFREE));
> +	pr_buf(&buf, "%s %lu\n", vm_event_name(PGLAZYFREED),
> +	       memcg_events(memcg, PGLAZYFREED));
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
> -		       memcg_events(memcg, THP_FAULT_ALLOC));
> -	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
> -		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
> +	pr_buf(&buf, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
> +	       memcg_events(memcg, THP_FAULT_ALLOC));
> +	pr_buf(&buf, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
> +	       memcg_events(memcg, THP_COLLAPSE_ALLOC));
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -	/* The above should easily fit into one page */
> -	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
> +	if (buf.allocation_failure) {
> +		printbuf_exit(&buf);
> +		return NULL;
> +	}
>  
> -	return s.buffer;
> +	return buf.buf;
>  }
>  
>  #define K(x) ((x) << (PAGE_SHIFT-10))
> -- 
> 2.35.2

-- 
Michal Hocko
SUSE Labs
