Return-Path: <linux-fsdevel+bounces-59093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03FB34637
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E36B2A3E8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F422F2914;
	Mon, 25 Aug 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnsXwwbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5849278771;
	Mon, 25 Aug 2025 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136757; cv=none; b=cVV0y+tgYg9NJ5VHeRsgScSKLIzl1bf0yV40hBw2uX3MlJhmWa5/r1aYVCTkJILWBL9NEZOQ6Opqpa07F8/oxQ0yA3bxVNCkwCqk7IUqjgiubWvQoDD5h8x9dE80il1VfNfnn3ZQPjFxFe1OjPU01mbwLf7CyLz/Bh7HOaZgxmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136757; c=relaxed/simple;
	bh=gpwk34UtNdwchwZ86ose4BoGJLBjkAAyl6IX6ZmWXP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8VAZi8VCoYSkWvdnAL1jB5vcHajQJQ6ziJggzYiVvB8fBViJkf3n9sjSi2PVhoDjncPJacDL6HZObbq3UVHCR49KKUj7tcJ54nEaB1A7gYzvvGK0OB29DWu/ZHg5NSZUSsQ2cmF2xAD8IKVePTtSkqkhy1bedtTHNuNatQSn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnsXwwbA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7acfde3so672685966b.3;
        Mon, 25 Aug 2025 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756136753; x=1756741553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okN3TzR4B4zAGpHAfXKiCwVxyhlUlFs/QttoG5tVXWc=;
        b=nnsXwwbAiT+wyOnbCkKC1hrA89KRAuosWXphx8V+9enjnYj/b4iU1J9aUkefNRz41i
         z7Ma6GTlDzaOAfRO2mCqa04Stt6SfxFp+sj82dl2n1S0NBgAx5IZiHDdLSBfd3iKIYTC
         45HyOHWVSuOHPdg48gmB7ZXTHVuLMBGGraaSX5T/CC0B3QIXU622O0GFQFPogFgAljtS
         5XPVLE24RVvQ/3ku0z854Cj3dJsoVEaSapMCWSoDsuVX3Wvs673MHUSZjRbt0KF82A0a
         C18jufHdZnaOBpsI+UGc6GISXNtS3CJYqNWupxmx6MfL1YdXLFECFo2KoJq+HU0eZXFf
         2QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756136753; x=1756741553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okN3TzR4B4zAGpHAfXKiCwVxyhlUlFs/QttoG5tVXWc=;
        b=hzX6UG07W6f/H/vbARmhnDPjbXyq7OuSsfpC6K0TQtF9X/ZsLVwdSL/3fq4Uv1YYnC
         QuTP0Mpu0t+R9VIUFZD7W8J97UrqxnJCDPYh4uMTfr+CGZMWHRmBEXxbBwt7pTeFz1zk
         +KRj9BT6RW648924ENE1tXWTEc36MEgQLD8enyiL/8P+q7+rxdKw/sDZDaPZtS+VoVSl
         xrBHfi4zPZdCvcTOJV7X7D7IFPy+AqzroKByTym+jfFI7p8FG75ZLrRvSb134TgH0Stt
         ClvPH1MBJAVs+MD//8YwwRDRF6q5x6K9+ayoOqpAuklRoI6ZO/Mji2O+ewfG0aiVyCBS
         5q1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTgQOAt8KV0Hsqm9Y1YeOYYv8/gkcwyNRc4enI4mH1pL5MjM1XlU0TbVBKBtFCCVcNxYB46xbRZAP5j1si@vger.kernel.org, AJvYcCXagS7PEyg/emFGg4ZY0YcVIg68D8lDydjYf/CFm7nwAVGrFBPerYrIMDThHKqRDIBzWryZX42I2UO4Uxumvw==@vger.kernel.org, AJvYcCXpUkHwRcN0zXcTumHiGA8DST5J5XVsugu0i5taDV5FBSRpnS0bT2TFOg9X1qw6ckVbnvBYgVc8Lwe3PW/V@vger.kernel.org
X-Gm-Message-State: AOJu0YwLO6vRKT4XntiEZ1tXu/iCSgOtCqR7B9jFXXt4PVTpQlb1LOzK
	KTn2USuUSM5q6GXb9do3ejY/iriFvMQJjlBzsTiAfSsFxQsuKjZZ89mKyjqV2XrCbRQMay8UuyM
	NFDsUS/GKwcvYkWFa57NwZnQaoFnGdzo=
X-Gm-Gg: ASbGncsyYo55QiuxbytgjbUtIdX6N89Kb/96KZwULM9GXtrNOTKBemSO0FL2OpQJqrJ
	JFhqsz6F/CE1xfqVldwr/d+YAi9N7cwiis57DqQYXnjtEYoklCHzs14Gj7Sb5ug5nsitxoyu3gZ
	2qX9v3mzfLgokcnPmYHM4ihvnehStxGRAVTJSk/tm+R/OduLEngYtWP8tSj3GyXyxO+apT9EwaE
	bq2hQyuAaxeMj7XOQ==
X-Google-Smtp-Source: AGHT+IGfmy4YKPmxcWMaGbKgQNJp77bsCl79ES9qeXok+cHbOQcOoMPF/IE9D1lC6vaCDok0greka6PqGS9D8gk6jf4=
X-Received: by 2002:a05:6402:34d6:b0:61c:6ca1:1a8c with SMTP id
 4fb4d7f45d1cf-61c6ca1237fmr2884059a12.20.1756136752540; Mon, 25 Aug 2025
 08:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com> <875xeb64ks.fsf@mailhost.krisman.be>
 <CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Aug 2025 17:45:40 +0200
X-Gm-Features: Ac12FXxIFbqcDt5vi70gupTgtojKH-1UE_eI82gWTnYNvDBc2CwoxRy1AGM23vU
Message-ID: <CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Aug 25, 2025 at 1:09=E2=80=AFPM Gabriel Krisman Bertazi
> <gabriel@krisman.be> wrote:
> >
> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
> >
> > > To add overlayfs support casefold layers, create a new function
> > > ovl_casefold(), to be able to do case-insensitive strncmp().
> > >
> > > ovl_casefold() allocates a new buffer and stores the casefolded versi=
on
> > > of the string on it. If the allocation or the casefold operation fail=
s,
> > > fallback to use the original string.
> > >
> > > The case-insentive name is then used in the rb-tree search/insertion
> > > operation. If the name is found in the rb-tree, the name can be
> > > discarded and the buffer is freed. If the name isn't found, it's then
> > > stored at struct ovl_cache_entry to be used later.
> > >
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > > ---
> > > Changes from v6:
> > >  - Last version was using `strncmp(... tmp->len)` which was causing
> > >    regressions. It should be `strncmp(... len)`.
> > >  - Rename cf_len to c_len
> > >  - Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
> > >  - Remove needless kfree(cf_name)
> > > ---
> > >  fs/overlayfs/readdir.c | 113 +++++++++++++++++++++++++++++++++++++++=
+---------
> > >  1 file changed, 94 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > > index b65cdfce31ce27172d28d879559f1008b9c87320..dfc661b7bc3f87efbf149=
91e97cee169400d823b 100644
> > > --- a/fs/overlayfs/readdir.c
> > > +++ b/fs/overlayfs/readdir.c
> > > @@ -27,6 +27,8 @@ struct ovl_cache_entry {
> > >       bool is_upper;
> > >       bool is_whiteout;
> > >       bool check_xwhiteout;
> > > +     const char *c_name;
> > > +     int c_len;
> > >       char name[];
> > >  };
> > >
> > > @@ -45,6 +47,7 @@ struct ovl_readdir_data {
> > >       struct list_head *list;
> > >       struct list_head middle;
> > >       struct ovl_cache_entry *first_maybe_whiteout;
> > > +     struct unicode_map *map;
> > >       int count;
> > >       int err;
> > >       bool is_upper;
> > > @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_fro=
m_node(struct rb_node *n)
> > >       return rb_entry(n, struct ovl_cache_entry, node);
> > >  }
> > >
> > > +static int ovl_casefold(struct unicode_map *map, const char *str, in=
t len, char **dst)
> > > +{
> > > +     const struct qstr qstr =3D { .name =3D str, .len =3D len };
> > > +     int cf_len;
> > > +
> > > +     if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, l=
en))
> > > +             return 0;
> > > +
> > > +     *dst =3D kmalloc(NAME_MAX, GFP_KERNEL);
> > > +
> > > +     if (dst) {
> > > +             cf_len =3D utf8_casefold(map, &qstr, *dst, NAME_MAX);
> > > +
> > > +             if (cf_len > 0)
> > > +                     return cf_len;
> > > +     }
> > > +
> > > +     kfree(*dst);
> > > +     return 0;
> > > +}
> >
> > Hi,
> >
> > I should just note this does not differentiates allocation errors from
> > casefolding errors (invalid encoding).  It might be just a theoretical
> > error because GFP_KERNEL shouldn't fail (wink, wink) and the rest of th=
e
> > operation is likely to fail too, but if you have an allocation failure,=
 you
> > can end up with an inconsistent cache, because a file is added under th=
e
> > !casefolded name and a later successful lookup will look for the
> > casefolded version.
>
> Good point.
> I will fix this in my tree.

wait why should we not fail to fill the cache for both allocation
and encoding errors?

Thanks,
Amir.

>
> >
> > > +
> > >  static bool ovl_cache_entry_find_link(const char *name, int len,
> > >                                     struct rb_node ***link,
> > >                                     struct rb_node **parent)
> > > @@ -79,10 +103,10 @@ static bool ovl_cache_entry_find_link(const char=
 *name, int len,
> > >
> > >               *parent =3D *newp;
> > >               tmp =3D ovl_cache_entry_from_node(*newp);
> > > -             cmp =3D strncmp(name, tmp->name, len);
> > > +             cmp =3D strncmp(name, tmp->c_name, len);
> > >               if (cmp > 0)
> > >                       newp =3D &tmp->node.rb_right;
> > > -             else if (cmp < 0 || len < tmp->len)
> > > +             else if (cmp < 0 || len < tmp->c_len)
> > >                       newp =3D &tmp->node.rb_left;
> > >               else
> > >                       found =3D true;
> > > @@ -101,10 +125,10 @@ static struct ovl_cache_entry *ovl_cache_entry_=
find(struct rb_root *root,
> > >       while (node) {
> > >               struct ovl_cache_entry *p =3D ovl_cache_entry_from_node=
(node);
> > >
> > > -             cmp =3D strncmp(name, p->name, len);
> > > +             cmp =3D strncmp(name, p->c_name, len);
> > >               if (cmp > 0)
> > >                       node =3D p->node.rb_right;
> > > -             else if (cmp < 0 || len < p->len)
> > > +             else if (cmp < 0 || len < p->c_len)
> > >                       node =3D p->node.rb_left;
> > >               else
> > >                       return p;
> > > @@ -145,6 +169,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_dat=
a *rdd,
> > >
> > >  static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdi=
r_data *rdd,
> > >                                                  const char *name, in=
t len,
> > > +                                                const char *c_name, =
int c_len,
> > >                                                  u64 ino, unsigned in=
t d_type)
> > >  {
> > >       struct ovl_cache_entry *p;
> > > @@ -167,6 +192,14 @@ static struct ovl_cache_entry *ovl_cache_entry_n=
ew(struct ovl_readdir_data *rdd,
> > >       /* Defer check for overlay.whiteout to ovl_iterate() */
> > >       p->check_xwhiteout =3D rdd->in_xwhiteouts_dir && d_type =3D=3D =
DT_REG;
> > >
> > > +     if (c_name && c_name !=3D name) {
> > > +             p->c_name =3D c_name;
> > > +             p->c_len =3D c_len;
> > > +     } else {
> > > +             p->c_name =3D p->name;
> > > +             p->c_len =3D len;
> > > +     }
> > > +
> > >       if (d_type =3D=3D DT_CHR) {
> > >               p->next_maybe_whiteout =3D rdd->first_maybe_whiteout;
> > >               rdd->first_maybe_whiteout =3D p;
> > > @@ -174,48 +207,55 @@ static struct ovl_cache_entry *ovl_cache_entry_=
new(struct ovl_readdir_data *rdd,
> > >       return p;
> > >  }
> > >
> > > -static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> > > -                               const char *name, int len, u64 ino,
> > > +/* Return 0 for found, 1 for added, <0 for error */
> > > +static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> > > +                               const char *name, int len,
> > > +                               const char *c_name, int c_len,
> > > +                               u64 ino,
> > >                                 unsigned int d_type)
> > >  {
> > >       struct rb_node **newp =3D &rdd->root->rb_node;
> > >       struct rb_node *parent =3D NULL;
> > >       struct ovl_cache_entry *p;
> > >
> > > -     if (ovl_cache_entry_find_link(name, len, &newp, &parent))
> > > -             return true;
> > > +     if (ovl_cache_entry_find_link(c_name, c_len, &newp, &parent))
> > > +             return 0;
> > >
> > > -     p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
> > > +     p =3D ovl_cache_entry_new(rdd, name, len, c_name, c_len, ino, d=
_type);
> > >       if (p =3D=3D NULL) {
> > >               rdd->err =3D -ENOMEM;
> > > -             return false;
> > > +             return -ENOMEM;
> > >       }
> > >
> > >       list_add_tail(&p->l_node, rdd->list);
> > >       rb_link_node(&p->node, parent, newp);
> > >       rb_insert_color(&p->node, rdd->root);
> > >
> > > -     return true;
> > > +     return 1;
> > >  }
> > >
> > > -static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
> > > +/* Return 0 for found, 1 for added, <0 for error */
> > > +static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
> > >                          const char *name, int namelen,
> > > +                        const char *c_name, int c_len,
> > >                          loff_t offset, u64 ino, unsigned int d_type)
> > >  {
> > >       struct ovl_cache_entry *p;
> > >
> > > -     p =3D ovl_cache_entry_find(rdd->root, name, namelen);
> > > +     p =3D ovl_cache_entry_find(rdd->root, c_name, c_len);
> > >       if (p) {
> > >               list_move_tail(&p->l_node, &rdd->middle);
> > > +             return 0;
> > >       } else {
> > > -             p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_ty=
pe);
> > > +             p =3D ovl_cache_entry_new(rdd, name, namelen, c_name, c=
_len,
> > > +                                     ino, d_type);
> > >               if (p =3D=3D NULL)
> > >                       rdd->err =3D -ENOMEM;
> > >               else
> > >                       list_add_tail(&p->l_node, &rdd->middle);
> > >       }
> > >
> > > -     return rdd->err =3D=3D 0;
> > > +     return rdd->err ?: 1;
> > >  }
> > >
> > >  void ovl_cache_free(struct list_head *list)
> > > @@ -223,8 +263,11 @@ void ovl_cache_free(struct list_head *list)
> > >       struct ovl_cache_entry *p;
> > >       struct ovl_cache_entry *n;
> > >
> > > -     list_for_each_entry_safe(p, n, list, l_node)
> > > +     list_for_each_entry_safe(p, n, list, l_node) {
> > > +             if (p->c_name !=3D p->name)
> > > +                     kfree(p->c_name);
> > >               kfree(p);
> > > +     }
> > >
> > >       INIT_LIST_HEAD(list);
> > >  }
> > > @@ -260,12 +303,36 @@ static bool ovl_fill_merge(struct dir_context *=
ctx, const char *name,
> > >  {
> > >       struct ovl_readdir_data *rdd =3D
> > >               container_of(ctx, struct ovl_readdir_data, ctx);
> > > +     struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
> > > +     const char *c_name =3D NULL;
> > > +     char *cf_name =3D NULL;
> > > +     int c_len =3D 0, ret;
> > > +
> > > +     if (ofs->casefold)
> > > +             c_len =3D ovl_casefold(rdd->map, name, namelen, &cf_nam=
e);
> > > +
> > > +     if (c_len <=3D 0) {
> > > +             c_name =3D name;
> > > +             c_len =3D namelen;
> > > +     } else {
> > > +             c_name =3D cf_name;
> > > +     }
> > >
> > >       rdd->count++;
> > >       if (!rdd->is_lowest)
> > > -             return ovl_cache_entry_add_rb(rdd, name, namelen, ino, =
d_type);
> > > +             ret =3D ovl_cache_entry_add_rb(rdd, name, namelen, c_na=
me, c_len, ino, d_type);
> > >       else
> > > -             return ovl_fill_lowest(rdd, name, namelen, offset, ino,=
 d_type);
> > > +             ret =3D ovl_fill_lowest(rdd, name, namelen, c_name, c_l=
en, offset, ino, d_type);
> > > +
> > > +     /*
> > > +      * If ret =3D=3D 1, that means that c_name is being used as par=
t of struct
> > > +      * ovl_cache_entry and will be freed at ovl_cache_free(). Other=
wise,
> > > +      * c_name was found in the rb-tree so we can free it here.
> > > +      */
> > > +     if (ret !=3D 1 && c_name !=3D name)
> > > +             kfree(c_name);
> > > +
> >
> > The semantics of this being conditionally freed is a bit annoying, as
> > it is already replicated in 3 places. I suppose a helper would come in
> > hand.
>
> Yeh.
>
> I have already used ovl_cache_entry_free() in my tree.
>
> Thanks,
> Amir.
>
> >
> > In this specific case, it could just be:
> >
> > if (ret !=3D 1)
> >         kfree(cf_name);
> >
> >
> > > +     return ret >=3D 0;
> > >  }
> > >
> > >  static int ovl_check_whiteouts(const struct path *path, struct ovl_r=
eaddir_data *rdd)
> > > @@ -357,12 +424,18 @@ static int ovl_dir_read_merged(struct dentry *d=
entry, struct list_head *list,
> > >               .list =3D list,
> > >               .root =3D root,
> > >               .is_lowest =3D false,
> > > +             .map =3D NULL,
> > >       };
> > >       int idx, next;
> > >       const struct ovl_layer *layer;
> > > +     struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> > >
> > >       for (idx =3D 0; idx !=3D -1; idx =3D next) {
> > >               next =3D ovl_path_next(idx, dentry, &realpath, &layer);
> > > +
> > > +             if (ofs->casefold)
> > > +                     rdd.map =3D sb_encoding(realpath.dentry->d_sb);
> > > +
> > >               rdd.is_upper =3D ovl_dentry_upper(dentry) =3D=3D realpa=
th.dentry;
> > >               rdd.in_xwhiteouts_dir =3D layer->has_xwhiteouts &&
> > >                                       ovl_dentry_has_xwhiteouts(dentr=
y);
> > > @@ -555,7 +628,7 @@ static bool ovl_fill_plain(struct dir_context *ct=
x, const char *name,
> > >               container_of(ctx, struct ovl_readdir_data, ctx);
> > >
> > >       rdd->count++;
> > > -     p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
> > > +     p =3D ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_t=
ype);
> > >       if (p =3D=3D NULL) {
> > >               rdd->err =3D -ENOMEM;
> > >               return false;
> > > @@ -1023,6 +1096,8 @@ int ovl_check_empty_dir(struct dentry *dentry, =
struct list_head *list)
> > >
> > >  del_entry:
> > >               list_del(&p->l_node);
> > > +             if (p->c_name !=3D p->name)
> > > +                     kfree(p->c_name);
> > >               kfree(p);
> > >       }
> >
> > --
> > Gabriel Krisman Bertazi

