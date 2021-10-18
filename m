Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11F8431A69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhJRNLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 09:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhJRNLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:11:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF9CC06161C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 06:09:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w14so70804336edv.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sfYWvGtF/RT2opW48TGh4cv28uaASbal3erpl/QsMA=;
        b=qv7jeK9DO5mWPMMGTw7OJ4VbsWTEEuo08heUS9ChqyCcJDhTHv2a4aWa8gZ7x2Puiq
         NWt5ZwrvvfBgmJoHiPSZvVOOtk48rTKvCvboatN5EbEO/EDxfcPZiB+VWpIA8mRjttvA
         u/FJf9TNrlmJ16oJcfLC5hMeeXmRJTXV9KxbV/wUDbCJMKzzhLEUMdnSGPEL43wKbXRz
         DWYauL6xZ0GbWO6DhFGsVVfwzNVLyNYHu6Ktr/0vKSe05hE3zFm0wnpvhrHGdstO+5Xp
         RA8BggiuvVw7yJ0XB/uZKuDAO1hGkqBtQwW/jkzaX0utBk02jzZL5D+guHg09s/H3i0P
         MURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sfYWvGtF/RT2opW48TGh4cv28uaASbal3erpl/QsMA=;
        b=qIfJyoBeXVhCHDzfUW/P7t0guNQVJaQPcDVgWqC08vnZNQwp62l1D50v5rIUDdwypR
         DnsMAUHzU5oUrHBsg8+AF5v1/9VUpHfsmJz5dTbW08Rb2ELr6KOk9PlxqsSSBXoUjFOT
         2rhMK76lmPfcwMlH+7XnUu1oVpaUVxoETPTvbXo1OIHfuLhoiNPlrkKfqOf1B2GsYmRN
         wS8pxAisWGx6/VS9iu0Dkz7S13uzofQy86GUZ2zIKR0GpYhZWrOXq1xVTuMMiwWmZGwv
         ey6UXm9/VjQ5Cw3pd01NOzkhCGXvnV4YXq2XMKAAVtC8GL+AUOYAvkuuqPXL0TqgUF7B
         tt0g==
X-Gm-Message-State: AOAM532JIw1V1CM76YyGL4DVpcaH9OGKlxHs9dGYEGf6P5949Yw19W+y
        dZ+3wdTBu29a1UyOnB3Chgq9v/KFf2cHTIKqHCI8
X-Google-Smtp-Source: ABdhPJx8sPwahsK+tmVX4AsdUMywiCdG8lbBDT2PwydF1/PjHWbPDuEjH2eEnYLTv9BC5AxvzMN3B6MGeyh1Mn0BFjU=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr44978423edd.231.1634562526268;
 Mon, 18 Oct 2021 06:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211011090240.97-1-xieyongji@bytedance.com> <CAJfpegvw2F_WbTAk_f92YwBn3YwqbG3Ond74DY7yvMbzeUnMKA@mail.gmail.com>
 <CACycT3sTarn8BfsGUQsrEbtWt9qeZ8Ph4O3VGpbYi7gbGKgsJA@mail.gmail.com>
 <CAJfpeguaRjQ9Fd1S4NHx5XVF89PGgFBxW3Xf=XNrb1QQRbDbYQ@mail.gmail.com>
 <CACycT3s=aC6eWfo0LHMuE6sVVErjkZPScsgaBGn4QABbZE2a9g@mail.gmail.com> <CAJfpegv51cbjkD6BQ6wUZSbaTpnB1-827G++HQnWX7zGA5fmmA@mail.gmail.com>
In-Reply-To: <CAJfpegv51cbjkD6BQ6wUZSbaTpnB1-827G++HQnWX7zGA5fmmA@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 18 Oct 2021 21:08:35 +0800
Message-ID: <CACycT3u18XRVs6LbaB0_UNX-_SpH1r=w=N01k61vscenozVj3g@mail.gmail.com>
Subject: Re: [RFC] fuse: Avoid invalidating attrs if writeback_cache enabled
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 7:45 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 18 Oct 2021 at 13:25, Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Wed, Oct 13, 2021 at 9:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, 11 Oct 2021 at 16:45, Yongji Xie <xieyongji@bytedance.com> wrote:
> > > >
> > > > On Mon, Oct 11, 2021 at 9:21 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > On Mon, 11 Oct 2021 at 11:07, Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > >
> > > > > > Recently we found the performance of small direct writes is bad
> > > > > > when writeback_cache enabled. This is because we need to get
> > > > > > attrs from userspace in fuse_update_get_attr() on each write.
> > > > > > The timeout for the attributes doesn't work since every direct write
> > > > > > will invalidate the attrs in fuse_direct_IO().
> > > > > >
> > > > > > To fix it, this patch tries to avoid invalidating attrs if writeback_cache
> > > > > > is enabled since we should trust local size/ctime/mtime in this case.
> > > > >
> > > > > Hi,
> > > > >
> > > > > Thanks for the patch.
> > > > >
> > > > > Just pushed an update to
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.gitt#for-next
> > > > > (9ca3f8697158 ("fuse: selective attribute invalidation")) that should
> > > > > fix this behavior.
> > > > >
> > > >
> > > > Looks like fuse_update_get_attr() will still get attrs from userspace
> > > > each time with this commit applied.
> > > >
> > > > > Could you please test?
> > > > >
> > > >
> > > > I applied the commit 9ca3f8697158 ("fuse: selective attribute
> > > > invalidation")  and tested it. But the issue still exists.
> > >
> > > Yeah, my bad.  Pushed a more complete set of fixes to #for-next ending with
> > >
> > > e15a9a5fca6c ("fuse: take cache_mask into account in getattr")
> > >
> > > You should pull or cherry pick the complete branch.
> > >
> >
> > I tested this branch, but it still doesn't fix this issue. The
> > inval_mask = 0x6C0 and cache_mask = 0x2C0, so we still need to get
> > attrs from userspace. Should we add STATX_BLOCKS to cache_mask?
>
> Does the attach incremental ~/gupatch solve this?

Yes, this patch solves it.

Thanks,
Yongji
