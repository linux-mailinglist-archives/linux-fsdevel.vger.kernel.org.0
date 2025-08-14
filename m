Return-Path: <linux-fsdevel+bounces-57881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84FB265ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A420A02263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81742FB977;
	Thu, 14 Aug 2025 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeCRM/cO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B8381AF;
	Thu, 14 Aug 2025 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176010; cv=none; b=YfFjSk7PYrZjFlgoWanm1UDHGvedxXetjE9PvgEPNHTrkMaGo99aKWuB2glEUldXyUcoCRc5XZ7ONdReHpus6lHb0759bwQhz/wydv3j5GW3Qor/0Ggtr62mdqslbF7KD7+xLFhl8Lc6LzZ6bQB3MjYUksq0zu6x8OImf4WqknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176010; c=relaxed/simple;
	bh=ix0LxShbEXZN1y9JWMUurN7ArRgjjBJypa/6qHO1fgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umdV/17h6XhgWaO3O5zsvnw8aUPHq6kYUA57H2JVy4HLm5mJu4WYLspzMPZHHgRUcUGj1ImmEBtAzTIJhKaPkX4DLCN7kQFYJhSsqMa9vsZPJdFDs/qK+55kfBDvbkzHz4VvsFoy7ZnnJATAQ8SwuIm+6l47+lUW5SUhmCAsP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeCRM/cO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b73bef3so1523936a12.3;
        Thu, 14 Aug 2025 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755176006; x=1755780806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7khHxa8EZ44tyI6GjkkfYO6aRfdNkYihbYAhB2fjATA=;
        b=FeCRM/cO2oyjDzbiqB/c3Z1v8MZLQzPZcQOAaSc9JqZjDrR1Dyy91myumY6u8ZFG7c
         Gam8aDmOAZ8S08Gi9KbCRHXOGvzRtJTkm1nNmvOXCwg98JZiMHLoDDjnlgE5Q5OJCSoJ
         Zg5+8iWz/qsJHBm8ZnjIfdZHyQUy4Gyye9QOoUpy9Ir0HHshZ7zMNbk1RZK8846zDmF/
         kGQssEhRYUtxtR6JMktdrUpmwtb2NLXW3GbymEK4OuPyRDeb9riAO0mEhqbqyu7Fy85r
         +6NO2/Rp8HKi7K6Z3AjCFGrj7qlo+iaMSL9+PJsQP1nYy5M59hnsmyZpC2VGXJZLxuJj
         JK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755176006; x=1755780806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7khHxa8EZ44tyI6GjkkfYO6aRfdNkYihbYAhB2fjATA=;
        b=FK/Ywphfv2dYgICLTY+sONz+o8coEGYsf4omxvwPcu8l4zhVyZQ0gahxoZTbFiNqYq
         3fvD21Ssc3HfnYqWqekvtdIr30zzI1PYTjA2o0/MtjNbTCp5ElBAaS30qafl/EK56GzD
         dVv/mvxVazJZkP0aqIFaapiGxpQB0L/ahkQnV0KEP5f1W3k2Tj5yc2BGym+YVI8n+e74
         SYi7485hCkbdvGFQgV563wzVzFFIK0nsQenTMwmFpXn68umLzI530tFAPXxWzQvtokEV
         U7zCc1Y+j836/iLSsmY4Q8k67VZ77GIrO9Kl/SCPh8JkoP9b3nCh7bxyGY+mHqykEh+B
         bVHA==
X-Forwarded-Encrypted: i=1; AJvYcCVVEceKTV8PpW9zdRLS5067g8oUao7aXhj64edEHWsWoCUCfqO1oPiI8Qd9D1+e5jm05J81ZYG6dg1K6uuYWQ==@vger.kernel.org, AJvYcCWmomdLJm93D1YO13JkczKQqN2hb7egl6/1ed8sU9cSTZ/V4qe++noqPilIQv9CueYHFPrq6N5/J6bKXKap@vger.kernel.org, AJvYcCX1tYCRQYOUEhOPN6z9eBzUoSD86eOXqb5CMnhmiOkgWfH3jxlWzearybGn4Q7Jx9XD/vC/7LivQxLcfDqU@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9TCQWnG7YEgrV7jjvXjZAxYwX7zABMan+vf/hH9XG51FdHDN
	IXPzKol4QL58GqIdvufNwRLvB45xaNWgl3yUl27IyWkhye/kC6Npmj4ldD33MfuOwHvfEbuMs+m
	Kq75/SHxIKg+1Dh8pgggvQ5Ja45kquiE=
X-Gm-Gg: ASbGncuuJG27w08yt+Uzji/aPYDTiOzDav/turWJt4TanDq6482IDsmZ430K5JcAl2p
	phG5K2APHpwC0HLacGjrcO3E6if9faVT4Q7SfGg6nD/1JM6UEqpmPkwrBWEjAsPLiFarByRvSPV
	7E3HyaERgu4T2wCoDy/1N1SHGzVx/O03ulKZEl18iCUfuJicH8TFnMlla1H0+08RzCFcEUUTfTs
	2QAERo=
X-Google-Smtp-Source: AGHT+IGkTmfSj0dduGA4pAZpNiG0GE8hMOjW7MXBHqXwYpQM+cStJ6mN5DFSoAChVYyP3qNkS5MCr6DlWq+71F/qHvM=
X-Received: by 2002:a05:6402:4603:b0:615:4106:9c10 with SMTP id
 4fb4d7f45d1cf-6188ba1b630mr2839665a12.17.1755176006135; Thu, 14 Aug 2025
 05:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-3-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-3-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 14:53:14 +0200
X-Gm-Features: Ac12FXwns1Mrb22M7jL885KHT0QD-d7abojmHutgof9Jy_l5Lp6VUmNspWBpdoA
Message-ID: <CAOQ4uxgDw5SVaoSJNzt2ma4P+XkVcvaJZoKmd1AmrTuqDxHc6A@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] ovl: Create ovl_casefold() to support casefolded strncmp()
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
> To add overlayfs support casefold filesystems, create a new function
> ovl_casefold(), to be able to do case-insensitive strncmp().
>
> ovl_casefold() allocates a new buffer and stores the casefolded version
> of the string on it. If the allocation or the casefold operation fails,
> fallback to use the original string.
>
> The case-insentive name is then used in the rb-tree search/insertion
> operation. If the name is found in the rb-tree, the name can be
> discarded and the buffer is freed. If the name isn't found, it's then
> stored at struct ovl_cache_entry to be used later.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v3:
>  - Improve commit message text
>  - s/OVL_NAME_LEN/NAME_MAX
>  - drop #ifdef in favor of if(IS_ENABLED)
>  - use new helper sb_encoding
>  - merged patch "Store casefold name..." and "Create ovl_casefold()..."
>  - Guard all the casefolding inside of IS_ENABLED(UNICODE)
>
> Changes from v2:
> - Refactor the patch to do a single kmalloc() per rb_tree operation
> - Instead of casefolding the cache entry name everytime per strncmp(),
>   casefold it once and reuse it for every strncmp().
> ---
>  fs/overlayfs/readdir.c | 99 ++++++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 87 insertions(+), 12 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index b65cdfce31ce27172d28d879559f1008b9c87320..3d92c0b407fe355053ca80ef9=
99d3520eb7d2462 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -27,6 +27,8 @@ struct ovl_cache_entry {
>         bool is_upper;
>         bool is_whiteout;
>         bool check_xwhiteout;
> +       const char *cf_name;
> +       int cf_len;
>         char name[];
>  };
>
> @@ -45,6 +47,7 @@ struct ovl_readdir_data {
>         struct list_head *list;
>         struct list_head middle;
>         struct ovl_cache_entry *first_maybe_whiteout;
> +       struct unicode_map *map;
>         int count;
>         int err;
>         bool is_upper;
> @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_from_no=
de(struct rb_node *n)
>         return rb_entry(n, struct ovl_cache_entry, node);
>  }
>
> +static int ovl_casefold(struct unicode_map *map, const char *str, int le=
n, char **dst)
> +{
> +       const struct qstr qstr =3D { .name =3D str, .len =3D len };
> +       int cf_len;
> +
> +       if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, len=
))
> +               return 0;
> +
> +       *dst =3D kmalloc(NAME_MAX, GFP_KERNEL);
> +
> +       if (dst) {
> +               cf_len =3D utf8_casefold(map, &qstr, *dst, NAME_MAX);
> +
> +               if (cf_len > 0)
> +                       return cf_len;
> +       }
> +
> +       kfree(*dst);
> +       return 0;
> +}
> +
>  static bool ovl_cache_entry_find_link(const char *name, int len,
>                                       struct rb_node ***link,
>                                       struct rb_node **parent)
> @@ -79,7 +103,7 @@ static bool ovl_cache_entry_find_link(const char *name=
, int len,
>
>                 *parent =3D *newp;
>                 tmp =3D ovl_cache_entry_from_node(*newp);
> -               cmp =3D strncmp(name, tmp->name, len);
> +               cmp =3D strncmp(name, tmp->cf_name, tmp->cf_len);
>                 if (cmp > 0)
>                         newp =3D &tmp->node.rb_right;
>                 else if (cmp < 0 || len < tmp->len)
> @@ -101,7 +125,7 @@ static struct ovl_cache_entry *ovl_cache_entry_find(s=
truct rb_root *root,
>         while (node) {
>                 struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(n=
ode);
>
> -               cmp =3D strncmp(name, p->name, len);
> +               cmp =3D strncmp(name, p->cf_name, p->cf_len);
>                 if (cmp > 0)
>                         node =3D p->node.rb_right;
>                 else if (cmp < 0 || len < p->len)
> @@ -145,13 +169,16 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data =
*rdd,
>
>  static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_da=
ta *rdd,
>                                                    const char *name, int =
len,
> +                                                  const char *cf_name, i=
nt cf_len,
>                                                    u64 ino, unsigned int =
d_type)
>  {
>         struct ovl_cache_entry *p;
>
>         p =3D kmalloc(struct_size(p, name, len + 1), GFP_KERNEL);
> -       if (!p)
> +       if (!p) {
> +               kfree(cf_name);
>                 return NULL;
> +       }
>
>         memcpy(p->name, name, len);
>         p->name[len] =3D '\0';
> @@ -167,6 +194,14 @@ static struct ovl_cache_entry *ovl_cache_entry_new(s=
truct ovl_readdir_data *rdd,
>         /* Defer check for overlay.whiteout to ovl_iterate() */
>         p->check_xwhiteout =3D rdd->in_xwhiteouts_dir && d_type =3D=3D DT=
_REG;
>
> +       if (cf_name && cf_name !=3D name) {
> +               p->cf_name =3D cf_name;
> +               p->cf_len =3D cf_len;
> +       } else {
> +               p->cf_name =3D p->name;
> +               p->cf_len =3D len;
> +       }
> +
>         if (d_type =3D=3D DT_CHR) {
>                 p->next_maybe_whiteout =3D rdd->first_maybe_whiteout;
>                 rdd->first_maybe_whiteout =3D p;
> @@ -175,17 +210,24 @@ static struct ovl_cache_entry *ovl_cache_entry_new(=
struct ovl_readdir_data *rdd,
>  }
>
>  static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> -                                 const char *name, int len, u64 ino,
> +                                 const char *name, int len,
> +                                 const char *cf_name, int cf_len,
> +                                 u64 ino,
>                                   unsigned int d_type)
>  {
>         struct rb_node **newp =3D &rdd->root->rb_node;
>         struct rb_node *parent =3D NULL;
>         struct ovl_cache_entry *p;
>
> -       if (ovl_cache_entry_find_link(name, len, &newp, &parent))
> +       if (ovl_cache_entry_find_link(cf_name, cf_len, &newp, &parent)) {
> +               if (cf_name !=3D name) {
> +                       kfree(cf_name);
> +                       cf_name =3D NULL;
> +               }

No use of setting cf_name to NULL here.
Please include comment to explain this free (as you did in commit message)

>                 return true;
> +       }
>
> -       p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
> +       p =3D ovl_cache_entry_new(rdd, name, len, cf_name, cf_len, ino, d=
_type);
>         if (p =3D=3D NULL) {
>                 rdd->err =3D -ENOMEM;
>                 return false;
> @@ -200,15 +242,21 @@ static bool ovl_cache_entry_add_rb(struct ovl_readd=
ir_data *rdd,
>
>  static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
>                            const char *name, int namelen,
> +                          const char *cf_name, int cf_len,
>                            loff_t offset, u64 ino, unsigned int d_type)
>  {
>         struct ovl_cache_entry *p;
>
> -       p =3D ovl_cache_entry_find(rdd->root, name, namelen);
> +       p =3D ovl_cache_entry_find(rdd->root, cf_name, cf_len);
>         if (p) {
>                 list_move_tail(&p->l_node, &rdd->middle);
> +               if (cf_name !=3D name) {
> +                       kfree(cf_name);
> +                       cf_name =3D NULL;

No use of setting cf_name to NULL here.
Please include comment to explain this free (as you did in commit message)

> +               }
>         } else {
> -               p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type=
);
> +               p =3D ovl_cache_entry_new(rdd, name, namelen, cf_name, cf=
_len,
> +                                       ino, d_type);
>                 if (p =3D=3D NULL)
>                         rdd->err =3D -ENOMEM;
>                 else
> @@ -223,8 +271,11 @@ void ovl_cache_free(struct list_head *list)
>         struct ovl_cache_entry *p;
>         struct ovl_cache_entry *n;
>
> -       list_for_each_entry_safe(p, n, list, l_node)
> +       list_for_each_entry_safe(p, n, list, l_node) {
> +               if (p->cf_name !=3D p->name)
> +                       kfree(p->cf_name);
>                 kfree(p);
> +       }
>
>         INIT_LIST_HEAD(list);
>  }
> @@ -260,12 +311,28 @@ static bool ovl_fill_merge(struct dir_context *ctx,=
 const char *name,
>  {
>         struct ovl_readdir_data *rdd =3D
>                 container_of(ctx, struct ovl_readdir_data, ctx);
> +       struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
> +       const char *aux =3D NULL;

It looks strange to me that you need aux
and it looks strange to pair <aux, cf_len>
neither here or there...

> +       char *cf_name =3D NULL;
> +       int cf_len =3D 0;
> +
> +       if (ofs->casefold)
> +               cf_len =3D ovl_casefold(rdd->map, name, namelen, &cf_name=
);
> +
> +       if (cf_len <=3D 0) {
> +               aux =3D name;

why not:
cf_name =3D name;

> +               cf_len =3D namelen;
> +       } else {
> +               aux =3D cf_name;
> +       }

and no aux and no else needed at all?

If you don't like a var named cf_name to point at a non-casefolded
name buffer, then use other var names which are consistent such as
<c_name, c_len> (c for "canonical" or "compare" name).

>
>         rdd->count++;
>         if (!rdd->is_lowest)
> -               return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_=
type);
> +               return ovl_cache_entry_add_rb(rdd, name, namelen, aux, cf=
_len,
> +                                             ino, d_type);
>         else
> -               return ovl_fill_lowest(rdd, name, namelen, offset, ino, d=
_type);
> +               return ovl_fill_lowest(rdd, name, namelen, aux, cf_len,
> +                                      offset, ino, d_type);
>  }
>

What do you think about moving all the consume/free buffer logic out to cal=
ler:

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b65cdfce31ce..e77530c63207 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -174,7 +174,8 @@ static struct ovl_cache_entry
*ovl_cache_entry_new(struct ovl_readdir_data *rdd,
        return p;
 }

-static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
+/* Return 0 for found, >0 for added, <0 for error */
+static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
                                  const char *name, int len, u64 ino,
                                  unsigned int d_type)
 {
@@ -183,22 +184,23 @@ static bool ovl_cache_entry_add_rb(struct
ovl_readdir_data *rdd,
        struct ovl_cache_entry *p;

        if (ovl_cache_entry_find_link(name, len, &newp, &parent))
-               return true;
+               return 0;

        p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
        if (p =3D=3D NULL) {
                rdd->err =3D -ENOMEM;
-               return false;
+               return -ENOMEM;
        }

        list_add_tail(&p->l_node, rdd->list);
        rb_link_node(&p->node, parent, newp);
        rb_insert_color(&p->node, rdd->root);

-       return true;
+       return 1;
 }

-static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
+/* Return 0 for found, >0 for added, <0 for error */
+static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
                           const char *name, int namelen,
                           loff_t offset, u64 ino, unsigned int d_type)
 {
@@ -207,6 +209,7 @@ static bool ovl_fill_lowest(struct ovl_readdir_data *rd=
d,
        p =3D ovl_cache_entry_find(rdd->root, name, namelen);
        if (p) {
                list_move_tail(&p->l_node, &rdd->middle);
+               return 0;
        } else {
                p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
                if (p =3D=3D NULL)
@@ -215,7 +218,7 @@ static bool ovl_fill_lowest(struct ovl_readdir_data *rd=
d,
                        list_add_tail(&p->l_node, &rdd->middle);
        }

-       return rdd->err =3D=3D 0;
+       return rdd->err ?: 1;
 }

@@ -260,12 +263,31 @@ static bool ovl_fill_merge(struct dir_context
*ctx, const char *name,
 {
        struct ovl_readdir_data *rdd =3D
                container_of(ctx, struct ovl_readdir_data, ctx);
+       struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
+       char *c_name =3D NULL;
+       int c_len =3D 0;
+       int ret;
+
+       if (ofs->casefold)
+               c_len =3D ovl_casefold(rdd->map, name, namelen, &c_name);
+
+       if (c_len <=3D 0) {
+               c_name =3D name;
+               c_len =3D namelen;
+       }

        rdd->count++;
-       if (!rdd->is_lowest)
-               return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_ty=
pe);
-       else
-               return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_t=
ype);
+       if (!rdd->is_lowest) {
+               ret =3D ovl_cache_entry_add_rb(rdd, name, namelen, c_name, =
c_len,
+                                            ino, d_type);
+       } else {
+               ret =3D ovl_fill_lowest(rdd, name, namelen, c_name, c_len, =
offset,
+                                     ino, d_type);
+       }
+       // ret > 1 means c_name is consumed
+       if (ret <=3D 0 && c_len > 0)
+               kfree(c_name);
+       return ret >=3D 0;
 }

Thanks,
Amir.

