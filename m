Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1C7059C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 23:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjEPVrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPVrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 17:47:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B41FD6;
        Tue, 16 May 2023 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RCVWP5n6K6Lz8z9J8Ai6uKS353zWFJSSAzmmvd1zqIs=; b=jQsyxEv/DJGXrls9lt3TGGtEWt
        WuFts7yqMOf5gyWydkkSKxLYQHXNrlHzF7TQ3F7DjIEqAQNneOhFt7afCCK7ByTcp7XYaHQGWWIRy
        VJBECcQLadjtrDov24LH4TUxbuEfKpCJwl77Udyc4QK/eCvDZm542DtwjkojwH6HZPuD+GfbwkC7L
        T/+mPaFm0xQzAwJiPd6DiH/iEylw9JWjCJKsB95mwzcGihE33us1vI6EZ0TW2RQDxQwKQ1jgH7Bef
        ynhhNOJj/OWpkej/BrBnb6vKgffjM7AuV1DrkAHTooY20eeVhrJ+EauXx3dtP8hgJmY6GDplzDld8
        ymR+uepg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pz2Vl-004aWL-6z; Tue, 16 May 2023 21:47:13 +0000
Date:   Tue, 16 May 2023 22:47:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
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
Message-ID: <ZGP54T0d89TMySsf@casper.infradead.org>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGPzocRpSlg+4vgN@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 05:20:33PM -0400, Kent Overstreet wrote:
> On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
> > For something that small, why not use the text_poke API?
> 
> This looks like it's meant for patching existing kernel text, which
> isn't what I want - I'm generating new functions on the fly, one per
> btree node.
> 
> I'm working up a new allocator - a (very simple) slab allocator where
> you pass a buffer, and it gives you a copy of that buffer mapped
> executable, but not writeable.
> 
> It looks like we'll be able to convert bpf, kprobes, and ftrace
> trampolines to it; it'll consolidate a fair amount of code (particularly
> in bpf), and they won't have to burn a full page per allocation anymore.
> 
> bpf has a neat trick where it maps the same page in two different
> locations, one is the executable location and the other is the writeable
> location - I'm stealing that.

How does that avoid the problem of being able to construct an arbitrary
gadget that somebody else will then execute?  IOW, what bpf has done
seems like it's working around & undoing the security improvements.

I suppose it's an improvement that only the executable address is
passed back to the caller, and not the writable address.

> external api will be:
> 
> void *jit_alloc(void *buf, size_t len, gfp_t gfp);
> void jit_free(void *buf);
> void jit_update(void *buf, void *new_code, size_t len); /* update an existing allocation */
> 
