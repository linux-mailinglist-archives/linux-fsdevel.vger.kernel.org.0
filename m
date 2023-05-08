Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69FD6FB87F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 22:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjEHUsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 16:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjEHUsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 16:48:45 -0400
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B075BAA;
        Mon,  8 May 2023 13:48:42 -0700 (PDT)
Date:   Mon, 8 May 2023 16:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683578919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9yUrg/v5raybQi2xKwTXiJDyugUh7KFNSbnsbVf1ko=;
        b=JlOqRkPdzk5AJhxPMwu8AlexUvrKA9kXRniMs6KXFAxkkCykU6KjHBDIF+g4xO4yC/3Xao
        +RuScEMByhVbOYP7Nl+Ojs+6ZTV4KDzSfRqi3slN82Zdtt1OUgviKekasieY9DgexpymM2
        tFWfTgTgTslrvfQsG/FcZTuRpfPmr6I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, corbet@lwn.net,
        void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
        ldufour@linux.ibm.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
        david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
        tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
        paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
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
Message-ID: <ZFlgG02A87qPNIn1@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <CAJuCfpHxbYFxDENYFfnggh1D8ot4s493PQX0C7kD-JLvixC-Vg@mail.gmail.com>
 <ZFN1yswCd9wRgYPR@dhcp22.suse.cz>
 <ZFfd99w9vFTftB8D@moria.home.lan>
 <20230508175206.7dc3f87c@meshulam.tesarici.cz>
 <ZFkb1p80vq19rieI@moria.home.lan>
 <20230508180913.6a018b21@meshulam.tesarici.cz>
 <ZFkjRBCExpXfI+O5@moria.home.lan>
 <20230508205939.0b5b485c@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230508205939.0b5b485c@meshulam.tesarici.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 08, 2023 at 08:59:39PM +0200, Petr Tesařík wrote:
> On Mon, 8 May 2023 12:28:52 -0400
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Mon, May 08, 2023 at 06:09:13PM +0200, Petr Tesařík wrote:
> > > Sure, although AFAIK the index does not cover all possible config
> > > options (so non-x86 arch code is often forgotten). However, that's the
> > > less important part.
> > > 
> > > What do you do if you need to hook something that does conflict with an
> > > existing identifier?  
> > 
> > As already happens in this patchset, rename the other identifier.
> > 
> > But this is C, we avoid these kinds of conflicts already because the
> > language has no namespacing
> 
> This statement is not accurate, but I agree there's not much. Refer to
> section 6.2.3 of ISO/IEC9899:2018 (Name spaces of identifiers).
> 
> More importantly, macros also interfere with identifier scoping, e.g.
> you cannot even have a local variable with the same name as a macro.
> That's why I dislike macros so much.

Shadowing a global identifier like that would at best be considered poor
style, so I don't see this as a major downside.

> But since there's no clear policy regarding macros in the kernel, I'm
> merely showing a downside; it's perfectly fine to write kernel code
> like this as long as the maintainers agree that the limitation is
> acceptable and outweighed by the benefits.

Macros do have lots of tricky downsides, but in general we're not shy
about using them for things that can't be done otherwise; see
wait_event(), all of tracing...

I think we could in general do a job of making the macros _themselves_
more managable, when writing things that need to be macros I'll often
have just the wrapper as a macro and write the bulk as inline functions.
See the generic radix tree code for example.

Reflection is a major use case for macros, and the underlying mechanism
here - code tagging - is something worth talking about more, since it's
codifying something that's been done ad-hoc in the kernel for a long
time and something we hope to refactor other existing code to use,
including tracing - I've got a patch already written to convert the
dynamic debug code to code tagging; it's a nice -200 loc cleanup.

Regarding the alloc_hooks() macro itself specifically, I've got more
plans for it. I have another patch series after this one that implements
code tagging based fault injection, which is _far_ more ergonomic to use
than our existing fault injection capabilities (and this matters! Fault
injection is a really important tool for getting good test coverage, but
tools that are a pain in the ass to use don't get used) - and with the
alloc_hooks() macro already in place, we'll be able to turn _every
individual memory allocation callsite_ into a distinct, individually
selectable fault injection point - which is something our existing fault
injection framework attempts at but doesn't really manage.

If we can get this in, it'll make it really easy to write unit tests
that iterate over every memory allocation site in a given module,
individually telling them to fail, run a workload until they hit, and
verify that the code path being tested was executed. It'll nicely
complement the fuzz testing capabilities that we've been working on,
particularly in filesystem land.
