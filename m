Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BAC7B8D62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjJDT0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjJDT0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:26:40 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEC3AD
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 12:26:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d865685f515so1232518276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696447595; x=1697052395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNtOw2zMeICJpsM+W2CmdJ9g0vBMt1nGnueozCmL+A4=;
        b=GfjOpnhj1vdKHS5of/zaqv1fOPr+VgZCxdsnGEpuNKNXCAsfniLQVPfdCN6S2XK2wP
         EHLwXGrXFS5A6sTUBoovXrJEmO6JqqHBBY+z1B3PNEv7ZiWGUO5R9wrH34kG/Gs6ryyg
         7yDENMRdXNCRJprDDhNT6QRbtcP6aRy/C5i7vXpwssRf0hAOWjvnKdlLGF8GnMVu/hd7
         Uif3NQu2d6H5WVIqU+GzCVRoe7ddiy6gh2GoUNW8mozMvUGBX4ENvhYRKMp4fCUtQuWJ
         ONOo6g0giEth4/yH0wtx2Vegm0iLqwH/Q3969gcRQDhotrC6SlXw861gN9ktD7BZyObg
         7imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447595; x=1697052395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNtOw2zMeICJpsM+W2CmdJ9g0vBMt1nGnueozCmL+A4=;
        b=ZwRdck4tk8j+lnA8aSOGst1pdoVbxnXJj2iJ/JJCmM5ERlbFy+Kt2PzgFOVSZQ+C5d
         03MacDpj0yfE86cvaTeHsj0prJAqXMC0eId1RT3hCiMggasgEe0Kol72JjfGuw+uPotV
         +SQk330ohVaJYWvpceor/Gii3mC3Cj7sarOHXtUCltZKp0IiRZDS3J3xDQNN28sExmwn
         7JiVZT27BPS3dMV6GPkSHxdIjZZrqFAd+8rQ7yYnFyXc6sL1p0kmBtJxB9ndIrR89TQ2
         U8p62FY60XdNkuiEszMqGV4lhyb/KQ4j8hCKTFjpbDoiBbiO9m89sxQWkEuq0V3NHQbx
         0bLA==
X-Gm-Message-State: AOJu0YzPZzYGJZ7l8UACcq3ZLQasNWwvtppcDySufn/8CpYqQO4s2dYj
        i/i1lHcNnLdZ5gy00ywaFlGyap+wA9tA7sLwqS24
X-Google-Smtp-Source: AGHT+IFgQ7KZulHqW46gnSInyJ+hza/7XB/qpXUHTrPS/mp0lJLZMqv7XZDUdzy8LdR5GaTKoIzODIK9K08t+Z+ygNE=
X-Received: by 2002:a5b:a44:0:b0:d86:4342:290 with SMTP id z4-20020a5b0a44000000b00d8643420290mr568657ybq.21.1696447595426;
 Wed, 04 Oct 2023 12:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-4-mszeredi@redhat.com>
In-Reply-To: <20230928130147.564503-4-mszeredi@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Oct 2023 15:26:24 -0400
Message-ID: <CAHC9VhQxMHBiB--QuV-g6ffghdN-G4N0fX3i-v+z-nc9n1p49A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] add statmount(2) syscall
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 9:03=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Add a way to query attributes of a single mount instead of having to pars=
e
> the complete /proc/$PID/mountinfo, which might be huge.
>
> Lookup the mount the new 64bit mount ID.  If a mount needs to be queried
> based on path, then statx(2) can be used to first query the mount ID
> belonging to the path.
>
> Design is based on a suggestion by Linus:
>
>   "So I'd suggest something that is very much like "statfsat()", which ge=
ts
>    a buffer and a length, and returns an extended "struct statfs" *AND*
>    just a string description at the end."
>
> The interface closely mimics that of statx.
>
> Handle ASCII attributes by appending after the end of the structure (as p=
er
> above suggestion).  Pointers to strings are stored in u64 members to make
> the structure the same regardless of pointer size.  Strings are nul
> terminated.
>
> Link: https://lore.kernel.org/all/CAHk-=3Dwh5YifP7hzKSbwJj94+DZ2czjrZsczy=
6GBimiogZws=3Drg@mail.gmail.com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  fs/namespace.c                         | 283 +++++++++++++++++++++++++
>  fs/statfs.c                            |   1 +
>  include/linux/syscalls.h               |   5 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/mount.h             |  56 +++++
>  7 files changed, 351 insertions(+), 1 deletion(-)

...

> diff --git a/fs/namespace.c b/fs/namespace.c
> index c3a41200fe70..3326ba2b2810 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c

...

> +static int do_statmount(struct stmt_state *s)
> +{
> +       struct statmnt *sm =3D &s->sm;
> +       struct mount *m =3D real_mount(s->mnt);
> +       size_t copysize =3D min_t(size_t, s->bufsize, sizeof(*sm));
> +       int err;
> +
> +       err =3D security_sb_statfs(s->mnt->mnt_root);
> +       if (err)
> +               return err;

Thank you for adding the security_sb_statfs() call to this operation,
however I believe we want to place it *after* the capability check to
be consistent with other LSM calls.

> +       if (!capable(CAP_SYS_ADMIN) &&
> +           !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> +               return -EPERM;
> +
> +       stmt_numeric(s, STMT_SB_BASIC, stmt_sb_basic);
> +       stmt_numeric(s, STMT_MNT_BASIC, stmt_mnt_basic);
> +       stmt_numeric(s, STMT_PROPAGATE_FROM, stmt_propagate_from);
> +       stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
> +       stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
> +       stmt_string(s, STMT_MNT_POINT, stmt_mnt_point, &sm->mnt_point);
> +
> +       if (s->err)
> +               return s->err;
> +
> +       /* Return the number of bytes copied to the buffer */
> +       sm->size =3D copysize + s->pos;
> +
> +       if (copy_to_user(s->buf, sm, copysize))
> +               return -EFAULT;
> +
> +       return 0;
> +}

--=20
paul-moore.com
