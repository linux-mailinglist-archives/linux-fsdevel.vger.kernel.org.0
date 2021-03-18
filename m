Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627EF3400AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 09:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCRIJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 04:09:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:34716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhCRIJG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:09:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616054945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYbYHzxzMIJD7TqPSeyrbmTDs2X+aT9qDOtxlKAHE2s=;
        b=DB7oESWT+Ryk/R9i0wJiVKnWYyAMJUTLOcSfnf0uHB4ImAz675V2H3hBp5P4iXqGU/s1T1
        p9MaUvgMfRV3rJWDtuvcUGh9nuFdA1/K8YavJlfudfMjZ2jXa7Vv1h7B/NHhNqj8wNL5Ys
        XfmnrDphhUkMYPmnIw9FvxkUq+h24nY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1ADB1AC17;
        Thu, 18 Mar 2021 08:09:05 +0000 (UTC)
Date:   Thu, 18 Mar 2021 09:09:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YFMKnakkxsAit17d@dhcp22.suse.cz>
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-2-minchan@kernel.org>
 <20210317171316.d261de806203d8d99c6bf0ef@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317171316.d261de806203d8d99c6bf0ef@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-03-21 17:13:16, Andrew Morton wrote:
> On Wed, 10 Mar 2021 08:14:28 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
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
> > 
> > To close the race, this patch disables lru caches(i.e, pagevec)
> > during ongoing migration until migrate is done.
> > 
> > Since it's really hard to reproduce, I measured how many times
> > migrate_pages retried with force mode(it is about a fallback to a
> > sync migration) with below debug code.
> > 
> > int migrate_pages(struct list_head *from, new_page_t get_new_page,
> > 			..
> > 			..
> > 
> > if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
> >        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
> >        dump_page(page, "fail to migrate");
> > }
> > 
> > The test was repeating android apps launching with cma allocation
> > in background every five seconds. Total cma allocation count was
> > about 500 during the testing. With this patch, the dump_page count
> > was reduced from 400 to 30.
> > 
> > The new interface is also useful for memory hotplug which currently
> > drains lru pcp caches after each migration failure. This is rather
> > suboptimal as it has to disrupt others running during the operation.
> > With the new interface the operation happens only once. This is also in
> > line with pcp allocator cache which are disabled for the offlining as
> > well.
> > 
> 
> This is really a rather ugly thing, particularly from a maintainability
> point of view.  Are you sure you found all the sites which need the
> enable/disable?  How do we prevent new ones from creeping in which need
> the same treatment?  Is there some way of adding a runtime check which
> will trip if a conversion was missed?

I am not sure I am following. What is your concern here? This is a
lock-like interface to disable a certain optimization because it stands
in the way. Not using the interface is not a correctness problem.

If you refer to disable/enable interface and one potentially missing
enable for some reason then again this will not become a correctness
problem. It will result in a suboptimal behavior. So in the end this is
much less of a probel than leaving a lock behind.

The functionality is not exported to modules and I would agree that this
is not something for out of core/MM code to be used. We can hide it into
an internal mm header of you want?
-- 
Michal Hocko
SUSE Labs
