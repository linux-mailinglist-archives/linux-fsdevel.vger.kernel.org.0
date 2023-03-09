Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09026B1A4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 05:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCIEIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 23:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCIEI3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 23:08:29 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E7830B2E
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 20:08:22 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id nf5so659525qvb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Mar 2023 20:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1678334901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOqFTH5u/fVVsKVxp4qKRwo0vsAjcMeltzSVwR+wC7w=;
        b=QR3kDqRboFFNYKkzTvJrai95dT3dZTs9cGDwwec8U7dvf/bHtU8JEPYSUNwNi/A46B
         gBI203InsTfsnZw9Bv6K1Tq2dpzCPmP9irezZNzKvopRnWuhHByck3EjMdnV8UYvu0MF
         pkOF6VyERI42m0XRvCUT7r3ELRx0whQS1NVs41INaHDKAHjqKKYfZ+5LCMR0HTol4O4c
         5ZhWDegnCqEQx6vHB0EVkpKmVt+qAJQ3GFLh1WwsqiXGzwYR7AR9t1UhDO9N9doLFdtd
         OCVBDqZ45fI2Bac3OyAY6RRjSMFpgAXGdNxKPvkbVt02jFWGaIMcLg4vJO1MbhB/sBZt
         Qliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678334901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOqFTH5u/fVVsKVxp4qKRwo0vsAjcMeltzSVwR+wC7w=;
        b=Y9EwKa9m6s53q/LqMD65TDhypt7Iazuf6sFSCDP85jS9iMiDwvoB7m3NFfiwKvKLt4
         Id4y9FDcy8QvyPT1jqZxHZxAuGsB/AMeJCQUnFFulL/VwLn8/8SUPchvVGZUk7E259on
         Uuu93wK2EyeEPY8tFKvBB1qLiKLKrXTJmVoFxE9+qWuKJbIU5SvRKnnKMAN8Gz0yXklY
         Y9pmIxDDNB+wJbwIf8LZqk6RW1dsy3o6xsHlh499ZHKkjhR7F0GQ3SKtOhAhPZN4nD4G
         0f1tQAcbvap7T7yDp21eid2Bhxl/cNfwxbS4OoYjXAP9oZBtsH0nn1QVY3769T98eRwf
         kjww==
X-Gm-Message-State: AO0yUKVy2gLaTj0I+C8IWqqmqCrHl8xhtLrg5vzeWie1LNwsQ7Vgf3s+
        y0C40Jas2d+Crf1xw2Ra6x6xmA==
X-Google-Smtp-Source: AK7set+r5PhASkThXPj+BSSKPFPWT2nq8eT+XeY2DnDOIzh5J3uIhZ9LayYCBBwqIwSzebzHBCuiOg==
X-Received: by 2002:a05:6214:518f:b0:56e:aa11:da91 with SMTP id kl15-20020a056214518f00b0056eaa11da91mr2203393qvb.14.1678334901632;
        Wed, 08 Mar 2023 20:08:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:d32c])
        by smtp.gmail.com with ESMTPSA id r8-20020ae9d608000000b006f9f3c0c63csm12698858qkk.32.2023.03.08.20.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 20:08:21 -0800 (PST)
Date:   Wed, 8 Mar 2023 23:08:20 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
Message-ID: <20230309040820.GC476158@cmpxchg.org>
References: <20230228085002.2592473-1-yosryahmed@google.com>
 <20230308160056.GA414058@cmpxchg.org>
 <CAJD7tka=6b-U3m0FdMoP=9nC8sYuJ9thghb9muqN5hQ5ZMrDag@mail.gmail.com>
 <20230308201629.GB476158@cmpxchg.org>
 <CAJD7tkbDN2LUG_EZHV8VZd3M4-wtY9TCO5uS2c5qvqEWpoMvoA@mail.gmail.com>
 <20230308212529.GL360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308212529.GL360264@dread.disaster.area>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:25:29AM +1100, Dave Chinner wrote:
> On Wed, Mar 08, 2023 at 12:24:08PM -0800, Yosry Ahmed wrote:
> > > I tried to come up with something better, but wasn't happy with any of
> > > the options, either. So I defaulted to just leaving it alone :-)
> > >
> > > It's part of the shrinker API and the name hasn't changed since the
> > > initial git import of the kernel tree. It should be fine, churn-wise.
> > 
> > Last attempt, just update_reclaim_state() (corresponding to
> > flush_reclaim_state() below). It doesn't tell a story, but neither
> > does incrementing a counter in current->reclaim_state. If that doesn't
> > make you happy I'll give up now and leave it as-is :)
> 
> This is used in different subsystem shrinkers outside mm/, so the
> name needs to be correctly namespaced. Please prefix it with the
> subsystem the function belongs to, at minimum.
> 
> mm_account_reclaimed_pages() is what is actually being done here.
> It is self describing  and leaves behind no ambiguity as to what is
> being accounted and why, nor which subsystem the accounting belongs
> to.
> 
> It doesn't matter what the internal mm/vmscan structures are called,
> all we care about is telling the mm infrastructure how many extra
> pages were freed by the shrinker....

My first preference would still be to just leave it. IMO that one line
saved in a small handful of places isn't worth the indirection,
obscuring the `current' deref etc.

But mm_account_reclaimed_pages() works for me if you really want to
enapsulate it.
