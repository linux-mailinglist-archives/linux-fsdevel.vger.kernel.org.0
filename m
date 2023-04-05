Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE016D8640
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjDESsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 14:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDESsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8317F5589;
        Wed,  5 Apr 2023 11:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20DD663E7A;
        Wed,  5 Apr 2023 18:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E15C433D2;
        Wed,  5 Apr 2023 18:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680720523;
        bh=85pV6+BglfXFKvptSlWlbOdngDBPoHAexzT1F8MZ1Eg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iPO5fkws81xBu9pR7DaAYQI4BPxx98OJkIPiL6CBk6R1G2Yj+M8OBx/s/22f1I7z0
         S6Q36YH2bTWlS6uTqW558FNdIB/nocqcwr8J3KxpkVxQxwX4MtYY7H9MIJ0vXlRoW1
         4WFXG8M2wulSta8dxKzFQSR6Cj1eiSRDv1uHfua4=
Date:   Wed, 5 Apr 2023 11:48:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] Ignore non-LRU-based reclaim in memcg reclaim
Message-Id: <20230405114841.248dffb65526383823c71d60@linux-foundation.org>
In-Reply-To: <CAJD7tkYFZGJqZ278stOWDyW3HgMP8iyAZu8hSG+bV-p9YoVxig@mail.gmail.com>
References: <20230404001353.468224-1-yosryahmed@google.com>
        <20230404143824.a8c57452f04929da225a17d0@linux-foundation.org>
        <CAJD7tkbZgA7QhkuxEbp=Sam6NCA0i3cZJYF4Z1nrLK1=Rem+Gg@mail.gmail.com>
        <20230404145830.b34afedb427921de2f0e2426@linux-foundation.org>
        <CAJD7tkZCmkttJo+6XGROo+pmfQ+ppQp6=qukwvAGSeSBEGF+nQ@mail.gmail.com>
        <20230404152816.cec6d41bfb9de4680ae8c787@linux-foundation.org>
        <20230404153124.b0fa5074cf9fc3b9925e8000@linux-foundation.org>
        <CAJD7tkYFZGJqZ278stOWDyW3HgMP8iyAZu8hSG+bV-p9YoVxig@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 4 Apr 2023 16:46:30 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> > But the key question remains: how desirable is a backport?
> >
> > Looking at the changelogs I'm not seeing a clear statement of the
> > impact upon real-world users' real-world workloads.  (This is a hint).
> > So I am unable to judge.
> >
> > Please share your thoughts on this.
> 
> I think it's nice to have but not really important. It occasionally
> causes writes to memory.reclaim to report false positives and *might*
> cause unnecessary retrying when charging memory, but probably too rare
> to be a practical problem.
> 
> Personally, I intend to backport to our kernel at Google because it's
> a simple enough fix and we have occasionally seen test flakiness
> without it.
> 
> I have a reworked version of the series that only has 2 patches:
> - simple-two-liner-patch (actually 5 lines)
> - one patch including all refactoring squashed (introducing
> flush_reclaim_state() with the huge comment, introducing
> mm_account_reclaimed_pages(), and moving set_task_reclaim_state()
> around).
> 
> Let me know if you want me to send it as v5, or leave the current v4
> if you think backporting is not generally important.

Let's have a look at that v5 and see what people think?
