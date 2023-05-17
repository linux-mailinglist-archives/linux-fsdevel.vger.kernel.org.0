Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E2706AE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjEQOSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjEQOSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 10:18:21 -0400
Received: from out-35.mta0.migadu.com (out-35.mta0.migadu.com [IPv6:2001:41d0:1004:224b::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34D459D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 07:18:18 -0700 (PDT)
Date:   Wed, 17 May 2023 10:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684333096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJ5xyIjdnqOODdgYyT/tGprQTvXceNzR+PcU18XJA2Y=;
        b=DRkNRqw2cpxP72oh9ESo41gFutZSDl+YmWd79P8rLziplWE9cmhMThXeM5UNfH3kBgthIO
        a2S1CSe8ZEfb6r9FtPGIm+83nqHbWlyB9vWkyhrNJhAK04eoQo+AdJg4SsVr1UUtpeiZoX
        R3WCAJelUZMAB+z0U6eH56SZab8kKuQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        song@kernel.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZGTiI49s8+YjBxVX@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
 <ZGP54T0d89TMySsf@casper.infradead.org>
 <ZGRmC2Qhe6oAHPIm@moria.home.lan>
 <ZGTe6zFYL25fNwcw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGTe6zFYL25fNwcw@kernel.org>
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

On Wed, May 17, 2023 at 05:04:27PM +0300, Mike Rapoport wrote:
> On Wed, May 17, 2023 at 01:28:43AM -0400, Kent Overstreet wrote:
> > On Tue, May 16, 2023 at 10:47:13PM +0100, Matthew Wilcox wrote:
> > > On Tue, May 16, 2023 at 05:20:33PM -0400, Kent Overstreet wrote:
> > > > On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
> > > > > For something that small, why not use the text_poke API?
> > > > 
> > > > This looks like it's meant for patching existing kernel text, which
> > > > isn't what I want - I'm generating new functions on the fly, one per
> > > > btree node.
> > > > 
> > > > I'm working up a new allocator - a (very simple) slab allocator where
> > > > you pass a buffer, and it gives you a copy of that buffer mapped
> > > > executable, but not writeable.
> > > > 
> > > > It looks like we'll be able to convert bpf, kprobes, and ftrace
> > > > trampolines to it; it'll consolidate a fair amount of code (particularly
> > > > in bpf), and they won't have to burn a full page per allocation anymore.
> > > > 
> > > > bpf has a neat trick where it maps the same page in two different
> > > > locations, one is the executable location and the other is the writeable
> > > > location - I'm stealing that.
> > > 
> > > How does that avoid the problem of being able to construct an arbitrary
> > > gadget that somebody else will then execute?  IOW, what bpf has done
> > > seems like it's working around & undoing the security improvements.
> > > 
> > > I suppose it's an improvement that only the executable address is
> > > passed back to the caller, and not the writable address.
> > 
> > Ok, here's what I came up with. Have not tested all corner cases, still
> > need to write docs - but I think this gives us a nicer interface than
> > what bpf/kprobes/etc. have been doing, and it does the sub-page sized
> > allocations I need.
> > 
> > With an additional tweak to module_alloc() (not done in this patch yet)
> > we avoid ever mapping in pages both writeable and executable:
> > 
> > -->--
> > 
> > From 6eeb6b8ef4271ea1a8d9cac7fbaeeb7704951976 Mon Sep 17 00:00:00 2001
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > Date: Wed, 17 May 2023 01:22:06 -0400
> > Subject: [PATCH] mm: jit/text allocator
> > 
> > This provides a new, very simple slab allocator for jit/text, i.e. bpf,
> > ftrace trampolines, or bcachefs unpack functions.
> > 
> > With this API we can avoid ever mapping pages both writeable and
> > executable (not implemented in this patch: need to tweak
> > module_alloc()), and it also supports sub-page sized allocations.
> 
> This looks like yet another workaround for that module_alloc() was not
> designed to handle permission changes. Rather than create more and more
> wrappers for module_alloc() we need to have core API for code allocation,
> apparently on top of vmalloc, and then use that API for modules, bpf,
> tracing and whatnot.
> 
> There was quite lengthy discussion about how to handle code allocations
> here:
> 
> https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.org/

Thanks for the link!

Added Song to the CC.

Song, I'm looking at your code now - switching to hugepages is great,
but I wonder if we might be able to combine our two approaches - with
the slab allocator I did, do we have to bother with VMAs at all? And
then it gets us sub-page sized allocations.

> and Song is already working on improvements for module_alloc(), e.g. see
> commit ac3b43283923 ("module: replace module_layout with module_memory")
> 
> Another thing, the code below will not even compile on !x86.

Due to text_poke(), which I see is abstracted better in that patchset.

I'm very curious why text_poke() does tlb flushing at all; it seems like
flush_icache_range() is actually what's needed?

text_poke() also only touching up to two pages, without that being
documented, is also a footgun...

And I'm really curious why text_poke() is needed at all. Seems like we
could just use kmap_local() to create a temporary writeable mapping,
except in my testing that got me a RO mapping. Odd.
