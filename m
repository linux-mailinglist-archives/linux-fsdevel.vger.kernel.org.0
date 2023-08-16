Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0FC77E51D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbjHPP0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 11:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbjHPP0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:26:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482A52D63
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 08:25:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcc0adab4so866090066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692199536; x=1692804336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MxXL5SlrE9mps1gsT2ZwBqp+UsgUpTQpEiTDpDxq990=;
        b=aGvNKC7G7MX7YT8ftThOdZZOlbhXdlzg6neB5mZ/tkKNTXA2uCxi0wPf/81N56b/1P
         nzgJlgiiD4xb0ZbnFWm5ieYgb8Xq4YbXwdRJMCndXv7blxI5PldvE53KrAU3erRnMiJG
         0xdF0o8i0u/0Oky57KhU6Ucp383LtoKHKLbzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692199536; x=1692804336;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxXL5SlrE9mps1gsT2ZwBqp+UsgUpTQpEiTDpDxq990=;
        b=A/pt3Qy8yzoF0IIHBipqY0oR86j2BviSHCNuoYThhWbqm22cOMqLW5h+jDfyxuwxTa
         Pr4iP/mUw4S3h2q8xzWekPEcXEz/VfOOrxrVgpSyOYuevQUlzpC2MKBJBI+9usUwn8GX
         vbiQKGEuQNSZoHosMJ+zMsEJc6Jo6b1I6y2c5CWtGFCG8/yVtMWP34cgiUa7tFpw+KHP
         n5SwjZrLW8VSE/C2t2cLljpc4noF9fe0CfOXwqdYQt0SxisTuuOw/GY7h7p7ooDN1TNg
         /OBdbQu//inXjHgulzSm9P/jwOHYB/k27OgvRuYq3XV8gyMRKc5+rJYJ4huohm1u4ZPt
         MRhw==
X-Gm-Message-State: AOJu0YzIwnc/PxdCU0Y1hB2sGRdfVhXn7gw8eASahaNkCKBRGmxOlEOg
        g8c/FPxfuEooIsq5/MbkMVTVcnCauGGeJSyEHt/a9g==
X-Google-Smtp-Source: AGHT+IGSOPKGiwocvoyClNZFoUxssqXNKxcM2Qy+TDlaHjKCL6sYeQptshwE1wjtJqeiO4MNfrtaaBbfM9YrjqirrTU=
X-Received: by 2002:a17:907:a07b:b0:99b:cc2f:c47c with SMTP id
 ia27-20020a170907a07b00b0099bcc2fc47cmr1484617ejc.53.1692199535758; Wed, 16
 Aug 2023 08:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230816143313.2591328-1-bschubert@ddn.com> <20230816143313.2591328-4-bschubert@ddn.com>
In-Reply-To: <20230816143313.2591328-4-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Aug 2023 17:25:24 +0200
Message-ID: <CAJfpegtEj1gyTG+mJLrPEerR3VuNNHhp7uYmU5R8a0x-Sv=BVw@mail.gmail.com>
Subject: Re: [PATCH 3/6] [RFC] Allow atomic_open() on positive dentry
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        fuse-devel@lists.sourceforge.net,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Aug 2023 at 16:34, Bernd Schubert <bschubert@ddn.com> wrote:
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
> Changes (v7 global series) from Miklos initial patch (by Bernd):
> - LOOKUP_ATOMIC_REVALIDATE was added and is set for revalidate
>   calls into the file system when revalidate by atomic open is
>   supported - this is to avoid that ->d_revalidate() would skip
>   revalidate and set DCACHE_ATOMIC_OPEN, although vfs
>   does not supported it in the given code path (for example
>   when LOOKUP_RCU is set)).
> - Support atomic-open-revalidate in lookup_fast() - allow atomic
>   open for positive dentries without O_CREAT being set.
>
> Changes (v8 global series)
> - Introduce enum for d_revalidate return values
> - LOOKUP_ATOMIC_REVALIDATE is removed again
> - DCACHE_ATOMIC_OPEN flag is replaced by D_REVALIDATE_ATOMIC
>   return value
>
> Co-developed-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/namei.c            | 25 +++++++++++++++++++------
>  include/linux/namei.h |  6 ++++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index e4fe0879ae55..8381ec7645f5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -858,7 +858,7 @@ static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
>         if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
>                 return dentry->d_op->d_revalidate(dentry, flags);
>         else
> -               return 1;
> +               return D_REVALIDATE_VALID;
>  }
>
>  /**
> @@ -1611,10 +1611,11 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
>  }
>  EXPORT_SYMBOL(lookup_one_qstr_excl);
>
> -static struct dentry *lookup_fast(struct nameidata *nd)
> +static struct dentry *lookup_fast(struct nameidata *nd, int *atomic_revalidate)

bool?

>  {
>         struct dentry *dentry, *parent = nd->path.dentry;
>         int status = 1;
> +       *atomic_revalidate = 0;
>
>         /*
>          * Rename seqlock is not required here because in the off chance
> @@ -1656,6 +1657,10 @@ static struct dentry *lookup_fast(struct nameidata *nd)
>                 dput(dentry);
>                 return ERR_PTR(status);
>         }
> +
> +       if (status == D_REVALIDATE_ATOMIC)
> +               *atomic_revalidate = 1;
> +
>         return dentry;
>  }
>
> @@ -1981,6 +1986,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
>  static const char *walk_component(struct nameidata *nd, int flags)
>  {
>         struct dentry *dentry;
> +       int atomic_revalidate;
>         /*
>          * "." and ".." are special - ".." especially so because it has
>          * to be able to know about the current root directory and
> @@ -1991,7 +1997,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
>                         put_link(nd);
>                 return handle_dots(nd, nd->last_type);
>         }
> -       dentry = lookup_fast(nd);
> +       dentry = lookup_fast(nd, &atomic_revalidate);
>         if (IS_ERR(dentry))
>                 return ERR_CAST(dentry);
>         if (unlikely(!dentry)) {
> @@ -1999,6 +2005,9 @@ static const char *walk_component(struct nameidata *nd, int flags)
>                 if (IS_ERR(dentry))
>                         return ERR_CAST(dentry);
>         }
> +
> +       WARN_ON(atomic_revalidate);
> +
>         if (!(flags & WALK_MORE) && nd->depth)
>                 put_link(nd);
>         return step_into(nd, flags, dentry);
> @@ -3430,7 +3439,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>                 dput(dentry);
>                 dentry = NULL;
>         }
> -       if (dentry->d_inode) {
> +       if (dentry->d_inode && error != D_REVALIDATE_ATOMIC) {
>                 /* Cached positive dentry: will open in f_op->open */
>                 return dentry;
>         }
> @@ -3523,15 +3532,19 @@ static const char *open_last_lookups(struct nameidata *nd,
>         }
>
>         if (!(open_flag & O_CREAT)) {
> +               int atomic_revalidate;
>                 if (nd->last.name[nd->last.len])
>                         nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>                 /* we _can_ be in RCU mode here */
> -               dentry = lookup_fast(nd);
> +               dentry = lookup_fast(nd, &atomic_revalidate);
>                 if (IS_ERR(dentry))
>                         return ERR_CAST(dentry);
> +               if (dentry && unlikely(atomic_revalidate)) {

Need to assert !LOOKUP_RCU

> +                       dput(dentry);
> +                       dentry = NULL;
> +               }

Feels a shame to throw away the dentry.  May be worth adding a helper
for the plain atomic open, most of the complexity of lookup_open() is
because of O_CREAT, so this should be much simplified.

>                 if (likely(dentry))
>                         goto finish_lookup;
> -

Adding/removing empty lines is just a distraction, so it shouldn't be
done unless it serves a real purpose.

>                 BUG_ON(nd->flags & LOOKUP_RCU);
>         } else {
>                 /* create side of things */
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 1463cbda4888..675fd6c88201 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -47,6 +47,12 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
>  #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
>
> +enum {
> +       D_REVALIDATE_INVALID = 0,
> +       D_REVALIDATE_VALID   = 1,
> +       D_REVALIDATE_ATOMIC =  2, /* Not allowed with LOOKUP_RCU */
> +};
> +
>  extern int path_pts(struct path *path);
>
>  extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
> --
> 2.37.2
>
