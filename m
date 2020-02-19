Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6F2164313
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgBSLLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 06:11:43 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44262 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgBSLLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:11:43 -0500
Received: by mail-il1-f194.google.com with SMTP id s85so20196375ill.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 03:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3J9sBFZ2g1DpC8eNWx0YGx0xb8tn/oD73qlJiO3TPY=;
        b=E+gasOfGs6Ar4lrTrGnI1i6XCWHnhi6syTz31qI/z6EyCwpgWLZCTOFoBsFbHxh9j1
         b71UeV7oE63PcbL7oC48hmbzKTjyQlFLnAGumc3SiktlFQqFhoRYqqeJqPL92OqBJD0D
         Zjdnm9QAMfJ/RpWQ0lqAPDwUWTJu/1pK7pTcD8nq1CXiKgR6SjovRi7Eg03GSqB5rHMh
         FQiNSmuIidBtZeDl7UhokLySMGUK+xqfGL8it/sB/gnDxJM1eNIM1e/j+545B3z70Uj+
         QQV10TRMy58FTayZfqPW1sRQimN/9X5tcDbT3DLAsbd5SrrjlN+POoLRhh0TTXorE8tq
         bpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3J9sBFZ2g1DpC8eNWx0YGx0xb8tn/oD73qlJiO3TPY=;
        b=MzxQPSQ2+TkKRBaAjWvX/0rnsXfmbfw9mWY2XriIz2By3l93FQ0I+MaKnP5fLis0NG
         GuSNHdcyJ4mbhc+MLKyKU04SO+f+X/5g/GwTPLlkNn0oRtdoiurxwAj87YIaHX2nq0tT
         Wp6uub+cSYc8yHCFXFiKlv24tXqVD3laKwbCOfejioJQqqOf5FP1QkoYRfwj/g429DFC
         vbxMvGL9aUnbQB4/qudcW74z9baJFNWHVWGCds8N4H6zrDH7JinQ7asAfLQ112qR/B3I
         ENqECrR2VF6zh9ndUHdCzDiV7u/qJB87/OoBUJkXRX+Esfngbl9uQ7tsT0siuC/aAGxb
         Md5w==
X-Gm-Message-State: APjAAAWQ8ebEiMYgMyeNrFchOo+2+lRZWlctTKDtIM+XiVs/iuX4dNZ0
        Fdm7QGpRrKb+O6RtHakaXnPkTESMW/aph83vtb/BSA==
X-Google-Smtp-Source: APXvYqz4kVVGJys4AP7MPfu2Q3gmJDbjnlNxbTjfleC7tGJk/bI/OS7RRZ4eWH5DqrFFX4YjvuOky19atoqNMS7TmNA=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr23653057ilq.250.1582110702535;
 Wed, 19 Feb 2020 03:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-6-amir73il@gmail.com>
In-Reply-To: <20200217131455.31107-6-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Feb 2020 13:11:31 +0200
Message-ID: <CAOQ4uxghADV42ybW0U628ZHs65O0beu7s84msswp_zDAep0p+g@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] fsnotify: simplify arguments passing to fsnotify_parent()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 3:15 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Instead of passing both dentry and path and having to figure out which
> one to use, pass data/data_type to simplify the code.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fsnotify.c             | 15 ++++-----------
>  include/linux/fsnotify.h         | 14 ++------------
>  include/linux/fsnotify_backend.h | 13 +++++++------
>  3 files changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index a5d6467f89a0..193530f57963 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -143,15 +143,13 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  }
>
>  /* Notify this dentry's parent about a child's events. */
> -int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
> +int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> +                   int data_type)
>  {
>         struct dentry *parent;
>         struct inode *p_inode;
>         int ret = 0;
>
> -       if (!dentry)
> -               dentry = path->dentry;
> -
>         if (!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))
>                 return 0;
>
> @@ -168,12 +166,7 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
>                 mask |= FS_EVENT_ON_CHILD;
>
>                 take_dentry_name_snapshot(&name, dentry);
> -               if (path)
> -                       ret = fsnotify(p_inode, mask, path, FSNOTIFY_EVENT_PATH,
> -                                      &name.name, 0);
> -               else
> -                       ret = fsnotify(p_inode, mask, dentry->d_inode, FSNOTIFY_EVENT_INODE,
> -                                      &name.name, 0);
> +               ret = fsnotify(p_inode, mask, data, data_type, &name.name, 0);
>                 release_dentry_name_snapshot(&name);
>         }
>
> @@ -181,7 +174,7 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
>
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(__fsnotify_parent);
> +EXPORT_SYMBOL_GPL(fsnotify_parent);
>
>  static int send_to_group(struct inode *to_tell,
>                          __u32 mask, const void *data,
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 420aca9fd5f4..af30e0a56f2e 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -38,16 +38,6 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
>         fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
>  }
>
> -/* Notify this dentry's parent about a child's events. */
> -static inline int fsnotify_parent(const struct path *path,
> -                                 struct dentry *dentry, __u32 mask)
> -{
> -       if (!dentry)
> -               dentry = path->dentry;
> -
> -       return __fsnotify_parent(path, dentry, mask);
> -}
> -
>  /*
>   * Simple wrappers to consolidate calls fsnotify_parent()/fsnotify() when
>   * an event is on a file/dentry.
> @@ -59,7 +49,7 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
>         if (S_ISDIR(inode->i_mode))
>                 mask |= FS_ISDIR;
>
> -       fsnotify_parent(NULL, dentry, mask);
> +       fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
>         fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
>  }
>
> @@ -75,7 +65,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>         if (S_ISDIR(inode->i_mode))
>                 mask |= FS_ISDIR;
>
> -       ret = fsnotify_parent(path, NULL, mask);
> +       ret = fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
>         if (ret)
>                 return ret;
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 5cc838db422a..b1f418cc28e1 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -376,9 +376,10 @@ struct fsnotify_mark {
>  /* called from the vfs helpers */
>
>  /* main fsnotify call to send events */
> -extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
> -                   const struct qstr *name, u32 cookie);
> -extern int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask);
> +extern int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
> +                   int data_type, const struct qstr *name, u32 cookie);
> +extern int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> +                          int data_type);
>  extern void __fsnotify_inode_delete(struct inode *inode);
>  extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
>  extern void fsnotify_sb_delete(struct super_block *sb);
> @@ -533,13 +534,13 @@ static inline void fsnotify_init_event(struct fsnotify_event *event,
>
>  #else
>
> -static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
> -                          const struct qstr *name, u32 cookie)
> +static inline int fsnotify(struct inode *to_tell, __u32 mask, const void *data,
> +                          int data_type, const struct qstr *name, u32 cookie)
>  {
>         return 0;
>  }
>
> -static inline int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
> +static inline int fsnotify_parent(__u32 mask, const void *data, int data_type)

This should be:

+static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
const void *data, int data_type)

Will squash the fix.

Thanks kbuild test robot,
Amir.
