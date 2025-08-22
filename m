Return-Path: <linux-fsdevel+bounces-58845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A17B320E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B51AE4E7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EAE30E836;
	Fri, 22 Aug 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYr25e8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DBC23D7D4;
	Fri, 22 Aug 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881616; cv=none; b=eZkOJOQ91sfrg1GGwgBG1027rgISdkXxe99CfK/2bNLOU2lTwK56r2bjDPtODyXo0qXP35XXGm59r58W8+xeL7SpTWvUSGz+SIZADKVnjPMYsez7LrL5HoL4oEcoGGYo9XI+fL1eA5TobptPNPPiry9bEZcohx3KLl7Kq+yvN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881616; c=relaxed/simple;
	bh=v0KLKGk6Owdd8Zj574QjQel3qf53+K5W14mGX5GjALE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6KyK1nIOB+P6vaMXxJ8NMbxmkAigDlioXwqsRUtaEK7CC0WpO895TaUwi81EmsBBAPKcTbP3S2ClnEtUzECVny1WyJZl+g8zSsrEBUnDlTTPRvdQTdNs6p6CJ24qmWJBO8gEprrHPvNHilKOYg3k2yWlI33vQMOxPQSk5OQ3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYr25e8t; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so3212636a12.0;
        Fri, 22 Aug 2025 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755881613; x=1756486413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slgHuffTEn7c1vy4b+fQXSvlwJ7sYn0p5p9oEVi/KlE=;
        b=LYr25e8t/DEQQVNUAL00bux0/nIfTR0/UR4juu5zhxzSQrXI3KtJX/F50VEckPEw1y
         WRyKC3I4rMOfRN4q5IhlwoCjtx5+x7adyKx5OJncHxxFOJn7PeqluSmB5uVj4KA5NFCp
         7oGOGQ8pbV+IKNnoMLvtKHyCRoyDntxnFXv64s62XMkfOG/9dAa4PyPJkM/Yx6Ebjct1
         zmLFFQtH4uOVqrwV7GEFQhP06tnenHTGAx7/L0/71GByAGxRcxPKLa1K4FU+NKmBm0C1
         Ro0C/Bju5/CZ5Il8tmgW1dQs2ustm9UXq83gFwUU1wjw+MFn7gDZeVHcEorpTFljxSfE
         riJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755881613; x=1756486413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slgHuffTEn7c1vy4b+fQXSvlwJ7sYn0p5p9oEVi/KlE=;
        b=ustzsE8fA/hWaR2RPhffF52AA5Ie3xl7WxvRBNWhHNUJGsjlPziVzF7VfE//qvTgAK
         fWk/S8oRLwnpKrJZtS8c+TPTmvvGSc+0OIjXqdCyH3EsUp0ms9znWQvi/xozHtf2aXGy
         QrVw1TjxRIZ3thZrKzS/HtLEf+HrJEb6U8JZakPxwypu2xuYA+IU3mz5T3XuFj2bj7tu
         AsEYhR/hHXd9rixAGYOIckr8/QrXk3Q+T5N3KBTpZdoAx2E4KuXrH7BlD0OkuI2Wx7ql
         hbi+7yeq4Pmi3x2Pxqs3zppjthxJx5kPjvubt+HG+nz53xA2KnN5563YmsEpHtOwqfHA
         xjMw==
X-Forwarded-Encrypted: i=1; AJvYcCVAHOIx3+OmLMWlDZsFOWUrpWvQ+sS709RvokOEB8x250TEBi3OXrT0IX6Jo9y5EyGIK3m4sPDpx3vr5G1m@vger.kernel.org, AJvYcCVkVxg6rH39mrqNs9i7h/fPuXoMvFMRHYwPvAR0iL9224/6DV++QZnYalFS9eRKlpl3sJAWFlaZ7RSOmQLQ@vger.kernel.org, AJvYcCWrEw43yuYq+Rat72bmDr3LQMvfjeUTMlRektassGEDHJ7TfvaZSzIw65afLxmktBz6LV8jEJvr4gijZcJEog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zTCYWPo7IXD1YxEzDNMrxsUou4kDLUoKMaTtoijo/OHneTVp
	ZFCHqZ5iAlbpZwunUSYi8ah6zMW50XeLm2l+uht1/RTt/aM+jZtgQIf4qH0e7u7Zux2FWqjOiHm
	84eYjEjOAbvgsiS/4ZMXIfBkejGGuXr0=
X-Gm-Gg: ASbGncvWSaGDLYTBVkQUh/smqam8CWeKmzvJIlp6gNzNKLOvK0ycGZ6oqwazMvf2LEF
	5PtiZyMA3SekT6vL/D+VtXbY1gPbGW6NoWlH0YSR575sj8TxBRC5U+l2D6VasB97f+CJ0wGZ+/V
	q8CPZpLR2kbsNjcpwfhtAfBS/WuWb7sdQl2e5Cn93ZNkTYOjevtGQE6/9qKv6DQzmYddPrEceCP
	XyiZRU=
X-Google-Smtp-Source: AGHT+IGNyPZYASwO0sJmnQ76GoCBnN67oQPWQ8NwlDT36KIeh5FKychF9EVlou+eUSe6VobY/qd6SfpUclxbp9jxybg=
X-Received: by 2002:a05:6402:210c:b0:615:5563:548e with SMTP id
 4fb4d7f45d1cf-61c1b45bd8dmr2990524a12.7.1755881612890; Fri, 22 Aug 2025
 09:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com> <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
In-Reply-To: <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Aug 2025 18:53:21 +0200
X-Gm-Features: Ac12FXw_k3EzAsjyfkTL5NnteB1vrgP3nwburCZTGBRF4TdolD0utomj-QglgVs
Message-ID: <CAOQ4uxjG9+Vwpn6n=j2-PrK8u5DMA_oVmnZvbSpstWAMVBOsPg@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:17=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> To add overlayfs support casefold layers, create a new function
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
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v6:
>  - Last version was using `strncmp(... tmp->len)` which was causing
>    regressions. It should be `strncmp(... len)`.
>  - Rename cf_len to c_len
>  - Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
>  - Remove needless kfree(cf_name)
> ---
>  fs/overlayfs/readdir.c | 113 ++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 94 insertions(+), 19 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index b65cdfce31ce27172d28d879559f1008b9c87320..dfc661b7bc3f87efbf14991e9=
7cee169400d823b 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -27,6 +27,8 @@ struct ovl_cache_entry {
>         bool is_upper;
>         bool is_whiteout;
>         bool check_xwhiteout;
> +       const char *c_name;
> +       int c_len;
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
> @@ -79,10 +103,10 @@ static bool ovl_cache_entry_find_link(const char *na=
me, int len,
>
>                 *parent =3D *newp;
>                 tmp =3D ovl_cache_entry_from_node(*newp);
> -               cmp =3D strncmp(name, tmp->name, len);
> +               cmp =3D strncmp(name, tmp->c_name, len);
>                 if (cmp > 0)
>                         newp =3D &tmp->node.rb_right;
> -               else if (cmp < 0 || len < tmp->len)
> +               else if (cmp < 0 || len < tmp->c_len)
>                         newp =3D &tmp->node.rb_left;
>                 else
>                         found =3D true;
> @@ -101,10 +125,10 @@ static struct ovl_cache_entry *ovl_cache_entry_find=
(struct rb_root *root,
>         while (node) {
>                 struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(n=
ode);
>
> -               cmp =3D strncmp(name, p->name, len);
> +               cmp =3D strncmp(name, p->c_name, len);
>                 if (cmp > 0)
>                         node =3D p->node.rb_right;
> -               else if (cmp < 0 || len < p->len)
> +               else if (cmp < 0 || len < p->c_len)
>                         node =3D p->node.rb_left;
>                 else
>                         return p;
> @@ -145,6 +169,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data *r=
dd,
>
>  static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_da=
ta *rdd,
>                                                    const char *name, int =
len,
> +                                                  const char *c_name, in=
t c_len,
>                                                    u64 ino, unsigned int =
d_type)
>  {
>         struct ovl_cache_entry *p;
> @@ -167,6 +192,14 @@ static struct ovl_cache_entry *ovl_cache_entry_new(s=
truct ovl_readdir_data *rdd,
>         /* Defer check for overlay.whiteout to ovl_iterate() */
>         p->check_xwhiteout =3D rdd->in_xwhiteouts_dir && d_type =3D=3D DT=
_REG;
>
> +       if (c_name && c_name !=3D name) {
> +               p->c_name =3D c_name;
> +               p->c_len =3D c_len;
> +       } else {
> +               p->c_name =3D p->name;
> +               p->c_len =3D len;
> +       }
> +
>         if (d_type =3D=3D DT_CHR) {
>                 p->next_maybe_whiteout =3D rdd->first_maybe_whiteout;
>                 rdd->first_maybe_whiteout =3D p;
> @@ -174,48 +207,55 @@ static struct ovl_cache_entry *ovl_cache_entry_new(=
struct ovl_readdir_data *rdd,
>         return p;
>  }
>
> -static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> -                                 const char *name, int len, u64 ino,
> +/* Return 0 for found, 1 for added, <0 for error */
> +static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> +                                 const char *name, int len,
> +                                 const char *c_name, int c_len,
> +                                 u64 ino,
>                                   unsigned int d_type)
>  {
>         struct rb_node **newp =3D &rdd->root->rb_node;
>         struct rb_node *parent =3D NULL;
>         struct ovl_cache_entry *p;
>
> -       if (ovl_cache_entry_find_link(name, len, &newp, &parent))
> -               return true;
> +       if (ovl_cache_entry_find_link(c_name, c_len, &newp, &parent))
> +               return 0;
>
> -       p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
> +       p =3D ovl_cache_entry_new(rdd, name, len, c_name, c_len, ino, d_t=
ype);
>         if (p =3D=3D NULL) {
>                 rdd->err =3D -ENOMEM;
> -               return false;
> +               return -ENOMEM;
>         }
>
>         list_add_tail(&p->l_node, rdd->list);
>         rb_link_node(&p->node, parent, newp);
>         rb_insert_color(&p->node, rdd->root);
>
> -       return true;
> +       return 1;
>  }
>
> -static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
> +/* Return 0 for found, 1 for added, <0 for error */
> +static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
>                            const char *name, int namelen,
> +                          const char *c_name, int c_len,
>                            loff_t offset, u64 ino, unsigned int d_type)
>  {
>         struct ovl_cache_entry *p;
>
> -       p =3D ovl_cache_entry_find(rdd->root, name, namelen);
> +       p =3D ovl_cache_entry_find(rdd->root, c_name, c_len);
>         if (p) {
>                 list_move_tail(&p->l_node, &rdd->middle);
> +               return 0;
>         } else {
> -               p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type=
);
> +               p =3D ovl_cache_entry_new(rdd, name, namelen, c_name, c_l=
en,
> +                                       ino, d_type);
>                 if (p =3D=3D NULL)
>                         rdd->err =3D -ENOMEM;
>                 else
>                         list_add_tail(&p->l_node, &rdd->middle);
>         }
>
> -       return rdd->err =3D=3D 0;
> +       return rdd->err ?: 1;
>  }
>
>  void ovl_cache_free(struct list_head *list)
> @@ -223,8 +263,11 @@ void ovl_cache_free(struct list_head *list)
>         struct ovl_cache_entry *p;
>         struct ovl_cache_entry *n;
>
> -       list_for_each_entry_safe(p, n, list, l_node)
> +       list_for_each_entry_safe(p, n, list, l_node) {
> +               if (p->c_name !=3D p->name)
> +                       kfree(p->c_name);
>                 kfree(p);
> +       }
>
>         INIT_LIST_HEAD(list);
>  }
> @@ -260,12 +303,36 @@ static bool ovl_fill_merge(struct dir_context *ctx,=
 const char *name,
>  {
>         struct ovl_readdir_data *rdd =3D
>                 container_of(ctx, struct ovl_readdir_data, ctx);
> +       struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
> +       const char *c_name =3D NULL;
> +       char *cf_name =3D NULL;
> +       int c_len =3D 0, ret;
> +
> +       if (ofs->casefold)
> +               c_len =3D ovl_casefold(rdd->map, name, namelen, &cf_name)=
;
> +
> +       if (c_len <=3D 0) {
> +               c_name =3D name;
> +               c_len =3D namelen;
> +       } else {
> +               c_name =3D cf_name;
> +       }
>
>         rdd->count++;
>         if (!rdd->is_lowest)
> -               return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_=
type);
> +               ret =3D ovl_cache_entry_add_rb(rdd, name, namelen, c_name=
, c_len, ino, d_type);
>         else
> -               return ovl_fill_lowest(rdd, name, namelen, offset, ino, d=
_type);
> +               ret =3D ovl_fill_lowest(rdd, name, namelen, c_name, c_len=
, offset, ino, d_type);
> +
> +       /*
> +        * If ret =3D=3D 1, that means that c_name is being used as part =
of struct
> +        * ovl_cache_entry and will be freed at ovl_cache_free(). Otherwi=
se,
> +        * c_name was found in the rb-tree so we can free it here.
> +        */
> +       if (ret !=3D 1 && c_name !=3D name)
> +               kfree(c_name);
> +
> +       return ret >=3D 0;
>  }
>
>  static int ovl_check_whiteouts(const struct path *path, struct ovl_readd=
ir_data *rdd)
> @@ -357,12 +424,18 @@ static int ovl_dir_read_merged(struct dentry *dentr=
y, struct list_head *list,
>                 .list =3D list,
>                 .root =3D root,
>                 .is_lowest =3D false,
> +               .map =3D NULL,
>         };
>         int idx, next;
>         const struct ovl_layer *layer;
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>
>         for (idx =3D 0; idx !=3D -1; idx =3D next) {
>                 next =3D ovl_path_next(idx, dentry, &realpath, &layer);
> +
> +               if (ofs->casefold)
> +                       rdd.map =3D sb_encoding(realpath.dentry->d_sb);
> +
>                 rdd.is_upper =3D ovl_dentry_upper(dentry) =3D=3D realpath=
.dentry;
>                 rdd.in_xwhiteouts_dir =3D layer->has_xwhiteouts &&
>                                         ovl_dentry_has_xwhiteouts(dentry)=
;
> @@ -555,7 +628,7 @@ static bool ovl_fill_plain(struct dir_context *ctx, c=
onst char *name,
>                 container_of(ctx, struct ovl_readdir_data, ctx);
>
>         rdd->count++;
> -       p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
> +       p =3D ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_typ=
e);
>         if (p =3D=3D NULL) {
>                 rdd->err =3D -ENOMEM;
>                 return false;
> @@ -1023,6 +1096,8 @@ int ovl_check_empty_dir(struct dentry *dentry, stru=
ct list_head *list)
>
>  del_entry:
>                 list_del(&p->l_node);
> +               if (p->c_name !=3D p->name)
> +                       kfree(p->c_name);
>                 kfree(p);

OK I thought this was contained in ovl_cache_free().
If we need to repeat this check, we need a helper
ovl_cache_entry_free() to use instead of kfree(p)
everywhere even in ovl_dir_read_impure() when it won't
actually be needed.

I can make this change on commit no need to repost.

Thanks,
Amir.

