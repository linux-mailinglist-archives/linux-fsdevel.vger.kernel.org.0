Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6BE416724
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbhIWVMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243231AbhIWVMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:12:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D0C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 14:10:28 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso10330683otb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=U8C7kTM2i0LULyId4CRBDB3WhhpE9MXA+bUV/5nqDCo=;
        b=sVjEV9NF9eKm1hMfgtvsNUa3rZxxZ/Lezl4IcpqFtOVWR+5zaDUqxg/2hiXVYGCr7I
         CQtjidNr9hwZ6tjsTvhRtQwqA2WGW79xEb5uZfAaH/b5TWCqeOnNStNWOKO+Vpo/wP6H
         U9Ea713fUSGaeqS5WU6p2qphlKV57l9LG5ug8VBf9p8g0U62zTHdouMLa114GRaWESjO
         blOcE5BxLA772si2ZZeJgIfj0tz2uwzgyy9dRxSeT2SsqNtdXwQ1kZom67fSsff1R26n
         30uQDOqWJ1QpTpn1LVOshgY+6SJ/JiBChWBGGblWKwbRCCnlQ2II+jotRQ1v1p7zEydL
         L7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=U8C7kTM2i0LULyId4CRBDB3WhhpE9MXA+bUV/5nqDCo=;
        b=tXJImJ8D7iktRcX+jzLuydXZd73FwN1aGCyo8+u9nGb2rLy6b25h75I8bUgdrT1Zhg
         daEf+ydewN/uoy5wko/nFFG+QwMc1fAz2aP5zoxM25F0N+Cw3vdXrDGpZX3BHaGS7SUS
         +KvBr2zWl2LN7q3YJ+DjmE2l1YZJTLaTa3yqYMwC6AvUu1Cg2mdCOrBbPfDbdq9Hk9JR
         pP06OcAKwo1ILO6yAA0ROXgNCEvOJ5bUd7Gmw6EHfL/AeO6OhvnlilQSrmuaVNseYJ0a
         r9YagNS7Uv/zFMfyx4yMuD6WiELtF366x+HTe98Zci9nXcYRkoGrAJnp56UkJxF89nx7
         Wi1A==
X-Gm-Message-State: AOAM530yoCR031URV5xs+oseqbGQN4ib/AfvQQpNjJBJ/ywePE9x9XS0
        1q6xXMoOcXmVmLf8WkfxrqHwmg==
X-Google-Smtp-Source: ABdhPJzwY4l4nfzUx7XxLiPKY1zK2O5YluTcKjvD7YeJim2WLDvwlsxLKjkqIRbKCKLks7jJnRSJCA==
X-Received: by 2002:a9d:60c2:: with SMTP id b2mr707393otk.27.1632431427084;
        Thu, 23 Sep 2021 14:10:27 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h25sm524386otl.1.2021.09.23.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:10:26 -0700 (PDT)
Date:   Thu, 23 Sep 2021 14:10:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: Mapcount of subpages
In-Reply-To: <20210923124502.nxfdaoiov4sysed4@box.shutemov.name>
Message-ID: <72cc2691-5ebe-8b56-1fe8-eeb4eb4a4c74@google.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <YUvzINep9m7G0ust@casper.infradead.org> <YUwNZFPGDj4Pkspx@moria.home.lan> <YUxnnq7uFBAtJ3rT@casper.infradead.org> <20210923124502.nxfdaoiov4sysed4@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Sep 2021, Kirill A. Shutemov wrote:
> On Thu, Sep 23, 2021 at 12:40:14PM +0100, Matthew Wilcox wrote:
> > On Thu, Sep 23, 2021 at 01:15:16AM -0400, Kent Overstreet wrote:
> > > On Thu, Sep 23, 2021 at 04:23:12AM +0100, Matthew Wilcox wrote:
> > > > (compiling that list reminds me that we'll need to sort out mapcount
> > > > on subpages when it comes time to do this.  ask me if you don't know
> > > > what i'm talking about here.)
> > > 
> > > I am curious why we would ever need a mapcount for just part of a page, tell me
> > > more.
> > 
> > I would say Kirill is the expert here.  My understanding:
> > 
> > We have three different approaches to allocating 2MB pages today;
> > anon THP, shmem THP and hugetlbfs.  Hugetlbfs can only be mapped on a
> > 2MB boundary, so it has no special handling of mapcount [1].  Anon THP
> > always starts out as being mapped exclusively on a 2MB boundary, but
> > then it can be split by, eg, munmap().  If it is, then the mapcount in
> > the head page is distributed to the subpages.
> 
> One more complication for anon THP is that it can be shared across fork()
> and one process may split it while other have it mapped with PMD.
> 
> > Shmem THP is the tricky one.  You might have a 2MB page in the page cache,
> > but then have processes which only ever map part of it.  Or you might
> > have some processes mapping it with a 2MB entry and others mapping part
> > or all of it with 4kB entries.  And then someone truncates the file to
> > midway through this page; we split it, and now we need to figure out what
> > the mapcount should be on each of the subpages.  We handle this by using
> > ->mapcount on each subpage to record how many non-2MB mappings there are
> > of that specific page and using ->compound_mapcount to record how many 2MB
> > mappings there are of the entire 2MB page.  Then, when we split, we just
> > need to distribute the compound_mapcount to each page to make it correct.
> > We also have the PageDoubleMap flag to tell us whether anybody has this
> > 2MB page mapped with 4kB entries, so we can skip all the summing of 4kB
> > mapcounts if nobody has done that.
> 
> Possible future complication comes from 1G THP effort. With 1G THP we
> would have whole hierarchy of mapcounts: 1 PUD mapcount, 512 PMD
> mapcounts and 262144 PTE mapcounts. (That's one of the reasons I don't
> think 1G THP is viable.)
> 
> Note that there are places where exact mapcount accounting is critical:
> try_to_unmap() may finish prematurely if we underestimate mapcount and
> overestimating mapcount may lead to superfluous CoW that breaks GUP.

It is critical to know for sure when a page has been completely unmapped:
but that does not need ptes of subpages to be accounted in the _mapcount
field of subpages - they just need to be counted in the compound page's
total_mapcount.

I may be wrong, I never had time to prove it one way or the other: but
I have a growing suspicion that the *only* reason for maintaining tail
_mapcounts separately, is to maintain the NR_FILE_MAPPED count exactly
(in the face of pmd mappings overlapping pte mappings).

NR_FILE_MAPPED being used for /proc/meminfo's "Mapped:" and a couple
of other such stats files, and for a reclaim heuristic in mm/vmscan.c.

Allow ourselves more slack in NR_FILE_MAPPED accounting (either count
each pte as if it mapped the whole THP, or don't count a THP's ptes
at all - you opted for the latter in the "Mlocked:" accounting),
and I suspect subpage _mapcount could be abandoned.

But you have a different point in mind when you refer to superfluous
CoW and GUP: I don't know the score there (and I think we are still in
that halfway zone, since pte CoW was changed to depend on page_count,
but THP CoW still depending on mapcount).

Hugh
