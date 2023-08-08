Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98172773DEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjHHQYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjHHQW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:22:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DECA26F
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 08:49:33 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b974031aeaso90466991fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1691509768; x=1692114568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mjjTXXAcYAfQBHkhSJDT/ZZzUMZhmxP9lOEvn/u21RQ=;
        b=KOQi4kCQeYUQ+1kLaIkIik3AkzcHr2tP4gJaYr348DJnXECdMhR+xm0iR6sCgS1oZ8
         BnBCev48wopel4w4DruTF28H21h/WjmlkGgDBzgttK44Rum65sLVDBu0EGrmFkSd3Z9I
         RZx4md/OZZxB9Ne6c+H485SCQRvZbQJYKEYSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509768; x=1692114568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjjTXXAcYAfQBHkhSJDT/ZZzUMZhmxP9lOEvn/u21RQ=;
        b=YV2bAmLSz3F4RiS8hFSStqAGkjLRyIUI2f2iGl8VVdrM/EeKoXQ37G2Xiox2WkUnFX
         6EezUtJVbIgjxz+yQ9quIdN6Om/j6AHrBxWB5uyEeuizPDcRLH9SJlcREsUNfi4z5its
         vhlb08bhkFXdcq+ce5TgdVua/zO/Lo9ZcdcH6OVwxGDMy48Q96jmW9/5Tp1Lj4DhOqix
         iUeck8uNgM3ch/y5asrnUdGv7Mg8GAywN050woKtPOUQtnLLQF1bEq/0I6Qd+dyMl/UY
         ZezpCC+ChCKGPCr/YSHRTL3mPHAOc6LJiwHl5YXa8yTXVVcER8eFa0aqk109EqjkDuy6
         5tRg==
X-Gm-Message-State: AOJu0Yw9GW1aiKOP2tlaZabQEn1SdMn6QQbJVYw4Z0yg2fQAOeEr3AGJ
        228MWzSrenPJKCugatMZEyYt4yFmwa39Si1l/1hPDGv4iyvR33ECnfxjLw==
X-Google-Smtp-Source: AGHT+IH5e9z5J71ajMIyvWEcHwEpFvu7pQcyVigECvH/+bwef9uocEzjfxyt+dbVngoOmIC0Yso9wozFmMCZrGQk78w=
X-Received: by 2002:a17:906:8a6b:b0:982:1936:ad27 with SMTP id
 hy11-20020a1709068a6b00b009821936ad27mr9941354ejc.11.1691497802595; Tue, 08
 Aug 2023 05:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230707132746.1892211-1-bschubert@ddn.com> <20230707132746.1892211-3-bschubert@ddn.com>
In-Reply-To: <20230707132746.1892211-3-bschubert@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 8 Aug 2023 14:29:51 +0200
Message-ID: <CAJfpegvxB37bHEAa=-Oeh26vQWx+rVxXt2BDJxe8RjAL43BhmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: introduce atomic open
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        fuse-devel@lists.sourceforge.net, vgoyal@redhat.com,
        dsingh@ddn.com, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Jul 2023 at 15:28, Bernd Schubert <bschubert@ddn.com> wrote:
>
> From: Dharmendra Singh <dsingh@ddn.com>
>
> This adds full atomic open support, to avoid lookup before open/create.
> If the implementation (fuse server/daemon) does not support atomic open
> it falls back to non-atomic open.
>
> Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dir.c             | 170 +++++++++++++++++++++++++++++++++++++-
>  fs/fuse/fuse_i.h          |   3 +
>  include/uapi/linux/fuse.h |   3 +
>  3 files changed, 175 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 6ffc573de470..8145bbfc7a40 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -724,7 +724,7 @@ static int _fuse_create_open(struct inode *dir, struct dentry *entry,
>
>  static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>                       umode_t, dev_t);
> -static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> +static int fuse_create_open(struct inode *dir, struct dentry *entry,
>                             struct file *file, unsigned flags,
>                             umode_t mode)
>  {
> @@ -770,6 +770,174 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>         return finish_no_open(file, res);
>  }
>
> +static int _fuse_atomic_open(struct inode *dir, struct dentry *entry,
> +                           struct file *file, unsigned flags,
> +                           umode_t mode)
> +{
> +
> +       int err;
> +       struct inode *inode;
> +       struct fuse_mount *fm = get_fuse_mount(dir);
> +       struct fuse_conn *fc = fm->fc;
> +       FUSE_ARGS(args);
> +       struct fuse_forget_link *forget;
> +       struct fuse_create_in inarg;
> +       struct fuse_open_out outopen;
> +       struct fuse_entry_out outentry;
> +       struct fuse_inode *fi;
> +       struct fuse_file *ff;
> +       struct dentry *res = NULL;
> +
> +       /* Userspace expects S_IFREG in create mode */
> +       if ((flags & O_CREAT) && (mode & S_IFMT) != S_IFREG) {
> +               WARN_ON(1);
> +               err = -EINVAL;
> +               goto out_err;
> +       }
> +       forget = fuse_alloc_forget();
> +       err = -ENOMEM;
> +       if (!forget)
> +               goto out_err;
> +
> +       err = -ENOMEM;
> +       ff = fuse_file_alloc(fm);
> +       if (!ff)
> +               goto out_put_forget_req;
> +
> +       if (!fc->dont_mask)
> +               mode &= ~current_umask();
> +
> +       flags &= ~O_NOCTTY;
> +       memset(&inarg, 0, sizeof(inarg));
> +       memset(&outentry, 0, sizeof(outentry));
> +       inarg.flags = flags;
> +       inarg.mode = mode;
> +       inarg.umask = current_umask();
> +
> +       if (fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
> +           !(flags & O_EXCL) && !capable(CAP_FSETID)) {
> +               inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
> +       }
> +
> +       args.opcode = FUSE_OPEN_ATOMIC;
> +       args.nodeid = get_node_id(dir);
> +       args.in_numargs = 2;
> +       args.in_args[0].size = sizeof(inarg);
> +       args.in_args[0].value = &inarg;
> +       args.in_args[1].size = entry->d_name.len + 1;
> +       args.in_args[1].value = entry->d_name.name;
> +       args.out_numargs = 2;
> +       args.out_args[0].size = sizeof(outentry);
> +       args.out_args[0].value = &outentry;
> +       args.out_args[1].size = sizeof(outopen);
> +       args.out_args[1].value = &outopen;
> +
> +       if (flags & O_CREAT) {
> +               err = get_create_ext(&args, dir, entry, mode);
> +               if (err)
> +                       goto out_free_ff;
> +       }
> +
> +       err = fuse_simple_request(fm, &args);

free_ext_value() missing.

Which also begs the question: can't _fuse_create_open() and
_fuse_atomic_open() be consolidated into a common helper?  There's
just too much duplication between them to warrant completely separate
implementations.

> +       if (err == -ENOSYS) {
> +               fc->no_open_atomic = 1;
> +               fuse_file_free(ff);
> +               kfree(forget);
> +               goto fallback;
> +       }
> +       if (err) {
> +               if (err == -ENOENT)
> +                       fuse_invalidate_entry_cache(entry);
> +               goto out_free_ff;
> +       }
> +
> +       err = -EIO;
> +       if (invalid_nodeid(outentry.nodeid) || fuse_invalid_attr(&outentry.attr))
> +               goto out_free_ff;
> +
> +       ff->fh = outopen.fh;
> +       ff->nodeid = outentry.nodeid;
> +       ff->open_flags = outopen.open_flags;
> +       inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
> +                         &outentry.attr, entry_attr_timeout(&outentry), 0);
> +       if (!inode) {
> +               flags &= ~(O_CREAT | O_EXCL | O_TRUNC);
> +               fuse_sync_release(NULL, ff, flags);
> +               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +               err = -ENOMEM;
> +               goto out_err;
> +       }
> +       if (d_in_lookup(entry)) {
> +               res = d_splice_alias(inode, entry);
> +               if (res) {
> +                       if (IS_ERR(res)) {
> +                               /*
> +                                * Close the file in user space, but do not unlink it,
> +                                * if it was created - with network file systems other
> +                                * clients might have already accessed it.
> +                                */
> +                               fi = get_fuse_inode(inode);
> +                               fuse_sync_release(fi, ff, flags);
> +                               fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> +                               err = PTR_ERR(res);
> +                               goto out_err;
> +                       }
> +                       entry = res;
> +               }
> +       } else
> +               d_instantiate(entry, inode);
> +       fuse_change_entry_timeout(entry, &outentry);
> +
> +       if (outopen.open_flags & FOPEN_FILE_CREATED) {
> +               if (!(flags & O_CREAT)) {
> +                       pr_debug("Server side bug, FOPEN_FILE_CREATED set "
> +                                "without O_CREAT, ignoring.");
> +               } else {
> +                       /* This should be always set when the file is created */
> +                       fuse_dir_changed(dir);
> +                       file->f_mode |= FMODE_CREATED;
> +               }
> +       }
> +
> +       if (!(flags & O_CREAT))
> +               fuse_advise_use_readdirplus(dir);

We advise to use readdirplus from lookup, because readdirplus can
substitute for a lookup.  But readdirplus cannot substitute for the
atomic open, so it's not a good idea to advise using readdirpuls in
this case.  At least that's how I see this.

Thanks,
Miklos
