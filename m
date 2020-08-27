Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC4253C02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 04:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgH0C7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 22:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0C7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:59:55 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E9C0612A3;
        Wed, 26 Aug 2020 19:59:54 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b16so4366805ioj.4;
        Wed, 26 Aug 2020 19:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=so9l8A4YqPXHm/BfsVqJ0qT+vESqYPxgUIFms4VihHY=;
        b=miLJ3TxdWtBzFcFP6l4h1cdrKFUYTg1bKrTjkBbUV4l8UFlzJ2Kc5ColaD4rWIwOuY
         hynwV/u/tZwKYxgA9p3Bg6kBznewcJBrlLjE5NSdkCCXDQkbiPeARRkCJZAFuq/gmvKo
         hTOs3/qaNJurMR0PrEiJRL1VPdvXDKOwC0F+bAzsadbhI8xYcF4psb5w//+8jIsxrAWt
         gW4G42HFqixREoJu1KJWi+5G8X6lNYb1os4azkyskdjHwFcBBb2IbbNtzbL/PWirorAy
         36aqr4GQYg7NNoyXrFNJK5mm5wN8wa4mC7iASxQzXkp3rh89H16JsiHZK5fVHVlNE5Bf
         oS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=so9l8A4YqPXHm/BfsVqJ0qT+vESqYPxgUIFms4VihHY=;
        b=oRxboUWvxHqpSS9Zkky3PvMTWaHtMfb/7qvP9uGzO1ggcWVU9XL12jrfrUjqzMTqSZ
         6AfUQzWB5ghlDKD65fwup9jMyoa9U0aUfgAgGBPnYDcoEIkYVYh13JOpOOtQPO2r+XGd
         El20YUphIPzoByZE2xX/Y0FYU+VMgaOort4/qPcQ2gguVrMtKUnL6LGsoki5yAxGmHUd
         QPBHqeNL0VL5grri7ok9I3fdvZv64OkHjYN07giPwyqHNqracg80g17mvMO2KgpA8v89
         +YhBajUI1g6xZaKm558K6xuMBREWHexLKVXEyqAmRQzl41RHaIn3s0UBaB945k3s4uJe
         e8HQ==
X-Gm-Message-State: AOAM533/9bPQ8wPWVpjWJUd6BO/b3NVWc3YaSHbGrvivu4371a1AKwxW
        BP3166diCmw4scyVXZ2RdBrc7JCTwjSNoU8K1R0=
X-Google-Smtp-Source: ABdhPJxdYDdW3vnfKYKnLIYpTXu6fth4mk6UmXCLurNLOw74xNiESboAi1oO51pwWDYByCnacffl88ypXCRb+NJCaoE=
X-Received: by 2002:a05:6602:26c1:: with SMTP id g1mr15642398ioo.10.1598497193630;
 Wed, 26 Aug 2020 19:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200827013444.24270-1-laoar.shao@gmail.com> <20200827013444.24270-3-laoar.shao@gmail.com>
 <20200827015853.GA14765@casper.infradead.org> <CALOAHbA3Twne1ebM+tMZQPCJkL9ghpeeMJXPRjPX=iz8X9=LJA@mail.gmail.com>
 <20200827024248.GA12131@dread.disaster.area>
In-Reply-To: <20200827024248.GA12131@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 27 Aug 2020 10:59:17 +0800
Message-ID: <CALOAHbA+hhiPeBh6LQcZ46Rni3TTWZu4Y8+vdTYcW5bBP5JHEA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] xfs: avoid transaction reservation recursion
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:42 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Aug 27, 2020 at 10:13:15AM +0800, Yafang Shao wrote:
> > On Thu, Aug 27, 2020 at 9:58 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Aug 27, 2020 at 09:34:44AM +0800, Yafang Shao wrote:
> > > > @@ -1500,9 +1500,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
> > > >
> > > >       /*
> > > >        * Given that we do not allow direct reclaim to call us, we should
> > > > -      * never be called in a recursive filesystem reclaim context.
> > > > +      * never be called while in a filesystem transaction.
> > > >        */
> > > > -     if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> > > > +     if (WARN_ON_ONCE(wbc->fstrans_recursion))
> > > >               goto redirty;
> > >
> > > Erm, Dave said:
> > >
> > > > I think we should just remove
> > > > the check completely from iomap_writepage() and move it up into
> > > > xfs_vm_writepage() and xfs_vm_writepages().
> > >
> > > ie everywhere you set this new bit, just check current->journal_info.
> >
> >
> > I can't get you. Would you pls. be more specific ?
> >
> > I move the check of current->journal into xfs_vm_writepage() and
> > xfs_vm_writepages(), and I think that is the easiest way to implement
> > it.
> >
> >        /* we abort the update if there was an IO error */
> > @@ -564,6 +565,9 @@ xfs_vm_writepage(
> >  {
> >         struct xfs_writepage_ctx wpc = { };
> >
> > +       if (xfs_trans_context_active())
> > +               wbc->fstrans_recursion = 1;    <<< set for XFS only.
> > +
> >         return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
>
> Get rid of wbc->fstrans_recursion. Just do
>
>         if (WARN_ON_ONCE(current->journal_info))
>                 .....
>
> right here in the XFS code.
>

Understood.
But we have to implement the 'redirty' as well in the XFS code, that
may make the implementation more complicated.


-- 
Thanks
Yafang
