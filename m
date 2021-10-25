Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20124439A95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhJYPhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbhJYPhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:37:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C96FC061746
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 08:35:28 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g20so12225258qka.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=APD+8v+yzG8mONZt5PB1dtOtV91cn6z6YYGiPhcEgzo=;
        b=CZaXqzxgV/rFXwcgME6NqnXsQ2goBIjelkXHFJWnQcpvj8y/TgAuRvl1PplMgFMRk9
         3NeQRqG0cgoeOAyt4otEEMtnupURSPQnffElUrBbakcf5GHNQRYYjEBbBh7per+4WjTd
         5mcpx+8Y7OSDPjwvdaGXaDiF0A4jDQ+V+Nuo+Y98Saezte+NRxzJpqwnOQ65PsL5mB4u
         3A9AIUTPKaNLCUotpFMISOnVrGrM9f1u0qTDIGNxDl++B8T2DUETdBLlXg0QBGqzKRlU
         g1vSkVFXOWF7o8DFyVZRhOW4UXcgnoGA3T1niASsvcEk4BFF2zKLow7cl/6i0sBXErcM
         DdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=APD+8v+yzG8mONZt5PB1dtOtV91cn6z6YYGiPhcEgzo=;
        b=2Ay+qZ4nUlq1/05LyX7/xO7gRXZgH0lNoL6lOZVdEh2t49t9U/ki47HbxCpyGpA6Yn
         KmXGrinf/bQjYzL92SFvrbP2pqiUyasen3VX5tBhZLklYitD+W4DCBR6YTosO/Rdrh6G
         hqktcXgQSpuDZcoGfuVEUUJoDupU6FIpeOen/xB1meAQs3i3sVPS2ph+1BkIdY2Mze8Y
         J7bxLgL3kQcc85Cn8GkjLAhRWilPwqViDrjzGL9UZwaCMCVjFXZfPWJ9gqa0pZof2yTw
         wnkrVvfh76KgUC4OTBWexclsr2xteaR6pTIKqk0XDrlUm/iNZS60/0tZMYq8MJCD2lJY
         ZebA==
X-Gm-Message-State: AOAM532Meq4V0waMPwRtFEIeKzjJXOFyWdHWeaV8ZZkW/7nI5XUTl3NU
        I7i55pjHwjgIdKJyYfoBmcOZUQ==
X-Google-Smtp-Source: ABdhPJzmVFGhPfVSLkQOPVn1nGoegSO3FOQ76nXsoSKE95o+yQ+MZFcyN6qf3Zw8X8sO51h9V6juHg==
X-Received: by 2002:a37:aa43:: with SMTP id t64mr13450043qke.233.1635176127558;
        Mon, 25 Oct 2021 08:35:27 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id t26sm8649908qtq.77.2021.10.25.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 08:35:26 -0700 (PDT)
Date:   Mon, 25 Oct 2021 11:35:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXbOvR6jMXZ0WPcM@cmpxchg.org>
References: <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXIZX0truEBv2YSz@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 02:52:31AM +0100, Matthew Wilcox wrote:
> > Anyway. I can even be convinved that we can figure out the exact fault
> > lines along which we split the page down the road.
> > 
> > My worry is more about 2). A shared type and generic code is likely to
> > emerge regardless of how we split it. Think about it, the only world
> > in which that isn't true would be one in which either
> > 
> > 	a) page subtypes are all the same, or
> > 	b) the subtypes have nothing in common
> > 
> > and both are clearly bogus.
> 
> Amen!
> 
> I'm convinced that pgtable, slab and zsmalloc uses of struct page can all
> be split out into their own types instead of being folios.  They have
> little-to-nothing in common with anon+file; they can't be mapped into
> userspace and they can't be on the LRU.  The only situation you can find
> them in is something like compaction which walks PFNs.

They can all be accounted to a cgroup. pgtables are tracked the same
as other __GFP_ACCOUNT pages (pipe buffers and kernel stacks right now
from a quick grep, but as you can guess that's open-ended).

So if those all aren't folios, the generic type and the interfacing
object for memcg and accounting would continue to be the page.

> Perhaps you could comment on how you'd see separate anon_mem and
> file_mem types working for the memcg code?  Would you want to have
> separate lock_anon_memcg() and lock_file_memcg(), or would you want
> them to be cast to a common type like lock_folio_memcg()?

That should be lock_<generic>_memcg() since it actually serializes and
protects the same thing for all subtypes (unlike lock_page()!).

The memcg interface is fully type agnostic nowadays, but it also needs
to be able to handle any subtype. It should continue to interface with
the broadest, most generic definition of "chunk of memory".

Notably it does not do tailpages (and I don't see how it ever would),
so it could in theory use the folio - but only if the folio is really
the systematic replacement of absolutely *everything* that isn't a
tailpage - including pgtables, kernel stack, pipe buffers, and all
other random alloc_page() calls spread throughout the code base. Not
just conceptually, but an actual wholesale replacement of struct page
throughout allocation sites.

I'm not sure that's realistic. So I'm thinking struct page will likely
be the interfacing object for memcg for the foreseeable future.
