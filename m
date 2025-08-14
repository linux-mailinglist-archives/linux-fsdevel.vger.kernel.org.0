Return-Path: <linux-fsdevel+bounces-57885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A5B2661D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D475C7E71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526151553A3;
	Thu, 14 Aug 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn4EX6yu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9F13959D;
	Thu, 14 Aug 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176446; cv=none; b=WzYcekBeYBojaUtF0WcRL7P4TTcmxhO6qhh7bmppMG6LUeJ06AOH41HZILRx75+K7QahFMQqxlzOdn6xAz8r1x8HjIIIRvQZwpZZGiTQ1QahF/fDRc1secJdOEt7RcJLWOoHI7QtDhKoqi3igarKNy4HoqUCvzqFYMRxEBf6hFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176446; c=relaxed/simple;
	bh=gTFYiJzHN6NnHxWBYr+oZ+0JdJKC8PTUq8bWF2bhLpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsaOU63eMwB59Aw4l1VOVeYN1WWzZ1YU8PTXUkzMi6bt0rcXf5szkMNbNyLwZuCgCdgOQcR34snEi/v8T8q55MrIt2vjhEekAThByO+lMRkvV/U/bDCdUAPsm4AqPX2yJWFp7A2yK6OZ9DgiHfV10i9WpZm24FQgU2ao8s6eRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn4EX6yu; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6188945f471so1979859a12.0;
        Thu, 14 Aug 2025 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755176443; x=1755781243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lP6JdkoxzCEOcH/8OhNo/+L2tHObF/APQ//FJkygXE=;
        b=Yn4EX6yu5YPkYdd2Pc1o1emYHXDM0UK975jGkwnJReIhEJL1GkOtIdVKlDdM78TKaE
         lITgMTSX9w4YJJXLbqhBFpjA267WHyTmZXZvV2VYOP7j4xOFqN2IsIVd1CPH60HDi8nX
         ttbm+sewL2cnHujbGppydzi7U+KIwNreq8zXtenTxNJj7wNO5i/2MfAA/h27VnLTDsbj
         w6SN4eh3CUXGaI2pPp9jWv8fCqWMyEnWkbJ2wC8yMs1FiBVRBoctklEfybY0OAX4IG0Y
         oKk1R6Czk7ks2hQ7Q0E4t+wkrhQnMAZkFNylubTSdzjvWuzsxidf0ovPcgBQy5NIqEQW
         NnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176443; x=1755781243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lP6JdkoxzCEOcH/8OhNo/+L2tHObF/APQ//FJkygXE=;
        b=ghLxwlECyNp5xX6TaBwkLRn3FAsU9q5Hny1yWxQYBqREaP89lvAGj8uwM/TwSPfVHe
         72/EAujVyWPrOCPpTxcWLWl+XH20HN5wjgaz4OyH1Ahk2n3f6HW1bENlrHFGQp3wdZ7o
         0EVsnBoqybCKci7zpjyTUeT2VsV0F9vpMa7zvss/PUeFlOZmSUcbkztWyJPJwdVIm/yz
         VldJrIetA/dLr+W+lHUqitIw2SD0rcRXjNei2XI2RvpEG48hZ1DF5imc3D453nSVUzQq
         /k25BmJG82oYFh5ffxiTLSG62nMg5fcfnKZxw7I1Dv04cFqHAInMV9vYYcT7TMKCGMXP
         Rciw==
X-Forwarded-Encrypted: i=1; AJvYcCUMF5Xi15Gbfvj4hJ9ItGZvOo5+wA9Wx04Y9sjW9FvcLKyBYeEj1tqcMcRc1U6zgwziK98vMy3Whte635hWRw==@vger.kernel.org, AJvYcCUkE8JLmhfyIgSnMeZ+S4CHWInQnFBOAcTYp1qbwf+YkSAJbgtUMbcvIvKV5RJCnbSiSrFsNvBd4DIC8m10@vger.kernel.org, AJvYcCVe7hoMX+o06TP9rDtJcGBg6U+Ie35Ui8nQlXFsCFYHPt+xNkBJQNRvxEImXHmO021c7P3HJq4KZ2aFVd2U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6rODbAEroy4oQSvmUeQTFmrRDsEbk65tGnnOkDJ7tIkullaA
	R3pndob701Ie5CpuSrQ4YNWyOekdqNsi6uh+N6WKE0OfZ8TUQ2oiO8F2qNJF+ZljyVfkpfrv9BZ
	wpedRIEhn121DUma3hxbykkm7YoZ4LRw=
X-Gm-Gg: ASbGncvM0TB2VEAWK/uNIC6u3Z/2tr3d4PI8weK5J5isYgcnKjAtZYpqdMZgkYbNfk0
	w6CJHtFPPPt0d7Em7YXcedsJvpjZNSsoItwtOQj4tmO6s04+DiFifUIG8Gv1vK1Uh4f3Vr0aIs3
	wPTr1ex8EJLN681nNzf5sFjHMUdfmeyKha1/XI7dj+gAKUvKHQQ9NdqeoDXmvbU/wezJG0TnG+/
	JDmWunHL9pwoCKaDg==
X-Google-Smtp-Source: AGHT+IHfmp1+ABxLkfX8CDNDXevMcqni0yxGxGMfAFlSEdKClivnqd4JKebFw9esK7P/7rUcyOSL9sLuls+8wXTubw0=
X-Received: by 2002:a05:6402:34cd:b0:615:8037:df67 with SMTP id
 4fb4d7f45d1cf-618920ba614mr2095134a12.5.1755176442801; Thu, 14 Aug 2025
 06:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-7-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-7-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 15:00:31 +0200
X-Gm-Features: Ac12FXzrfcF9KLSlHczSkdSacImVw4faDCeITHfNH-iHzr4UVDkCHsCvrtOBdgs
Message-ID: <CAOQ4uxj18QP45785xk1pzMw0y=QU0K6djxHuqARVbdUOTPR59Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] ovl: Add S_CASEFOLD as part of the inode flag to
 be copied
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
> To keep ovl's inodes consistent with their real inodes, create a new
> mask for inode file attributes that needs to be copied.  Add the
> S_CASEFOLD flag as part of the flags that need to be copied along with
> the other file attributes.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes from v3:
> - Create new flag OVL_FATTR_I_FLAGS_MASK for the file attributes and add
>   S_CASEFOLD in the OVL_COPY_I_FLAGS_MASK.
> - Add WARN()s to check for inode consistency
> - Add check for copied up directories
>
> Changes from v2:
> - Instead of manually setting the flag if the realpath dentry is
>   casefolded, just add this flag as part of the flags that need to be
>   copied.
> ---
>  fs/overlayfs/copy_up.c   | 2 +-
>  fs/overlayfs/inode.c     | 1 +
>  fs/overlayfs/overlayfs.h | 8 +++++---
>  fs/overlayfs/super.c     | 1 +
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 27396fe63f6d5b36143750443304a1f0856e2f56..66bd43a99d2e8548eecf21699=
a9a6b97e9454d79 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -670,7 +670,7 @@ static int ovl_copy_up_metadata(struct ovl_copy_up_ct=
x *c, struct dentry *temp)
>         if (err)
>                 return err;
>
> -       if (inode->i_flags & OVL_COPY_I_FLAGS_MASK &&
> +       if (inode->i_flags & OVL_FATTR_I_FLAGS_MASK &&
>             (S_ISREG(c->stat.mode) || S_ISDIR(c->stat.mode))) {
>                 /*
>                  * Copy the fileattr inode flags that are the source of a=
lready
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index ecb9f2019395ecd01a124ad029375b1a1d13ebb5..aaa4cf579561299c50046f5de=
d03d93f056c370c 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -1277,6 +1277,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
>         }
>         ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev);
>         ovl_inode_init(inode, oip, ino, fsid);
> +       WARN_ON_ONCE(!!IS_CASEFOLDED(inode) !=3D ofs->casefold);
>
>         if (upperdentry && ovl_is_impuredir(sb, upperdentry))
>                 ovl_set_flag(OVL_IMPURE, inode);
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index bb0d7ded8e763a4a7a6fc506d966ed2f3bdb4f06..50d550dd1b9d7841723880da8=
5359e735bfc9277 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -821,10 +821,12 @@ struct inode *ovl_get_inode(struct super_block *sb,
>                             struct ovl_inode_params *oip);
>  void ovl_copyattr(struct inode *to);
>
> +/* vfs fileattr flags read from overlay.protattr xattr to ovl inode */
> +#define OVL_PROT_I_FLAGS_MASK  (S_APPEND | S_IMMUTABLE)
> +/* vfs fileattr flags copied from real to ovl inode */
> +#define OVL_FATTR_I_FLAGS_MASK (OVL_PROT_I_FLAGS_MASK | S_SYNC | S_NOATI=
ME)
>  /* vfs inode flags copied from real to ovl inode */
> -#define OVL_COPY_I_FLAGS_MASK  (S_SYNC | S_NOATIME | S_APPEND | S_IMMUTA=
BLE)
> -/* vfs inode flags read from overlay.protattr xattr to ovl inode */
> -#define OVL_PROT_I_FLAGS_MASK  (S_APPEND | S_IMMUTABLE)
> +#define OVL_COPY_I_FLAGS_MASK  (OVL_FATTR_I_FLAGS_MASK | S_CASEFOLD)
>
>  /*
>   * fileattr flags copied from lower to upper inode on copy up.
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index a99c77802efa1a6d96c43019728d3517fccdc16a..7937aa4daa9c29e8b9219f7fc=
c2abe7fb55b2e5c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1335,6 +1335,7 @@ static struct dentry *ovl_get_root(struct super_blo=
ck *sb,
>         ovl_dentry_set_flag(OVL_E_CONNECTED, root);
>         ovl_set_upperdata(d_inode(root));
>         ovl_inode_init(d_inode(root), &oip, ino, fsid);
> +       WARN_ON(!!IS_CASEFOLDED(d_inode(root)) !=3D ofs->casefold);
>         ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVAL=
IDATE);
>         /* root keeps a reference of upperdentry */
>         dget(upperdentry);
>
> --
> 2.50.1
>

