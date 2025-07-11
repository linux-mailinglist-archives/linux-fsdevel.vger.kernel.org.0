Return-Path: <linux-fsdevel+bounces-54606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7E3B018A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813D51CA6DA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5792B27F16A;
	Fri, 11 Jul 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb65eGMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972627E06C;
	Fri, 11 Jul 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227206; cv=none; b=iHf8bNLwF5abJtBQScffxjgGsDJJZpTuYFr/y93chURIMAlJEgXc6XZuBcGFvz4obTw4eUrfJh3H6+dWZ6O3tnCe422bayrwyXWTNFaXvjEx8kAC5/AQgz8rJCHyixStfp9xfOnGIhMyYXI+jc6wZsRyJKfVx71M2O6Dv8szfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227206; c=relaxed/simple;
	bh=FhKULSqGBmvnGSH+FwP5V1mfWJ77eOEIiy6JATcKyQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gtn24nLKN4nGSu4Sp5kwNO2LD6YjLTSQlgDMf0hqAuY6Quh301QiaEa19Da0YHP0p5u6bhIoOvQEC9fQvZ824r++bJFfCird8YK/6z6BWGxxoG6DA455ezJ5M96UB78hicpoolvP8tCi0vA2cYo+kDT/vWzQVOM8y0hp7g7t8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb65eGMM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso630879966b.0;
        Fri, 11 Jul 2025 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227202; x=1752832002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWxaFq6B1WhfohWAxkce96BoUL90ZeODa6IArkghQVg=;
        b=Wb65eGMM0Ds2tgPB9qp1NfUU7mBz+mdkC1mkHcTuMZPp7p2VR5tsLXhMtP1s3Jd3vP
         4nDNDMKR9m6tuwaPSdh/UfjkrgBaIYMocfOmhiHck293XTqyjHnCPf9f6SPR3zGQVpCm
         ZBCxziStAdtXiwV4cPVBsvn1XtbYGhNZPLpKCp/NaOL9bs+rUJcjavJbm8leIEKWkhYn
         mgcveUNWlX48tdoHLu1qSzAB0H06xKELqFH+g360uiee+Cg7OSHymfdS3qXyQ7b69HKM
         xFW5Vfm+zA9BZSwKFFA5ALN6sWAR9GcpT4TQQNIkBU4/EyWBC0KxQGrR1ZiKNNgKnKZj
         K0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227202; x=1752832002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWxaFq6B1WhfohWAxkce96BoUL90ZeODa6IArkghQVg=;
        b=dTNd0LAgNgWzy4gtRqDAp8tQ/Z8rEJDScv+qidDTpOUqLbq5/s27lYocxnTHPGNDyV
         9QNGSddfBExVbzvbsJbs/TDCvUdWaV2GMdAMDeBRBgRNWYm3AFDTSckTRxPaXIZ4AiCm
         BYS0swAG88k24ADtXtyatE2KBgzO5edrF4fakn3Rh6W5ljgfTVXWuVPIjxmlUDmw02zQ
         ixE8uHccTQdkzi4JVN+qOx/pM/B42U8Y1HkkBzWKWfOKgIB4kaFSGuzTJGooAoArU0Xv
         tM0pmL4gG0MTUBAbZ0Az7/UZ4YXwVs/nPPD1uPy0niraWybBpG4g2Ikv0lQ8lv75iqIG
         zDvw==
X-Forwarded-Encrypted: i=1; AJvYcCUcS10fk1GiKda+2qm/Tnvida4f6Z0fYboI0YIoc2IlBVew64IYf70xkTk3VUvna8bdtkcEI73tQy2HjqxzhQ==@vger.kernel.org, AJvYcCVa/v7+NFAPbvK/Lufni6INOII4mepZ9eTepETORxcgTAsNYbmE8DqkRSedpMvIEDRgWXGOgjbB8RwCRYE6@vger.kernel.org, AJvYcCWzCN6a2WCihGHXBnITWzldEWmkcvGMh2es/S8vxT7Lf6Ns/YZ9ZSIJfa0nPOqgMoixtWN8D0ZOU912ZR8q@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2sAvyv91qix0vvKETe/ipOoJUbsrTXMefSfi0GH8+kOflykm
	po2EshwjNqV5FwaS2QCbSB/Uu56sEdCMcDWg459xP3WmBH68rWc0WuIls/dvDjogh93us5Lfkd4
	zxOvoXuIAKjneiixV6DWcbIvQRGHlO1I=
X-Gm-Gg: ASbGncv3h/75ET8TKREXjoVJyYA0Tx14ifQN80l6WxwjeMB3RJswxq78h5SljqBFwGp
	oUQgM4XotZUy/VU9NZT8PyDKmXrGk6K4b0PXpKJ4PjCF6Sz+DEhakZHSf/ChuvVOh0XLsxfgJ09
	h6vuWHE2IMJ7qwPaJZJtug4u8Jf46gpBjfU0O0SOZsNNWqZfCpne8SbIU04x2+jLIX6iM4GY19T
	CuMiAY=
X-Google-Smtp-Source: AGHT+IHiY3xa6kGWa2ZZx/ubPBkWo65H8kbbj2DkUhbZf4YWqT9FMnaC25+qUJjTgy1w80qmvk38mF4HYHRbYnCULoA=
X-Received: by 2002:a17:906:9f91:b0:ae0:7e95:fb with SMTP id
 a640c23a62f3a-ae6e227c889mr719410466b.5.1752227201542; Fri, 11 Jul 2025
 02:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com> <20250409-tonyk-overlayfs-v1-1-3991616fe9a3@igalia.com>
In-Reply-To: <20250409-tonyk-overlayfs-v1-1-3991616fe9a3@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 11:46:30 +0200
X-Gm-Features: Ac12FXxZ3_W7PgUflUyUh3BPlyzS0a0otRjvpz7FCpnsZ38Tqeeglv4E0Ein8rU
Message-ID: <CAOQ4uxjv199LB4XhgeSbTc9VkPB16S86vwcz9tq4GHVX4eVx-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ovl: Make ovl_cache_entry_find support casefold
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> To add overlayfs support casefold filesystems, make
> ovl_cache_entry_find() support casefold dentries.
>
> For the casefold support, just comparing the strings does not work
> because we need the dentry enconding, so make this function find the
> equivalent dentry for a giving directory, if any.
>
> Also, if two strings are not equal, strncmp() return value sign can be
> either positive or negative and this information can be used to optimize
> the walk in the rb tree. utf8_strncmp(), in the other hand, just return
> true or false, so replace the rb walk with a normal rb_next() function.

You cannot just replace a more performance implementation with a
less performant one for everyone else just for your niche use case.
Also it is the wrong approach.

This code needs to use utf8_normalize() to store the normalized
name in the rbtree instead of doing lookup and d_same_name().
and you need to do ovl_cache_entry_add_rb() with the normalized
name anotherwise you break the logic of ovl_dir_read_merged().

Gabriel,

Do you think it makes sense to use utf8_normalize() from this code
directly to generate a key for "is this name found in another layer"
search tree?

I see that utf8_normalize() has zero users, so I guess there was
an intention to use it for things like that?

More nits below, but they will not be relevant once you use the normalized =
name.

Thanks,
Amir.

>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/readdir.c   | 32 +++++++++++++++++++++-----------
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index cb449ab310a7a89aafa0ee04ee7ff6c8141dd7d5..2ee52da85ba3e3fd704415a7e=
e4e9b7da88bb019 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -90,6 +90,7 @@ struct ovl_fs {
>         bool no_shared_whiteout;
>         /* r/o snapshot of upperdir sb's only taken on volatile mounts */
>         errseq_t errseq;
> +       bool casefold;
>  };
>
>  /* Number of lower layers, not including data-only layers */
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 881ec5592da52dfb27a588496582e7084b2fbd3b..68f4a83713e9beab604fd2331=
9d60567ef1feeca 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -92,21 +92,31 @@ static bool ovl_cache_entry_find_link(const char *nam=
e, int len,
>  }
>
>  static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root=
,
> -                                                   const char *name, int=
 len)
> +                                                   const char *name, int=
 len,
> +                                                   struct dentry *upper)

This is not an "upper" it is an overlayfs dentry that we call "dentry"

>  {
> +       struct ovl_fs *ofs =3D OVL_FS(upper->d_sb);

OVL_FS(upper) is never correct, because OVL_FS() is only applicable to
ovl dentries.

>         struct rb_node *node =3D root->rb_node;
> -       int cmp;
> +       struct qstr q =3D { .name =3D name, .len =3D len };
>
>         while (node) {
>                 struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(n=
ode);
> +               struct dentry *p_dentry, *real_dentry =3D NULL;
> +
> +               if (ofs->casefold && upper) {
> +                       p_dentry =3D ovl_lookup_upper(ofs, p->name, upper=
, p->len);

and here you are mixing a helper to lookup in underlying upper fs with
an overlayfs dentry. You should not do lookup in this context at all.

> +                       if (!IS_ERR(p_dentry)) {
> +                               real_dentry =3D ovl_dentry_real(p_dentry)=
;
> +                               if (d_same_name(real_dentry, real_dentry-=
>d_parent, &q))
> +                                       return p;
> +                       }
> +               }
>
> -               cmp =3D strncmp(name, p->name, len);
> -               if (cmp > 0)
> -                       node =3D p->node.rb_right;
> -               else if (cmp < 0 || len < p->len)
> -                       node =3D p->node.rb_left;
> -               else
> -                       return p;
> +               if (!real_dentry)
> +                       if (!strncmp(name, p->name, len))
> +                               return p;
> +
> +               node =3D rb_next(&p->node);

As I wrote this change is wrong and unneeded when using normalized names.

Thanks,
Amir.

