Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9C1CF920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 17:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgELP1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 11:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgELP1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 11:27:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA17C061A0C;
        Tue, 12 May 2020 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=0o6dVNg9znzcukghDI8w+W/ZJ8g4B3rZRt84WXfDJ6c=; b=qid5QeziBRaVfqMBDyUCBGgDpI
        /gF4sMtm3dRw8LjoA63J+wVFfLD3dsqePrw16fUSSYGDnVoBhu5KrEpY1j0bhTFF30jtZmGTLE9bM
        p2w7JB6I9TvRiWBLg9FoZyzGvoseM/YkgM4KU+kxIGAVTvI4YLqHT+LcVxKMpWnBStdRVSqEukak7
        mdJMblA9cqMezoVZqxuCN+PCIk2PhL3ZQQGztYGOCy9UeAjdbBic7tsoEKQqavyS7NszdHbK2FJIM
        Uj+Y6CY+lZiFt01TbKVo9phwsXK4dseELaXRyYvpoNPZbiuVbV5BcoEz0W0pA3J8muluAtiYobjFe
        39FlXhgw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYWob-0000js-Ob; Tue, 12 May 2020 15:27:34 +0000
Subject: Re: mmotm 2020-05-11-15-43 uploaded (mm/memcontrol.c, huge pages)
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20200511224430.HDJjRC68z%akpm@linux-foundation.org>
 <3b612c3e-ce52-ba92-eb02-0fa7fd38819f@infradead.org>
 <20200512121750.GA397968@cmpxchg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bc0af588-3591-1372-ac44-27404ee79ff9@infradead.org>
Date:   Tue, 12 May 2020 08:27:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512121750.GA397968@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/20 5:17 AM, Johannes Weiner wrote:

> 
> ---
> 
> Randy reports:
> 
>> on x86_64:
>>
>> In file included from ../arch/x86/include/asm/atomic.h:5:0,
>>                  from ../include/linux/atomic.h:7,
>>                  from ../include/linux/page_counter.h:5,
>>                  from ../mm/memcontrol.c:25:
>> ../mm/memcontrol.c: In function ‘memcg_stat_show’:
>> ../include/linux/compiler.h:394:38: error: call to ‘__compiletime_assert_383’ declared with attribute error: BUILD_BUG failed
>>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>                                       ^
>> ../include/linux/compiler.h:375:4: note: in definition of macro ‘__compiletime_assert’
>>     prefix ## suffix();    \
>>     ^~~~~~
>> ../include/linux/compiler.h:394:2: note: in expansion of macro ‘_compiletime_assert’
>>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>   ^~~~~~~~~~~~~~~~~~~
>> ../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
>>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>                                      ^~~~~~~~~~~~~~~~~~
>> ../include/linux/build_bug.h:59:21: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
>>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>                      ^~~~~~~~~~~~~~~~
>> ../include/linux/huge_mm.h:319:28: note: in expansion of macro ‘BUILD_BUG’
>>  #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> 
> The THP page size macros are CONFIG_TRANSPARENT_HUGEPAGE only.
> 
> We already ifdef most THP-related code in memcg, but not these
> particular stats. Memcg used to track the pages as they came in, and
> PageTransHuge() + hpage_nr_pages() work when THP is not compiled in.
> 
> Switching to native vmstat counters, memcg doesn't see the pages, it
> only gets a count of THPs. To translate that to bytes, it has to know
> how big the THPs are - and that's only available for CONFIG_THP.
> 
> Add the necessary ifdefs. /proc/meminfo, smaps etc. also don't show
> the THP counters when the feature is compiled out. The event counts
> (THP_FAULT_ALLOC, THP_COLLAPSE_ALLOC) were already conditional also.
> 
> Style touchup: HPAGE_PMD_NR * PAGE_SIZE is silly. Use HPAGE_PMD_SIZE.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 738d071ba1ef..47c685088a2c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1401,9 +1401,11 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  		       (u64)memcg_page_state(memcg, NR_WRITEBACK) *
>  		       PAGE_SIZE);
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	seq_buf_printf(&s, "anon_thp %llu\n",
>  		       (u64)memcg_page_state(memcg, NR_ANON_THPS) *
> -		       HPAGE_PMD_NR * PAGE_SIZE);
> +		       HPAGE_PMD_SIZE);
> +#endif
>  
>  	for (i = 0; i < NR_LRU_LISTS; i++)
>  		seq_buf_printf(&s, "%s %llu\n", lru_list_name(i),
> @@ -3752,7 +3754,9 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  static const unsigned int memcg1_stats[] = {
>  	NR_FILE_PAGES,
>  	NR_ANON_MAPPED,
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	NR_ANON_THPS,
> +#endif
>  	NR_SHMEM,
>  	NR_FILE_MAPPED,
>  	NR_FILE_DIRTY,
> @@ -3763,7 +3767,9 @@ static const unsigned int memcg1_stats[] = {
>  static const char *const memcg1_stat_names[] = {
>  	"cache",
>  	"rss",
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	"rss_huge",
> +#endif
>  	"shmem",
>  	"mapped_file",
>  	"dirty",
> @@ -3794,8 +3800,10 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
>  			continue;
>  		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  		if (memcg1_stats[i] == NR_ANON_THPS)
>  			nr *= HPAGE_PMD_NR;
> +#endif
>  		seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
>  	}
>  
> 


-- 
~Randy
