Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9842C1C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhJMNy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhJMNy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:54:56 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7552DC061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 06:52:53 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id u5so4549050uao.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Oct 2021 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxaBZG3SSxRYAROaf1n89iFwIV9nDCzDr26dh6jtBRM=;
        b=ZS3hChruB3A/EdbV7+EdcCmNoRkTIvcOaI1y7mMyxBkkaoDg6o3OB79boyFgFIH7ZZ
         8jjny90rq0FvPOykz1JgmdugE/D5gk9ccs6K0zvpplf8QJVxg+BaBKoRkBtOjgZ1CsNm
         z7lKAKeP2Rf8GpedWn2I9wH9XEB8wv2PzCgIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxaBZG3SSxRYAROaf1n89iFwIV9nDCzDr26dh6jtBRM=;
        b=jSkMi0qSMxL3i6VVwWbrOooJ5VZxWxYpT49qrJLm3JcfEtzQc14DLYeEXy9BXiQ6EA
         7MBglZD9XMvT62iqpuxgEebnqYZ1OAW7ftTS/Nf50Ynx7gFdjPwoO/Db/Q87B9D7e4zR
         9c3Eob+bBB0A+l95czuPKpyWbat6B4qiXwpeU2qXfIrgII3+ZkCweZX7M/CHgLEO3p+C
         8zI2UoDJWvOws0y7z8B9bqsYwdt1w2u2zFK+ZFyWF0lfm6HxhhNfuZ7emVdxDzC80mhO
         Tf/G4L2+PQwGgAVdkUyRylnxDlDmQpSsyliUWXoq2h6tzxpYFzXyfjq71zysYIM8gDtc
         XscA==
X-Gm-Message-State: AOAM532odqX1CkV/TVxvg3e6rhSl3G3C9j2wAMGcaeanYIC6FWDLWgFs
        sWgtjLSmDLmqeZkUP73oWdxdJBqLscEKEax0EQPMCSk6t8E=
X-Google-Smtp-Source: ABdhPJw+sWUGEv2nawnwME7eqi22xUwlkIGYkVx61sgKxQzVT8FjrA7z5+/Yp/NqvZ2jcO/vqdevpWlIfyv6gngjvbA=
X-Received: by 2002:a67:d504:: with SMTP id l4mr4320059vsj.42.1634133172549;
 Wed, 13 Oct 2021 06:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211011090240.97-1-xieyongji@bytedance.com> <CAJfpegvw2F_WbTAk_f92YwBn3YwqbG3Ond74DY7yvMbzeUnMKA@mail.gmail.com>
 <CACycT3sTarn8BfsGUQsrEbtWt9qeZ8Ph4O3VGpbYi7gbGKgsJA@mail.gmail.com>
In-Reply-To: <CACycT3sTarn8BfsGUQsrEbtWt9qeZ8Ph4O3VGpbYi7gbGKgsJA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 Oct 2021 15:52:41 +0200
Message-ID: <CAJfpeguaRjQ9Fd1S4NHx5XVF89PGgFBxW3Xf=XNrb1QQRbDbYQ@mail.gmail.com>
Subject: Re: [RFC] fuse: Avoid invalidating attrs if writeback_cache enabled
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 11 Oct 2021 at 16:45, Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Mon, Oct 11, 2021 at 9:21 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 11 Oct 2021 at 11:07, Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > Recently we found the performance of small direct writes is bad
> > > when writeback_cache enabled. This is because we need to get
> > > attrs from userspace in fuse_update_get_attr() on each write.
> > > The timeout for the attributes doesn't work since every direct write
> > > will invalidate the attrs in fuse_direct_IO().
> > >
> > > To fix it, this patch tries to avoid invalidating attrs if writeback_cache
> > > is enabled since we should trust local size/ctime/mtime in this case.
> >
> > Hi,
> >
> > Thanks for the patch.
> >
> > Just pushed an update to
> > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.gitt#for-next
> > (9ca3f8697158 ("fuse: selective attribute invalidation")) that should
> > fix this behavior.
> >
>
> Looks like fuse_update_get_attr() will still get attrs from userspace
> each time with this commit applied.
>
> > Could you please test?
> >
>
> I applied the commit 9ca3f8697158 ("fuse: selective attribute
> invalidation")  and tested it. But the issue still exists.

Yeah, my bad.  Pushed a more complete set of fixes to #for-next ending with

e15a9a5fca6c ("fuse: take cache_mask into account in getattr")

You should pull or cherry pick the complete branch.

Thanks,
Miklos
