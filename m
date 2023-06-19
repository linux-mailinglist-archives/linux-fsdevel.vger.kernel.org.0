Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C085735DD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjFSTRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjFSTRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:17:53 -0400
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [IPv6:2001:41d0:203:375::22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ACEE60
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 12:17:47 -0700 (PDT)
Date:   Mon, 19 Jun 2023 15:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687202265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kyPXfpVQ4C+B8nMExw9vaxU/T8HvIqFX6/+tZpsWRZk=;
        b=W7xeUfMhioXlZpOSNVtKa+8xBg0rix59OVcvUz35FaQQkLVc47A7lTZtgKbJBJG24Mk9tl
        m35qopb39p/Ct2MnipRlyA/LcAg0HZiWjSxkZeLfnuuhcbqmaQ9YzzJ/82jSptrRvF4VG1
        bjM/b2Ad03rEpWR1gMybH8+6KcYzd+M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230619191740.2qmlza3inwycljih@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
 <20230619104717.3jvy77y3quou46u3@moria.home.lan>
 <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 01:47:18PM +0100, Mark Rutland wrote:
> Sorry, but I do have an engineering rationale here: I want to make sure that
> this actually works, on architectures that I care about, and will be
> maintanable long-term.
> 
> We've had a bunch of problems with other JITs ranging from JIT-local "we got
> the encoding wrong" to major kernel infrastructure changes like tasks RCU rude
> synchronization. I'm trying to figure out whether any of those are likely to
> apply and/or whether we should be refactoring other infrastructure for use here
> (e.g. the factoring the acutal instruction generation from arch code, or
> perhaps reusing eBPF so this can be arch-neutral).
> 
> I appreciate that's not clear from my initial mail, but please don't jump
> straight to assuming I'm adversarial here.

I know you're not trying to be adversarial, but vague negative feedback
_is_ hostile, because productive technical discussions can't happen
without specifics and you're putting all the onus on the other person to
make that happen.

When you're raising an issue, try be specific - don't make people dig.
If you're unable to be specific, perhaps you're not the right person to
be raising the issue.

I'm of course happy to answer questions that haven't already been asked.

This code is pretty simple as JITs go. With the existing, vmalloc_exec()
based code, there aren't any fancy secondary mappings going on, so no
crazy cache coherency games, and no crazy syncronization issues to worry
about: the jit functions are protected by the per-btree-node locks.

vmalloc_exec() isn't being upstreamed however, since people don't want
WX mappings.

The infrastructure changes we need (and not just for bcachefs) are
 - better executable memory allocation API, with support for sub-page
   allocations: this is already being worked on, the prototype slab
   allocator I posted is probably going to be the basis for part of this

 - an arch indepenendent version of text_poke(): we don't want user code
   to be flipping page permissions to update text, text_poke() is the
   proper API but it's x86 only. No one has volunteered for this yet.

Re-using eBPF for bcachefs's unpack functions is not outside the realm
of possibility, but BPF is a heavy, complex dependency - it's not
something I'll be looking at unless the BPF people are volunteering to
refactor their stuff to provide a suitable API.

> One thing I note mmediately is that HAVE_BCACHEFS_COMPILED_UNPACK seems to be
> x86-only. If this is important, that'll need some rework to either be
> arch-neutral or allow for arch-specific implementations.

Correct. Arm will happen at some point, but it's not an immediate
priority.
