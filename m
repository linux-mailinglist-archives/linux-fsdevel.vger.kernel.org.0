Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7AB366CC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbhDUN2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 09:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240967AbhDUN2t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:28:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93F8D61449;
        Wed, 21 Apr 2021 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619011695;
        bh=gd6rsygtuagfkB4FDvWJXsa742reDkhpJW+iRUjhuHU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t25R61c8zfm3o/7Vj1DobsToPSADsHEVrGtsGb9SMfxgo9LRkwpXmz6M9VycBiOr0
         CSh641IvPStyZj3lqUxbfnUTyFFFerPXvh/q5RyecQMkV/1xdm3IyrZfnxOdmp0rHH
         bWZ/Ppdry7GCTH6YGXQLnp7GoFCwsv6WPhENEm2G0nEC6hYdrldw7cU/QSLR889A2Q
         ZPHWNe6Cw8Y4NhvTA+fERLFTJExanBNg1AHZ2BOxqO90ic9Bb+0NwmvhA39sFTxbFt
         Xf3EYNTN+yLVaSdTIUZJV0mra9tV39R/0IUKXAnQFohvlaK2R0kjHPvotFj9vZuvl2
         mODpr6RkoErDg==
Received: by mail-ed1-f43.google.com with SMTP id h10so49337864edt.13;
        Wed, 21 Apr 2021 06:28:15 -0700 (PDT)
X-Gm-Message-State: AOAM532Q6fFXYvArr2Fcdxl3m/h8K5vI92vp3bI92HTEH5yogNozdulb
        YTaUeTgIY9Txsrf3heRMdCEt71KtcvpVj0kVG7g=
X-Google-Smtp-Source: ABdhPJxesrYNMpetivD88y9gOQd9/WNjXGkrwbMGNXwoHyVO6fn06ZJLI0nODGQZ/qRqHh0KYR1I2lEnH5FMv/zbdYU=
X-Received: by 2002:a50:ec92:: with SMTP id e18mr39345623edr.246.1619011694047;
 Wed, 21 Apr 2021 06:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210406235332.2206460-1-pakki001@umn.edu> <20210407155031.GA1014852@redhat.com>
In-Reply-To: <20210407155031.GA1014852@redhat.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 21 Apr 2021 15:28:01 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc-GuTmVzWPXWqSegtckDsfyYj_aOKwK1TKCsYFkK681A@mail.gmail.com>
Message-ID: <CAJKOXPc-GuTmVzWPXWqSegtckDsfyYj_aOKwK1TKCsYFkK681A@mail.gmail.com>
Subject: Re: [PATCH] fuse: Avoid potential use after free
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 7 Apr 2021 at 23:25, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Apr 06, 2021 at 06:53:32PM -0500, Aditya Pakki wrote:
> > In virtio_fs_get_tree, after fm is freed, it is again freed in case
> > s_root is NULL and virtio_fs_fill_super() returns an error. To avoid
> > a double free, set fm to NULL.
> >
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > ---
> >  fs/fuse/virtio_fs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 4ee6f734ba83..a7484c1539bf 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -1447,6 +1447,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
> >       if (fsc->s_fs_info) {
> >               fuse_conn_put(fc);
> >               kfree(fm);
> > +             fm = NULL;
>
> I think both the code paths are mutually exclusive and that's why we
> don't double free it.
>
> sget_fc(), can either return existing super block which is already
> initialized, or it can create a new super block which need to
> initialize further.
>
> If if get an existing super block, in that case fs->s_fs_info will
> still be set and we need to free fm (as we did not use it). But in
> that case this super block is already initialized so sb->s_root
> should be non-null and we will not call virtio_fs_fill_super()
> on this. And hence we will not get into kfree(fm) again.
>
> Same applies to fuse_conn_put(fc) call as well.
>
> So I think this patch is not needed. I think sget_fc() semantics are
> not obvious and that confuses the reader of the code.

This patch might be harmful, might be not. Probably should be skipped
due to uncertain intentions:
https://lore.kernel.org/linux-nfs/YH+7ZydHv4+Y1hlx@kroah.com/

Best regards,
Krzysztof
