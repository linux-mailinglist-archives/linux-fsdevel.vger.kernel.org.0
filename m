Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30029C99E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 21:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830841AbgJ0UFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 16:05:05 -0400
Received: from casper.infradead.org ([90.155.50.34]:54842 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460397AbgJ0UFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tzWPcYHuy72jM3lfq5yTC7lqPQiYT06h+bTUgYiDIAw=; b=tttj6ypZroxZq2rn47tx6H2Ebs
        4qeGp1M+Hsc4l1FsGZoew0kbQxvTbhzd2T1KvBFDF7+YMACwxFE+YPi49yhvGwsWVw6AWiU6dcNbZ
        gqYAWUuXbwdj05Bb9qDtJhUrjIQvIcoqw2jkNJOqoReBNdhVdfRZXolbazzyWLGzwUWCwQzWlgaSy
        jwcFJzCx9W76rL/ScWDuK3oVgf6sZV9wcX4bBtPuTEHHO8BzFE13kpdxkbG4tkXCFQqp3JbFIVy3R
        a9HplTuCmGfp56hPF0E07u1L2lNS79kQXse5pDi1hKudx6CrAfTbZpIsdHTXiKoWbM8Ft4ER6T4jO
        1ft9z6eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXVDG-0000Ep-Tq; Tue, 27 Oct 2020 20:04:59 +0000
Date:   Tue, 27 Oct 2020 20:04:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 04/12] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20201027200458.GX20115@casper.infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-5-willy@infradead.org>
 <20201027185809.GB15201@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027185809.GB15201@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 06:58:09PM +0000, Christoph Hellwig wrote:
> > +/**
> > + * mapping_seek_hole_data - Seek for SEEK_DATA / SEEK_HOLE in the page cache.
> > + * @mapping: Address space to search.
> > + * @start: First byte to consider.
> > + * @end: Limit of search (exclusive).
> > + * @whence: Either SEEK_HOLE or SEEK_DATA.
> > + *
> > + * If the page cache knows which blocks contain holes and which blocks
> > + * contain data, your filesystem can use this function to implement
> > + * SEEK_HOLE and SEEK_DATA.  This is useful for filesystems which are
> > + * entirely memory-based such as tmpfs, and filesystems which support
> > + * unwritten extents.
> > + *
> > + * Return: The requested offset on successs, or -ENXIO if @whence specifies
> > + * SEEK_DATA and there is no data after @start.  There is an implicit hole
> > + * after @end - 1, so SEEK_HOLE returns @end if all the bytes between @start
> > + * and @end contain data.
> > + */
> 
> This seems to just lift the tmpfs one to common code.  If it really
> is supposed to be generic it should be able to replace
> page_cache_seek_hole_data as well.  So I don't think moving this without
> removing the other common one is an all that good idea.

I have that patch here:

http://git.infradead.org/users/willy/pagecache.git/commitdiff/a4e435b5ed14a0b898da6e5a66fe232f467b8ba1

I was going to let this patch go upstream through Andrew's tree, then
submit that one through Darrick's tree.  But I can add that patch to
the next submission of this series if you'd rather.
