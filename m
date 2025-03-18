Return-Path: <linux-fsdevel+bounces-44361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB9A67EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 22:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA843AC53D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ADA205ADA;
	Tue, 18 Mar 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkghtQbd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3611F585B;
	Tue, 18 Mar 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333567; cv=none; b=prvwz11NQsW0qriarcdAnMJMhX/r8yISPrKmJRzxmQkwkWMaWj4jbsBhod890XboCyaEEDBU+C9unaqB0IpCW05lW2rCL0LdfTGUdztW5egGtWaozBngROKSZPg2+1I/yAF0Kyuh5gxwQJGrBTSnEBHKpe20sjuvRkQ45irDov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333567; c=relaxed/simple;
	bh=aND0qdQLECf32W4Klj2DiTAdR7FI7XMZZ+mG4Iz+bS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lC8oUA/8JQFqzPwp3qmJ0WwLFCxfHHQFPtV6KlvRxp6g9a1aQiwfXF2NQMPZCCwsXU3rNxTQnhzHKsDSj+XMGtiqiCjRl8tG4SOCoLc7wCBzlff+CPErt3wsaj5tTTVk9S2S48OVeC/86Ev3gU1gpbClBnW3RurWbLp8vBfnk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkghtQbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EBDC4AF09;
	Tue, 18 Mar 2025 21:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742333566;
	bh=aND0qdQLECf32W4Klj2DiTAdR7FI7XMZZ+mG4Iz+bS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FkghtQbdqE9zVHS5QHDp8hon96ClXBBS8tnPy+zKob3iSBy8Rh1Abo1xZAc4irCOE
	 Ns74MKmM1Y2vHdo+j2JpEBuRHHnjodW+pXS80rVHSqFwMLjcKfP/FcPoolO8ANegg3
	 +Mos3oF0F4S8ARQec2gBhkynAKDYC98WfwG0kux+PBOWWukC7ORNCKzArVyroLYjrE
	 ilHRQ1sVBPAYpxOpYlFQDG5GlGxlzTKGO7ZsanPXiwmYTfgucwNB7LtQZmkVaxMLkg
	 b56DiMizA8d0fZ4uBTnzBYoMO3+e6wadlkM0t2U2PTIhV+qPfOs10WuWLiZfAwkbjB
	 O/LjWD9yiBzcw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so875111fa.1;
        Tue, 18 Mar 2025 14:32:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1dd362njRTu3VxodRYhSK2f7ZUOZjxu2Gqwi8BgMJfaJfUZl5gBFQhLl6XVi/0q+iFSVjSUv1au2ZzgxF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5f+TPrcMQo/bAzzfig2KOaNN0ixc/NXo7R/ad64icx/kKEZ/
	wsHdM9wDAdld3ZzFTRMg2pVZAH9CnWgFuyLg3q/zSpoZN94FfxwYkz731ZokZRfoN8tx8NMtt9F
	BPtslqWhyC/ZtbCRLZDVjXiOma6U=
X-Google-Smtp-Source: AGHT+IFnjhqBFO+KpHHBtCfsDJBdbQ3x5aESBD4QUjYBY2fAIV3vFX99r31AIpXuhkReGxacuB7Cb07O9VZYf/1MkD8=
X-Received: by 2002:a05:6512:6d1:b0:549:8ff1:e0f3 with SMTP id
 2adb3069b0e04-54acab43a15mr85743e87.5.1742333565169; Tue, 18 Mar 2025
 14:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com> <20250318194111.19419-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20250318194111.19419-2-James.Bottomley@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Mar 2025 22:32:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGxXY7jh-2WC7WjWkioZA73mkm1CFhXa+VHCt_qNyxzVQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpSav_nLw32Qg4NEz_OTXYmmEbqodAbS6wpJeAw3XwWtrutYWt0IcPZqtk
Message-ID: <CAMj1kXGxXY7jh-2WC7WjWkioZA73mkm1CFhXa+VHCt_qNyxzVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] libfs: rework dcache_readdir to use an internal
 function with callback
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Hi James,

Thanks for persisting with this.


On Tue, 18 Mar 2025 at 20:44, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> No functional change.  Preparatory to using the internal function to
> iterate a directory with just a dentry not a file.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  fs/libfs.c | 41 +++++++++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8444f5cc4064..816bfe6c0430 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -189,28 +189,21 @@ EXPORT_SYMBOL(dcache_dir_lseek);
>   * for ramfs-type trees they can't go away without unlink() or rmdir(),
>   * both impossible due to the lock on directory.
>   */
> -
> -int dcache_readdir(struct file *file, struct dir_context *ctx)
> +static void internal_readdir(struct dentry *dentry, struct dentry *cursor,

It might make sense to make this __always_inline, so that the callback
argument is guaranteed to become a compile time constant when the
caller is dcache_readdir(). Otherwise, the indirect call overhead
might impact its performance.

> +                            void *data, bool start,
> +                            bool (*callback)(void *, struct dentry *))
>  {
> -       struct dentry *dentry = file->f_path.dentry;
> -       struct dentry *cursor = file->private_data;
>         struct dentry *next = NULL;
>         struct hlist_node **p;
>
> -       if (!dir_emit_dots(file, ctx))
> -               return 0;
> -
> -       if (ctx->pos == 2)
> +       if (start)
>                 p = &dentry->d_children.first;
>         else
>                 p = &cursor->d_sib.next;
>
>         while ((next = scan_positives(cursor, p, 1, next)) != NULL) {
> -               if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
> -                             d_inode(next)->i_ino,
> -                             fs_umode_to_dtype(d_inode(next)->i_mode)))
> +               if (!callback(data, next))
>                         break;
> -               ctx->pos++;
>                 p = &next->d_sib.next;
>         }
>         spin_lock(&dentry->d_lock);
> @@ -219,6 +212,30 @@ int dcache_readdir(struct file *file, struct dir_context *ctx)
>                 hlist_add_before(&cursor->d_sib, &next->d_sib);
>         spin_unlock(&dentry->d_lock);
>         dput(next);
> +}
> +
> +static bool dcache_readdir_callback(void *data, struct dentry *entry)
> +{
> +       struct dir_context *ctx = data;
> +
> +       if (!dir_emit(ctx, entry->d_name.name, entry->d_name.len,
> +                     d_inode(entry)->i_ino,
> +                     fs_umode_to_dtype(d_inode(entry)->i_mode)))
> +               return false;
> +       ctx->pos++;
> +       return true;
> +}
> +
> +int dcache_readdir(struct file *file, struct dir_context *ctx)
> +{
> +       struct dentry *dentry = file->f_path.dentry;
> +       struct dentry *cursor = file->private_data;
> +
> +       if (!dir_emit_dots(file, ctx))
> +               return 0;
> +
> +       internal_readdir(dentry, cursor, ctx, ctx->pos == 2,
> +                        dcache_readdir_callback);
>
>         return 0;
>  }
> --
> 2.43.0
>

