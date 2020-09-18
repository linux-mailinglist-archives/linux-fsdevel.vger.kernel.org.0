Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45F32705E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRT73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIRT72 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:59:28 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA33C0613CE;
        Fri, 18 Sep 2020 12:59:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x18so5058002ila.7;
        Fri, 18 Sep 2020 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jCYIACuhjclAywU5+9CJ6TqYdm+ri/HvHFJXd2c0iU=;
        b=E686i06sCMkMsJ47BGjd2Rwowi7HrtuqmIOiJA1WlOqvCUQLOhHIRZrHdZpdcHqEex
         8M8dbOxPVswPZ1dERVt7Y07w1lJ4IG90gligMaG7AsSzi1og/dOWRpc06z5U37mVAMBu
         MezrrrtFOiOEIj0Ltp9JfWCsqpcItxWI5HuEDoJe9BnmOAGoxBehRyk28kBMSsoNB/8i
         U+4iSKdoTodpz1QsKgV6MZe3uLCQfZXZM1RLLfKCIdhvC/Lb0K0WbF5VYZN3xbFlU7dY
         EfUvxpC3RMN1dN6b0d4sJ7S/dKHG7zcShiN32LlwPTmMvDheYlaRC9QhXFaBL1mTzDI0
         x5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jCYIACuhjclAywU5+9CJ6TqYdm+ri/HvHFJXd2c0iU=;
        b=dM228pSyoTka5ec4sw4JCoNuevcA4avip05GIjK+EoxhOcFZPy9KhgNox7PcVEmafB
         RVBbaAJeZGCfiN7CgKlnMGSO7fFMCtL5fHC9jBVSWy99YH/4FDkuWOeZn0KWUFGEfiiD
         6vNiRGCWgtRdkkEqjLrQsRqtY39QVscVg1Dup2Xolkrt6iY9utlV276tl9frCl8BEEKM
         Jotq3qNXGk276ADK3ORQLw2TShQtnmoI6p5Gt8ns9d+y8DBRzXQacpG4qpNFG/Z5+kJB
         QVCEzysSMRVZ3bjAjJ73L/GPKd1y02wzYyGYOzTFoF/PMAwhjdepULeHkE5rxjiYiIzV
         rBzA==
X-Gm-Message-State: AOAM532J+A+jW79fuCpdQq/I+fXB7D+T93xsihW0TKF2iRILiiWdbg2Y
        nmONVvQKKjn7OAHNIVHXPvWycoVnDRBolMo5M5g=
X-Google-Smtp-Source: ABdhPJzTBZeKjWWm+CvWih3+jCqQYydAdYEjanpgIkRIrFIbSYVbsvYiuzAMsL0zpsNwGhUtygSN5USKAq96/RGpOzg=
X-Received: by 2002:a92:1fd9:: with SMTP id f86mr31055820ilf.250.1600459167986;
 Fri, 18 Sep 2020 12:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200911163403.79505-1-balsini@android.com> <20200911163403.79505-2-balsini@android.com>
 <CAOQ4uxiWK5dNMkrriApMVZQi6apmnMijcCw5j4fa2thHFdnFcw@mail.gmail.com> <20200918163354.GB3385065@google.com>
In-Reply-To: <20200918163354.GB3385065@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 18 Sep 2020 22:59:16 +0300
Message-ID: <CAOQ4uxhNddkdZ5TCdg6Gdb9oYqNVUrpk25kGYxZNe-LDsZV_Ag@mail.gmail.com>
Subject: Re: [PATCH V8 1/3] fuse: Definitions and ioctl() for passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 7:33 PM Alessio Balsini <balsini@android.com> wrote:
>
> Hi Amir,
>
> Thanks again for your feedback.
>
> On Sat, Sep 12, 2020 at 02:06:02PM +0300, Amir Goldstein wrote:
> > On Fri, Sep 11, 2020 at 7:34 PM Alessio Balsini <balsini@android.com> wrote:
> > [...]
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index bba747520e9b..eb223130a917 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -965,6 +965,12 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
> > >                                         min_t(unsigned int, FUSE_MAX_MAX_PAGES,
> > >                                         max_t(unsigned int, arg->max_pages, 1));
> > >                         }
> > > +                       if (arg->flags & FUSE_PASSTHROUGH) {
> > > +                               fc->passthrough = 1;
> > > +                               /* Prevent further stacking */
> > > +                               fc->sb->s_stack_depth =
> > > +                                       FILESYSTEM_MAX_STACK_DEPTH;
> > > +                       }
> >
> > That seems a bit limiting.
> > I suppose what you really want to avoid is loops into FUSE fd.
> > There may be a way to do this with forbidding overlay over FUSE passthrough
> > or the other way around.
> >
> > You can set fc->sb->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH - 1
> > here and in passthrough ioctl you can check for looping into a fuse fs with
> > passthrough enabled on the passed fd (see below) ...
> >
> > [...]
> > > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > > new file mode 100644
> > > index 000000000000..86ab4eafa7bf
> > > --- /dev/null
> > > +++ b/fs/fuse/passthrough.c
> > > @@ -0,0 +1,55 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include "fuse_i.h"
> > > +
> > > +int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd)
> > > +{
> > > +       int ret;
> > > +       int fs_stack_depth;
> > > +       struct file *passthrough_filp;
> > > +       struct inode *passthrough_inode;
> > > +       struct super_block *passthrough_sb;
> > > +
> > > +       /* Passthrough mode can only be enabled at file open/create time */
> > > +       if (req->in.h.opcode != FUSE_OPEN && req->in.h.opcode != FUSE_CREATE) {
> > > +               pr_err("FUSE: invalid OPCODE for request.\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       passthrough_filp = fget(fd);
> > > +       if (!passthrough_filp) {
> > > +               pr_err("FUSE: invalid file descriptor for passthrough.\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       ret = -EINVAL;
> > > +       if (!passthrough_filp->f_op->read_iter ||
> > > +           !passthrough_filp->f_op->write_iter) {
> > > +               pr_err("FUSE: passthrough file misses file operations.\n");
> > > +               goto out;
> > > +       }
> > > +
> > > +       passthrough_inode = file_inode(passthrough_filp);
> > > +       passthrough_sb = passthrough_inode->i_sb;
> > > +       fs_stack_depth = passthrough_sb->s_stack_depth + 1;
> >
> > ... for example:
> >
> >        if (fs_stack_depth && passthrough_sb->s_type == fuse_fs_type) {
> >                pr_err("FUSE: stacked passthrough file\n");
> >                goto out;
> >        }
> >
> > But maybe we want to ban passthrough to any lower FUSE at least for start.
>
>
> Yes, what I proposed here is very conservative, and your solution sounds
> good to me. Unfortunately I don't have a clear idea of what could go wrong
> if we relax this constraint. I need some guidance from you experts here.
>

I guess the main concern would be locking order and deadlocks.
With my suggestion I think deadlocks are avoided and I am less sure
but think that lockdep should not have false positives either.

If people do need the 1-level stacking, I can try to think harder
if it is safe and maybe add some more compromise limitations.

> What do you think if we keep this overly strict rule for now to avoid
> unintended behaviors and come back as we find affected use case?
>

I can live with that if other designated users don't mind the limitation.

I happen to be developing a passthrough FUSE fs [1] myself and
I also happen to be using it to pass through to overlayfs.
OTOH, the workloads for my use case are mostly large sequential IO,
and the hardware can handle the few extra syscalls, so the passthrough
fd feature is not urgent for my use case at this point in time.


>
> >
> > > +       ret = -EEXIST;
> >
> > Why EEXIST? Why not EINVAL?
> >
>
>
> Reaching the stacking limit sounded like an error caused by the undesired
> existence of something, thus EEXIST sounded like a good fit.
> No problem in changing that to EINVAL.
>
>
>
> > > +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> > > +               pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
> > > +               goto out;
> > > +       }
> > > +
> > > +       req->args->passthrough_filp = passthrough_filp;
> > > +       return 0;
> > > +out:
> > > +       fput(passthrough_filp);
> > > +       return ret;
> > > +}
> > > +
> >
> > And speaking of overlayfs, I believe you may be able to test your code with
> > fuse-overlayfs (passthrough to upper files).
> >
...
>
> This is indeed a project with several common elements to what we are doing
> in Android,

Are you in liberty to share more information about the Android project?
Is it related to Incremental FS [2]?

Thanks,
Amir.

[1] https://github.com/amir73il/libfuse/commits/cachegwfs
[2] https://lore.kernel.org/linux-fsdevel/20190502040331.81196-1-ezemtsov@google.com/
