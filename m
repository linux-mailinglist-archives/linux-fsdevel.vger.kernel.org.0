Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC376D6F0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 23:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjDDVi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 17:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbjDDVi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9623AA5;
        Tue,  4 Apr 2023 14:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4611E639B3;
        Tue,  4 Apr 2023 21:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFF4C433EF;
        Tue,  4 Apr 2023 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680644305;
        bh=L5F2ijKJ66iY+tJ/pkWPhA0L85I65eReAl6XPsdsEq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pPvHdb0yFSvdhEjkpnDHkJpDSYIqO9+rJ0i0vzFM0UfaUWcUa/87vu35+3p8R8YKU
         UKrdBpvWEGBHZT2cLMmPrq7jqnM2XPuGc/2vBV1rNQqmEXKP0l5woJUTRpFidtxSUv
         9F6cYTBVBoMNbEr+6Gz0a5vSpYxeVhtRmuGpWy+I=
Date:   Tue, 4 Apr 2023 14:38:24 -0700
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
Message-Id: <20230404143824.a8c57452f04929da225a17d0@linux-foundation.org>
In-Reply-To: <20230404001353.468224-1-yosryahmed@google.com>
References: <20230404001353.468224-1-yosryahmed@google.com>
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

On Tue,  4 Apr 2023 00:13:50 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> Upon running some proactive reclaim tests using memory.reclaim, we
> noticed some tests flaking where writing to memory.reclaim would be
> successful even though we did not reclaim the requested amount fully.
> Looking further into it, I discovered that *sometimes* we over-report
> the number of reclaimed pages in memcg reclaim.
> 
> Reclaimed pages through other means than LRU-based reclaim are tracked
> through reclaim_state in struct scan_control, which is stashed in
> current task_struct. These pages are added to the number of reclaimed
> pages through LRUs. For memcg reclaim, these pages generally cannot be
> linked to the memcg under reclaim and can cause an overestimated count
> of reclaimed pages. This short series tries to address that.
> 
> Patches 1-2 are just refactoring, they add helpers that wrap some
> operations on current->reclaim_state, and rename
> reclaim_state->reclaimed_slab to reclaim_state->reclaimed.
> 
> Patch 3 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
> The pages are uncharged anyway, so even if we end up under-reporting
> reclaimed pages we will still succeed in making progress during
> charging.
> 
> Do not let the diff stat deceive you, the core of this series is patch 3,
> which has one line of code change. All the rest is refactoring and one
> huge comment.
> 

Wouldn't it be better to do this as a single one-line patch for
backportability?  Then all the refactoring etcetera can be added on
later.
