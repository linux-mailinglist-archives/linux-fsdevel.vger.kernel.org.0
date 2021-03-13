Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5DE339EF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 16:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhCMPci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 10:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhCMPcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 10:32:09 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5F3C061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Mar 2021 07:32:08 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l11so1937510otq.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Mar 2021 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjxFnib4GJ7o9UIJx9idNmQjKFRv3fxgW/EoBUe4vRU=;
        b=c40f8ylotMqI32p9HmmjfEryFFjv17CDqDET2B50Mt0KQe+GIftQJYwlA5cnghuPAF
         DKG8P/eKVy84y7ve5S9Y+8bxzeiurvpVOjZmWb2gYwfZ+Rp77St5XomIU3xm1rMbFFiJ
         J8HqDGdkigKmmYzHzBPPW79OavyzthmcmDhF9n8skVxSI2sl4gvaogUzISI1y9DT4zYp
         LgAsuaSDl4nsIPgg5Fi7optzGCEUNWFYkNKjy8QzeyRSoONyJ/KRexi4CZBcNi9HF6pX
         1QB16xhepuuCSpCqV14onp1GqVZHIpdPw+jLx6QgJFqVwgxUVM9/FZa+QuYxTssFo1ZZ
         QCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjxFnib4GJ7o9UIJx9idNmQjKFRv3fxgW/EoBUe4vRU=;
        b=NDOg81lg4oFDQXrG7nSqQRJ7Zy6z9KMS+35YFoX3SlBXXDrvkgroWjoM5zBrCmx11J
         iQN7u2C5bj5SVpfdhqfynvCkvCQrPKhTGVBVbZuUTYVemmOPoVkhVwKHM59ncytNc6ow
         8aU1QEiKycrGUKFGZIcfj/ZecQlO7cYboAL2+adDFYZ41OdTGfn34AhUcURYb8wDdDPU
         6ok0b15H4qJeK9/NU+mXqOyzfceZj0b1QeBJVWp3Mr+JPn9pGOaPukGo6h/jgXVVYAjI
         gFvEyxEs71bZjkwaBpRigs87itmWomTrykGBP4cLWnuZlozRao9wHQTr3KubPPRyjUaZ
         Tz8Q==
X-Gm-Message-State: AOAM532hZdsVoeTf+drF2ifZYjcqAt8jHX5PZUCvD8QkWIaocpA5XcyU
        eOOMG0ibPzcD/ZdaKcY+QR6ECjMnq34H/cmu53O6XlCDlZKLYA==
X-Google-Smtp-Source: ABdhPJyTgmk3acVaQkO3OOwAyrqRG6hYn1Fvn/+qEnmzAvySgZ1oTg07r/qEVpn+QIntaydZkKwotiljcLojH27VCSo=
X-Received: by 2002:a9d:bc9:: with SMTP id 67mr7730323oth.352.1615649526914;
 Sat, 13 Mar 2021 07:32:06 -0800 (PST)
MIME-Version: 1.0
References: <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
In-Reply-To: <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sat, 13 Mar 2021 10:31:55 -0500
Message-ID: <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings everyone.

I have made another version of orangefs_readahead, without any
of my hand rolled page cache manipulations. I read a bunch of
the source in other filesystems and mm and fs and pagemap.h to
try and get an idea of how to implement readahead so that my
implementation is "with the program".

I have described the flawed code I have upstream now in an
earlier message. My flawed code has no readahead implementation, but
it is much faster than with this readahead implementation.

If this readahead implementation is "the right idea", I can
use it as a framework to implement an async orangefs read function
and start the read at the beginning of my readahead function
and collect the results at the end after the readahead pages
have been marshaled. Also, once some mechanism like David Howells'
code to control the readahead window goes upstream, I should be
able take big enough gulps of readahead to make Orangefs do right.
The heuristically chosen 64 page max that I can get now isn't enough.

I hope some of y'all have the time to review this implementation of
readahead...

Thanks!

-Mike

static void orangefs_readahead(struct readahead_control *rac)
{
struct page **pages;
unsigned int npages = readahead_count(rac);
loff_t offset = readahead_pos(rac);
struct bio_vec *bvs;
int i;
struct iov_iter iter;
struct file *file = rac->file;
struct inode *inode = file->f_mapping->host;
int ret;

/* allocate an array of page pointers. */
pages = kzalloc(npages * (sizeof(struct page *)), GFP_KERNEL);

/* Get a batch of pages to read. */
npages = __readahead_batch(rac, pages, npages);

/* allocate an array of bio_vecs. */
bvs = kzalloc(npages * (sizeof(struct bio_vec)), GFP_KERNEL);

/* hook the bio_vecs to the pages. */
for (i = 0; i < npages; i++) {
bvs[i].bv_page = pages[i];
bvs[i].bv_len = PAGE_SIZE;
bvs[i].bv_offset = 0;
}

iov_iter_bvec(&iter, READ, bvs, npages, npages * PAGE_SIZE);

/* read in the pages. */
ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &offset, &iter,
npages * PAGE_SIZE, inode->i_size, NULL, NULL, file);

/* clean up. */
for (i = 0; i < npages; i++) {
SetPageUptodate(bvs[i].bv_page);
unlock_page(bvs[i].bv_page);
put_page(bvs[i].bv_page);
}
kfree(pages);
kfree(bvs);
}

On Mon, Feb 1, 2021 at 10:32 PM Mike Marshall <hubcap@omnibond.com> wrote:
>
> >> This is not the way to do it. You need to actually kick
> >> off readahead in this routine so that you get pipelining
> >> (ie the app is working on pages 0-15 at the same time
> >> the server is getting you pages 16-31).
>
> Orangefs isn't very good at reading or writing a few
> pages at a time. Its optimal block size is four megabytes.
> I'm trying to do IOs big enough to make Orangefs
> start flowing like it needs to and then have pages
> on hand to fill with the data. Perhaps I can figure
> how to use Dave Howell's code to control the
> readahead window and make adjustments to
> how many pages Orangefs reads per IO and
> end up with something that is closer to how
> readahead is intended to be used.
>
> This patch is a big performance improvement over
> the code that's upstream even though I'm
> not using readahead as intended.
>
> >> I don't see much support in orangefs for doing async
> >> operations; everything seems to be modelled on
> >> "submit an I/O and wait for it to complete".
>
> Yep... when we were polishing up the kernel module to
> attempt to go upstream, the code in there for async was
> left behind... I might be able to make sense of it now,
> Ida know... You've helped me to see this place where
> it is needed.
>
> >> adding async
> >> support to orangefs is a little bigger task than I'm willing to put
> >> significant effort into right now.
>
> The effort and help that you're providing is much
> appreciated and just what I need, thanks!
>
> -Mike
>
> On Mon, Feb 1, 2021 at 8:08 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Jan 31, 2021 at 05:25:02PM -0500, Mike Marshall wrote:
> > > I wish I knew how to specify _nr_pages in the readahead_control
> > > structure so that all the extra pages I need could be obtained
> > > in readahead_page instead of part there and the rest in my
> > > open-coded stuff in orangefs_readpage. But it looks to me as
> > > if values in the readahead_control structure are set heuristically
> > > outside of my control over in ondemand_readahead?
> >
> > That's right (for now).  I pointed you at some code from Dave Howells
> > that will allow orangefs to enlarge the readahead window beyond that
> > determined by the core code's algorithms.
> >
> > > [root@vm3 linux]# git diff master..readahead
> > > diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> > > index 48f0547d4850..682a968cb82a 100644
> > > --- a/fs/orangefs/inode.c
> > > +++ b/fs/orangefs/inode.c
> > > @@ -244,6 +244,25 @@ static int orangefs_writepages(struct
> > > address_space *mapping,
> > >
> > >  static int orangefs_launder_page(struct page *);
> > >
> > > +/*
> > > + * Prefill the page cache with some pages that we're probably
> > > + * about to need...
> > > + */
> > > +static void orangefs_readahead(struct readahead_control *rac)
> > > +{
> > > +       pgoff_t index = readahead_index(rac);
> > > +       struct page *page;
> > > +
> > > +       while ((page = readahead_page(rac))) {
> > > +               prefetchw(&page->flags);
> > > +               put_page(page);
> > > +               unlock_page(page);
> > > +               index++;
> > > +       }
> > > +
> > > +       return;
> > > +}
> >
> > This is not the way to do it.  You need to actually kick off readahead in
> > this routine so that you get pipelining (ie the app is working on pages
> > 0-15 at the same time the server is getting you pages 16-31).  I don't
> > see much support in orangefs for doing async operations; everything
> > seems to be modelled on "submit an I/O and wait for it to complete".
> >
> > I'm happy to help out with pagecache interactions, but adding async
> > support to orangefs is a little bigger task than I'm willing to put
> > significant effort into right now.
