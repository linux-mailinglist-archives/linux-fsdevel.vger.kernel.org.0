Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237A7413C12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhIUVMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhIUVMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:12:42 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F57C061574;
        Tue, 21 Sep 2021 14:11:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c7so2278631qka.2;
        Tue, 21 Sep 2021 14:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zCsTnszozcMWakwvCPgZXXhNyKNOkSlqncLZKwtc/cs=;
        b=Wo0ChhyKDc641UkRQXImePyH7Kca90qJ0M+wVAZehOGrSvyqhqySnh5pwDSXOk0Sid
         099qlb+GgA+Md5pIc2x9t8aAAXPPYV8seX2/g14ugartmaCaY7UuYkfBBQU0ISzOBTeT
         dwKLp1d9X5/q+QaLSRww/e1Q0VptwWRZjKF4D76F4dl7Myuxa5yrPy063I0Go8wsdgjg
         75FZY2e3HkRR10Ma9X5+jUyJSe1jfC4N9Jlam2kripRtLC+/ltKOmAqvRfUekbMu4wWS
         w+WvRBaMCqN/MVo0MNiKpmYeBv43z859ecs5sj1JGolhDF/e8XTKR5nCe9HnEVy3FFhz
         JWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zCsTnszozcMWakwvCPgZXXhNyKNOkSlqncLZKwtc/cs=;
        b=nj7mqf+7MITyBP7yJ1R7cCgFp0xG2368riFcDtnU1Ic5hRS51+8L9pMsTGBrwARvEr
         /NflbTLwQKqoL8QWZfLHGADYuk2IZn7qoxtatitintkLYD25g3ZR3XOhr2/2XYAt9Msj
         NRYrC2BxXyQrQXQRhDOkGAuSqzawYTo8XLjHdLswBp3f+ymIqwxBHy5qfSO3NCy29XvH
         3mHSx/VrqU3feRLcVaPX4fW6rXIk+WsL6FwWXLBZNsvcYgp2FFvWAQ6zMJsXuxSRPXrI
         G5NNlQiUsaLVYZYRJcAnmYGrXeNs9Z2L0REFUortBbQf1CAKxjuRCHQnxHknUETAvmvg
         Je5Q==
X-Gm-Message-State: AOAM5302ibAzP4q+AXNQdJ8dSdjgwkFiQyETvKKM0dcV6rQueJpsT//k
        xy6/xNbtciv3dGI6EF2KRw==
X-Google-Smtp-Source: ABdhPJwawa4dME/5/GH0r/McBHz9A74FW3KWI/lcJzN9mewwiCovRyE/eKFXpxKF9RWNgIO1YdwFzA==
X-Received: by 2002:ae9:efc9:: with SMTP id d192mr15818686qkg.366.1632258672543;
        Tue, 21 Sep 2021 14:11:12 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m21sm131906qka.69.2021.09.21.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:11:11 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:11:09 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUpKbWDYqRB6eBV+@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUpC3oV4II+u+lzQ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:38:54PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 21, 2021 at 03:47:29PM -0400, Johannes Weiner wrote:
> > and so the justification for replacing page with folio *below* those
> > entry points to address tailpage confusion becomes nil: there is no
> > confusion. Move the anon bits to anon_page and leave the shared bits
> > in page. That's 912 lines of swap_state.c we could mostly leave alone.
> 
> Your argument seems to be based on "minimising churn".  Which is certainly
> a goal that one could have, but I think in this case is actually harmful.
> There are hundreds, maybe thousands, of functions throughout the kernel
> (certainly throughout filesystems) which assume that a struct page is
> PAGE_SIZE bytes.  Yes, every single one of them is buggy to assume that,
> but tracking them all down is a never-ending task as new ones will be
> added as fast as they can be removed.

Yet it's only file backed pages that are actually changing in behaviour right
now - folios don't _have_ to be the tool to fix that elsewhere, for anon, for
network pools, for slab.

> > The anon_page->page relationship may look familiar too. It's a natural
> > type hierarchy between superclass and subclasses that is common in
> > object oriented languages: page has attributes and methods that are
> > generic and shared; anon_page and file_page encode where their
> > implementation differs.
> > 
> > A type system like that would set us up for a lot of clarification and
> > generalization of the MM code. For example it would immediately
> > highlight when "generic" code is trying to access type-specific stuff
> > that maybe it shouldn't, and thus help/force us refactor - something
> > that a shared, flat folio type would not.
> 
> If you want to try your hand at splitting out anon_folio from folio
> later, be my guest.  I've just finished splitting out 'slab' from page,
> and I'll post it later.  I don't think that splitting anon_folio from
> folio is worth doing, but will not stand in your way.  I do think that
> splitting tail pages from non-tail pages is worthwhile, and that's what
> this patchset does.

Eesh, we can and should hold ourselves to a higher standard in our technical
discussions.

Let's not let past misfourtune (and yes, folios missing 5.15 _was_ unfortunate
and shouldn't have happened) colour our perceptions and keep us from having
productive working relationships going forward. The points Johannes is bringing
up are valid and pertinent and deserve to be discussed.

If you're still trying to sell folios as the be all, end all solution for
anything using compound pages, I think you should be willing to make the
argument that that really is the _right_ solution - not just that it was the one
easiest for you to implement.

Actual code might make this discussion more concrete and clearer. Could you post
your slab conversion?
