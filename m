Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF67410195
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 01:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhIQXPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 19:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhIQXPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:15:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C64BC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 16:13:44 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id u21so10178091qtw.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WvStkWEONyoI89jczNA46zkJFi1B00WTIBUldmnucWA=;
        b=GnxUObmKo72rWvaUEWgCN6A6rnlgat7y67MnCheWDPis6UcdBSkLUXjaFXw1NyK+gt
         Cwq763rGlcAfuMnQzXbKWGixgHA4MkdM/IthGmiY03SEGC5nIStr9RTTHc1moqi3+l7u
         JyU7XKBGN/1H//94k5aoydPNo8LafO9EeLSt/dWk+oNgTxTCpzD73a8ZWXSguLcSe4sK
         KfZBvpX+MBdiSaOZifKJpXbbw/uqP+tna0RXwfwpLmtpl96CSC7P/HP+ychHew362jqM
         E2hUVmnoBFSq3pyQrRmK4yVltMcESwiwhd4mKsLV7lJUemBvCJh7rL6whtGl51B3gT9e
         HEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WvStkWEONyoI89jczNA46zkJFi1B00WTIBUldmnucWA=;
        b=sbXkKOkiztkRGXXJWYtGUdM+8aEpSixOzaHMcEh0XeMiJh/aNIQsVKEJ3MMXz0fwKD
         Pq+gtz1DxS59ecYcD5vPvs0ZOPkzjy1sVkPdubk2cgmISF35Zjudyy9f3t2/d63Kye8t
         1ngG0qhbRPPYBO9Bwi0a3gsd4atSpWV6Gb6n9UGfTQVWHpq7ZqhypHjm4+rw56QyBpOE
         IVWu0tQ+Sk8yI7Yrpv3Ro/J9MAs9C/XXBU9SU8epbQnhDyraZUzHpTxN1SKiv+ciKv5A
         y7bbRm3Pl4AYqDzobrhigpYPdj7gR0A2yf/VfhW1Z3OrovmDLIBHV4eO3amhGPTZzc35
         3FpA==
X-Gm-Message-State: AOAM532ntvilF360qhoYN5XmXB2Qa/R6+PZQX5DbLWR8QZgeikH9A+7B
        WKzNzoBliquCh7hmeh+j8jgMSw==
X-Google-Smtp-Source: ABdhPJyejXJYq9o/ujHepN1pUktkQ1bF6z16rKzRI+uE+VqOCntzSq9GIzsYhHgZk8O03odAUsg70g==
X-Received: by 2002:a05:622a:190a:: with SMTP id w10mr4358606qtc.300.1631920423410;
        Fri, 17 Sep 2021 16:13:43 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id m6sm4907016qti.38.2021.09.17.16.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:13:42 -0700 (PDT)
Date:   Fri, 17 Sep 2021 19:15:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUUhnHrWUeYebhPa@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:57:35PM +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 17, 2021 at 12:31:36PM -0400, Johannes Weiner wrote:
> > I didn't suggest to change what the folio currently already is for the
> > page cache. I asked to keep anon pages out of it (and in the future
> > potentially other random stuff that is using compound pages).
> 
> It would mean that anon-THP cannot benefit from the work Willy did with
> folios. Anon-THP is the most active user of compound pages at the moment
> and it also suffers from the compound_head() plague. You ask to exclude
> anon-THP siting *possible* future benefits for pagecache.
> 
> Sorry, but this doesn't sound fair to me.

Hold on Kirill. I'm not saying we shouldn't fix anonthp. But let's
clarify the actual code in question in this specific patchset. You say
anonthp cannot benefit from folio, but in the other email you say this
patchset isn't doing the conversion yet.

The code I'm specifically referring to here is the conversion of some
code that encounters both anon and file pages - swap.c, memcontrol.c,
workingset.c, and a few other places. It's a small part of the folio
patches, but it's a big deal for the MM code conceptually.

I'm requesting to drop those and just keep the page cache bits. Not
because I think anonthp shouldn't be fixed, but because I think we're
not in agreement yet on how they should be fixed. And it's somewhat
independent of fixing the page cache interface now that people are
waiting on much more desparately and acutely than we inside MM wait
for a struct page cleanup. It's not good to hold them while we argue.

Dropping the anon bits isn't final. Depending on how our discussion
turns out, we can still put them in later or we can put in something
new. The important thing is that the uncontroversial page cache bits
aren't held up any longer while we figure it out.

> If you want to limit usage of the new type to pagecache, the burden on you
> to prove that it is useful and not just a dead weight.

I'm not asking to add anything to the folio patches, just to remove
some bits around the edges. And for the page cache bits: I think we
have a rather large number of folks really wanting those. Now.

Again, I think we should fix anonthp. But I also think we should
really look at struct page more broadly. And I think we should have
that discussion inside a forum of MM people that truly care.

I'm just trying to unblock the fs folks at this point and merge what
we can now.
