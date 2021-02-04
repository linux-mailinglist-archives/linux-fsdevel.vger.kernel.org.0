Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D854F30F2C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 12:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhBDL6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 06:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbhBDL6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:58:15 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA691C061573;
        Thu,  4 Feb 2021 03:57:34 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z22so2107002qto.7;
        Thu, 04 Feb 2021 03:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UklazaNAycz2BFsJtlkthid2wC2kf6KqSFJIrZZTFqE=;
        b=MIezhuXYhG2D0R9kN2+/693HsVznla+jJAQSYJIa0kNaGGnMVC5X+kKrKP5vslBpYH
         edLxX9VVhPuBm0omPBu6Sr32lwLnQgUoO+3/aPxeAFZy4iDulcVAxpKpP5qg6rRcgkrF
         1/n9cf4OpnyT9/xez9+A59uyzl+64CCUzOWohlAEoj28TXUnPY5nM7IzlWFCADGnJyy7
         qpPgguI1RChxuCJSCxKWmnXFFRJ876ID5bIF+0ViO4atxInnFa8FY9xQt4/NjSF2SXW9
         C6NSR+l3nJQUF1+ordXp+JGf/D3URpcQiwLDiIYRn/J9ZDlXLJEex0qHp89Uu7O2HFfG
         +zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UklazaNAycz2BFsJtlkthid2wC2kf6KqSFJIrZZTFqE=;
        b=dPMShg/0bnlN9P62DRwIWxkkVL4K2uL64/piAAtcp347xMqNtd1MilkrGwyomOqr8D
         wVdlV3mA1kgj9UMkEoOsURlealCGPDVcF8Aq4X/8KkQjbSDY4vAFZADKOPV/7iZeJeb+
         kZdXJWLZ4E5w+Y4hBz0r4H04yeaONaLDYz360Y//nNJ/0w6dhogYqWIn5bAU0aEA20AO
         ywTDDVwcDhLxInxB7HVdLEdaw8MC/cSg53iMGvDqX2RB17YfYzEf1dXhG5EdjIb44zcs
         488ScmBEejKQFOuf4JmnniLwgHmDHW+lzxqY81lb2EtK746BCvFa5yIoNzoP1iYysoqG
         rBYw==
X-Gm-Message-State: AOAM533IDkwUw+26C8C0qEtdEMhfF6gbmocFa2F0UYNqO9J83HfdFdst
        fLBFpLztYd/hYygvlznl2lSY5UY65ijR8YPXTQ0=
X-Google-Smtp-Source: ABdhPJy1WDuOpN9VovHrQg0qbPDBjI26sfuwcaAuX9B+XfkYd+rSWhWiYl1AzHqW+cYQQhzf1IWf/WcnVNGbeFJ3G/A=
X-Received: by 2002:ac8:7773:: with SMTP id h19mr6713770qtu.213.1612439853520;
 Thu, 04 Feb 2021 03:57:33 -0800 (PST)
MIME-Version: 1.0
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <492da9326ecb5f888e76117983603bb502b7b589.1612434091.git.naohiro.aota@wdc.com>
In-Reply-To: <492da9326ecb5f888e76117983603bb502b7b589.1612434091.git.naohiro.aota@wdc.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 4 Feb 2021 11:57:22 +0000
Message-ID: <CAL3q7H7mzAngA8SF13+FOgVserhF3iyA2a8tggYuO+qi+woLOw@mail.gmail.com>
Subject: Re: [PATCH v15 41/42] btrfs: zoned: reorder log node allocation on
 zoned filesystem
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 4, 2021 at 10:23 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> This is the 3/3 patch to enable tree-log on zoned filesystems.
>
> The allocation order of nodes of "fs_info->log_root_tree" and nodes of
> "root->log_root" is not the same as the writing order of them. So, the
> writing causes unaligned write errors.
>
> Reorder the allocation of them by delaying allocation of the root node of
> "fs_info->log_root_tree," so that the node buffers can go out sequentiall=
y
> to devices.
>
> Cc: Filipe Manana <fdmanana@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/disk-io.c  | 12 +++++++-----
>  fs/btrfs/tree-log.c | 27 +++++++++++++++++++++------
>  2 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 84c6650d5ef7..c2576c5fe62e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1298,16 +1298,18 @@ int btrfs_init_log_root_tree(struct btrfs_trans_h=
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
> +       if (!btrfs_is_zoned(fs_info)) {
> +               int ret =3D btrfs_alloc_log_tree_node(trans, log_root);
> +
> +               if (ret) {
> +                       btrfs_put_root(log_root);
> +                       return ret;
> +               }
>         }
>
>         WARN_ON(fs_info->log_root_tree);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 8be3164d4c5d..7ba044bfa9b1 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3159,6 +3159,19 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,
>         list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2=
]);
>         root_log_ctx.log_transid =3D log_root_tree->log_transid;
>
> +       if (btrfs_is_zoned(fs_info)) {
> +               mutex_lock(&fs_info->tree_log_mutex);
> +               if (!log_root_tree->node) {

As commented in v14, the log root tree is not protected by
fs_info->tree_log_mutex anymore.
It is fs_info->tree_root->log_mutex as of 5.10.

Everything else was addressed and looks good.
Thanks.

> +                       ret =3D btrfs_alloc_log_tree_node(trans, log_root=
_tree);
> +                       if (ret) {
> +                               mutex_unlock(&fs_info->tree_log_mutex);
> +                               mutex_unlock(&log_root_tree->log_mutex);
> +                               goto out;
> +                       }
> +               }
> +               mutex_unlock(&fs_info->tree_log_mutex);
> +       }
> +
>         /*
>          * Now we are safe to update the log_root_tree because we're unde=
r the
>          * log_mutex, and we're a current writer so we're holding the com=
mit
> @@ -3317,12 +3330,14 @@ static void free_log_tree(struct btrfs_trans_hand=
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
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
