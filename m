Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D167531E0B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 21:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhBQUrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 15:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhBQUrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:47:03 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB19C061756;
        Wed, 17 Feb 2021 12:46:23 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b21so9250225pgk.7;
        Wed, 17 Feb 2021 12:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZc4B1Q+CyiqJeSdeG8prgrIa3xPgvflOEqHMjO6o+M=;
        b=AOfPcWXA6GijbuuBhcd0OQi2XAulVffyK1tW9ESBXDo9rZGO0tOeMTBKN4pCb1lf5d
         dwWg6KYCrWPtBLskgtvuPuuCsqfkNuAmc+vXkLlLycM8jb/vRvK4xsv6nt4Gb2eE914y
         dPRBx1JS5SWr7ubelK+jm5BhaZykbp9dUPLr7mK7jEs6IY1cchDVu3cFmWUrYhx0uYYv
         Sb3PBdF4N6sZ5DcM7oCf7VEEVDdBCxysxn9J3IfkNf/dMRgeYfurB6XY814KFS2hjxtF
         FjlX3xXjTYmuPmAutjDvbCaAmh+pFLMJ0nZtKB+G0gkkYcympq5znzO49+Bb6bo9KF21
         jN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iZc4B1Q+CyiqJeSdeG8prgrIa3xPgvflOEqHMjO6o+M=;
        b=WuJ2ZQdiFmk7Fp7sJoc8M+IcdxF2zBem7QcY/1vLtEQFc3DNc2TQqSLKraag3YDwXB
         p9mRpKhfsRJo0FGZcfIXu5fOZ/SF8vQM3ZE3ZBwglGENs5cOly3JAF9i/MfU2QUf6bXs
         pcwJ/0gGTj4eYOMRWdeqi8pzh0Q81eL7RCImtP6HstEbw77STz062wQeRsklew2HRUZE
         dHzTT0O3P4vRxOPFY8/wWdI5H02w5CNFJDgfHuL38xx3UMQbpG9kM3EZ0ZUrfJ5ccv9O
         6rV0VYflCqIFH7uy7udcRK35VZxOepz0StuKrukJa0GNU+yxB83BJnSELGxWeLyRArOw
         BbTw==
X-Gm-Message-State: AOAM530l8QKBVrD4q1NSd6cjKZTaLneJqK80FmmFhy8G3wYi9+uKP2d+
        U9mnyQrNaTWncHOkqbb2LJk=
X-Google-Smtp-Source: ABdhPJzd0t0ssx9imTZeL1PNQQRheMmXcRqEKUZylWCcKhSdmThJOFFFPTC66D/+pUIxSc6A6k+7Vw==
X-Received: by 2002:a62:7fcb:0:b029:1da:36b1:8ac7 with SMTP id a194-20020a627fcb0000b02901da36b18ac7mr1063900pfd.13.1613594782422;
        Wed, 17 Feb 2021 12:46:22 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id x9sm3321738pfc.114.2021.02.17.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:46:21 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Feb 2021 12:46:19 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
        joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YC2Am34Fso5Y5SPC@google.com>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:59:54AM +0100, Michal Hocko wrote:
> On Tue 16-02-21 09:03:47, Minchan Kim wrote:
> > LRU pagevec holds refcount of pages until the pagevec are drained.
> > It could prevent migration since the refcount of the page is greater
> > than the expection in migration logic. To mitigate the issue,
> > callers of migrate_pages drains LRU pagevec via migrate_prep or
> > lru_add_drain_all before migrate_pages call.
> > 
> > However, it's not enough because pages coming into pagevec after the
> > draining call still could stay at the pagevec so it could keep
> > preventing page migration. Since some callers of migrate_pages have
> > retrial logic with LRU draining, the page would migrate at next trail
> > but it is still fragile in that it doesn't close the fundamental race
> > between upcoming LRU pages into pagvec and migration so the migration
> > failure could cause contiguous memory allocation failure in the end.
> 
> Please put some numbers on how often this happens here.

Actually, it's hard to get real number of cma allocation failure
since we didn't introduce any cma allocation statistics.
I am working on it to make the failure more visible.
https://lore.kernel.org/linux-mm/20210217170025.512704-1-minchan@kernel.org/

Having said, the cma allocation failure is one of the most common bug
reporting from field test I got periodically. I couldn't say they all
comes from pagevec issue since it's *really hard* to get who was the long
time holder of additional refcount at the moment. However, I kept tracking
down pinner from drivers and resolved them but the problem is still
reported and saw pagevec is one of common place to hold additional
refcount. 

I think data below is not exact one you want to see but that's the
way how I could see how this patch effectives reduce vulnerability.

Quote from Matthew quesiton
````
What I measured was how many times migrate_pages retried with force mode
below debug code.
The test was android apps launching with cma allocation in background.
Total cma allocation count was about 500 during the entire testing
and have seen about 400 retrial with below debug code.
With this patchset(with bug fix), the retrial count was reduced under 30.

What I measured was how many times the migrate_pages
diff --git a/mm/migrate.c b/mm/migrate.c
index 04a98bb2f568..caa661be2d16 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1459,6 +1459,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
                                                private, page, pass > 2, mode,
                                                reason);

+                       if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
+                               printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
+                               dump_page(page, "fail to migrate");
+                       }
+

```

IMO, rather than relying on retrial, it would be better if we close
such race from the beginning like free memory isolation logic in
start_isolate_page_range. Furthmore, migrate_pending function
will provide a way to detect migration-in-progress other vulnerable
places in future.

> 
> > The other concern is migration keeps retrying until pages in pagevec
> > are drained. During the time, migration repeatedly allocates target
> > page, unmap source page from page table of processes and then get to
> > know the failure, restore the original page to pagetable of processes,
> > free target page, which is also not good.
> 
> This is not good for performance you mean, rigth?

It's not good for allocation latency as well as performance but
it's not a top reason for this work. Goal is mostly focus on
closing the race to reduce pontential sites to migration failure
for CMA.

>  
> > To solve the issue, this patch tries to close the race rather than
> > relying on retrial and luck. The idea is to introduce
> > migration-in-progress tracking count with introducing IPI barrier
> > after atomic updating the count to minimize read-side overhead.
> >
> > The migrate_prep increases migrate_pending_count under the lock
> > and IPI call to guarantee every CPU see the uptodate value
> > of migrate_pending_count. Then, drain pagevec via lru_add_drain_all.
> > >From now on, no LRU pages could reach pagevec since LRU handling
> > functions skips the batching if migration is in progress with checking
> > migrate_pedning(IOW, pagevec should be empty until migration is done).
> > Every migrate_prep's caller should call migrate_finish in pair to
> > decrease the migration tracking count.
> 
> migrate_prep already does schedule draining on each cpu which has pages
> queued. Why isn't it enough to disable pcp lru caches right before
> draining in migrate_prep? More on IPI side below

Yub, with simple tweak of lru_add_drain_all(bool disable) and queue
it for every CPU, it would work.

>  
> [...]
> > +static DEFINE_SPINLOCK(migrate_pending_lock);
> > +static unsigned long migrate_pending_count;
> > +static DEFINE_PER_CPU(struct work_struct, migrate_pending_work);
> > +
> > +static void read_migrate_pending(struct work_struct *work)
> > +{
> > +	/* TODO : not sure it's needed */
> > +	unsigned long dummy = __READ_ONCE(migrate_pending_count);
> > +	(void)dummy;
> 
> What are you trying to achieve here? Are you just trying to enforce read
> memory barrier here?

I though IPI by migrate_pending_work will guarantee the memory ordering
so it wouldn't be needed but wanted to get attention from reviewer.
If it's not needed, I will drop it.

> 
> > +}
> > +
> > +bool migrate_pending(void)
> > +{
> > +	return migrate_pending_count;
> > +}
> > +
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

It's also spin_lock_irq_save in some arch. If the new synchonization is
heavily compilcated, atomic would be better for simple start but I thought
this locking scheme is too simple so no need to add atomic operation in
readside.
