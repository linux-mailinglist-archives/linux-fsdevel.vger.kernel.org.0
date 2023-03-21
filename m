Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8AE6C2EB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 11:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCUKY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCUKYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:24:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D970B451;
        Tue, 21 Mar 2023 03:24:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g18so14973229ljl.3;
        Tue, 21 Mar 2023 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679394287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMnGO+cdUo4n0JCQA6B9J3faYFMMwzSPnGc3N31RXns=;
        b=OL97cOCuA1WOehpm1zJAySiABvjHD8vQTwJI2isdWzRb7Q4Ysgyx/nzCpMSqEj6Grw
         9R60XvRrJIzfWG8xnyW6C4Mh1japTaTlgH12slRH2gsbn7Dk8tAz3yKn0XpldrxMC/jd
         ONmU04Y1pbnOAy9SYneQmtRfKUJb9OPd79uWkRw3mIyWJQemn6aL8GPkDyM+1GbgfnzG
         QUdbzi377DtIo3106z7EBOYjKRGlrxy2UMsCeFzrcF7cCDS3KPK3TdjBtIBF1MZu0sBY
         yaA9eqQW9yPEGRINYuBR7Df6FnAoZkZCoUKPIn7c7Dr87DfLQkD69zr0FzywITqabCmu
         Zmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679394287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMnGO+cdUo4n0JCQA6B9J3faYFMMwzSPnGc3N31RXns=;
        b=66cAEu8BoH5mbJU6fj13FPdWLAUkuHE+0HUeQVHdAqaJujcMY1tYh75wJXX1U3EKl8
         D30PnbsSeoEISWSiNlM7lP95DolLIG5IfqDVutwWYqcCEVysg16eJdN2uAK6ZXMBPTm4
         0e2sZP2pmaabokMKeZ3vrvc9OVh3cmxR8UPlHOx61DyJT2pVVj2NqQ4F4c7OUOR4xuoS
         DbiuSNBwIoauVJWK+KbTQBsP+6JTFOblrUDMv17wM5sr9956AvlEifFpntMS8wm2GWiY
         hL6J2oODFlyDQ4zelikIt40ze+4hbk6y++IBlgx9tzEDeYqpyVKN31mWVoC6OlT9IuAN
         pElg==
X-Gm-Message-State: AO0yUKWFXDhjenkjgqNDcoGT7v/IOwSTk0fBe3cIweVpXCUpcgWVSU03
        ncBjMqI2YzlE208qZye/QyI=
X-Google-Smtp-Source: AK7set8+X6YPBnP4OYEIhq0HB7BSUjF2dweQmUvOy7pWHXIqJeBGU2x5Fw6aWB3zC+XgtcLzx9bg9g==
X-Received: by 2002:a2e:8342:0:b0:299:5d3a:4f29 with SMTP id l2-20020a2e8342000000b002995d3a4f29mr645207ljh.31.1679394286927;
        Tue, 21 Mar 2023 03:24:46 -0700 (PDT)
Received: from pc636 (host-90-233-209-15.mobileonline.telia.com. [90.233.209.15])
        by smtp.gmail.com with ESMTPSA id l18-20020a2e99d2000000b00297dad1a2b0sm2101031ljj.103.2023.03.21.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:24:46 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Mar 2023 11:24:44 +0100
To:     Dave Chinner <david@fromorbit.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBmF7OMw2TAOYsfW@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBk/Wxj4rXPra/ge@pc636>
 <8cd31bcd-dad4-44e3-920f-299a656aea98@lucifer.local>
 <ZBmBZqhOHdGt4t9n@destitution>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBmBZqhOHdGt4t9n@destitution>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:05:26PM +1100, Dave Chinner wrote:
> On Tue, Mar 21, 2023 at 07:45:56AM +0000, Lorenzo Stoakes wrote:
> > On Tue, Mar 21, 2023 at 06:23:39AM +0100, Uladzislau Rezki wrote:
> > > On Tue, Mar 21, 2023 at 12:09:12PM +1100, Dave Chinner wrote:
> > > > On Sun, Mar 19, 2023 at 07:09:31AM +0000, Lorenzo Stoakes wrote:
> > > > > vmalloc() is, by design, not permitted to be used in atomic context and
> > > > > already contains components which may sleep, so avoiding spin locks is not
> > > > > a problem from the perspective of atomic context.
> > > > >
> > > > > The global vmap_area_lock is held when the red/black tree rooted in
> > > > > vmap_are_root is accessed and thus is rather long-held and under
> > > > > potentially high contention. It is likely to be under contention for reads
> > > > > rather than write, so replace it with a rwsem.
> > > > >
> > > > > Each individual vmap_block->lock is likely to be held for less time but
> > > > > under low contention, so a mutex is not an outrageous choice here.
> > > > >
> > > > > A subset of test_vmalloc.sh performance results:-
> > > > >
> > > > > fix_size_alloc_test             0.40%
> > > > > full_fit_alloc_test		2.08%
> > > > > long_busy_list_alloc_test	0.34%
> > > > > random_size_alloc_test		-0.25%
> > > > > random_size_align_alloc_test	0.06%
> > > > > ...
> > > > > all tests cycles                0.2%
> > > > >
> > > > > This represents a tiny reduction in performance that sits barely above
> > > > > noise.
> > > >
> > > > I'm travelling right now, but give me a few days and I'll test this
> > > > against the XFS workloads that hammer the global vmalloc spin lock
> > > > really, really badly. XFS can use vm_map_ram and vmalloc really
> > > > heavily for metadata buffers and hit the global spin lock from every
> > > > CPU in the system at the same time (i.e. highly concurrent
> > > > workloads). vmalloc is also heavily used in the hottest path
> > > > throught the journal where we process and calculate delta changes to
> > > > several million items every second, again spread across every CPU in
> > > > the system at the same time.
> > > >
> > > > We really need the global spinlock to go away completely, but in the
> > > > mean time a shared read lock should help a little bit....
> > > >
> > 
> > Hugely appreciated Dave, however I must disappoint on the rwsem as I have now
> > reworked my patch set to use the original locks in order to satisfy Willy's
> > desire to make vmalloc atomic in future, and Uladzislau's desire to not have a
> > ~6% performance hit -
> > https://lore.kernel.org/all/cover.1679354384.git.lstoakes@gmail.com/
> 
> Yeah, I'd already read that.
> 
> What I want to do, though, is to determine whether the problem
> shared access contention or exclusive access contention. If it's
> exclusive access contention, then an rwsem will do nothing to
> alleviate the problem, and that's kinda critical to know before any
> fix for the contention problems are worked out...
> 
> > > I am working on it. I submitted a proposal how to eliminate it:
> > >
> > >
> > > <snip>
> > > Hello, LSF.
> > >
> > > Title: Introduce a per-cpu-vmap-cache to eliminate a vmap lock contention
> > >
> > > Description:
> > >  Currently the vmap code is not scaled to number of CPU cores in a system
> > >  because a global vmap space is protected by a single spinlock. Such approach
> > >  has a clear bottleneck if many CPUs simultaneously access to one resource.
> > >
> > >  In this talk i would like to describe a drawback, show some data related
> > >  to contentions and places where those occur in a code. Apart of that i
> > >  would like to share ideas how to eliminate it providing a few approaches
> > >  and compare them.
> 
> If you want data about contention problems with vmalloc
> 
> > > Requirements:
> > >  * It should be a per-cpu approach;
> 
> Hmmmm. My 2c worth on this: That is not a requirement.
> 
> That's a -solution-.
> 
> The requirement is that independent concurrent vmalloc/vfree
> operations do not severely contend with each other.
> 
> Yes, the solution will probably involve sharding the resource space
> across mulitple independent structures (as we do in filesystems with
> block groups, allocations groups, etc) but that does not necessarily
> need the structures to be per-cpu.
> 
> e.g per-node vmalloc arenas might be sufficient and allow more
> expensive but more efficient indexing structures to be used because
> we don't have to care about the explosion of memory that
> fine-grained per-cpu indexing generally entails.  This may also fit
> in to the existing per-node structure of the memory reclaim
> infrastructure to manage things like compaction, balancing, etc of
> vmalloc space assigned to the given node.
> 
> Hence I think saying "per-cpu is a requirement" kinda prevents
> exploration of other novel solutions that may have advantages other
> than "just solves the concurrency problem"...
> 
> > >  * Search of freed ptrs should not interfere with other freeing(as much as we can);
> > >  *   - offload allocated areas(buzy ones) per-cpu;
> > >  * Cache ready sized objects or merge them into one big per-cpu-space(split on demand);
> > >  * Lazily-freed areas either drained per-cpu individually or by one CPU for all;
> > >  * Prefetch a fixed size in front and allocate per-cpu
> 
> I'd call these desired traits and/or potential optimisations, not
> hard requirements.
> 
> > > Goals:
> > >  * Implement a per-cpu way of allocation to eliminate a contention.
> 
> The goal should be to "allow contention-free vmalloc operations", not
> that we implement a specific solution.
> 
I think we are on the same page. I do not see that we go apart in anything.
Probably i was a bit more specific in requirements but this is how i see
personally on it based on different kind of experiments with it.

Thank you for your 2c!

--
Uladzislau Rezki
