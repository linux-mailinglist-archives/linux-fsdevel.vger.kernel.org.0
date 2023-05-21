Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB570AC2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 05:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEUDjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 23:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjEUDi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 23:38:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAC9EA;
        Sat, 20 May 2023 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UvzrU1fWGgvrzkJyGWrLT8gY5uKFL11kwPzh0h2bATs=; b=nvR0L2NDFge3IXTjysGKJajTqs
        SIl+No7sQWLN2SjnEqZVl/wPNi1s3yyWXhlpDtJq/y6KeRQeZMDReaoYwIjnwj/y8/S+s1wzaI7mv
        4qTjnPyVgXwHUVmYiK82kcrD7SdJimwhzoG3kGt9Ey7ceI3WNOigXFpBPZ/Y9e+SC9YYhFCx4xLuy
        vBkLRq9rptxQhhhgRp7y/gNzvenlgOhn+ERZDkRDxWFdWfx/34pC+rsogWWmtk7EXA6rTHYikaYMI
        +POs2qTZcKT6tp56ulHJP66tsuW2KsKS4LDh9N/uxfTAI7U8k9K70wDAZ6AkhQ9NESC0bjfmyNXrs
        OsYv0lIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0Zu0-007vHq-2p; Sun, 21 May 2023 03:38:36 +0000
Date:   Sun, 21 May 2023 04:38:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/3] filemap: Allow __filemap_get_folio to allocate large
 folios
Message-ID: <ZGmSPNHU44dAzPvE@casper.infradead.org>
References: <20230520163603.1794256-1-willy@infradead.org>
 <20230520163603.1794256-2-willy@infradead.org>
 <ZGl+ZeaCB+7D23xj@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGl+ZeaCB+7D23xj@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 21, 2023 at 12:13:57PM +1000, Dave Chinner wrote:
> > +static inline unsigned fgp_order(size_t size)
> > +{
> > +	unsigned int shift = ilog2(size);
> > +
> > +	if (shift <= PAGE_SHIFT)
> > +		return 0;
> > +	return (shift - PAGE_SHIFT) << 26;
> > +}
> 
> Doesn't check for being larger than MAX_PAGECACHE_ORDER.

It doesn't need to.  I check it on extraction.  We've got six bits,
so we can't overflow it.

> Also: naming. FGP_ORDER(fgp) to get the order stored in the fgp,
> fgp_order(size) to get the order from the IO length.
> 
> Both are integers, the compiler is not going to tell us when we get
> them the wrong way around, and it's impossible to determine which
> one is right just from looking at the code.
> 
> Perhaps fgp_order_from_flags(fgp) and fgp_order_from_length(size)?

Yeah, I don't like that either.  I could be talked into
fgp_set_order(size) and fgp_get_order(fgp).  Also we should type the
FGP flags like we type the GFP flags.

> Also, why put the order in the high bits? Shifting integers up into
> unaligned high bits is prone to sign extension issues and overflows.
> e.g.  fgp_flags is passed around the filemap functions as a signed
> integer, so using the high bit in a shifted value that is unsigned
> seems like a recipe for unexpected sign extension bugs on
> extraction.

As long as it's an unsigned int in the function which does the extraction,
there's no problem.  It's also kind of hard to set the top bit -- you'd
have to somehow get a 2^44 byte write into iomap.

> Hence I'd much prefer low bits are used for this sort of integer
> encoding (i.e. uses masks instead of shifts for extraction), and
> that flags fields -always- use unsigned variables so high bit
> usage doesn't unexpected do the wrong thing....

There are some encoding advantages to using low bits for flags.  Does
depend on the architecture; x86 is particularly prone to this kind of
thing, but ARM has various constraints on what constants it can
represent as immediates.  I've rarely had cause to care about other
architecture details, but generally low bits are better supported
as flags than high bits.
