Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF89320C09
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 18:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBURQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 12:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhBURQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 12:16:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7FCC061574;
        Sun, 21 Feb 2021 09:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AOsa6QLKiBxd9IXor0Ks1BmuObn2r2CzlMsd1FiSqZk=; b=mkXhOpibR/jP1Bck8iR0Ny+ZcA
        uF1uiE+nQZqFOzwzrdDtl3cCJ9TkMsbVZXUxZVLp8MjC8l6ryLx8JNkYDcIyARpWS/Ffq1nmH6gE4
        8IIB9u0N9nlcj0oWB4Oep6VK2UJh6F1Myw4SdEY4bx+EjKK6nV9k7QLgjcXbpQ7eB1LXeV8g5SfIn
        ozQvCrqZwSx8wX1/ah+sIeDPwYIf8h1j0p0qppcdXaCMfnN4sl7JueMNhyO7KWhJeVseQu3YVvmUR
        6bxyzVdrm8OyJ5B5FeuFrHYIQu02/CLwi6ZITYt3vlDu8LgQYVHqjh8Gc2v1I5tdrC2BsbRrn8xHC
        em70uvxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDsKX-005WOk-8p; Sun, 21 Feb 2021 17:15:37 +0000
Date:   Sun, 21 Feb 2021 17:15:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210221171537.GG2858050@casper.infradead.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
 <b3e40749-a30d-521a-904f-8182c6d0e258@rkjnsn.net>
 <20210220232224.GF2858050@casper.infradead.org>
 <CAMj6ewPxYkoPuVmER7QuBfyDK4O9Ksr4OZTiGkpGvbg4kmxh6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj6ewPxYkoPuVmER7QuBfyDK4O9Ksr4OZTiGkpGvbg4kmxh6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 04:01:17PM -0800, Erik Jensen wrote:
> On Sat, Feb 20, 2021 at 3:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Sat, Feb 20, 2021 at 03:02:26PM -0800, Erik Jensen wrote:
> > > Out of curiosity, would it be at all feasible to use 64-bits for the page
> > > offset *without* changing XArray, perhaps by indexing by the lower 32-bits,
> > > and evicting the page that's there if the top bits don't match (vaguely like
> > > how the CPU cache works)? Or, if there are cases where a page can't be
> > > evicted (I don't know if this can ever happen), use chaining?
> > >
> > > I would expect index contention to be extremely uncommon, and it could only
> > > happen for inodes larger than 16 TiB, which can't be used at all today. I
> > > don't know how many data structures store page offsets today, but it seems
> > > like this should significantly reduce the performance impact versus upping
> > > XArray to 64-bit indexes.
> >
> > Again, you're asking for significant development work for a dying
> > platform.
> 
> Depending on how complex it would be, I'm not unwilling to give it a
> go myself, but I admittedly have no kernel development experience or
> knowledge of how locking works around the page cache. E.g., I have no
> idea if evicting the old page at an index before bringing in a new one
> is even possible without causing deadlocks right and left.

I wouldn't recommend the page cache as the ideal place to start learning
how to hack on the kernel.  Not only is it complex, it affects almost
everything.

What might work is using "auxiliary" inodes for btrfs's special purpose.
Allocate an array of inodes and use inodes[index / (ULONG_MAX + 1)]
and look up the page at index % (ULONG_MAX + 1).
