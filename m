Return-Path: <linux-fsdevel+bounces-57174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB20B1F494
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F971174E46
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7A286893;
	Sat,  9 Aug 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIRbyPzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80245244677;
	Sat,  9 Aug 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754742990; cv=none; b=FUtFQAYVpzeWvYz8yMsEy5E0SfOf7aJ9rOhiNw5OMQ+2+AweOt8HOSjdF2Jd1yoLm6io0Q4lKzZGqZEA91xgpK/nPJm6/l+Gkmyer3yQ8cl4xbhWOuCqsD+XINy6vAeYmnWSyiXJXxd0XgrWEH8Vu3qA6IVo8d16CNevQQ76Z3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754742990; c=relaxed/simple;
	bh=oLw6t04dtk91WBMbXe/9DtsTKh22NqMz2zSS/v0RE2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgVhYlQQg1TKXkgO2UWQ3YQqHZ+QIfT9lEvgHRYiHCdSK4QXxJECgzeYyow4sw/cin5BpUvXJcyfR2fEEF2f4wtPd+CLvSyCPc/HQr0UGUmPks6tNh2SkaBP/mhp6qMmTJrhxELg1EMYwhKUmSWCW16tt+Ap4B90UTJOr97wQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIRbyPzI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so567662366b.3;
        Sat, 09 Aug 2025 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754742987; x=1755347787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRoaKzlW07zs3NpzL/zUAlPACOOfMwP8ZC5PGuZsgDY=;
        b=kIRbyPzISLbsCwDOnceLl3sIPK+ygSS1ne6l02ltigzKH7JkmNiLtEwZrQnfQeo5dy
         CUkPibMIKRh3KI/NuVU680eVelyg2oMyHW+ssE20g0B+2MIKpHtreY/YpqNmAXSzEgoY
         7V0GTqyYhwrE2TMvv0x719TAmf1hhuDjEcELtoHiYGxHtrvcP65zxUn6bBMgFQZu5yhl
         VK3fupyBt8hVUYltMD1yHsaI33m1V+7pd2jS50RtOTbhI/R5i5G8Csf2PutX3A69TI/F
         EVr/7edCHiiOSutlSCPcw9bh/Hu8qAbIlLQTBMjgvg25cbI7SVinZQN6ftn8TcbVHBlX
         6T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754742987; x=1755347787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRoaKzlW07zs3NpzL/zUAlPACOOfMwP8ZC5PGuZsgDY=;
        b=Vjf61cOuQqXB5pitGSyy2xoKJhf1DMJ9DcOCFvpkaDzarbvSNAXj5TMC4Gp+FJkb9o
         UEUSl8i4BQ1R08oWEkt4fH6Jufm0OqqjmXJI2Bicr5byats97rzGUneuTNfVY9kMoo3m
         AfheEdaGkEbCDBq4lCBep+6oVlfQEAR6XGjDnZCTe5CE9NBjzuZnZMGj/DFIupXaaBFZ
         HksFUPaipn7cbtuiMCenifjSjXsSBTqyCXw7/a3H6q0+VKv863yeTmN25qYoO70yxSJR
         xw8LC6A1TruBd098xfoAGbBh1WmCaG8QbkqOy5s32KymC4k5v7WizhjrAWhk6YgeWb5C
         VXDw==
X-Forwarded-Encrypted: i=1; AJvYcCWY7r9FBSQBSffIkFUEo8XSHGfxXRDRUbfoTRhwQE0/vu6dWlL6z1+PAxGR6hNFUzbYFAd8eBXP6lJ38ZBs@vger.kernel.org, AJvYcCXjC7Z4cnn0s8Bjvs/Rx5fNu5v4eXBhRo+2Zydy0FDePuC7mAij0X3zA0nmO0/IMX2QdKNWeAWu84tp5MLT@vger.kernel.org, AJvYcCXwZhjRYyDg8HejDHxoxBIoSX6v4Diog927gdu5znUkO3DeKKgUtRR2HeMKr0ca1Jk8NtqoPtVHNIQes8hDcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0PTLGnJtcOLiPpoes0te4B00kcjxvPVdhhbouJSjOrcVFlyr
	zVFdAK/ploedhNjaPaSayTDsoJlyC4pXvUHDmXNpMyUii62ldkH7A2yXcs7ogOOkpL3xgXjCyRN
	yFsXAoPB2BhIJTzeozWO3pjYVBkAtkws=
X-Gm-Gg: ASbGncuxzN9hVd1m2NjV0DJh71KOLHBU8yaw9j56uhRUPAPvgx7gt82qeyGHZwVDsr+
	VS20wpjxqlxjjMUY/ApDKxw2H/sOC9cwkn5LRC8OY+kEAA51Jnpsrgw2OpEdJb3kDwVwuWsZajo
	035xEJwMtuLYJtbrzYMBDwcbZXX1PYwvafbF6JjIp/bbmZ6Jf2MnKDVbDIH7uXNYxt5l2j3Oplg
	nro5yQ=
X-Google-Smtp-Source: AGHT+IHSWwS/buNPqITaxdKDVY1uKDuwtYzSBRHCgvPL1Qh5tWVb7vQRRJijmb9wUBHlSO9IFpRGutJr3eGhVz8eCNM=
X-Received: by 2002:a17:907:7e89:b0:ae0:35fb:5c83 with SMTP id
 a640c23a62f3a-af9c64bf042mr527260266b.28.1754742986514; Sat, 09 Aug 2025
 05:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com> <20250808-tonyk-overlayfs-v3-1-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-1-30f9be426ba8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 14:36:14 +0200
X-Gm-Features: Ac12FXxP3f5A8LTv5kEEgxosIWCJPDd5y2WC3kiD6sjtLvEpJKNRVeLowoYhTvs
Message-ID: <CAOQ4uxjdE4A14cwkhm+QjZS-5ANhc1568nbNU=KtF-oh_fE3VQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/7] ovl: Store casefold name for case-insentive dentries
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> In order to make case-insentive mounting points work, overlayfs needs

Terminology:
not case-insensitive mounting points
case-insensitive layers.

> the casefolded version of its dentries so the search and insertion in

Terminology:
overlayfs needs the casefolded names
the objects in the rb tree correspond to dirent readdir results not to dent=
ries
which are dcache objects.

> the struct ovl_readdir_data's red-black compares the dentry names in a
> case-insentive fashion.
>
> If a dentry is casefolded, compute and store it's casefolded name and

We are not doing per-dir casefolding so should say:
"If overlay mount is casefolded, compute and store the casefolded name..."

> it's Unicode map. If utf8_casefold() fails, set it's name pointer as
> NULL so it can be ignored and fallback to the original name.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v3:
>  - Guard all the casefolding inside of IS_ENABLED(UNICODE)
> ---
>  fs/overlayfs/readdir.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index b65cdfce31ce27172d28d879559f1008b9c87320..2f42fec97f76c2000f76e15c6=
0975db567b2c6d6 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -16,6 +16,8 @@
>  #include <linux/overflow.h>
>  #include "overlayfs.h"
>
> +#define OVL_NAME_LEN 255
> +

This is very arbitrary.
Either use the existing constant NAME_MAX or
use the max of all layers ofs->namelen.
I think ofs->namelen will always be <=3D NAME_MAX,
so it's fine to use NAME_MAX if we never expose
the cf_name to userspace.

>  struct ovl_cache_entry {
>         unsigned int len;
>         unsigned int type;
> @@ -27,6 +29,8 @@ struct ovl_cache_entry {
>         bool is_upper;
>         bool is_whiteout;
>         bool check_xwhiteout;
> +       char *cf_name;
> +       int cf_len;
>         char name[];
>  };
>
> @@ -45,6 +49,7 @@ struct ovl_readdir_data {
>         struct list_head *list;
>         struct list_head middle;
>         struct ovl_cache_entry *first_maybe_whiteout;
> +       struct unicode_map *map;
>         int count;
>         int err;
>         bool is_upper;
> @@ -166,6 +171,31 @@ static struct ovl_cache_entry *ovl_cache_entry_new(s=
truct ovl_readdir_data *rdd,
>         p->is_whiteout =3D false;
>         /* Defer check for overlay.whiteout to ovl_iterate() */
>         p->check_xwhiteout =3D rdd->in_xwhiteouts_dir && d_type =3D=3D DT=
_REG;
> +       p->cf_name =3D NULL;
> +       p->cf_len =3D 0;
> +
> +#if IS_ENABLED(CONFIG_UNICODE)

Whenever possible in C code you should use:

if (IS_ENABLED(CONFIG_UNICODE) && rdd->map && ...

> +       if (rdd->map && !is_dot_dotdot(name, len)) {
> +               const struct qstr str =3D { .name =3D name, .len =3D len =
};
> +               int ret;
> +
> +               p->cf_name =3D kmalloc(OVL_NAME_LEN, GFP_KERNEL);
> +
> +               if (!p->cf_name) {
> +                       kfree(p);
> +                       return NULL;
> +               }
> +
> +               ret =3D utf8_casefold(rdd->map, &str, p->cf_name, OVL_NAM=
E_LEN);
> +
> +               if (ret < 0) {
> +                       kfree(p->cf_name);
> +                       p->cf_name =3D NULL;
> +               } else {
> +                       p->cf_len =3D ret;
> +               }
> +       }
> +#endif
>
>         if (d_type =3D=3D DT_CHR) {
>                 p->next_maybe_whiteout =3D rdd->first_maybe_whiteout;
> @@ -223,8 +253,10 @@ void ovl_cache_free(struct list_head *list)
>         struct ovl_cache_entry *p;
>         struct ovl_cache_entry *n;
>
> -       list_for_each_entry_safe(p, n, list, l_node)
> +       list_for_each_entry_safe(p, n, list, l_node) {
> +               kfree(p->cf_name);
>                 kfree(p);
> +       }
>
>         INIT_LIST_HEAD(list);
>  }
> @@ -357,12 +389,19 @@ static int ovl_dir_read_merged(struct dentry *dentr=
y, struct list_head *list,
>                 .list =3D list,
>                 .root =3D root,
>                 .is_lowest =3D false,
> +               .map =3D NULL,
>         };
>         int idx, next;
>         const struct ovl_layer *layer;
>
>         for (idx =3D 0; idx !=3D -1; idx =3D next) {
>                 next =3D ovl_path_next(idx, dentry, &realpath, &layer);
> +
> +#if IS_ENABLED(CONFIG_UNICODE)
> +               if (ovl_dentry_casefolded(realpath.dentry))
> +                       rdd.map =3D realpath.dentry->d_sb->s_encoding;
> +#endif
> +

We are not doing per-dir casefolding, so this should be
if (ofs->casefold)

and I'd rather avoid this ifdef, so how about another vfs helper:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2ec4807d4ea8..3f4c89367908 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3738,15 +3738,20 @@ static inline bool
generic_ci_validate_strict_name(struct inode *dir, struct qst
 }
 #endif

-static inline bool sb_has_encoding(const struct super_block *sb)
+static inline struct unicode_map *sb_encoding(const struct super_block *sb=
)
 {
 #if IS_ENABLED(CONFIG_UNICODE)
-       return !!sb->s_encoding;
+       return sb->s_encoding;
 #else
-       return false;
+       return NULL;
 #endif
 }

+static inline bool sb_has_encoding(const struct super_block *sb)
+{
+       return !!sb_encoding(sb);
+}
+

Thanks,
Amir.

