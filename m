Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055E178CBE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjH2SPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjH2SOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:14:50 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6097BBE
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 11:14:47 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-44d4d997dcfso1890821137.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693332886; x=1693937686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoRqN8B8TnnGakxHs7Ejq5xGab2BV/t8G+EwY34+qUE=;
        b=kjxJ4IaOA1ATEuL3DwtA2BbGwxkcdujSVkcj+k5HQ3/+UUE/JoYgnKl5uo7SmEwVbR
         ni1LizyGncxxKC7nCbgPsWY2WqWtSBbxXCVnqMp80QBnMyNNbQdO8XqCyWDNvdKMqsWH
         AuvGOt41RnIpyIBZsfkjsCvfJDbgdrhLlGAOPtxN1xaxUBmrh/NaGIfihnPcWhAsGoMn
         dyKyBJYbFeYoIiSIqYooYnM01qHzncB2CvJJbJCXTDKqjNjSpBPM9u4ZX9+heW5cbfGR
         cfHKz91wtpg3ZyqPtlTqJ7BzQFEYaXlJcWQ+nBcvSjzZVo+67FLcGTH/jHaouibdRIxO
         lJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693332886; x=1693937686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoRqN8B8TnnGakxHs7Ejq5xGab2BV/t8G+EwY34+qUE=;
        b=cU8JCPgV3EGfl5mmsci33FX84KYCiJvYDzOCh+np9aaMJzPXA6421cdH9w+KdzjkJf
         GD+bxY/YO+3Gjx7J1mIfhcPQk2nmWDwbHl8n/H5jLyQaR9pkeUo1FYpY3fhXd/m4ERlD
         kbfWNloOVThoUCDVmkzSk1izfNHWAeRZYb5SGB0yPOssyLbKz7E8d2/v6IHSspoxm2Kt
         nkDVgbr3y0i1rk8Dj4NRgZNWZTLWR135S/LB2ejZo0WcO1r9NP1gRJKp6MdZ90UhhbBM
         Gt1N7nRqbmt9PM6Qd0lM+/1Ftq81qvqAuChRlN5xapeIlkIScvIVnNJTohVeGtnR/wHn
         /dRw==
X-Gm-Message-State: AOJu0YyiNouG5K9dm7ixKDHrdgJ+EYUeVjNNVToz2Xlv0+NQZOyOvlm4
        wCN/ZMSVIYoaborrtW2aLj0w29hp3Agtk9wsoxo=
X-Google-Smtp-Source: AGHT+IESRgYoukwCaXEJbDkbgl4U2MSc0BgoKzSZxhpxeM5AXtQYcnNziuizuhHVsMsdqYrfXVDsl53Acsss3tEAQ+k=
X-Received: by 2002:a67:ffc5:0:b0:44d:4d7f:bcc4 with SMTP id
 w5-20020a67ffc5000000b0044d4d7fbcc4mr12586vsq.5.1693332886352; Tue, 29 Aug
 2023 11:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com> <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
In-Reply-To: <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 29 Aug 2023 21:14:35 +0300
Message-ID: <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
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

On Tue, Jun 6, 2023 at 4:06=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 6 Jun 2023 at 13:19, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Jun 6, 2023 at 12:49=E2=80=AFPM Miklos Szeredi <miklos@szeredi.=
hu> wrote:

[...]

> > >    I'm not sure that the per-file part of this is necessary, doing
> > > everything per-inode should be okay.   What are the benefits?
> > >
> >
> > I agree that semantics are simpler with per-inode.
> > The only benefit I see to per-file is the lifetime of the mapping.
> >
> > It is very easy IMO to program with a mapping scope of
> > open-to-close that is requested by FOPEN_PASSTHROUGH
> > and FOPEN_PASSTHROUGH_AUTO_CLOSE.
>
> Right, and this case the resource limiting is also easy to think about.
>
> I'm not worried about consistency, fuse server can do whatever it
> wants with the data anyway.  I am worried about the visibility of the
> mapping.  One idea would be to create a kernel thread for each fuse sb
> instance and install mapped files into that thread's file table.  In
> theory this should be trivial as the VFS has all the helpers that can
> do this safely.
>

Sounds doable.
I will look into this after I get the basics sorted out.

> >
> > I think if I can make this patch set work per-inode, the roadmap
> > from here to FUSE-BPF would be much more clear.
>
> One advantage of per-inode non-autoclose would be that open could be
> done without a roundtrip to the server.   However the resource
> limiting becomes harder to think about.
>
> So it might make sense to just create two separate modes:
>
>  - per-open unmap-on-release (autoclose)
>  - per-inode unmap-on-forget (non-autoclose, mapping can be torn down
> explicitly)
>

[...]

> > In summary, I will try to come up with v14 that is:
> > - privileged user only
> > - no resource limitation
> > - per-inode mapping
>
> Okay, that's a logical first step.

I said that I would try to start with per-inode operation mode,
but I realize that it does not meet one of my basic project requirements -
I need to be able to passthrough some of the fds of the same inode,
but not all of them.

I was thinking of a slightly different model that could (possibly)
unify those two modes and be flexible enough to be extended with
BPF filters going forward.

The model is based on per-inode association to backing fd.

1. A single association (mapping) can created per-inode using ioctl
 - There is no mapping id - the inode either has a backing_fd or not
 - Trying to set another backing_fd for inode gets EEXIST if one exists
 - A backing_fd can be torn with ioctl
 - The backing_fd is of course auto-closed on forget

2. The backing_fd association itself does not cause any passthrough!
 - Passthrough operations need to be opt-in independently of mapping
   the backing_fd
 - Down the road, passthrough operation mask could be setup in the
   mapping
 - Down the road, a BPF program to decide on passthrough operation
   could be setup in the mapping as the BPF patches intended

3. Initially, the only way to opt-in to passthrough read/write operations
    is by passing the FOPEN_PASSTHROUGH flag on open
 - FOPEN_PASSTHROUGH will have no effect if backing_fd wasn't
   mapped beforehand
 - As long as there are FUSE files open with FOPEN_PASSTHROUGH,
   the inode's backing_fd cannot be unmapped
 - If a file is opened with FOPEN_PASSTHROUGH_AUTOCLOSE,
   when that file is closed, *if it is the last file referencing* the inode=
,
   the backing_fd is auto-closed

This is not as flexible as being able to map each FUSE fd to a different
backing_fd.

In the future, FUSE fds could have their own individual backing_fd if
needed, but for now, I think that starting with a single shared backing_fd
with per-fd opt-in on open, would be simpler to implement, but still useful=
.

One obvious downside of the shared backing_fd approach is that
if FUSE fds are a mix of O_RDONLY and O_WRONLY, the shared
backing_fd needs to be setup as O_RDWR in advance.

I think this is not such a strict limitation for the first implementation,
since we anyway agreed that the first implementation would require
the server to be privileged.

Do you think this is an acceptable first step?

Thanks,
Amir.
