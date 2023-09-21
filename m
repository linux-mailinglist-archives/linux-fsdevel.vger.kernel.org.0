Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7AF7AA0A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjIUUp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjIUUpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:45:09 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037002D227
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:53:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76ef6d98d7eso77967085a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318801; x=1695923601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujBdCXIAptHR486LLkyIuWqTwNv9k20/HJ89XtN7Tns=;
        b=Oa24In6iLDPp/KjYXydXjTd5iEVKEBAirIdxHGi8N2xyYV7DOCDSTQX9u4pI4P9Ltc
         xdAQbpu1pUr2GvFQs2b4d2AnbuC9higZG9EjvSAlxvIR9eEuUzfKDNUci4r5I2ruqRMQ
         afO4U6zVxgFNSqLXoVzyTfhdERl29Gk+M9MTyzjMFSxhaR34mywhRTFGPof7T9Efu0TG
         m/sBXGKlzjVB1iYuaTpKrdjN5ht1PmbvAnGtYtt9RiByjDMkk1Og8dgDq4qA2QJwX62p
         G1PWWWe2gLX58ZcLbFDB6gQVEgQSqdzrqc20alIs39RXXka+v20t35eAHjVpwzYTvMQE
         cy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318801; x=1695923601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujBdCXIAptHR486LLkyIuWqTwNv9k20/HJ89XtN7Tns=;
        b=EpEVJ6KP66nW9Mh5KgsEdgzs8F1nJTgDuX76oLZE041t+3RYd3pRIXbAF/9x7KuuUP
         iEvIho/7PQsYGcPygctaIRlmjc0ocBxJKL5Q9HObd16O0K6WFHQX/1RMitKZ6tfuqJ6h
         I5dF0bdFB24+f7RVFRP1V+MaOFP2sCrc0Wb4lFSUS1i+SlXkjauJnflHM0IAArd2gdCZ
         jRUq3yEC0WGu7gAE5TRfVudmsQALjsNdGk8WcNZ5MpQx9oFeVtoVurvY75VQaVYERt1z
         nfeLRDt4je+382KNkGgpHjq74XqVtLKCGP8dVjFErGIhX17GYRBhpuGDLIMDdSiqtscs
         rUNQ==
X-Gm-Message-State: AOJu0YweYMqv9AiNYgwYehfcFoWZ2ONcibiWcJP+atCiFmC7WBDibtLd
        vd1GCgcm3fBQaNKOEqg+1otnt7dnDQhyl1HmI7j+yhIE
X-Google-Smtp-Source: AGHT+IFx/OBAePra7efdokH+Km1BfsciIcHEfFqjxsm5VIp27h6kSLESVJ/5yPX6csKuleFCpkze4Lv7vVi2D5QSJg0=
X-Received: by 2002:a67:d08d:0:b0:452:78ea:4aec with SMTP id
 s13-20020a67d08d000000b0045278ea4aecmr3726520vsi.7.1695277248589; Wed, 20 Sep
 2023 23:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230920173445.3943581-1-bschubert@ddn.com> <20230920173445.3943581-4-bschubert@ddn.com>
In-Reply-To: <20230920173445.3943581-4-bschubert@ddn.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 21 Sep 2023 09:20:37 +0300
Message-ID: <CAOQ4uxjkrfkrWFV8bpaD_2OFifkqSRRre-y4jOOqLtVStNfBSQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] [RFC] Allow atomic_open() on positive dentry
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 8:51=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> From: Miklos Szeredi <miklos@szeredi.hu>
>
> atomic_open() will do an open-by-name or create-and-open
> depending on the flags.
>
> If file was created, then the old positive dentry is obviously
> stale, so it will be invalidated and a new one will be allocated.
>
> If not created, then check whether it's the same inode (same as in
> ->d_revalidate()) and if not, invalidate & allocate new dentry.
>
> Co-developed-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/namei.c            | 25 ++++++++++++++++++++-----
>  include/linux/namei.h |  7 +++++++
>  2 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index e56ff39a79bc..f01b278ac0ef 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -858,7 +858,7 @@ static inline int d_revalidate(struct dentry *dentry,=
 unsigned int flags)
>         if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
>                 return dentry->d_op->d_revalidate(dentry, flags);
>         else
> -               return 1;
> +               return D_REVALIDATE_VALID;
>  }
>
>  /**
> @@ -1611,10 +1611,11 @@ struct dentry *lookup_one_qstr_excl(const struct =
qstr *name,
>  }
>  EXPORT_SYMBOL(lookup_one_qstr_excl);
>
> -static struct dentry *lookup_fast(struct nameidata *nd)
> +static struct dentry *lookup_fast(struct nameidata *nd, bool *atomic_rev=
alidate)
>  {
>         struct dentry *dentry, *parent =3D nd->path.dentry;
>         int status =3D 1;
> +       *atomic_revalidate =3D false;
>
>         /*
>          * Rename seqlock is not required here because in the off chance
> @@ -1656,6 +1657,10 @@ static struct dentry *lookup_fast(struct nameidata=
 *nd)
>                 dput(dentry);
>                 return ERR_PTR(status);
>         }
> +
> +       if (status =3D=3D D_REVALIDATE_ATOMIC)
> +               *atomic_revalidate =3D true;
> +
>         return dentry;
>  }
>
> @@ -1981,6 +1986,7 @@ static const char *handle_dots(struct nameidata *nd=
, int type)
>  static const char *walk_component(struct nameidata *nd, int flags)
>  {
>         struct dentry *dentry;
> +       bool atomic_revalidate;
>         /*
>          * "." and ".." are special - ".." especially so because it has
>          * to be able to know about the current root directory and
> @@ -1991,7 +1997,7 @@ static const char *walk_component(struct nameidata =
*nd, int flags)
>                         put_link(nd);
>                 return handle_dots(nd, nd->last_type);
>         }
> -       dentry =3D lookup_fast(nd);
> +       dentry =3D lookup_fast(nd, &atomic_revalidate);
>         if (IS_ERR(dentry))
>                 return ERR_CAST(dentry);
>         if (unlikely(!dentry)) {
> @@ -1999,6 +2005,9 @@ static const char *walk_component(struct nameidata =
*nd, int flags)
>                 if (IS_ERR(dentry))
>                         return ERR_CAST(dentry);
>         }
> +
> +       WARN_ON(atomic_revalidate);
> +

WARN_ON_ONCE should be enough in most cases
to signal bad code without spamming the log.

Is there an error path that can be taken in this case?

Thanks,
Amir.

>         if (!(flags & WALK_MORE) && nd->depth)
>                 put_link(nd);
>         return step_into(nd, flags, dentry);
> @@ -3430,7 +3439,7 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>                 dput(dentry);
>                 dentry =3D NULL;
>         }
> -       if (dentry->d_inode) {
> +       if (dentry->d_inode && error !=3D D_REVALIDATE_ATOMIC) {
>                 /* Cached positive dentry: will open in f_op->open */
>                 return dentry;
>         }
> @@ -3523,12 +3532,18 @@ static const char *open_last_lookups(struct namei=
data *nd,
>         }
>
>         if (!(open_flag & O_CREAT)) {
> +               bool atomic_revalidate;
> +
>                 if (nd->last.name[nd->last.len])
>                         nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>                 /* we _can_ be in RCU mode here */
> -               dentry =3D lookup_fast(nd);
> +               dentry =3D lookup_fast(nd, &atomic_revalidate);
>                 if (IS_ERR(dentry))
>                         return ERR_CAST(dentry);
> +               if (dentry && unlikely(atomic_revalidate)) {
> +                       dput(dentry);
> +                       dentry =3D NULL;
> +               }
>                 if (likely(dentry))
>                         goto finish_lookup;
>
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 1463cbda4888..a70e87d2b2a9 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -47,6 +47,13 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
>  #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
>
> +/* ->d_revalidate return codes */
> +enum {
> +       D_REVALIDATE_INVALID =3D 0, /* invalid dentry */
> +       D_REVALIDATE_VALID   =3D 1, /* valid dentry */
> +       D_REVALIDATE_ATOMIC =3D  2, /* atomic_open will revalidate */
> +};
> +
>  extern int path_pts(struct path *path);
>
>  extern int user_path_at_empty(int, const char __user *, unsigned, struct=
 path *, int *empty);
> --
> 2.39.2
>
