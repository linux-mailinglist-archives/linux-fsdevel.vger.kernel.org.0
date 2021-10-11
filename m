Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6B429272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhJKOrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 10:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbhJKOr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:47:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05DEC061570
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 07:45:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so68826688edt.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDPfAzRPCJZekdkJLdiW5yA+Hq7e3NibC9rFYF30teQ=;
        b=ybBq2sppTGojXohfkwvJ/tGhP9hu5lEL0qh34QPAnDBZKh3j/ZgZ4uLGGEdO547zPi
         V6iAAyCyIwzp2wHV1Bj+joNqrZWW+QjkJKUcFO0BmtC+B+qlKDuiN8D9t1GjUtXushA6
         tN5o9WoQerg2r5CV1rD+9gVsCakKeAlVRuG1z24pbKqOfeadMZ7eRyuZKqZrpcqVyaE0
         F3UD/p7viAoFRJU0JxgrqilcC/fjTLVwyMf7+xgw1OTgsgQRzrgdLpzEKK9pPSkXbtrQ
         VYKje+Exek3pObA0KvtUbVmawNjNux+m3LZPZ088iOaMccwK+a2dxBuyNi+fJv8gJQFV
         qB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDPfAzRPCJZekdkJLdiW5yA+Hq7e3NibC9rFYF30teQ=;
        b=1hGdYNlACiptV97HNMvFIv1wLOv16EfqN4RUnnymXOGwAewdpFGV9xyqhp4xq9kxLg
         yGTNbO9bIVMEVEPpb6X4Xyh/OjwJphOrUodvg4cnOwLb/HNDN7fQRBCEg6WRhxdfku4Q
         Z7aJEh6BfmmCqecQK8AH96EZT9JwMsRRKN5RvER1LkD4rwi2W52SsCra7zOEVIDwZ/J2
         f0CX6VIBWRqEK29odJzDcA4W1syTQOKqRSXiH+1P36xyg1XCK8HjH2qlyI3F7WYTHeGq
         upvAzQzjFBFzHJn/WpruIUw9BLnij+CQPBBS38SE9unk68U6nn3LPhsbHAbqAkSUMZr/
         LVVQ==
X-Gm-Message-State: AOAM531Cyl3hR8aM/ktGR5fLXkf0NrnvXlFq6qKRP5arQglFBcn3kcDM
        4NHEjI+37t41syEYgwJUY6TQwaRXwWf4Ut93c610
X-Google-Smtp-Source: ABdhPJzQkCGph00c+9GkbTGMxPX7NVio9ILpaaXhuMVlp6Gu4jhrBRHKzVSv2VOT92gNlo920CjU4Ppmq2IlNhN8riU=
X-Received: by 2002:a05:6402:42d6:: with SMTP id i22mr38752786edc.54.1633963525283;
 Mon, 11 Oct 2021 07:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211011090240.97-1-xieyongji@bytedance.com> <CAJfpegvw2F_WbTAk_f92YwBn3YwqbG3Ond74DY7yvMbzeUnMKA@mail.gmail.com>
In-Reply-To: <CAJfpegvw2F_WbTAk_f92YwBn3YwqbG3Ond74DY7yvMbzeUnMKA@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 11 Oct 2021 22:45:14 +0800
Message-ID: <CACycT3sTarn8BfsGUQsrEbtWt9qeZ8Ph4O3VGpbYi7gbGKgsJA@mail.gmail.com>
Subject: Re: [RFC] fuse: Avoid invalidating attrs if writeback_cache enabled
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 9:21 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 11 Oct 2021 at 11:07, Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > Recently we found the performance of small direct writes is bad
> > when writeback_cache enabled. This is because we need to get
> > attrs from userspace in fuse_update_get_attr() on each write.
> > The timeout for the attributes doesn't work since every direct write
> > will invalidate the attrs in fuse_direct_IO().
> >
> > To fix it, this patch tries to avoid invalidating attrs if writeback_cache
> > is enabled since we should trust local size/ctime/mtime in this case.
>
> Hi,
>
> Thanks for the patch.
>
> Just pushed an update to
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.gitt#for-next
> (9ca3f8697158 ("fuse: selective attribute invalidation")) that should
> fix this behavior.
>

Looks like fuse_update_get_attr() will still get attrs from userspace
each time with this commit applied.

> Could you please test?
>

I applied the commit 9ca3f8697158 ("fuse: selective attribute
invalidation")  and tested it. But the issue still exists.

Thanks,
Yongji
