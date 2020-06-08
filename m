Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943541F133C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 09:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgFHHJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgFHHJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:09:53 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AD3C08C5C3;
        Mon,  8 Jun 2020 00:09:52 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a13so15740078ilh.3;
        Mon, 08 Jun 2020 00:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nf9dHqg6+XQwKpI8ou9xSgbseHLRO6vjwPKJ056sGMw=;
        b=VS2lrjRYg1vBSVU3Lym8CjazMJrZEuwL3D8SPYJNftC0tECW7uS4NmwyHmJjskGcme
         W2iSbSaI5Icy9RRBVFAbtvAguBG3LSJTWQsMZw9DSilcCgjumwYXEtMi3rfm4GvfAJ7l
         Lg9kfOqGlbDMqBJHUxWLiKIerNSfmHjQe5NQ9EJkXLHHGSuTE0h0CC77RNEjHhJO3qgM
         fDVv6mEYZfvlV13g0f/c+sBMPAjdJ5Jo7z8LMo1OxFNzabbd4Zr0geiR9y40ryRQ+cw5
         Ks+tsPaRQopanhM5Zkg0dRy19oR+fuM4WyFlniLnQ39Dh0nbDZjfvnTxXSLbqGOh9QfB
         JUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nf9dHqg6+XQwKpI8ou9xSgbseHLRO6vjwPKJ056sGMw=;
        b=Dn4dfcgRap3NqOrRVvBZb9SNWhSGckFy+KyaUR96VIJS5b6eTgDuMKmFlNyMZZQJlz
         Xk1MhAKMuCoM9nvgukhGtvLAco4XDvETNd8gBabP+6NDZl6MriRUAGbeVu4xCDcnV3Hn
         r5i5avVijhwBkCHwDWeQ+2E+EB8BUWVqGpN78bULXS0bugEtPg/QCk0vtxjzBzsFsZVN
         GnnOju32StYFdrwjhL5cSMdVgmZ2WoHWXC2hR8SLfK9HQin3M89wravZZo7ZZVyYi1S2
         sqYv9jd0nHy3ZYhX4FR0RsWjvU/14OW/GUtEs0cpkhag6WcLn1ltGz0NxKr9oWXg5qbV
         R4ZA==
X-Gm-Message-State: AOAM532MTow0BVXE86PrsMmIeWEqHdoyd14QQUM6ztsbZMh34iNhp4wu
        18nQLOKgHVu7iEuVHBGNbvbK1gGT5n6uPSIk4lg=
X-Google-Smtp-Source: ABdhPJwi5Bw+CdttQXg1msL1Y4l1HLgGn2IsguTqKPOLJfTGo37VbE9laPCTQYH5xzzCfqY1Cfwy242nwDJ549M6nDU=
X-Received: by 2002:a92:7311:: with SMTP id o17mr21691800ilc.176.1591600192183;
 Mon, 08 Jun 2020 00:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200608020557.31668-1-yanaijie@huawei.com> <20200608061502.GB17366@lst.de>
 <CA+icZUUks4oJGJLhiRLTJTzyNxfsT_TZQ12MMvBVLXSaR8t0zA@mail.gmail.com> <CA+icZUXg2H7a4BVLpPXiw2D5Xzpy=Nxj8OJyw96giDvjNuBt+w@mail.gmail.com>
In-Reply-To: <CA+icZUXg2H7a4BVLpPXiw2D5Xzpy=Nxj8OJyw96giDvjNuBt+w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Jun 2020 09:09:40 +0200
Message-ID: <CA+icZUWYJ70W9E=Y-Cx92Ywd=pVgj9RAf2KsdapiVsXQwLDAnw@mail.gmail.com>
Subject: Re: [PATCH v4] block: Fix use-after-free in blkdev_get()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Yan <yanaijie@huawei.com>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Hulk Robot <hulkci@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 8, 2020 at 8:52 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Jun 8, 2020 at 8:47 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Mon, Jun 8, 2020 at 8:18 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Looks good,
> > >
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > >
> > > Can you dig into the history for a proper fixes tag?
> >
> > [ CC Dan ]
> >
> > Dan gave the hint for the Fixes: tag in reply to the first patch:
> >
> > > The Fixes tag is a good idea though:
> > >
> > > Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_SET_FD")
> >
> > > It broke last July.  Before that, we used to check if __blkdev_get()
> > > failed before dereferencing "bdev".
> >
>
> Here is the Link.
>
> https://www.spinics.net/lists/linux-block/msg54825.html
>

Really CC Dan in 3rd attempt.

OMG, I need a coffee - urgently.

- Sedat -
