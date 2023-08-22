Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F67841EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjHVNWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 09:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjHVNWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:22:39 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6750CEB;
        Tue, 22 Aug 2023 06:22:34 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-79dea64c428so1316997241.3;
        Tue, 22 Aug 2023 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692710553; x=1693315353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZiAVsDpb/EogH9eLF3AXPNbgSh0YM/k8XU96DkY0Sc=;
        b=GexZpJBw2Ptr/Nu8mEFiGOpENH5+euv6N1kIlB6BRJxCjT2wgXwzb8Kd1gi/kj69mS
         rFI4a6NFlC6+Qg3VyvKbydEwkJ8RR47QQ/evJvzniVCMnOcbKAfdQn/4gpQyWcn/rOgt
         Ng2T9O+9DsOQObJNumfS7iLHXH6MSOZoIxwMVl/8mYj0fuPztV2MdK1G6Rc3vP4QkSNt
         luKpTKhcnB4FbAa+ExRfZQkIBv02Xe4Yueint5zhiooPEBZtTyyW0jCQ53yL4L8UT7Bb
         4jaIs4o86cXKUxFyy5o286VAOv5Lqmfc+fTcFH0h2EnZMDZ0VbJEogkg14ovZBs273xr
         6EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710553; x=1693315353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZiAVsDpb/EogH9eLF3AXPNbgSh0YM/k8XU96DkY0Sc=;
        b=CnGbxST14E4BDSJvI++lRwoUIkCHodS30bplm41+dE5oyqi6GV+hfRbjp2/4GWaKj9
         oxsv9jEfC1vDBMORQRvyP1dBYWFo8CawUdOAlxFvxUWYTMYme4bmlRkoc0ru1syyl2uG
         33liXaTIHFf0BSnTRvNkocKgi17uYZHIvOXTK14TE0rvGLJyv/3TJFKGspLLDBID9jz1
         ygLz7O0+UISCCRMSWX4U4Xn151q1njoI2oIatQ749GDKBcm5hzHIuFABSrdjAWzwggPs
         ya3OG1+WeB5yi0WzRzk7FLiXJmaFlnvA8QkSQG6Nktv1JDIOpoa6BGiwaZ7gNPWnlLVq
         +5Mw==
X-Gm-Message-State: AOJu0YxnahH4XjD+gEhT9B2y91WP5LCtTC8DHvvrrZjWt5YzdjOpszhL
        I3SaSZOHfXdsDOaqK6wgUtmbuuLJxLCgqArfFv9vEZR7cQxevw==
X-Google-Smtp-Source: AGHT+IFvTPBD9DUnhL1ZjtKzrlpt4XtLgDV2PpHPukY7zxoWU1Ie+MKdrKD5nCu+U2QpTtY8/Ih1T+mjjqbamnXKCBs=
X-Received: by 2002:a67:f3d7:0:b0:447:4cb2:74fb with SMTP id
 j23-20020a67f3d7000000b004474cb274fbmr7325909vsn.19.1692710553622; Tue, 22
 Aug 2023 06:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-6-amir73il@gmail.com>
 <CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWwRFEAUgnUcQ@mail.gmail.com>
 <CAOQ4uxhYZqe0-r9knvdW_BWNvfeKapiwReTv4FWr_Px+CB+ENw@mail.gmail.com>
 <CAOQ4uxhBeFSV7TFuWXBgJZuu-eJBjKcsshDdxCz-fie0MqwVcw@mail.gmail.com>
 <CAOQ4uxirdrsaHPyctxRgSMxb2mBHJCJqB12Eof02CnouExKgzQ@mail.gmail.com> <CAJfpegth3TASZKvc_HrhGLOAFSGiAriiqO6iCN2OzT2bu62aDA@mail.gmail.com>
In-Reply-To: <CAJfpegth3TASZKvc_HrhGLOAFSGiAriiqO6iCN2OzT2bu62aDA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Aug 2023 16:22:22 +0300
Message-ID: <CAOQ4uxjU5D=BmLe66NyG_qGWk8rhZGKx+BCZmJQmhQOdCSw+1g@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] fuse: Handle asynchronous read and write in passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 22, 2023 at 2:03=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 22 Aug 2023 at 12:18, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Aug 21, 2023 at 6:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
>
> > > Getting back to this.
> > > Did you mean something like that? (only compile tested)
> > >
> > > https://github.com/amir73il/linux/commits/backing_fs
> > >
> > > If yes, then I wonder:
> > > 1. Is the difference between FUSE_IOCB_MASK and OVL_IOCB_MASK
> > >     (i.e. the APPEND flag) intentional?
>
> Setting IOCB_APPEND on the backing file doesn't make a difference as
> long as the backing file is not modified during the write.
>
> In overlayfs the case of the backing file being modified is not
> defined, so I guess that's the reason to omit it.  However I don't see
> a problem with setting it on the backing file either, the file
> size/position is synchronized after the write, so nothing bad should
> happen if the backing file was modified.
>
> > > 2. What would be the right way to do ovl_copyattr() on io completion?
> > >     Pass another completion handler to read/write helpers?
> > >     This seems a bit ugly. Do you have a nicer idea?
> > >
>
> Ugh, I missed that little detail.   I don't have a better idea than to
> use a callback function.
>
> >
> > Hmm. Looking closer, ovl_copyattr() in ovl_aio_cleanup_handler()
> > seems a bit racy as it is not done under inode_lock().
> >
> > I wonder if it is enough to fix that by adding the lock or if we need
> > to resort to a more complicated scheme like FUSE_I_SIZE_UNSTABLE
> > for overlayfs aio?
>
> Quite recently rename didn't take inode lock on source, so
> ovl_aio_cleanup_handler() wasn't the only unlocked instance.
>
> I don't see a strong reason to always lock the inode before
> ovl_copyattr(), but I could be wrong.
>

IDK, ovl_copyattr() looks like a textbook example of a race
if not protected by something because it reads a bunch of stuff
from realinode and then writes a bunch of stuff to inode.

Anyway, I guess it wouldn't hurt to wrap it with inode_lock()
in the ovl completion callback.

Thanks,
Amir.
