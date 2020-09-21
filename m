Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D5F27249B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 15:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIUNII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 09:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgIUNII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:08:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B83C061755;
        Mon, 21 Sep 2020 06:08:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y13so15256768iow.4;
        Mon, 21 Sep 2020 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0Jv0CLGJ4DfZHttNSCtLSVitK8nvs/atSVnSKAM6bs=;
        b=hsaWX9w5jMWlEZ96TVclL1PoprwTmY7ooxwDz3mUg1vUN64DaieSMlteLKi2A5qIEJ
         SWVpndESE8A6SD41i4YOcJIiaxBMPL05K7T4wnGyDKoSDFhUQsO7Yh1BRfAU2V7MUej/
         Va4TIO99JMW3cfn8UU71F/zM38ku/Q6tyaxPxyStiRsXoe2GeAJol52X6n9ud+9VRB+g
         W2rkhOpgFpYnaxhhwSuCTvjiOEWapsoVLAC75wyp0w7golWOyIrOo3OaAPyQ0lgjayBS
         YxiLwXddUs8fvWYj8TuHSCXrMPIxY3pYcC866G07ivPt4JXJHIdO+9Ndhm6K55BUqE+a
         4a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0Jv0CLGJ4DfZHttNSCtLSVitK8nvs/atSVnSKAM6bs=;
        b=EgFaZLVPyLSTNiuSaHVQkypwGabJFIaP52Jxd+bdvCe+lB6L9J/ZhAzrxPdM7rJGxh
         geDXGw2DfS9+mfS8w/oFWhckwnhpgLxqJp6zVkfJyewL6J13k91vLaSIhR3D9XK5GF8d
         3RAxHpUkHPFz+L5h+/x0sWy4e07gkCmtJcm8e7iaKocj3Ny97y8cJWptlu+K9gIXg8U3
         SDD2P1Q1r41hKtFDodl9STNSiEEj7lINqjDbF24i0TB7j2JaugsFehHVFkhRreWWYdpd
         SfWI9MqGKmVQv9P8u0ildQU/892pmLJeqRx66Zu8riIYcHNQVqhq6uji79fTDptnqYVm
         SfMA==
X-Gm-Message-State: AOAM530STHH3RWM7ue0+xdbTBauuLAIieaHQyrswiypTt/53lnBBiXEN
        t0UwEBK+Y7WPUblxKxmJRDbxj1+BuVXWrfg6d3Y=
X-Google-Smtp-Source: ABdhPJzfEhuHujTa3hefuqudWxZ/EKDNycHeqfbn3emhF0Wj5zn21IHdIbr1kW809gDv6sFlFQc+YU6+GbZwEs3v3So=
X-Received: by 2002:a02:76d5:: with SMTP id z204mr37834534jab.93.1600693687349;
 Mon, 21 Sep 2020 06:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200911163403.79505-1-balsini@android.com> <20200911163403.79505-3-balsini@android.com>
 <CAOQ4uxhxiuZV3LVk=ihqt4S7ktNK=gZcyLh19iZ1+je0fhc3Uw@mail.gmail.com> <20200921110156.GC3385065@google.com>
In-Reply-To: <20200921110156.GC3385065@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 21 Sep 2020 16:07:56 +0300
Message-ID: <CAOQ4uxhA+6+m0GTWiaRLC090FCngVYHJv62TCPNNSWzVkdQjgg@mail.gmail.com>
Subject: Re: [PATCH V8 2/3] fuse: Introduce synchronous read and write for passthrough
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

On Mon, Sep 21, 2020 at 2:01 PM Alessio Balsini <balsini@android.com> wrote:
>
> Hi Amir,
>
> On Sat, Sep 12, 2020 at 12:55:35PM +0300, Amir Goldstein wrote:
> > On Fri, Sep 11, 2020 at 7:34 PM Alessio Balsini <balsini@android.com> wrote:
> > > +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> > > +                                  struct iov_iter *iter)
> > > +{
> > > +       ssize_t ret;
> > > +       struct file *fuse_filp = iocb_fuse->ki_filp;
> > > +       struct fuse_file *ff = fuse_filp->private_data;
> > > +       struct file *passthrough_filp = ff->passthrough_filp;
> > > +
> > > +       if (!iov_iter_count(iter))
> > > +               return 0;
> > > +
> > > +       if (is_sync_kiocb(iocb_fuse)) {
> > > +               struct kiocb iocb;
> > > +
> > > +               kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> > > +               ret = call_read_iter(passthrough_filp, &iocb, iter);
> > > +               iocb_fuse->ki_pos = iocb.ki_pos;
> > > +               if (ret >= 0)
> > > +                       fuse_copyattr(fuse_filp, passthrough_filp, false);
> > > +
> > > +       } else {
> > > +               ret = -EIO;
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
> > > +                                   struct iov_iter *iter)
> > > +{
> > > +       ssize_t ret;
> > > +       struct file *fuse_filp = iocb_fuse->ki_filp;
> > > +       struct fuse_file *ff = fuse_filp->private_data;
> > > +       struct inode *fuse_inode = file_inode(fuse_filp);
> > > +       struct file *passthrough_filp = ff->passthrough_filp;
> > > +
> > > +       if (!iov_iter_count(iter))
> > > +               return 0;
> > > +
> > > +       inode_lock(fuse_inode);
> > > +
> > > +       if (is_sync_kiocb(iocb_fuse)) {
> > > +               struct kiocb iocb;
> > > +
> > > +               kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> > > +
> > > +               file_start_write(passthrough_filp);
> > > +               ret = call_write_iter(passthrough_filp, &iocb, iter);
> >
> > Why not vfs_iter_write()/vfs_iter_read()?
> >
> > You are bypassing many internal VFS checks that seem pretty important.
> >
>
> I've been thinking a lot about this and decided to go for the VFS bypassing
> solution because:
> 1. it looked odd to me to perform VFS checks twice, both for FUSE and lower
>    FS and it seemed to me that we found a tradeoff with Jann about doing
>    this lower FS call, and
> 2. in our Android use case (I just saw you asking for more details about
>    this in, I'll reply on the other thread), the user might have the right
>    credentials to access the FUSE file system, but not to access the lower
>    file system, so the VFS checkings would fail. So that would have created
>    the need for a credential bypassing that looked hacky.
>
> But I agree and I would probably sleep better knowing that VFS checks are
> not skipped :) So I decided to implemented the vfs_iter_{read,write}()
> variant.
>
> I again picked a lot from the overlayfs solution. In a few words, I get the
> FUSE daemon credential reference at FUSE FS creation time and, when
> passthrough read/write operations are triggered, the kernel temporarily
> overrides the requesting process' credentials with those of the FUSE
> daemon. Credentials are reverted as soon as the operation completes.
>
> I have a temporary development branch where I'm developing the V9 of this
> patch, plus the VFS variant (git history may change):
>
> https://github.com/balsini/linux/tree/fuse-passthrough-stable-v5.8-v9-vfs
>
> For now, I'm happy to say that I like this VFS solution, it also simplified
> the lower file system notifications, so I'll probably go with this in the
> V9.
>

I am happy this direction was workable, not because the overlayfs solution
is perfect, but because it already has decent mileage running into strange
corner cases and fixing them.

But I also think it is better when fuse driver performs actions on behalf
of the server, that it uses the server's credential, because this way,
the passthrough fd code path behaves logically closer to the non-passthrough
code, only (hopefully) faster.

Thanks,
Amir.
