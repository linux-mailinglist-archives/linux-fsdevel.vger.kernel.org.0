Return-Path: <linux-fsdevel+bounces-70134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D81B9C91C9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE5F3AA4A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531CB30CD95;
	Fri, 28 Nov 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3cnNoTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE617BA6
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764329245; cv=none; b=iW8jDx4kB1VJEMpzn9jmf15bTuu31egyTKT3nIDP5FHSXnsHdYTJtwMyaWfxX+t62kTCXAMZOtGotT0H6G6Byn1P270IgdCBohlTG197LgQWTiM2azj2CbIr0x07Rq6H38NguvchnYkaBLOKySucg4ezolD5grg/KND9LWpy6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764329245; c=relaxed/simple;
	bh=8QpAJZREAKPJM+mXh1VfTsY4k31qKcajBY174hWUMdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbtFFCQvvKomik0oQokRCNuxJhwo/T4Ub9cpC8mTx+7DcNp7/NzE9ckYBhPDIW9kHwSAsa798Zo5/zQokqYLeLoYYcnKOc0DZL0Jfjpq20w33TeKWovkgKEzSRWc89AILTLeI9CFBtE2HgJNx/sGyVNh4TxsjeS4+GwmKG7RkdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3cnNoTa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so2995615a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 03:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764329241; x=1764934041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUeyxN62EEN8hyjvBZXRBEK3BnCJ9uKwHVVyJVoGd+8=;
        b=K3cnNoTaMVWy5ApgDuuFq9tfIs0C8UBSBTgIM3baH4ifE2xDbvS1nJTdasmdBdCCIH
         aZzpoFaOh7a19qw4TUPKN6DBIpI3Arl1hTgkgWsBDH9j1rOJBYFhXmmYNBXFHFCzv6pJ
         Vi3YjGd96fnyqQL07Jb8YMIH+Fy9lapn+VV6d3RLqefD4dAiRkqxkLRC8Y+tpuxusnOK
         oU2KIusZtopnpTIjvX84hVsvcCz0JzT++O9ywlJqOCHH4N1idEqSqPz5ZfiNJv3H8Bb9
         XSEaNUSIjolxV6uKkwsSmYBKYX8MqWoIxlr9+ai7/4FfMBGIc/Nt1P8Yj0imQlcrmzvk
         4Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764329241; x=1764934041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUeyxN62EEN8hyjvBZXRBEK3BnCJ9uKwHVVyJVoGd+8=;
        b=U8qxczGyVuceqUsoMWNQedxro1II7t0skqoyS47hYdWKYBtLdCty01TUzP0Ma/8udw
         ZnnsNFedS5zPS3HLY97MKCCyErKz6A4CiszVIuYrXpnHphu8jX4GS4UtGXUQ1FEZNv0V
         5J2tdnQcg6tgMz97ewzIjpWtfopuVjLSLYsBYvk4QyfLOyaePeMmedu5ITEgNrJEjifP
         zYEIB0AvoFUlK1l7EARhxpwAoxYuuiq3G1VpUaQp1UeTMGW79LRzOy8llUH6KdQN+9qq
         C7FI8B6VSPDzcfOW69Vl/bnAic95mQeqE/YOiB1nhI7RgQu/nu0ir1aKM7KXw56cj9ZU
         0+Bg==
X-Gm-Message-State: AOJu0YysX+ru5zJLanyuiG9bPiRUHJOwX57Ly/tZvljqpcju+2iq3tNB
	m1JSg3XzVGSAv5F7OsxuXpUn3+nHSc5lVjHPbF+zi2R3WJgEwopUJjYQgIYHyTSs++GXM+/p5Ch
	o5cy2eQ2fHGvNwc+AuLG140+GB1E4mNZowBdnntE=
X-Gm-Gg: ASbGncvZmHTQREqFAeelAKAOgwyv6HvYkIjCHVpNLYJLftTep9o8vWrraQBYXSo/V/1
	NlTD/LvbDQuMom1bXLR1/6L5kF7NmY36swJxGlRAevyVB8eSyMImWc7ZUruwH9sC6CsVcgiEX/u
	H02K6ZsElpXfKJin4eP+hep6GWkEvWzK8jWm2UN0/wXicZdzeaiZn1FzE+rEJtlI+Wb0H7J09eb
	cYCTI1pRhQgHQt7u5Ll5cR7ZnC+OJ8ItSca6/+2J28DI6DRlInFuzoOZ1G6HouU/YBfLv8IZUfs
	7R9M81mAag19WDtYUjNepvWAshZyLA==
X-Google-Smtp-Source: AGHT+IEzcm8i2N4Up4w7NoMzQzgWYSFjowrp/k2JYwOFbJiVZ9HeVuRLb6Ey4B4N7RM4zH8UvgB9itSy7Vfv/f14Y7k=
X-Received: by 2002:a05:6402:4303:b0:641:8908:a558 with SMTP id
 4fb4d7f45d1cf-64555ce53famr24192810a12.25.1764329241153; Fri, 28 Nov 2025
 03:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127170509.30139-1-jack@suse.cz> <20251127173012.23500-20-jack@suse.cz>
In-Reply-To: <20251127173012.23500-20-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 28 Nov 2025 12:27:09 +0100
X-Gm-Features: AWmQ_bmb_Dz3OsCvnFLc66piRG4-Mk83GufIfOO5unsAWkcj9ppk5aZADF9R6B8
Message-ID: <CAOQ4uxgdhmWAxeNoQE4b7J6_f9kMOBXZf4eO6kVavTeQ7Es27w@mail.gmail.com>
Subject: Re: [PATCH 07/13] fsnotify: Use connector hash for destroying inode marks
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:30=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Instead of iterating all inodes belonging to a superblock to find inode
> marks and remove them on umount, iterate all inode connectors for the
> superblock. This may be substantially faster since there are generally
> much less inodes with fsnotify marks than all inodes. It also removes
> one use of sb->s_inodes list which we strive to ultimately remove.

It should be simple to iterate an sb->s_inode_connectors list
without the need of any of the patches until this point. Right?

Thanks,
Amir.

>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/notify/fsnotify.c | 78 ++++++++++++++++++--------------------------
>  1 file changed, 32 insertions(+), 46 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index f7f1d9ff3e38..6e4da46c10ad 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -34,62 +34,48 @@ void __fsnotify_mntns_delete(struct mnt_namespace *mn=
tns)
>  }
>
>  /**
> - * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched in=
odes.
> - * @sb: superblock being unmounted.
> + * fsnotify_unmount_inodes - an sb is unmounting. Handle any watched ino=
des.
> + * @sbinfo: fsnotify info for superblock being unmounted.
>   *
> - * Called during unmount with no locks held, so needs to be safe against
> - * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and C=
AN block.
> + * Walk all inode connectors for the superblock and free all associated =
marks.
>   */
> -static void fsnotify_unmount_inodes(struct super_block *sb)
> +static void fsnotify_unmount_inodes(struct fsnotify_sb_info *sbinfo)
>  {
> -       struct inode *inode, *iput_inode =3D NULL;
> +       int idx;
> +       struct rhashtable_iter iter;
> +       struct fsnotify_mark_connector *conn;
> +       struct inode *inode;
>
> -       spin_lock(&sb->s_inode_list_lock);
> -       list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> -               /*
> -                * We cannot __iget() an inode in state I_FREEING,
> -                * I_WILL_FREE, or I_NEW which is fine because by that po=
int
> -                * the inode cannot have any associated watches.
> -                */
> -               spin_lock(&inode->i_lock);
> -               if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
> -                       spin_unlock(&inode->i_lock);
> +       /*
> +        * We hold srcu over the iteration so that returned connectors st=
ay
> +        * allocated until we can grab them in fsnotify_destroy_conn_mark=
s()
> +        */
> +       idx =3D srcu_read_lock(&fsnotify_mark_srcu);
> +       rhashtable_walk_enter(&sbinfo->inode_conn_hash, &iter);
> +       rhashtable_walk_start(&iter);
> +       while ((conn =3D rhashtable_walk_next(&iter)) !=3D NULL) {
> +               /* Table resized - we don't care... */
> +               if (IS_ERR(conn))
>                         continue;
> -               }
> -
> -               /*
> -                * If i_count is zero, the inode cannot have any watches =
and
> -                * doing an __iget/iput with SB_ACTIVE clear would actual=
ly
> -                * evict all inodes with zero i_count from icache which i=
s
> -                * unnecessarily violent and may in fact be illegal to do=
.
> -                * However, we should have been called /after/ evict_inod=
es
> -                * removed all zero refcount inodes, in any case.  Test t=
o
> -                * be sure.
> -                */
> -               if (!atomic_read(&inode->i_count)) {
> -                       spin_unlock(&inode->i_lock);
> +               spin_lock(&conn->lock);
> +               /* Connector got detached before we grabbed conn->lock? *=
/
> +               if (conn->type =3D=3D FSNOTIFY_OBJ_TYPE_DETACHED) {
> +                       spin_unlock(&conn->lock);
>                         continue;
>                 }
> -
> +               inode =3D conn->obj;
>                 __iget(inode);
> -               spin_unlock(&inode->i_lock);
> -               spin_unlock(&sb->s_inode_list_lock);
> -
> -               iput(iput_inode);
> -
> -               /* for each watch, send FS_UNMOUNT and then remove it */
> +               spin_unlock(&conn->lock);
> +               rhashtable_walk_stop(&iter);
>                 fsnotify_inode(inode, FS_UNMOUNT);
> -
> -               fsnotify_inode_delete(inode);
> -
> -               iput_inode =3D inode;
> -
> +               fsnotify_destroy_marks(&inode->i_fsnotify_marks);
> +               iput(inode);
>                 cond_resched();
> -               spin_lock(&sb->s_inode_list_lock);
> +               rhashtable_walk_start(&iter);
>         }
> -       spin_unlock(&sb->s_inode_list_lock);
> -
> -       iput(iput_inode);
> +       rhashtable_walk_stop(&iter);
> +       rhashtable_walk_exit(&iter);
> +       srcu_read_unlock(&fsnotify_mark_srcu, idx);
>  }
>
>  void fsnotify_sb_delete(struct super_block *sb)
> @@ -100,7 +86,7 @@ void fsnotify_sb_delete(struct super_block *sb)
>         if (!sbinfo)
>                 return;
>
> -       fsnotify_unmount_inodes(sb);
> +       fsnotify_unmount_inodes(sbinfo);
>         fsnotify_clear_marks_by_sb(sb);
>         /* Wait for outstanding object references from connectors */
>         wait_var_event(&sbinfo->connector_count,
> --
> 2.51.0
>

