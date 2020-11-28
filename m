Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4DF2C6E54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 03:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgK1B7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 20:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbgK1B63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 20:58:29 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABC2C0613D1;
        Fri, 27 Nov 2020 17:57:43 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s63so5587126pgc.8;
        Fri, 27 Nov 2020 17:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whvKGzUqUZSNINeh/F+7SKgvwSkGOhNp9JPcu0NpbpI=;
        b=mnrXKU4aGHsXQBffV6J+gqcnZjh8OcJURUVkOjGvrv1IMDEf4C5Hy2y7H7wfkQydXB
         yncP3ydpbT+/ziIoGTgSDj3SehtRyO4uJWJ3a0AlZYFGrO9g5L946gpdiHSv5dxSNaoL
         mvs5i3rbwZUBoAD8Qd6fC/hn32/zOIu/0I4NIIISyJ5UCNaGYgGJ3IS1V7Qbx62AfIOG
         GGKHAggiR6NQQklym6VIBqPlgCjeT7DSDlLbncuzyMVQmu3d2hAr8dK+UEBoBYhbN7PK
         MGK2owCkT5Nm7EGAsT6aP5XwyPtDoy6zg0lXuy1M0cipppaifbwogQZaRR1U5KWreaTd
         EJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whvKGzUqUZSNINeh/F+7SKgvwSkGOhNp9JPcu0NpbpI=;
        b=aEJDjAq5IeHwi2L/EG7d86PMGB/fy3EjdgWKEHMZZNrBc1a9w8FEo1gLYVJyn69zV0
         3SS1I4lKE/ieMRdneSMH5K7MIyrJD/nSPM8TQuQvDz67dM4SnZ9ATKN/508p7PkIPbH+
         Plm3FNGZIRr1kI8X5gOnQT4KYmd1dkGgYbomnHOFLVMkfc8TfRJ7MQkfjA3I5cPyKfA2
         /T9+Il9bz1+vxxtKXD3CGQl/lyPKRzZkgTIlSD/OBndbK9gEvzNHfroEODeJhT/oD5aO
         +21eKegq9/pa0k9UuKZ/BzBMcd9wlBmPBMF92EQsPSHpvhSza3IuuWc5o3jBaQxv5XLS
         DqCQ==
X-Gm-Message-State: AOAM531SdDX3GyH9JbZUuVs8t+tqInKVMVYbqwjqWa3WtZwcoq6M9aq9
        s4h+0WASifmSw0tfyzZRmuYus6iFQi0SMd7TbAg=
X-Google-Smtp-Source: ABdhPJw+5hWu1XmZZqKnFwnjWvFyQP3zTDNm1T0We3NohT/Oom1jIFwkoP8yM7vwDLvl8nI2DKJaBm8dGRkrqN0Ivk0=
X-Received: by 2002:a63:b516:: with SMTP id y22mr8939881pge.140.1606528662506;
 Fri, 27 Nov 2020 17:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20201026125016.1905945-1-balsini@android.com> <20201026125016.1905945-3-balsini@android.com>
 <CA+a=Yy4bhC-432h8shxbsrY5vjTcRZopS-Ojo0924L49+Be3Cg@mail.gmail.com> <20201127134123.GA569154@google.com>
In-Reply-To: <20201127134123.GA569154@google.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Sat, 28 Nov 2020 09:57:31 +0800
Message-ID: <CA+a=Yy6S9spMLr9BqyO1qvU52iAAXU3i9eVtb81SnrzjkCwO5Q@mail.gmail.com>
Subject: Re: [PATCH V10 2/5] fuse: Passthrough initialization and release
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 9:41 PM Alessio Balsini <balsini@android.com> wrote:
>
> Hi Peng,
>
> Thanks for the heads up!
>
> On Thu, Nov 26, 2020 at 09:33:34PM +0800, Peng Tao wrote:
> > On Tue, Oct 27, 2020 at 12:19 AM Alessio Balsini <balsini@android.com> wrote:
> > > [...]
> > >  int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
> > >                            struct fuse_open_out *openarg)
> > >  {
> > > -       return -EINVAL;
> > > +       struct inode *passthrough_inode;
> > > +       struct super_block *passthrough_sb;
> > > +       struct fuse_passthrough *passthrough;
> > > +       int passthrough_fh = openarg->passthrough_fh;
> > > +
> > > +       if (!fc->passthrough)
> > > +               return -EPERM;
> > > +
> > > +       /* Default case, passthrough is not requested */
> > > +       if (passthrough_fh <= 0)
> > > +               return -EINVAL;
> > > +
> > > +       spin_lock(&fc->passthrough_req_lock);
> > > +       passthrough = idr_remove(&fc->passthrough_req, passthrough_fh);
> > > +       spin_unlock(&fc->passthrough_req_lock);
> > > +
> > > +       if (!passthrough)
> > > +               return -EINVAL;
> > > +
> > > +       passthrough_inode = file_inode(passthrough->filp);
> > > +       passthrough_sb = passthrough_inode->i_sb;
> > > +       if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
> > Hi Alessio,
> >
> > passthrough_sb is the underlying filesystem superblock, right? It
> > seems to prevent fuse passthrough fs from stacking on another fully
> > stacked file system, instead of preventing other file systems from
> > stacking on this fuse passthrough file system. Am I misunderstanding
> > it?
>
> Correct, this checks the stacking depth on the lower filesystem.
> This is an intended behavior to avoid the stacking of multiple FUSE
> passthrough filesystems, and works because when a FUSE connection has
> the passthrough feature activated, the file system updates its
> s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH in process_init_reply()
> (PATCH 1/5), avoiding further stacking.
>
> Do you see issues with that?
I'm considering a use case where a fuse passthrough file system is
stacked on top of an overlayfs and/or an ecryptfs. The underlying
s_stack_depth FILESYSTEM_MAX_STACK_DEPTH is rejected here so it is
possible to have an overlayfs or an ecryptfs underneath but not both
(with current FILESYSTEM_MAX_STACK_DEPTH being 2). How about changing
passthrough fuse sb s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH + 1 in
PATCH 1/5, and allow passthrough_sb->s_stack_depth to be
FILESYSTEM_MAX_STACK_DEPTH here? So that existing kernel stacking file
system setups can all work as the underlying file system, while the
stacking of multiple FUSE passthrough filesystems is still blocked.

>
> What I'm now thinking is that fuse_passthrough_open would probably be a
> better place for this check, so that the ioctl() would fail and the user
> space daemon may decide to skip passthrough and use legacy FUSE access
> for that file (or, at least, be aware that something went wrong).
>
+1, fuse_passthrough_open seems to be a better place for the check.

> A more aggressive approach would be instead to move the stacking depth
> check to fuse_fill_super_common, where we can update s_stack_depth to
> lower-fs depth+1 and fail if passthrough is active and s_stack_depth is
> greater than FILESYSTEM_MAX_STACK_DEPTH.
>
The lower layer files/directories might actually spread on different
file systems. I'm not sure if s_stack_depth check is still possible at
mount time. Even if we can calculate the substree s_stack_depth, it is
still more flexible to determine on a per inode basis, right?

Cheers,
Tao
--
Into Sth. Rich & Strange
