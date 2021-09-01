Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE923FD703
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 11:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbhIAJmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbhIAJmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:42:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32503C061575;
        Wed,  1 Sep 2021 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6TBF+qXplc9oeCUOY+UjwCh+LIVpyFyk42tsJE47zzc=; b=dqWKrOMNN3eJvo4aHYae9gFmrM
        VyRA/uIp3lROX+RFWQcbkLXz1Yaq8CegwdNirdWf8U5rc7Xpl89yG3I+Bt62r5ZvXxtfsLcZE22A7
        p+1xifRCxwXZCOsiYJYIf8QCK0z4OYBu7VxfZtTyYozz8bRZzXWUfcn2zZ5OHwU1nQ5HwDziiqk7w
        0Tdjlch7I2luiDWTEgPDVYgFIkEdWUB4+cCi9GZq+x7saZ53dzYG1n/6MbSX5LD4kJuDIxOj1xXOO
        SQEuEIWDWWVS10gBOnie2RpN83bbzf2kM8dZXNbyZVz6gJqaz28y1BDv9jtCIHNgAdwRd2o3wDCU7
        SfPmfJ1A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLMj3-0026bK-LF; Wed, 01 Sep 2021 09:40:18 +0000
Date:   Wed, 1 Sep 2021 10:40:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Discontiguous folios/pagesets
Message-ID: <YS9KeV6cwVlBT14R@infradead.org>
References: <YSqIry5dKg+kqAxJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSqIry5dKg+kqAxJ@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 08:04:15PM +0100, Matthew Wilcox wrote:
> Non-power-of-two folios are more awkward.  Any calls to folio_order()
> and folio_shift() have to be guarded by folio_test_contig() (which will
> be fine).  The bigger problem is the radix tree.  It really only works
> for power-of-two sized objects (and honestly, it's not even all that
> great for things which aren't a power of 64 in size).  See appendix
> for more details.

Honestly I think this framing the wrong problem.  Folios are a way
to manage memory which should be about how to manage memory, not about
offloading awkward file systems tasks to performance sensitive core
code.

Right now the proper answer to supporting reflinks on RT devices with
non-power of two extent sizes is don't do it, which is pretty easy
given that XFS doesn't even support reflink on the RT device at all
yet.  And if someone has a strong enough use case for eflinks on a weird
extent size RT device they'll find  way to support it, preferably
without making a mess out of the core Linux memory management.  Because
even if we did support non-power of two folios sizes we'd still need
to gurantee XFS would always be able to allocate one for that case,
which just sounds like a trainwreck waiting to happen.
