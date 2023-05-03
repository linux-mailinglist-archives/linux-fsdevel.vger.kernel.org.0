Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA06F5D38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjECRpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 13:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjECRpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 13:45:14 -0400
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01276BF
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 10:45:11 -0700 (PDT)
Date:   Wed, 3 May 2023 13:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683135908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VLjEZmUZdVYCB3vahsC4N4RlfMUKbdvDvHs1QSrBbkc=;
        b=Bqk+D3wkDUmlYZ1as8gRsPGcBGwt1SpSgZ4HIXBomyou3scD9fsxFx8d9Pi9i0plH0MlvB
        Wz5W7oioStPfXkk2kiF/4sAZhv4YdHhahVNxY2sEvKz1jU0Q3fpXkK6JN4TWTcevaEcWHI
        xj1ZN9ZDwCFrzS5sVFM3Iqdhgz6ddic=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Tejun Heo <tj@kernel.org>
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
Message-ID: <ZFKdmMe21U3LqGGD@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <ZFIVtB8JyKk0ddA5@moria.home.lan>
 <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
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

On Wed, May 03, 2023 at 06:35:49AM -1000, Tejun Heo wrote:
> Hello, Kent.
> 
> On Wed, May 03, 2023 at 04:05:08AM -0400, Kent Overstreet wrote:
> > No, we're still waiting on the tracing people to _demonstrate_, not
> > claim, that this is at all possible in a comparable way with tracing. 
> 
> So, we (meta) happen to do stuff like this all the time in the fleet to hunt
> down tricky persistent problems like memory leaks, ref leaks, what-have-you.
> In recent kernels, with kprobe and BPF, our ability to debug these sorts of
> problems has improved a great deal. Below, I'm attaching a bcc script I used
> to hunt down, IIRC, a double vfree. It's not exactly for a leak but leaks
> can follow the same pattern.
> 
> There are of course some pros and cons to this approach:
> 
> Pros:
> 
> * The framework doesn't really have any runtime overhead, so we can have it
>   deployed in the entire fleet and debug wherever problem is.
> 
> * It's fully flexible and programmable which enables non-trivial filtering
>   and summarizing to be done inside kernel w/ BPF as necessary, which is
>   pretty handy for tracking high frequency events.
> 
> * BPF is pretty performant. Dedicated built-in kernel code can do better of
>   course but BPF's jit compiled code & its data structures are fast enough.
>   I don't remember any time this was a problem.

You're still going to have the inherent overhead a separate index of
outstanding memory allocations, so that frees can be decremented to the
correct callsite.

The BPF approach is going to be _way_ higher overhead if you try to use
it as a general profiler, like this is.
