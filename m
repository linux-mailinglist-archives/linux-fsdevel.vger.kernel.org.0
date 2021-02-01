Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20CB30ABE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBAPth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 10:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhBAPte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:49:34 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96509C061573;
        Mon,  1 Feb 2021 07:48:54 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x81so16652976qkb.0;
        Mon, 01 Feb 2021 07:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hUMMXC5iDRXzXVIcbJwpI6flgqD4hERm6u8i4HWSxbI=;
        b=c9mYmNDvjIgJTKoJoiGyQxS14o4yCswbYSMfREBhPIjSpMWY+GSYosP4gIYX5JkNPW
         gZwzSieP3HQwst8/59b0rFQhLXu23NfE1hvVuBtGPL51RLKsgU88a8jCdniCQgQ5Pk6l
         B09cK+GER7AJ0yoQ/nDwhk1OJuN/g++0ncCQXHDxjY2hkF1GD6CbPgeqtXRm+wbHfTvt
         r6PPDmUVpb9zsLlwnaA5/PHhVDTkZ2b8hF9rZqsxDz5Khotm6v7kbqZiD2X73nqXMeuq
         vnPT/aM63US5DKLOLRLf0tSTcQpMjSFzxvrT0bUqkiUeIUWdnXWPjM4JVrYee/Ez3oJ7
         WWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hUMMXC5iDRXzXVIcbJwpI6flgqD4hERm6u8i4HWSxbI=;
        b=rpr2fEa0KMw8um82ekc5rCkV9JCTCOek6h3o1dHjQyUcs/vsglcTtsVJveKKtOwrdl
         FM6qMcAitcrcEaENPj2v75PgiO5Ev45AjNyLkHrsWS2PrMOJKQehxYGQRiTOuHYYNeuT
         MRuuOgHELpaiemtkdti65KIR9imis42srnYiUXo7L9LhdWlUCN+d1UsYBHY0X6yUCQ/Z
         sltJYghWSG8lSrLE9po+GVLbPnktjXww76HVy4Cuu499hdGbQDQw58xqiFR5PajuhaL/
         w7gtplAoXnSNefvFenovSP/nWjdadGA+1DgHjOGpUlEtjwhd9tHSn+OBqnj2JIbCV65u
         vfyg==
X-Gm-Message-State: AOAM533ALcxYi2eiIExBWHFFOryqWKBzeyF1C43gkiTsuQNiT30sApRA
        wbAfGEW6xoDbEpg8EiDcT2mzGIbKFoi8QuX5QbM=
X-Google-Smtp-Source: ABdhPJy55LKieQvNyu+GmwsuMEITyRMrGrvgSt3FFIkyp0j98/Se4pgW12FGtwO0A90VUA9NShib+gHGYKwCk3LLwao=
X-Received: by 2002:a37:4c8:: with SMTP id 191mr15853830qke.338.1612194533837;
 Mon, 01 Feb 2021 07:48:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611627788.git.naohiro.aota@wdc.com> <cf8cd6170bd2283524a89a8192eeaba769a98fd6.1611627788.git.naohiro.aota@wdc.com>
In-Reply-To: <cf8cd6170bd2283524a89a8192eeaba769a98fd6.1611627788.git.naohiro.aota@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 1 Feb 2021 15:48:42 +0000
Message-ID: <CAL3q7H5pv416FVwThOHe+M3L5B-z_n6_ZGQQxsUq5vC5fsAoJw@mail.gmail.com>
Subject: Re: [PATCH v14 41/42] btrfs: serialize log transaction on ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 5:53 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> This is the 2/3 patch to enable tree-log on ZONED mode.
>
> Since we can start more than one log transactions per subvolume
> simultaneously, nodes from multiple transactions can be allocated
> interleaved. Such mixed allocation results in non-sequential writes at th=
e
> time of log transaction commit. The nodes of the global log root tree
> (fs_info->log_root_tree), also have the same mixed allocation problem.
>
> This patch serializes log transactions by waiting for a committing
> transaction when someone tries to start a new transaction, to avoid the
> mixed allocation problem. We must also wait for running log transactions
> from another subvolume, but there is no easy way to detect which subvolum=
e
> root is running a log transaction. So, this patch forbids starting a new
> log transaction when other subvolumes already allocated the global log ro=
ot
> tree.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/tree-log.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 930e752686b4..71a1c0b5bc26 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -105,6 +105,7 @@ static noinline int replay_dir_deletes(struct btrfs_t=
rans_handle *trans,
>                                        struct btrfs_root *log,
>                                        struct btrfs_path *path,
>                                        u64 dirid, int del_all);
> +static void wait_log_commit(struct btrfs_root *root, int transid);
>
>  /*
>   * tree logging is a special write ahead log used to make sure that
> @@ -140,6 +141,7 @@ static int start_log_trans(struct btrfs_trans_handle =
*trans,
>  {
>         struct btrfs_fs_info *fs_info =3D root->fs_info;
>         struct btrfs_root *tree_root =3D fs_info->tree_root;
> +       const bool zoned =3D btrfs_is_zoned(fs_info);
>         int ret =3D 0;
>
>         /*
> @@ -160,12 +162,20 @@ static int start_log_trans(struct btrfs_trans_handl=
e *trans,
>
>         mutex_lock(&root->log_mutex);
>
> +again:
>         if (root->log_root) {
> +               int index =3D (root->log_transid + 1) % 2;
> +
>                 if (btrfs_need_log_full_commit(trans)) {
>                         ret =3D -EAGAIN;
>                         goto out;
>                 }
>
> +               if (zoned && atomic_read(&root->log_commit[index])) {
> +                       wait_log_commit(root, root->log_transid - 1);
> +                       goto again;
> +               }
> +
>                 if (!root->log_start_pid) {
>                         clear_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->stat=
e);
>                         root->log_start_pid =3D current->pid;
> @@ -173,6 +183,17 @@ static int start_log_trans(struct btrfs_trans_handle=
 *trans,
>                         set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state)=
;
>                 }
>         } else {
> +               if (zoned) {
> +                       mutex_lock(&fs_info->tree_log_mutex);
> +                       if (fs_info->log_root_tree)
> +                               ret =3D -EAGAIN;
> +                       else
> +                               ret =3D btrfs_init_log_root_tree(trans, f=
s_info);
> +                       mutex_unlock(&fs_info->tree_log_mutex);
> +               }

Hum, so looking at this in the for-next branch, this does not seem to
make much sense now, probably because these patches started to be
developed before the following commit that landed in 5.10:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D47876f7ceffa0e6af7476e052b3c061f1f2c1d9f

So if we are the first task doing an fsync after a transaction commit,
and there are no other concurrent tasks doing an fsync:

1) We create fs_info->log_root_tree at the top of start_log_trans()
because test_bit(BTRFS_ROOT_HAS_LOG_TREE, &tree_root->state) returns
false;

2) Then, we enter this code for zoned mode only, and
fs_info->log_root_tree is not NULL, because we just created it before,
so we always return
     -EAGAIN and every fsync is converted to a full transaction commit.

For this case, of no concurrency, and being the first task doing an
fsync, it was not supposed to fallback to a transaction commit - that
defeats the goal of this patch unless I missed something.

Also, fs_info->log_root_tree is protected by tree_root->log_mutex and
not anymore by fs_info->tree_log_mutex (since that specific commit).

> +               if (ret)
> +                       goto out;

Also this "if (ret)" check could be moved inside the previous "if
(zoned)" block after unlocking the mutex.

Thanks, sorry for the very late review.

> +
>                 ret =3D btrfs_add_log_tree(trans, root);
>                 if (ret)
>                         goto out;
> @@ -201,14 +222,22 @@ static int start_log_trans(struct btrfs_trans_handl=
e *trans,
>   */
>  static int join_running_log_trans(struct btrfs_root *root)
>  {
> +       const bool zoned =3D btrfs_is_zoned(root->fs_info);
>         int ret =3D -ENOENT;
>
>         if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &root->state))
>                 return ret;
>
>         mutex_lock(&root->log_mutex);
> +again:
>         if (root->log_root) {
> +               int index =3D (root->log_transid + 1) % 2;
> +
>                 ret =3D 0;
> +               if (zoned && atomic_read(&root->log_commit[index])) {
> +                       wait_log_commit(root, root->log_transid - 1);
> +                       goto again;
> +               }
>                 atomic_inc(&root->log_writers);
>         }
>         mutex_unlock(&root->log_mutex);
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
