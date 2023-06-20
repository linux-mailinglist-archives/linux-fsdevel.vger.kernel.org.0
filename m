Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D018E7375F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjFTUTV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjFTUTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:19:19 -0400
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [IPv6:2001:41d0:1004:224b::17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF4419A2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 13:18:59 -0700 (PDT)
Date:   Tue, 20 Jun 2023 16:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687292337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AknCkCooyVujKThdxC1FM7ZvENiuN9/CmEk5IHQ7iJc=;
        b=XuzztPfVVe+3n5nJEOjm27aqlllgXuZQ6rVKnaNP1qE0QAgMdGx6B41jDrtlCUaSZVvcwB
        aFXG7iOPoRS+k3iuIDq6aCVJVdfwEIwxm8O1jeyxNx8BlQuDXJKsTMlQrOrb4Uy0Osm8So
        ZIKImGyM50seypVLOxcay429rYAWiDE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230620201851.qrcabl327mrofygb@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
 <20230619104717.3jvy77y3quou46u3@moria.home.lan>
 <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
 <20230619191740.2qmlza3inwycljih@moria.home.lan>
 <5ef2246b-9fe5-4206-acf0-0ce1f4469e6c@app.fastmail.com>
 <20230620180839.oodfav5cz234pph7@moria.home.lan>
 <dcf8648b-c367-47a5-a2b6-94fb07a68904@app.fastmail.com>
 <37d2378e-72de-e474-5e25-656b691384ba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d2378e-72de-e474-5e25-656b691384ba@intel.com>
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

On Tue, Jun 20, 2023 at 11:48:26AM -0700, Dave Hansen wrote:
> >> No, I'm saying your concerns are baseless and too vague to
> >> address.
> > If you don't address them, the NAK will stand forever, or at least
> > until a different group of people take over x86 maintainership.
> > That's fine with me.
> 
> I've got a specific concern: I don't see vmalloc_exec() used in this
> series anywhere.  I also don't see any of the actual assembly that's
> being generated, or the glue code that's calling into the generated
> assembly.
>
> I grepped around a bit in your git trees, but I also couldn't find it in
> there.  Any chance you could help a guy out and point us to some of the
> specifics of this new, tiny JIT?

vmalloc_exec() has already been dropped from the patchset - I'll switch
to the new jit allocator when that's available and doing sub-page
allocations.

I can however point you at the code that generates the unpack functions:

https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/bkey.c#n727

> >> Andy, I replied explaining the difference between text_poke() and
> >> text_poke_sync(). It's clear you have no idea what you're talking about,
> >> so I'm not going to be wasting my time on further communications with
> >> you.
> 
> One more specific concern: This comment made me very uncomfortable and
> it read to me very much like a personal attack, something which is
> contrary to our code of conduct.

It's not; I prefer to be direct than passive aggressive, and if I have
to bow out of a discussion that isn't going anywhere I feel I owe an
explanation of _why_. Too much conflict avoidance means things don't get
resolved.

And Andy and I are talking on IRC now, so things are proceeding in a
better direction.
