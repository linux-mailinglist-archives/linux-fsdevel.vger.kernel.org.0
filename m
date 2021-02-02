Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4099D30B5DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 04:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhBBDdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 22:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBBDdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:33:50 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26019C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 19:33:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id j25so21362780oii.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 19:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/CFl6gelu2Jn1XfP1Pk3Io/iXu94EXjdcr7KKjYEt8=;
        b=n/uhnbMyew5WF4Ev5z/fz/DOVUe8c4QpIOhdCVY/nXXtP9E+FU2sC+mZPpouYvEE+g
         tErXMDQ2QB7/ORkhAoXGSZT5JKZvM5MR13duKdbBG157s/cxkGo1YM+P50O482XvsG7H
         vkSQ9eyb/VIcM7FokrEVVD2TOGUR+/rn3mB66O2MF1N9KvNI0wglOfQ0qIyxywQcNDXr
         LgdF2u4GKOyrCEPrJLpGs81+EE44oX4ZzbZ6tsRpUY9Qk6VUMRTfmnT84vpz4hDnPRiu
         /g7pMse6mFwjBMMQLUVZRk3yX3kkQDWSXR72Eh6kG+7XE0p/ztKuY9jEV8jnOKGXu5sM
         r0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/CFl6gelu2Jn1XfP1Pk3Io/iXu94EXjdcr7KKjYEt8=;
        b=KQ9No4DViRohIlOzZxYVfyQKxGkOk+TwMW3w/jzOQJ75SNLAT+5LGHQKkmnxvZKZIa
         w4U9wwp3GXGqflrERuSrjVTRUa+IOfGg1b9DFlI4WaILK3Q7PyQg6nqalB54/H+F+KPV
         SNTcmXVwxLFu4R8c1y0x0HoG3rkA5Oy/GUN5SR6kEYhbTM300TcfdM0WvyqrweExGEkt
         enS84XnryzGfIT8y+v/dJXaWmma+vm+NGTG3u10PGO4ZJLydwhiU8/Gg7MsPT2iQXPpq
         ZnunnQC5I2FklB0udKJrN0ZLTcIPUWDUOrWZj2BPlXCMl4rhJuSppCxvV1OEOGo8yqSv
         4hFg==
X-Gm-Message-State: AOAM5303VCWVd4bV2IfL4lDoFzJVcyl/JPGCqrNRzX2Rn5z0eLQ0dVvv
        +YLXQ/eVliCWZ1+CHO7c64A1JwXgPrDoa/bfCPquomQK/H3osONX
X-Google-Smtp-Source: ABdhPJzmYcO1RPAnl/Pt2uN/WYRyI5Ny6oWWEaCL/8kwM3t8PevB6sEoJv0AOoc4Ape96NGS/ZWDMJb80eUTsAw2Rjk=
X-Received: by 2002:a05:6808:158:: with SMTP id h24mr1383059oie.135.1612236789573;
 Mon, 01 Feb 2021 19:33:09 -0800 (PST)
MIME-Version: 1.0
References: <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org>
In-Reply-To: <20210201130800.GP308988@casper.infradead.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 1 Feb 2021 22:32:58 -0500
Message-ID: <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
Subject: Re: [RFC PATCH] implement orangefs_readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> This is not the way to do it. You need to actually kick
>> off readahead in this routine so that you get pipelining
>> (ie the app is working on pages 0-15 at the same time
>> the server is getting you pages 16-31).

Orangefs isn't very good at reading or writing a few
pages at a time. Its optimal block size is four megabytes.
I'm trying to do IOs big enough to make Orangefs
start flowing like it needs to and then have pages
on hand to fill with the data. Perhaps I can figure
how to use Dave Howell's code to control the
readahead window and make adjustments to
how many pages Orangefs reads per IO and
end up with something that is closer to how
readahead is intended to be used.

This patch is a big performance improvement over
the code that's upstream even though I'm
not using readahead as intended.

>> I don't see much support in orangefs for doing async
>> operations; everything seems to be modelled on
>> "submit an I/O and wait for it to complete".

Yep... when we were polishing up the kernel module to
attempt to go upstream, the code in there for async was
left behind... I might be able to make sense of it now,
Ida know... You've helped me to see this place where
it is needed.

>> adding async
>> support to orangefs is a little bigger task than I'm willing to put
>> significant effort into right now.

The effort and help that you're providing is much
appreciated and just what I need, thanks!

-Mike

On Mon, Feb 1, 2021 at 8:08 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jan 31, 2021 at 05:25:02PM -0500, Mike Marshall wrote:
> > I wish I knew how to specify _nr_pages in the readahead_control
> > structure so that all the extra pages I need could be obtained
> > in readahead_page instead of part there and the rest in my
> > open-coded stuff in orangefs_readpage. But it looks to me as
> > if values in the readahead_control structure are set heuristically
> > outside of my control over in ondemand_readahead?
>
> That's right (for now).  I pointed you at some code from Dave Howells
> that will allow orangefs to enlarge the readahead window beyond that
> determined by the core code's algorithms.
>
> > [root@vm3 linux]# git diff master..readahead
> > diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> > index 48f0547d4850..682a968cb82a 100644
> > --- a/fs/orangefs/inode.c
> > +++ b/fs/orangefs/inode.c
> > @@ -244,6 +244,25 @@ static int orangefs_writepages(struct
> > address_space *mapping,
> >
> >  static int orangefs_launder_page(struct page *);
> >
> > +/*
> > + * Prefill the page cache with some pages that we're probably
> > + * about to need...
> > + */
> > +static void orangefs_readahead(struct readahead_control *rac)
> > +{
> > +       pgoff_t index = readahead_index(rac);
> > +       struct page *page;
> > +
> > +       while ((page = readahead_page(rac))) {
> > +               prefetchw(&page->flags);
> > +               put_page(page);
> > +               unlock_page(page);
> > +               index++;
> > +       }
> > +
> > +       return;
> > +}
>
> This is not the way to do it.  You need to actually kick off readahead in
> this routine so that you get pipelining (ie the app is working on pages
> 0-15 at the same time the server is getting you pages 16-31).  I don't
> see much support in orangefs for doing async operations; everything
> seems to be modelled on "submit an I/O and wait for it to complete".
>
> I'm happy to help out with pagecache interactions, but adding async
> support to orangefs is a little bigger task than I'm willing to put
> significant effort into right now.
