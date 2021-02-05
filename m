Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C37310A36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 12:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBELYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 06:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhBELWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:22:11 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77876C061786;
        Fri,  5 Feb 2021 03:21:31 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id e11so4659768qtg.6;
        Fri, 05 Feb 2021 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=n63PCZmjecm1Kt+KnVOZRm5DeZvW/I4x9Xo7ew9oBXY=;
        b=MQn3c4ZMzhdiKVdnUgU5Hkn0+/JuTPEeBOukCdpdL10b/2vj1InJbzWbZy2LO+v2eL
         vB19NutgiAyYIvBtrS6KVUC4Im3LEZ6QXSaQnTkpcs2N4nK0qOTokPnfKEqvlfoP0Dc/
         3gXh0if/m+a38JRMq8H8Uy8kiwTQSkUuEqmHMdm/CCrsT2B/QlhL4EZO23o0utVIzth+
         DS7+cxkIO51eKJIxCRD2ZJp4/ajqHZg12XL/DjB37ot7mYvqMfNAdy59iWa7ZHqCTwKv
         Qsy0gH+xWIOWDBB+CaCtcxR1U2a4x0wUACqK/+k8HhWVOxvswgMED27xRHXI25KtnLaz
         w5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=n63PCZmjecm1Kt+KnVOZRm5DeZvW/I4x9Xo7ew9oBXY=;
        b=RQXeBdu0LGmC8HxRk0mLCLX29kZJkqzSgrZ9ZlhxKAfoAatv7zxtx/3tRXrQ7L8Xe/
         zWBcWedqQAE6y9n6BjAaLe1magbRjBpd3SGG5FlvytBMsccvLTlh+N+KtkEowRJmAWUa
         MmhsLGALnhBf5rmOfETxj73KbjFwW0jmeRWyvPz+EC3kXFxr0UvyKXSQpQTsa8GknX/x
         WCvg5jhYB+9tUsxkyCme0f+64pS9tOeB3QHxFVsj26R95v9bmGBzZvmeSHVHIK7mkZ6w
         pTFnQ7HTNkqvamKQ+P049pCYrx8Fun1Ld+XBr5ts2PA9/4TMcUt9TKKM3JvtWjynB45F
         WaHg==
X-Gm-Message-State: AOAM532u9rz4f+gYTBTTraCt9By3JKEnr2DVlC08UlM4UOk9MWBk0bx8
        /MZDZ/p21cVjoxHf/sPOcPJNySq4N1P1+WttZGlI2MhZkyU=
X-Google-Smtp-Source: ABdhPJyCF7SiIg8Np22esfLYmtR89wpZh4G8X68LRuo29O1DKQTrInlQIljvsJ0vsRBGGvCv+buR9jDT4cFlDrEoAlE=
X-Received: by 2002:aed:2f01:: with SMTP id l1mr3766902qtd.21.1612524090656;
 Fri, 05 Feb 2021 03:21:30 -0800 (PST)
MIME-Version: 1.0
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <5eabc4600691c618f34f8f39c156d9c094f2687b.1612434091.git.naohiro.aota@wdc.com>
 <20210205091516.l3nkvig7swburnxx@naota-xeon>
In-Reply-To: <20210205091516.l3nkvig7swburnxx@naota-xeon>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 5 Feb 2021 11:21:19 +0000
Message-ID: <CAL3q7H628ivfaObKuAeo6A7mT4ONNebrAJGWP-ADSVQJ7DLWwA@mail.gmail.com>
Subject: Re: [PATCH v15 40/42] btrfs: zoned: serialize log transaction on
 zoned filesystems
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 9:15 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> David, could you fold the below incremental diff to this patch? Or, I
> can send a full replacement patch.
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 8be3164d4c5d..4e72794342c0 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -143,6 +143,7 @@ static int start_log_trans(struct btrfs_trans_handle =
*trans,
>         struct btrfs_root *tree_root =3D fs_info->tree_root;
>         const bool zoned =3D btrfs_is_zoned(fs_info);
>         int ret =3D 0;
> +       bool created =3D false;
>
>         /*
>          * First check if the log root tree was already created. If not, =
create
> @@ -152,8 +153,10 @@ static int start_log_trans(struct btrfs_trans_handle=
 *trans,
>                 mutex_lock(&tree_root->log_mutex);
>                 if (!fs_info->log_root_tree) {
>                         ret =3D btrfs_init_log_root_tree(trans, fs_info);
> -                       if (!ret)
> +                       if (!ret) {
>                                 set_bit(BTRFS_ROOT_HAS_LOG_TREE, &tree_ro=
ot->state);
> +                               created =3D true;
> +                       }
>                 }
>                 mutex_unlock(&tree_root->log_mutex);
>                 if (ret)
> @@ -183,16 +186,16 @@ static int start_log_trans(struct btrfs_trans_handl=
e *trans,
>                         set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state)=
;
>                 }
>         } else {
> -               if (zoned) {
> -                       mutex_lock(&fs_info->tree_log_mutex);
> -                       if (fs_info->log_root_tree)
> -                               ret =3D -EAGAIN;
> -                       else
> -                               ret =3D btrfs_init_log_root_tree(trans, f=
s_info);
> -                       mutex_unlock(&fs_info->tree_log_mutex);
> -               }
> -               if (ret)
> +               /*
> +                * This means fs_info->log_root_tree was already created
> +                * for some other FS trees. Do the full commit not to mix
> +                * nodes from multiple log transactions to do sequential
> +                * writing.
> +                */
> +               if (zoned && !created) {
> +                       ret =3D -EAGAIN;
>                         goto out;
> +               }
>
>                 ret =3D btrfs_add_log_tree(trans, root);
>                 if (ret)
>

Ok, with this, it looks good to me and you can have,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
> On Thu, Feb 04, 2021 at 07:22:19PM +0900, Naohiro Aota wrote:
> > This is the 2/3 patch to enable tree-log on zoned filesystems.
> >
> > Since we can start more than one log transactions per subvolume
> > simultaneously, nodes from multiple transactions can be allocated
> > interleaved. Such mixed allocation results in non-sequential writes at =
the
> > time of a log transaction commit. The nodes of the global log root tree
> > (fs_info->log_root_tree), also have the same problem with mixed
> > allocation.
> >
> > Serializes log transactions by waiting for a committing transaction whe=
n
> > someone tries to start a new transaction, to avoid the mixed allocation
> > problem. We must also wait for running log transactions from another
> > subvolume, but there is no easy way to detect which subvolume root is
> > running a log transaction. So, this patch forbids starting a new log
> > transaction when other subvolumes already allocated the global log root
> > tree.
> >
> > Cc: Filipe Manana <fdmanana@gmail.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/tree-log.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index c02eeeac439c..8be3164d4c5d 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -105,6 +105,7 @@ static noinline int replay_dir_deletes(struct btrfs=
_trans_handle *trans,
> >                                      struct btrfs_root *log,
> >                                      struct btrfs_path *path,
> >                                      u64 dirid, int del_all);
> > +static void wait_log_commit(struct btrfs_root *root, int transid);
> >
> >  /*
> >   * tree logging is a special write ahead log used to make sure that
> > @@ -140,6 +141,7 @@ static int start_log_trans(struct btrfs_trans_handl=
e *trans,
> >  {
> >       struct btrfs_fs_info *fs_info =3D root->fs_info;
> >       struct btrfs_root *tree_root =3D fs_info->tree_root;
> > +     const bool zoned =3D btrfs_is_zoned(fs_info);
> >       int ret =3D 0;
> >
> >       /*
> > @@ -160,12 +162,20 @@ static int start_log_trans(struct btrfs_trans_han=
dle *trans,
> >
> >       mutex_lock(&root->log_mutex);
> >
> > +again:
> >       if (root->log_root) {
> > +             int index =3D (root->log_transid + 1) % 2;
> > +
> >               if (btrfs_need_log_full_commit(trans)) {
> >                       ret =3D -EAGAIN;
> >                       goto out;
> >               }
> >
> > +             if (zoned && atomic_read(&root->log_commit[index])) {
> > +                     wait_log_commit(root, root->log_transid - 1);
> > +                     goto again;
> > +             }
> > +
> >               if (!root->log_start_pid) {
> >                       clear_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->stat=
e);
> >                       root->log_start_pid =3D current->pid;
> > @@ -173,6 +183,17 @@ static int start_log_trans(struct btrfs_trans_hand=
le *trans,
> >                       set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state)=
;
> >               }
> >       } else {
> > +             if (zoned) {
> > +                     mutex_lock(&fs_info->tree_log_mutex);
> > +                     if (fs_info->log_root_tree)
> > +                             ret =3D -EAGAIN;
> > +                     else
> > +                             ret =3D btrfs_init_log_root_tree(trans, f=
s_info);
> > +                     mutex_unlock(&fs_info->tree_log_mutex);
> > +             }
> > +             if (ret)
> > +                     goto out;
> > +
> >               ret =3D btrfs_add_log_tree(trans, root);
> >               if (ret)
> >                       goto out;
> > @@ -201,14 +222,22 @@ static int start_log_trans(struct btrfs_trans_han=
dle *trans,
> >   */
> >  static int join_running_log_trans(struct btrfs_root *root)
> >  {
> > +     const bool zoned =3D btrfs_is_zoned(root->fs_info);
> >       int ret =3D -ENOENT;
> >
> >       if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &root->state))
> >               return ret;
> >
> >       mutex_lock(&root->log_mutex);
> > +again:
> >       if (root->log_root) {
> > +             int index =3D (root->log_transid + 1) % 2;
> > +
> >               ret =3D 0;
> > +             if (zoned && atomic_read(&root->log_commit[index])) {
> > +                     wait_log_commit(root, root->log_transid - 1);
> > +                     goto again;
> > +             }
> >               atomic_inc(&root->log_writers);
> >       }
> >       mutex_unlock(&root->log_mutex);
> > --
> > 2.30.0
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
