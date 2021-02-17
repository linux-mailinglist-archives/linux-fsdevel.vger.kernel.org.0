Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1F31E0D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhBQUwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 15:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhBQUwJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:52:09 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC3DC061574;
        Wed, 17 Feb 2021 12:51:29 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so9202238pfg.11;
        Wed, 17 Feb 2021 12:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZ2YDaTrQUxNgyjPGXSCzsEOssMhFQi4w5yssr+wN8k=;
        b=I1c4pAWQOn9X4rC/3iGQL9deLcILN/k6imqe10/rBbzJ/3WSxHT3GF7uobSkL04iQa
         eok36l37EBjUSYf37Bhk7oSa51YMfDPlFZkygZNt8XAFnNBRcW095uU843fXf7OA0Cpv
         Jo+bMyKH6X2QaB8M7apZsIWDExwZLludz7dUl+vwlpF7hgOUm0DXAsrxL/HSSUYf1tvT
         lZtVhHzRZz4uEn51WoZ2KW3XN5GSCws6J8dTZHt53HclTSLPSu2xsxvIrwElKnLAfpMl
         dTP/EThr22TufBqiqjgK1zFw+p//bk9Cf5gHDvqbAZ9p/vjC5w4UNIkfXgWNvGgK/YhN
         3I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KZ2YDaTrQUxNgyjPGXSCzsEOssMhFQi4w5yssr+wN8k=;
        b=tp0oJ420hNI5DEtrdRzDBaF1OOv4ljxzor0Qi/EdAi/15u0X2Iho+rEcNMur9NRkjS
         SEzSfoRDHnfUCv6XovWd6rr5zqqu3piiudh321kfmAjU6ljy+z6oZwd/uANH0tAUFHiW
         Ctvs60qIgIrc9ZCZHpMsa3SigvmogAQA4OGeUdQss4TdfIw+dQM6CpN/oyVxqAkIbXEd
         nAniuVP3nPHExF8ncHFqkLenj5JcoYwmQ+MvznAv6l7qXlS0SX6XyKxH4FePzdbLQC/k
         T0l6+Y4AxL3gjz2BY5uErt+L+o9ADYjlvY7MHbvb7EUxk1Y2xBelIG2TfhAsDnF3pNXB
         7bIw==
X-Gm-Message-State: AOAM531qWGSjoGSX2VE8prUoY+LvaHW738VSfAJPcYdMI5fywdQ6ebB9
        pyKdDNsEDZ9HcA95exvYasE=
X-Google-Smtp-Source: ABdhPJxajiR0XpFqMA+nXwR2lha7uU9OOxH9cyx53NpuErp3m0XGQO+tHGLlfnF9013gT7e7wQHP+g==
X-Received: by 2002:a63:cd41:: with SMTP id a1mr1024554pgj.177.1613595089015;
        Wed, 17 Feb 2021 12:51:29 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id r13sm3646734pfc.198.2021.02.17.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:51:27 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Feb 2021 12:51:25 -0800
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
Message-ID: <YC2BzdHxF0xEdNxH@google.com>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YCzm/3GIy1EJlBi2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCzm/3GIy1EJlBi2@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 10:50:55AM +0100, Michal Hocko wrote:
> On Wed 17-02-21 09:59:54, Michal Hocko wrote:
> > On Tue 16-02-21 09:03:47, Minchan Kim wrote:
> [...]
> > >  /*
> > >   * migrate_prep() needs to be called before we start compiling a list of pages
> > >   * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
> > > @@ -64,11 +80,27 @@
> > >   */
> > >  void migrate_prep(void)
> > >  {
> > > +	unsigned int cpu;
> > > +
> > > +	spin_lock(&migrate_pending_lock);
> > > +	migrate_pending_count++;
> > > +	spin_unlock(&migrate_pending_lock);
> > 
> > I suspect you do not want to add atomic_read inside hot paths, right? Is
> > this really something that we have to microoptimize for? atomic_read is
> > a simple READ_ONCE on many archs.
> 
> Or you rather wanted to prevent from read memory barrier to enfore the
> ordering.

Yub.

> 
> > > +
> > > +	for_each_online_cpu(cpu) {
> > > +		struct work_struct *work = &per_cpu(migrate_pending_work, cpu);
> > > +
> > > +		INIT_WORK(work, read_migrate_pending);
> > > +		queue_work_on(cpu, mm_percpu_wq, work);
> > > +	}
> > > +
> > > +	for_each_online_cpu(cpu)
> > > +		flush_work(&per_cpu(migrate_pending_work, cpu));
> > 
> > I also do not follow this scheme. Where is the IPI you are mentioning
> > above?
> 
> Thinking about it some more I think you mean the rescheduling IPI here?

True.

> 
> > > +	/*
> > > +	 * From now on, every online cpu will see uptodate
> > > +	 * migarte_pending_work.
> > > +	 */
> > >  	/*
> > >  	 * Clear the LRU lists so pages can be isolated.
> > > -	 * Note that pages may be moved off the LRU after we have
> > > -	 * drained them. Those pages will fail to migrate like other
> > > -	 * pages that may be busy.
> > >  	 */
> > >  	lru_add_drain_all();
> > 
> > Overall, this looks rather heavy weight to my taste. Have you tried to
> > play with a simple atomic counter approach? atomic_read when adding to
> > the cache and atomic_inc inside migrate_prep followed by lrdu_add_drain.

I'd like to avoid atomic operation if we could.

> 
> If you really want a strong ordering then it should be sufficient to
> simply alter lru_add_drain_all to force draining all CPUs. This will
> make sure no new pages are added to the pcp lists and you will also sync
> up anything that has accumulated because of a race between atomic_read
> and inc:
> diff --git a/mm/swap.c b/mm/swap.c
> index 2cca7141470c..91600d7bb7a8 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -745,7 +745,7 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>   * Calling this function with cpu hotplug locks held can actually lead
>   * to obscure indirect dependencies via WQ context.
>   */
> -void lru_add_drain_all(void)
> +void lru_add_drain_all(bool force_all_cpus)
>  {
>  	/*
>  	 * lru_drain_gen - Global pages generation number
> @@ -820,7 +820,8 @@ void lru_add_drain_all(void)
>  	for_each_online_cpu(cpu) {
>  		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
>  
> -		if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
> +		if (force_all_cpus ||
> +		    pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
>  		    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
>  		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
>  		    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||

Yub, that's a idea.
How about this?

diff --git a/mm/migrate.c b/mm/migrate.c
index a69da8aaeccd..2531642dd9ce 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,6 +57,14 @@
 
 #include "internal.h"
 
+static DEFINE_SPINLOCK(migrate_pending_lock);
+static unsigned long migrate_pending_count;
+
+bool migrate_pending(void)
+{
+	return migrate_pending_count;
+}
+
 /*
  * migrate_prep() needs to be called before we start compiling a list of pages
  * to be migrated using isolate_lru_page(). If scheduling work on other CPUs is
@@ -64,13 +72,20 @@
  */
 void migrate_prep(void)
 {
+	unsigned int cpu;
+
+	/*
+	 * lru_add_drain_all's IPI will make sure no new pages are added
+	 * to the pcp lists and drain them all.
+	 */
+	spin_lock(&migrate_pending_lock);
+	migrate_pending_count++;
+	spin_unlock(&migrate_pending_lock);
+
 	/*
 	 * Clear the LRU lists so pages can be isolated.
-	 * Note that pages may be moved off the LRU after we have
-	 * drained them. Those pages will fail to migrate like other
-	 * pages that may be busy.
 	 */
-	lru_add_drain_all();
+	lru_add_drain_all(true);
 }
 
 /* Do the necessary work of migrate_prep but not if it involves other CPUs */
@@ -79,6 +94,15 @@ void migrate_prep_local(void)
 	lru_add_drain();
 }
 
+void migrate_finish(void)
+{
+	int cpu;
+
+	spin_lock(&migrate_pending_lock);
+	migrate_pending_count--;
+	spin_unlock(&migrate_pending_lock);
+}

A odd here is there are no barrier for migrate_finish for
updating migrate_pending_count so other CPUs will see
stale value until they encounters the barrier by chance.
However, it wouldn't be a big deal, IMHO.

What do you think?
