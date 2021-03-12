Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8729339483
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 18:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhCLRRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 12:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhCLRR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:17:27 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9366C061574;
        Fri, 12 Mar 2021 09:17:26 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q5so3627586pgk.5;
        Fri, 12 Mar 2021 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X5T+1cZx7Ze9HLcDcUFhAoG7Y0mpEVmrKDYi0os1bZE=;
        b=nwSUnGgDe1RavjwqezmE3K7rZLKM25jazvEOwEgTtQbDHDSImMIXoev0JTWQHt9IDI
         ArmuMuMFKn5uN4oOhoLP+zIyszMiZlvFA5Eb+/YRgIngQh/eAlwF83DRVCzQTWwcZ4FP
         9A9k+2X/ZVT0+F5Tap+vfB9mFD1/BUGqa6eNaogQR+kgr7IhvPZs9q+qpbpSmNLd+K5V
         kJQdli+TA0Am7Px/AO7ZtOqwUzOQQRO35hztpMTz6XD7rL5zpK8W2CRVGbN6EVqM+z2v
         7ofbN8044OVu0vBV1AoGAfH7ZYORFyF98gLB1IrbwnlaTdoi65dlBRTDF77sgXtddARo
         D0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=X5T+1cZx7Ze9HLcDcUFhAoG7Y0mpEVmrKDYi0os1bZE=;
        b=jlPVT/5hLi2Y+BUv6dDFObj3wCAqtQBnWYBMUfp/eDvK5UETGAxfvxmeq66pke4Ss0
         aOz8l1FOofRu44TigYqqbsVuChLtNbg2qNxeS4xSteVlJ3fjwx1neTqRHvDe2NHHtpiU
         I4SXURs/hDc0HTBsjE0FcD0qk0ZF4cMVfm0WL3gELZqFymf+/dfKy7SCVFh36SSRv8gK
         crR1/lNZL9pYvqMowsPFSgO/1B4EpDjQnwFy0DFF85rbt66I7OX0vkdMA0N+JfI/mE4R
         sjmZW5u0N2koK8PIXEhr3I/+MBsoFYSGsZULFQqEEW+nczgnsJvhzAi0w5ppaGZJk6XU
         oGvw==
X-Gm-Message-State: AOAM5324p8YPHh0mOZgBV382x6kwcLvrsTrKrzh4E/UpsHrRr2Q3Uj/X
        66+6g4iDEMLDxu0KZa+ei3jo7H9hi64=
X-Google-Smtp-Source: ABdhPJzqNpRSsGwU1QmpjOx064HIxZbOPkL28CMseU3xup1dCP0HxRqcDxNEm1bd4JA4HCqMmW65TA==
X-Received: by 2002:a63:1021:: with SMTP id f33mr12680153pgl.409.1615569446373;
        Fri, 12 Mar 2021 09:17:26 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8d76:9272:43a9:a6d0])
        by smtp.gmail.com with ESMTPSA id y4sm6004799pfn.67.2021.03.12.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:17:25 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 12 Mar 2021 09:17:23 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        mhocko@suse.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm: fs: Invalidate BH LRU during page migration
Message-ID: <YEuiI44IRjBOQ8Wy@google.com>
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-3-minchan@kernel.org>
 <1bdc93e5-e5d4-f166-c467-5b94ac347857@redhat.com>
 <1527f16f-4376-a10d-4e72-041926cf38da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527f16f-4376-a10d-4e72-041926cf38da@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 10:33:48AM +0100, David Hildenbrand wrote:
> On 12.03.21 10:03, David Hildenbrand wrote:
> > On 10.03.21 17:14, Minchan Kim wrote:
> > > ffer_head LRU caches will be pinned and thus cannot be migrated.
> > > This can prevent CMA allocations from succeeding, which are often used
> > > on platforms with co-processors (such as a DSP) that can only use
> > > physically contiguous memory. It can also prevent memory
> > > hot-unplugging from succeeding, which involves migrating at least
> > > MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
> > > GiB based on the architecture in use.
> > 
> > Actually, it's memory_block_size_bytes(), which can be even bigger
> > (IIRC, 128MiB..2 GiB on x86-64) that fails to get offlined. But that
> > will prevent bigger granularity (e.g., a whole DIMM) from getting unplugged.
> > 
> > > 
> > > Correspondingly, invalidate the BH LRU caches before a migration
> > > starts and stop any buffer_head from being cached in the LRU caches,
> > > until migration has finished.
> > 
> > Sounds sane to me.
> > 
> 
> Diving a bit into the code, I am wondering:
> 
> 
> a) Are these buffer head pages marked as movable?
> 
> IOW, are they either PageLRU() or __PageMovable()?
> 
> 
> b) How do these pages end up on ZONE_MOVABLE or MIGRATE_CMA?
> 
> I assume these pages come via
> alloc_page_buffers()->alloc_buffer_head()->kmem_cache_zalloc(GFP_NOFS |
> __GFP_ACCOUNT)
> 

It's indirect it was not clear

try_to_release_page
    try_to_free_buffers
        buffer_busy
            failed

Yeah, comment is misleading. This one would be better.

        /*
         * the refcount of buffer_head in bh_lru prevents dropping the
         * attached page(i.e., try_to_free_buffers) so it could cause
         * failing page migrationn.
         * Skip putting upcoming bh into bh_lru until migration is done.
         */
