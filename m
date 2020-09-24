Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A87277C8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 01:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIXX6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 19:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIXX6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 19:58:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531CC0613CE;
        Thu, 24 Sep 2020 16:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J/tuyLxu5cq1kPHap7w/ykYlaZ9fPtuLFMVuedHctq0=; b=eIcNbl1HriAwt/NIhyhYCjCa6k
        tsuUYxO+iD6Ip6B9mLD1nN1N+Zy8AyJjn9cNKUeduLZAI7W2/7jL1wbHALAtVsDDUXl+3wMA8i1JI
        IWsYuPyiKy5pRfd861FDZojdkO7ZWPG+qyU99OPUYKJ7vipdR9IvRaSObHGqp5dfVnT31wp5bxwV+
        UDjlkh8aexyAH1M3ipZEOE9O73+WsC6eSaJ5eMErlAyV6Yw10CXEynBMn12M01NdkUjk4qRD9PxK5
        zVBWo4IRa2+cpy5IHrEdyaShMmDiuInJBx4kMYjitpjNVNe7TTuK/7S+ASM8mXIx8vvHkBcWDUz3p
        37/rngkw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLb7c-0005p0-LS; Thu, 24 Sep 2020 23:57:56 +0000
Date:   Fri, 25 Sep 2020 00:57:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200924235756.GD32101@casper.infradead.org>
References: <20200924151538.GW32101@casper.infradead.org>
 <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
 <20200924152755.GY32101@casper.infradead.org>
 <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org>
 <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org>
 <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 10:04:40PM +0200, Sedat Dilek wrote:
> On Thu, Sep 24, 2020 at 10:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Sep 24, 2020 at 09:54:36PM +0200, Sedat Dilek wrote:
> > > You are named in "mm: fix misplaced unlock_page in do_wp_page()".
> > > Is this here a different issue?
> >
> > Yes, completely different.  That bug is one Linus introduced in this
> > cycle; the bug that this patch fixes was introduced a couple of years
> > ago, and we only noticed now because I added an assertion to -next.
> > Maybe I should add the assertion for 5.9 too.
> 
> Can you point me to this "assertion"?
> Thanks.

Here's the version against 5.8

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 810f7dae11d9..b421e4efc4bd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -70,11 +70,15 @@ static void
 iomap_page_release(struct page *page)
 {
 	struct iomap_page *iop = detach_page_private(page);
+	unsigned int nr_blocks = PAGE_SIZE / i_blocksize(page->mapping->host);
 
 	if (!iop)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
+	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
+			PageUptodate(page));
+
 	kfree(iop);
 }
 
