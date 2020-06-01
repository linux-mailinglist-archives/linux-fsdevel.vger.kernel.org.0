Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D81EA27E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 13:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgFALOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 07:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFALOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:14:05 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF3C03E96F
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 04:14:05 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id v25so91577uau.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2020 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXOAaMoBz4R8U5dwNZ1YfVLsYcbZLZ+dVXxKsEXRwXY=;
        b=ldYjGDwxIV0HzE2xVPpuBE0NOAVS/wx8H146GJymaAusL8tM4TbALmC5vckRW1Mz2h
         iYHXRI042v6RPOvV2TxuBXm7yKSuQ7eAGi19pRqoDsXPm3eaQdEDp4agW/pkDWzJvswX
         lHKPP/PrvdEZKioAgAXdN3Cj9R582GOgxZERyU0rXTDPVUz+dF01KRgtgKNI01FFXGls
         E+Qd4105igPjLgGxPH/nSEIxB87EZD8JPlhCjxUjxqOxlAp/6OMwg9lcHLUtH6ThPs3f
         BQyv/5nbSVdTe2MuD3wqDiKM6D164XduVY61OUE0kRFs1W0aTXn5NNNVEWXzqkBI1Y7y
         8nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXOAaMoBz4R8U5dwNZ1YfVLsYcbZLZ+dVXxKsEXRwXY=;
        b=hnONl66capWaEZZ48zkrU22zSRPwpM+KGd93n+MnppRXlovW8whlwx20Ot1DrYvoME
         G6OOyvueHOcYMnie1iwLf2vSmNbIKIKggcMFur5WiicErMMqmAUCPTb2Tmbjd9cLOj8i
         Sl8bcMLFJphMz+HuHYqv5O+YzkvehXyympT38TQXnaGiIh2Nxh1bVpql/6YPEj0/vP3r
         eSm+aIAZmPlDW+nJA8lkTiwHStgnPzggyVC0GRWaVXdGnkhInEnQMz/220lHp+oz9n1H
         31msETMCEkjxWn9dBoh2LuE5XCAIYp7u5jDcsYRXGjAmvzisKTuU/GIjzmF9M6AtciN+
         tbdg==
X-Gm-Message-State: AOAM533aHBO+ZRGdJz69qz0JETQH14masxNY7SlF+B6wxnkOdSPuCv/h
        F+v4yjpR24tT4QuuXUwvhYbgfS7FWeyvr0Vd0GOJUw==
X-Google-Smtp-Source: ABdhPJz8Ar6V60hnAAObpp+yduGb260FWlbMjEdQ4KdG8I/hXKgn7dO8wizKMxc1REqOfKGvnrW5O/i0ftzKsyinRv0=
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr9356732uan.19.1591010044429;
 Mon, 01 Jun 2020 04:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200523035909.418683-1-jhubbard@nvidia.com> <89244e74-f619-e515-083a-3bf2586fa5c3@nvidia.com>
In-Reply-To: <89244e74-f619-e515-083a-3bf2586fa5c3@nvidia.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Mon, 1 Jun 2020 07:13:53 -0400
Message-ID: <CAOg9mSQYvPcjCOoTj5_zq-62pxe_XCnqxiaiNLefx10M-MSYuw@mail.gmail.com>
Subject: Re: [PATCH v2] orangefs: convert get_user_pages() --> pin_user_pages()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi John.

Thanks for the patch, and the testing, and the reference to the
lwn article.

I have also applied your patch to 5.7-rc7 and have run xfstests.

I applied your patch to the orangefs for-next tree.

-Mike

On Sat, May 30, 2020 at 3:39 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-22 20:59, John Hubbard wrote:
> > This code was using get_user_pages*(), in a "Case 1" scenario
> > (Direct IO), using the categorization from [1]. That means that it's
> > time to convert the get_user_pages*() + put_page() calls to
> > pin_user_pages*() + unpin_user_pages() calls.
> >
> > There is some helpful background in [2]: basically, this is a small
> > part of fixing a long-standing disconnect between pinning pages, and
> > file systems' use of those pages.
> >
> > [1] Documentation/core-api/pin_user_pages.rst
> >
> > [2] "Explicit pinning of user-space pages":
> >      https://lwn.net/Articles/807108/
> >
> > Cc: Mike Marshall <hubcap@omnibond.com>
> > Cc: Martin Brandenburg <martin@omnibond.com>
> > Cc: devel@lists.orangefs.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >
> > Hi,
> >
> > Note that I have only compile-tested this patch, although that does
> > also include cross-compiling for a few other arches.
>
> An update on the run-time testing: Just now, I got basic orangefs tests
> running in xfstests, with this patch applied, and it all looks normal.
>
> thanks,
> --
> John Hubbard
> NVIDIA
>
> >
> > Changes since v1 [3]: correct the commit description, so that
> > it refers to "Case 1" instead of "Case 2".
> >
> >
> > [3] https://lore.kernel.org/r/20200518060139.2828423-1-jhubbard@nvidia.com
> >
> > thanks,
> > John Hubbard
> > NVIDIA
> >
> >   fs/orangefs/orangefs-bufmap.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
> > index 2bb916d68576..538e839590ef 100644
> > --- a/fs/orangefs/orangefs-bufmap.c
> > +++ b/fs/orangefs/orangefs-bufmap.c
> > @@ -168,10 +168,7 @@ static DEFINE_SPINLOCK(orangefs_bufmap_lock);
> >   static void
> >   orangefs_bufmap_unmap(struct orangefs_bufmap *bufmap)
> >   {
> > -     int i;
> > -
> > -     for (i = 0; i < bufmap->page_count; i++)
> > -             put_page(bufmap->page_array[i]);
> > +     unpin_user_pages(bufmap->page_array, bufmap->page_count);
> >   }
> >
> >   static void
> > @@ -268,7 +265,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
> >       int offset = 0, ret, i;
> >
> >       /* map the pages */
> > -     ret = get_user_pages_fast((unsigned long)user_desc->ptr,
> > +     ret = pin_user_pages_fast((unsigned long)user_desc->ptr,
> >                            bufmap->page_count, FOLL_WRITE, bufmap->page_array);
> >
> >       if (ret < 0)
> > @@ -280,7 +277,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
> >
> >               for (i = 0; i < ret; i++) {
> >                       SetPageError(bufmap->page_array[i]);
> > -                     put_page(bufmap->page_array[i]);
> > +                     unpin_user_page(bufmap->page_array[i]);
> >               }
> >               return -ENOMEM;
> >       }
> >
>
