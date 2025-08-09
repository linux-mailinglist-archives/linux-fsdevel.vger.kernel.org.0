Return-Path: <linux-fsdevel+bounces-57177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B733BB1F521
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2AB627509
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8A82BE63B;
	Sat,  9 Aug 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEH1YqBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC817BBF;
	Sat,  9 Aug 2025 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752424; cv=none; b=IRjz3eI7UCRKXT9kvnFs2+6sNoBwYOX3s4E8mffVDSQBlnUpXNZ4xWHwbE4s1SLW89MjyCdZTbB0J7MxwhXHW2hisMWvf2oYthpelb0UvlqRG0MX2b+5sH93f0ijjnXEsNsiIaRvXHDYRJVqSBTOLRAlGCC+OwsJ04JzNaicJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752424; c=relaxed/simple;
	bh=qGuxUx7qyE/jQ6kLVFyQlqNmjRcJZjIDvTfYRwD43zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqMPaHDji8z+RwEoUJ0kmbv1+j840ktfwiqo9I5gcXGU4+A50YaKn5P7BSLTETy52xOziAm4J99Xcv42C+Bd17Yj7663TORhEXrGLHeL80GCgIjV0UO+Rs+kCSOqjJ+z61mGDVFx5fJLR6FIpP6AthARWhkR9xkcdKT006Nldas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEH1YqBm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso4974242a12.3;
        Sat, 09 Aug 2025 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754752421; x=1755357221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+EvJjjiv0Mt2GnowPYtEO/+IymnIZwSlyPTIxx5Gf8=;
        b=gEH1YqBmG8i5SAXUPoMcqRqFTxZr+IkpTnKiKoexbXw9TjRXV93VV/AsbumQMVS5rN
         ekEYguHriwDcbXQZ5nEKLqgKCRFkxCIvKu393HtMf1mm8ncfgBe92DjDihr8tlhPJTuR
         yFrEs+WAUdlJvBRw5c+ZlrBal4/QzavUzyI0F/m9a8VW6G7jViGksyHnZSgnYiiSTcgU
         XXqeinnd/SsJhn4xi+CVi0Tbzn44fuLX8W0FouCots8rQKm4TVF9AvL9WSTaCbT6kDNO
         AIq96WKkdbDEsj3lllKlxuLRcfi0UtQ5A/OIYBW4VMzqabOI6cpZ/jPm4cTzN48qv6VV
         Fhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754752421; x=1755357221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+EvJjjiv0Mt2GnowPYtEO/+IymnIZwSlyPTIxx5Gf8=;
        b=Spz8hmZ7Or2P35MhGPN5SiA2lnbgh7PtVqoL2efNIBv+Qz06yV+wfOTWQcrlxWcXt/
         meERQTQxalOem/QJGrc9+6jv30zj2oCZOW/gf+AnaIPfdibh++AGo8/1lRb3oxc4ugoi
         PkbcGAZ249Zg2/YDrXg5UX+lw/+7S2QK7wfQFYEdDCTUO/o8R0G6zNR47SpxIBruqaaI
         YBbAxOwx702bVfQzv9OELX2ns4DPyvaytVj5axm0WkVtVcnbFpdXp1FbRT88ajyGY5m4
         YEs/mRbdwCrBPr9+jeix3riWmBumb5Br5Lo9zvig5rMe7uHn7jzKMyDjKG0LpjGXxgpK
         9B9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvt39p5RwGmGofFGidoL0qKDG/yyrOQG2C295eKi7RVu2CDQNhTUfZ692VQ5N/QsgyOE/VbQidHkJUjZb40g==@vger.kernel.org, AJvYcCW+RmBrdXBNJPJdK4sl+O6tRJRRt12ab0J+08F3moDhgSdH1tOMZKZ+ybCqWgrjgkn3eUtu9v5XA7KUskCN@vger.kernel.org, AJvYcCXkBu3irzi27X/70oZmV5ATR4/yRKh22skTQarMK89v/jZsSIHPBrdMHeaK/v1rN5gxitV0Hr4pFjXugmDv@vger.kernel.org
X-Gm-Message-State: AOJu0YySJd2D4iP3pQKyhLPsjkvRFzzS6dybGa3jRA3kOmlyrmbaES7O
	sa+wbzNiy7z5N+hz2AlieT0WUC2ViXoMxy3dhemGdeT9ErheVtMLjevWsfwpUDvI5kBsYpT1ZYM
	eKlfwjcTLv0KPxroi7JqRKv/nYCjnHbU=
X-Gm-Gg: ASbGncsQs5E4ZQblunBYGDCXa3EatmQ9OMZjpcFTsvhofri6My/oWl03pliRczLb7SL
	WiWAWJS/EO/8zoOSstbcrt37+3fELmuHI6fjznQTmgPnrbDt+vv7QRSnA6909NqpwZuQUehGY3m
	yhTO1Nt4bBBTbRdz4k8imi+TwAEbJcCtElah/UNRgx9Bdnd5IXnDhInYvj09xMGLBfNNUHFbO05
	RZHdd95mOi2GYWF4A==
X-Google-Smtp-Source: AGHT+IHDiBh0w/ODZBCYvcpScvJ5tnj3Sr95KmLiEIY0IYoijWSfNT+XV5LNWkZsR6T0B838r4uYN9UG0hcBkeLyHRQ=
X-Received: by 2002:a17:906:d542:b0:ad8:87a0:62aa with SMTP id
 a640c23a62f3a-af9c64930e0mr640793266b.27.1754752420593; Sat, 09 Aug 2025
 08:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com> <20250808-tonyk-overlayfs-v3-2-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-2-30f9be426ba8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 17:13:29 +0200
X-Gm-Features: Ac12FXyfYL2DVZXAxHXruxSnEFO8jOztf8qwxn9OzuyPGmDQXQ7x7bw7B1NNrKw
Message-ID: <CAOQ4uxhgz=ZZvfxXcECE-daWmwqOCEMWH5Nh_weOeDciP8xh9w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/7] ovl: Create ovl_casefold() to support
 casefolded strncmp()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> To add overlayfs support casefold filesystems, create a new function
> ovl_casefold(), to be able to do case-insensitive strncmp().
>
> ovl_casefold() allocates a new buffer and stores the casefolded version
> of the string on it. If the allocation or the casefold operation fails,
> fallback to use the original string. The caller of the function is
> responsible of freeing the buffer.
>
> The other string to be compared is casefolded in a previous step and
> stored at `struct ovl_cache_entry` member `char *cf_name`.
>
> Finally, set the strncmp() parameters to the casefold versions of the
> names to achieve case-insensitive support.
>
> For the non-casefold names, nothing changes and the rb_tree
> search/insert functions just ignores this change.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v2:
> - Refactor the patch to do a single kmalloc() per rb_tree operation
> - Instead of casefolding the cache entry name everytime per strncmp(),
>   casefold it once and reuse it for every strncmp().
> ---
>  fs/overlayfs/readdir.c | 92 +++++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 80 insertions(+), 12 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 2f42fec97f76c2000f76e15c60975db567b2c6d6..422f991393dfae12bcacf3264=
14b7ee19e486ac8 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -71,20 +71,58 @@ static struct ovl_cache_entry *ovl_cache_entry_from_n=
ode(struct rb_node *n)
>         return rb_entry(n, struct ovl_cache_entry, node);
>  }
>
> +static int ovl_casefold(struct unicode_map *map, const char *str, int le=
n, char **dst)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +       const struct qstr qstr =3D { .name =3D str, .len =3D len };
> +       int cf_len;
> +
> +       if (!map || is_dot_dotdot(str, len))

if (!IS_ENABLED(CONFIG_UNICODE) || !map ||...

> +               return -1;

Better return 0 for no casefolding.

> +
> +       *dst =3D kmalloc(OVL_NAME_LEN, GFP_KERNEL);
> +
> +       if (dst) {
> +               cf_len =3D utf8_casefold(map, &qstr, *dst, OVL_NAME_LEN);
> +
> +               if (cf_len > 0)
> +                       return cf_len;

need to kfree(*dst) in the error case
caller only responsible of free on success

> +       }
> +#endif
> +
> +       return -1;

Better return 0 for no casefolding.

> +}
> +
>  static bool ovl_cache_entry_find_link(const char *name, int len,
>                                       struct rb_node ***link,
> -                                     struct rb_node **parent)
> +                                     struct rb_node **parent,
> +                                     struct unicode_map *map)
>  {
> +       int ret;
> +       char *dst =3D NULL;
>         bool found =3D false;
> +       const char *str =3D name;
>         struct rb_node **newp =3D *link;
>
> +       ret =3D ovl_casefold(map, name, len, &dst);
> +
> +       if (ret > 0) {
> +               str =3D dst;
> +               len =3D ret;
> +       }
> +
>         while (!found && *newp) {
>                 int cmp;
> +               char *aux;
>                 struct ovl_cache_entry *tmp;
>
>                 *parent =3D *newp;
> +
>                 tmp =3D ovl_cache_entry_from_node(*newp);
> -               cmp =3D strncmp(name, tmp->name, len);
> +
> +               aux =3D tmp->cf_name ? tmp->cf_name : tmp->name;
> +
> +               cmp =3D strncmp(str, aux, len);
>                 if (cmp > 0)
>                         newp =3D &tmp->node.rb_right;
>                 else if (cmp < 0 || len < tmp->len)
> @@ -94,27 +132,50 @@ static bool ovl_cache_entry_find_link(const char *na=
me, int len,
>         }
>         *link =3D newp;
>
> +       kfree(dst);
> +
>         return found;
>  }
>
>  static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root=
,
> -                                                   const char *name, int=
 len)
> +                                                   const char *name, int=
 len,
> +                                                   struct unicode_map *m=
ap)
>  {
>         struct rb_node *node =3D root->rb_node;
> -       int cmp;
> +       struct ovl_cache_entry *p;
> +       const char *str =3D name;
> +       bool found =3D false;
> +       char *dst =3D NULL;
> +       int cmp, ret;
> +
> +       ret =3D ovl_casefold(map, name, len, &dst);
> +
> +       if (ret > 0) {
> +               str =3D dst;
> +               len =3D ret;
> +       }
> +
> +       while (!found && node) {
> +               char *aux;
>
> -       while (node) {
> -               struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(n=
ode);
> +               p =3D ovl_cache_entry_from_node(node);
>
> -               cmp =3D strncmp(name, p->name, len);
> +               aux =3D p->cf_name ? p->cf_name : p->name;
> +
> +               cmp =3D strncmp(str, aux, len);
>                 if (cmp > 0)
>                         node =3D p->node.rb_right;
>                 else if (cmp < 0 || len < p->len)
>                         node =3D p->node.rb_left;
>                 else
> -                       return p;
> +                       found =3D true;
>         }
>
> +       kfree(dst);
> +
> +       if (found)
> +               return p;
> +
>         return NULL;
>  }
>
> @@ -212,7 +273,7 @@ static bool ovl_cache_entry_add_rb(struct ovl_readdir=
_data *rdd,
>         struct rb_node *parent =3D NULL;
>         struct ovl_cache_entry *p;
>
> -       if (ovl_cache_entry_find_link(name, len, &newp, &parent))
> +       if (ovl_cache_entry_find_link(name, len, &newp, &parent, rdd->map=
))
>                 return true;
>
>         p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
> @@ -234,7 +295,7 @@ static bool ovl_fill_lowest(struct ovl_readdir_data *=
rdd,
>  {
>         struct ovl_cache_entry *p;
>
> -       p =3D ovl_cache_entry_find(rdd->root, name, namelen);
> +       p =3D ovl_cache_entry_find(rdd->root, name, namelen, rdd->map);
>         if (p) {
>                 list_move_tail(&p->l_node, &rdd->middle);
>         } else {

IMO, it is nicer to pass the cf_name to the low level rb tree lookup
helpers and call ovl_casefold() only in high level ovl_fill_merge().
This also deduplicates the code from patch 1 of storing the cf_name in
 ovl_cache_entry_new().
something like this (untested) WDYT?

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b65cdfce31ce..71efb29ad30f 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -79,10 +79,10 @@ static bool ovl_cache_entry_find_link(const char
*name, int len,

                *parent =3D *newp;
                tmp =3D ovl_cache_entry_from_node(*newp);
-               cmp =3D strncmp(name, tmp->name, len);
+               cmp =3D strncmp(name, tmp->cf_name, len);
                if (cmp > 0)
                        newp =3D &tmp->node.rb_right;
-               else if (cmp < 0 || len < tmp->len)
+               else if (cmp < 0 || len < tmp->cf_len)
                        newp =3D &tmp->node.rb_left;
                else
                        found =3D true;
@@ -101,10 +101,10 @@ static struct ovl_cache_entry
*ovl_cache_entry_find(struct rb_root *root,
        while (node) {
                struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(nod=
e);

-               cmp =3D strncmp(name, p->name, len);
+               cmp =3D strncmp(name, p->cf_name, len);
                if (cmp > 0)
                        node =3D p->node.rb_right;
-               else if (cmp < 0 || len < p->len)
+               else if (cmp < 0 || len < p->cf_len)
                        node =3D p->node.rb_left;
                else
                        return p;
@@ -145,6 +145,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data *rdd=
,

 static struct ovl_cache_entry *ovl_cache_entry_new(struct
ovl_readdir_data *rdd,
                                                   const char *name, int le=
n,
+                                                  const char
*cf_name, int cf_len,
                                                   u64 ino, unsigned int d_=
type)
 {
        struct ovl_cache_entry *p;
@@ -156,6 +157,13 @@ static struct ovl_cache_entry
*ovl_cache_entry_new(struct ovl_readdir_data *rdd,
        memcpy(p->name, name, len);
        p->name[len] =3D '\0';
        p->len =3D len;
+       if (cf_name && cf_name !=3D name) {
+               p->cf_name =3D=3D cf_name
+               p->cf_len =3D cf_len;
+       } else {
+               p->cf_name =3D p->name;
+               p->cf_len =3D len;
+       }
        p->type =3D d_type;
        p->real_ino =3D ino;
        p->ino =3D ino;
@@ -175,17 +183,18 @@ static struct ovl_cache_entry
*ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 }

 static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
-                                 const char *name, int len, u64 ino,
-                                 unsigned int d_type)
+                                 const char *name, int len,
+                                 const char *cf_name, int cf_len,
+                                 u64 ino, unsigned int d_type)
 {
        struct rb_node **newp =3D &rdd->root->rb_node;
        struct rb_node *parent =3D NULL;
        struct ovl_cache_entry *p;

-       if (ovl_cache_entry_find_link(name, len, &newp, &parent))
+       if (ovl_cache_entry_find_link(cf_name, cf_len, &newp, &parent))
                return true;

-       p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
+       p =3D ovl_cache_entry_new(rdd, name, len, cf_name, cf_len, ino, d_t=
ype);
        if (p =3D=3D NULL) {
                rdd->err =3D -ENOMEM;
                return false;
@@ -200,15 +209,17 @@ static bool ovl_cache_entry_add_rb(struct
ovl_readdir_data *rdd,

 static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
                           const char *name, int namelen,
+                          const char *cf_name, int cf_len,
                           loff_t offset, u64 ino, unsigned int d_type)
 {
        struct ovl_cache_entry *p;

-       p =3D ovl_cache_entry_find(rdd->root, name, namelen);
+       p =3D ovl_cache_entry_find(rdd->root, cf_name, cf_len);
        if (p) {
                list_move_tail(&p->l_node, &rdd->middle);
        } else {
-               p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
+               p =3D ovl_cache_entry_new(rdd, name, namelen, cf_name, cf_l=
en,
+                                       ino, d_type);
                if (p =3D=3D NULL)
                        rdd->err =3D -ENOMEM;
                else
@@ -223,8 +234,11 @@ void ovl_cache_free(struct list_head *list)
        struct ovl_cache_entry *p;
        struct ovl_cache_entry *n;

-       list_for_each_entry_safe(p, n, list, l_node)
+       list_for_each_entry_safe(p, n, list, l_node) {
+               if (p->cf_name !=3D p->name)
+                       kfree(p->cf_name);
                kfree(p);
+       }

        INIT_LIST_HEAD(list);
 }
@@ -260,12 +274,26 @@ static bool ovl_fill_merge(struct dir_context
*ctx, const char *name,
 {
        struct ovl_readdir_data *rdd =3D
                container_of(ctx, struct ovl_readdir_data, ctx);
+       char *cf_name;
+       int cf_len =3D 0;
+
+       if (ofs->casefold)
+               cf_len =3D ovl_casefold(rdd->map, name, namelen, &cf_name);
+
+       /* lookup in rb tree by casefolded name or orig name */
+       if (cf_len <=3D 0) {
+               cf_name =3D name;
+               cf_len =3D namelen;
+       }

        rdd->count++;
-       if (!rdd->is_lowest)
-               return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_ty=
pe);
-       else
-               return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_t=
ype);
+       if (!rdd->is_lowest) {
+               return ovl_cache_entry_add_rb(rdd, name, namelen,
cf_name, cf_len,
+                                             ino, d_type);
+       } else {
+               return ovl_fill_lowest(rdd, name, namelen, cf_name, cf_len,
+                                      offset, ino, d_type);
+       }
 }

 static int ovl_check_whiteouts(const struct path *path, struct
ovl_readdir_data *rdd)
@@ -555,7 +583,7 @@ static bool ovl_fill_plain(struct dir_context
*ctx, const char *name,
                container_of(ctx, struct ovl_readdir_data, ctx);

        rdd->count++;
-       p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
+       p =3D ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_type)=
;
        if (p =3D=3D NULL) {
                rdd->err =3D -ENOMEM;
                return false;

> @@ -640,7 +701,8 @@ static int ovl_dir_read_impure(const struct path *pat=
h,  struct list_head *list,

All the changes below this point related to code paths of
ovl_iterate_real(), ovl_dir_read_impure() and struct ovl_readdir_translate
are irrelevant to casefolding and not needed.

This code iterates a single layer "real directory" and "translates" real in=
o to
ovl ino in some cases, but it does not compare any names between layers.

Thanks,
Amir.

