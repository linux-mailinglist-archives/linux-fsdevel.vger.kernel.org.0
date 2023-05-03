Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8607C6F5568
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjECJ4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 05:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjECJzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 05:55:36 -0400
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [IPv6:2001:41d0:203:375::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47CE4C13
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 02:54:58 -0700 (PDT)
Date:   Wed, 3 May 2023 05:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683107695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jg445jwECvvRmiCScPtVAaWcZXXyMj8rYmSMQmAKTHE=;
        b=lCllcENijvyC1ebNj7URRaDdhwEZW7RyfvbYg1fVUeO79bulTkt3RjYJG2jVCHzwR7Pc3x
        HUxyBBuo+xgNeAXZgmwQd3P2gPgxlM+XgMIkSt4fwh5HjNr9tfDeILYa8rca8iOp4VrOxy
        Ufos0rVn5Brx5c1dPWhOO5ah3BGV4Lc=
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
Message-ID: <ZFIvY5p1UAXxHw9s@moria.home.lan>
References: <20230501165450.15352-1-surenb@google.com>
 <ZFIMaflxeHS3uR/A@dhcp22.suse.cz>
 <ZFIOfb6/jHwLqg6M@moria.home.lan>
 <ZFISlX+mSx4QJDK6@dhcp22.suse.cz>
 <20230503115051.30b8a97f@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230503115051.30b8a97f@meshulam.tesarici.cz>
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

On Wed, May 03, 2023 at 11:50:51AM +0200, Petr Tesařík wrote:
> On Wed, 3 May 2023 09:51:49 +0200
> Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Wed 03-05-23 03:34:21, Kent Overstreet wrote:
> >[...]
> > > We've made this as clean and simple as posssible: a single new macro
> > > invocation per allocation function, no calling convention changes (that
> > > would indeed have been a lot of churn!)  
> > 
> > That doesn't really make the concern any less relevant. I believe you
> > and Suren have made a great effort to reduce the churn as much as
> > possible but looking at the diffstat the code changes are clearly there
> > and you have to convince the rest of the community that this maintenance
> > overhead is really worth it.
> 
> I believe this is the crucial point.
> 
> I have my own concerns about the use of preprocessor macros, which goes
> against the basic idea of a code tagging framework (patch 13/40).
> AFAICS the CODE_TAG_INIT macro must be expanded on the same source code
> line as the tagged code, which makes it hard to use without further
> macros (unless you want to make the source code unreadable beyond
> imagination). That's why all allocation functions must be converted to
> macros.
> 
> If anyone ever wants to use this code tagging framework for something
> else, they will also have to convert relevant functions to macros,
> slowly changing the kernel to a minefield where local identifiers,
> struct, union and enum tags, field names and labels must avoid name
> conflict with a tagged function. For now, I have to remember that
> alloc_pages is forbidden, but the list may grow.

No, we've got other code tagging applications (that have already been
posted!) and they don't "convert functions to macros" in the way this
patchset does - they do introduce new macros, but as new identifiers,
which we do all the time.

This was simply the least churny way to hook memory allocations.
