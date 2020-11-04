Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52932A6FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 22:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbgKDVn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 16:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgKDVnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:43:55 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20250C0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 13:43:55 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b2so171036ots.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 13:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwlu6tmyWDOoSnUZBS3UCLHELicofaEW86fjN/rfbDc=;
        b=ZhR0cKYHs0EegtoZ6P9s6tdwaJWJjR0YnLw0/vT0ZRgSLKVt/6eZqzjdwwc5JVF7Zf
         mtohimHM+Hm0KZszrIaHeV3Aw29kIOPCXc8UcoQXZykjI6nUu7qmmuP3yhNdX4fjQ5+Q
         flb/DyDNP26Sg1Brn0S3tsS17SoxQBbTSOFMnpOT5MTjYSnSOgkU7IeL8GvmLveVuWry
         ClsLPCiXyFRpETuUWgFNjvRPbmqgmc4kPVssXjwV/8pw1L/8pwTdyAFsbbfQkbD93Kyj
         0msh7M4yDQ3uUWFD6lcP1MJVeCm+PUzh2y73ssNnIN2Cam3T4IgoauvEkSCdCO8q1zXD
         T9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwlu6tmyWDOoSnUZBS3UCLHELicofaEW86fjN/rfbDc=;
        b=BnD+S1sCP82K65JTjeeoqkV6fhVlSxU8UZl99Bxdm5xhDrleCjpyrb0H1HcDBBy+6Z
         xe4Srl5LfAcJZSNBK483Sln2XDymJsPqXIxZ2V7AaLu+2+DJEMSB6w+S7ndi6kgFVa6Z
         AzN3BuFvE5ai0S1GIOkUj1Ic8ytTDeqma2orA5+0V7i3/0Gm1cVVsvvpjCPTRq4e3J/s
         Nw4Kl9ye4KMAH/nPMDpZ4ZrZaq8oo21AratGgSgZW6ghCU0syMhpOJEGT6YV0JDvAqyi
         0nmEKUepojCzD1nsoft8MAiHfX1dBAVwi9aT1k3FTPXXkTE360DnrkeHYFZ2RnyHv4Ft
         bMcQ==
X-Gm-Message-State: AOAM53262wIplSyFWIw6XMza/uGhyLTPiE27Q35YCiBXqqqaz22N7P5k
        8p7rgHwXKYXJjoG/yxljz9wHSqR8Urlh0J69GRU=
X-Google-Smtp-Source: ABdhPJwO4XNUUjTWFq5QC/0YcD4Vc8Y4jXOQnYN+pGVNyVXHK9HN2SMmr5Sn+QolvmFWe3LOkkvkdDHz1EfVQEQrPNY=
X-Received: by 2002:a05:6830:1644:: with SMTP id h4mr8641633otr.185.1604526234328;
 Wed, 04 Nov 2020 13:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-3-willy@infradead.org>
 <20201104213005.GB3365678@moria.home.lan>
In-Reply-To: <20201104213005.GB3365678@moria.home.lan>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 13:43:43 -0800
Message-ID: <CAE1WUT6Rjot=J-fU5ZMDSQM3VLxyRF5X0MXM_LLEs4s43WTwZA@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] mm/filemap: Remove dynamically allocated array
 from filemap_read
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 4, 2020 at 1:34 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> On Wed, Nov 04, 2020 at 08:42:03PM +0000, Matthew Wilcox (Oracle) wrote:
> > Increasing the batch size runs into diminishing returns.  It's probably
> > better to make, eg, three calls to filemap_get_pages() than it is to
> > call into kmalloc().
>
> I have to disagree. Working with PAGEVEC_SIZE pages is eventually going to be
> like working with 4k pages today, and have you actually read the slub code for
> the kmalloc fast path? It's _really_ fast, there's no atomic operations and it
> doesn't even have to disable preemption - which is why you never see it showing
> up in profiles ever since we switched to slub.

Yeah, kmalloc's fast path is extremely fast. Let's stay off
PAGEVEC_SIZE for now.

>
> It would however be better to have a standard abstraction for this rather than
> open coding it - perhaps adding it to the pagevec code. Please don't just drop
> it, though.
>
>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/filemap.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 23e3781b3aef..bb1c42d0223c 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2429,8 +2429,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
> >       struct file_ra_state *ra = &filp->f_ra;
> >       struct address_space *mapping = filp->f_mapping;
> >       struct inode *inode = mapping->host;
> > -     struct page *pages_onstack[PAGEVEC_SIZE], **pages = NULL;
> > -     unsigned int nr_pages = min_t(unsigned int, 512,
> > +     struct page *pages[PAGEVEC_SIZE];
> > +     unsigned int nr_pages = min_t(unsigned int, PAGEVEC_SIZE,
> >                       ((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
> >                       (iocb->ki_pos >> PAGE_SHIFT));
> >       int i, pg_nr, error = 0;
> > @@ -2441,14 +2441,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
> >               return 0;
> >       iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
> >
> > -     if (nr_pages > ARRAY_SIZE(pages_onstack))
> > -             pages = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
> > -
> > -     if (!pages) {
> > -             pages = pages_onstack;
> > -             nr_pages = min_t(unsigned int, nr_pages, ARRAY_SIZE(pages_onstack));
> > -     }
> > -
> >       do {
> >               cond_resched();
> >
> > @@ -2533,9 +2525,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
> >
> >       file_accessed(filp);
> >
> > -     if (pages != pages_onstack)
> > -             kfree(pages);
> > -
> >       return written ? written : error;
> >  }
> >  EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> > --
> > 2.28.0
> >

Best regards,
Amy Parker
(they/them)
