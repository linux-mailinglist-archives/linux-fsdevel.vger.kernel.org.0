Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E4150BBB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449476AbiDVPcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449510AbiDVPct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:32:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0630BC6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 08:29:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s18so17183898ejr.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3ndCcoKSfgDdwTgox1SYrm0TgUghFUDkVmxzCUPpWI=;
        b=CI/7eNrAZWppSmvGj7Ei/huCBNooS5x/94tgY7F08MECG0LFS9LDb8Ez8Z9MObCngr
         IT9Ew4iQRcE3HdHzTMkh8bot08REiR6caysRhsnXnVB6hMfzLskH3UJG/UPKUlzDLoEd
         SFybgBnrJgrBZ0D/Nwiw80CyvlET//V1rBuIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3ndCcoKSfgDdwTgox1SYrm0TgUghFUDkVmxzCUPpWI=;
        b=mfQa+/IpN9PJQt9/AwozJaNgfHFMgQAHu1MhdN/rYOiYDgaWL9qw1b6bUgs+9FY1op
         G8JkjXLqsx+YKvXQieWbeOQ0RxeT6gWO9JUfD5KpyPokVgzDLEiLwMKXMXW8yhgiU7hW
         NgMU+N6y7Shbk1PnLWmdsBMavd5RZk8HrcMBRf3tzwNUaoZp8IpDViyIYqixB/t87jP0
         KM1dzib6/gZw7hjZX0dDqh1Lfu4mxKY19zC3rm527Xq/JlwUOJ+v2ooW9vFftMVCk9n6
         cgNhzqcHubGbT+4WwQ0S5hACBejWcm2sKrvt8ngH+j+DrGpVdVVOmYUu1CkqAwL/V6/y
         hJtw==
X-Gm-Message-State: AOAM530UM9XMkcJl2WtlwIuTJoB77MsX5wkmTiQIxD7ITwMs+XRp1oRs
        eeq+5jVAtHz8TQGvP5U6HBoHp49M4rrEvwWtZxYNaA==
X-Google-Smtp-Source: ABdhPJy1at9+LCOaoCzkJdFtaQNyYQdt70weIoAhFlcg+F9RTA+dfPK4ONhY88KREMaYRWFFa0Ko6wL4MnVM1pZ5ZYQ=
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id
 l8-20020a170906794800b006da64ed178emr4797983ejo.523.1650641392357; Fri, 22
 Apr 2022 08:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220322115148.3870-1-dharamhans87@gmail.com> <20220322115148.3870-2-dharamhans87@gmail.com>
In-Reply-To: <20220322115148.3870-2-dharamhans87@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 22 Apr 2022 17:29:40 +0200
Message-ID: <CAJfpegtunCe5hV1b9cKJgPk44B2SQgtK3RG5r2is8V5VrMYeNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] FUSE: Implement atomic lookup + open
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Mar 2022 at 12:52, Dharmendra Singh <dharamhans87@gmail.com> wrote:
>
> From: Dharmendra Singh <dsingh@ddn.com>
>
> There are couple of places in FUSE where we do agressive
> lookup.
> 1) When we go for creating a file (O_CREAT), we do lookup
> for non-existent file. It is very much likely that file
> does not exists yet as O_CREAT is passed to open(). This
> lookup can be avoided and can be performed  as part of
> open call into libfuse.
>
> 2) When there is normal open for file/dir (dentry is
> new/negative). In this case since we are anyway going to open
> the file/dir with USER space, avoid this separate lookup call
> into libfuse and combine it with open.
>
> This lookup + open in single call to libfuse and finally to
> USER space has been named as atomic open. It is expected
> that USER space open the file and fills in the attributes
> which are then used to make inode stand/revalidate in the
> kernel cache.
>
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> ---
> v2 patch includes:
> - disabled o-create atomicity when the user space file system
>   does not have an atomic_open implemented. In principle lookups
>   for O_CREATE also could be optimized out, but there is a risk
>   to break existing fuse file systems. Those file system might
>   not expect open O_CREATE calls for exiting files, as these calls
>   had been so far avoided as lookup was done first.

So we enabling atomic lookup+create only if FUSE_DO_ATOMIC_OPEN is
set.  This logic is a bit confusing as CREATE is unrelated to
ATOMIC_OPEN.   It would be cleaner to have a separate flag for atomic
lookup+create.  And in fact FUSE_DO_ATOMIC_OPEN could be dropped and
the usual logic of setting fc->no_atomic_open if ENOSYS is returned
could be used instead.

>
>  fs/fuse/dir.c             | 113 +++++++++++++++++++++++++++++++-------
>  fs/fuse/fuse_i.h          |   3 +
>  fs/fuse/inode.c           |   4 +-
>  include/uapi/linux/fuse.h |   2 +
>  4 files changed, 101 insertions(+), 21 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 656e921f3506..b2613eb87a4e 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -516,16 +516,14 @@ static int get_security_context(struct dentry *entry, umode_t mode,
>  }
>
>  /*
> - * Atomic create+open operation
> - *
> - * If the filesystem doesn't support this, then fall back to separate
> - * 'mknod' + 'open' requests.
> + * Perform create + open or lookup + open in single call to libfuse
>   */
> -static int fuse_create_open(struct inode *dir, struct dentry *entry,
> -                           struct file *file, unsigned int flags,
> -                           umode_t mode)
> +static int fuse_atomic_open_common(struct inode *dir, struct dentry *entry,
> +                                  struct dentry **alias, struct file *file,
> +                                  unsigned int flags, umode_t mode,
> +                                  uint32_t opcode)
>  {
> -       int err;
> +       bool create = (opcode == FUSE_CREATE ? true : false);
>         struct inode *inode;
>         struct fuse_mount *fm = get_fuse_mount(dir);
>         FUSE_ARGS(args);
> @@ -535,11 +533,16 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         struct fuse_entry_out outentry;
>         struct fuse_inode *fi;
>         struct fuse_file *ff;
> +       struct dentry *res = NULL;
>         void *security_ctx = NULL;
>         u32 security_ctxlen;
> +       int err;
> +
> +       if (alias)
> +               *alias = NULL;
>
>         /* Userspace expects S_IFREG in create mode */
> -       BUG_ON((mode & S_IFMT) != S_IFREG);
> +       BUG_ON(create && (mode & S_IFMT) != S_IFREG);
>
>         forget = fuse_alloc_forget();
>         err = -ENOMEM;
> @@ -554,7 +557,13 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         if (!fm->fc->dont_mask)
>                 mode &= ~current_umask();
>
> -       flags &= ~O_NOCTTY;
> +       if (!create) {
> +               flags = flags & ~(O_CREAT | O_EXCL | O_NOCTTY);

We know O_CREAT and O_EXCL are not set in this case.

> +               if (!fm->fc->atomic_o_trunc)
> +                       flags &= ~O_TRUNC;

I think atomic_open should imply atomic_o_trunc.  Not worth
complicating this further with a separate case.

> +       } else {
> +               flags &= ~O_NOCTTY;
> +       }
>         memset(&inarg, 0, sizeof(inarg));
>         memset(&outentry, 0, sizeof(outentry));
>         inarg.flags = flags;
> @@ -566,7 +575,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>                 inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
>         }
>
> -       args.opcode = FUSE_CREATE;
> +       args.opcode = opcode;
>         args.nodeid = get_node_id(dir);
>         args.in_numargs = 2;
>         args.in_args[0].size = sizeof(inarg);
> @@ -595,8 +604,12 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         if (err)
>                 goto out_free_ff;
>
> +       err = -ENOENT;
> +       if (!S_ISDIR(outentry.attr.mode) && !outentry.nodeid)
> +               goto out_free_ff;
> +
>         err = -EIO;
> -       if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
> +       if (invalid_nodeid(outentry.nodeid) ||
>             fuse_invalid_attr(&outentry.attr))
>                 goto out_free_ff;
>
> @@ -612,10 +625,32 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>                 err = -ENOMEM;
>                 goto out_err;
>         }
> +       if (!fm->fc->do_atomic_open)
> +               d_instantiate(entry, inode);
> +       else {
> +               res = d_splice_alias(inode, entry);
> +               if (res) {
> +                       /* Close the file in user space, but do not unlink it,
> +                        * if it was created - with network file systems other
> +                        * clients might have already accessed it.
> +                        */
> +                       if (IS_ERR(res)) {
> +                               fi = get_fuse_inode(inode);
> +                               fuse_sync_release(fi, ff, flags);
> +                               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +                               err = PTR_ERR(res);
> +                               goto out_err;
> +                       } else {
> +                               entry = res;
> +                               if (alias)
> +                                       *alias = res;
> +                       }
> +               }
> +       }
>         kfree(forget);
> -       d_instantiate(entry, inode);
>         fuse_change_entry_timeout(entry, &outentry);
> -       fuse_dir_changed(dir);
> +       if (create)
> +               fuse_dir_changed(dir);

This will invalidate the parent even if the file was not created.
Userspace will have to indicate whether the file was created or not as
the kernel won't be able to determine this otherwise.  This affects
permission checking as well.

>         err = finish_open(file, entry, generic_file_open);
>         if (err) {
>                 fi = get_fuse_inode(inode);
> @@ -634,20 +669,54 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
>         return err;
>  }
>
> +/*
> + * Atomic lookup + open
> + */
> +
> +static int fuse_do_atomic_open(struct inode *dir, struct dentry *entry,
> +                              struct dentry **alias, struct file *file,
> +                              unsigned int flags, umode_t mode)
> +{
> +       int err;
> +       struct fuse_conn *fc = get_fuse_conn(dir);
> +
> +       if (!fc->do_atomic_open)
> +               return -ENOSYS;
> +       err = fuse_atomic_open_common(dir, entry, alias, file,
> +                                     flags, mode, FUSE_ATOMIC_OPEN);
> +       return err;
> +}
> +
>  static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
>                       umode_t, dev_t);
>  static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>                             struct file *file, unsigned flags,
>                             umode_t mode)
>  {
> -       int err;
> +       bool create = (flags & O_CREAT) ? true : false;
>         struct fuse_conn *fc = get_fuse_conn(dir);
> -       struct dentry *res = NULL;
> +       struct dentry *res = NULL, *alias = NULL;
> +       int err;
>
>         if (fuse_is_bad(dir))
>                 return -EIO;
>
> -       if (d_in_lookup(entry)) {
> +       /* Atomic lookup + open - dentry might be File or Directory */
> +       if (!create) {
> +               err = fuse_do_atomic_open(dir, entry, &alias, file, flags, mode);
> +               res = alias;
> +               if (!err)
> +                       goto out_dput;
> +               else if (err != -ENOSYS)
> +                       goto no_open;

The above looks bogus.  On error we just want to return that error,
not finish the open.

> +       }
> +       /* ENOSYS fall back - user space does not have full atomic open.*/
> +
> +       /* O_CREAT could be optimized already, but we fear to break some
> +        * userspace implementations therefore optimize in case of atomic
> +        * open only.
> +        */
> +       if (!fc->do_atomic_open && d_in_lookup(entry))  {
>                 res = fuse_lookup(dir, entry, 0);
>                 if (IS_ERR(res))
>                         return PTR_ERR(res);
> @@ -656,7 +725,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>                         entry = res;
>         }
>
> -       if (!(flags & O_CREAT) || d_really_is_positive(entry))
> +       if (!create || d_really_is_positive(entry))
>                 goto no_open;
>
>         /* Only creates */
> @@ -664,8 +733,12 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>
>         if (fc->no_create)
>                 goto mknod;
> -
> -       err = fuse_create_open(dir, entry, file, flags, mode);
> +       /*
> +        * If the filesystem doesn't support atomic create + open, then fall
> +        * back to separate 'mknod' + 'open' requests.
> +        */
> +       err = fuse_atomic_open_common(dir, entry, NULL, file, flags, mode,
> +                                     FUSE_CREATE);
>         if (err == -ENOSYS) {
>                 fc->no_create = 1;
>                 goto mknod;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index e8e59fbdefeb..e4dc68a90b28 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -669,6 +669,9 @@ struct fuse_conn {
>         /** Is open/release not implemented by fs? */
>         unsigned no_open:1;
>
> +       /** Does the filesystem support atomic open? */
> +       unsigned do_atomic_open:1;
> +
>         /** Is opendir/releasedir not implemented by fs? */
>         unsigned no_opendir:1;
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index ee846ce371d8..5f667de69115 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1190,6 +1190,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>                                 fc->setxattr_ext = 1;
>                         if (flags & FUSE_SECURITY_CTX)
>                                 fc->init_security = 1;
> +                       if (flags & FUSE_DO_ATOMIC_OPEN)
> +                               fc->do_atomic_open = 1;
>                 } else {
>                         ra_pages = fc->max_read / PAGE_SIZE;
>                         fc->no_lock = 1;
> @@ -1235,7 +1237,7 @@ void fuse_send_init(struct fuse_mount *fm)
>                 FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
>                 FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
>                 FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
> -               FUSE_SECURITY_CTX;
> +               FUSE_SECURITY_CTX | FUSE_DO_ATOMIC_OPEN;
>  #ifdef CONFIG_FUSE_DAX
>         if (fm->fc->dax)
>                 flags |= FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..a28dd60078ff 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -389,6 +389,7 @@ struct fuse_file_lock {
>  /* bits 32..63 get shifted down 32 bits into the flags2 field */
>  #define FUSE_SECURITY_CTX      (1ULL << 32)
>  #define FUSE_HAS_INODE_DAX     (1ULL << 33)
> +#define FUSE_DO_ATOMIC_OPEN    (1ULL << 34)
>
>  /**
>   * CUSE INIT request/reply flags
> @@ -537,6 +538,7 @@ enum fuse_opcode {
>         FUSE_SETUPMAPPING       = 48,
>         FUSE_REMOVEMAPPING      = 49,
>         FUSE_SYNCFS             = 50,
> +       FUSE_ATOMIC_OPEN        = 51,
>
>         /* CUSE specific operations */
>         CUSE_INIT               = 4096,
> --
> 2.17.1
>
