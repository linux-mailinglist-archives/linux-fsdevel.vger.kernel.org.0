Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ADE3F68B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhHXSET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbhHXSEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:04:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F7EC035426;
        Tue, 24 Aug 2021 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pTa7CJ6QaTq6UueYZg9lyVDrVwoJx5n2tyWb82cOfR0=; b=CTZxkTVCpt8lr38ykH3ksUqKTC
        spllFLWvt5uzaa0YpRVVqpqvIzdPS1hh1NZTcwUCGU2UzW67tQXdB9n13bhxwNMOwhYPAxEB9VnOO
        Ih/U9EsYoY6ly9jiBGwkEizMbOonx07+f+gh1aPVCyAy97C8x3bU+4j/UgrRkuoHjuO4AuN0fMFGW
        fi7zB6U1Bw5Gxp1f4lq1WIKvRA6PBCrzXZNPWHZpj34H/Mwkw0zOjMPT9ESIAuNhsW52oto83eSAQ
        fNMSiSGxY2TcsTQw9v2Gi7DG0otiljMNtHnaCcJqv2dLOAL3QhAWa2veX3G5k5DSA6NmUJuz8EW10
        XuebDQcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIafB-00BNao-VY; Tue, 24 Aug 2021 17:56:58 +0000
Date:   Tue, 24 Aug 2021 18:56:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSUy2WwO9cuokkW0@casper.infradead.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1957060.1629820467@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 04:54:27PM +0100, David Howells wrote:
> One question does spring to mind, though: do filesystems even need to know
> about hardware pages at all?  They need to be able to access source data or a
> destination buffer, but that can be stitched together from disparate chunks
> that have nothing to do with pages (eg. iov_iter); they need access to the
> pagecache, and may need somewhere to cache pieces of information, and they
> need to be able to pass chunks of pagecache, data or bufferage to crypto
> (scatterlists) and I/O routines (bio, skbuff) - but can we hide "paginess"
> from filesystems?
> 
> The main point where this matters, at the moment, is, I think, mmap - but
> could more of that be handled transparently by the VM?

It really depends on the filesystem.  I just audited adfs, for example,
and there is literally nothing in there that cares about struct page.
It passes its arguments from ->readpage and ->writepage to
block_*_full_page(); it uses cont_write_begin() for its ->write_begin;
and it uses __set_page_dirty_buffers for its ->set_page_dirty.

Then there are filesystems like UFS which use struct page extensively in
its directory handling.  And NFS which uses struct page throughout.
Partly there's just better infrastructure for block-based filesystems
(which you're fixing) and partly NFS is trying to perform better than
a filesystem which exists for compatibility with a long-dead OS.

> > Because, as you say, head pages are the norm. And "folio" may be a
> > clever term, but it's not very natural. Certainly not at all as
> > intuitive or common as "page" as a name in the industry.
> 
> That's mostly because no one uses the term... yet, and that it's not commonly
> used.  I've got used to it in building on top of Willy's patches and have no
> problem with it - apart from the fact that I would expect something more like
> a plural or a collective noun ("sheaf" or "ream" maybe?) - but at least the
> name is similar in length to "page".
> 
> And it's handy for grepping ;-)

If the only thing standing between this patch and the merge is
s/folio/ream/g, I will do that.  All three options are equally greppable
(except for 'ream' as a substring of dream, stream, preamble, scream,
whereami, and typos for remain).

