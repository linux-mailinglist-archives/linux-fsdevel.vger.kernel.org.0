Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07EC49D521
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 23:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiAZWPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 17:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiAZWPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:15:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A2C06173B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 14:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qAgwUu4hxpxSMPK5yCkrYcCBU7fyklxJk+WYMbSBWVs=; b=gdilxkDjd4f8yLlCzqcVZYRQjQ
        l9MTnpPeY9h2+mvgL6RekehpvbTneWGuHZfz/ZKd3E0bXV0pzknnJm3nlZRIk8ybjd7PVp8ic1QAF
        NKPhqY8bQqJhmE5VUa29ES70HTaFv/zP4Nv9352Q7U+In8/LpNS/xu1PCNYw/SyCCHQs6yyWstBud
        7H+MT0PkZQgvWQAFgOqSd/hFb46qJmg+56OeAyF+k8WovnAFxo1fHyJfMXIsCzRvZeBudpMS+Pth+
        eC4War4VN3MmhFF2NuiDciCk4NPNrg/sroM5cp1YBmFiCl8BlP8+49ecTli+37Xbz+QuQwmiZOvrm
        qRUP5MAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCqZA-004WIe-CR; Wed, 26 Jan 2022 22:15:00 +0000
Date:   Wed, 26 Jan 2022 22:15:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Black <daniel@mariadb.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: fcntl(fd, F_SETFL, O_DIRECT) succeeds followed by EINVAL in write
Message-ID: <YfHH5HsynuMuFJse@casper.infradead.org>
References: <CABVffEPxKp4o_-Bz=JzvEvQNSuOBaUmjcSU4wPB3gSzqmApLOw@mail.gmail.com>
 <YfC5vuwQyxoMfWLP@casper.infradead.org>
 <CABVffEPReS0d1dN2eKCry_k6K0LCGNNjGf04O3c7-h6P1Q_9zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVffEPReS0d1dN2eKCry_k6K0LCGNNjGf04O3c7-h6P1Q_9zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:03:36AM +1100, Daniel Black wrote:
> On Wed, Jan 26, 2022 at 2:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jan 26, 2022 at 09:05:48AM +1100, Daniel Black wrote:
> >
> > O_RDONLY is defined to be 0, so don't worry about it.
> 
> Thanks.
> 
> > > The kernel code in setfl seems to want to return EINVAL for
> > > filesystems without a direct_IO structure member assigned,
> > >
> > > A noop_direct_IO seems to be used frequently to just return EINVAL
> > > (like cifs_direct_io).
> >
> > Sorry for the confusion.  You've caught us mid-transition.  Eventually,
> > ->direct_IO will be deleted, but for now it signifies whether or not the
> > filesystem supports O_DIRECT, even though it's not used (except in some
> > scenarios you don't care about).
> 
> Is it going to be reasonable to expect fcntl(fd, F_SETFL, O_DIRECT) to
> return EINVAL if O_DIRECT isn't supported?

That is a reasonable expectation.  I can't guarantee that we won't have
bugs, of course ...

> > > Lastly on the list of peculiar behaviors here, is tmpfs will return
> > > EINVAL from the fcntl call however it works fine with O_DIRECT
> > > (https://bugs.mysql.com/bug.php?id=26662). MySQL (and MariaDB still
> > > has the same code) that currently ignores EINVAL, but I'm willing to
> > > make that code better.
> >
> > Out of interest, what behaviour do you _want_ from doing O_DIRECT
> > to tmpfs?  O_DIRECT is defined to bypass the page cache, but tmpfs
> > only stores data in the page cache.  So what do you intend to happen?
> 
> It occurs to me because EINVAL is returned, it's just operating in
> non-O_DIRECT mode.
> 
> It occurs to me that someone probably added this because (too much)
> MySQL/MariaDB
> testing is done on tmpfs and someone didn't want to adjust the test
> suite to handle
> failures everywhere on O_DIRECT. I don't think there was any kernel
> expectation there.
> 
> My problem it seems, I'll see what I can do to get back to using real
> filesystems more.

Heh.  I know Hugh is looking at "supporting" O_DIRECT on tmpfs, at least
for his internal testing.  Not sure what his plans are for merging
that support.
