Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EAE7A0F15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjINUkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 16:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjINUkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:40:02 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D913F2697
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 13:39:54 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5924093a9b2so16458007b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694723994; x=1695328794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaSIjMfdl0Gv6CgKXRD6SAmPWndDpWS6dyBZZ4689K4=;
        b=N5vvMHout599KVr+BGn43S8hqeXB+KRKk6fLGZeqH/6Sa/KHg2mV1dqbVR4OAGBegk
         Ji5qkNbtns/pRRU4ch0nMHYxILVIki++jUhPsRYJEzKDXwQ3uR6+euAmw7kIRxHk34NN
         t6m3FY6bN7ptMEUgR4bI3pPfJwdUF1GcsxBDRvFIsHARq4ZzeSAaeHrZD4DvmpJG2usa
         A6+OMkrr3cpHV9CqRMrtKpuRRz5Tz5V/koYSkndU4SRwuaxDvcx4LjBYwxfELnfuT5i3
         48NTSzk/fqv2BDjyvYRESc8yRbNb4U+EQY62len0BNjVClZ73w1Zao5CdVDH9iS4jADm
         eMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694723994; x=1695328794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaSIjMfdl0Gv6CgKXRD6SAmPWndDpWS6dyBZZ4689K4=;
        b=BDKqTHHvQ5wr9fGw3Ggfq2JCDjcHcsT/km26dHSb9OceEA1Ys0VeIWgfkW8YAHkFK4
         j5vRd2F679LaMWqIc7h2iU81EnOjlMmteVpQlUF3fszN04yqUXoEkrsE7PyfKJKfUP3c
         Ma4NoUkDUs7l/ZnaM4VQdWMP+HL9D7DoDsktedmFYxk0jVztrgLeyHbXf7MHE7FESc3F
         7JW6Wfuc8CDEgy30BcCv9kKdVfk3CTnsh9HCTeCFw1zEuIMgTolyhLdJVbxAdliCDQrw
         VJbwLVnMccsHVVHdZEniVunHjHcqdTdaz2TJQlMs0Cw7LHA69GUwoC1TCefzI0gqeeSB
         enpw==
X-Gm-Message-State: AOJu0YwASFtxYra/Ch7sN9mrFnavd5YaD0CtJfZIX0U/n9J58tsovz5b
        Ue6XMDzz23HE96atlFArOF0BE3YhBPWwCFhZlhKP
X-Google-Smtp-Source: AGHT+IHq8rrjq9tCJqLC7OfNa2hY3WISMCd4iUOBtPL6TwaHsYbzZZlii/9C2ThIbkYmqI7J/8s3pycN3nmMnaBACaI=
X-Received: by 2002:a0d:c942:0:b0:577:189b:ad4 with SMTP id
 l63-20020a0dc942000000b00577189b0ad4mr6892155ywd.48.1694723994051; Thu, 14
 Sep 2023 13:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
In-Reply-To: <20230913152238.905247-3-mszeredi@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Sep 2023 16:39:43 -0400
Message-ID: <CAHC9VhSQb0fYz9FqEu-1jQ1UNsnt-asrKuPt4ufui92GC+=5=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:23=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.co=
m> wrote:
>
> Add a way to query attributes of a single mount instead of having to pars=
e
> the complete /proc/$PID/mountinfo, which might be huge.
>
> Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
> needs to be queried based on path, then statx(2) can be used to first que=
ry
> the mount ID belonging to the path.
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
> above suggestion).  Allow querying multiple string attributes with
> individual offset/length for each.  String are nul terminated (terminatio=
n
> isn't counted in length).
>
> Mount options are also delimited with nul characters.  Unlike proc, speci=
al
> characters are not quoted.
>
> Link: https://lore.kernel.org/all/CAHk-=3Dwh5YifP7hzKSbwJj94+DZ2czjrZsczy=
6GBimiogZws=3Drg@mail.gmail.com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  fs/internal.h                          |   5 +
>  fs/namespace.c                         | 312 ++++++++++++++++++++++++-
>  fs/proc_namespace.c                    |  19 +-
>  fs/statfs.c                            |   1 +
>  include/linux/syscalls.h               |   3 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/mount.h             |  36 +++
>  8 files changed, 373 insertions(+), 9 deletions(-)

...

> diff --git a/fs/namespace.c b/fs/namespace.c
> index de47c5f66e17..088a52043bba 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c

...

> +static int do_statmnt(struct stmt_state *s)
> +{
> +       struct statmnt *sm =3D &s->sm;
> +       struct mount *m =3D real_mount(s->mnt);
> +
> +       if (!capable(CAP_SYS_ADMIN) &&
> +           !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> +               return -EPERM;

I realize statmnt() is different from fstatfs(), but from an access
control perspective they look a lot alike to me which is why I think
we should probably have a security_sb_statfs() call here.  Same thing
for the listmnt() syscall in patch 3/3.

> +       stmt_numeric(s, STMT_SB_BASIC, stmt_sb_basic);
> +       stmt_numeric(s, STMT_MNT_BASIC, stmt_mnt_basic);
> +       stmt_numeric(s, STMT_PROPAGATE_FROM, stmt_propagate_from);
> +       stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
> +       stmt_string(s, STMT_MOUNTPOINT, stmt_mountpoint, &sm->mountpoint)=
;
> +       stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
> +       stmt_string(s, STMT_SB_OPTS, stmt_sb_opts, &sm->sb_opts);
> +
> +       if (s->err)
> +               return s->err;
> +
> +       if (copy_to_user(s->buf, sm, min_t(size_t, s->bufsize, sizeof(*sm=
))))
> +               return -EFAULT;
> +
> +       return 0;
> +}

--=20
paul-moore.com
