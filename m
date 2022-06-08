Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746FF5426B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiFHGpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiFHGI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:08:26 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B279417CD3;
        Tue,  7 Jun 2022 22:14:49 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id q14so18642885vsr.12;
        Tue, 07 Jun 2022 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QBGwtKpyTYcwHawGkkLJIlVc8uYMzI2DXbLnehmXfbE=;
        b=SB0WOTvPTBDL580CNJpBSrVLBNq9/eKKCK8hLOT6KVBVv0TrGp2zn/JM1IUJQw6u9G
         eK8IYj3exswHjhWEXQrSbAZHl8f5WSnJ6kfjSaI8FwZM4nJ8zOM+lwXCPaFkazROYF+R
         hyhMO1E8boquWtsici45GjRKvi9pPRiAar2Ozft3hQec274g2MwkIgoEJD1Y9bByBJJf
         FVbLqu7oDS75iva6nVklYe4zTkwweuUxGq+mWeccpUXcr+xwOEKkmVfMcRpVbOkClACN
         5gYHGH9BHx2AY9PLsi+YeDZSFKy2I3p+HojZR8U2QLhLQ78UHqRbK+044hBz3mbTDBrB
         A1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QBGwtKpyTYcwHawGkkLJIlVc8uYMzI2DXbLnehmXfbE=;
        b=vfjEH6tL6pGAbJyASqQG5WbS/Ag5XyyI7q5UeULH5sX9JE0sFjtJkH9jsoIvlVZCKh
         H+K2jVlrn7AyYTinmHpl1EZpYMQgp9uI1eBE27mVvnvxVIZTkoyZKE6RBKzcKNYQoW0Q
         oBgxAsW+4AAH9KMwdFAUpD+ScMS9DzPBCxnZYpNPLwUberHgU6Kj9hPw5kwCBWJoWCIw
         +MitgL7bwvT5yNNL+dIURoo+PHs75qmfUfbQlIotq7jixvPiAZ6GJMeJCuzVDdAgeBor
         AJ0wHreZEFFc+4vJCbFqxzYQ4OryTTPyjp5/OCo7mjzW5rROBydLilIYQXd/0n91pWos
         xTOg==
X-Gm-Message-State: AOAM533uNSVOURNrmncryBxkn+g5cM8iCM2gyDhiRe/AUR4SO+fJPohb
        rdrkaIb68yT7TAMIeUrSeY8PmYuLprHG+MbxwYA=
X-Google-Smtp-Source: ABdhPJzt4gBGzWHwFbcparAl2vI/ut9cXMxIMjE1fE+uM8+vrXAB9MlTphllB1wBrc+bU0jzx0MMIHnKz47kUKFMKSQ=
X-Received: by 2002:a67:70c4:0:b0:349:d442:f287 with SMTP id
 l187-20020a6770c4000000b00349d442f287mr15008426vsc.2.1654665199165; Tue, 07
 Jun 2022 22:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
In-Reply-To: <20220607153139.35588-1-cgzones@googlemail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jun 2022 08:13:07 +0300
Message-ID: <CAOQ4uxhu3urLps09B8zxnJPJpQXO7g67mEv3yoPRKBeZRdJb7g@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alejandro Colomar <alx.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 8, 2022 at 5:23 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> Support file descriptors obtained via O_PATH for extended attribute
> operations.
>
> Extended attributes are for example used by SELinux for the security
> context of file objects. To avoid time-of-check-time-of-use issues while
> setting those contexts it is advisable to pin the file in question and
> operate on a file descriptor instead of the path name. This can be
> emulated in userspace via /proc/self/fd/NN [1] but requires a procfs,
> which might not be mounted e.g. inside of chroots, see[2].
>
> [1]: https://github.com/SELinuxProject/selinux/commit/7e979b56fd2cee28f64=
7376a7233d2ac2d12ca50
> [2]: https://github.com/SELinuxProject/selinux/commit/de285252a1801397306=
032e070793889c9466845
>
> Original patch by Miklos Szeredi <mszeredi@redhat.com>
> https://patchwork.kernel.org/project/linux-fsdevel/patch/20200505095915.1=
1275-6-mszeredi@redhat.com/
>
> > While this carries a minute risk of someone relying on the property of
> > xattr syscalls rejecting O_PATH descriptors, it saves the trouble of
> > introducing another set of syscalls.

The bitter irony is that we now want to add another set of syscalls ;-)

https://lore.kernel.org/linux-fsdevel/CAOQ4uxiqG-w8s+zRqk945UtJcE4u0zjPhSs=
=3DMSYJ0jMLLjUTFg@mail.gmail.com/

> >
> > Only file->f_path and file->f_inode are accessed in these functions.
> >
> > Current versions return EBADF, hence easy to detect the presense of
> > this feature and fall back in case it's missing.
>
> CC: linux-api@vger.kernel.org
> CC: linux-man@vger.kernel.org
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I think it is important to inspect this with consistency of the UAPI in min=
d.
What I see is that fchdir(), fcntl(), fstat(), fstatat() already accept O_P=
ATH
so surely they behave the same w.r.t old kernels and EBADF.
Those could all be better documented in their man pages.

w.r.t permission checks, this is no different than what *xattr() variants
already provide.

Therefore, I see no reason to object to this UAPI change.

You may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/xattr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e8dd03e4561e..16360ac4eb1b 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -656,7 +656,7 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathn=
ame,
>  SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
>                 const void __user *,value, size_t, size, int, flags)
>  {
> -       struct fd f =3D fdget(fd);
> +       struct fd f =3D fdget_raw(fd);
>         int error =3D -EBADF;
>
>         if (!f.file)
> @@ -768,7 +768,7 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathn=
ame,
>  SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
>                 void __user *, value, size_t, size)
>  {
> -       struct fd f =3D fdget(fd);
> +       struct fd f =3D fdget_raw(fd);
>         ssize_t error =3D -EBADF;
>
>         if (!f.file)
> @@ -844,7 +844,7 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, path=
name, char __user *, list,
>
>  SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
>  {
> -       struct fd f =3D fdget(fd);
> +       struct fd f =3D fdget_raw(fd);
>         ssize_t error =3D -EBADF;
>
>         if (!f.file)
> @@ -910,7 +910,7 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pa=
thname,
>
>  SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
>  {
> -       struct fd f =3D fdget(fd);
> +       struct fd f =3D fdget_raw(fd);
>         int error =3D -EBADF;
>
>         if (!f.file)
> --
> 2.36.1
>
