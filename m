Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DEC40725C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 22:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhIJURy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 16:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhIJURq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:17:46 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B68C061574;
        Fri, 10 Sep 2021 13:16:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m21so3377004qkm.13;
        Fri, 10 Sep 2021 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NIMZ+lVamZ4qSqmjcxEtb3AzB6s9aRg0W8SCbuO991M=;
        b=R4MKZuTWImwx6zv6dVhudDTptSUTe6SYQVBnOiJwDDReSt8w334TUsxlB6+egksRR1
         D51Jv5YRQEnSdgZnOcs249JR5mzxphdSquDHGe9pE13w6LD00AebT5kHcyyGhjwSz5fX
         kg15gU2KCBtyndmUp/zYiQBz05+hxCpK94aI1VrrT0xWYrvcddgDrWlNDbywuxbGeSpW
         kDuVpMmTOvtY2xcoXYR9DO/HZ5P5rmB9YGt7V5h+Pl1jBkkk+DGOEPMP355HjHT+ljJM
         HzOa13bMzB+6p+ShuUz1Sjn34BVEB9u/YcKgO582YhiNCjiFbIDRDcttQmhJGZPpwNqi
         MQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NIMZ+lVamZ4qSqmjcxEtb3AzB6s9aRg0W8SCbuO991M=;
        b=QlJYCk/ujpktuYXfS/BaMp0baHW+pzCLFYGm8EamAjYYA/6wSYqIDNoxmpX89fodyU
         zLpcX7ELX9FfS+byZNi1NVfSknJZ3cPiJ/RGvu97CSTKMjCqSWk9QubnGIOrc/Tp1Z5c
         53moZSQPDaTkh0pwJNYDaJvv9gL9CScThSw732oTOASjDl9sH05BfOOEoe2LWLknXp3b
         TueAKy4jsPzc2y2D4qNlda6kZcE3Q7pesJeN+voTOnqTB8YKIIK4YFrR4mjo2bHt0+ok
         XGRXNDSuW9E+cNLJVfNCDKPO1D4Q+SDBnH1gEnS2DKsjWXbtUSWbscpRnKfJw3FNoSaH
         AVhA==
X-Gm-Message-State: AOAM533bcnCq46Q5qcN+yRClHt629wAGQ/VLZZpDw+rPa+wI39v+NnnY
        AF1tWP1nslQZR/yM3h3+MA==
X-Google-Smtp-Source: ABdhPJw4d2l4D3XuTTkG0JRuxdgFCt9I5nUEczOBakoAQ5sI8WzbZQ5Il3Wlv+iiw1pK+h8OPxotSQ==
X-Received: by 2002:a05:620a:1f1:: with SMTP id x17mr9493015qkn.227.1631304993400;
        Fri, 10 Sep 2021 13:16:33 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id y29sm4149284qtm.4.2021.09.10.13.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:16:32 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:16:28 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Folio discussion recap
Message-ID: <YTu9HIu+wWWvZLxp@moria.home.lan>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSPwmNNuuQhXNToQ@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So I've been following the folio discussion, and it seems like the discussion
has gone off the rails a bit partly just because struct page is such a mess and
has been so overused, and we all want to see that cleaned up but we're not being
clear about what that means. I was just talking with Johannes off list, and I
thought I'd recap that discussion as well as other talks with Mathew and see if
I can lay something out that everyone agrees with.

Some background:

For some years now, the overhead of dealing with 4k pages in the page cache has
gotten really, really painful. Any time we're doing buffered IO, we end up
walking a radix tree to get to the cached page, then doing a memcpy to or from
that page - which quite conveniently blows away the CPU cache - then walking
the radix tree to look up the next page, often touching locks along the way that
are no longer in cache - it's really bad.

We've been hacking around this - the btrfs people have a vectorized buffered
write path, and also this is what my generic_file_buffered_read() patches we're
about, batching up the page cache lookups - but really these are hacks that make
our core IO paths even more complicated, when the right answer that's been
staring all of us filesystem people in the face for years has been that it's
2021 and dealing with cached data in 4k chunks (when block based filesystems are
a thing of the past!) is abject stupidity.

So we need to be moving to larger, variable sized allocations for cached data.
We NEED this, this HAS TO HAPPEN - spend some time really digging into profiles,
and looking actual application usage, this is the #1 thing that's killing our
performance in the IO paths. Remember, us developers tend to be benchmarking
things like direct IO and small random IOs because we're looking at the whole IO
path, but most reads and writes are buffered, and they're already in cache, and
they're mostly big and sequential.

I emphasize this because a lot of us have really been waiting rather urgently
for Willy's work to go in, and there will no doubt be a lot more downstream
filesystem work to be done to fully take advantage of it and we're waiting on
this stuff to get merged so we can actually start testing and profiling the
brave new world and seeing what to work on next.

As an aside, before this there have been quite a few attempts at using
hugepages to deal with these issues, and they're all _fucking gross_, because
they all do if (normal page) else if (hugepage), and they all cut and paste
filemap.c code because no one (rightly) wanted to add their abortions to the
main IO paths. But look around the kernel and see how many times you can find
core filemap.c code duplicated elsewhere... Anyways, Willy's work is going to
let us delete all that crap.

So: this all means that filesystem code needs to start working in larger,
variable sized units, which today means - compound pages. Hence, the folio work
started out as a wrapper around compound pages.

So, one objection to folios has been that they leak too much MM details out into
the filesystem code. To that we must point out: all the code that's going to be
using folios is right now using struct page - this isn't leaking out new details
and making things worse, this is actually (potentially!) a step in the right
direction, by moving some users of struct page to a new type that is actually
created for a specific purpose.

I think a lot of the acrimony in this discussion came precisely from this mess;
Johannes and the other MM people would like to see this situation improved so
that they have more freedom to reengineer and improve things on their side. One
particularly noteworthy idea was having struct page refer to multiple hardware
pages, and using slab/slub for larger alloctions. In my view, the primary reason
for making this change isn't the memory overhead to struct page (though reducing
that would be nice); it's that the slab allocator is _significantly_ faster than
the buddy allocator (the buddy allocator isn't percpu!) and as average
allocation sizes increase, this is hurting us more and more over time.

So we should listen to the MM people.

Fortunately, Matthew made a big step in the right direction by making folios a
new type. Right now, struct folio is not separately allocated - it's just
unionized/overlayed with struct page - but perhaps in the future they could be
separately allocated. I don't think that is a remotely realistic goal for _this_
patch series given the amount of code that touches struct page (thing: writeback
code, LRU list code, page fault handlers!) - but I think that's a goal we could
keep in mind going forward.

We should also be clear on what _exactly_ folios are for, so they don't become
the new dumping ground for everyone to stash their crap. They're to be a new
core abstraction, and we should endeaver to keep our core data structures
_small_, and _simple_. So: no scatter gather. A folio should just represent a
single buffer of physically contiguous memory - vmap is slow, kmap_atomic() only
works on single pages, we do _not_ want to make filesystem code jump through
hoops to deal with anything else. The buffers should probably be power of two
sized, as that's what the buddy allocator likes to give us - that doesn't
necessarily have to be baked into the design, but I can't see us ever actually
wanting non power of two sized allocations.

Q: But what about fragmentation? Won't these allocations fail sometimes?

Yes, and that's OK. The relevant filesystem code is all changing to handle
variable sized allocations, so it's completely fine if we fail a 256k allocation
and we have to fall back to whatever is available.

But also keep in mind that switching the biggest consumer of kernel side memory
to larger allocations is going to do more than anything else to help prevent
memory from getting fragmented in the first place. We _want_ this.

Q: Oh yeah, but what again are folios for, exactly?

Folios are for cached filesystem data which (importantly) may be mapped to
userspace.

So when MM people see a new data structure come up with new references to page
size - there's a very good reason with that, which is that we need to be
allocating in multiples of the hardware page size if we're going to be able to
map it to userspace and have PTEs point to it.

So going forward, if the MM people want struct page to refer to muliple hardware
pages - this shouldn't prevent that, and folios will refer to multiples of the
_hardware_ page size, not struct page pagesize.

Also - all the filesystem code that's being converted tends to talk and thing in
units of pages. So going forward, it would be a nice cleanup to get rid of as
many of those references as possible and just talk in terms of bytes (e.g. I
have generally been trying to get rid of references to PAGE_SIZE in bcachefs
wherever reasonable, for other reasons) - those cleanups are probably for
another patch series, and in the interests of getting this patch series merged
with the fewest introduced bugs possible we probably want the current helpers.

-------------

That's my recap, I hope I haven't missed anything. The TL;DR is:

 * struct page is a mess; yes, we know. We're all living with that pain.

 * This isn't our ultimate end goal (nothing ever is!) - but it's probably along
   the right path.

 * Going forward: maybe struct folio should be separately allocated. That will
   entail a lot more work so it's not appropriate for this patch series, but I
   think it's a goal that would make everyone 

 * We should probably think and talk more concretely about what our end goals
   are.

Getting away from struct page is something that comes up again and again - DAX
is another notable (and acrimonious) area this has come up. Also, page->mapping
and page->index make sharing cached data in different files (thing: reflink,
snapshots) pretty much non starters.

I'm going to publicly float one of my own ideas here: maybe entries in the page
cache radix tree don't have to be just a single pointer/ulong. If those entries
were bigger, perhaps some things would fit better there than in either struct
page/folio.


Excessive PAGE_SIZE usage:
--------------------------

Another thing that keeps coming up is - indiscriminate use of PAGE_SIZE makes it
hard, especially when we're reviewing new code, to tell what's a legitimate use
or not. When it's tied to the hardware page size (as folios are), it's probably
legitimate, but PAGE_SIZE is _way_ overused.

Partly this was because historically slab had to be used for small allocations
and the buddy allocator, __get_free_pages(), had to be used for larger
allocations. This is still somewhat the case - slab can go up to something like
128k, but there's still a hard cap on allocation size with kmalloc().

Perhaps the MM people could look into lifting this restriction, so that
kmalloc() could be used for any sized physically contiguous allocation that the
system could satisfy?  If we had this, then it would make it more practical to
go through and refactor existing code that uses __get_free_pages() and convert
it to kmalloc(), without having to stare at code and figure out if it's safe.

And that's my $.02
