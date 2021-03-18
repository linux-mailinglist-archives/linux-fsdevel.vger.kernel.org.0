Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E331733FC19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 01:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCRANW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 20:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCRANS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:13:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC41964F0F;
        Thu, 18 Mar 2021 00:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616026398;
        bh=fSIIYD4Bqq9DjOcJ00I7RmGxvGVeisJfg5itiZrWuHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dx2142MJ4udauam6sy8vYa+l2BrMlHhDtLm82C5w2FxZOH+zh5poMNLBuOfjTH9PY
         YrH34VWJ6SNWpYYGs9v72EsDYsYYQnuXboQFKGsbIAwB9ciSYAOYU8G7sG2QLCW0Ch
         cWgTie2g1YKTddJEH6EuGC3OKB/UiaSCNKBGLdWA=
Date:   Wed, 17 Mar 2021 17:13:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: disable LRU pagevec during the migration
 temporarily
Message-Id: <20210317171316.d261de806203d8d99c6bf0ef@linux-foundation.org>
In-Reply-To: <20210310161429.399432-2-minchan@kernel.org>
References: <20210310161429.399432-1-minchan@kernel.org>
        <20210310161429.399432-2-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 10 Mar 2021 08:14:28 -0800 Minchan Kim <minchan@kernel.org> wrote:

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

This is really a rather ugly thing, particularly from a maintainability
point of view.  Are you sure you found all the sites which need the
enable/disable?  How do we prevent new ones from creeping in which need
the same treatment?  Is there some way of adding a runtime check which
will trip if a conversion was missed?

> ...
>
> +bool lru_cache_disabled(void)
> +{
> +	return atomic_read(&lru_disable_count);
> +}
> +
> +void lru_cache_enable(void)
> +{
> +	atomic_dec(&lru_disable_count);
> +}
> +
> +/*
> + * lru_cache_disable() needs to be called before we start compiling
> + * a list of pages to be migrated using isolate_lru_page().
> + * It drains pages on LRU cache and then disable on all cpus until
> + * lru_cache_enable is called.
> + *
> + * Must be paired with a call to lru_cache_enable().
> + */
> +void lru_cache_disable(void)
> +{
> +	atomic_inc(&lru_disable_count);
> +#ifdef CONFIG_SMP
> +	/*
> +	 * lru_add_drain_all in the force mode will schedule draining on
> +	 * all online CPUs so any calls of lru_cache_disabled wrapped by
> +	 * local_lock or preemption disabled would be ordered by that.
> +	 * The atomic operation doesn't need to have stronger ordering
> +	 * requirements because that is enforeced by the scheduling
> +	 * guarantees.
> +	 */
> +	__lru_add_drain_all(true);
> +#else
> +	lru_add_drain();
> +#endif
> +}

I guess at least the first two of these functions should be inlined.
