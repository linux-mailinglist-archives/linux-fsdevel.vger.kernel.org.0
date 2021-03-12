Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689FA33873A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 09:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhCLIVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 03:21:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:55102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232183AbhCLIVn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:21:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615537302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Ux0+Pb2clKATA+9uJvqm/OvOlt7xzKyD+cErR9DPO4=;
        b=EJBuwLOaxbyFyLgDDgpljk5VUnrmwFhCrDLJcCfUQek16R4gG+FpsNdkrr1cFtBbJyEFKv
        g85L0NRHUq/BHX/53DyK7Kwh/WHCeh4+sTbQIObFLCjobFjxOCqLkxi/606X2LApInYZro
        KlOUz7gX7ufgWqvu2bJSyPl5/ABUDCA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E12DAF26;
        Fri, 12 Mar 2021 08:21:42 +0000 (UTC)
Date:   Fri, 12 Mar 2021 09:21:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YEsklV/Hvkwxqbxo@dhcp22.suse.cz>
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310161429.399432-2-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-03-21 08:14:28, Minchan Kim wrote:
> LRU pagevec holds refcount of pages until the pagevec are drained.
> It could prevent migration since the refcount of the page is greater
> than the expection in migration logic. To mitigate the issue,
> callers of migrate_pages drains LRU pagevec via migrate_prep or
> lru_add_drain_all before migrate_pages call.
> 
> However, it's not enough because pages coming into pagevec after the
> draining call still could stay at the pagevec so it could keep
> preventing page migration. Since some callers of migrate_pages have
> retrial logic with LRU draining, the page would migrate at next trail
> but it is still fragile in that it doesn't close the fundamental race
> between upcoming LRU pages into pagvec and migration so the migration
> failure could cause contiguous memory allocation failure in the end.
> 
> To close the race, this patch disables lru caches(i.e, pagevec)
> during ongoing migration until migrate is done.
> 
> Since it's really hard to reproduce, I measured how many times
> migrate_pages retried with force mode(it is about a fallback to a
> sync migration) with below debug code.
> 
> int migrate_pages(struct list_head *from, new_page_t get_new_page,
> 			..
> 			..
> 
> if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
>        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
>        dump_page(page, "fail to migrate");
> }
> 
> The test was repeating android apps launching with cma allocation
> in background every five seconds. Total cma allocation count was
> about 500 during the testing. With this patch, the dump_page count
> was reduced from 400 to 30.
> 
> The new interface is also useful for memory hotplug which currently
> drains lru pcp caches after each migration failure. This is rather
> suboptimal as it has to disrupt others running during the operation.
> With the new interface the operation happens only once. This is also in
> line with pcp allocator cache which are disabled for the offlining as
> well.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Looks goot to me
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks

-- 
Michal Hocko
SUSE Labs
