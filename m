Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA2731D6C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 10:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhBQJAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 04:00:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhBQJAn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 04:00:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613552395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9ZjUGZRskkZ0NzAW6UUH7ZF+ZkwTXUSHR0haHlwa+Y=;
        b=DGkoj1xr1pVVIdtvc1btoSO4zxqq1Jd5ow+34vyReiJF0smOdHRWzua1E+hcBUJAcqmhGF
        21kRdXV8V/d7ttjtb11zizK/bo+9gCMz3Bw5+RShP4BcEe4Sdi67Rn1VnqBdA1bzoYofB1
        lNUrZGoUO1MdNd5cc1LqWoMhT9jqaYs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 863F9B030;
        Wed, 17 Feb 2021 08:59:55 +0000 (UTC)
Date:   Wed, 17 Feb 2021 09:59:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
        joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
References: <20210216170348.1513483-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216170348.1513483-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-02-21 09:03:47, Minchan Kim wrote:
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

Please put some numbers on how often this happens here.

> The other concern is migration keeps retrying until pages in pagevec
> are drained. During the time, migration repeatedly allocates target
> page, unmap source page from page table of processes and then get to
> know the failure, restore the original page to pagetable of processes,
> free target page, which is also not good.

This is not good for performance you mean, rigth?
 
> To solve the issue, this patch tries to close the race rather than
> relying on retrial and luck. The idea is to introduce
> migration-in-progress tracking count with introducing IPI barrier
> after atomic updating the count to minimize read-side overhead.
>
> The migrate_prep increases migrate_pending_count under the lock
> and IPI call to guarantee every CPU see the uptodate value
> of migrate_pending_count. Then, drain pagevec via lru_add_drain_all.
> >From now on, no LRU pages could reach pagevec since LRU handling
> functions skips the batching if migration is in progress with checking
> migrate_pedning(IOW, pagevec should be empty until migration is done).
> Every migrate_prep's caller should call migrate_finish in pair to
> decrease the migration tracking count.

migrate_prep already does schedule draining on each cpu which has pages
queued. Why isn't it enough to disable pcp lru caches right before
draining in migrate_prep? More on IPI side below
 
[...]
> +static DEFINE_SPINLOCK(migrate_pending_lock);
> +static unsigned long migrate_pending_count;
> +static DEFINE_PER_CPU(struct work_struct, migrate_pending_work);
> +
> +static void read_migrate_pending(struct work_struct *work)
> +{
> +	/* TODO : not sure it's needed */
> +	unsigned long dummy = __READ_ONCE(migrate_pending_count);
> +	(void)dummy;

What are you trying to achieve here? Are you just trying to enforce read
memory barrier here?

> +}
> +
> +bool migrate_pending(void)
> +{
> +	return migrate_pending_count;
> +}
> +
>  /*
>   * migrate_prep() needs to be called before we start compiling a list of pages
>   * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
> @@ -64,11 +80,27 @@
>   */
>  void migrate_prep(void)
>  {
> +	unsigned int cpu;
> +
> +	spin_lock(&migrate_pending_lock);
> +	migrate_pending_count++;
> +	spin_unlock(&migrate_pending_lock);

I suspect you do not want to add atomic_read inside hot paths, right? Is
this really something that we have to microoptimize for? atomic_read is
a simple READ_ONCE on many archs.

> +
> +	for_each_online_cpu(cpu) {
> +		struct work_struct *work = &per_cpu(migrate_pending_work, cpu);
> +
> +		INIT_WORK(work, read_migrate_pending);
> +		queue_work_on(cpu, mm_percpu_wq, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(&per_cpu(migrate_pending_work, cpu));

I also do not follow this scheme. Where is the IPI you are mentioning
above?

> +	/*
> +	 * From now on, every online cpu will see uptodate
> +	 * migarte_pending_work.
> +	 */
>  	/*
>  	 * Clear the LRU lists so pages can be isolated.
> -	 * Note that pages may be moved off the LRU after we have
> -	 * drained them. Those pages will fail to migrate like other
> -	 * pages that may be busy.
>  	 */
>  	lru_add_drain_all();

Overall, this looks rather heavy weight to my taste. Have you tried to
play with a simple atomic counter approach? atomic_read when adding to
the cache and atomic_inc inside migrate_prep followed by lrdu_add_drain.
-- 
Michal Hocko
SUSE Labs
