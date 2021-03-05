Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6681232EFA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 17:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhCEQGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 11:06:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:45076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhCEQGT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:06:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614960378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KaVkVhRkdIPeBEfcZK2BZahxFa1648i+OZhY5tS4IkY=;
        b=kinwnXlFoqC2i/vX+HThGlOYJeXAMp+xYZkoErq4bFuwLPcfQJeQWN8No6wddf499EEUVC
        lm7WURMddPIFC0AeSCn8+mczXsdt+HZ3FPIb1hOGVrDtnIEvsn+DZtLna8RS9gTKlqxWNq
        hme3madqe5qteeuNCXfCkH+u0o2aAyM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFDEBACCF;
        Fri,  5 Mar 2021 16:06:17 +0000 (UTC)
Date:   Fri, 5 Mar 2021 17:06:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YEJW+dzF9/BNIiqn@dhcp22.suse.cz>
References: <20210302210949.2440120-1-minchan@kernel.org>
 <YD+F4LgPH0zMBDGW@dhcp22.suse.cz>
 <YD/wOq3lf9I5HK85@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD/wOq3lf9I5HK85@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 03-03-21 12:23:22, Minchan Kim wrote:
> On Wed, Mar 03, 2021 at 01:49:36PM +0100, Michal Hocko wrote:
> > On Tue 02-03-21 13:09:48, Minchan Kim wrote:
> > > LRU pagevec holds refcount of pages until the pagevec are drained.
> > > It could prevent migration since the refcount of the page is greater
> > > than the expection in migration logic. To mitigate the issue,
> > > callers of migrate_pages drains LRU pagevec via migrate_prep or
> > > lru_add_drain_all before migrate_pages call.
> > > 
> > > However, it's not enough because pages coming into pagevec after the
> > > draining call still could stay at the pagevec so it could keep
> > > preventing page migration. Since some callers of migrate_pages have
> > > retrial logic with LRU draining, the page would migrate at next trail
> > > but it is still fragile in that it doesn't close the fundamental race
> > > between upcoming LRU pages into pagvec and migration so the migration
> > > failure could cause contiguous memory allocation failure in the end.
> > > 
> > > To close the race, this patch disables lru caches(i.e, pagevec)
> > > during ongoing migration until migrate is done.
> > > 
> > > Since it's really hard to reproduce, I measured how many times
> > > migrate_pages retried with force mode below debug code.
> > > 
> > > int migrate_pages(struct list_head *from, new_page_t get_new_page,
> > > 			..
> > > 			..
> > > 
> > > if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
> > >        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
> > >        dump_page(page, "fail to migrate");
> > > }
> > > 
> > > The test was repeating android apps launching with cma allocation
> > > in background every five seconds. Total cma allocation count was
> > > about 500 during the testing. With this patch, the dump_page count
> > > was reduced from 400 to 30.
> > 
> > Have you seen any improvement on the CMA allocation success rate?
> 
> Unfortunately, the cma alloc failure rate with reasonable margin
> of error is really hard to reproduce under real workload.
> That's why I measured the soft metric instead of direct cma fail
> under real workload(I don't want to make some adhoc artificial
> benchmark and keep tunes system knobs until it could show 
> extremly exaggerated result to convice patch effect).
> 
> Please say if you belive this work is pointless unless there is
> stable data under reproducible scenario. I am happy to drop it.

Well, I am not saying that this is pointless. In the end the resulting
change is relatively small and it provides a useful functionality for
other users (e.g. hotplug). That should be a sufficient justification.

I was asking about CMA allocation success rate because that is a much
more reasonable metric than how many times something has retried because
retries can help to increase success rate and the patch doesn't really
remove those. If you want to use number of retries as a metric then the
average allocation latency would be more meaningful.
-- 
Michal Hocko
SUSE Labs
