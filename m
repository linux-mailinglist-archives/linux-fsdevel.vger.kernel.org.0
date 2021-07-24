Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3F3D4941
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 20:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhGXSJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhGXSJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:09:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6970AC061575;
        Sat, 24 Jul 2021 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eTIqvGtmgSD1grJHtfLM6OPgrkrmdCF2vMDDkcCO9xM=; b=akqHBRwHpJ3ScR0Pn2WCaCdoTi
        pdA+NUUAPz92r+ZAn2WpHPkluxu7XqiuyiDmiOFgDkEepmQHi8WRmWwTMkQsLTrW0UACI7Vp24pIM
        S537piHtomKG30N9Tnc7L7szCRymrlfaNK+pS5OhxTJlZWuMPj+ihlr22KoYkSPgr/SU9vhDErNPm
        NNMDNVVnL+rD+8PZmqY0cue2xlkXJMtqcK7lEZTI7vkKoQ5tF9QZ9AMaqpQ5lyXtcAeT9AbXQF1jF
        fZ1EPdOl9qtDU+tRnykno/ZbapvYKr/KkIHaCbOzDUPTr5IhgPQj06/h7dZa4cTVHPXFn69kkG+/l
        qMmfq2Xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7Mir-00CTiD-Iv; Sat, 24 Jul 2021 18:50:13 +0000
Date:   Sat, 24 Jul 2021 19:50:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andres Freund <andres@anarazel.de>,
        Michael Larabel <Michael@michaellarabel.com>
Subject: Re: Folios give an 80% performance win
Message-ID: <YPxg3RYDp/C7/ack@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
 <YPxYdhEirWL0XExY@casper.infradead.org>
 <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 11:23:25AM -0700, James Bottomley wrote:
> On Sat, 2021-07-24 at 19:14 +0100, Matthew Wilcox wrote:
> > On Sat, Jul 24, 2021 at 11:09:02AM -0700, James Bottomley wrote:
> > > On Sat, 2021-07-24 at 18:27 +0100, Matthew Wilcox wrote:
> > > > What blows me away is the 80% performance improvement for
> > > > PostgreSQL. I know they use the page cache extensively, so it's
> > > > plausibly real. I'm a bit surprised that it has such good
> > > > locality, and the size of the win far exceeds my
> > > > expectations.  We should probably dive into it and figure out
> > > > exactly what's going on.
> > > 
> > > Since none of the other tested databases showed more than a 3%
> > > improvement, this looks like an anomalous result specific to
> > > something in postgres ... although the next biggest db: mariadb
> > > wasn't part of the tests so I'm not sure that's
> > > definitive.  Perhaps the next step should be to t
> > > est mariadb?  Since they're fairly similar in domain (both full
> > > SQL) if mariadb shows this type of improvement, you can
> > > safely assume it's something in the way SQL databases handle paging
> > > and if it doesn't, it's likely fixing a postgres inefficiency.
> > 
> > I think the thing that's specific to PostgreSQL is that it's a heavy
> > user of the page cache.  My understanding is that most databases use
> > direct IO and manage their own page cache, while PostgreSQL trusts
> > the kernel to get it right.
> 
> That's testable with mariadb, at least for the innodb engine since the
> flush_method is settable. 

We're still not communicating well.  I'm not talking about writes,
I'm talking about reads.  Postgres uses the page cache for reads.
InnoDB uses O_DIRECT (afaict).  See articles like this one:
https://www.percona.com/blog/2018/02/08/fsync-performance-storage-devices/

: The first and most obvious type of IO are pages reads and writes from
: the tablespaces. The pages are most often read one at a time, as 16KB
: random read operations. Writes to the tablespaces are also typically
: 16KB random operations, but they are done in batches. After every batch,
: fsync is called on the tablespace file handle.

(the current folio patch set does not create multi-page folios for
writes, only for reads)

I downloaded the mariadb source package that's in Debian, and from
what I can glean, it does indeed set O_DIRECT on data files in Linux,
through os_file_set_nocache().

> > Regardless of whether postgres is "doing something wrong" or not,
> > do you not think that an 80% performance win would exert a certain
> > amount of pressure on distros to do the backport?
> 
> Well, I cut the previous question deliberately, but if you're going to
> force me to answer, my experience with storage tells me that one test
> being 10x different from all the others usually indicates a problem
> with the benchmark test itself rather than a baseline improvement, so
> I'd wait for more data.

... or the two benchmarks use Linux in completely different ways such
that one sees a huge benefit while the other sees none.  Which is what
you'd expect for a patchset that improves the page cache and using a
benchmark that doesn't use the page cache.
