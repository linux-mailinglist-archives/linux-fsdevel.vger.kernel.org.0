Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5B6E2BD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 23:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDNVrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 17:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDNVrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBB1701;
        Fri, 14 Apr 2023 14:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 880EA64A38;
        Fri, 14 Apr 2023 21:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163FBC433D2;
        Fri, 14 Apr 2023 21:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681508825;
        bh=EMmmaBZFjds9BFbgkw7ViAkFOrUh05zvgcFyP1mSUVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hplhZsPGZPwVDi3zxgaoq+7FXFRFNqAlRv/O70IgiUPQTCv7Fa8QHsb0qqSXJpiZh
         uuORn6WrqwZKO7YhkvUAEYpt5f6WtpipwsAVzxA5a4VxEESvtd1PFYQng2fIfFRP+1
         QLsx+GvdCwjsyWw85umJkzFKdYBAQeHlBhPwELa0=
Date:   Fri, 14 Apr 2023 14:47:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        David Hildenbrand <david@redhat.com>,
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 3/3] mm: vmscan: refactor updating
 current->reclaim_state
Message-Id: <20230414144704.2e411d40887c8e9e25ab2864@linux-foundation.org>
In-Reply-To: <CAJD7tkbzQb+gem-49xo8=1EfeOttiHZpD4X-iiWvHuO9rrHuog@mail.gmail.com>
References: <20230413104034.1086717-1-yosryahmed@google.com>
        <20230413104034.1086717-4-yosryahmed@google.com>
        <b7fe839d-d914-80f7-6b96-f5f3a9d0c9b0@redhat.com>
        <CAJD7tkae0uDuRG77nQEtzkV1abGstjF-1jfsCguR3jLNW=Cg5w@mail.gmail.com>
        <20230413210051.GO3223426@dread.disaster.area>
        <CAJD7tkbzQb+gem-49xo8=1EfeOttiHZpD4X-iiWvHuO9rrHuog@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Apr 2023 14:38:03 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> > > I suck at naming things. If you think "reclaimed_non_lru" is better,
> > > then we can do that. FWIW mm_account_reclaimed_pages() was taken from
> > > a suggestion from Dave Chinner. My initial version had a terrible
> > > name: report_freed_pages(), so I am happy with whatever you see fit.
> > >
> > > Should I re-spin for this or can we change it in place?
> >
> > I don't care for the noise all the bikeshed painting has generated
> > for a simple change like this.  If it's a fix for a bug, and the
> > naming is good enough, just merge it already, ok?
> 
> Sorry for all the noise. I think this version is in good enough shape.
> 
> Andrew, could you please replace v4 with this v6 without patch 2 as
> multiple people pointed out that it is unneeded? Sorry for the hassle.

I like patch 2!

mm.git presently has the v6 series.  All of it ;)
