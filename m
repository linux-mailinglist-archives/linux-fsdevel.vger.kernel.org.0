Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EF27341ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjFQPeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 11:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjFQPes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:34:48 -0400
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435351FF3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jun 2023 08:34:45 -0700 (PDT)
Date:   Sat, 17 Jun 2023 11:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687016083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/n1M3rkIqj2fYlcf86oQKmm6toDjWN0ksVwZeIikJo=;
        b=dOatmczg4Jywa17R64WDUuNlLFHSl0gHLdFxUjiRip5Y9HERUHlvyqQktBUOYz3C04QOpZ
        yi8bWqsNiwlZWZ1G/Lf4997PNQLyIwqM+VFcfnJ0l2MuAillQ1X2IWn1/r9IYihlBZtgR0
        NixVJmtd1KAhXd70CJAq2tCS+y+D2d4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZI3Sh6p8b4FcP0Y2@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
 <1d249326-e3dd-9c9d-7b53-2fffeb39bfb4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d249326-e3dd-9c9d-7b53-2fffeb39bfb4@kernel.org>
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

On Fri, Jun 16, 2023 at 09:13:22PM -0700, Andy Lutomirski wrote:
> On 5/16/23 14:20, Kent Overstreet wrote:
> > On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
> > > For something that small, why not use the text_poke API?
> > 
> > This looks like it's meant for patching existing kernel text, which
> > isn't what I want - I'm generating new functions on the fly, one per
> > btree node.
> 
> Dynamically generating code is a giant can of worms.
> 
> Kees touched on a basic security thing: a linear address mapped W+X is a big
> no-no.  And that's just scratching the surface -- ideally we would have a
> strong protocol for generating code: the code is generated in some
> extra-secure context, then it's made immutable and double-checked, then
> it becomes live.

"Double checking" arbitrary code is is fantasy. You can't "prove the
security" of arbitrary code post compilation.

Rice's theorem states that any nontrivial property of a program is
either a direct consequence of the syntax, or is undecidable. It's why
programs in statically typed languages are easier to reason about, and
it's also why the borrow checker in Rust is a syntactic construct.

You just have to be able to trust the code that generates the code. Just
like you have to be able to trust any other code that lives in kernel
space.

This is far safer and easier to reason about than what BPF is doing
because we're not compiling arbitrary code, the actual codegen part is
200 loc and the input is just a single table.

> 
> (When x86 modifies itself at boot or for static keys, it changes out the
> page tables temporarily.)
> 
> And even beyond security, we have correctness.  x86 is a fairly forgiving
> architecture.  If you go back in time about 20 years, modify
> some code *at the same linear address at which you intend to execute it*,
> and jump to it, it works.  It may even work if you do it through
> an alias (the manual is vague).  But it's not 20 years ago, and you have
> multiple cores.  This does *not* work with multiple CPUs -- you need to
> serialize on the CPU executing the modified code.  On all the but the very
> newest CPUs, you need to kludge up the serialization, and that's
> sloooooooooooooow.  Very new CPUs have the SERIALIZE instruction, which
> is merely sloooooow.

If what you were saying was true, it would be an issue any time we
mapped in new executable code for userspace - minor page faults would be
stupidly slow.

This code has been running on thousands of machines for years, and the
only issues that have come up have been due to the recent introduction
of indirect branch tracking. x86 doesn't have such broken caches, and
architectures that do have utterly broken caches (because that's what
you're describing: you're describing caches that _are not coherent
across cores_) are not high on my list of things I care about.

Also, SERIALIZE is a spectre thing. Not relevant here.

> Based on the above, I regret to inform you that jit_update() will either
> need to sync all cores via IPI or all cores will need to check whether a
> sync is needed and do it themselves.

text_poke() doesn't even send IPIs.

I think you've been misled about some things :)
