Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D73AD12D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhFRRb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhFRRb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:31:58 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EFC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 10:29:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c9so12832943qkm.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MDqR7W4yXQCvkXsnmPwhAYo/pxcSJzJ3a33+/Daa0uQ=;
        b=tlKYNHoJKQ717Wgx+oKVyuIEe8YtJI+Nn01hhT4DgoCaC88ilBmdTeB73xxHXK97Rj
         uQS/lp9yilJvs3jKBXXmHGAeGHwyWZPNOJDwfbi4TlHp2CCCO/zoA4OvxnQ8xNJCoszI
         HqvLGpy/mB5vJQ+XdM6SJHEyKKNlOziKmL3wU+EsZrJhVXrtR12jp1PK6MAJy7yoxmRk
         Km/K8DfdbAnEYTkYH4fINxE/E9qLFD/+sWya7Axtvh+N4iHl1HImIp4ptD71ytIpPb18
         JWgxBEWy0e3PrlBLLEwiyyBKPOAjjy73TqEhmmGG+VJqufb8/2qBC2T5IZtBR1ukh3jh
         /ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MDqR7W4yXQCvkXsnmPwhAYo/pxcSJzJ3a33+/Daa0uQ=;
        b=iWoburxK316P3Dp1Oacbau3kZ7msZTSf8B4/D1v7wwYVcN29G5Qwbvxs0uPGydrXs/
         Y5z5dG4mI93ynZlOZlENsiOfvxCr/bn5H8gz9FIZ+wD0+JaLsVlC18VJuzzmY12TVFSY
         Hgu1f4G5bkfjjqKrPIpaGwDr9JwAaw4bcEQ18npcWgOfPSCEDVXLIxW678pzAQivHGKE
         ic6OGftCIgrAsyA9oVBil8i4PyyFvE1Ln8MRvEya6qSilRclWXq6OjVCKEOnAVM0ydPU
         fBMwxLFq03NRLWPTJMaOPp65jyH5Tzhoihr7bXo8H75/T6uySuR70T7mCErFue0PPG9G
         61zg==
X-Gm-Message-State: AOAM5339/jVA4Iv/a1u2Xlg1oLVwhqONWI3YTAoh/7x/1DiqUyGbnDMe
        VXbeiFFBAWLofXXXVawieeDkTA==
X-Google-Smtp-Source: ABdhPJwj0x4VwWE+SOwFVKpLufRmLSe5wzxJRgydxXgTHZpdvGvFYrh2LKPjmY5S6n12H79ISqah8Q==
X-Received: by 2002:a05:620a:5fb:: with SMTP id z27mr10652616qkg.262.1624037387382;
        Fri, 18 Jun 2021 10:29:47 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id g15sm3139288qtq.70.2021.06.18.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:29:46 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:29:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: Re: Possible bogus "fuse: trying to steal weird page" warning
 related to PG_workingset.
Message-ID: <YMzYCCBaUTfzdFff@cmpxchg.org>
References: <016b2fe2-0d52-95c9-c519-40b14480587a@gmail.com>
 <CAJfpeguzkDQ5VL3m19jrepf1YjFeJ2=q99TurTX6DRpAKz+Omg@mail.gmail.com>
 <YMn1s19wMQdGDQuQ@casper.infradead.org>
 <CAJfpegsMNc-deQvdOntZJHU2bW34JF=e0gwxPe19eFXp1t0PFQ@mail.gmail.com>
 <029095d9-399a-e323-15f3-b665e9852eb3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029095d9-399a-e323-15f3-b665e9852eb3@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 06:48:34PM +0200, Vlastimil Babka wrote:
> On 6/16/21 3:47 PM, Miklos Szeredi wrote:
> > On Wed, 16 Jun 2021 at 14:59, Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> > AFAICT fuse is trying to steal a pagecache page from a pipe buffer
> >> > created by splice(2).    The page looks okay, but I have no idea what
> >> > PG_workingset means in this context.
> >> >
> >> > Matthew, can you please help?
> >>
> >> PG_workingset was introduced by Johannes:
> >>
> >>     mm: workingset: tell cache transitions from workingset thrashing
> >>
> >>     Refaults happen during transitions between workingsets as well as in-place
> >>     thrashing.  Knowing the difference between the two has a range of
> >>     applications, including measuring the impact of memory shortage on the
> >>     system performance, as well as the ability to smarter balance pressure
> >>     between the filesystem cache and the swap-backed workingset.
> >>
> >>     During workingset transitions, inactive cache refaults and pushes out
> >>     established active cache.  When that active cache isn't stale, however,
> >>     and also ends up refaulting, that's bonafide thrashing.
> >>
> >>     Introduce a new page flag that tells on eviction whether the page has been
> >>     active or not in its lifetime.  This bit is then stored in the shadow
> >>     entry, to classify refaults as transitioning or thrashing.
> >>
> >> so I think it's fine for you to ignore when stealing a page.
> > 
> > I have problem understanding what a workingset is.  Is it related to
> 
> "working set" is the notion of the set of pages that the workload needs to
> access at the moment/relatively short time window, and it would be beneficial if
> all of it could fit in the RAM.
> PG_workinsgset is part of the mechanism that tries to estimate this ideal set of
> pages, and especially when the workload shifts to another set of pages, in order
> to guide reclaim better. See the big comment at the top of mm/workingset.c for
> details
> 
> > swap?  If so, how can such a page be part of a file mapping?
> 
> Not related to swap. It was actually first implemented only for file pages (page
> cache), but then extended to anonymous pages by aae466b0052e ("mm/swap:
> implement workingset detection for anonymous LRU")

Thanks, yes.

Think of it as similar to PG_active. It's just another usage/heat
indicator of file and anon pages on the reclaim LRU that, unlike
PG_active, persists across deactivation and even reclaim (we store it
in the page cache / swapper cache tree until the page refaults).

So if fuse accepts pages that can legally have PG_active set,
PG_workingset is fine too.

