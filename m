Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5897587CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 14:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiHBMuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiHBMuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:50:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3963665E8
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 05:50:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b96so7151823edf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Aug 2022 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RoJV2wJ4KbDqOj+E/M+uEoPsAjfRx5p0+xqH+Wf97C0=;
        b=EZjGz9cfSrUEb1g8RAmPgEIWsC4LAV2uUdBVDNifF7PPrFK3EAlVctkaszK1xgEJu9
         MVMAG5Vx/10aMpdUbXoqblltfzcM9vHPhYTWtZy9Wu6T3uAat5FahAwzaZ60PEI7filB
         +bOIMahCrr1i51ZNdw/Xs5kvBLogAp+InEdpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RoJV2wJ4KbDqOj+E/M+uEoPsAjfRx5p0+xqH+Wf97C0=;
        b=htjlhBeEYMIF3wmOKjEpyRaSqdZIbsMK+w3pGxfaXJTsZ+mk5yLiTGZg60vx3U8i07
         9EDFhYEI750jM550ZkEHQQ+zUF+XNDOR9iMKxSpTAdIOyMNjsi9rSmVTq1KHd2OZOGIN
         Gq2rRqhFxsOnWnhpe1VPhtzhDXjAUT3xN1O2vpaWdo67Cc1i+GdDofZC7gQ1i53Lf3lx
         lt/xIGzbMbwKbqLqQPjeHfLviHHulEGGqqTzzS0c9tUrfDcj6tZByoHmo89PZ2lMqdOu
         tV/U7qdAoiNuNgaUPh6TYKrRKfcqM0NtOuX/j0zfE0ACO/25GT4yN4fQqV+j774qNtNc
         cHfg==
X-Gm-Message-State: AJIora+eSPSTj5zXih5Bp3/ZV1tXyM3B6T3ukPXsI8D5mfUKJFh33ZYY
        Fps4Jzh+fO6sWocfLAS3NAS2YM6VQJ1YHjlYQuuWiw==
X-Google-Smtp-Source: AGRyM1usnWfdQvEVZVYX75vJe2yLJEQa7jM3TmANtN36PTwsLRnqFCGbyBmZc0W/KRjSQuI+QiQVbqjyrtaqiTWogG8=
X-Received: by 2002:a05:6402:2b8d:b0:43a:5410:a9fc with SMTP id
 fj13-20020a0564022b8d00b0043a5410a9fcmr21254484edb.99.1659444643810; Tue, 02
 Aug 2022 05:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220727191949.GD18822@redhat.com> <YuGUyayVWDB7R89i@tycho.pizza>
 <20220728091220.GA11207@redhat.com> <YuL9uc8WfiYlb2Hw@tycho.pizza>
 <87pmhofr1q.fsf@email.froward.int.ebiederm.org> <YuPlqp0jSvVu4WBK@tycho.pizza>
 <87v8rfevz3.fsf@email.froward.int.ebiederm.org> <YuQPc51yXhnBHjIx@tycho.pizza>
 <87h72zes14.fsf_-_@email.froward.int.ebiederm.org> <20220729204730.GA3625@redhat.com>
 <YuR4MRL8WxA88il+@ZenIV> <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Aug 2022 14:50:32 +0200
Message-ID: <CAJfpegsTmiO-sKaBLgoVT4WxDXBkRES=HF1YmQN1ES7gfJEJ+w@mail.gmail.com>
Subject: Re: [RFC][PATCH v2] fuse: In fuse_flush only wait if someone wants
 the return code
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 30 Jul 2022 at 07:11, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> In my very light testing this resolves a hang where a thread of the
> fuse server was accessing the fuse filesystem (the fuse server is
> serving up), when the fuse server is killed.
>
> The practical problem is that the fuse server file descriptor was
> being closed after the file descriptor into the fuse filesystem so
> that the fuse filesystem operations were being blocked for instead of
> being aborted.  Simply skipping the unnecessary wait resolves this
> issue.
>
> This is just a proof of concept and someone should look to see if the
> fuse max_background limit could cause a problem with this approach.

max_background just throttles the number of background requests that
the userspace filesystem can *unqueue*.   It doesn't affect queuing in
any way.

> Additionally testing PF_EXITING is a very crude way to tell if someone
> wants the return code from the vfs flush operation.  As such in the
> long run it probably makes sense to get some direct vfs support for
> knowing if flush needs to block until all of the flushing is complete
> and a status/return code can be returned.
>
> Unless I have missed something this is a generic optimization that can
> apply to many network filesystems.
>
> Al, vfs folks? (igrab/iput sorted so as not to be distractions).
>
> Perhaps a .flush_async method without a return code and a
> filp_close_async function without a return code to take advantage of
> this in the general sense.
>
> Waiting potentially indefinitely for user space in do_exit seems like a
> bad idea.  Especially when all that the wait is for is to get a return
> code that will never be examined.

The wait is for posix locks to get unlocked.  But "remote" posix locks
are almost never used due to problems like this, so I think it's safe
to do this.

>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/fuse/file.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 05caa2b9272e..2bd94acd761f 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -464,6 +464,62 @@ static void fuse_sync_writes(struct inode *inode)
>         fuse_release_nowrite(inode);
>  }
>
> +struct fuse_flush_args {
> +       struct fuse_args args;
> +       struct fuse_flush_in inarg;
> +       struct inode *inode;
> +};
> +
> +static void fuse_flush_end(struct fuse_mount *fm, struct fuse_args *args, int err)
> +{
> +       struct fuse_flush_args *fa = container_of(args, typeof(*fa), args);
> +
> +       if (err == -ENOSYS) {
> +               fm->fc->no_flush = 1;
> +               err = 0;
> +       }
> +
> +       /*
> +        * In memory i_blocks is not maintained by fuse, if writeback cache is
> +        * enabled, i_blocks from cached attr may not be accurate.
> +        */
> +       if (!err && fm->fc->writeback_cache)
> +               fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);
> +
> +       iput(fa->inode);

Filesystems might expect not just he inode to not be destroyed but
also the file, so do what other file operations do, keep a ref on ff:

fuse_file_put(fa->ff, false, false);

> +       kfree(fa);
> +}
> +
> +static int fuse_flush_async(struct file *file, fl_owner_t id)
> +{
> +       struct inode *inode = file_inode(file);
> +       struct fuse_mount *fm = get_fuse_mount(inode);
> +       struct fuse_file *ff = file->private_data;
> +       struct fuse_flush_args *fa;
> +       int err;
> +
> +       fa = kzalloc(sizeof(*fa), GFP_KERNEL);
> +       if (!fa)
> +               return -ENOMEM;
> +
> +       fa->inarg.fh = ff->fh;
> +       fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
> +       fa->args.opcode = FUSE_FLUSH;
> +       fa->args.nodeid = get_node_id(inode);
> +       fa->args.in_numargs = 1;
> +       fa->args.in_args[0].size = sizeof(fa->inarg);
> +       fa->args.in_args[0].value = &fa->inarg;
> +       fa->args.force = true;
> +       fa->args.end = fuse_flush_end;
> +       fa->inode = igrab(inode);

fa->ff = fuse_file_get(ff);

> +
> +       err = fuse_simple_background(fm, &fa->args, GFP_KERNEL);
> +       if (err)
> +               fuse_flush_end(fm, &fa->args, err);
> +
> +       return err;
> +}
> +
>  static int fuse_flush(struct file *file, fl_owner_t id)
>  {
>         struct inode *inode = file_inode(file);
> @@ -495,6 +551,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
>         if (fm->fc->no_flush)
>                 goto inval_attr_out;
>
> +       if (current->flags & PF_EXITING)
> +               return fuse_flush_async(file, id);
> +
>         memset(&inarg, 0, sizeof(inarg));
>         inarg.fh = ff->fh;
>         inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
> --
> 2.35.3
>
