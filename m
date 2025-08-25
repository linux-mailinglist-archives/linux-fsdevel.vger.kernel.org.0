Return-Path: <linux-fsdevel+bounces-59088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDFB345BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C81F1A8834A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930FE2FC87E;
	Mon, 25 Aug 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxoGarBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17152F0C55;
	Mon, 25 Aug 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135646; cv=none; b=HkBSVnJbA1fD9NedNynp0WXTOJQNhCeQ6oVoR8B25LiCkfY6rbbkN1yBBD37DmPj1dIlJvbolZFt89sJIxNuYmZt/7sQrwq4i8E9eLqP7ActS6bQgyOw9HVThi/S18inR0QhF+Vv6I2H5WnViVt9rOa18ctxgaXsTavoYki76ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135646; c=relaxed/simple;
	bh=p8gjBjIRzCHWyUi5DpS2yDHeVUgPqglJHlKKHzmUNTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTGKDKAtHWmoKDV07jM+E5iH9NNdbXH4jN8sViPAAr7I4KoX37BRg2COxHwZHyuHUkcTbU2yd1SrLfiisasBv6tZlczCdjBWj7KxZbewA/WQXZ1sgNRUGEKpVtj/t+PqHQQygsUWLPIfGL7HEa2kzqMOnF0PKZZiqma8JW9GgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxoGarBI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c51f57224so2000912a12.2;
        Mon, 25 Aug 2025 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756135642; x=1756740442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy6qjvAqdLg55WqIQDO8GqXZDAPVRghUSaPnYDJDXUo=;
        b=YxoGarBIarPmskvNj40W8FdRQdgI/yiYrvdxWkzQJpu07EaTv12KVcXOPBvBvNqvgu
         SJkg+poLv/02VqjEakSVW3ZZztTkxAONTIazjKHW0sINSE08S/jsuVObhDIV+xDC8jZO
         yjywFx7WVA+FOsWnVjnsLww9WJ0+JG2F6s5uOCa4XTb7zLYTFlKw0fbSLeZB+Kz206C0
         TJGBs7a8meAR9D6OxI9laXVQsdF0OGyofF7iN1+0d8T2CaD5+L1KTIcdkzwS1SX3AWcE
         +6pmiJegYJQv+1IMXAmDHL1oSX5x7+Xuta2Eb9UBZQquPCOWe78ApkG0h5Bj8klsqaLv
         6P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135642; x=1756740442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy6qjvAqdLg55WqIQDO8GqXZDAPVRghUSaPnYDJDXUo=;
        b=wUv98ec/8P94c/a+wDAgd3mnaRR680J09RdKFPMEwm2tfnYRdGZWkRLRERRwGJw6x8
         Dhul5pqe7iAPxPkBbeSYme5fQw1hTc1mt4lkj0U+8+Ufdjpqoke3XBMDnbS5uIcmRNrK
         xAtd24nCU5AoYq33JhdWADXYd9fTqB/SVyZnsZpqdEhG0dXdFoH5mL5K2XAeZrXakQWK
         OxitNXLtwMNM6pdoudQSLfwts/2YzN5dvrhKpUw2l0F0SMRMEBhKB62YHoeSC+WJzERp
         m4RhskpRVTbRxiwdlrvmy++3SAYOhfCJJZEVhP9XlqtGxoBcPr9nMhHuOotNpYnN1Oa3
         tbMg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/Q60xrud5m2bym4kzcYIp25tLnEu5MMvqwRnHw3BDOKMH7NM4A2kfY8nxQPBWceYBNBjgIrzhbhU0C3b@vger.kernel.org, AJvYcCVTX6TpIrtFrb/dLMsXfK0DHrCjHZtBp7wtb3iOH9mcV50WgtFSLE7aLOaLbQJ2a8sUjOJ74m2WlWZsVh55nw==@vger.kernel.org, AJvYcCXoFTPo+I8JrVPBjvpdjx0R4yrnPfORarAv1W2bJZZosY4VahNgWj1xpNAJf3tFPwP4CPY50PfsTsCCjmVG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1jkz2/duQ/GwGN5IfyerPDWklY7ua/9O1TJXhgZm4ratDK/p
	rMOKsC/XWALqc4a+BJgf7HAKbRcAuWHFJbcNe39B+Uz0GrRs1FHGY/lyTMO4+AGuFMi255Vbi84
	cKF4gJXyA5tf3mEcSs7gyuHRZx7B0v3FISkr4DRKTTw==
X-Gm-Gg: ASbGncs0U6LHdWRbRwsa+u43nl4t/jhrxRFpAaEk7seZnTYwaDZ+Gib/9zMkb9PkOJl
	tofNzMTwiBBkTNYTFEvnPEEppw3PJSQ6/jUb9Dwnjb0Y35qTA2eyhfuizdqdZksqSbO6TTVR/q/
	S0Jsq2CynZsWp++dGBUYvZFayMUwgqypQrLhXAq5DSLEF/HL8BqDNvdr2l+yLln5pROl3DwXX3H
	FtroyU=
X-Google-Smtp-Source: AGHT+IEAzbB/CckAXYzaLzCwDVk9E9eUI4JL0NigOKEkk38DYSBA8wkQSDHfEfXP4TWzmjbFqH2nXx2RlZUx/xz7YAU=
X-Received: by 2002:a05:6402:5057:b0:61a:8c7c:a1f4 with SMTP id
 4fb4d7f45d1cf-61c1b48f5e9mr9677089a12.11.1756135641879; Mon, 25 Aug 2025
 08:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com> <875xeb64ks.fsf@mailhost.krisman.be>
In-Reply-To: <875xeb64ks.fsf@mailhost.krisman.be>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Aug 2025 17:27:10 +0200
X-Gm-Features: Ac12FXzbwQaszvkSxUPM330MG6gvx4rn4xgw8knBAnp5njdcSD1RjDrShs2BH6Q
Message-ID: <CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 1:09=E2=80=AFPM Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
>
> > To add overlayfs support casefold layers, create a new function
> > ovl_casefold(), to be able to do case-insensitive strncmp().
> >
> > ovl_casefold() allocates a new buffer and stores the casefolded version
> > of the string on it. If the allocation or the casefold operation fails,
> > fallback to use the original string.
> >
> > The case-insentive name is then used in the rb-tree search/insertion
> > operation. If the name is found in the rb-tree, the name can be
> > discarded and the buffer is freed. If the name isn't found, it's then
> > stored at struct ovl_cache_entry to be used later.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> > Changes from v6:
> >  - Last version was using `strncmp(... tmp->len)` which was causing
> >    regressions. It should be `strncmp(... len)`.
> >  - Rename cf_len to c_len
> >  - Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
> >  - Remove needless kfree(cf_name)
> > ---
> >  fs/overlayfs/readdir.c | 113 ++++++++++++++++++++++++++++++++++++++++-=
--------
> >  1 file changed, 94 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index b65cdfce31ce27172d28d879559f1008b9c87320..dfc661b7bc3f87efbf14991=
e97cee169400d823b 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -27,6 +27,8 @@ struct ovl_cache_entry {
> >       bool is_upper;
> >       bool is_whiteout;
> >       bool check_xwhiteout;
> > +     const char *c_name;
> > +     int c_len;
> >       char name[];
> >  };
> >
> > @@ -45,6 +47,7 @@ struct ovl_readdir_data {
> >       struct list_head *list;
> >       struct list_head middle;
> >       struct ovl_cache_entry *first_maybe_whiteout;
> > +     struct unicode_map *map;
> >       int count;
> >       int err;
> >       bool is_upper;
> > @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_from_=
node(struct rb_node *n)
> >       return rb_entry(n, struct ovl_cache_entry, node);
> >  }
> >
> > +static int ovl_casefold(struct unicode_map *map, const char *str, int =
len, char **dst)
> > +{
> > +     const struct qstr qstr =3D { .name =3D str, .len =3D len };
> > +     int cf_len;
> > +
> > +     if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, len=
))
> > +             return 0;
> > +
> > +     *dst =3D kmalloc(NAME_MAX, GFP_KERNEL);
> > +
> > +     if (dst) {
> > +             cf_len =3D utf8_casefold(map, &qstr, *dst, NAME_MAX);
> > +
> > +             if (cf_len > 0)
> > +                     return cf_len;
> > +     }
> > +
> > +     kfree(*dst);
> > +     return 0;
> > +}
>
> Hi,
>
> I should just note this does not differentiates allocation errors from
> casefolding errors (invalid encoding).  It might be just a theoretical
> error because GFP_KERNEL shouldn't fail (wink, wink) and the rest of the
> operation is likely to fail too, but if you have an allocation failure, y=
ou
> can end up with an inconsistent cache, because a file is added under the
> !casefolded name and a later successful lookup will look for the
> casefolded version.

Good point.
I will fix this in my tree.

>
> > +
> >  static bool ovl_cache_entry_find_link(const char *name, int len,
> >                                     struct rb_node ***link,
> >                                     struct rb_node **parent)
> > @@ -79,10 +103,10 @@ static bool ovl_cache_entry_find_link(const char *=
name, int len,
> >
> >               *parent =3D *newp;
> >               tmp =3D ovl_cache_entry_from_node(*newp);
> > -             cmp =3D strncmp(name, tmp->name, len);
> > +             cmp =3D strncmp(name, tmp->c_name, len);
> >               if (cmp > 0)
> >                       newp =3D &tmp->node.rb_right;
> > -             else if (cmp < 0 || len < tmp->len)
> > +             else if (cmp < 0 || len < tmp->c_len)
> >                       newp =3D &tmp->node.rb_left;
> >               else
> >                       found =3D true;
> > @@ -101,10 +125,10 @@ static struct ovl_cache_entry *ovl_cache_entry_fi=
nd(struct rb_root *root,
> >       while (node) {
> >               struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(n=
ode);
> >
> > -             cmp =3D strncmp(name, p->name, len);
> > +             cmp =3D strncmp(name, p->c_name, len);
> >               if (cmp > 0)
> >                       node =3D p->node.rb_right;
> > -             else if (cmp < 0 || len < p->len)
> > +             else if (cmp < 0 || len < p->c_len)
> >                       node =3D p->node.rb_left;
> >               else
> >                       return p;
> > @@ -145,6 +169,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data =
*rdd,
> >
> >  static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_=
data *rdd,
> >                                                  const char *name, int =
len,
> > +                                                const char *c_name, in=
t c_len,
> >                                                  u64 ino, unsigned int =
d_type)
> >  {
> >       struct ovl_cache_entry *p;
> > @@ -167,6 +192,14 @@ static struct ovl_cache_entry *ovl_cache_entry_new=
(struct ovl_readdir_data *rdd,
> >       /* Defer check for overlay.whiteout to ovl_iterate() */
> >       p->check_xwhiteout =3D rdd->in_xwhiteouts_dir && d_type =3D=3D DT=
_REG;
> >
> > +     if (c_name && c_name !=3D name) {
> > +             p->c_name =3D c_name;
> > +             p->c_len =3D c_len;
> > +     } else {
> > +             p->c_name =3D p->name;
> > +             p->c_len =3D len;
> > +     }
> > +
> >       if (d_type =3D=3D DT_CHR) {
> >               p->next_maybe_whiteout =3D rdd->first_maybe_whiteout;
> >               rdd->first_maybe_whiteout =3D p;
> > @@ -174,48 +207,55 @@ static struct ovl_cache_entry *ovl_cache_entry_ne=
w(struct ovl_readdir_data *rdd,
> >       return p;
> >  }
> >
> > -static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> > -                               const char *name, int len, u64 ino,
> > +/* Return 0 for found, 1 for added, <0 for error */
> > +static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> > +                               const char *name, int len,
> > +                               const char *c_name, int c_len,
> > +                               u64 ino,
> >                                 unsigned int d_type)
> >  {
> >       struct rb_node **newp =3D &rdd->root->rb_node;
> >       struct rb_node *parent =3D NULL;
> >       struct ovl_cache_entry *p;
> >
> > -     if (ovl_cache_entry_find_link(name, len, &newp, &parent))
> > -             return true;
> > +     if (ovl_cache_entry_find_link(c_name, c_len, &newp, &parent))
> > +             return 0;
> >
> > -     p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
> > +     p =3D ovl_cache_entry_new(rdd, name, len, c_name, c_len, ino, d_t=
ype);
> >       if (p =3D=3D NULL) {
> >               rdd->err =3D -ENOMEM;
> > -             return false;
> > +             return -ENOMEM;
> >       }
> >
> >       list_add_tail(&p->l_node, rdd->list);
> >       rb_link_node(&p->node, parent, newp);
> >       rb_insert_color(&p->node, rdd->root);
> >
> > -     return true;
> > +     return 1;
> >  }
> >
> > -static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
> > +/* Return 0 for found, 1 for added, <0 for error */
> > +static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
> >                          const char *name, int namelen,
> > +                        const char *c_name, int c_len,
> >                          loff_t offset, u64 ino, unsigned int d_type)
> >  {
> >       struct ovl_cache_entry *p;
> >
> > -     p =3D ovl_cache_entry_find(rdd->root, name, namelen);
> > +     p =3D ovl_cache_entry_find(rdd->root, c_name, c_len);
> >       if (p) {
> >               list_move_tail(&p->l_node, &rdd->middle);
> > +             return 0;
> >       } else {
> > -             p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type=
);
> > +             p =3D ovl_cache_entry_new(rdd, name, namelen, c_name, c_l=
en,
> > +                                     ino, d_type);
> >               if (p =3D=3D NULL)
> >                       rdd->err =3D -ENOMEM;
> >               else
> >                       list_add_tail(&p->l_node, &rdd->middle);
> >       }
> >
> > -     return rdd->err =3D=3D 0;
> > +     return rdd->err ?: 1;
> >  }
> >
> >  void ovl_cache_free(struct list_head *list)
> > @@ -223,8 +263,11 @@ void ovl_cache_free(struct list_head *list)
> >       struct ovl_cache_entry *p;
> >       struct ovl_cache_entry *n;
> >
> > -     list_for_each_entry_safe(p, n, list, l_node)
> > +     list_for_each_entry_safe(p, n, list, l_node) {
> > +             if (p->c_name !=3D p->name)
> > +                     kfree(p->c_name);
> >               kfree(p);
> > +     }
> >
> >       INIT_LIST_HEAD(list);
> >  }
> > @@ -260,12 +303,36 @@ static bool ovl_fill_merge(struct dir_context *ct=
x, const char *name,
> >  {
> >       struct ovl_readdir_data *rdd =3D
> >               container_of(ctx, struct ovl_readdir_data, ctx);
> > +     struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
> > +     const char *c_name =3D NULL;
> > +     char *cf_name =3D NULL;
> > +     int c_len =3D 0, ret;
> > +
> > +     if (ofs->casefold)
> > +             c_len =3D ovl_casefold(rdd->map, name, namelen, &cf_name)=
;
> > +
> > +     if (c_len <=3D 0) {
> > +             c_name =3D name;
> > +             c_len =3D namelen;
> > +     } else {
> > +             c_name =3D cf_name;
> > +     }
> >
> >       rdd->count++;
> >       if (!rdd->is_lowest)
> > -             return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_=
type);
> > +             ret =3D ovl_cache_entry_add_rb(rdd, name, namelen, c_name=
, c_len, ino, d_type);
> >       else
> > -             return ovl_fill_lowest(rdd, name, namelen, offset, ino, d=
_type);
> > +             ret =3D ovl_fill_lowest(rdd, name, namelen, c_name, c_len=
, offset, ino, d_type);
> > +
> > +     /*
> > +      * If ret =3D=3D 1, that means that c_name is being used as part =
of struct
> > +      * ovl_cache_entry and will be freed at ovl_cache_free(). Otherwi=
se,
> > +      * c_name was found in the rb-tree so we can free it here.
> > +      */
> > +     if (ret !=3D 1 && c_name !=3D name)
> > +             kfree(c_name);
> > +
>
> The semantics of this being conditionally freed is a bit annoying, as
> it is already replicated in 3 places. I suppose a helper would come in
> hand.

Yeh.

I have already used ovl_cache_entry_free() in my tree.

Thanks,
Amir.

>
> In this specific case, it could just be:
>
> if (ret !=3D 1)
>         kfree(cf_name);
>
>
> > +     return ret >=3D 0;
> >  }
> >
> >  static int ovl_check_whiteouts(const struct path *path, struct ovl_rea=
ddir_data *rdd)
> > @@ -357,12 +424,18 @@ static int ovl_dir_read_merged(struct dentry *den=
try, struct list_head *list,
> >               .list =3D list,
> >               .root =3D root,
> >               .is_lowest =3D false,
> > +             .map =3D NULL,
> >       };
> >       int idx, next;
> >       const struct ovl_layer *layer;
> > +     struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >
> >       for (idx =3D 0; idx !=3D -1; idx =3D next) {
> >               next =3D ovl_path_next(idx, dentry, &realpath, &layer);
> > +
> > +             if (ofs->casefold)
> > +                     rdd.map =3D sb_encoding(realpath.dentry->d_sb);
> > +
> >               rdd.is_upper =3D ovl_dentry_upper(dentry) =3D=3D realpath=
.dentry;
> >               rdd.in_xwhiteouts_dir =3D layer->has_xwhiteouts &&
> >                                       ovl_dentry_has_xwhiteouts(dentry)=
;
> > @@ -555,7 +628,7 @@ static bool ovl_fill_plain(struct dir_context *ctx,=
 const char *name,
> >               container_of(ctx, struct ovl_readdir_data, ctx);
> >
> >       rdd->count++;
> > -     p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
> > +     p =3D ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_typ=
e);
> >       if (p =3D=3D NULL) {
> >               rdd->err =3D -ENOMEM;
> >               return false;
> > @@ -1023,6 +1096,8 @@ int ovl_check_empty_dir(struct dentry *dentry, st=
ruct list_head *list)
> >
> >  del_entry:
> >               list_del(&p->l_node);
> > +             if (p->c_name !=3D p->name)
> > +                     kfree(p->c_name);
> >               kfree(p);
> >       }
>
> --
> Gabriel Krisman Bertazi

