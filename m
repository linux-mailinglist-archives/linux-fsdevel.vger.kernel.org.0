Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7DE35830C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 14:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhDHMP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhDHMP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:15:56 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430AEC061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 05:15:45 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id c15so1579464ilj.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 05:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lRvfRTscEJXEyXijoczXoMKeGFlkeYt6lKI4RETx/Bk=;
        b=KLB4CSdSQKv16RqgQPuBq1ovj/AVXzBeu/hGZNlOEkrUVlw9fPXaru6AFRurLPNIuE
         uiyOi9XIIWLQtG2SLWV9Nqp0LgzyO4S8ClEFFKM0jEEdQE75B7tF4HxTnDmcj6OySxCS
         ofUeoT93FRS5bmT7bQP7H/qEKYknEw9GUNLxbgMQSofrOl0LegrRlVNrbDVHm6N1BiqS
         UG5wwoaiNh4r+le3aSYAOoWJfGbx2GHPIC9dTP4GIWRKppdu9gUbHJZT4Nl9fWZE3v1P
         fVQcqCtjH9u1fMIAswJ4mUEZAdOeAPhVArWhyWgz+Kx920CbnNtEs6+bjmP6Xa3xlyM6
         lSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lRvfRTscEJXEyXijoczXoMKeGFlkeYt6lKI4RETx/Bk=;
        b=UopsvWYRYJ0dGQr+1Wd/banTTKeciUmPHcN+kHlhOLZ0wAEnnrgMH5qSujMYaw6M3R
         yWIk+4tRJp2XMqEvByWhC4/NzLaD2vync5jMD00oCqrzS6nhgUEHd3ZXn+WYo8F1tkrO
         s1aZI9w37JU1w6SilVhOiSwyDtzCZ98tiM5gj8DFdeeHKFQJgqkbyYDx5OTXcHcLyqAD
         DsO/JgV7YHk/jQv2OrJMsEU22vfamYX1y+RTkTKSE0bxZOlcvD8oE1PspQ9NZyChP2Eh
         NPOV6FmyDRFZ+a2IAWbC5g6WD27DTYnj2aV6SRFQ8R7JgULSM+5uhmTe3J8MOmf+vRPT
         DyVA==
X-Gm-Message-State: AOAM530+zkZ8XXQ45iwQqh5Hq5KqqX9WRll2HfNWzLwbV2E2ioVQR2HU
        e0qQSYEXT3HFVxLxQGpd+vyWq+cpSYVWRmcntQjC29nt7SM=
X-Google-Smtp-Source: ABdhPJx78bpzULJWdJolElryDH5R3oulwzoPVALocE0qLABGaGfqw0cnajxyrjuHhgSMyOQvbQcv7TKo+BxXNopy3z4=
X-Received: by 2002:a92:c54a:: with SMTP id a10mr1528676ilj.215.1617884144690;
 Thu, 08 Apr 2021 05:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200723185921.1847880-1-tytso@mit.edu> <CA+icZUU7Dqoc3-HeM5W4EMXzmZSetD+=WkavDgeGqAi4St6t3g@mail.gmail.com>
 <CA+icZUW1nybY==tV0sGDjZTOinR17Tpj3Eh3cjCtZXDOXXJAdw@mail.gmail.com>
In-Reply-To: <CA+icZUW1nybY==tV0sGDjZTOinR17Tpj3Eh3cjCtZXDOXXJAdw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 8 Apr 2021 14:15:20 +0200
Message-ID: <CA+icZUW5d+JCM=i-OF_hLyN+As14KFZ_4WN0np5AG080WeJuaA@mail.gmail.com>
Subject: Re: [PATCH] fs: prevent out-of-bounds array speculation when closing
 a file descriptor
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     viro@zeniv.linux.org.uk,
        Linux Filesystem Development List 
        <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 1:59 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 3:18 AM Sedat Dilek <sedat.dilek@gmail.com> wrote=
:
> >
> > On Thu, Jul 23, 2020 at 9:02 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > >
> > > Google-Bug-Id: 114199369
> > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> >
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # Linux v5.8-rc6+
> >
>
> Ping.
>
> What is the status of this patch?
>

Friendly ping again.

- Sedat -

>
> >
> > > ---
> > >  fs/file.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/fs/file.c b/fs/file.c
> > > index abb8b7081d7a..73189eaad1df 100644
> > > --- a/fs/file.c
> > > +++ b/fs/file.cfs: prevent out-of-bounds array speculation when closi=
ng a file descriptor
> > > @@ -632,6 +632,7 @@ int __close_fd(struct files_struct *files, unsign=
ed fd)
> > >         fdt =3D files_fdtable(files);
> > >         if (fd >=3D fdt->max_fds)
> > >                 goto out_unlock;fs: prevent out-of-bounds array specu=
lation when closing a file descriptor fs: prevent out-of-bounds array specu=
lation when closing a file descriptor fs: prevent out-of-bounds array specu=
lation when closing a file descriptor
> > > +       fd =3D array_index_nospec(fd, fdt->max_fds);
> > >         file =3D fdt->fd[fd];
> > >         if (!file)
> > >                 goto out_unlock;
> > > --
> > > 2.24.1
> > >
