Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5954834B426
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 04:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhC0DvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 23:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhC0Duu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:50:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00819C0613AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Mar 2021 20:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0joRd3BVHG74/NUidLyeyPjblLNXF+awivZrAmng9Eg=; b=N0rYlfgqvBSYYpM1D2PFs/pc6v
        kMLEo5+ZYtZogA8zJJTJw8kKWpRYHMI7rBoUmhZIGlsMZguIVMxKLrvLqG8/if6xKcEX0hJGgRfWz
        YSLzii+gOhbF/jpccaSF1CG6h5W2k6O3pFC7w4Ygd2Ngqsh1OsnK2/qY8FEHdqLZgg5m35knv1vC0
        /QEoBL61W9w3SJytsIBQl7J2Y+XBTDJgTnDjUKcJ6OMhOAs6DBsJkH1tK3toywYo2tmElWVcOPTk2
        l4h/yZCRchx6iWoNW5n1Nw+UJfTiZmvnTh2jZ+mqAa+3jXt3cFRAHUIFjmFhUMOKZOCNtTbdpozdB
        N0NC8xCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lPzxr-00FtZv-VB; Sat, 27 Mar 2021 03:50:31 +0000
Date:   Sat, 27 Mar 2021 03:50:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
Message-ID: <20210327035019.GG1719932@casper.infradead.org>
References: <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org>
 <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk>
 <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:55:44PM -0400, Mike Marshall wrote:
> Hi David.
> 
> I implemented a version with iov_iter_xarray (below).
> It appears to be doing "the right thing" when it
> gets called, but then I get a backtrace in the kernel
> ring buffer "RIP: 0010:read_pages+0x1a1/0x2c0" which is
> page dumped because: VM_BUG_ON_PAGE(!PageLocked(page))
> ------------[ cut here ]------------
> kernel BUG at include/linux/pagemap.h:892!
> 
> So it seems that in mm/readahead.c/read_pages I end up
> entering the "Clean up the remaining pages" part, and
> never make it through even one iteration... it happens
> whether I use readahead_expand or not.
> 
> I've been looking at it a long time :-), I'll look more
> tomorrow... do you see anything obvious?

Yes; Dave's sample code doesn't consume the pages from the readahead
iterator, so the core code thinks you didn't consume them and unlocks
/ puts the pages for you.  That goes wrong, because you did actually
consume them.  Glad I added the assertions now!

We should probably add something like:

static inline void readahead_consume(struct readahead_control *ractl,
		unsigned int nr)
{
	ractl->_nr_pages -= nr;
	ractl->_index += nr;
}

to indicate that you consumed the pages other than by calling
readahead_page() or readahead_page_batch().  Or maybe Dave can
wrap iov_iter_xarray() in a readahead_iter() macro or something
that takes care of adjusting index & nr_pages for you.
