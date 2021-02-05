Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760BF310AA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhBELwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 06:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhBELt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:49:57 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AADC06178A;
        Fri,  5 Feb 2021 03:49:17 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id s77so6532818qke.4;
        Fri, 05 Feb 2021 03:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=l/vribjxAtI/37qZQgHoFc1KUL5WulO4nd5F9jh4cH0=;
        b=AxQMi0mJAJQyCsNsWHrgS5m1y8GcnxidzdGZNOwX0XyrrXf7wDCU+zYs2sPSTMzkvd
         JMHFtSTRRPeN3AewSzVD1YWalAZsGla62c/yI0wSbrsi0//ySdtI73dUfvKnffgCFE2W
         ZYoMjPHDV6FG7QenWEx4h+s1EoNhAClZfq2Mhxk8nfUJ9CIWDj/8W8T3MCWvDQCElhU2
         FZqnWzdBOewX7AdcRZe7CrlTv2EJi3d0h/JGgVsLFTES7n8HnAuLawS9uoTOEgF8KQZY
         oxEuoJdEkb8w2Rr2upfE8tIuMJAWcUTCQqLkSv8YV2vHATW+xKzuv5aqFMqu3I564pCK
         cECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=l/vribjxAtI/37qZQgHoFc1KUL5WulO4nd5F9jh4cH0=;
        b=JXE3qporzpEoiJEfiMw2oQbtl8LBNGB8QBLbsCEzL/r2BRDg5zYmpQle0DAO2+pvbF
         DJrtNpyWtjkYoJXd2Naux3IGZJ5x6ZmE2fgFG3BnphMYRqgcKz80dC9A1gG10w0ss+z3
         kai63Ru4nN6tQtOsUKlrcZxyJsa6ytR1pEZn9AXTa8UIw1prs8d0R0fU1wfcZfW+1woQ
         KBkm9EjXKxZ9MPalg2r00ui8KkckQs2nfSXafFQ2GAJcskpRG36G4rK+dcynHIa3YJUF
         pJMlDfN9rlp1cuVW/ibQl/ypl4U1wIrW47MZyQzKIMMqbF6kaiyphPEga2CUcmqrhCXq
         SYgQ==
X-Gm-Message-State: AOAM530dvT8P67roSamTz2/ABOF2MF1uVXw/m76O2joRoIeTIU77tzOk
        fQZKHzNhltdWjm97icHBz1ijIg5oIx8elrhwfTM=
X-Google-Smtp-Source: ABdhPJwYP8WW+4WF5NzRQShKSBC3b+mWgCq8DoJlS3G5NErHnFr5hTp+VItGc06AL3T+rbCWu3MA4AtQ1nrGoahQXQ8=
X-Received: by 2002:a37:4c8:: with SMTP id 191mr3558485qke.338.1612525756879;
 Fri, 05 Feb 2021 03:49:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612433345.git.naohiro.aota@wdc.com> <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <20210205092635.i6w3c7brawlv6pgs@naota-xeon>
In-Reply-To: <20210205092635.i6w3c7brawlv6pgs@naota-xeon>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 5 Feb 2021 11:49:05 +0000
Message-ID: <CAL3q7H6REfruE-DSyiqZQ_Y0=HmXbiTbEC3d18Q7+3Z7pf5QzQ@mail.gmail.com>
Subject: Re: [PATCH v15 43/43] btrfs: zoned: deal with holes writing out
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

On Fri, Feb 5, 2021 at 9:26 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> Since the zoned filesystem requires sequential write out of metadata, we
> cannot proceed with a hole in tree-log pages. When such a hole exists,
> btree_write_cache_pages() will return -EAGAIN. We cannot wait for the ran=
ge
> to be written, because it will cause a deadlock. So, let's bail out to a
> full commit in this case.
>
> Cc: Filipe Manana <fdmanana@gmail.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/tree-log.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> This patch solves a regression introduced by fixing patch 40. I'm
> sorry for the confusing patch numbering.

Hum, how does patch 40 can cause this?
And is it before the fixup or after?

>
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 4e72794342c0..629e605cd62d 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3120,6 +3120,14 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,
>          */
>         blk_start_plug(&plug);
>         ret =3D btrfs_write_marked_extents(fs_info, &log->dirty_log_pages=
, mark);
> +       /*
> +        * There is a hole writing out the extents and cannot proceed it =
on
> +        * zoned filesystem, which require sequential writing. We can

require -> requires

> +        * ignore the error for now, since we don't wait for completion f=
or
> +        * now.

So why can we ignore the error for now?
Why not just bail out here and mark the log for full commit? (without
a transaction abort)

> +        */
> +       if (ret =3D=3D -EAGAIN)
> +               ret =3D 0;
>         if (ret) {
>                 blk_finish_plug(&plug);
>                 btrfs_abort_transaction(trans, ret);
> @@ -3229,7 +3237,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *tran=
s,
>                                          &log_root_tree->dirty_log_pages,
>                                          EXTENT_DIRTY | EXTENT_NEW);
>         blk_finish_plug(&plug);
> -       if (ret) {
> +       /*
> +        * There is a hole in the extents, and failed to sequential write
> +        * on zoned filesystem. We cannot wait for this write outs, sinc =
it

this -> these

> +        * cause a deadlock. Bail out to the full commit, instead.
> +        */
> +       if (ret =3D=3D -EAGAIN) {
> +               btrfs_wait_tree_log_extents(log, mark);
> +               mutex_unlock(&log_root_tree->log_mutex);
> +               goto out_wake_log_root;

Must also call btrfs_set_log_full_commit(trans);

Thanks.

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
