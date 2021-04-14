Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23035F4B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351264AbhDNNUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhDNNUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:20:39 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E1C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Apr 2021 06:20:16 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id i2so4367437vka.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Apr 2021 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IX7qcrEu6HFQSyp3w8KMyWeid0wzPn8mCOmpMPv5Pjs=;
        b=ntdQ5YG1Gr5915B2/+DC5gbp2HzxCQkyXazZ+/W0Lfn/znpyilVyJvxBJO2wGCOJLD
         s1hxzdX+wZfmByqC1JppV6mb2abxvk8BFw96p6Gph1yfoBtZCDFnbdJq5UlcIY9IkBc5
         bNOZwXfKXnisVQ0i5xV4CqTO1g3rgnF0Oet0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IX7qcrEu6HFQSyp3w8KMyWeid0wzPn8mCOmpMPv5Pjs=;
        b=ppB4l8dBaq7/VR5EI1iIi6ZVw3ydJRaDHqWw+POjkuq/+YpwUdPTrfCqI5RPmu7AnC
         MhHFDKIeVYeQUSLYRe7RnIx2DP6bfHoXyEvvbf/lIRN3RqMTk6FB/ECFkKB3PtLyd1Bz
         IYLhNXgiatWxK9wYNRhVGDY2qFYR4euEbouqhrQJlE2+1UhNllhc/OVlZYb12HElpChO
         7UGXFbgWd08O4zSPrEh7hPaKlqFoyJLWTXhpyYLs+Vgu1gvQM+RmjdoeluzYW+U534K8
         UcJHI9eOBqTm3wyRMunVU0VtIfGRoOYNsyT2zwWw8BAjJHsZWplDPT+6J7ih2HrdAyP4
         GhRA==
X-Gm-Message-State: AOAM533MP3PvpT3hPYpZEtHIm+aZQngQf/1Uv8xm+Z7u83ydDF32guhX
        bXGSYanp/lqjQd0L5jLUdzrqbcYqXge64YKdNnJ8og==
X-Google-Smtp-Source: ABdhPJy90G4eb02i87Z4ecltuTLzpFoMFuaOOkxblpV3zDET8ldycNjqEruoINsaIBmJaCBGEE/YHFjkiFdwojQ+lbk=
X-Received: by 2002:a1f:99cc:: with SMTP id b195mr5541459vke.19.1618406415804;
 Wed, 14 Apr 2021 06:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
 <f72f28cd-06b5-fb84-c7ce-ad1a3d14c016@linux.alibaba.com> <CAJfpegtJ6100CS34+MSi8Rn_NMRGHw5vxbs+fOHBBj8GZLEexw@mail.gmail.com>
 <CA+a=Yy4Ea6Vn7md2KxGc_Tkxx04Ck-JCBL7qz-JWecJ9W2nT_g@mail.gmail.com>
In-Reply-To: <CA+a=Yy4Ea6Vn7md2KxGc_Tkxx04Ck-JCBL7qz-JWecJ9W2nT_g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 14 Apr 2021 15:20:04 +0200
Message-ID: <CAJfpegtXJ=waad2SNtru90Nn6f4yOkRD5Pot9K-13z249PjFgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: Fix possible deadlock when writing back
 dirty pages
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 2:22 PM Peng Tao <bergwolf@gmail.com> wrote:
>

> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1117,17 +1117,12 @@ static ssize_t fuse_send_write_pages(str
> >       count = ia->write.out.size;
> >       for (i = 0; i < ap->num_pages; i++) {
> >               struct page *page = ap->pages[i];
> > +             bool page_locked = ap->page_locked && (i == ap->num_pages - 1);
> Any reason for just handling the last locked page in the page array?
> To be specific, it look like the first page in the array can also be
> partial dirty and locked?

In that case the first partial page will be locked, and it'll break
out of the loop...

> >
> > -             if (!err && !offset && count >= PAGE_SIZE)
> > -                     SetPageUptodate(page);
> > -
> > -             if (count > PAGE_SIZE - offset)
> > -                     count -= PAGE_SIZE - offset;
> > -             else
> > -                     count = 0;
> > -             offset = 0;
> > -
> > -             unlock_page(page);
> > +             if (err)
> > +                     ClearPageUptodate(page);
> > +             if (page_locked)
> > +                     unlock_page(page);
> >               put_page(page);
> >       }
> >
> > @@ -1191,6 +1186,16 @@ static ssize_t fuse_fill_write_pages(str
> >               if (offset == PAGE_SIZE)
> >                       offset = 0;
> >
> > +             /* If we copied full page, mark it uptodate */
> > +             if (tmp == PAGE_SIZE)
> > +                     SetPageUptodate(page);
> > +
> > +             if (PageUptodate(page)) {
> > +                     unlock_page(page);
> > +             } else {
> > +                     ap->page_locked = true;
> > +                     break;

... here, and send it as a separate WRITE request.

So the multi-page case with a partial & non-uptodate head page will
always result in the write request being split into two (even if
there's no partial tail page).

Thanks,
Miklos
