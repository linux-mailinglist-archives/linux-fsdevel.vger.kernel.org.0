Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6E31ED0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhBRRNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:13:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:37342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232871AbhBRQKV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:10:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613664541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bC2Uhe3wS/iH/9eQnHqw2DtW9bXgLhC7iPsGl5NSF5g=;
        b=fQBtUlPl0glwKmB4E4ZCwLU7lqM7nkvEiu3jLUn/lXru3Qo+tW7Qz5kzfMFJcw/w2oCJmB
        6hPfaCcPYpFbyfJe3GI5yF1cdc3BDV7H0uIzxcngoQvyFx+53oQ/7AiiX/toVWBhICGVMS
        zrMnj/az2JIcktIdFxmr1agGO5LRKJs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9DDBCADDB;
        Thu, 18 Feb 2021 16:09:01 +0000 (UTC)
Date:   Thu, 18 Feb 2021 17:08:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, david@redhat.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YC6RGiemaQHQScsZ@dhcp22.suse.cz>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YC2Am34Fso5Y5SPC@google.com>
 <20210217211612.GO2858050@casper.infradead.org>
 <YC2LVXO6e2NVsBqz@google.com>
 <YC4ifqXYEeWrj4aF@dhcp22.suse.cz>
 <YC6NOVBy5J4bUjfD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC6NOVBy5J4bUjfD@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-02-21 07:52:25, Minchan Kim wrote:
> On Thu, Feb 18, 2021 at 09:17:02AM +0100, Michal Hocko wrote:
> > On Wed 17-02-21 13:32:05, Minchan Kim wrote:
> > > On Wed, Feb 17, 2021 at 09:16:12PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Feb 17, 2021 at 12:46:19PM -0800, Minchan Kim wrote:
> > > > > > I suspect you do not want to add atomic_read inside hot paths, right? Is
> > > > > > this really something that we have to microoptimize for? atomic_read is
> > > > > > a simple READ_ONCE on many archs.
> > > > > 
> > > > > It's also spin_lock_irq_save in some arch. If the new synchonization is
> > > > > heavily compilcated, atomic would be better for simple start but I thought
> > > > > this locking scheme is too simple so no need to add atomic operation in
> > > > > readside.
> > > > 
> > > > What arch uses a spinlock for atomic_read()?  I just had a quick grep and
> > > > didn't see any.
> > > 
> > > Ah, my bad. I was confused with update side.
> > > Okay, let's use atomic op to make it simple.
> > 
> > Thanks. This should make the code much more simple. Before you send
> > another version for the review I have another thing to consider. You are
> > kind of wiring this into the migration code but control over lru pcp
> > caches can be used in other paths as well. Memory offlining would be
> > another user. We already disable page allocator pcp caches to prevent
> > regular draining. We could do the same with lru pcp caches.
> 
> I didn't catch your point here. If memory offlining is interested on
> disabling lru pcp, it could call migrate_prep and migrate_finish
> like other places. Are you suggesting this one?

What I meant to say is that you can have a look at this not as an
integral part of the migration code but rather a common functionality
that migration and others can use. So instead of an implicit part of
migrate_prep this would become disable_lru_cache and migrate_finish
would become lruc_cache_enable. See my point? 

An advantage of that would be that this would match the pcp page
allocator disabling and we could have it in place for the whole
operation to make the page state more stable wrt. LRU state (PageLRU).
 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a969463bdda4..0ec1c13bfe32 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1425,8 +1425,12 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>                 node_clear(mtc.nid, nmask);
>                 if (nodes_empty(nmask))
>                         node_set(mtc.nid, nmask);
> +
> +               migrate_prep();
>                 ret = migrate_pages(&source, alloc_migration_target, NULL,
>                         (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> +
> +               migrate_finish();
>                 if (ret) {
>                         list_for_each_entry(page, &source, lru) {
>                                 pr_warn("migrating pfn %lx failed ret:%d ",
> 

-- 
Michal Hocko
SUSE Labs
