Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8850F20A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 09:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbiDZHUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbiDZHUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:20:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7F8BF6E;
        Tue, 26 Apr 2022 00:17:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2E6E210EA;
        Tue, 26 Apr 2022 07:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650957460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E341m0oGAZ8uwfYf1PyOsWw2EY2ezQuuipQASY4qGhM=;
        b=HDAJXwas5NvCqoiwQ7rHZHQ0CIxgB0k64TTcJDFBbBPmbmlYEtZEgoyDMKzktRiMq8g43s
        jbaUFHMY7zDJ0b7SsFz/ywwwxzjoQKkex/6FYfVDeotPaaGalAH5DhVqFUbjp+N9ReAUB2
        EIfEH/eIZDzw3BtusTQi5w69L1izR3Y=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4270D2C141;
        Tue, 26 Apr 2022 07:17:40 +0000 (UTC)
Date:   Tue, 26 Apr 2022 09:17:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <Ymeck8AaTwaB29KS@dhcp22.suse.cz>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan>
 <YmNH/fh8OwTJ6ASC@carbon>
 <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
 <YmZpuikkgWeF2RPt@dhcp22.suse.cz>
 <20220425152811.pg2dse4zybpnpaa4@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425152811.pg2dse4zybpnpaa4@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-04-22 11:28:11, Kent Overstreet wrote:
> On Mon, Apr 25, 2022 at 11:28:26AM +0200, Michal Hocko wrote:
> > 
> > > Do you know if using memalloc_noreclaim_(save|restore) is sufficient for that,
> > > or do we want GFP_ATOMIC? I'm already using GFP_ATOMIC for allocations when we
> > > generate the report on slabs, since we're taking the slab mutex there.
> > 
> > No it's not. You simply _cannot_ allocate from the oom context.
> 
> Hmm, no, that can't be right. I've been using the patch set and it definitely
> works, at least in my testing.

Yes, the world will not fall down and it really depends on the workload
what kind of effect this might have.

> Do you mean to say that we shouldn't? Can you explain why?

I have already touched on that but let me reiterate. Allocation context
called from the oom path will have an unbound access to memory reserves.
Those are a last resort emergency pools of memory that are not available
normally and there are areas which really depend on them to make a
further progress to release the memory pressure.

Swap over NFS would be one such example. If some other code path messes
with those reserves the swap IO path could fail with all sorts of
fallouts.

So to be really exact in my statement. You can allocate from the OOM
context but it is _strongly_ discouraged unless there is no other way
around that.

I would even claim that the memory reclaim in general shouldn't rely on
memory allocations (other than mempools). If an allocation is really
necessary then an extra care has to prevent from complete memory
depletion.
-- 
Michal Hocko
SUSE Labs
