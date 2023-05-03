Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D56F52CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjECILK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 04:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjECILI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 04:11:08 -0400
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [IPv6:2001:41d0:203:375::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4895198E
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 01:10:37 -0700 (PDT)
Date:   Wed, 3 May 2023 04:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683101119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Af+2O/2Jo9IC9XECoO60Ibec+DnzA9yRBnuv4Bp8O9Y=;
        b=rqHkCee1X71Oj3G6VysOrsK/rdJHy9B0yyXfZMJ4T4TWGYp3bKIJl27dUenlhtN0eAw3EY
        9wtRJDXX0Vxp+Xc6ZM2YYwJwQELwnDdfgbU2buAGO1Vb841r/qxmb4h0I2pylWL1m2aZFQ
        DMBUFXd/kgyZZl04aMULTG8rjWs+sv0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
        peterz@infradead.org, juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFIVtB8JyKk0ddA5@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 09:51:49AM +0200, Michal Hocko wrote:
> Your answers have shown your insight into tracing is very limited. I
> have a clear recollection there were many suggestions on how to get what
> you need and willingness to help out. Repeating your previous position
> will not help much to be honest with you.

Please enlighten us, oh wise one.

> > > - It has been brought up that this is duplicating functionality already
> > >   available via existing tracing infrastructure. You should make it very
> > >   clear why that is not suitable for the job
> > 
> > Tracing people _claimed_ this, but never demonstrated it.
> 
> The burden is on you and Suren. You are proposing the implement an
> alternative tracing infrastructure.

No, we're still waiting on the tracing people to _demonstrate_, not
claim, that this is at all possible in a comparable way with tracing. 

It's not on us to make your argument for you, and before making
accusations about honesty you should try to be more honest yourself.

The expectations you're trying to level have never been the norm in the
kernel community, sorry. When there's a technical argument about the
best way to do something, _code wins_ and we've got working code to do
something that hasn't been possible previously.

There's absolutely no rule that "tracing has to be the one and only tool
for kernel visibility".

I'm considering the tracing discussion closed until someone in the
pro-tracing camp shows something new.

> > > - We already have page_owner infrastructure that provides allocation
> > >   tracking data. Why it cannot be used/extended?
> > 
> > Page owner is also very high overhead,
> 
> Is there any data to prove that claim? I would be really surprised that
> page_owner would give higher overhead than page tagging with profiling
> enabled (there is an allocation for each allocation request!!!). We can
> discuss the bare bone page tagging comparision to page_owner because of
> the full stack unwinding but is that overhead really prohibitively costly?
> Can we reduce that by trimming the unwinder information?

Honestly, this isn't terribly relevant, because as noted before page
owner is limited to just page allocations.

> 
> > and the output is not very user
> > friendly (tracking full call stack means many related overhead gets
> > split, not generally what you want), and it doesn't cover slab.
> 
> Is this something we cannot do anything about? Have you explored any
> potential ways?
> 
> > This tracks _all_ memory allocations - slab, page, vmalloc, percpu.

Michel, the discussions with you seem to perpetually go in circles; it's
clear you're negative on the patchset, you keep raising the same
objections while refusing to concede a single point.

I believe I've answered enough, so I'll leave off further discussions
with you.
