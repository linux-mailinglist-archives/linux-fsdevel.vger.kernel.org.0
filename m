Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA45415CF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhIWLng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 07:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbhIWLng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:43:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009F3C061574;
        Thu, 23 Sep 2021 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n8Mi5cs+FlsaY04tVh3IDSphRi78FWp+NqQJpSgK8j4=; b=CZdYXdf8h6Q+xsZWV/2sdWoW23
        fGrqUFqTTcmxJHkqSHaACMPLKoW6klLmT+0Vd0eR8NNVfQ6MkZtodbas0yHL/0hQ3XZyet00Zkr+Q
        wsp86MneIZ/eB0wK+av1BY8Y+PGOp4RH8iIYKQsIagw4eiEfZ5QqxRldiph1zS8G9Mt0Pj11YLWGz
        cZdd/4rP+DEcQ6jT1Kxc6iKei3g/Y4SYb+ca/K0zU5vty45q+D5sPi31AAdBotDxpJV++y8p5yLU2
        iD0PrxXQ4KRffFzXD5zsGfrTHrB8MrZxc/8HcTxOT8+5h5IpvBDyRW4xcPB8oIhXxgPpFkQYJaaW6
        Imo1ADlg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTN5K-005pNi-Gx; Thu, 23 Sep 2021 11:40:31 +0000
Date:   Thu, 23 Sep 2021 12:40:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Mapcount of subpages
Message-ID: <YUxnnq7uFBAtJ3rT@casper.infradead.org>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <YUvzINep9m7G0ust@casper.infradead.org>
 <YUwNZFPGDj4Pkspx@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUwNZFPGDj4Pkspx@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 01:15:16AM -0400, Kent Overstreet wrote:
> On Thu, Sep 23, 2021 at 04:23:12AM +0100, Matthew Wilcox wrote:
> > (compiling that list reminds me that we'll need to sort out mapcount
> > on subpages when it comes time to do this.  ask me if you don't know
> > what i'm talking about here.)
> 
> I am curious why we would ever need a mapcount for just part of a page, tell me
> more.

I would say Kirill is the expert here.  My understanding:

We have three different approaches to allocating 2MB pages today;
anon THP, shmem THP and hugetlbfs.  Hugetlbfs can only be mapped on a
2MB boundary, so it has no special handling of mapcount [1].  Anon THP
always starts out as being mapped exclusively on a 2MB boundary, but
then it can be split by, eg, munmap().  If it is, then the mapcount in
the head page is distributed to the subpages.

Shmem THP is the tricky one.  You might have a 2MB page in the page cache,
but then have processes which only ever map part of it.  Or you might
have some processes mapping it with a 2MB entry and others mapping part
or all of it with 4kB entries.  And then someone truncates the file to
midway through this page; we split it, and now we need to figure out what
the mapcount should be on each of the subpages.  We handle this by using
->mapcount on each subpage to record how many non-2MB mappings there are
of that specific page and using ->compound_mapcount to record how many 2MB
mappings there are of the entire 2MB page.  Then, when we split, we just
need to distribute the compound_mapcount to each page to make it correct.
We also have the PageDoubleMap flag to tell us whether anybody has this
2MB page mapped with 4kB entries, so we can skip all the summing of 4kB
mapcounts if nobody has done that.

[1] Mike is looking to change this, but I'm not sure where he is with it.
