Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30D3FD8ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbhIALnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 07:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243865AbhIALnX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:43:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4007761056;
        Wed,  1 Sep 2021 11:42:24 +0000 (UTC)
Date:   Wed, 1 Sep 2021 13:42:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Folios: Can we resolve this please?
Message-ID: <20210901114222.fm6enxi66nkynwc4@wittgenstein>
References: <3285174.1630448147@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3285174.1630448147@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 31, 2021 at 11:15:47PM +0100, David Howells wrote:
> Hi Linus, Andrew, Johannes,
> 
> Can we come to a quick resolution on folios?  I'd really like this to be
> solved in this merge window if at all possible as I (and others) have stuff
> that will depend on and will conflict with Willy's folio work.  It would be
> great to get this sorted one way or another.
> 
> As I see it, there are three issues, I think, and I think they kind of go like
> this:
> 
>  (1) Johannes wants to get away from pages being used as the unit of memory
>      currency and thinks that folios aren't helpful in this regard[1].  There
>      seems to be some disagreement about where this is heading.
> 
>  (2) Linus isn't entirely keen on Willy's approach[2], with a bottom up
>      approach hiding the page objects behind a new type from the pov of the
>      filesystem, but would rather see the page struct stay the main API type
>      and the changes be hidden transparently inside of that.
> 
>      I think from what Linus said, he may be in favour (if that's not too
>      strong a word) of using a new type to make sure we don't miss the
>      necessary changes[3].
> 
>  (3) Linus isn't in favour of the name 'folio' for the new type[2].  Various
>      names have been bandied around and Linus seems okay with "pageset"[4],
>      though it's already in minor(-ish) use[5][6].  Willy has an alternate
>      patchset with "folio" changed to "pageset"[7].
> 
> With regard to (1), I think the folio concept could be used in future to hide
> at least some of the paginess from filesystems.
> 
> With regard to (2), I think a top-down approach won't work until and unless we
> wrap all accesses to struct page by filesystems (and device drivers) in
> wrapper functions - we need to stop filesystems fiddling with page internals
> because what page internals may mean may change.
> 
> With regard to (3), I'm personally fine with the name "folio", as are other
> people[8][9][10][11], but I could also live with a conversion to "pageset".
> 
> Is it possible to take the folios patchset as-is and just live with the name,
> or just take Willy's rename-job (although it hasn't had linux-next soak time
> yet)?  Or is the approach fundamentally flawed and in need of redoing?

I can't speak to the deep technical mm problems but from a pure "user"
perspective, I think this is a genuinely good patchset which simplifies
and unifies a good set of things. Sure, it is a lot of changes. But the
fact that a range of people have ported their patchsets to make use of
the new folio api is a rather good sign imho.

If I saw a huge changeset like this coming in that I don't believe is
worth it I wouldn't port my patches to it. So I think that expresses
a decent amount of practial confidence in the changes and that the
conversion has been done in a way that is tasteful. Of course there are
other ways of doing it; there always are.

I don't have yet another clever name to propose. The "folio" prefix
forms a very natural api over a wide range of helpers such as
folio_memcg_kmem(), folio_file_mapping() et al. I found the other
suggestions to be rather clunky compared to that. And compsci and
science in general thrives on piling on additional meaning on existing
concepts.

Christian
