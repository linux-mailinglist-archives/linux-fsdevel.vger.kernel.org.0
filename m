Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66AF520678
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 23:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiEIVL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiEIVLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 17:11:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C612764DC
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Awpoi92d6BGRHldlrI1n1IDNkGK4KkErDKD8MdV98vA=; b=ObXvNU/eSqVM79/ImXhLKNM8OM
        RgdCxM1fAdXgepfvR141zYkMDNIrGns+0RxKD6Gf1LH6xx1niJg1tIs3IWLxc3kJuzeLD489WyrmV
        fNraU9GCaFu3k8h26yY+sAn0RqUmTucFe6isli5Tc9OR6yFrX6tKp0wZNOZPL8k/4uPWGOyOyw+tk
        k5aPQHsPdDUdSwDfsaf5YXLQXHTQPfhhNPDtqfUiQd5euBAITREkoUr49ryA1SUixIlQTFHEYA1/9
        G2eiEp6A3ZPKDItln9N0fKoB20Jad5+gIdMQ05PtvvkFJnskxoSFT27ELeU0TjIJfe6pviIeAnRKt
        8Vy6HbWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noAav-003oHd-DK; Mon, 09 May 2022 21:07:05 +0000
Date:   Mon, 9 May 2022 22:07:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/37] ext4: Convert ext4 to read_folio
Message-ID: <YnmCeRJe5w2bVF1u@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
 <20220508203131.667959-19-willy@infradead.org>
 <YnkXjPZMSC+yYGOe@mit.edu>
 <YnkgGJdQpT6UZtI3@casper.infradead.org>
 <Ynl2k7FNEBB0awNs@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynl2k7FNEBB0awNs@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 04:16:19PM -0400, Theodore Ts'o wrote:
> > but the page
> > cache is absolutely not supposed to be creating large folios for
> > filesystems that haven't indicated their support for such by calling
> > mapping_set_large_folios().
> 
> I think my concern is that at some point in the future, ext4 probably
> *will* want to enable large folios --- and we may want to do so
> selectively.  e.g., just on the read-path, and assume that someone
> will break apart large folios to individual pages on the write path,
> for example.

My mental model doesn't include that last part -- if the filesystem says
it supports large folios, then it supports large folios, including read,
write-into, writeback, etc.  The filesystem can (of course) split the
page itself, but page splitting can fail, and part of the point of all
this is to keep the memory allocation as a single object throughout its
allocation-usage-free lifecycle.

> The question is when do we add all of these sanity check asserts ---
> at the point when ext4 starts making the transition from large folio
> unaware, to large folio kind-of-aware, and hope we don't miss any of
> these interfaces?  Or add those sanity check asserts now, so we get
> reminded that some of these functions may need fixing up when we start
> adding large folio support to the file system?

Right!  I went through the same questions when starting to work on iomap
-- how do we know which of these functions is really capable of dealing
with large folios.  The good news is that xfstests blows up in very
entertaining and obvious ways, so most of this you really can do by
trial and error.  That's obviously a bit unsatisfying ...

As I convert utility functions to take a folio, I try not to leave
landmines; I either convert the function to work on a folio of arbitrary
size, or I leave a VM_BUG_ON_FOLIO in there to help the first person
who tries to use it with a large folio.  Of course, there can always
be places I missed.  If there's anywhere still using a struct page,
that's always cause for greater scrutiny.

> Also, what's the intent for when the MM layer would call
> aops->read_folio() with the intent to fill a huge folio, versus
> calling aops->readahead()?  After all, when we take a page fault,
> it'll be either a 4k page, right?  We currently don't support
> file-backed huge pages; is there a plan to change this?

One of the recent changes to the pagecache (from Jens, iirc) is that
we _always_ call ->readahead() before calling ->read_folio().  That's a
really good thing because it means you can now make your ->read_folio()
synchronous and return the exact error instead of sending off an I/O
and signalling the page "had an error" and returning -EIO to userspace.

The decision about whether to use THP for file-backed faults is
currently left up to userspace.  Commit 4687fdbb805a added support for
the existing MADV_HUGEPAGE to file-backed pages.  I'm not inclined to
leave the decision entirely up to userspace ... I think we should notice
that userspace is behaving in a way that using larger folios would be
beneficial, and eventually end up going all the way to THPs.  However,
the vast majority of applications do not use mmap() on files, so I'm
not too enthusiastic about adding that support until someone comes to
me with a use case.

I did just notice that I need to update the manpage for madvise(2).

> P.S.  On a somewhat unrelated issue, if we have a really large folio
> caused by a 4MB readahead because CIFS really wanted a huge readahead
> size because of the network setup overhead --- and then a single 4k
> page gets dirtied, I imagine the VM subsystem *want* to break apart
> that 4MB folio so that we know that only that single 4k page was
> dirtied, and not require writing back a huge amount of clean 4k pages
> just because we didn't track dirtiness at the right granularity,
> right?

Well ... we don't necessarily grow the folio size all the way up to
the size of the readahead window.  The two are decoupled to a certain
extent (obviously the folio size won't exceed the readahead size!)  And I
currently limit the readahead folio size to PMD_SIZE because I don't want
to track down all the places that assume a PMD page is exactly PMD_SIZE.

But no, the VM doesn't want to break up 4MB pages just because we only
dirtied 4KB of it.  We do tell the FS which parts of it are dirtied, so if
the FS wants to keep track of what is dirty at a sub-folio level, it can.
But it doesn't have to; choosing the granularity of dirtiness is a job
for the filesystem, not the VM.  It can be beneficial to do a larger
write than what is dirty, or some filesystems want to be byte-precise
in what they write back.

If an application has exhibited good locality in reads (enough to get
readahead growing to 4MB), the hope is that it will also exhibit good
locality in writes, so absorbing a lot of writes to the same 4MB page
before it gets written back in a big chunk will actually be a good thing.

Obviously, that's something we'll only know is true once users start
banging on this feature in earnest.  We may need to adjust how we handle
large folios to make users happier.  I don't think we can reasonably
anticipate the problems they'll see.
