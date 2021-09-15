Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8941840C861
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhIOPjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbhIOPjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:39:37 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC0C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 08:38:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c10so3825662qko.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ArUAuTE9FGqrnr42N0MK/D8RpNpSVBjMgHCZx6+GIEE=;
        b=sx3+gk4bOsezocNCIPVCPoOkAU0OfdbcR0iEjl35YM8b3q21o9WQi8X0ExvviCs9ps
         BXivS2QkT4LLxb/9cK4NC95iAikcxs1H0NYGkYXSqIJNfjCUzN1HzfAGSABQR0adv4Vw
         uAfvyH+mASxOnNSz1AH409r5rmOYvLewVy1kNCVop35hYkNoJUZqyYRNBrEL57vK/8oL
         jUXCYnR1OBHn6INnyYrIRn915Bagrk71ahAzaU8j8GoxNIMOEbXRSGSPR/Tz/pMswDKd
         vLyzsxhKrt+lKdhfHwjn1kUck9gVt1XBNBGvJ3NQRYPR+G+p9ta7szneQWq7YBGym+Q7
         iZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ArUAuTE9FGqrnr42N0MK/D8RpNpSVBjMgHCZx6+GIEE=;
        b=CcN7pbTlRgC2MCT5Os9z4LMG+Gb+k+/Cz92gxq5wpWy+qrJSFKhOpO164Nal5x9yRG
         4tqMbxuKLARF7zuxL7RznklODK2qVNy6BEcqWzaSBoNA3g7+zEPowO4rbq7vTX5wH7Br
         l+BkvxKL8eVVdaLqrOlvyUZAck0tOYQZevbXL+RO6Mc1K5VAnQi+OyRC01DtmOuLZHe1
         MHgKNsHC8Bza1HPxP8aq/r1EAUQtDkpnt3GpDLqVzCd+4cf27klEGJn99aEgFw/ee2Me
         O1X51Ge6Qf6KMDL0cJ6ik0JvKDVSqvqK97p80ovagCudLGIcTwn/1TOhkN2fqMdE7nuo
         W+fQ==
X-Gm-Message-State: AOAM533vcrlHV9jVwCQ04gl4iKVcKFVgDzDGQoWc86sTZG/KcnTqTiqZ
        qJWHlfWWlzpI5n9dDQBc8J7SAg==
X-Google-Smtp-Source: ABdhPJzFVviZm5h4lwNbgHsw4DtC7FKLYC+KKLDqfzfmhPoEJGa2LiJwHLhmuAiNyCZnuSCCVnYjtA==
X-Received: by 2002:a05:620a:4094:: with SMTP id f20mr531393qko.488.1631720296514;
        Wed, 15 Sep 2021 08:38:16 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id c28sm223332qkl.69.2021.09.15.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 08:38:15 -0700 (PDT)
Date:   Wed, 15 Sep 2021 11:40:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUIT2/xXwvZ4IErc@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTu9HIu+wWWvZLxp@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:16:28PM -0400, Kent Overstreet wrote:
> One particularly noteworthy idea was having struct page refer to
> multiple hardware pages, and using slab/slub for larger
> alloctions. In my view, the primary reason for making this change
> isn't the memory overhead to struct page (though reducing that would
> be nice);

Don't underestimate this, however.

Picture the near future Willy describes, where we don't bump struct
page size yet but serve most cache with compound huge pages.

On x86, it would mean that the average page cache entry has 512
mapping pointers, 512 index members, 512 private pointers, 1024 LRU
list pointers, 512 dirty flags, 512 writeback flags, 512 uptodate
flags, 512 memcg pointers etc. - you get the idea.

This is a ton of memory. I think this doesn't get more traction
because it's memory we've always allocated, and we're simply more
sensitive to regressions than long-standing pain. But nevertheless
this is a pretty low-hanging fruit.

The folio makes a great first step moving those into a separate data
structure, opening the door to one day realizing these savings. Even
when some MM folks say this was never the intent behind the patches, I
think this is going to matter significantly, if not more so, later on.

> Fortunately, Matthew made a big step in the right direction by making folios a
> new type. Right now, struct folio is not separately allocated - it's just
> unionized/overlayed with struct page - but perhaps in the future they could be
> separately allocated. I don't think that is a remotely realistic goal for _this_
> patch series given the amount of code that touches struct page (thing: writeback
> code, LRU list code, page fault handlers!) - but I think that's a goal we could
> keep in mind going forward.

Yeah, agreed. Not doable out of the gate, but retaining the ability to
allocate the "cache entry descriptor" bits - mapping, index etc. -
on-demand would be a huge benefit down the road for the above reason.

For that they would have to be in - and stay in - their own type.

> We should also be clear on what _exactly_ folios are for, so they don't become
> the new dumping ground for everyone to stash their crap. They're to be a new
> core abstraction, and we should endeaver to keep our core data structures
> _small_, and _simple_.

Right. struct page is a lot of things and anything but simple and
obvious today. struct folio in its current state does a good job
separating some of that stuff out.

However, when we think about *which* of the struct page mess the folio
wants to address, I think that bias toward recent pain over much
bigger long-standing pain strikes again.

The compound page proliferation is new, and we're sensitive to the
ambiguity it created between head and tail pages. It's added some
compound_head() in lower-level accessor functions that are not
necessary for many contexts. The folio type safety will help clean
that up, and this is great.

However, there is a much bigger, systematic type ambiguity in the MM
world that we've just gotten used to over the years: anon vs file vs
shmem vs slab vs ...

- Many places rely on context to say "if we get here, it must be
  anon/file", and then unsafely access overloaded member elements:
  page->mapping, PG_readahead, PG_swapcache, PG_private

- On the other hand, we also have low-level accessor functions that
  disambiguate the type and impose checks on contexts that may or may
  not actually need them - not unlike compound_head() in PageActive():

  struct address_space *folio_mapping(struct folio *folio)
  {
	struct address_space *mapping;

	/* This happens if someone calls flush_dcache_page on slab page */
	if (unlikely(folio_test_slab(folio)))
		return NULL;

	if (unlikely(folio_test_swapcache(folio)))
		return swap_address_space(folio_swap_entry(folio));

	mapping = folio->mapping;
	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
		return NULL;

	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
  }

  Then we go identify places that say "we know it's at least not a
  slab page!" and convert them to page_mapping_file() which IS safe to
  use with anon. Or we say "we know this MUST be a file page" and just
  access the (unsafe) mapping pointer directly.

- We have a singular page lock, but what it guards depends on what
  type of page we're dealing with. For a cache page it protects
  uptodate and the mapping. For an anon page it protects swap state.

  A lot of us can remember the rules if we try, but the code doesn't
  help and it gets really tricky when dealing with multiple types of
  pages simultaneously. Even mature code like reclaim just serializes
  the operation instead of protecting data - the writeback checks and
  the page table reference tests don't seem to need page lock.

  When the cgroup folks wrote the initial memory controller, they just
  added their own page-scope lock to protect page->memcg even though
  the page lock would have covered what it needed.

- shrink_page_list() uses page_mapping() in the first half of the
  function to tell whether the page is anon or file, but halfway
  through we do this:

	  /* Adding to swap updated mapping */
          mapping = page_mapping(page);

  and then use PageAnon() to disambiguate the page type.

- At activate_locked:, we check PG_swapcache directly on the page and
  rely on it doing the right thing for anon, file, and shmem pages.
  But this flag is PG_owner_priv_1 and actually used by the filesystem
  for something else. I guess PG_checked pages currently don't make it
  this far in reclaim, or we'd crash somewhere in try_to_free_swap().

  I suppose we're also never calling page_mapping() on PageChecked
  filesystem pages right now, because it would return a swap mapping
  before testing whether this is a file page. You know, because shmem.

These are just a few examples from an MM perspective. I'm sure the FS
folks have their own stories and examples about pitfalls in dealing
with struct page members.

We're so used to this that we don't realize how much bigger and
pervasive this lack of typing is than the compound page thing.

I'm not saying the compound page mess isn't worth fixing. It is.

I'm saying if we started with a file page or cache entry abstraction
we'd solve not only the huge page cache, but also set us up for a MUCH
more comprehensive cleanup in MM code and MM/FS interaction that makes
the tailpage cleanup pale in comparison. For the same amount of churn,
since folio would also touch all of these places.
