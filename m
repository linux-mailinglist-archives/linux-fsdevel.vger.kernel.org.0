Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225966F5DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjECSNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjECSNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:13:09 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F019A2
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 11:13:05 -0700 (PDT)
Date:   Wed, 3 May 2023 14:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683137583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bFNCoxPB6ZGjmPXwS7aActt9s9ZGw8uNq57D7UKDjKM=;
        b=siD6JyeicdLYm9Q2yXmRLr5ySGXSB2lV1k50m3UiM0GKRXv1RttykEM7dYP8xs5X197IgJ
        jBtAc6ZM4L3Wd+zT4HheIwdrdCZIcmEPDStAu9bPcBItsW2S45BekRwud2QX4sDZVSICcP
        fDDddqmELDDTv0N0zR7Bb5BfCgDoj40=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
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
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
        elver@google.com, dvyukov@google.com, shakeelb@google.com,
        songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
        minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <ZFKkJJ8+/uD0tPMM@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com>
 <20230503122839.0d9934c5@gandalf.local.home>
 <CAJuCfpFYq7CZS4y2ZiF+AJHRKwnyhmZCk_uuTwFse26DxGh-qQ@mail.gmail.com>
 <20230503140337.0f7127b2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503140337.0f7127b2@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 02:03:37PM -0400, Steven Rostedt wrote:
> On Wed, 3 May 2023 10:40:42 -0700
> Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > > This approach is actually quite common, especially since tagging every
> > > instance is usually overkill, as if you trace function calls in a running
> > > kernel, you will find that only a small percentage of the kernel ever
> > > executes. It's possible that you will be allocating a lot of tags that will
> > > never be used. If run time allocation is possible, that is usually the
> > > better approach.  
> > 
> > True but the memory overhead should not be prohibitive here. As a
> > ballpark number, on my machine I see there are 4838 individual
> > allocation locations and each codetag structure is 32 bytes, so that's
> > 152KB.
> 
> If it's not that big, then allocating at runtime should not be an issue
> either. If runtime allocation can make it less intrusive to the code, that
> would be more rationale to do so.

We're more optimizing for runtime overhead - a major goal of this
patchset was to be cheap enough to be always on, we've got too many
debugging features that are really useful, but too expensive to have on
all the time.

Doing more runtime allocation would add another pointer fetch to the
fast paths - and I don't see how it would even be possible to runtime
allocate the codetag struct itself.

We already do runtime allocation of percpu counters; see the lazy percpu
counter patch.
