Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084C170C170
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 16:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjEVOuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEVOuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 10:50:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC28CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 07:50:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so11238374a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 07:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1684767017; x=1687359017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ON1XtIn8i5t/ok1PZB/tCkyoT+Ms37Fnnm8zl6UYm8=;
        b=gOfrA1nkFC4EosA0DoIjpYPbjKBgOW9GJQCAFlmnuJZaGJ/KGGOcC4OlPLYuCUAYnz
         5q6KTu2hpPYV4tIYDgnQPtpojZW2Vr4s1COZM741vB5cmNuWxIx7ccfKve61j3fLpdhZ
         8sgYsJl39A19yOm2+SmJTHUIhXWVNa65ylADE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684767017; x=1687359017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ON1XtIn8i5t/ok1PZB/tCkyoT+Ms37Fnnm8zl6UYm8=;
        b=R95mPtHBxKQFc+eC2r/N0xXMruhBSmPS7DLXiilca2t1NCRdrAYax4655mUDA4ZCEP
         Cgflde6R0qio/bDPqqSa2Jzqfq6g0tU+ZDxFJTrUonph9Awi8eYLSmHHrVox7qEYiplQ
         Pnhwm1LSGu4QKtHWI9r6xeeff+FsVLtnFa9nh7TKlRK1kbw/TxE2tTxGYUDxVLfCCCpa
         1ti36OsAY49Z4RB9b3Kn07QXpaIp4x1I4+/nM++ha40H8NzWQQ9wEpk7VVa+QrCIWQYr
         G1eZvQUI8ONE5kaom/CO7AigDqaWujpn3wFkjtOEsgohZ2HoNEqGfXYvucfmpriagCGg
         OkOw==
X-Gm-Message-State: AC+VfDw6n4JsdlNenCTY+Ob6LDxqQDSqFYZLz+AjfK1jc3L9cZ0Bkd+n
        8JEwoDvAgW2ysBUE5udo1Y3QttfmrWWySfAbYoc5Gw==
X-Google-Smtp-Source: ACHHUZ5hRjtpjMRp7EHe7euPLb7teaCVuN8oSj+MtgtgxPQdX+TMV4M4eAXkP3qsgHWy76S4QGGCbE1S3H4f5Ef5VzE=
X-Received: by 2002:a17:907:da5:b0:970:925:6563 with SMTP id
 go37-20020a1709070da500b0097009256563mr2127237ejc.8.1684767017115; Mon, 22
 May 2023 07:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-3-amir73il@gmail.com>
 <CAJfpegtK7dJ1wa5NdruK1rPmJ9JgXujjyxFCGFBXnu=6u_KzLQ@mail.gmail.com> <CAOQ4uxi=wWWeDb5BLQiOmMG02R-LRugy1TXCM7YU77K-7Ost0A@mail.gmail.com>
In-Reply-To: <CAOQ4uxi=wWWeDb5BLQiOmMG02R-LRugy1TXCM7YU77K-7Ost0A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 22 May 2023 16:50:05 +0200
Message-ID: <CAJfpegsty3wfV=2g_M7pfdrHxDDjecOAnkidcp87pe5o+dBt_A@mail.gmail.com>
Subject: Re: [PATCH v13 02/10] fuse: Definitions and ioctl for passthrough
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 20 May 2023 at 12:20, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, May 19, 2023 at 6:13=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Fri, 19 May 2023 at 14:57, Amir Goldstein <amir73il@gmail.com> wrote=
:
> > >
> > > From: Alessio Balsini <balsini@android.com>
> > >
> > > Expose the FUSE_PASSTHROUGH capability to user space and declare all =
the
> > > basic data structures and functions as the skeleton on top of which t=
he
> > > FUSE passthrough functionality will be built.
> > >
> > > As part of this, introduce the new FUSE passthrough ioctl, which allo=
ws
> > > the FUSE daemon to specify a direct connection between a FUSE file an=
d a
> > > backing file.  The ioctl requires user space to pass the file descrip=
tor
> > > of one of its opened files to the FUSE driver and get an id in return=
.
> > > This id may be passed in a reply to OPEN with flag FOPEN_PASSTHROUGH
> > > to setup passthrough of read/write operations on the open file.
> > >
> > > Also, add the passthrough functions for the set-up and tear-down of t=
he
> > > data structures and locks that will be used both when fuse_conns and
> > > fuse_files are created/deleted.
> > >
> > > Signed-off-by: Alessio Balsini <balsini@android.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/fuse/Makefile          |  1 +
> > >  fs/fuse/dev.c             | 33 ++++++++++++++++++++++++--------
> > >  fs/fuse/dir.c             |  7 ++++++-
> > >  fs/fuse/file.c            | 17 +++++++++++++----
> > >  fs/fuse/fuse_i.h          | 27 ++++++++++++++++++++++++++
> > >  fs/fuse/inode.c           | 21 +++++++++++++++++++-
> > >  fs/fuse/passthrough.c     | 40 +++++++++++++++++++++++++++++++++++++=
++
> > >  include/uapi/linux/fuse.h | 13 +++++++++++--
> > >  8 files changed, 143 insertions(+), 16 deletions(-)
> > >  create mode 100644 fs/fuse/passthrough.c
> > >
> > > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > > index 0c48b35c058d..d9e1b47382f3 100644
> > > --- a/fs/fuse/Makefile
> > > +++ b/fs/fuse/Makefile
> > > @@ -8,6 +8,7 @@ obj-$(CONFIG_CUSE) +=3D cuse.o
> > >  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
> > >
> > >  fuse-y :=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readd=
ir.o ioctl.o
> > > +fuse-y +=3D passthrough.o
> > >  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> > >
> > >  virtiofs-y :=3D virtio_fs.o
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 1a8f82f478cb..cb00234e7843 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -2255,16 +2255,19 @@ static long fuse_dev_ioctl(struct file *file,=
 unsigned int cmd,
> > >                            unsigned long arg)
> > >  {
> > >         int res;
> > > -       int oldfd;
> > > -       struct fuse_dev *fud =3D NULL;
> > > +       int fd, id;
> > > +       struct fuse_dev *fud =3D fuse_get_dev(file);
> >
> > This is broken, see below.
>
> IIUC, *this* is not broken for the new ioctls...
>
> >
> > >         struct fd f;
> > >
> > > +       if (!fud)
> > > +               return -EINVAL;
> > > +

This is also broken for the old ioctl.

> > >         switch (cmd) {
> > >         case FUSE_DEV_IOC_CLONE:
> > > -               if (get_user(oldfd, (__u32 __user *)arg))
> > > +               if (get_user(fd, (__u32 __user *)arg))
> > >                         return -EFAULT;
> > >
> > > -               f =3D fdget(oldfd);
> > > +               f =3D fdget(fd);
> > >                 if (!f.file)
> > >                         return -EINVAL;
> > >
> > > @@ -2272,17 +2275,31 @@ static long fuse_dev_ioctl(struct file *file,=
 unsigned int cmd,
> > >                  * Check against file->f_op because CUSE
> > >                  * uses the same ioctl handler.
> > >                  */
> > > -               if (f.file->f_op =3D=3D file->f_op)
> > > -                       fud =3D fuse_get_dev(f.file);
> > > -
> > >                 res =3D -EINVAL;
> > > -               if (fud) {
> > > +               if (f.file->f_op =3D=3D file->f_op) {
>
> and this can be fixed by adding:
>  +                           fud =3D fuse_get_dev(f.file);

Yes, but it's still messy.

I suggest separating out unrelated ioctl commands into different
functions.  Not sure if it's worth doing the open/close in a common
function, I'll leave that to you.

[snip]

> > Seems too restrictive.  We could specify the max stacking depth in the
> > protocol and verify that when registering the passthrough file.
> >
> > I.e. fuse_sb->s_stack_depth of
> >
> > 0 -> passthrough disabled
> > 1 -> backing_sb->s_stack_depth =3D=3D 0
> > 2 -> backing_sb->stack_depth <=3D 1
> > ...
> >
>
> Ok. Let's see.
> What do we stand to gain from the ability to setup nax stacking depth?
>
> We could use it to setup an overlayfs with lower FUSE that allows passthr=
ough
> fds to a non-stacked backing fs and we could use it to setup FUSE that al=
lows
> passthrough fds to overlayfs.
>
> I pity the FUSE userspace developers that will need to understand this
> setup parameter...

I guess libfuse could parse it with other common options.  It's
something that needs to be tuned on a per-case basis, not something
the filesystem designer can predict.

Would be better if we could have a per-inode stack depth and then this
wouldn't have to be tuned.  Is that feasible?

> So ignoring the possibility of  FILESYSTEM_MAX_STACK_DEPTH changing in
> the future, maybe better describe this with two capability flags
> instead of an int?

The max depth could be changed, this value was just chosen because we
didn't have a use case for a larger fs stack, I guess.  Some analysis
about the kernel stack usage would be required before doing so (btw.
such analysis was never done, so it would be useful regardless).

Thanks,
Miklos
