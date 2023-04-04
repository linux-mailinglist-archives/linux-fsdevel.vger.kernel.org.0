Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FE66D7022
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 00:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjDDW2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 18:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjDDW2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7469540FD;
        Tue,  4 Apr 2023 15:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 176D5636F1;
        Tue,  4 Apr 2023 22:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22B1C433D2;
        Tue,  4 Apr 2023 22:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680647297;
        bh=OTTzTEX5FAK65Ptaf3F55ybCVKywhwaSU+WvIwOcWLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vAxywzSMsDZL7luul1SA1Wj6EjObXuiwGDmtSlEtT+SvrkPVOIA0JNw1CA6wT+m5Z
         nBGk5WBddO3w+W3RLtJXDA5gbBdRLlrbFGYqyZvbSCZKa1ViqyD5s9rA2sjlIf6S9J
         psnAr+yTP9bEUu/UFgIpG/YYV4nCtEIOOZjXlQNI=
Date:   Tue, 4 Apr 2023 15:28:16 -0700
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
Message-Id: <20230404152816.cec6d41bfb9de4680ae8c787@linux-foundation.org>
In-Reply-To: <CAJD7tkZCmkttJo+6XGROo+pmfQ+ppQp6=qukwvAGSeSBEGF+nQ@mail.gmail.com>
References: <20230404001353.468224-1-yosryahmed@google.com>
        <20230404143824.a8c57452f04929da225a17d0@linux-foundation.org>
        <CAJD7tkbZgA7QhkuxEbp=Sam6NCA0i3cZJYF4Z1nrLK1=Rem+Gg@mail.gmail.com>
        <20230404145830.b34afedb427921de2f0e2426@linux-foundation.org>
        <CAJD7tkZCmkttJo+6XGROo+pmfQ+ppQp6=qukwvAGSeSBEGF+nQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 4 Apr 2023 15:00:57 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> ...
>
> > >
> > > Without refactoring the code that adds reclaim_state->reclaimed to
> > > scan_control->nr_reclaimed into a helper (flush_reclaim_state()), the
> > > change would need to be done in two places instead of one, and I
> > > wouldn't know where to put the huge comment.
> >
> > Well, all depends on how desirable it it that we backport.  If "not
> > desirable" then leave things as-is.  If at least "possibly desirable"
> > then a simple patch with the two changes and no elaborate comment will
> > suit.
> >
> 
> I would rather leave the current series as-is with an elaborate
> comment. I can send a separate single patch as a backport to stable if
> this is something that we usually do (though I am not sure how to
> format such patch).

-stable maintainers prefer to take something which has already been
accepted by Linus.

The series could be as simple as

simple-two-liner.patch
revert-simple-two-liner.patch
this-series-as-is.patch

simple-two-liner.patch goes into 6.3-rcX and -stable.  The other
patches into 6.4-rc1.  
