Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60A27B098F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjI0QDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI0QDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:03:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6996491;
        Wed, 27 Sep 2023 09:03:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a64619d8fbso1481336066b.0;
        Wed, 27 Sep 2023 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695830623; x=1696435423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji/hBwx8+isn2luTSLK88rkw0mw2KsvkgWhx3gQ5C1A=;
        b=SuhKstCZCjlKLeIa600rlLEAIBrcuCWl0L8aA9A5Y/R5Vh7l1XAzDgDvQU/xp1MzEc
         OM4WHogcpapx+OzKot0Rhk6pp1GkpuoqO9VSh0dRm8A6U5qz0CkHqp4au9llthiDOwC2
         1qI1sI19jYrDOnab6UOVzuKqLisjlDA8T6QNkosRBTxaX1U4C+dvOCOEdbJjXQaR5+4Z
         eaywyI6DGowJuMTYCLkVI/YSO3La+CQeZeBWPSKgZJ5ie//8ofXkPzLedKC/TzAlLKQw
         3OmVQ97gG3Msg+FzyfcrXhJpJvOeVuzDWMer971YI2Jdr71/woUSn6x6+PHGgforGfLZ
         hE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830623; x=1696435423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji/hBwx8+isn2luTSLK88rkw0mw2KsvkgWhx3gQ5C1A=;
        b=mybJGfBJNBulSrLOonQwGWTZJ9EmP9rSB/1KvK/rAy9kDyhyP6UCPvQkVW3K1AjJ+v
         h0RNit61Ed8vsDu91om6h+FzdzukWzceX9vALdJGjdC/0Gyv9f7MUVtfUG7mnsTRj0Tg
         kPg4zeaO6YvHEZV/ktCdIUj7rE8nWmMzWhHKiSnvLWfqwT40E1Ox5WacLplY2ns6Fvu3
         m+X1jr4UBfUPq7XbDeClIo7KE+RBG3R2jdIiMuGR2lo1qeX21oRdabjiv0KkPicVutei
         L1O7viUVRIBmZ1qQ+eWxdPI+4EUQQADHO2hYXQ/a0QdGDOoFh9qA9SJdriEpHZOY4zt8
         nUTg==
X-Gm-Message-State: AOJu0Yw+s68l320YPRXBRuGZiPAKso6W3KRMKMAY4p8vL7r9JV987Y38
        4EivnJnlAonGnRzleypk9iJ+keJn+F81JVLT/fM=
X-Google-Smtp-Source: AGHT+IG6yWhEHFsOWCaJgQIq+JART08DJ4Xp3AmdWnErHVXMsInwmUfTtgtJjxk6hR3l5zD2i1H8cIc+VQDdy/G+Ck4=
X-Received: by 2002:a17:906:7494:b0:9ad:ece6:eeb with SMTP id
 e20-20020a170906749400b009adece60eebmr1913065ejl.32.1695830623284; Wed, 27
 Sep 2023 09:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230919214800.3803828-1-andrii@kernel.org> <20230919214800.3803828-4-andrii@kernel.org>
 <20230926-augen-biodiesel-fdb05e859aac@brauner> <CAEf4BzaH64kkccc1P-hqQj6Mccr3Q6x059G=A95d=KfU=yBMJQ@mail.gmail.com>
 <20230927-kaution-ventilator-33a41ee74d63@brauner>
In-Reply-To: <20230927-kaution-ventilator-33a41ee74d63@brauner>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Sep 2023 09:03:31 -0700
Message-ID: <CAEf4BzZ2a7ZR75ka6bjXex=qrf9bQBEyDBN5tPtkfWbErhuOTw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 03/13] bpf: introduce BPF token object
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, kernel-team@meta.com, sargun@sargun.me
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

On Wed, Sep 27, 2023 at 2:52=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > > > +#define BPF_TOKEN_INODE_NAME "bpf-token"
> > > > +
> > > > +/* Alloc anon_inode and FD for prepared token.
> > > > + * Returns fd >=3D 0 on success; negative error, otherwise.
> > > > + */
> > > > +int bpf_token_new_fd(struct bpf_token *token)
> > > > +{
> > > > +     return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops=
, token, O_CLOEXEC);
> > >
> > > It's unnecessary to use the anonymous inode infrastructure for bpf
> > > tokens. It adds even more moving parts and makes reasoning about it e=
ven
> > > harder. Just keep it all in bpffs. IIRC, something like the following
> > > (broken, non-compiling draft) should work:
> > >
> > > /* bpf_token_file - get an unlinked file living in bpffs */
> > > struct file *bpf_token_file(...)
> > > {
> > >         inode =3D bpf_get_inode(bpffs_mnt->mnt_sb, dir, mode);
> > >         inode->i_op =3D &bpf_token_iop;
> > >         inode->i_fop =3D &bpf_token_fops;
> > >
> > >         // some other stuff you might want or need
> > >
> > >         res =3D alloc_file_pseudo(inode, bpffs_mnt, "bpf-token", O_RD=
WR, &bpf_token_fops);
> > > }
> > >
> > > Now set your private data that you might need, reserve an fd, install
> > > the file into the fdtable and return the fd. You should have an unlin=
ked
> > > bpffs file that serves as your bpf token.
> >
> > Just to make sure I understand. You are saying that instead of having
> > `struct bpf_token *` and passing that into internal APIs
> > (bpf_token_capable() and bpf_token_allow_xxx()), I should just pass
> > around `struct super_block *` representing BPF FS instance? Or `struct
> > bpf_mount_opts *` maybe? Or 'struct vfsmount *'? (Any preferences
> > here?). Is that right?
>
> No, that's not what I meant.
>
> So, what you're doing right now to create a bpf token file descriptor is:
>
> return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, token, O_C=
LOEXEC);
>
> which is using the anonymous inode infrastructure. That is an entirely
> different filesystems (glossing over details) that is best leveraged for
> stuff like kvm fds and other stuff that doesn't need or have its own
> filesytem implementation.
>
> But you do have your own filesystem implementation so why abuse another
> one to create bpf token fds when they can just be created directly from
> the bpffs instance.
>
> IOW, everything stays the same apart from the fact that bpf token fds
> are actually file descriptors referring to a detached bpffs file instead
> of an anonymous inode file. IOW, bpf tokens are actual bpffs objects
> tied to a bpffs instance.

Ah, ok, this is a much smaller change than what I was about to make.
I'm glad I asked and thanks for elaborating! I'll use
alloc_file_pseudo() using bpffs mount in the next revision.

>
> **BROKEN BROKEN BROKEN AND UGLY**
>
> int bpf_token_create(union bpf_attr *attr)
> {
>         struct inode *inode;
>         struct path path;
>         struct bpf_mount_opts *mnt_opts;
>         struct bpf_token *token;
>         struct fd fd;
>         int fd, ret;
>         struct file *file;
>
>         fd =3D fdget(attr->token_create.bpffs_path_fd);
>         if (!fd.file)
>                 goto cleanup;
>
>         if (fd.file->f_path->dentry !=3D fd.file->f_path->dentry->d_sb->s=
_root)
>                 goto cleanup;
>
>         inode =3D bpf_get_inode(fd.file->f_path->mnt->mnt_sb, NULL, 12341=
23412341234);
>         if (!inode)
>                 goto cleanup;
>
>         fd =3D get_unused_fd_flags(O_RDWR | O_CLOEXEC);
>         if (fd < 0)
>                 goto cleanup;
>
>         clear_nlink(inode); /* make sure it is unlinked */
>
>         file =3D alloc_file_pseudo(inode, fd.file->f_path->mnt, "bpf-toke=
n", O_RDWR, &&bpf_token_fops);
>         if (IS_ERR(file))
>                 goto cleanup;
>
>         token =3D bpf_token_alloc();
>         if (!token)
>                 goto cleanup;
>
>         /* remember bpffs owning userns for future ns_capable() checks */
>         token->userns =3D get_user_ns(path.dentry->d_sb->s_user_ns);
>
>         mnt_opts =3D path.dentry->d_sb->s_fs_info;
>         token->allowed_cmds =3D mnt_opts->delegate_cmds;
>         token->allowed_maps =3D mnt_opts->delegate_maps;
>         token->allowed_progs =3D mnt_opts->delegate_progs;
>         token->allowed_attachs =3D mnt_opts->delegate_attachs;
>
>         file->private_data =3D token;
>         fd_install(fd, file);
>         return fd;
>
> cleanup:
>         // cleanup stuff here
>         return -SOME_ERROR;
> }
