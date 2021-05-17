Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5E7382B39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 13:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhEQLiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbhEQLiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 07:38:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B11C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 04:36:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so5996606wrt.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w+xkGRvvRiunjBm3RVE6YkhJ5AJIWHDmoIrUIlGn+fc=;
        b=rgeOydfoO4C0EGb+zRmNliMzLP+z/a3m/PFvxWzQCnuTO0yX+YRfpXF1F/UYV8g5wZ
         4QB+/OXoKHS192d/lt5nSZqGPQdDUZPdAI6UezHpfVdKOgAF5iPPyhZahZX+s7MiEqd3
         qeC+9PMLWROihyVRXsduqAT9Q1L+zD2DKsYG1alUepvXXUPHUHdLdHS2xa2vEWnqiQkz
         DBjW/Q6/7WAl02qblvCi8azyWoJABTNcExa5YAltFXPHb0uPHKpfdkB0IWy0wsemVP72
         NOgTI5z2APyifDtP178fxwUdiCe11qaAdGsZLCNXV318ih3yUKwzg8OOKVgOb0XrfqK1
         FuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+xkGRvvRiunjBm3RVE6YkhJ5AJIWHDmoIrUIlGn+fc=;
        b=jj7nDyvS07Ow5bivMu1xHqOrgzFYJ3d/BWGUgPD/nEsjtPzRQ5z8sDgqtJF1UUDkq7
         8HdVxJ9pH97CL1oot47sPIS7Oj6GMhEqgE6fKKIEuTdcZTXKf1O8poVCSRB7a7fnxupm
         WuCwJZwPR9byBVN3R9FDDMKOyHwgfgLvb00UpNYd3MdbTWmCNukZkKx2LoB0hQQaOGAm
         KBMeovnjIU6aYnHn5sOChYBKvyo//9/YxNJWToeIefnpTagy3DNOwPlQsmqqT5Mct09a
         rbhAnRI7HfBM5cGR+Um0Oog5jhkMuwuFL8o31WjvutyxMujGbbJOUNp7vg3aeZuLSG3x
         BmoQ==
X-Gm-Message-State: AOAM530TvD8z5ppOnm0mIal5No95s/pYAoVzo4C+z24cfCm4DrNWjUMd
        HylmgF5qRylHDHYCpHwYKGzJZw==
X-Google-Smtp-Source: ABdhPJyGsM3oCPTLWOpqeCoRagEc7wbBVf6zeJwBGTjbXWDCK5KGLdhunb7sWhyxf/KCLdblAG64pw==
X-Received: by 2002:a5d:64a9:: with SMTP id m9mr3795995wrp.200.1621251411489;
        Mon, 17 May 2021 04:36:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:c20d:53d8:7bc:dbf9])
        by smtp.gmail.com with ESMTPSA id a18sm10660286wmb.13.2021.05.17.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 04:36:51 -0700 (PDT)
Date:   Mon, 17 May 2021 12:36:49 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
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
Subject: Re: [PATCH RESEND V12 4/8] fuse: Passthrough initialization and
 release
Message-ID: <YKJVUUUapNSijV38@google.com>
References: <20210125153057.3623715-1-balsini@android.com>
 <20210125153057.3623715-5-balsini@android.com>
 <CAJfpegvL2kOCkbP9bBL8YD-YMFKiSazD3_wet2-+emFafA6y5A@mail.gmail.com>
 <CAOQ4uxjOGx8gZ2biTEb4a54gw5c_aDn+FFkUvRpY+cmgEEh=sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjOGx8gZ2biTEb4a54gw5c_aDn+FFkUvRpY+cmgEEh=sA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 05, 2021 at 03:21:26PM +0300, Amir Goldstein wrote:
> On Wed, Feb 17, 2021 at 3:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, Jan 25, 2021 at 4:31 PM Alessio Balsini <balsini@android.com> wrote:
> > >
> > > Implement the FUSE passthrough ioctl that associates the lower
> > > (passthrough) file system file with the fuse_file.
> > >
> > > The file descriptor passed to the ioctl by the FUSE daemon is used to
> > > access the relative file pointer, that will be copied to the fuse_file
> > > data structure to consolidate the link between the FUSE and lower file
> > > system.
> > >
> > > To enable the passthrough mode, user space triggers the
> > > FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl and, if the call succeeds, receives
> > > back an identifier that will be used at open/create response time in the
> > > fuse_open_out field to associate the FUSE file to the lower file system
> > > file.
> > > The value returned by the ioctl to user space can be:
> > > - > 0: success, the identifier can be used as part of an open/create
> > > reply.
> > > - <= 0: an error occurred.
> > > The value 0 represents an error to preserve backward compatibility: the
> > > fuse_open_out field that is used to pass the passthrough_fh back to the
> > > kernel uses the same bits that were previously as struct padding, and is
> > > commonly zero-initialized (e.g., in the libfuse implementation).
> > > Removing 0 from the correct values fixes the ambiguity between the case
> > > in which 0 corresponds to a real passthrough_fh, a missing
> > > implementation of FUSE passthrough or a request for a normal FUSE file,
> > > simplifying the user space implementation.
> > >
> > > For the passthrough mode to be successfully activated, the lower file
> > > system file must implement both read_iter and write_iter file
> > > operations. This extra check avoids special pseudo files to be targeted
> > > for this feature.
> > > Passthrough comes with another limitation: no further file system
> > > stacking is allowed for those FUSE file systems using passthrough.
> > >
> > > Signed-off-by: Alessio Balsini <balsini@android.com>
> > > ---
> > >  fs/fuse/inode.c       |  5 +++
> > >  fs/fuse/passthrough.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 90 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index a1104d5abb70..7ebc398fbacb 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -1133,6 +1133,11 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
> > >
> > >  static int free_fuse_passthrough(int id, void *p, void *data)
> > >  {
> > > +       struct fuse_passthrough *passthrough = (struct fuse_passthrough *)p;
> > > +
> > > +       fuse_passthrough_release(passthrough);
> > > +       kfree(p);
> > > +
> > >         return 0;
> > >  }
> > >
> > > diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> > > index 594060c654f8..cf993e83803e 100644
> > > --- a/fs/fuse/passthrough.c
> > > +++ b/fs/fuse/passthrough.c
> > > @@ -3,19 +3,102 @@
> > >  #include "fuse_i.h"
> > >
> > >  #include <linux/fuse.h>
> > > +#include <linux/idr.h>
> > >
> > >  int fuse_passthrough_open(struct fuse_dev *fud,
> > >                           struct fuse_passthrough_out *pto)
> > >  {
> > > -       return -EINVAL;
> > > +       int res;
> > > +       struct file *passthrough_filp;
> > > +       struct fuse_conn *fc = fud->fc;
> > > +       struct inode *passthrough_inode;
> > > +       struct super_block *passthrough_sb;
> > > +       struct fuse_passthrough *passthrough;
> > > +
> > > +       if (!fc->passthrough)
> > > +               return -EPERM;
> > > +
> > > +       /* This field is reserved for future implementation */
> > > +       if (pto->len != 0)
> > > +               return -EINVAL;
> > > +
> > > +       passthrough_filp = fget(pto->fd);
> > > +       if (!passthrough_filp) {
> > > +               pr_err("FUSE: invalid file descriptor for passthrough.\n");
> > > +               return -EBADF;
> > > +       }
> > > +
> > > +       if (!passthrough_filp->f_op->read_iter ||
> > > +           !passthrough_filp->f_op->write_iter) {
> > > +               pr_err("FUSE: passthrough file misses file operations.\n");
> > > +               res = -EBADF;
> > > +               goto err_free_file;
> > > +       }
> > > +
> > > +       passthrough_inode = file_inode(passthrough_filp);
> > > +       passthrough_sb = passthrough_inode->i_sb;
> > > +       if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
> > > +               pr_err("FUSE: fs stacking depth exceeded for passthrough\n");
> >
> > No need to print an error to the logs, this can be a perfectly normal
> > occurrence.  However I'd try to find a more unique error value than
> > EINVAL so that the fuse server can interpret this as "not your fault,
> > but can't support passthrough on this file".  E.g. EOPNOTSUPP.
> >
> >
> 
> Sorry for the fashionably late response...
> Same comment for !{read,write}_iter case above.
> EBAFD is really not appropriate there.
> May I suggest ELOOP for s_stack_depth and EOPNOTSUPP
> for no rw iter ops.
> 
> Are you planning to post another version of the patches soon?
> 
> Thanks,
> Amir.

Hi Amir,

Thanks for your feedback. I like the ELOOP for the stack_depth, and the
EOPNOTSUPP is already in my local branch.

I've been busy with the integration of this last patchset in Android,
that unfortunately will be shipped as out-of-tree. I'm keeping all my
fingers crossed for my workarounds to prevent future passthrough UAPI
breakages to work. :)

I have an ugly patch which uses IDR as Miklos asked, but unfortunately
I'm facing some performance issues due to the locking mechanisms to keep
guarantee the RCU consistency. I can post the new patch set as an RFC
soon for the community to take a look.
At a glance what happens is:
- the IDR, one for each fuse_conn, contains pointers to "struct
  fuse_passthrough" containing:
  - fuse_file *: which is using passthrough,
  - file *: native file system file target,
  - cred of the FUSE server,
- ioctl(PASSTHROUGH_OPEN): updates IDR, requires spinlock:
  - kmalloc(fuse_passthrough), update file and cred,
  - ID = idr_alloc(),
  - return ID,
- fuse_open reply from FUSE server with passthrough ID: updates IDR,
  requires spinlock:
  - pt = idr_find(ID),
  - update fuse_file with the current fuse_file,
  - update fuse_file->passthrough_id = ID,
  - idr_replace(),
- read/write/mmap: lock-free IDR read:
  - idr_find(fuse_file::passthrough_id),
  - forward request to lower file system as for the current FUSE
    passthrough patches.
- ioctl(PASSTHROUGH_CLOSE): updates IDR, requires spinlock:
  - idr_remove();
  - call_rcu(): tell possible open fuse_file user that the ID is no more
    valid and kfree() the allocated struct;
- close(fuse_file): updates IDR, requires spinlock:
  - ID = fuse_file::passthrough_id
  - idr_find(ID),
  - fuse_passthrough::fuse_file = NULL,
  - idr_replace().

This would be fine if passthrough is activated for a few, big files,
where the passthrough overhead is dominated by the direct access
benefits, but if passthrough is enabled for many small files which just
do one or two read/writes (as what I did for my benchmark of total build
time for the kernel, where I was passing-through every opened file), the
overhead becomes a real issue.

If you have any thoughts on how to make this simpler, I'm absolutely
open to fix this.

We are also in the preliminary design step of having a hierarchical
passthrough feature, for which all the dir/file operations performed in
any of the contents of the passthrough folder, are automatically
forwarded to the lower file system.
That may fix this overhead issue, but it's still early to forecast what
is going to happen with this idea. Right now I'm not even sure it's
feasible.

Looking forward to receiving some feedback, thanks in advance!
Alessio
