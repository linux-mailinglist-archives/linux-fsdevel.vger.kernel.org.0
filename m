Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1D12EF2C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 14:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbhAHNAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 08:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAHNAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:00:12 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18991C0612F4
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 04:59:32 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q5so10108106ilc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 04:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WYSaHM9r6uysAUvp9nyuEks2t9hNctkID59kc9VK5xc=;
        b=DaytoU/08EfN4newYg6SISoZxOQpuYFcUPpBctAjrxRLJxlcYgMolSqJGd/y+Y0tqC
         suQsgUXvYuy3jzsI6x4OoRmc+Oru+FvEAd0QfZSb+n+ZPa81FxKA+m7JIF2YgCWcDOnx
         44X2Ke/1ljrczvALEDiDNquDhUSyYP2PucSQk6AoX1u/Yc9r8kkEHtCOobY+noifTzLZ
         OGlNfbMO9rz0UIzSPqWz+/mJaZk7brTt41IvILvqrAcmUz2Hxl6aVdcLwHWr+DFBfpHK
         /E1Eqm58/0Ctyiv/kECAURGJ+jgWMWdFTNuL4kv0qK70fYMkcczJL4drarcPu+DfNKHD
         ANog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WYSaHM9r6uysAUvp9nyuEks2t9hNctkID59kc9VK5xc=;
        b=oq/FIN5UMQgndWPXa6u1TSeYmwBbG/vvk5pxtbPf24ttT25jtBPIgc6oegQXJya/FR
         kvDyJZd3Z3ECpt/oAUtJqNPNsueLU7/gsM3x5f8STGsyB8zkFoN0fy6eCpxZuoIoAiMc
         8YJFNAy7Qx6vtevytB1Q+jMiXr7mHhAbzwWc3UQRl137QDwO7xwXdsecCn/ayBb8uerR
         AQLKUzaQ1vMXOtNDWEGb5NuiShV5nbshxHfyRL8TGgYY+L0yzBZWk/wGE6hkBiJtyedE
         cu3KbEYf7xaO1vRpWphM+Z5k5MIfmCItQkhlIpdaWDb3KbjB8bai7AL2fdab812SNyM+
         8l4w==
X-Gm-Message-State: AOAM532OOVuMfycidWhxEhNyp9LXjqlgGqMmyG7uPq5caUleqJh3uEnn
        iC0WmQ954H+8n6GkKT4mq4Z7pELepPPox/OeaTBa8+M+TL1Y7w==
X-Google-Smtp-Source: ABdhPJxtQ7Ru6seXvIxshFbsGin60gvekD7Zn1Ol0reBkUYTJH+drKgiQjb9YFodZ29Mdif5my57rPfX8IbaojO0K2I=
X-Received: by 2002:a05:6e02:1a43:: with SMTP id u3mr3612508ilv.209.1610110771515;
 Fri, 08 Jan 2021 04:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20200723185921.1847880-1-tytso@mit.edu> <CA+icZUU7Dqoc3-HeM5W4EMXzmZSetD+=WkavDgeGqAi4St6t3g@mail.gmail.com>
In-Reply-To: <CA+icZUU7Dqoc3-HeM5W4EMXzmZSetD+=WkavDgeGqAi4St6t3g@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 8 Jan 2021 13:59:20 +0100
Message-ID: <CA+icZUW1nybY==tV0sGDjZTOinR17Tpj3Eh3cjCtZXDOXXJAdw@mail.gmail.com>
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

On Fri, Jul 24, 2020 at 3:18 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Jul 23, 2020 at 9:02 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Google-Bug-Id: 114199369
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # Linux v5.8-rc6+
>

Ping.

What is the status of this patch?

 - Sedat -

>
> > ---
> >  fs/file.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index abb8b7081d7a..73189eaad1df 100644
> > --- a/fs/file.c
> > +++ b/fs/file.cfs: prevent out-of-bounds array speculation when closing=
 a file descriptor
> > @@ -632,6 +632,7 @@ int __close_fd(struct files_struct *files, unsigned=
 fd)
> >         fdt =3D files_fdtable(files);
> >         if (fd >=3D fdt->max_fds)
> >                 goto out_unlock;fs: prevent out-of-bounds array specula=
tion when closing a file descriptor fs: prevent out-of-bounds array specula=
tion when closing a file descriptor fs: prevent out-of-bounds array specula=
tion when closing a file descriptor
> > +       fd =3D array_index_nospec(fd, fdt->max_fds);
> >         file =3D fdt->fd[fd];
> >         if (!file)
> >                 goto out_unlock;
> > --
> > 2.24.1
> >
