Return-Path: <linux-fsdevel+bounces-57883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB12B26610
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457BF3AC5A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE452FB98B;
	Thu, 14 Aug 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RogPRt9N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80B2E92DD;
	Thu, 14 Aug 2025 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176253; cv=none; b=naiqRg811GoVmE+M3MnUWpF1VPmhbwNZ9bwxR5wYoM9WfmGuLOtIX834CO4FqQaBj1ao/ks/bHoc2oworNCubCB8LjZWKZ34f3hccIHP3jPe3hhXdiJxNK/yPEzCtrGU23BNuR1nfOSqkLL5IZNDUxYbucBrzmzr3s2dq2u+wXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176253; c=relaxed/simple;
	bh=+06cjw5JMcQzB9dndAJf9FMSNlsLHhw8BVZ84sEtk2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDwd86YtB4myGs5usjbgxxL1TEEAAG13ql0rp+s8wzzM8K4r4NzdC0qFFxnZdgUmCjbfGmG3XFpYV495OGImeGnyh+sfBnR82GZaWEuRPmGBxda+QRYJL945ibNr8ZE5Dzmeq2TeW6KSxDvkdet6TsTHooZ/MfK7NWpskzgVlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RogPRt9N; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7ae31caso152962266b.3;
        Thu, 14 Aug 2025 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755176250; x=1755781050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4GIDMaIwjPktdjgTPGwa63eY9WvWbCFa8CMm/cK4Bk=;
        b=RogPRt9Nj7MS8wLoMRqFJJlZOXm9agpI2VKtCRaurjyfWvXluTccq7MqVHQ5VfLSHL
         ymegcQTVU8QI5r2jZfBtvajyOc5MfKBdmTzGPmNixxOORhmbsVrA5iKRtfd5+gnVf6gh
         5mMKn+aWWfMmDcdJtTPG8Pkd0KJfZVc4cyIotE8FN8DSxSKeGWI9CPimyx/BYiiy6PuJ
         kmXOfKTlbmjZ5GmQFMVaj2qYAC4/i6ky8AChmYL/bVzY6YVPNXHquQZQuBHpSkW1QWeC
         xkdk0/bIWZSD75KdiTzABIkUpiuYsCYiNIkOW7jbFeeyvzRvs2yCEgNWiEqBtvEVUAMp
         0QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176250; x=1755781050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4GIDMaIwjPktdjgTPGwa63eY9WvWbCFa8CMm/cK4Bk=;
        b=dqiMQEI09Bcu16YCOWULEXIspm/O8YF88zh1zhc/3CLFJuKMNVYeIRv3mhBU7ZZa69
         sga7ntO3Ozk6/qMQ9l0UhmrmGkSiTCtbvN2fpWjFUCvObJGoakdQ+DkRAJsSMSjERfwR
         +Olw46/oGUy+Jrb5BAVgAGGfPjs8j0T0m25te1MSp+sNLSHWw6KGliMlxL00tFzQmD3H
         7KRYHCGh7234Pv7pGqk8GNUBZWRwLj/4HbIAknqsr58OAy6Dv5TxLLtq3KfkvzgIu4/I
         hJf0lbLffAY93rhn5iZWCfyxVgWm7iJjeZ4B1/mZDgrHXi72W4uDppJREEyat2OYtkgT
         rmKA==
X-Forwarded-Encrypted: i=1; AJvYcCUWkzgHlRqWJYENxim6fQRno+os4ao33dhDWMXWXfm9oQwRO4sncSFUvwxyjVTLLQuB7/2UcOuOXP+u3pqm@vger.kernel.org, AJvYcCVhf7vUZJKV28SL9FvSyh0BVjh/6AMTNp3Vg6OmfhoFVD2l3w1wUpk/T4PPNl6DCJHlsGYktBZmw6+EJhAV@vger.kernel.org, AJvYcCVlL00rUdWD4wpxFUFj1TA0nin6IsFnACZLmbVaYRzmVp9CUBrXOf0awbfN/Qd1Hwv6dgn88n2BVdRz7ZoS7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4Jk7xTrBAjJ/bV4tRhGG+XZ/MlZujsSBQLg9ZgnqXyQcWj7c
	mTxI7Fb19pVyZQ3co41ft+e0qePhoqif2qdDc8t8nFffxNn8OPZ3pyAbI07OE4IPzaEjLbITTwk
	1+5LW/jIJIKFZSYYfULg1gcl4IGmsICY=
X-Gm-Gg: ASbGnctkxMwFKiF7jk640a0Mgt3oKQKuFy7fk40Oa/LYud7OiIG0qCy6GMLVHtX8EBJ
	5DczWcdwe6q5UWqb8/fKZoiLzkQqym4kI2D/21TdVqVd20xWL2HyXJVc7gzw74Y1+I7kShd2I5V
	DdaSomQbR4c2MMBVFzNsdfoqS7mksG/hmLahMd1aCk2exjVajRr4QYzX5ylIoeaBZvqDWvgj8f/
	33FTA9Vd8s7ZN4ICw==
X-Google-Smtp-Source: AGHT+IHcvmWqxjVveYRjeXenhp+pxyUsW/vZF3sostIGvUYZkonpch7cuG1kj8HBPgPEqrgIg32FjhgRSzuQCxrr+qg=
X-Received: by 2002:a17:907:72cc:b0:ae9:a1f1:2b7d with SMTP id
 a640c23a62f3a-afcb9799ba0mr293550366b.17.1755176250137; Thu, 14 Aug 2025
 05:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-6-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-6-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 14:57:19 +0200
X-Gm-Features: Ac12FXw7-pMgoAJKR4qVcUZUocffeSo97sr8PSf_aYJZeUcqJWIMnM5E1h_PJpQ
Message-ID: <CAOQ4uxjQkF2qa_DWCDY=1QLZCUq6rJbK_HTv2iuz0+O+rnRsRw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] ovl: Set case-insensitive dentry operations for
 ovl sb
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:37=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> For filesystems with encoding (i.e. with case-insensitive support), set
> the dentry operations for the super block as ovl_dentry_ci_operations.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes from v3:
> - new helper ovl_set_d_op()
> - encoding flags are now set in a step earlier
>
> Changes from v2:
> - Create ovl_dentry_ci_operations to not override dentry ops set by
>   ovl_dentry_operations
> - Create a new function for this
> - Instead of setting encoding just when there's a upper layer, set it
>   for any first layer (ofs->fs[0].sb), regardless of it being upper or
>   not.
> ---
>  fs/overlayfs/super.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index b1dbd3c79961094d00c7f99cc622e515d544d22f..a99c77802efa1a6d96c430197=
28d3517fccdc16a 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -161,6 +161,16 @@ static const struct dentry_operations ovl_dentry_ope=
rations =3D {
>         .d_weak_revalidate =3D ovl_dentry_weak_revalidate,
>  };
>
> +#if IS_ENABLED(CONFIG_UNICODE)
> +static const struct dentry_operations ovl_dentry_ci_operations =3D {
> +       .d_real =3D ovl_d_real,
> +       .d_revalidate =3D ovl_dentry_revalidate,
> +       .d_weak_revalidate =3D ovl_dentry_weak_revalidate,
> +       .d_hash =3D generic_ci_d_hash,
> +       .d_compare =3D generic_ci_d_compare,
> +};
> +#endif
> +
>  static struct kmem_cache *ovl_inode_cachep;
>
>  static struct inode *ovl_alloc_inode(struct super_block *sb)
> @@ -1332,6 +1342,19 @@ static struct dentry *ovl_get_root(struct super_bl=
ock *sb,
>         return root;
>  }
>
> +static void ovl_set_d_op(struct super_block *sb)
> +{
> +       struct ovl_fs *ofs =3D sb->s_fs_info;
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +       if (ofs->casefold) {
> +               set_default_d_op(sb, &ovl_dentry_ci_operations);
> +               return;
> +       }
> +#endif
> +       set_default_d_op(sb, &ovl_dentry_operations);
> +}
> +
>  int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>         struct ovl_fs *ofs =3D sb->s_fs_info;
> @@ -1443,6 +1466,8 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>         if (IS_ERR(oe))
>                 goto out_err;
>
> +       ovl_set_d_op(sb);
> +
>         /* If the upper fs is nonexistent, we mark overlayfs r/o too */
>         if (!ovl_upper_mnt(ofs))
>                 sb->s_flags |=3D SB_RDONLY;
>
> --
> 2.50.1
>

