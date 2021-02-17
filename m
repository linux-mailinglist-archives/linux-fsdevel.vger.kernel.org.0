Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15F531D720
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 10:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhBQJvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 04:51:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:37088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhBQJvo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 04:51:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613555457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A8liV9LivvgJbefXJ55VyrMSp067sOf3ODYYksKOF1U=;
        b=vUF/7zLqOIqRO3nHFbLVor/ibH6SIiaLTRd3+Z+WlOYv/WpjYhGjkjIDAI+N2LQZmScOMy
        91aUHNP9DizHYPNHY8OIu+h5XNrlpC6KuxoZmT8YFFZgJW9aIrB97wCEMLoea/3cifM7sd
        skrLy8aV8Ymd4rwEaISTX5QXhPG4sFE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7079EB7A8;
        Wed, 17 Feb 2021 09:50:57 +0000 (UTC)
Date:   Wed, 17 Feb 2021 10:50:55 +0100
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
Message-ID: <YCzm/3GIy1EJlBi2@dhcp22.suse.cz>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-02-21 09:59:54, Michal Hocko wrote:
> On Tue 16-02-21 09:03:47, Minchan Kim wrote:
[...]
> >  /*
> >   * migrate_prep() needs to be called before we start compiling a list of pages
> >   * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
> > @@ -64,11 +80,27 @@
> >   */
> >  void migrate_prep(void)
> >  {
> > +	unsigned int cpu;
> > +
> > +	spin_lock(&migrate_pending_lock);
> > +	migrate_pending_count++;
> > +	spin_unlock(&migrate_pending_lock);
> 
> I suspect you do not want to add atomic_read inside hot paths, right? Is
> this really something that we have to microoptimize for? atomic_read is
> a simple READ_ONCE on many archs.

Or you rather wanted to prevent from read memory barrier to enfore the
ordering.

> > +
> > +	for_each_online_cpu(cpu) {
> > +		struct work_struct *work = &per_cpu(migrate_pending_work, cpu);
> > +
> > +		INIT_WORK(work, read_migrate_pending);
> > +		queue_work_on(cpu, mm_percpu_wq, work);
> > +	}
> > +
> > +	for_each_online_cpu(cpu)
> > +		flush_work(&per_cpu(migrate_pending_work, cpu));
> 
> I also do not follow this scheme. Where is the IPI you are mentioning
> above?

Thinking about it some more I think you mean the rescheduling IPI here?

> > +	/*
> > +	 * From now on, every online cpu will see uptodate
> > +	 * migarte_pending_work.
> > +	 */
> >  	/*
> >  	 * Clear the LRU lists so pages can be isolated.
> > -	 * Note that pages may be moved off the LRU after we have
> > -	 * drained them. Those pages will fail to migrate like other
> > -	 * pages that may be busy.
> >  	 */
> >  	lru_add_drain_all();
> 
> Overall, this looks rather heavy weight to my taste. Have you tried to
> play with a simple atomic counter approach? atomic_read when adding to
> the cache and atomic_inc inside migrate_prep followed by lrdu_add_drain.

If you really want a strong ordering then it should be sufficient to
simply alter lru_add_drain_all to force draining all CPUs. This will
make sure no new pages are added to the pcp lists and you will also sync
up anything that has accumulated because of a race between atomic_read
and inc:
diff --git a/mm/swap.c b/mm/swap.c
index 2cca7141470c..91600d7bb7a8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -745,7 +745,7 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
  * Calling this function with cpu hotplug locks held can actually lead
  * to obscure indirect dependencies via WQ context.
  */
-void lru_add_drain_all(void)
+void lru_add_drain_all(bool force_all_cpus)
 {
 	/*
 	 * lru_drain_gen - Global pages generation number
@@ -820,7 +820,8 @@ void lru_add_drain_all(void)
 	for_each_online_cpu(cpu) {
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
-		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
+		if (force_all_cpus ||
+		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
 		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
 		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
-- 
Michal Hocko
SUSE Labs
