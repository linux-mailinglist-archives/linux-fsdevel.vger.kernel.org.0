Return-Path: <linux-fsdevel+bounces-58037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FFCB283AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 18:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F625E5284
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D17D308F2F;
	Fri, 15 Aug 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDkj0LV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC8224B03;
	Fri, 15 Aug 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274586; cv=none; b=k/oGj26r8PT+fuMjd7fxx/91NLXzS5apSbgqkcnZ8CMWKtjCZsf95WMLzSVeWuTotylxZbMY+duSU8KPidshWryXXquwpvOWfUBYczbIa5EOKdb5ALVsOupmjaPjJBSZW9VJg15zeJFRWUtIbtZgGqABDQiFTUmyLS61u0itqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274586; c=relaxed/simple;
	bh=CJqtRouB/zf6LLkoYjjtkKlIZ0K2T4r3DtGNwFhhH3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb1A95iA8Qk2mwQizYuRkuw4QvUEdJwPpHqGmTiV2fT12YPzAsOIAU+d3pty9nNTXm3fWqjlI381919Oc6NkhG5txxlvh/mTmzRqrhDXO4eT+up1c6bHEIP1oVpXTHQcTY+6k7RkPn0Or5G37b4oVNpp34deogx8rvsV28i8Rc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDkj0LV1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so2834478a12.2;
        Fri, 15 Aug 2025 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755274583; x=1755879383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1W8qCWPDSlcr4LOYzMFIQnsfqXcLIE3VVjRwGLr7Hk=;
        b=MDkj0LV1jRnJH1XUcop0di2bxwfS1l4Oo6yXSvqYf6ldfFz8DqOFYh5vs/UBp2+M4w
         P/V6QycdgDkfG0ROtWhGxSFFaLGJaPDCRrfvxz1d7MhznAIzlSZAWFkEYc0RXGN1yGB5
         HIAnuvpgXjmMw7iYJDiqLxK1DwCXO/xhrqrRzOjn0aOQaERXFp82P/U3g5ZtUdcE9JMy
         cp2g00gMCLEJBIwbTvM/maAcjyp2YShh6kiRByZnxzhauc1/u99xp/L55UDvz9yCtYop
         D1h24phJeqx6x6gIKUHCdMJwY2jF7B6mH4ZOloF4DSBrS0WFGjqZsxzP8m8loj5FCqry
         EPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755274583; x=1755879383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1W8qCWPDSlcr4LOYzMFIQnsfqXcLIE3VVjRwGLr7Hk=;
        b=R616yPqBrEGHN2VFR+XbskyDCIKpWbKRlG95qCqrObVYf50SkE7+WyewQiVCg8mM48
         4gvHccH0pU+h6wdFCywXfmxDw9EkTBU1ncSUPEJzrR0RJdALtJomBQhzA6iWVV6pEZov
         2LmU94Zld6gVpgUzwakxcOCCYjA6cxZiFj2uXT9PigMF7Pkz7RI3EdK+tDGO9xgZ/Hin
         mMNf+cXGSDAUcOIRK8VpQFBTNbjJivFsnSdOJkgtaCay29jHDR8ltiYbGStX9Gvxsvvw
         6qkJagQeXQiZlKR4mpyTRDcoy2L+LyJu7OZu5aLnIA4BiErXTLdHAifiHH9h72r7HH/l
         GixA==
X-Forwarded-Encrypted: i=1; AJvYcCVF7HnxFBkKP3GQ2rBZ2LqCIlrXX+idm0VcK0+kOqEBFpOx6LfxqlzsH0Im43qZe8Aee7l2d7T/0tD+zY3x@vger.kernel.org, AJvYcCWy55c7T1bQH91egCfPru/dTe/UWWTjjyTwAOkDTmyuluDEqwGgG57E8RyJUm622A4vPBLYd8/pFmoNhAbH@vger.kernel.org, AJvYcCWzxawBYELQueKN0ZmELBEtYk1F2/TgHsa8E9puFxlDTjKjqKYnEsB5o6PkzTYjQohzH42S8t1qGA9apZA8rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3wAkr2BYwDDvyqPAKorSCDqRiS1TNppvrUYUSd/HfdPWP9vj
	HzuOfyDkzJgihlyNQ9A3OOSpH9G5Z6Drbo+x3F0ZdYTzHbeMG/pfNgulNcJ6eiskWfa+onKt9zA
	aFAA4O3uwJYtxYSp7EU59omiJAi/raYV6FbSsB24=
X-Gm-Gg: ASbGnctbVjWR1owsmZSPd84Yn63DqZY3owlIzxnSrBRs9xbrK/VzMk/mD4UsdPoja5f
	6g7Lovh2x1e9gx1Arqrn8pBg07MpkVHJZ78d7lawq7Wqh8xcqdqWn22AF7gYEwkgjfp3hJzfuH3
	qsywyhWyVu16U31K+V5mXnUcoBxffILfpIZbvuz11dGsZNFzeKHqjwwYbh22NKZvkf3fT406Man
	H6N1yFwU1K4x49djA==
X-Google-Smtp-Source: AGHT+IEq53CvZiK9QwqFIqqIkvSxCZLxw6WxxXTSPChXmEAA61xP7XlyJOFW+kFmv0bmdEoccnYSbMGzYVpCumTMoGc=
X-Received: by 2002:a05:6402:234a:b0:615:7fdf:9c4f with SMTP id
 4fb4d7f45d1cf-618b055639amr2207732a12.24.1755274582886; Fri, 15 Aug 2025
 09:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com> <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
In-Reply-To: <20250814-tonyk-overlayfs-v5-4-c5b80a909cbd@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Aug 2025 18:16:11 +0200
X-Gm-Features: Ac12FXw7HEcTxH4ly2XMMWxVMhAdyLVKkIQ0ckSe7GXTHasZi66tKFCBe0_tVXc
Message-ID: <CAOQ4uxjVs4kKfvfp+Jgdf2BxMW8v5p0gPHujRfCHj4733ioCag@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] ovl: Create ovl_casefold() to support casefolded strncmp()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:22=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
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
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v4:
>  - Move the consumer/free buffer logic out to the caller
>  - s/aux/c_name
>
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
>  fs/overlayfs/readdir.c | 115 +++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 97 insertions(+), 18 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index b65cdfce31ce27172d28d879559f1008b9c87320..803ac6a7516d0156ae7793ee1=
ff884dbbf2e20b0 100644
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
> @@ -174,48 +209,55 @@ static struct ovl_cache_entry *ovl_cache_entry_new(=
struct ovl_readdir_data *rdd,
>         return p;
>  }
>
> -static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> -                                 const char *name, int len, u64 ino,
> +/* Return 0 for found, 1 for added, <0 for error */
> +static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
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
> -               return true;
> +       if (ovl_cache_entry_find_link(cf_name, cf_len, &newp, &parent))
> +               return 0;
>
> -       p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
> +       p =3D ovl_cache_entry_new(rdd, name, len, cf_name, cf_len, ino, d=
_type);
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
> +                          const char *cf_name, int cf_len,
>                            loff_t offset, u64 ino, unsigned int d_type)
>  {
>         struct ovl_cache_entry *p;
>
> -       p =3D ovl_cache_entry_find(rdd->root, name, namelen);
> +       p =3D ovl_cache_entry_find(rdd->root, cf_name, cf_len);
>         if (p) {
>                 list_move_tail(&p->l_node, &rdd->middle);
> +               return 0;
>         } else {
> -               p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type=
);
> +               p =3D ovl_cache_entry_new(rdd, name, namelen, cf_name, cf=
_len,
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
> @@ -223,8 +265,11 @@ void ovl_cache_free(struct list_head *list)
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
> @@ -260,12 +305,38 @@ static bool ovl_fill_merge(struct dir_context *ctx,=
 const char *name,
>  {
>         struct ovl_readdir_data *rdd =3D
>                 container_of(ctx, struct ovl_readdir_data, ctx);
> +       struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
> +       char *cf_name =3D NULL;
> +       int c_len =3D 0;
> +       int ret;
> +
> +       const char *c_name =3D NULL;
> +

Another nit:
Pls move up next to cf_name =3D NULL line in your branch

No need to repost.

Thanks,
Amir.

