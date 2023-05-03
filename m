Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E586F5B1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjECP20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 11:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjECP2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 11:28:24 -0400
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7C59F0
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 08:28:21 -0700 (PDT)
Date:   Wed, 3 May 2023 11:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683127699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFYIJmhJAvKFo5pe5s/5UJk4QkyDXcesgOEFEoMRDNY=;
        b=boB83q/e6dPpScD3oLrI6VUwakIoR3LUhGCnyQMCxASyO8r2l7zqVdmDFRo6uwurhNcS1T
        cRfqdo7eOirckrWyHsy41sri7bXWHG3o1Yaz8fCtLlrA1TZnZIeBqJQBjgDeSjUqnZVKbs
        djBS6eWHow6oQykPfZoNtjmwnPDbnB8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        Michal Hocko <mhocko@suse.com>,
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
Message-ID: <ZFJ9hlQ3ZIU1XYCY@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <20230503115051.30b8a97f@meshulam.tesarici.cz>
 <ZFIv+30UH7+ySCZr@moria.home.lan>
 <25a1ea786712df5111d7d1db42490624ac63651e.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25a1ea786712df5111d7d1db42490624ac63651e.camel@HansenPartnership.com>
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

On Wed, May 03, 2023 at 08:33:48AM -0400, James Bottomley wrote:
> On Wed, 2023-05-03 at 05:57 -0400, Kent Overstreet wrote:
> > On Wed, May 03, 2023 at 11:50:51AM +0200, Petr Tesařík wrote:
> > > If anyone ever wants to use this code tagging framework for
> > > something
> > > else, they will also have to convert relevant functions to macros,
> > > slowly changing the kernel to a minefield where local identifiers,
> > > struct, union and enum tags, field names and labels must avoid name
> > > conflict with a tagged function. For now, I have to remember that
> > > alloc_pages is forbidden, but the list may grow.
> > 
> > Also, since you're not actually a kernel contributor yet...
> 
> You have an amazing talent for being wrong.  But even if you were
> actually right about this, it would be an ad hominem personal attack on
> a new contributor which crosses the line into unacceptable behaviour on
> the list and runs counter to our code of conduct.

...Err, what? That was intended _in no way_ as a personal attack.

If I was mistaken I do apologize, but lately I've run across quite a lot
of people offering review feedback to patches I post that turn out to
have 0 or 10 patches in the kernel, and - to be blunt - a pattern of
offering feedback in strong language with a presumption of experience
that takes a lot to respond to adequately on a technical basis.

I don't think a suggestion to spend a bit more time reading code instead
of speculating is out of order! We could all, put more effort into how
we offer review feedback.
