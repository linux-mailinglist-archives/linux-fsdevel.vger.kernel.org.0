Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5CE6C29C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 06:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCUFXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 01:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCUFXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:23:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A17AA4;
        Mon, 20 Mar 2023 22:23:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eh3so55156040edb.11;
        Mon, 20 Mar 2023 22:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679376222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAuDp41/Jc9fpuI9VECojCxomDXuMmNXR8rPFwVFJCc=;
        b=BHAOXHiS4k4TJgqRzzZoaBWltYI+Ohh+eodyGTbGiHP8Dg1q0nLI4p+CoX1rwg2w3N
         tCA9V31XCHJ6itq3dPhid7873bq3r9XGcrKb3qmJ40Pjos0FvDBUhD2DlC8sE1oRoGm3
         rGnLGz0fVlorTchxIVGSl82Pz+VMyfkYR7rfiKRiQ/1rxCAfy4KPV94TxmwLxBg5/Ctk
         G2CYMSyllsK0ewyt4sOcNyfo3/2zBrXdsmgtKOYmEkpjEdsO9/MXMr8OnJCAvAi87KiU
         GZHAihtjaJGaDYUJN1IFTmZ9s22FqTCLJkh3L/egQ75SJgZ6PYCNAbgAsLPCevbYaj2i
         kzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679376222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAuDp41/Jc9fpuI9VECojCxomDXuMmNXR8rPFwVFJCc=;
        b=6aCRE6fPwjcpeEN6YMYi26JBvNEcG1f01YhOzCvtq3f/Uj6qBbzinDAMsHy1bc867X
         sgYS2kqkzg+HFCLMNVcLubuR53fwc1Tj1Ae/ZeFbm3UZvVH2kbTb2Rj6J1mlRBsTt2rk
         qroahv8bw2LvHLsjyuDgdr/CFFbeihy4gBRf0QWhViyPPhgsfE4nxxgauAKK4G5ykaVv
         juxg2/CIUt9EeY8lH84+cV+czs0ECTJfG7ErSrXGQQfiQAQvPiigmpPeqVVKMK8vtvYe
         vTviDs/innrdvYqw4sNTMR57zmRmfeGY3dXVarEgNK84EJMUvhm8fUwV1yrLJEw894qH
         IbtQ==
X-Gm-Message-State: AO0yUKXaEAHdQgw1nLCkP/FzLAjGtIQjDF2vXRrj/eA3wsGbYBNfxb0l
        trr6SAt7lu+64vdeKxuCIko=
X-Google-Smtp-Source: AK7set9TcfYfZ/XME1QNGZ73w+jPmylxr6E5FwUlYCjpaqJZ07PpOC7KRKrgFUrwNWcUwK482e0t/g==
X-Received: by 2002:a17:906:f10c:b0:930:a3a1:bede with SMTP id gv12-20020a170906f10c00b00930a3a1bedemr1546987ejb.50.1679376222041;
        Mon, 20 Mar 2023 22:23:42 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id kg2-20020a17090776e200b009334219656dsm3472789ejc.56.2023.03.20.22.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:23:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 21 Mar 2023 06:23:39 +0100
To:     Dave Chinner <david@fromorbit.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZBk/Wxj4rXPra/ge@pc636>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBkDuLKLhsOHNUeG@destitution>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:09:12PM +1100, Dave Chinner wrote:
> On Sun, Mar 19, 2023 at 07:09:31AM +0000, Lorenzo Stoakes wrote:
> > vmalloc() is, by design, not permitted to be used in atomic context and
> > already contains components which may sleep, so avoiding spin locks is not
> > a problem from the perspective of atomic context.
> > 
> > The global vmap_area_lock is held when the red/black tree rooted in
> > vmap_are_root is accessed and thus is rather long-held and under
> > potentially high contention. It is likely to be under contention for reads
> > rather than write, so replace it with a rwsem.
> > 
> > Each individual vmap_block->lock is likely to be held for less time but
> > under low contention, so a mutex is not an outrageous choice here.
> > 
> > A subset of test_vmalloc.sh performance results:-
> > 
> > fix_size_alloc_test             0.40%
> > full_fit_alloc_test		2.08%
> > long_busy_list_alloc_test	0.34%
> > random_size_alloc_test		-0.25%
> > random_size_align_alloc_test	0.06%
> > ...
> > all tests cycles                0.2%
> > 
> > This represents a tiny reduction in performance that sits barely above
> > noise.
> 
> I'm travelling right now, but give me a few days and I'll test this
> against the XFS workloads that hammer the global vmalloc spin lock
> really, really badly. XFS can use vm_map_ram and vmalloc really
> heavily for metadata buffers and hit the global spin lock from every
> CPU in the system at the same time (i.e. highly concurrent
> workloads). vmalloc is also heavily used in the hottest path
> throught the journal where we process and calculate delta changes to
> several million items every second, again spread across every CPU in
> the system at the same time.
> 
> We really need the global spinlock to go away completely, but in the
> mean time a shared read lock should help a little bit....
> 
I am working on it. I submitted a proposal how to eliminate it:


<snip>
Hello, LSF.

Title: Introduce a per-cpu-vmap-cache to eliminate a vmap lock contention

Description:
 Currently the vmap code is not scaled to number of CPU cores in a system
 because a global vmap space is protected by a single spinlock. Such approach
 has a clear bottleneck if many CPUs simultaneously access to one resource.

 In this talk i would like to describe a drawback, show some data related
 to contentions and places where those occur in a code. Apart of that i
 would like to share ideas how to eliminate it providing a few approaches
 and compare them.

Requirements:
 * It should be a per-cpu approach;
 * Search of freed ptrs should not interfere with other freeing(as much as we can);
 *   - offload allocated areas(buzy ones) per-cpu;
 * Cache ready sized objects or merge them into one big per-cpu-space(split on demand);
 * Lazily-freed areas either drained per-cpu individually or by one CPU for all;
 * Prefetch a fixed size in front and allocate per-cpu

Goals:
 * Implement a per-cpu way of allocation to eliminate a contention.

Thanks!
<snip>

--
Uladzislau Rezki

