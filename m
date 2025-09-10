Return-Path: <linux-fsdevel+bounces-60832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117BB51ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 19:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B03D581661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE201320A29;
	Wed, 10 Sep 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6x5avp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567B726D4F9;
	Wed, 10 Sep 2025 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524898; cv=none; b=Jnzi2axwgKU8Q3YbX2FNUqztm7Kidly18c9WtNTedRPk3yUZMF/gqqkzvkW4tr+3usZXk4EDfbMoAvkoieYI82J6mVI6rjkW/dp+BEVl6QIyafUcC7bRgrhJzCaJrERrEhG/h1dqyb2cLERTTgvQlIYy0yIr1mwq3Jc/XBlixhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524898; c=relaxed/simple;
	bh=RhMZzzYltdKFB5qM+3pAwKbhueJllywcPAsvUkS/hCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akGIxro7HwaWy4yjEuvxobpRZGn1S7juBGSXtT2pyr8gbFAHqJlf5oenjC3TzM2BeAuZMgBJ8XZq9NRp5NwLAaBkyA6/REzRvESZfMN0wQmNuzeRLTuQpN1D57M/O5HoQWDNUkHdgaZefjIiTkzBUQIaUMNPU6AqhGdExzipxh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6x5avp9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6237202020bso7979723a12.3;
        Wed, 10 Sep 2025 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757524894; x=1758129694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fawpfDcReCPiexHLQmJUihCOqOpAI9vERWwTnUBX3Jg=;
        b=b6x5avp9Psa1GISFy/Yic0ReQ1j+h1XuFtuwU5HBnVN2wEAtes0BTjOwXN1/GS5aQB
         GOFGL65syg8O5oEoLkZuuv5mBsesF5zk1pChzCy01jGVccx8Ay7wsjrlfqSCfPE79ONM
         w4pAsdmuPz37Q2Zec9sDTx2DVGiuDMvtk9kYHMZxQXSeyZtG+I81xZ3Ah5wB+nmbwM7H
         8esfGHEjZLKIrOiBHx8DmgkGJjnZvqWzsDWPoonFQ1d5esLXeFXZ3sEdnCwvttwJKh4d
         vkp1a1uqf+dR7nS/OOMApHO+4KynDKgt50TUv1gnowLDOs7PK0ZCcM2bzz1D5WATj/mm
         eFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524894; x=1758129694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fawpfDcReCPiexHLQmJUihCOqOpAI9vERWwTnUBX3Jg=;
        b=v7VOmT3fq0o2zi1eR+CkbX+YuSnmR2JhXhhLD/lkYHaojSx7p7M21DXGqq+vhk1bEY
         yz7K+G+OXIDC4C6COzsenXbZg+vUnp4qYSsc57s9P0cfvPgY8wlOQI4ftfB+3oNfO7oO
         4jF8Y8j50gSLjcsBUCIR12dLe1udNdbEshEX/uQhDvo8agsmf+di3mlS2v4PLZMAiBxj
         bfhS1jg73NHpGc5oxaqluemuV17QQnWmK/IvCLornlQugxQ+gnS6wLaK7L1sBHCj8V8z
         W8C2xXlqVTOJSfUJmm12cejjjKnjHXSO9k3YB9U49Wc7cZSZCacMIrp/3KVEUFg4u8OH
         RuFw==
X-Forwarded-Encrypted: i=1; AJvYcCVFWXuVbccaeOlf4+mxSRXMfBjSnbgmfv4nEDjw6ptP2h+FP5A0VoC29eCtjskoqq9ZXhuDuZkX@vger.kernel.org, AJvYcCVdJHHwEulZsOk0kyoPWGF55+RIwsbBA9l7x1lMd/BhfNZj47otHv23FvxpHkbgsm9TLySjmVjqlz5nGhbxoQ==@vger.kernel.org, AJvYcCVh22BPo8cd59RgomHdKhV/0CUsQvZ/cTkHRXs6RJ3fhoMr1boQoyo5ZY2kM2NZaRHqa0Klr8bFY04MXgU=@vger.kernel.org, AJvYcCWPVKtnqjfoZFmqxsdxHbQu9UfCj1Oo+hdk6Npmm7D9+tZqBLP5knmrUK0pNDEsbI2UmcO5D+F86LMz@vger.kernel.org, AJvYcCWnE9use5+QoCtAmLcddJ+UqH/FSQa/MtIfzGTuezdqMvFm/9Xa+5Fc1u5QCnhLq3C87UJr7DPEG8WnEz7f@vger.kernel.org, AJvYcCWs1QPegX1U68dgqCOYQ6zxTaq+QAlIQZDnvGFAGnwd504mG66YbEuI5FWeKovX4vI0afV30Q8p@vger.kernel.org, AJvYcCXa4VI2CrsPkxMyRz05prIClTqxdZ8bOC7vd94kEQIWrXNDIlhpySoOsHG4tkRm6N7w7PnZlyFa83sa4gEsu82J@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4rPXv7QZqlGoQizoDGKf4bmrojBig6063g6wjQ0HKErV1P+b
	j2zGZGY276GFTCAf+UOsnlUFiuyyje+yU4hvKc7rdNJNQUgYDLmHiDFjM5SQZrf7nZ8XObIaZD0
	G5v+BzSjaCaOdQWuAri8ueHpaS4cf6hQ=
X-Gm-Gg: ASbGncv0pjY4m4Z3wPCkPMFByCIMKjKXwM4gyj6OrSMa9+UYknGB2RYnPekqRhOvoAt
	bzIQ6D5RhLKy+UfcjAxq4rjEL5J9gluQy02qSK7jnXSgtEGKtCtRZKW7SmvU/UDhKhulurbXbLe
	JRgovQZKjseuNVPwUq/M2wo4APNWD979GTdWDjmXTiYpLBcfvVYjEzRFclUs45gwi9SNKHMv8ch
	sjuaEs81P66xfLf0g==
X-Google-Smtp-Source: AGHT+IGzSM48OmUPGzUeRKEcJYruA5utreW1EjHGV7gmdERENFp7O15TXDw7VLk6zyBAsqAOGPzeKl/ZVy5+N52X/B4=
X-Received: by 2002:a05:6402:24c9:b0:61d:3bca:f2fc with SMTP id
 4fb4d7f45d1cf-62378366920mr12218960a12.31.1757524894224; Wed, 10 Sep 2025
 10:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org> <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 10 Sep 2025 19:21:22 +0200
X-Gm-Features: AS18NWAeQzw8A2L3MeKKv5VLNvqBS6WiA4GMVCa0r-bsvToYY4x-puEFtCSLPAg
Message-ID: <CAOQ4uxgtQQa-jzsnTBxgUTPzgtCiAaH8X6ffMqd+1Y5Jjy0dmQ@mail.gmail.com>
Subject: Re: [PATCH 27/32] nsfs: support file handles
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:39=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> A while ago we added support for file handles to pidfs so pidfds can be
> encoded and decoded as file handles. Userspace has adopted this quickly
> and it's proven very useful.

> Pidfd file handles are exhaustive meaning
> they don't require a handle on another pidfd to pass to
> open_by_handle_at() so it can derive the filesystem to decode in.
>
> Implement the exhaustive file handles for namespaces as well.

I think you decide to split the "exhaustive" part to another patch,
so better drop this paragraph?

I am missing an explanation about the permissions for
opening these file handles.

My understanding of the code is that the opener needs to meet one of
the conditions:
1. user has CAP_SYS_ADMIN in the userns owning the opened namespace
2. current task is in the opened namespace

But I do not fully understand the rationale behind the 2nd condition,
that is, when is it useful?
And as far as I can tell, your selftest does not cover this condition
(only both true or both false)?

I suggest to start with allowing only the useful and important
cases, so if cond #1 is useful enough, drop cond #2 and we can add
it later if needed and then your selftests already cover cond #1 true and f=
alse.

>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

After documenting the permissions, with ot without dropping cond #2
feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/nsfs.c                | 176 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/exportfs.h |   6 ++
>  2 files changed, 182 insertions(+)
>
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 6f8008177133..a1585a2f4f03 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -13,6 +13,12 @@
>  #include <linux/nsfs.h>
>  #include <linux/uaccess.h>
>  #include <linux/mnt_namespace.h>
> +#include <linux/ipc_namespace.h>
> +#include <linux/time_namespace.h>
> +#include <linux/utsname.h>
> +#include <linux/exportfs.h>
> +#include <linux/nstree.h>
> +#include <net/net_namespace.h>
>
>  #include "mount.h"
>  #include "internal.h"
> @@ -417,12 +423,182 @@ static const struct stashed_operations nsfs_stashe=
d_ops =3D {
>         .put_data =3D nsfs_put_data,
>  };
>
> +struct nsfs_fid {
> +       u64 ns_id;
> +       u32 ns_type;
> +       u32 ns_inum;
> +} __attribute__ ((packed));
> +
> +#define NSFS_FID_SIZE (sizeof(struct nsfs_fid) / sizeof(u32))
> +
> +static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +                         struct inode *parent)
> +{
> +       struct nsfs_fid *fid =3D (struct nsfs_fid *)fh;
> +       struct ns_common *ns =3D inode->i_private;
> +       int len =3D *max_len;
> +
> +       /*
> +        * TODO:
> +        * For hierarchical namespaces we should start to encode the
> +        * parent namespace. Then userspace can walk a namespace
> +        * hierarchy purely based on file handles.
> +        */
> +       if (parent)
> +               return FILEID_INVALID;
> +
> +       if (len < NSFS_FID_SIZE) {
> +               *max_len =3D NSFS_FID_SIZE;
> +               return FILEID_INVALID;
> +       }
> +
> +       len  =3D NSFS_FID_SIZE;
> +
> +       fid->ns_id =3D ns->ns_id;
> +       fid->ns_type =3D ns->ops->type;
> +       fid->ns_inum =3D inode->i_ino;
> +       *max_len =3D len;
> +       return FILEID_NSFS;
> +}
> +
> +static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct f=
id *fh,
> +                                       int fh_len, int fh_type)
> +{
> +       struct path path __free(path_put) =3D {};
> +       struct nsfs_fid *fid =3D (struct nsfs_fid *)fh;
> +       struct user_namespace *owning_ns =3D NULL;
> +       struct ns_common *ns;
> +       int ret;
> +
> +       if (fh_len < NSFS_FID_SIZE)
> +               return NULL;
> +
> +       switch (fh_type) {
> +       case FILEID_NSFS:
> +               break;
> +       default:
> +               return NULL;
> +       }
> +
> +       scoped_guard(rcu) {
> +               ns =3D ns_tree_lookup_rcu(fid->ns_id, fid->ns_type);
> +               if (!ns)
> +                       return NULL;
> +
> +               VFS_WARN_ON_ONCE(ns->ns_id !=3D fid->ns_id);
> +               VFS_WARN_ON_ONCE(ns->ops->type !=3D fid->ns_type);
> +               VFS_WARN_ON_ONCE(ns->inum !=3D fid->ns_inum);
> +
> +               if (!refcount_inc_not_zero(&ns->count))
> +                       return NULL;
> +       }
> +
> +       switch (ns->ops->type) {
> +#ifdef CONFIG_CGROUPS
> +       case CLONE_NEWCGROUP:
> +               if (!current_in_namespace(to_cg_ns(ns)))
> +                       owning_ns =3D to_cg_ns(ns)->user_ns;
> +               break;
> +#endif
> +#ifdef CONFIG_IPC_NS
> +       case CLONE_NEWIPC:
> +               if (!current_in_namespace(to_ipc_ns(ns)))
> +                       owning_ns =3D to_ipc_ns(ns)->user_ns;
> +               break;
> +#endif
> +       case CLONE_NEWNS:
> +               if (!current_in_namespace(to_mnt_ns(ns)))
> +                       owning_ns =3D to_mnt_ns(ns)->user_ns;
> +               break;
> +#ifdef CONFIG_NET_NS
> +       case CLONE_NEWNET:
> +               if (!current_in_namespace(to_net_ns(ns)))
> +                       owning_ns =3D to_net_ns(ns)->user_ns;
> +               break;
> +#endif
> +#ifdef CONFIG_PID_NS
> +       case CLONE_NEWPID:
> +               if (!current_in_namespace(to_pid_ns(ns))) {
> +                       owning_ns =3D to_pid_ns(ns)->user_ns;
> +               } else if (!READ_ONCE(to_pid_ns(ns)->child_reaper)) {
> +                       ns->ops->put(ns);
> +                       return ERR_PTR(-EPERM);
> +               }
> +               break;
> +#endif
> +#ifdef CONFIG_TIME_NS
> +       case CLONE_NEWTIME:
> +               if (!current_in_namespace(to_time_ns(ns)))
> +                       owning_ns =3D to_time_ns(ns)->user_ns;
> +               break;
> +#endif
> +#ifdef CONFIG_USER_NS
> +       case CLONE_NEWUSER:
> +               if (!current_in_namespace(to_user_ns(ns)))
> +                       owning_ns =3D to_user_ns(ns);
> +               break;
> +#endif
> +#ifdef CONFIG_UTS_NS
> +       case CLONE_NEWUTS:
> +               if (!current_in_namespace(to_uts_ns(ns)))
> +                       owning_ns =3D to_uts_ns(ns)->user_ns;
> +               break;
> +#endif
> +       default:
> +               return ERR_PTR(-EOPNOTSUPP);
> +       }
> +
> +       if (owning_ns && !ns_capable(owning_ns, CAP_SYS_ADMIN)) {
> +               ns->ops->put(ns);
> +               return ERR_PTR(-EPERM);
> +       }
> +
> +       /* path_from_stashed() unconditionally consumes the reference. */
> +       ret =3D path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return no_free_ptr(path.dentry);
> +}
> +
> +/*
> + * Make sure that we reject any nonsensical flags that users pass via
> + * open_by_handle_at().
> + */
> +#define VALID_FILE_HANDLE_OPEN_FLAGS \
> +       (O_RDONLY | O_WRONLY | O_RDWR | O_NONBLOCK | O_CLOEXEC | O_EXCL)
> +
> +static int nsfs_export_permission(struct handle_to_path_ctx *ctx,
> +                                  unsigned int oflags)
> +{
> +       if (oflags & ~(VALID_FILE_HANDLE_OPEN_FLAGS | O_LARGEFILE))
> +               return -EINVAL;
> +
> +       /* nsfs_fh_to_dentry() is performs further permission checks. */
> +       return 0;
> +}
> +
> +static struct file *nsfs_export_open(struct path *path, unsigned int ofl=
ags)
> +{
> +       /* Clear O_LARGEFILE as open_by_handle_at() forces it. */
> +       oflags &=3D ~O_LARGEFILE;
> +       return file_open_root(path, "", oflags, 0);
> +}
> +
> +static const struct export_operations nsfs_export_operations =3D {
> +       .encode_fh      =3D nsfs_encode_fh,
> +       .fh_to_dentry   =3D nsfs_fh_to_dentry,
> +       .open           =3D nsfs_export_open,
> +       .permission     =3D nsfs_export_permission,
> +};
> +
>  static int nsfs_init_fs_context(struct fs_context *fc)
>  {
>         struct pseudo_fs_context *ctx =3D init_pseudo(fc, NSFS_MAGIC);
>         if (!ctx)
>                 return -ENOMEM;
>         ctx->ops =3D &nsfs_ops;
> +       ctx->eops =3D &nsfs_export_operations;
>         ctx->dops =3D &ns_dentry_operations;
>         fc->s_fs_info =3D (void *)&nsfs_stashed_ops;
>         return 0;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index cfb0dd1ea49c..3aac58a520c7 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -122,6 +122,12 @@ enum fid_type {
>         FILEID_BCACHEFS_WITHOUT_PARENT =3D 0xb1,
>         FILEID_BCACHEFS_WITH_PARENT =3D 0xb2,
>
> +       /*
> +        *
> +        * 64 bit namespace identifier, 32 bit namespace type, 32 bit ino=
de number.
> +        */
> +       FILEID_NSFS =3D 0xf1,
> +
>         /*
>          * 64 bit unique kernfs id
>          */
>
> --
> 2.47.3
>

