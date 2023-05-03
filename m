Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5F6F5D87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 20:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjECSHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 14:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjECSHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 14:07:31 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D496640C6
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 11:07:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-74e13e46cb9so248472485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683137247; x=1685729247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2w9A9pnL0O0lFcU+PAMU7GlOP92xLISlqVzvjl6lgs=;
        b=PO1zbleTRcn7/zJUq5fpzWyIVOtx3gGn49YYpfEl2F4FWxhiJ5fgQAqy5Gv8Rl7t4b
         4T1zNQ9CTD0v6Fcr+COWEcCatJ8vzRlvWG8SkcACjHLxntxzZs/gG82CwJJWHpWUEONd
         cGLPZ7cNpnCc/t8QVWPqgWnDicnuHXilHjvFQDv/HFMyExCqGPXkMsAxP0THwRZzjpwt
         tJTBaDGCLYadHAPw6twVE7Wlb44jFKBpznb67ElZ6MS4BbXOLmkcX6xIuqSjfiyuXQLI
         RIkz3zaf2yZ3/uiFHSg4JYLFzIuSo/Bm5ju3koRWEJWCC+FYZXCAKhsuD1K2JclzBVmN
         XWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137247; x=1685729247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2w9A9pnL0O0lFcU+PAMU7GlOP92xLISlqVzvjl6lgs=;
        b=XVgLN2RBRPczC7HcmuV3GCe699LV/Ok3VnLKJEAjHJnFdtDwcS2xZ9rfhKPwBjFAe5
         I/V4jjZlVB59bulmyXTdH1rz0N3r3DXQpzzwRUhU2viHnDW5ES9cfTbUMGFJSUfi9g8m
         yq+DRVn525lPZaro8PJeQ2t6irhEtJQ3+Q6PAAnKOvwyFr19RAMJrJ12Wm4oEaRf8J3U
         oUQcITa2iZXNDYV3V2i8pg4V/ZeemZGhVcpYsm9TJPP6bJ83VU/M9ZdgOv9lWqlj2F5w
         vrl91DIZ8S54ft4PMm40QmMynRwYXvmmKBy/5AKoyj1c7h2klwryGeUJwqHoH3MeNM6c
         vGTg==
X-Gm-Message-State: AC+VfDwFEYNVSl9qofGFT5qLRuYTK24cUYifuDLQ0vIiKCi1AS992tnA
        A1FtWAXtYqpLKfqv6017QJ/cyw==
X-Google-Smtp-Source: ACHHUZ4vn0FuCMnCG+kySd2u32Zv4GyyAo20GhKuXAT2/CW7e9UZn2KKViRjxDmYGZnFqwGpJOgsdA==
X-Received: by 2002:a05:6214:20c1:b0:619:4232:aa87 with SMTP id 1-20020a05621420c100b006194232aa87mr11224719qve.24.1683137247516;
        Wed, 03 May 2023 11:07:27 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id a9-20020a0cca89000000b0061b59bcc3edsm1473657qvk.44.2023.05.03.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:07:27 -0700 (PDT)
Date:   Wed, 3 May 2023 14:07:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
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
Message-ID: <20230503180726.GA196054@cmpxchg.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> 
> Cons:
> 
> * BPF has some learning curve. Also the fact that what it provides is a wide
>   open field rather than something scoped out for a specific problem can
>   make it seem a bit daunting at the beginning.
> 
> * Because tracking starts when the script starts running, it doesn't know
>   anything which has happened upto that point, so you gotta pay attention to
>   handling e.g. handling frees which don't match allocs. It's kinda annoying
>   but not a huge problem usually. There are ways to build in BPF progs into
>   the kernel and load it early but I haven't experiemnted with it yet
>   personally.

Yeah, early loading is definitely important, especially before module
loading etc.

One common usecase is that we see a machine in the wild with a high
amount of kernel memory disappearing somewhere that isn't voluntarily
reported in vmstat/meminfo. Reproducing it isn't always
practical. Something that records early and always (with acceptable
runtime overhead) would be the holy grail.

Matching allocs to frees is doable using the pfn as the key for pages,
and virtual addresses for slab objects.

The biggest issue I had when I tried with bpf was losing updates to
the map. IIRC there is some trylocking going on to avoid deadlocks
from nested contexts (alloc interrupted, interrupt frees). It doesn't
sound like an unsolvable problem, though.

Another minor thing was the stack trace map exploding on a basically
infinite number of unique interrupt stacks. This could probably also
be solved by extending the trace extraction API to cut the frames off
at the context switch boundary.

Taking a step back though, given the multitude of allocation sites in
the kernel, it's a bit odd that the only accounting we do is the tiny
fraction of voluntary vmstat/meminfo reporting. We try to cover the
biggest consumers with this of course, but it's always going to be
incomplete and is maintenance overhead too. There are on average
several gigabytes in unknown memory (total - known vmstats) on our
machines. It's difficult to detect regressions easily. And it's per
definition the unexpected cornercases that are the trickiest to track
down. So it might be doable with BPF, but it does feel like the kernel
should do a better job of tracking out of the box and without
requiring too much plumbing and somewhat fragile kernel allocation API
tracking and probing from userspace.
