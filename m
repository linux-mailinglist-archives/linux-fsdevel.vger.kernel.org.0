Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D8438437
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJWQDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 12:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWQDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 12:03:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7FC061714;
        Sat, 23 Oct 2021 09:00:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g20so7646921qka.1;
        Sat, 23 Oct 2021 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qthr8cU1dSojgOgBBt4dT5UmFwa8J4R/24qOs7tEfOI=;
        b=SW1HV4z3DDfn8pj9XE8+R6qNKJBkLTktSvZMfr3j+nyDqEl7eJIklPbA+ioEgkktQd
         mBQMpVdA54dqQlvh/RSq/nBqQnxquZjFkCaGvAop64ZyB+SA9DQJ7Z1IZS9AAB2qgrYk
         SMNEhTXuYVqZfGgdV4xt4hpbLJ6xY0WE6ZKGmUJJoTD2fONrNV6J9gHfT6cCLtjFOzBj
         RRVVu6SVPDgbPydliOdQ/EqV0gnwk3NjRjjnI3p10GSWyY2ZW2xUhjItslmja+o4/l15
         DuRRf7Fv03S785KppBZUOBOz6Cyt3PHYmanBztu9fmoocLXhyvEZ8Rlpbgy/KGNzfK7n
         OI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qthr8cU1dSojgOgBBt4dT5UmFwa8J4R/24qOs7tEfOI=;
        b=e2gvDAuZzOZOV/7y2INOu8pNfy4aezJUWMoeGkL6U2hsDpGxlVOAIgI6HhX537vQ9s
         5EDwy+5eWYMPVZwdmIMfMUy7xfwVHttuypW6Y74N85+4Jb6Fg3HRTHphmzclb9Y6a6Oo
         bLlipq1sessQiMfX1FJZCS6l6jav40lVp9HO5IQN9JxbQKCHxGW4gemwzLFS9fhVzW5D
         SijWJE7NR7shzwR2prHoHmAJhObuE1ApHB0AAj+mi6t1Q/942oj7jYwVwKRqwlcjP7bk
         nGyASvRZaeQIR9MtJKmZUTd8CzoeDzf+Z4yVjOakQ+CfMbIqwf58UcylrpP9eUrrkGIT
         Tx1A==
X-Gm-Message-State: AOAM533cfq2+Pv52q4n6s2D2iHwpmPqZKGssG5jRwCp5iOsc9eYIwWlB
        0DbB5zAc1ccpAcPwVBJEOiepIJ4nlsUu
X-Google-Smtp-Source: ABdhPJwOt99lzC+F3f94YhOfmD9szqqqxLxeUc+99UfI57we1FBO952e676doMC29RdKHILlnaJK9Q==
X-Received: by 2002:a37:44c8:: with SMTP id r191mr5372123qka.507.1635004843919;
        Sat, 23 Oct 2021 09:00:43 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id m28sm5835578qkm.23.2021.10.23.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 09:00:42 -0700 (PDT)
Date:   Sat, 23 Oct 2021 12:00:38 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <YXQxptoPALVHHPCU@moria.home.lan>
References: <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
 <326b5796-6ef9-a08f-a671-4da4b04a2b4f@redhat.com>
 <YXK2ICKi6fjNfr4X@casper.infradead.org>
 <c18923a1-8144-785e-5fb3-5cbce4be1310@redhat.com>
 <YXNx686gvsJMgS+z@casper.infradead.org>
 <404bdc05-487f-3d47-6b30-0687b74c2f2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404bdc05-487f-3d47-6b30-0687b74c2f2f@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 23, 2021 at 11:58:42AM +0200, David Hildenbrand wrote:
> I know, the crowd is screaming "we want folios, we need folios, get out
> of the way". I know that the *compound page* handling is a mess and that
> we want something to change that. The point I am making is that folios
> are not necessarily what we *need*.
> 
> Types as discussed above are really just using the basic idea of a folio
> lifted to the next level that not only avoid any kind of PageTail checks
> but also any kind of type checks we have splattered all over the place.
> IMHO that's a huge win when it comes to code readability and
> maintainability. This also tackles the point Johannes made: folios being
> the dumping ground for everything. And he has a point, because folios
> are really just "not tail pages", so consequently they will 99% just
> mimic what "struct page" does, and we all know what that means.

Look, even if folios go this direction of being the compound page replacement,
the "new dumping ground" argument is just completely bogus.

In introducing new types and type safety for struct page, it's not reasonable to
try to solve everything at once - we don't know what an ideal end solution is
going to look like, we can't see that far ahead. What is a reasonable approach
is looking for where the fault lines in the way struct page is used now, and
cutting along those lines, look at the result, then cut it up some more. If the
first new type still inherits most of the mess in struct page but it solves real
problems, that's not a failure, that's normal incremental progress!

--------

More than that, I think you and Johannes heard what I was saying about imagining
what the ideal end solution would look like with infinite refactoring and you
two have been running way too far with that idea - the stuff you guys are
talking about sounds overengineered to me - inheritence heirarchies before we've
introduced the first new type!

The point of such thought experiments is to imagine how simple things could be -
and also to not take such thought experiments too seriously, because when we
start refactoring real world code, that's when we discover what's actually
_possible_.

I ran into a major roadblock when I tried converting buddy allocator freelists
to radix trees: freeing a page may require allocating a new page for the radix
tree freelist, which is fine normally - we're freeing a page after all - but not
if it's highmem. So right now I'm not sure if getting struct page down to two
words is even possible. Oh well.

> Your patches introduce the concept of folio across many layers and your
> point is to eventually clean up later and eventually remove it from all
> layers again. I can understand that approach, yet I am at least asking
> the question if this is the right order to do this.
> 
> And again, I am not blocking this, I think cleaning up compound pages is
> very nice. I'm asking questions to see how the concept of folios would
> fit in long-term and if it would be required at all if types are done right.

I'm also not really seeing the need to introduce folios as a replacement for all
of compound pages, though - I think limiting it to file & anon and using the
union-of-structs in struct page as the fault lines for introducing new types
would be the reasonable thing to do. The struct slab patches were great, it's a
real shame that the slab maintainers have been completely absent.

Also introducing new types to be describing our current using of struct page
isn't the only thing we should be doing - as we do that, that will (is!) uncover
a lot of places where our ontology of struct page uses is just nonsensical (all
the types of pages mapped into userspace!) - and part of our mission should be
to clean those up.

That does turn things into a much bigger project than what Matthew signed up
for, but we shouldn't all be sitting on the sidelines here...
