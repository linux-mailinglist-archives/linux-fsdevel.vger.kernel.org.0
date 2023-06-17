Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94277734370
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbjFQUIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 16:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjFQUIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:08:51 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [95.215.58.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3ED7
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 13:08:48 -0700 (PDT)
Date:   Sat, 17 Jun 2023 16:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687032526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GPGLZsZm64bgwsneBuz+CggZ2M5liImV9Hi4c1vfVF8=;
        b=gMu/KmpiOsd4WxboU74CEmN0ASW32YyMQ3O2HnLKuEG2OEInckYuH9u4Hcn4Y/m/adA6RK
        oHvUYTRmwwSU5lbtGMjzSIEbqT92G5tnSeAlUSc7X2DofpDjdSpKHbkDpm8M+slXEV3qp6
        +cujJdBb6XKSTD8LjB0tCAgIqpoFaQ8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZI4SyXjmA1DsR3Gl@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
 <1d249326-e3dd-9c9d-7b53-2fffeb39bfb4@kernel.org>
 <ZI3Sh6p8b4FcP0Y2@moria.home.lan>
 <1d332a4f-3c45-4e6c-81ca-7f8e669b0366@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d332a4f-3c45-4e6c-81ca-7f8e669b0366@app.fastmail.com>
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

On Sat, Jun 17, 2023 at 12:19:41PM -0700, Andy Lutomirski wrote:
> On Sat, Jun 17, 2023, at 8:34 AM, Kent Overstreet wrote:
> > On Fri, Jun 16, 2023 at 09:13:22PM -0700, Andy Lutomirski wrote:
> >> On 5/16/23 14:20, Kent Overstreet wrote:
> >> > On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
> >> > > For something that small, why not use the text_poke API?
> >> > 
> >> > This looks like it's meant for patching existing kernel text, which
> >> > isn't what I want - I'm generating new functions on the fly, one per
> >> > btree node.
> >> 
> >> Dynamically generating code is a giant can of worms.
> >> 
> >> Kees touched on a basic security thing: a linear address mapped W+X is a big
> >> no-no.  And that's just scratching the surface -- ideally we would have a
> >> strong protocol for generating code: the code is generated in some
> >> extra-secure context, then it's made immutable and double-checked, then
> >> it becomes live.
> >
> > "Double checking" arbitrary code is is fantasy. You can't "prove the
> > security" of arbitrary code post compilation.
> >
> > Rice's theorem states that any nontrivial property of a program is
> > either a direct consequence of the syntax, or is undecidable. It's why
> > programs in statically typed languages are easier to reason about, and
> > it's also why the borrow checker in Rust is a syntactic construct.
> 
> If you want security in some theoretical sense, sure, you're probably right.  But that doesn't stop people from double-checking executable code to quite good effect.  For example:
> 
> https://www.bitdefender.com/blog/businessinsights/bitdefender-releases-landmark-open-source-software-project-hypervisor-based-memory-introspection/
> 
> (I have no personal experience with this, but I know people who do.  It's obviously not perfect, but I think it provides meaningful benefits.)
> 
> I'm not saying Linux should do this internally, but it might not be a terrible idea some day.

So you want to pull a virus scanner into the kernel.

> > You just have to be able to trust the code that generates the code. Just
> > like you have to be able to trust any other code that lives in kernel
> > space.
> >
> > This is far safer and easier to reason about than what BPF is doing
> > because we're not compiling arbitrary code, the actual codegen part is
> > 200 loc and the input is just a single table.
> 
> Great, then propose a model where the codegen operates in an
> extra-safe protected context.  Or pre-generate the most common
> variants, have them pull their constants from memory instead of
> immediates, and use that.

I'll do no such nonsense.

> > If what you were saying was true, it would be an issue any time we
> > mapped in new executable code for userspace - minor page faults would be
> > stupidly slow.
> 
> I literally mentioned this in the email.

No, you didn't. Feel free to link or cite if you think otherwise.

> 
> I don't know _precisely_ what's going on, but I assume it's that it's impossible (assuming the kernel gets TLB invalidation right) for a CPU to have anything buffered for a linear address that is unmapped, so when it gets mapped, the CPU can't have anything stale in its buffers.  (By buffers, I mean any sort of instruction or decoded instruction cache.)
> 
> Having *this* conversation is what I was talking about in regard to possible fancy future optimization.
> 
> >
> > This code has been running on thousands of machines for years, and the
> > only issues that have come up have been due to the recent introduction
> > of indirect branch tracking. x86 doesn't have such broken caches, and
> > architectures that do have utterly broken caches (because that's what
> > you're describing: you're describing caches that _are not coherent
> > across cores_) are not high on my list of things I care about.
> 
> I care.  And a bunch of people who haven't gotten their filesystem corrupted because of a missed serialization.
> 
> >
> > Also, SERIALIZE is a spectre thing. Not relevant here.
> 
> Nope, try again.  SERIALIZE "serializes" in the rather vague sense in the Intel SDM.  I don't think it's terribly useful for Spectre.
> 
> (Yes, I know what I'm talking about.)
> 
> >
> >> Based on the above, I regret to inform you that jit_update() will either
> >> need to sync all cores via IPI or all cores will need to check whether a
> >> sync is needed and do it themselves.
> >
> > text_poke() doesn't even send IPIs.
> 
> text_poke() and the associated machinery is unbelievably complicated.  

It's not that bad.

The only reference to IPIs in text_poke() is the comment that indicates
that flush_tlb_mm_range() may sometimes do IPIs, but explicitly
indicates that it does _not_ do IPIs the way text_poke() is using it.

> Also, arch/x86/kernel/alternative.c contains:
> 
> void text_poke_sync(void)
> {
> 	on_each_cpu(do_sync_core, NULL, 1);
> }

...which is for modifying code that is currently being executed, not the
text_poke() or text_poke_copy() paths.

> 
> The magic in text_poke() was developed over the course of years, and
> Intel architects were involved.
> 
> (And I think some text_poke() stuff uses RCU, which is another way to
> sync without IPI.  I doubt the performance characteristics are
> appropriate for bcachefs, but I could be wrong.)

No, it doesn't use RCU.

> > I think you've been misled about some things :)
> 
> I wish.

Given your comments on text_poke(), I think you are. You're confusing
synchronization requirements for _self modifying_ code with the
synchronization requirements for writing new code to memory, and then
executing it.

And given that bcachefs is not doing anything new here - we're doing a
more limited form of what BPF is already doing - I don't think this is
even the appropriate place for this discussion. There is a new
executable memory allocator being developed and posted, which is
expected to wrap text_poke() in an arch-independent way so that
allocations can share pages, and so that we can remove the need to have
pages mapped both writeable and executable.

If you've got knowledge you wish to share on how to get cache coherency
right, I think that might be a more appropriate thread.
