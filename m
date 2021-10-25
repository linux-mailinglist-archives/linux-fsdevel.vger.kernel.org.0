Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EDE439B2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhJYQH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 12:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhJYQH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:07:56 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E35C061228;
        Mon, 25 Oct 2021 09:05:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id o12so10725130qtq.7;
        Mon, 25 Oct 2021 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ppqh2FjE67TRGkYF6J+dJDIWyZOwoaR5T77AFpPHUY=;
        b=GRUaH6e3WvbgYGCQ6eeyTaj4Iyk/l1K2qN++puuH1b1narFqGkoIbA9/qVlLYg8IQk
         /KV99weEbi4ew0cbYpyc0F6Ru42D5BrI4693XJBaLnokLYJ8yeYaaaxqN6wQ98OV5YpS
         gQIKe8fgnTK9wwQdmbtBfRG9rJwBj6yCp6h4lLnKJOjkfzjJNii4sQyQS18D4TpUAWew
         6b5k/ckh7MtKM9btbKucH/k2AnIxhfbH/gZPEf1xl1bigedZcai/QIhu7/ZYA1EjIcj4
         IX6yhl+9H5j65hteADUvpJF2Vpvi4Btxr1BLpcK898X4FdwEc1rWKplp6pPG6Fjlh+nr
         YO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ppqh2FjE67TRGkYF6J+dJDIWyZOwoaR5T77AFpPHUY=;
        b=xjTa3H7nw87WbS47XZJYPvFC1TIPEsPYX8NykccxlRqPtOokMdJcNPwbMaj0n4/4zL
         5W0K3SdsYw51QBaJs7Qx41AaQlTy1lxfGuCvOKI2acGnS3UAcw7/QXjkW9/QnRpQnf3C
         sUgthHDwQXM+OpGdQmY0S3KHvOo1Dk04cPd+oXBZDwHI6ZwKEmbZVoAlW3L2bvEmBX/8
         6n88wcv3qJs0ref8U4ZcRKbdl91PFOQAYRYZdU8kkDB7DTmqE2UwiY1w+A0Oa18MtmbA
         u+UjkTPAZPOPzH++z5jyP+/Znc1fPMOxtWyB/DKCQsVbchrvG8bY3aLuY3QhucpYQxlP
         mLzg==
X-Gm-Message-State: AOAM531rwnOIbx2C7EBzR9lJUrdJctw5xDzqm/bWQ+K4OiLJRTQ13Vby
        BMxsMcnc5yq3VAzZ3YuV5w==
X-Google-Smtp-Source: ABdhPJxXTu0ihxDnfTmNDxlqd0IaSM/8I8JWjmbtOaHcXfVnG4l7zuv/gGPEFe2TnvyneIAYsJQaHw==
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr19047475qtc.266.1635177930295;
        Mon, 25 Oct 2021 09:05:30 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id br20sm4134284qkb.104.2021.10.25.09.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:05:29 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:05:27 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <YXbVxwx+Ln73CtEB@moria.home.lan>
References: <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
 <YXbOvR6jMXZ0WPcM@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXbOvR6jMXZ0WPcM@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:35:25AM -0400, Johannes Weiner wrote:
> On Fri, Oct 22, 2021 at 02:52:31AM +0100, Matthew Wilcox wrote:
> > > Anyway. I can even be convinved that we can figure out the exact fault
> > > lines along which we split the page down the road.
> > > 
> > > My worry is more about 2). A shared type and generic code is likely to
> > > emerge regardless of how we split it. Think about it, the only world
> > > in which that isn't true would be one in which either
> > > 
> > > 	a) page subtypes are all the same, or
> > > 	b) the subtypes have nothing in common
> > > 
> > > and both are clearly bogus.
> > 
> > Amen!
> > 
> > I'm convinced that pgtable, slab and zsmalloc uses of struct page can all
> > be split out into their own types instead of being folios.  They have
> > little-to-nothing in common with anon+file; they can't be mapped into
> > userspace and they can't be on the LRU.  The only situation you can find
> > them in is something like compaction which walks PFNs.
> 
> They can all be accounted to a cgroup. pgtables are tracked the same
> as other __GFP_ACCOUNT pages (pipe buffers and kernel stacks right now
> from a quick grep, but as you can guess that's open-ended).
> 
> So if those all aren't folios, the generic type and the interfacing
> object for memcg and accounting would continue to be the page.
> 
> > Perhaps you could comment on how you'd see separate anon_mem and
> > file_mem types working for the memcg code?  Would you want to have
> > separate lock_anon_memcg() and lock_file_memcg(), or would you want
> > them to be cast to a common type like lock_folio_memcg()?
> 
> That should be lock_<generic>_memcg() since it actually serializes and
> protects the same thing for all subtypes (unlike lock_page()!).
> 
> The memcg interface is fully type agnostic nowadays, but it also needs
> to be able to handle any subtype. It should continue to interface with
> the broadest, most generic definition of "chunk of memory".
> 
> Notably it does not do tailpages (and I don't see how it ever would),
> so it could in theory use the folio - but only if the folio is really
> the systematic replacement of absolutely *everything* that isn't a
> tailpage - including pgtables, kernel stack, pipe buffers, and all
> other random alloc_page() calls spread throughout the code base. Not
> just conceptually, but an actual wholesale replacement of struct page
> throughout allocation sites.
> 
> I'm not sure that's realistic. So I'm thinking struct page will likely
> be the interfacing object for memcg for the foreseeable future.

Interesting.

We were also just discussing how in the block layer, bvecs can currently point
to multiple pages - this is the multipage bvec work that Ming did, it made bio
segment merging a lot cheaper by moving it from the layer that maps bvecs to
sglists and up to bio_add_page() and got rid of the need for segment counting.

But with the upper layers transitioning to compound pages, i.e. keeping
contiguous stuff together as a unit - we're going to want to switch bvecs to
pointing to compound pages, and ditch all the code that breaks up a bvec into
individual 4k pages when we iterate over them; we also won't need or want any
kind of page/segment merging anymore, which is really cool.

But since bios can do IO to/from basically any type of memory, this is another
argument in favor of folios becoming the replacement for all or essentially all
compound pages. The alternative would be changing bvecs to only point to head
pages, which I do think would be completely workable with appropriate
assertions.

We don't want to prevent doing block IO to/from slab memory - there's a lot of
places where we do block IO to memory that isn't exposed to userspace
(e.g. filesystem metadata, other weirder paths), so if bvecs point to folios,
then at least slab needs to be a subtype of folios and folios need to be all or
most compound pages.

I've been anti folios being the replacement for all compound pages because this
is C, trying to do a lot with types is a pain in the ass and I think in general
nested inheritence heirarchies tend to not be the way to go. But I'm definitely
keeping an open mind...
