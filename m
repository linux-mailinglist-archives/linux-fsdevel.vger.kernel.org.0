Return-Path: <linux-fsdevel+bounces-143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994BD7C61CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 02:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CCBA2827F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 00:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A6817;
	Thu, 12 Oct 2023 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7l+oJHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A01110;
	Thu, 12 Oct 2023 00:31:33 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8FB7;
	Wed, 11 Oct 2023 17:31:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so759208a12.2;
        Wed, 11 Oct 2023 17:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697070689; x=1697675489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUrT345ss4IDJzjgaXD0eDiurjQS/ECS4JCN2GClNgY=;
        b=c7l+oJHNwbYv8a/Pg3QpT7dgEkELebh85jXySc2eJK9vuwlqxrlhGq1511rSey/QWJ
         YyllhHifqb8LtLI/Re5+qNHmfiPbyD8P3i5oKeLcHrPQkP81V+efyIS5fyvR6O7dPmNf
         GPsN8cQmYecyPgmIXWoScA6zC+n4isUajwx/GK0v5nw7g7stozkhC8s84RGhd7ymaCE8
         3RkvWh9G/HaLGAn/LH1Eixq8xG+oGQyZUyKGzAIQITjiqdH1ocZQWD3Q3FyreHqALmUn
         lZog91DF9cjtcUuzFUvYuz0Q1DfQVnn6RWNh1a4EtvQgbAEF5/zMOtoF2qSDGCfhg/Tc
         G/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070689; x=1697675489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUrT345ss4IDJzjgaXD0eDiurjQS/ECS4JCN2GClNgY=;
        b=aqmk7nJu2BoiVodBeDNcwFrtmf9XbcOdN0vu1gAKxOGGKhWuKEN60Yrv2c9yUSRmT4
         S5ngq4A58odTMZOEYfc6aWVXThyW5LMrJxTCbhGWNpxJv9A7TX+E5tzAeHpFFcRZRquK
         F9jRsFllyNrVUhp/pdM9MUUXob6vPWva776loe1A/8bim8wMVdDVckbtp69+GXFkfgJv
         7qR8Se5PQdoz/T3Q1yni/P39WqmR6RnBKJPvAaYIBsUl/ZAoZHbty9ytxoYMcLuwbTq+
         pvm0+t1OOL27rpil7cFCiSjY4ozik/G0s6iGLRva80BbTdlQejazFCMctnrNo7rngLFL
         7FBg==
X-Gm-Message-State: AOJu0YyGaP68pnGwm6ZTuTxmcFKqhCzUBMXkuB10oecAcxM/EMnnaY3r
	OjhLpG0pNeePLLgarkP/GNFSttAQOGQHAyACwFw=
X-Google-Smtp-Source: AGHT+IFVxNPar3QJyGQhz/+0QzbZyDHkBgunmTp+ejy78RsgKHsRzHPpvPI4mJQJgkLQ6pXKF9ujfE65qc6feXVJ5M4=
X-Received: by 2002:a05:6402:2919:b0:53d:8320:efcb with SMTP id
 ee25-20020a056402291900b0053d8320efcbmr5223622edb.36.1697070688757; Wed, 11
 Oct 2023 17:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927225809.2049655-4-andrii@kernel.org> <53183ab045f8154ef94070039d53bbab.paul@paul-moore.com>
In-Reply-To: <53183ab045f8154ef94070039d53bbab.paul@paul-moore.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 17:31:17 -0700
Message-ID: <CAEf4BzaTZ_EY4JVZ3ozGzed1PeD+HNGgkDw6jGpWYD_K9c8RFw@mail.gmail.com>
Subject: Re: [PATCH v6 3/13] bpf: introduce BPF token object
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sep 27, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > allow delegating privileged BPF functionality, like loading a BPF
> > program or creating a BPF map, from privileged process to a *trusted*
> > unprivileged process, all while have a good amount of control over whic=
h
> > privileged operations could be performed using provided BPF token.
> >
> > This is achieved through mounting BPF FS instance with extra delegation
> > mount options, which determine what operations are delegatable, and als=
o
> > constraining it to the owning user namespace (as mentioned in the
> > previous patch).
> >
> > BPF token itself is just a derivative from BPF FS and can be created
> > through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
> > a path specification (using the usual fd + string path combo) to a BPF
> > FS mount. Currently, BPF token "inherits" delegated command, map types,
> > prog type, and attach type bit sets from BPF FS as is. In the future,
> > having an BPF token as a separate object with its own FD, we can allow
> > to further restrict BPF token's allowable set of things either at the c=
reation
> > time or after the fact, allowing the process to guard itself further
> > from, e.g., unintentionally trying to load undesired kind of BPF
> > programs. But for now we keep things simple and just copy bit sets as i=
s.
> >
> > When BPF token is created from BPF FS mount, we take reference to the
> > BPF super block's owning user namespace, and then use that namespace fo=
r
> > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> > capabilities that are normally only checked against init userns (using
> > capable()), but now we check them using ns_capable() instead (if BPF
> > token is provided). See bpf_token_capable() for details.
> >
> > Such setup means that BPF token in itself is not sufficient to grant BP=
F
> > functionality. User namespaced process has to *also* have necessary
> > combination of capabilities inside that user namespace. So while
> > previously CAP_BPF was useless when granted within user namespace, now
> > it gains a meaning and allows container managers and sys admins to have
> > a flexible control over which processes can and need to use BPF
> > functionality within the user namespace (i.e., container in practice).
> > And BPF FS delegation mount options and derived BPF tokens serve as
> > a per-container "flag" to grant overall ability to use bpf() (plus furt=
her
> > restrict on which parts of bpf() syscalls are treated as namespaced).
> >
> > The alternative to creating BPF token object was:
> >   a) not having any extra object and just pasing BPF FS path to each
> >      relevant bpf() command. This seems suboptimal as it's racy (mount
> >      under the same path might change in between checking it and using =
it
> >      for bpf() command). And also less flexible if we'd like to further
> >      restrict ourselves compared to all the delegated functionality
> >      allowed on BPF FS.
> >   b) use non-bpf() interface, e.g., ioctl(), but otherwise also create
> >      a dedicated FD that would represent a token-like functionality. Th=
is
> >      doesn't seem superior to having a proper bpf() command, so
> >      BPF_TOKEN_CREATE was chosen.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h            |  40 +++++++
> >  include/uapi/linux/bpf.h       |  39 +++++++
> >  kernel/bpf/Makefile            |   2 +-
> >  kernel/bpf/inode.c             |  10 +-
> >  kernel/bpf/syscall.c           |  17 +++
> >  kernel/bpf/token.c             | 197 +++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  39 +++++++
> >  7 files changed, 339 insertions(+), 5 deletions(-)
> >  create mode 100644 kernel/bpf/token.c
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a5bd40f71fd0..c43131a24579 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1572,6 +1576,13 @@ struct bpf_mount_opts {
> >       u64 delegate_attachs;
> >  };
> >
> > +struct bpf_token {
> > +     struct work_struct work;
> > +     atomic64_t refcnt;
> > +     struct user_namespace *userns;
> > +     u64 allowed_cmds;
>
> We'll also need a 'void *security' field to go along with the BPF token
> allocation/creation/free hooks, see my comments below.  This is similar
> to what we do for other kernel objects.
>

ok, I'm thinking of adding a dedicated patch for all the
security-related stuff and refactoring of existing LSM hook(s).

> > +};
> > +
>
> ...
>
> > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > new file mode 100644
> > index 000000000000..779aad5007a3
> > --- /dev/null
> > +++ b/kernel/bpf/token.c
> > @@ -0,0 +1,197 @@
> > +#include <linux/bpf.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/anon_inodes.h>
>
> Probably don't need the anon_inode.h include anymore.

yep, dropped

>
> > +#include <linux/fdtable.h>
> > +#include <linux/file.h>
> > +#include <linux/fs.h>
> > +#include <linux/kernel.h>
> > +#include <linux/idr.h>
> > +#include <linux/namei.h>
> > +#include <linux/user_namespace.h>
> > +
> > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > +{
> > +     /* BPF token allows ns_capable() level of capabilities */
> > +     if (token) {
>
> I think we want a LSM hook here before the token is used in the
> capability check.  The LSM will see the capability check, but it will
> not be able to distinguish it from the process which created the
> delegation token.  This is arguably the purpose of the delegation, but
> with the LSM we want to be able to control who can use the delegated
> privilege.  How about something like this:
>
>   if (security_bpf_token_capable(token, cap))
>      return false;

sounds good, I'll add this hook

btw, I'm thinking of guarding the BPF_TOKEN_CREATE command behind the
ns_capable(CAP_BPF) check, WDYT? This seems appropriate. You can get
BPF token only if you have CAP_BPF **within the userns**, so any
process not granted CAP_BPF within namespace ("container") is
guaranteed to not be able to do anything with BPF token.

>
> > +             if (ns_capable(token->userns, cap))
> > +                     return true;
> > +             if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, C=
AP_SYS_ADMIN))
> > +                     return true;
> > +     }
> > +     /* otherwise fallback to capable() checks */
> > +     return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS=
_ADMIN));
> > +}
> > +
> > +void bpf_token_inc(struct bpf_token *token)
> > +{
> > +     atomic64_inc(&token->refcnt);
> > +}
> > +
> > +static void bpf_token_free(struct bpf_token *token)
> > +{
>
> We should have a LSM hook here to handle freeing the LSM state
> associated with the token.
>
>   security_bpf_token_free(token);
>

yep

> > +     put_user_ns(token->userns);
> > +     kvfree(token);
> > +}
>
> ...
>
> > +static struct bpf_token *bpf_token_alloc(void)
> > +{
> > +     struct bpf_token *token;
> > +
> > +     token =3D kvzalloc(sizeof(*token), GFP_USER);
> > +     if (!token)
> > +             return NULL;
> > +
> > +     atomic64_set(&token->refcnt, 1);
>
> We should have a LSM hook here to allocate the LSM state associated
> with the token.
>
>   if (security_bpf_token_alloc(token)) {
>     kvfree(token);
>     return NULL;
>   }
>
> > +     return token;
> > +}
>
> ...
>

Would having userns and allowed_* masks filled out by that time inside
the token be useful (seems so if we treat bpf_token_alloc as generic
LSM hook). If yes, I'll add security_bpf_token_alloc() after all that
is filled out, right before we try to get unused fd. WDYT?


> > +int bpf_token_create(union bpf_attr *attr)
> > +{
> > +     struct bpf_mount_opts *mnt_opts;
> > +     struct bpf_token *token =3D NULL;
> > +     struct inode *inode;
> > +     struct file *file;
> > +     struct path path;
> > +     umode_t mode;
> > +     int err, fd;
> > +
> > +     err =3D user_path_at(attr->token_create.bpffs_path_fd,
> > +                        u64_to_user_ptr(attr->token_create.bpffs_pathn=
ame),
> > +                        LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
> > +     if (err)
> > +             return err;
> > +
> > +     if (path.mnt->mnt_root !=3D path.dentry) {
> > +             err =3D -EINVAL;
> > +             goto out_path;
> > +     }
> > +     err =3D path_permission(&path, MAY_ACCESS);
> > +     if (err)
> > +             goto out_path;
> > +
> > +     mode =3D S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask());
> > +     inode =3D bpf_get_inode(path.mnt->mnt_sb, NULL, mode);
> > +     if (IS_ERR(inode)) {
> > +             err =3D PTR_ERR(inode);
> > +             goto out_path;
> > +     }
> > +
> > +     inode->i_op =3D &bpf_token_iops;
> > +     inode->i_fop =3D &bpf_token_fops;
> > +     clear_nlink(inode); /* make sure it is unlinked */
> > +
> > +     file =3D alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,=
 O_RDWR, &bpf_token_fops);
> > +     if (IS_ERR(file)) {
> > +             iput(inode);
> > +             err =3D PTR_ERR(file);
> > +             goto out_file;
> > +     }
> > +
> > +     token =3D bpf_token_alloc();
> > +     if (!token) {
> > +             err =3D -ENOMEM;
> > +             goto out_file;
> > +     }
> > +
> > +     /* remember bpffs owning userns for future ns_capable() checks */
> > +     token->userns =3D get_user_ns(path.dentry->d_sb->s_user_ns);
> > +
> > +     mnt_opts =3D path.dentry->d_sb->s_fs_info;
> > +     token->allowed_cmds =3D mnt_opts->delegate_cmds;
>
> I think we would want a LSM hook here, both to control the creation
> of the token and mark it with the security attributes of the creating
> process.  How about something like this:
>
>   err =3D security_bpf_token_create(token);
>   if (err)
>     goto out_token;

hmm... so you'd like both security_bpf_token_alloc() and
security_bpf_token_create()? They seem almost identical, do we need
two? Or is it that the security_bpf_token_alloc() is supposed to be
only used to create those `void *security` context pieces, while
security_bpf_token_create() is actually going to be used for
enforcement? For my own education, is there some explicit flag or some
other sort of mark between LSM hooks for setting up security vs
enforcement? Or is it mostly based on convention and implicitly
following the split?

>
> > +     fd =3D get_unused_fd_flags(O_CLOEXEC);
> > +     if (fd < 0) {
> > +             err =3D fd;
> > +             goto out_token;
> > +     }
> > +
> > +     file->private_data =3D token;
> > +     fd_install(fd, file);
> > +
> > +     path_put(&path);
> > +     return fd;
> > +
> > +out_token:
> > +     bpf_token_free(token);
> > +out_file:
> > +     fput(file);
> > +out_path:
> > +     path_put(&path);
> > +     return err;
> > +}
>
> ...
>
> > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd c=
md)
> > +{
> > +     if (!token)
> > +             return false;
> > +
> > +     return token->allowed_cmds & (1ULL << cmd);
>
> Similar to bpf_token_capable(), I believe we want a LSM hook here to
> control who is allowed to use the delegated privilege.
>
>   bool bpf_token_allow_cmd(...)
>   {
>     if (token && (token->allowed_cmds & (1ULL << cmd))
>       return security_bpf_token_cmd(token, cmd);

ok, so I guess I'll have to add all four variants:
security_bpf_token_{cmd,map_type,prog_type,attach_type}, right?



>     return false;
>   }
>
> > +}
>
> --
> paul-moore.com

