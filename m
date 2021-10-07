Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AB442535A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 14:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhJGMr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhJGMrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:47:25 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D7C061755
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Oct 2021 05:45:32 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f2so6626039vsj.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Oct 2021 05:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wVGqCEv5OuW11NNJUvfsDwkjHfJJuYc/XpuXB4FLhAc=;
        b=Rf8GuXJ7M1dKiqO3dvNXK4IDlZxdzcsLOAiqs622DUFDvs2+FoX0siDG7l7JBWAEFS
         FYI/dFhiPr85/tr4UDhHFOmRdda7+AWL8LphfB1ZP5vUku44Hzy4boBbG3zsz2TDPmuy
         5DL5cGMcOj/x7Vi4CsKCiyPW3sESFeeqwkNGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wVGqCEv5OuW11NNJUvfsDwkjHfJJuYc/XpuXB4FLhAc=;
        b=mETrtLZUgpVEvyr+bPERyLc+DZIf1ZchYvgdzvh9koBh+RE9KazTOloz1wUwgLi8A8
         QzAG0xnkbmVowAiO0aZl6W9+NxZZHj6AiAludV+sI5cahjUho3dYv4wpg63dxSOPL4Ws
         dluVUdnm+mUZKSt5rOsu5HIB2VStNs/sI1aN82RC339+lyTiBF0bm5PjORCvYE4rud+I
         P/ktyodoyesbwKjJvaF3KiOkA8IcAdCywgwm7A1+W2zlR4Z/rNGNwvqeukEvdopa+mYe
         m1UfBqG1aeJyw18I5Y8m2VGzSauaZqqhf3IvQK030mXnUYMR2F6rblxULsN90zfZ3x1n
         Msdw==
X-Gm-Message-State: AOAM533zPgob2dUBnDDYzHRmHkVktjudTjEAta9nQoUNEtdE6RynlmA5
        +NuaUdE2NFjCj61vqGDnIrls+khogbcDjggc1TljpyKq9eE=
X-Google-Smtp-Source: ABdhPJxxG+rpdbv8RJtQlpU0+LgZvCFIrN4KUwyYnxMZ5ZFAX5aUfgqwvRb/nmLCXUMWgnXFGfN2xtfZ/QtvjTVnx50=
X-Received: by 2002:a67:ec94:: with SMTP id h20mr3614063vsp.59.1633610731189;
 Thu, 07 Oct 2021 05:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com> <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
In-Reply-To: <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 7 Oct 2021 14:45:20 +0200
Message-ID: <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 7 Oct 2021 at 14:28, Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 17:23:06 Miklos S=
zeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
>  > On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wr=
ote:
>  > >
>  > > Implement overlayfs' ->write_inode to sync dirty data
>  > > and redirty overlayfs' inode if necessary.
>  > >
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > ---
>  > >  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
>  > >  1 file changed, 30 insertions(+)
>  > >
>  > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>  > > index 2ab77adf7256..cddae3ca2fa5 100644
>  > > --- a/fs/overlayfs/super.c
>  > > +++ b/fs/overlayfs/super.c
>  > > @@ -412,12 +412,42 @@ static void ovl_evict_inode(struct inode *inod=
e)
>  > >         clear_inode(inode);
>  > >  }
>  > >
>  > > +static int ovl_write_inode(struct inode *inode,
>  > > +                          struct writeback_control *wbc)
>  > > +{
>  > > +       struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
>  > > +       struct inode *upper =3D ovl_inode_upper(inode);
>  > > +       unsigned long iflag =3D 0;
>  > > +       int ret =3D 0;
>  > > +
>  > > +       if (!upper)
>  > > +               return 0;
>  > > +
>  > > +       if (!ovl_should_sync(ofs))
>  > > +               return 0;
>  > > +
>  > > +       if (upper->i_sb->s_op->write_inode)
>  > > +               ret =3D upper->i_sb->s_op->write_inode(inode, wbc);
>  >
>  > Where is page writeback on upper inode triggered?
>  >
>
> Should pass upper inode instead of overlay inode here.

That's true and it does seem to indicate lack of thorough testing.

However that wasn't what I was asking about.  AFAICS ->write_inode()
won't start write back for dirty pages.   Maybe I'm missing something,
but there it looks as if nothing will actually trigger writeback for
dirty pages in upper inode.

Thanks,
Miklos
