Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F2B77C914
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjHOIDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjHOIDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:03:21 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE77FC9
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 01:03:17 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b703a0453fso76524161fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692086596; x=1692691396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pxtOVwOaeS61AQXJN01+riMZ1U7B7Eqb0G5L4iqXuQQ=;
        b=Eew6PUwYkn5Ge5W0lE/Hwxul3vLCXvQFbpFcT+64ZOK6FvKTFTbjpQICjBacJbaHln
         77T4xXBlI5yl87YpwlQNetJOqlaI3I1TGs+fkswDLotFblJZO/EIjwiTWRwVa7mSZb2C
         cUijZNkTGEKs4oRMmyQ3UtQnuJuIxGSqPOals=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692086596; x=1692691396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxtOVwOaeS61AQXJN01+riMZ1U7B7Eqb0G5L4iqXuQQ=;
        b=aXmFjf+9L+tf4h7ESsEMOPM+J1rTTPqSvZq7b8/yL8IBbDteEzzAlQr2Nobb4dcq+J
         m9Pde1pYoggT+loBWI26KxPzHuHbwKCX8uoc8LkY6YQVstemXrs3A3BAYfasLIZ0Mi7C
         IH8XHjvsy7WJqVrYdbBvYsBT9h5NOuA6nJdXTfqvJUHVwBvTX9dRtv7HDlXsQdZDR9dU
         vWKCAx6wEQlu/mRLn2yO6Z6Eje0GG4gd6HxsiI2ioDH4Fe1lMpStLFI00uXF0frVBMct
         eul4N9rHN14J0Qj3ESNUjQoWxrnYazLwbtEGdcapNWe6qbYNk31fpKv7YhwzJxAqCRv/
         5pxg==
X-Gm-Message-State: AOJu0YzXvp8FMzTdEETxU9xN5QLIQiEmw4q7JVoXj9Gi6FNMjncHec9Z
        Q5oHR7Q8f9yRVPR58FkVV2+xikIcsLu7vJzGpsFdYQ==
X-Google-Smtp-Source: AGHT+IEV4toO7pncW0QeHVYP9OC7DvCM0O+s5PYJDuAfU/MENY8v/IK6FB+wIyvBgqvA96CcqRpXu6CzjaVT6tRqdis=
X-Received: by 2002:a2e:7412:0:b0:2b6:c2e4:a57a with SMTP id
 p18-20020a2e7412000000b002b6c2e4a57amr8303297ljc.38.1692086595825; Tue, 15
 Aug 2023 01:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230811183752.2506418-1-bschubert@ddn.com> <20230811183752.2506418-4-bschubert@ddn.com>
In-Reply-To: <20230811183752.2506418-4-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 15 Aug 2023 10:03:04 +0200
Message-ID: <CAJfpegtsCPZ_c2J7o08kgT8z9UNkTJ0BD5R1yT2_fT+ZPH+Q_w@mail.gmail.com>
Subject: Re: [PATCH 3/6] [RFC] Allow atomic_open() on positive dentry
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        fuse-devel@lists.sourceforge.net,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 11 Aug 2023 at 20:38, Bernd Schubert <bschubert@ddn.com> wrote:
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
> Changes from Miklos initial patch (by Bernd):
> - LOOKUP_ATOMIC_REVALIDATE was added and is set for revalidate
>   calls into the file system when revalidate by atomic open is
>   supported - this is to avoid that ->d_revalidate() would skip
>   revalidate and set DCACHE_ATOMIC_OPEN, although vfs
>   does not supported it in the given code path (for example
>   when LOOKUP_RCU is set)).

I don't get it.   We don't get so far as to set DCACHE_ATOMIC_OPEN if
LOOKUP_RCU is set.

> - Support atomic-open-revalidate in lookup_fast() - allow atomic
>   open for positive dentries without O_CREAT being set.
>
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Dharmendra Singh <dsingh@ddn.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/fuse/dir.c          |  5 ++---
>  fs/namei.c             | 17 +++++++++++++----
>  include/linux/dcache.h |  6 ++++++
>  include/linux/namei.h  |  1 +
>  4 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index c02b63fe91ca..8ccd49d63235 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -380,7 +380,6 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
>         if (name->len > FUSE_NAME_MAX)
>                 goto out;
>
> -
>         forget = fuse_alloc_forget();
>         err = -ENOMEM;
>         if (!forget)
> @@ -771,8 +770,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>  }
>
>  static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
> -                           struct file *file, unsigned flags,
> -                           umode_t mode)
> +                            struct file *file, unsigned flags,
> +                            umode_t mode)
>  {
>
>         int err;
> diff --git a/fs/namei.c b/fs/namei.c
> index e4fe0879ae55..5dae1b1afd0e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1643,12 +1643,14 @@ static struct dentry *lookup_fast(struct nameidata *nd)
>                         return ERR_PTR(-ECHILD);
>                 if (status == -ECHILD)
>                         /* we'd been told to redo it in non-rcu mode */
> -                       status = d_revalidate(dentry, nd->flags);
> +                       status = d_revalidate(dentry,
> +                                             nd->flags | LOOKUP_ATOMIC_REVALIDATE);
>         } else {
>                 dentry = __d_lookup(parent, &nd->last);
>                 if (unlikely(!dentry))
>                         return NULL;
> -               status = d_revalidate(dentry, nd->flags);
> +               status = d_revalidate(dentry,
> +                                     nd->flags | LOOKUP_ATOMIC_REVALIDATE);
>         }
>         if (unlikely(status <= 0)) {
>                 if (!status)
> @@ -1656,6 +1658,12 @@ static struct dentry *lookup_fast(struct nameidata *nd)
>                 dput(dentry);
>                 return ERR_PTR(status);
>         }
> +
> +       if (unlikely(d_atomic_open(dentry))) {
> +               dput(dentry);
> +               return NULL;
> +       }
> +

This looks like a hack.  Why not move the d_atomic_open() check to the caller?

>         return dentry;
>  }
>
> @@ -3421,7 +3429,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>                 if (d_in_lookup(dentry))
>                         break;
>
> -               error = d_revalidate(dentry, nd->flags);
> +               error = d_revalidate(dentry,
> +                                    nd->flags | LOOKUP_ATOMIC_REVALIDATE);
>                 if (likely(error > 0))
>                         break;
>                 if (error)
> @@ -3430,7 +3439,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>                 dput(dentry);
>                 dentry = NULL;
>         }
> -       if (dentry->d_inode) {
> +       if (dentry->d_inode && !d_atomic_open(dentry)) {
>                 /* Cached positive dentry: will open in f_op->open */
>                 return dentry;
>         }
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 6b351e009f59..f90eec22691c 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -208,6 +208,7 @@ struct dentry_operations {
>  #define DCACHE_FALLTHRU                        0x01000000 /* Fall through to lower layer */
>  #define DCACHE_NOKEY_NAME              0x02000000 /* Encrypted name encoded without key */
>  #define DCACHE_OP_REAL                 0x04000000
> +#define DCACHE_ATOMIC_OPEN             0x08000000 /* Always use ->atomic_open() to open this file */
>
>  #define DCACHE_PAR_LOOKUP              0x10000000 /* being looked up (with parent locked shared) */
>  #define DCACHE_DENTRY_CURSOR           0x20000000
> @@ -496,6 +497,11 @@ static inline bool d_is_fallthru(const struct dentry *dentry)
>         return dentry->d_flags & DCACHE_FALLTHRU;
>  }
>
> +static inline bool d_atomic_open(const struct dentry *dentry)
> +{
> +       return dentry->d_flags & DCACHE_ATOMIC_OPEN;
> +}
> +
>
>  extern int sysctl_vfs_cache_pressure;
>
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 1463cbda4888..7eec6c06b192 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -33,6 +33,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  #define LOOKUP_CREATE          0x0200  /* ... in object creation */
>  #define LOOKUP_EXCL            0x0400  /* ... in exclusive creation */
>  #define LOOKUP_RENAME_TARGET   0x0800  /* ... in destination of rename() */
> +#define LOOKUP_ATOMIC_REVALIDATE  0x1000 /* atomic revalidate possible */
>
>  /* internal use only */
>  #define LOOKUP_PARENT          0x0010
> --
> 2.34.1
>
