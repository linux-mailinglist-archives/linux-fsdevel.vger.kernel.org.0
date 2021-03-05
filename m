Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E84932F498
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 21:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCEU0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 15:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCEU0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:26:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5426EC06175F;
        Fri,  5 Mar 2021 12:26:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so1963737plg.13;
        Fri, 05 Mar 2021 12:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dNGmj86mFeRkOoBt/AbK+6NZzyM9+XeKwiG9SmwabaA=;
        b=NpHTAtpodPt1vaJ1SvWGGj0+4cLHTqpaSNcKeA967cncTMTZmCx3+44vMoJBvQjy3D
         ZL2781KzRviiwFPwpiCrq9CgXSdV1Kmgs7W0mxQT2dKVViHJ9MxOZEJT7SNjCPt1Mdfd
         Mj9Tg8LxeDSoHBGwWP5wcKGObXFhq+Twj1qfXfHIGsCHjWC0txfLpC5ZgXt73sDpaEKk
         n1uiTZAL6S5LLJKQNflmxCsWKOZEfS7tVuE2iH39aaXsTr2bjdwKSxMsMGrmxCdettsE
         QzSmVvX69Bl+++C9f6DR19P4x59eNangZgUw2HQjKxEZ03CXM3gv+qTZkp6PF+Npm/l8
         ERyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dNGmj86mFeRkOoBt/AbK+6NZzyM9+XeKwiG9SmwabaA=;
        b=lvpqFqoBLDCvxcK1PhgTaCkE3orNDflWjrxyCJ9tvXh3vUktbMCBVRP37OznhVbao8
         xlJE3y+iJWoeEiKFZ9le1VHSSU15s1H9LSZ/kZQT4ai1TfOlCM4jEnN2XuNM0zhLKTJI
         Vojqy1OoRyFr+njmS2uXNQ6za2w3qlbsRN5ozLUn3tuF/gaGx9G74Ycw0cx2mBjRrkMo
         YvHST3wrKOmfa2dQpHKBz+6FKMCH6qKaWNu/nsGCvhYmfBjKUUgbRU3+p0wLrXLKdu04
         h0izV95udOt+uvuEItvPtOltvt13mOUP7oYFsrSDitYnABX4HkKhF7zq+f/WGS+U5LO1
         qEbg==
X-Gm-Message-State: AOAM533RSsV6GM8+/yPMAxDaUxOzHJtZxt6k5FUhgAbOS8GXFAinnnrh
        BDT166gsRYiI6p7Od9HlF7g=
X-Google-Smtp-Source: ABdhPJzqUgSGCScxhDoo2nN4iiTLIVlk230TnxX0TjAWahTL3fkMweSC0QyTPYeIzrPozM5e/oARJQ==
X-Received: by 2002:a17:90a:3ec3:: with SMTP id k61mr11772694pjc.125.1614975974792;
        Fri, 05 Mar 2021 12:26:14 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9db6:fc32:1046:dd86])
        by smtp.gmail.com with ESMTPSA id s28sm3269115pfd.155.2021.03.05.12.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 12:26:13 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 5 Mar 2021 12:26:11 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YEKT4+4nLjGaAHCx@google.com>
References: <20210302210949.2440120-1-minchan@kernel.org>
 <YD+F4LgPH0zMBDGW@dhcp22.suse.cz>
 <YD/wOq3lf9I5HK85@google.com>
 <YEJW+dzF9/BNIiqn@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEJW+dzF9/BNIiqn@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 05, 2021 at 05:06:17PM +0100, Michal Hocko wrote:
> On Wed 03-03-21 12:23:22, Minchan Kim wrote:
> > On Wed, Mar 03, 2021 at 01:49:36PM +0100, Michal Hocko wrote:
> > > On Tue 02-03-21 13:09:48, Minchan Kim wrote:
> > > > LRU pagevec holds refcount of pages until the pagevec are drained.
> > > > It could prevent migration since the refcount of the page is greater
> > > > than the expection in migration logic. To mitigate the issue,
> > > > callers of migrate_pages drains LRU pagevec via migrate_prep or
> > > > lru_add_drain_all before migrate_pages call.
> > > > 
> > > > However, it's not enough because pages coming into pagevec after the
> > > > draining call still could stay at the pagevec so it could keep
> > > > preventing page migration. Since some callers of migrate_pages have
> > > > retrial logic with LRU draining, the page would migrate at next trail
> > > > but it is still fragile in that it doesn't close the fundamental race
> > > > between upcoming LRU pages into pagvec and migration so the migration
> > > > failure could cause contiguous memory allocation failure in the end.
> > > > 
> > > > To close the race, this patch disables lru caches(i.e, pagevec)
> > > > during ongoing migration until migrate is done.
> > > > 
> > > > Since it's really hard to reproduce, I measured how many times
> > > > migrate_pages retried with force mode below debug code.
> > > > 
> > > > int migrate_pages(struct list_head *from, new_page_t get_new_page,
> > > > 			..
> > > > 			..
> > > > 
> > > > if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
> > > >        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
> > > >        dump_page(page, "fail to migrate");
> > > > }
> > > > 
> > > > The test was repeating android apps launching with cma allocation
> > > > in background every five seconds. Total cma allocation count was
> > > > about 500 during the testing. With this patch, the dump_page count
> > > > was reduced from 400 to 30.
> > > 
> > > Have you seen any improvement on the CMA allocation success rate?
> > 
> > Unfortunately, the cma alloc failure rate with reasonable margin
> > of error is really hard to reproduce under real workload.
> > That's why I measured the soft metric instead of direct cma fail
> > under real workload(I don't want to make some adhoc artificial
> > benchmark and keep tunes system knobs until it could show 
> > extremly exaggerated result to convice patch effect).
> > 
> > Please say if you belive this work is pointless unless there is
> > stable data under reproducible scenario. I am happy to drop it.
> 
> Well, I am not saying that this is pointless. In the end the resulting
> change is relatively small and it provides a useful functionality for
> other users (e.g. hotplug). That should be a sufficient justification.

Yub, that was my impression to worth upstreaming rather than keeping
downstream tree so made divergent.

> 
> I was asking about CMA allocation success rate because that is a much
> more reasonable metric than how many times something has retried because
> retries can help to increase success rate and the patch doesn't really
> remove those. If you want to use number of retries as a metric then the
> average allocation latency would be more meaningful.

I believe the allocation latency would be pretty big and retrial part
would be marginal so doubt it's meaningful.

Let me send next revision with as-is descripion once I fix places
you pointed out.

Thanks.
