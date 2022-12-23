Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C731C65549D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 21:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiLWUyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 15:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLWUys (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:54:48 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540171E704;
        Fri, 23 Dec 2022 12:54:47 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id pa22so2846730qkn.9;
        Fri, 23 Dec 2022 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=elNIdyx1h5Jg1j16dMpw5pELc93eL/yPHRGnY+J1k3M=;
        b=Mu9fwkAZaBnG157i+jPVM7QQV4CwMJkVWJevFwoMaNkjhysTIbDdFehX2pnVUhs6CF
         CTJXFOH1GYyq2L0fZNtNBDFYFwHpZxL7g9y0yX2NJ6ACOQXUVDAdRJwTf4sAAbqiNm4P
         QvujdyY2U65429MrNuUXCarJf3q8bg0qWia0+qJ7T5micejhx1Tksr0lqFHW2yqgwg4K
         MgbZlrOqzORrTEZBFsgXHL/00K8pVK8P8O0TPRTG7m4d0K5qe0Yzf2fvy6cflK5I8sI2
         mYQUqD4QdjJ8l99Osw6LzYu5dYWsmAeWM6blRtd8yie8MP4Yai1pvnYRVb/m3CC/hLM9
         Lvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elNIdyx1h5Jg1j16dMpw5pELc93eL/yPHRGnY+J1k3M=;
        b=7ojB24YcHyOe/5IjuzNF3q5CC0ukkzYsGHN/h78FKwkwpIcDh/D/Ei0buJCMFD/SHf
         HVkdxXbvTpCVF3Ny4KXIjgrmw0bDl6V+dcE3iKeg/jYtWdCOv6aOODPLhOWYFyfSatiW
         OsUIW92tzasFE26o+t6lXwcwPQRIpDAA7LYEiTpU3pSI+P1xy+rTjsUTBPP6yHsW9DmI
         81IaZtkKCyg8HLm/sost4ewiHyVczS7IrO1RtzCs7qadDr8xT/0DHeEkwaZhOtetPB9q
         hKWTWW9cFtLBCOjyLCu8fpa9jKGdTQ9ZAj5b/hKkhcSYcMkAQSpHilQok4IsyOXFALTv
         p93Q==
X-Gm-Message-State: AFqh2koL7oI4q1rFfDPFhPZIMfnjQgnyObTFbN9b9RyNkP1+lM7HCvFy
        S+vFfpK+lqOs7W2lMtQ/G0r4k0Dai4f9GUhJUv1Zl5yR5ko=
X-Google-Smtp-Source: AMrXdXtXXrJvPZjl+kD+zsNOKG6ZjJVact6gML4iYFi1bbi/Xhv9RiWizo11/tOBp9Mw346MQ1ZFHK3wAwV+DdSSVvE=
X-Received: by 2002:a37:b04:0:b0:6ff:b5c2:e181 with SMTP id
 4-20020a370b04000000b006ffb5c2e181mr434881qkl.236.1671828886302; Fri, 23 Dec
 2022 12:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20221216150626.670312-1-agruenba@redhat.com> <20221216150626.670312-3-agruenba@redhat.com>
 <Y6XDAG25Qumt/iyM@infradead.org>
In-Reply-To: <Y6XDAG25Qumt/iyM@infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 23 Dec 2022 21:54:34 +0100
Message-ID: <CAHpGcMJAnyn_7hHvsPL5GAiwbJs_DX04+Tt0P+6jfi_kb7jGUg@mail.gmail.com>
Subject: Re: [RFC v3 2/7] iomap: Add iomap_folio_done helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Fr., 23. Dez. 2022 um 16:12 Uhr schrieb Christoph Hellwig
<hch@infradead.org>:
> On Fri, Dec 16, 2022 at 04:06:21PM +0100, Andreas Gruenbacher wrote:
> > +static void iomap_folio_done(struct iomap_iter *iter, loff_t pos, size_t ret,
> > +             struct folio *folio)
> > +{
> > +     const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
> > +
> > +     if (folio)
> > +             folio_unlock(folio);
> > +     if (page_ops && page_ops->page_done)
> > +             page_ops->page_done(iter->inode, pos, ret, &folio->page);
> > +     if (folio)
> > +             folio_put(folio);
> > +}
>
> How is the folio dereference going to work if folio is NULL?

'&folio->page' is effectively a type cast, not a dereference. I
realize iomap_folio_done() as introduced here is not pretty, but it's
only an intermediary step and the ugliness goes away later in this
series.

> That being said, I really wonder if the current API is the right way to
> go.  Can't we just have a ->get_folio method with the same signature as
> __filemap_get_folio, and then do the __filemap_get_folio from the file
> system and avoid the page/folio == NULL clean path entirely?  Then on
> the done side move the unlock and put into the done method as well.

Yes, this is what happens later in this series (as you've seen by now).

> >       if (!folio) {
> >               status = (iter->flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOMEM;
> > -             goto out_no_page;
> > +             iomap_folio_done(iter, pos, 0, NULL);
> > +             return status;
> >       }
> >
> >       /*
> > @@ -656,13 +670,9 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> >       return 0;
> >
> >  out_unlock:
> > -     folio_unlock(folio);
> > -     folio_put(folio);
> > +     iomap_folio_done(iter, pos, 0, folio);
> >       iomap_write_failed(iter->inode, pos, len);
> >
> > -out_no_page:
> > -     if (page_ops && page_ops->page_done)
> > -             page_ops->page_done(iter->inode, pos, 0, NULL);
> >       return status;
>
> But for the current version I don't really understand why the error
> unwinding changes here.

Currently, we have this order of operations in iomap_write_begin():

  folio_unlock() // folio_put() // iomap_write_failed() // ->page_done()

and this order in iomap_write_end():

  folio_unlock() // ->page_done() // folio_put() // iomap_write_failed()

The unwinding in iomap_write_begin() works because this is the trivial
case in which nothing happens to the page. We might just as well use
the same order of operations there as in iomap_write_end() though, and
when you switch to that, this is what you get.

Thank you for the review.

Andreas
