Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D1332C10
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCIQ3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 11:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhCIQ3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:29:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B129C06174A;
        Tue,  9 Mar 2021 08:29:25 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b23so1144101pfo.8;
        Tue, 09 Mar 2021 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qIR+vLuSsJtxvMH6Qq5CKiZHj7EMGWr+lEiBpjCDZ+Y=;
        b=nP2Gbw1PPZPCgw056ud+h4MaNUTkNDXAV84IdyxUs629jghlnu69vu6vhZ8NQLdUnZ
         bf7X2QGyifRV2q/06Nb/GbLyP0UHGn19kSTi0gW+RCK78800jKPfR39986xl4t/GN8Kb
         c5wu+Y7H3UIki+3O/5XL9yjapAeAm+nzhJnn9jCaUHMAwkZDpZMBxdp+MlgtBixTB2VT
         iyNE5tQzRMLI3SqcJWy4Dw35QS6JQWRPe+uMMwhsUw0azQb5k2MxG6KcAsnTDGQNVOFN
         9lTHYNiJwwh8+wcv/cwZq9GGxzUSwtCPxIJCqgB/blv9SDic3Gpwa61EWHjW5+w9PeB1
         iH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qIR+vLuSsJtxvMH6Qq5CKiZHj7EMGWr+lEiBpjCDZ+Y=;
        b=ey4F0Rk4o3FurCxM7Yad6ku98elHQc11Amurwhdk7eT6l4DJx8ymSHxZYbeJ66ePpu
         QReup90a4C//p4s5YVyX5z2QVg0CfEwA1adFTBWjt5LcNq3+8rwrWziWwPgU3DgeGHUs
         EYLltEke6KRXtpme+JmFp7dUYS6OAc04A49WAt+P2YrZX5sFWMXTtpCiSGiWqRu9mCml
         7guJbMHgzvT+8YOs/orXks8y4i9IfDvKOreSgwUIQ19dCVutL/ZmaWNfJ7xOPnO1Hp6N
         OrAJh4Inrq2t+540urXipK11eGievUyTBMbWqQ6MipM1iHR2YL9KFlCkqMEaV7e/yluc
         /qzQ==
X-Gm-Message-State: AOAM532yYp2DeoQkjnl3eXl2UCBBcARyF7paDAYgkzeFWCQg9o0TO12f
        gicc4e9XYQUzNTCl4hn1sY8=
X-Google-Smtp-Source: ABdhPJyszkOEcnYbIOnFBoX3QlBm9YiD1XhVw67IrawQzunWp7WpYWi/+chIHQMfJgVSS3gjcgKvtg==
X-Received: by 2002:aa7:8e51:0:b029:1ed:2928:18ff with SMTP id d17-20020aa78e510000b02901ed292818ffmr4171793pfr.76.1615307364873;
        Tue, 09 Mar 2021 08:29:24 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
        by smtp.gmail.com with ESMTPSA id t12sm10391170pfe.203.2021.03.09.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:29:23 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Mar 2021 08:29:21 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YEeiYbBjefM08h18@google.com>
References: <20210309051628.3105973-1-minchan@kernel.org>
 <YEdV7Leo7MC93PlK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEdV7Leo7MC93PlK@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 12:03:08PM +0100, Michal Hocko wrote:
> On Mon 08-03-21 21:16:27, Minchan Kim wrote:
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
> > migrate_pages retried with force mode below debug code.
> 
> It would be better to explicitly state that this is about a fallback to
> a sync migration.
> 
>  
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
> 
> I still find these results hard to argue about because it has really no
> relation to any measurable effect for those apps you are mentioning. I
> would expect sync migration would lead to performance difference. Is
> there any?

Think about migrating 300M pages. It needs to migrate 76800 pages.
It means page migration works(unmap + copy + map) are dominant.

> 
> > It would be also useful for memory-hotplug.
> 
> This is a statment that would deserve some explanation.
> "
> The new interface is alsow useful for memory hotplug which currently
> drains lru pcp caches after each migration failure. This is rather
> suboptimal as it has to disrupt others running during the operation.
> With the new interface the operation happens only once. This is also in
> line with pcp allocator cache which are disabled for the offlining as
> well.
> "

Much better. Thanks. 

>  
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > * from v1 - https://lore.kernel.org/lkml/20210302210949.2440120-1-minchan@kernel.org/
> >   * introduce __lru_add_drain_all to minimize changes - mhocko
> >   * use lru_cache_disable for memory-hotplug
> >   * schedule for every cpu at force_all_cpus
> > 
> > * from RFC - http://lore.kernel.org/linux-mm/20210216170348.1513483-1-minchan@kernel.org
> >   * use atomic and lru_add_drain_all for strict ordering - mhocko
> >   * lru_cache_disable/enable - mhocko
> > 
> >  include/linux/migrate.h |  6 ++-
> >  include/linux/swap.h    |  2 +
> >  mm/memory_hotplug.c     |  3 +-
> >  mm/mempolicy.c          |  6 +++
> >  mm/migrate.c            | 13 ++++---
> >  mm/page_alloc.c         |  3 ++
> >  mm/swap.c               | 82 +++++++++++++++++++++++++++++++++--------
> >  7 files changed, 91 insertions(+), 24 deletions(-)
> 
> Sorry for nit picking but I think the additional abstraction for
> migrate_prep is not really needed and we can remove some more code.
> Maybe we should even get rid of migrate_prep_local which only has a
> single caller and open coding lru draining with a comment would be
> better from code reading POV IMO.

Thanks for the code. I agree with you.
However, in this moment, let's go with this one until we conclude.
The removal of migrate_prep could be easily done after that.
I am happy to work on it.
