Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ABA373B03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 14:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhEEMWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 08:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhEEMWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 08:22:35 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD80C061574;
        Wed,  5 May 2021 05:21:38 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b10so1452015iot.4;
        Wed, 05 May 2021 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iz8U5loy8geDk9btldDmJT58vgqPTxOtYivWS5JMHIU=;
        b=XGbp1TiFw6WDoqCAlbyDWBX6XGgovM6jJ9b/5OYG7noabSVkTxpH+5uoK/EvWUd2GW
         GAGex5kK5cqQIZygCRXZEzh1vk2ckM2kuwIgaAv18AjB29RJFbxwK6GIt0bvA2Elf1tK
         cFpVLyQIfsEHKtrMZmNkShk+D49TgQHdI1zD3nZi8M7CVJnmsRdAn3LvYR48QHix4vWX
         X/nK4k7oE62bpyVkyZNLqhMXbCCvdgag8NwVbB4LtG1WFL2Z7aVHDw9SsEEf2mWvnjuU
         Pf5Gm08S/jBjkjzyqvtd9P7x0pAsR70eeBg2ews3dN7DsPhuO3Bqyy7wndkFBjAjnp/h
         RBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iz8U5loy8geDk9btldDmJT58vgqPTxOtYivWS5JMHIU=;
        b=MdYnCeQdnRCVoPkOemVsbXXGrw6Bzu2i4GawR2jg8sQBQSlUaZzdvxiWUSmL0HsQf9
         qjyLvLww9I91DqUMq8XYZrSQPBRi9CsyGeVnptUfEvb1ozztPAN+9RUcD3oupKHToZdr
         KB5BhJX8/fhGknIlp60M9fUkgTEBQfpxoxobZETU1HHCRmmgbEOeCn0m/YZJBr5rbvyC
         ih76GGfBXNpKqtrzmU9nksxGH6+24Ht60blfal2Xbp+NmhIlKt+pps5A5319OeOZXvAN
         1+1t9zbyI/kzMS1/UIfvtSlUB21WrpXNNQPs6wQPk88/U3R54tISd7da5Jai/McF5TiK
         +8Cg==
X-Gm-Message-State: AOAM533ClWTjP/dVwHQWQlSc5Yj/D7eDqRsirhdM2QlTs6EeXZUbBNe/
        EkyZR0sUh5iDQ2Lz8ZSVa4E3gSEzJSqjjwEfCsU=
X-Google-Smtp-Source: ABdhPJysFWBq8OLZzVc77x6XMEnpTr0jFcA3oNSZbASonwHgnGdLxu2jUh+fcaBFLw9R8fMa6S4JI/ORteZS8tjJv+w=
X-Received: by 2002:a02:9109:: with SMTP id a9mr29026252jag.93.1620217297915;
 Wed, 05 May 2021 05:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-5-balsini@android.com>
 <CAJfpegvL2kOCkbP9bBL8YD-YMFKiSazD3_wet2-+emFafA6y5A@mail.gmail.com>
In-Reply-To: <CAJfpegvL2kOCkbP9bBL8YD-YMFKiSazD3_wet2-+emFafA6y5A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 5 May 2021 15:21:26 +0300
Message-ID: <CAOQ4uxjOGx8gZ2biTEb4a54gw5c_aDn+FFkUvRpY+cmgEEh=sA@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 4/8] fuse: Passthrough initialization and release
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 3:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Jan 25, 2021 at 4:31 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > Implement the FUSE passthrough ioctl that associates the lower
> > (passthrough) file system file with the fuse_file.
> >
> > The file descriptor passed to the ioctl by the FUSE daemon is used to
> > access the relative file pointer, that will be copied to the fuse_file
> > data structure to consolidate the link between the FUSE and lower file
> > system.
> >
> > To enable the passthrough mode, user space triggers the
> > FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl and, if the call succeeds, receives
> > back an identifier that will be used at open/create response time in the
> > fuse_open_out field to associate the FUSE file to the lower file system
> > file.
> > The value returned by the ioctl to user space can be:
> > - > 0: success, the identifier can be used as part of an open/create
> > reply.
> > - <= 0: an error occurred.
> > The value 0 represents an error to preserve backward compatibility: the
> > fuse_open_out field that is used to pass the passthrough_fh back to the
> > kernel uses the same bits that were previously as struct padding, and is
> > commonly zero-initialized (e.g., in the libfuse implementation).
> > Removing 0 from the correct values fixes the ambiguity between the case
> > in which 0 corresponds to a real passthrough_fh, a missing
> > implementation of FUSE passthrough or a request for a normal FUSE file,
> > simplifying the user space implementation.
> >
> > For the passthrough mode to be successfully activated, the lower file
> > system file must implement both read_iter and write_iter file
> > operations. This extra check avoids special pseudo files to be targeted
> > for this feature.
> > Passthrough comes with another limitation: no further file system
> > stacking is allowed for those FUSE file systems using passthrough.
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > ---
> >  fs/fuse/inode.c       |  5 +++
> >  fs/fuse/passthrough.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 90 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index a1104d5abb70..7ebc398fbacb 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1133,6 +1133,11 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
> >
> >  static int free_fuse_passthrough(int id, void *p, void *data)
> >  {
> > +       struct fuse_passthrough *passthrough = (struct fuse_passthrough *)p;
> > +
> > +       fuse_passthrough_release(passthrough);
> > +       kfree(p);
> > +
> >         return 0;
> >  }
> >
> > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > index 594060c654f8..cf993e83803e 100644
> > --- a/fs/fuse/passthrough.c
> > +++ b/fs/fuse/passthrough.c
> > @@ -3,19 +3,102 @@
> >  #include "fuse_i.h"
> >
> >  #include <linux/fuse.h>
> > +#include <linux/idr.h>
> >
> >  int fuse_passthrough_open(struct fuse_dev *fud,
> >                           struct fuse_passthrough_out *pto)
> >  {
> > -       return -EINVAL;
> > +       int res;
> > +       struct file *passthrough_filp;
> > +       struct fuse_conn *fc = fud->fc;
> > +       struct inode *passthrough_inode;
> > +       struct super_block *passthrough_sb;
> > +       struct fuse_passthrough *passthrough;
> > +
> > +       if (!fc->passthrough)
> > +               return -EPERM;
> > +
> > +       /* This field is reserved for future implementation */
> > +       if (pto->len != 0)
> > +               return -EINVAL;
> > +
> > +       passthrough_filp = fget(pto->fd);
> > +       if (!passthrough_filp) {
> > +               pr_err("FUSE: invalid file descriptor for passthrough.\n");
> > +               return -EBADF;
> > +       }
> > +
> > +       if (!passthrough_filp->f_op->read_iter ||
> > +           !passthrough_filp->f_op->write_iter) {
> > +               pr_err("FUSE: passthrough file misses file operations.\n");
> > +               res = -EBADF;
> > +               goto err_free_file;
> > +       }
> > +
> > +       passthrough_inode = file_inode(passthrough_filp);
> > +       passthrough_sb = passthrough_inode->i_sb;
> > +       if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
> > +               pr_err("FUSE: fs stacking depth exceeded for passthrough\n");
>
> No need to print an error to the logs, this can be a perfectly normal
> occurrence.  However I'd try to find a more unique error value than
> EINVAL so that the fuse server can interpret this as "not your fault,
> but can't support passthrough on this file".  E.g. EOPNOTSUPP.
>
>

Sorry for the fashionably late response...
Same comment for !{read,write}_iter case above.
EBAFD is really not appropriate there.
May I suggest ELOOP for s_stack_depth and EOPNOTSUPP
for no rw iter ops.

Are you planning to post another version of the patches soon?

Thanks,
Amir.
