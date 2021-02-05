Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2131141A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhBEV7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 16:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhBEO6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:58:33 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F34DC061794;
        Fri,  5 Feb 2021 08:25:58 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c1so5388850qtc.1;
        Fri, 05 Feb 2021 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tknZsG8RVjECD5MXLCyGMYFFF5ZPCX7pFowei7WIg4w=;
        b=PJqU8blQVv9UUoLrC68SIN//YrkNO8+pNLkY3nG2b6CRwKBwChSYtRICYFWu8Jcq7H
         xZW8QOb1CuK8LspZB2DMb8RSuN5cmKqlzpaFpaTAywQzC1Yj1LhMuzuxCwHpQ58p7736
         d/Zg89wjcKA1atDQXbFFy1hGWAIAtfqjr2VVVuk4e6Hi/Z9KUdBvOFxlytnX3LyfE5lo
         fvVPJls5B9vXYIP7ZFxr4TfpTIpTJPQ/NP9l4EFiBnAucTmKY/A7a883e/KhzvcvJE4j
         A6Ztbn4VrCTKESKu0YaPxZMt4NdEnevxZ5Koa1ZGfoaUCHsblcE1eUF2dK46AoSKRIF3
         GIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tknZsG8RVjECD5MXLCyGMYFFF5ZPCX7pFowei7WIg4w=;
        b=pUPH3dRQCltAyKWLnWt5411YXQulYX4zTsVyHugWv9cPi+oIBKNncN70Zujj0xfBs7
         AKBne0YimaMzgMZX4DdLXRIS2OcXwdPOT0mq/+J2fuMTuDWsYOYpruEqwGwj+rFax3dD
         SlPEPpxF9qdSdceaWrTAcu0r8xguJ907ysbqj2HBHxQisuwRYFhERjXPu1ugBLyEgEoy
         sOz+81wcDrFgPCOd/TAWx2Oe05GLs+LxMC3339KeBcb0oe/Glv34JY6Lc8JZ7RDmvEh1
         fy3TDEj1vh4wyfXy7tc3Q/Q7SNpgFhJqAwT7x3IlC45+vIlpFYG8+dTcjLHlr2Gi+8cr
         FKfw==
X-Gm-Message-State: AOAM530bn4esRp8txAPg2qyO5+DHrzddZOsbrVXd5FTq7HqBBqUil4tT
        Z//tOHQra0CCfcK+hDvKzc2UOA8ZPPxsXw9OMf6COMD5CsY=
X-Google-Smtp-Source: ABdhPJzSY4tHGRPzoupf6eGMwIpwkJv8V7MF61hTdNK0LpMfqmFtNAmpyCjnyYJiOhqzVkrIH7iAoPcA6Tebou3xrfw=
X-Received: by 2002:ac8:4755:: with SMTP id k21mr4959450qtp.376.1612542357329;
 Fri, 05 Feb 2021 08:25:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612433345.git.naohiro.aota@wdc.com> <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <20210205092635.i6w3c7brawlv6pgs@naota-xeon> <20210205145836.gtty4r6a4ftolehj@naota-xeon>
In-Reply-To: <20210205145836.gtty4r6a4ftolehj@naota-xeon>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 5 Feb 2021 16:25:45 +0000
Message-ID: <CAL3q7H7aMzLbf-1-16x4GDPkmEC=1RNFDpkRuz55XU7B5F94cg@mail.gmail.com>
Subject: Re: [PATCH v15.1 43/43] btrfs: zoned: deal with holes writing out
 tree-log pages
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, hare@suse.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:58 PM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> Since the zoned filesystem requires sequential write out of metadata, we
> cannot proceed with a hole in tree-log pages. When such a hole exists,
> btree_write_cache_pages() will return -EAGAIN. This happens when someone,
> e.g., a concurrent transaction commit, writes a dirty extent in this
> tree-log commit.
>
> If we are not going to wait for the extents, we can hope the concurrent
> writing fills the hole for us. So, we can ignore the error in this case a=
nd
> hope the next write will succeed.
>
> If we want to wait for them and got the error, we cannot wait for them
> because it will cause a deadlock. So, let's bail out to a full commit in
> this case.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

It looks good now, thanks!

> ---
>  fs/btrfs/tree-log.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index fc04625cbbd1..d90695c1ab6c 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3120,6 +3120,17 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,
>          */
>         blk_start_plug(&plug);
>         ret =3D btrfs_write_marked_extents(fs_info, &log->dirty_log_pages=
, mark);
> +       /*
> +        * -EAGAIN happens when someone, e.g., a concurrent transaction
> +        *  commit, writes a dirty extent in this tree-log commit. This
> +        *  concurrent write will create a hole writing out the extents,
> +        *  and we cannot proceed on a zoned filesystem, requiring
> +        *  sequential writing. While we can bail out to a full commit
> +        *  here, but we can continue hoping the concurrent writing fills
> +        *  the hole.
> +        */
> +       if (ret =3D=3D -EAGAIN && btrfs_is_zoned(fs_info))
> +               ret =3D 0;
>         if (ret) {
>                 blk_finish_plug(&plug);
>                 btrfs_abort_transaction(trans, ret);
> @@ -3242,7 +3253,17 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,
>                                          &log_root_tree->dirty_log_pages,
>                                          EXTENT_DIRTY | EXTENT_NEW);
>         blk_finish_plug(&plug);
> -       if (ret) {
> +       /*
> +        * As described above, -EAGAIN indicates a hole in the extents. W=
e
> +        * cannot wait for these write outs since the waiting cause a
> +        * deadlock. Bail out to the full commit instead.
> +        */
> +       if (ret =3D=3D -EAGAIN && btrfs_is_zoned(fs_info)) {
> +               btrfs_set_log_full_commit(trans);
> +               btrfs_wait_tree_log_extents(log, mark);
> +               mutex_unlock(&log_root_tree->log_mutex);
> +               goto out_wake_log_root;
> +       } else if (ret) {
>                 btrfs_set_log_full_commit(trans);
>                 btrfs_abort_transaction(trans, ret);
>                 mutex_unlock(&log_root_tree->log_mutex);
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
