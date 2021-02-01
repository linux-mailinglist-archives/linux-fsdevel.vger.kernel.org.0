Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2594A30ABE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 16:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBAPtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 10:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhBAPtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:49:46 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5AC0613D6;
        Mon,  1 Feb 2021 07:49:06 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k193so16627117qke.6;
        Mon, 01 Feb 2021 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=I54ajqQl0WrEHvpPFbW0YkpdVP0i1Gv7cRoXlHu3xqU=;
        b=V/Qqc8ELlLUoKjBYcNkhJQgwemRw0vlCUVyYidCvrUWRh3YD37HuApqwF9ekK0QGnL
         pAmw88nkLNQKy/JT8io3k/Uxed1gToD1tPgOvCHQgvwVsDFvEjZeCk33SRbXVet2gvBN
         GE6YDAJ4h+Ph/TUaM2aK8ssaBaR8Qh60mVZadSU4XIyBexWiwl6J8vJSLzZp8w6i2z+L
         Ce0M0ctZnfmJUkmq4oIrOam8ddXrhxv+jitqjhGklOfvZ3VzFIkIZFsLRG30ZDMAJJDR
         YgSDZHCybnAs1hlzEl7VBf9pIt47WK89sGvmd604z2qFAMJgqbIc/QX0NRa3TDllq2BF
         jT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=I54ajqQl0WrEHvpPFbW0YkpdVP0i1Gv7cRoXlHu3xqU=;
        b=s/2q/I3oRSms2DsWPllIgHU3SHR9wlwikMURROLEX7bCqQz4Ny0e7tFoG0a6W1GKLK
         ZDuHqcuySwdIEebHqAL0wKPmLHcJ3sxMhKouWSJKL1SDXqFkcrvTYvE1qJeuO0BntY0C
         s1wjKAz6LRokNgZTk419FIF7C0xAmz8y6WOQi44BArvDMynyJI9pL/VzVzzx1N+ecrtu
         FDmeO6lItUHy0tA0gg/D9dlJjuHt29on3875KjMGMz89uo5nC1mmTa7wFWbkuOhprywb
         3iqbTyVylOiqdCh+htd65965CPcvsAvy8WxE79q2W6WR8BM02PgT2lSIsugEU/xzVh5r
         PuZQ==
X-Gm-Message-State: AOAM532rXWw0+TUj0MN76ufKVaEiuNKJTohhyavrfS/MoHWC06PbgSkY
        1BClcKr3g7RO6o1/+jJ8P6WVohqLx4/cgQ6+klU=
X-Google-Smtp-Source: ABdhPJyCF+wJGrnjLZNX+mSXpqKeFjeqVOvbyWjXSnvotcr243etTOZPyaJisNVsqpTqsn17ENmjgI3jCBY/5Vr104g=
X-Received: by 2002:a37:6491:: with SMTP id y139mr15989197qkb.479.1612194545560;
 Mon, 01 Feb 2021 07:49:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611627788.git.naohiro.aota@wdc.com> <246db67fcf56240127a252f09742684cd30f4cfe.1611627788.git.naohiro.aota@wdc.com>
In-Reply-To: <246db67fcf56240127a252f09742684cd30f4cfe.1611627788.git.naohiro.aota@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 1 Feb 2021 15:48:54 +0000
Message-ID: <CAL3q7H7KYKgJgm2+C9WBW+F23tpdJukNZHQ8N-RxbyyC78B5xw@mail.gmail.com>
Subject: Re: [PATCH v14 42/42] btrfs: reorder log node allocation
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 6:48 PM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> This is the 3/3 patch to enable tree-log on ZONED mode.
>
> The allocation order of nodes of "fs_info->log_root_tree" and nodes of
> "root->log_root" is not the same as the writing order of them. So, the
> writing causes unaligned write errors.
>
> This patch reorders the allocation of them by delaying allocation of the
> root node of "fs_info->log_root_tree," so that the node buffers can go ou=
t
> sequentially to devices.
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/disk-io.c  |  7 -------
>  fs/btrfs/tree-log.c | 24 ++++++++++++++++++------
>  2 files changed, 18 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c3b5cfe4d928..d2b30716de84 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1241,18 +1241,11 @@ int btrfs_init_log_root_tree(struct btrfs_trans_h=
andle *trans,
>                              struct btrfs_fs_info *fs_info)
>  {
>         struct btrfs_root *log_root;
> -       int ret;
>
>         log_root =3D alloc_log_tree(trans, fs_info);
>         if (IS_ERR(log_root))
>                 return PTR_ERR(log_root);
>
> -       ret =3D btrfs_alloc_log_tree_node(trans, log_root);
> -       if (ret) {
> -               btrfs_put_root(log_root);
> -               return ret;
> -       }
> -
>         WARN_ON(fs_info->log_root_tree);
>         fs_info->log_root_tree =3D log_root;
>         return 0;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 71a1c0b5bc26..d8315363dc1e 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3159,6 +3159,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,
>         list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2=
]);
>         root_log_ctx.log_transid =3D log_root_tree->log_transid;
>
> +       mutex_lock(&fs_info->tree_log_mutex);
> +       if (!log_root_tree->node) {
> +               ret =3D btrfs_alloc_log_tree_node(trans, log_root_tree);
> +               if (ret) {
> +                       mutex_unlock(&fs_info->tree_log_mutex);
> +                       goto out;
> +               }
> +       }
> +       mutex_unlock(&fs_info->tree_log_mutex);

Hum, so this now has an impact for non-zoned mode.

It reduces the parallelism between a previous transaction finishing
its commit and an fsync started in the current transaction.

A transaction commit releases fs_info->tree_log_mutex after it commits
the super block.

By taking that mutex here, we wait for the transaction commit to write
the super blocks before we update the log root, start writeback of log
tree nodes and wait for the writeback to complete.

Before this change, we would do those 3 things before waiting for the
previous transaction to commit the super blocks.

So this undoes part of what was made by the following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D47876f7ceffa0e6af7476e052b3c061f1f2c1d9f

Which landed in 5.10. This patch and the rest of the patchset was
based on pre 5.10 code - was this missed because of that?
Or is there some other reason to have to do things this way for non-zoned m=
ode?

I think we should preserve the behaviour for non-zoned mode - i.e. any
reason why not allocating log_root_tree->node at the top of start
log_trans(), while under the protection of tree_root->log_mutex?

My impression is that this, and the other patch with the subject
"btrfs: serialize log transaction on ZONED mode", are out of sync with
the changes in 5.10.

Thanks, sorry for the late review.


> +
>         /*
>          * Now we are safe to update the log_root_tree because we're unde=
r the
>          * log_mutex, and we're a current writer so we're holding the com=
mit
> @@ -3317,12 +3327,14 @@ static void free_log_tree(struct btrfs_trans_hand=
le *trans,
>                 .process_func =3D process_one_buffer
>         };
>
> -       ret =3D walk_log_tree(trans, log, &wc);
> -       if (ret) {
> -               if (trans)
> -                       btrfs_abort_transaction(trans, ret);
> -               else
> -                       btrfs_handle_fs_error(log->fs_info, ret, NULL);
> +       if (log->node) {
> +               ret =3D walk_log_tree(trans, log, &wc);
> +               if (ret) {
> +                       if (trans)
> +                               btrfs_abort_transaction(trans, ret);
> +                       else
> +                               btrfs_handle_fs_error(log->fs_info, ret, =
NULL);
> +               }
>         }
>
>         clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
> --
> 2.27.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
