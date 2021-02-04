Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237D630F2B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 12:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhBDLvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 06:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbhBDLvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:51:38 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C1C061573;
        Thu,  4 Feb 2021 03:50:57 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id x81so2987333qkb.0;
        Thu, 04 Feb 2021 03:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pQoB5p1emxGuR6lyqESJhj2lnKa68LFvA3amb7bH7mE=;
        b=FusXReQq2xz0CSBFi2mQhZHOwD6X/VDG9vEQWnP4VAQt2zY3FZYW+Dz/CKURIm2c1v
         6wMtxDoyrRc/6Ph2YP/uus6AJFKtP19+jjCbBY6ET+4vh56o1C0/3iixUL9wpqeE34Mq
         dp/1cFO8r0buUxLwmQd+EUOzLHcdEEW5mhK43gCtKj8Y6M6fFRvuWoGusXcEssGY9J0z
         5GzK693Fbe0eDSgrLXVTBcSsUeuR9q+JgCbcpKYaRa38M2rxKEIQihFzpubyUaDdZIv3
         ZviSO5y6vRN81Xz5Yui3DRD409Yyz8oEog28ehrmVOtOotuZ3BWEdn7ZmNQ4FfPuCw0M
         nN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pQoB5p1emxGuR6lyqESJhj2lnKa68LFvA3amb7bH7mE=;
        b=ZQoh/7donZwf1MC0nruyOzGtesMQ36Xw0F1O64eWwcMGNO6ShKZ8BKVoRF3u7bSyX6
         E3s3fwuVMeCBw43A4gSCE+/Cq2ADwg62eaiCOJ784EdhjJNBqJoyq2UtOLvuG0k2WWf4
         h9XxZtbAVQP1RyfIZ3A0cBpuE3Qmpi4hyCUGpDEq/xS4/ODn1lkX4cMEAy5DCf4sUkhG
         2+42XZ0CWrvzkysHxkfUOph6KPTd0kmENsy+9ZgY4wUwwNm8ifx5T3kbKBqkfujB8OS9
         U4t1sd9AF742diFZMt3eoqKM9vJyVzYcRkiwtrOQkaRwdOsGFvF7/zoRxxlJ427CtVhE
         ZJsg==
X-Gm-Message-State: AOAM533HW3cb4bjr4y7YHS2oABKqk0YrvwEBRECLXA+Wv2FyYlo40/aJ
        EfJ2+Bf6iHTL9DjwuqIus+npcK+sjGvhIqdX/C+n1VSvyhSqZg==
X-Google-Smtp-Source: ABdhPJzmKltii+kkW/2bQ6fFvutDbwWPndZEZi8MI/WnFvyw3Xrau2qsERDIC0P720RqBRBm62e5wnBTG/s/qTRNhuI=
X-Received: by 2002:a37:4c8:: with SMTP id 191mr6712442qke.338.1612439456979;
 Thu, 04 Feb 2021 03:50:56 -0800 (PST)
MIME-Version: 1.0
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <5eabc4600691c618f34f8f39c156d9c094f2687b.1612434091.git.naohiro.aota@wdc.com>
In-Reply-To: <5eabc4600691c618f34f8f39c156d9c094f2687b.1612434091.git.naohiro.aota@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 4 Feb 2021 11:50:45 +0000
Message-ID: <CAL3q7H7UGEm14j1nNiX7FMkfdFq3dViw2o4uEdbZE+qpk7amLQ@mail.gmail.com>
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

On Thu, Feb 4, 2021 at 10:23 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> This is the 2/3 patch to enable tree-log on zoned filesystems.
>
> Since we can start more than one log transactions per subvolume
> simultaneously, nodes from multiple transactions can be allocated
> interleaved. Such mixed allocation results in non-sequential writes at th=
e
> time of a log transaction commit. The nodes of the global log root tree
> (fs_info->log_root_tree), also have the same problem with mixed
> allocation.
>
> Serializes log transactions by waiting for a committing transaction when
> someone tries to start a new transaction, to avoid the mixed allocation
> problem. We must also wait for running log transactions from another
> subvolume, but there is no easy way to detect which subvolume root is
> running a log transaction. So, this patch forbids starting a new log
> transaction when other subvolumes already allocated the global log root
> tree.
>
> Cc: Filipe Manana <fdmanana@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/tree-log.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index c02eeeac439c..8be3164d4c5d 100644
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

So, nothing here changed since v14 - all my comments still apply [1]
This is based on pre-5.10 code and is broken as it is - it results in
every fsync falling back to a transaction commit, defeating the
purpose of all the patches that deal with log trees on zoned
filesystems.

Thanks.

[1] https://lore.kernel.org/linux-btrfs/CAL3q7H5pv416FVwThOHe+M3L5B-z_n6_ZG=
QQxsUq5vC5fsAoJw@mail.gmail.com/


> +               if (ret)
> +                       goto out;
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
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
