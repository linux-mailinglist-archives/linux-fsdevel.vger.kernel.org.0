Return-Path: <linux-fsdevel+bounces-59109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01350B34848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A1D16A207
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A637301039;
	Mon, 25 Aug 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="LXmHeZts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547DD21FF29;
	Mon, 25 Aug 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141910; cv=none; b=Zdn+ICZanZfut0Gh7BWnI4P+msPGqQJ/U/KxHIKcNEIIv+9OejVGpPO7kXNIpfkdVEjAZaFAtjNEZlhrsPm5lU+jc7s0EW2qQWhebO0mKskiZfckz8SyJ5ZWbq5nxXLEVnKk11YYE17D5KxgkBJU6uzgmoVr2na7AoxFFe9BdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141910; c=relaxed/simple;
	bh=dLcnXuGcWpEhVGLZ6K/kgN19PdQdMFcOS1l5Z9LNJkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T9nouDTdBtBNru5G0NcaBpU48CoJXrEbdRSNT2aZjbMhXXGIKf9hjc2Z7IPlAZoIcn1+AW27PHA77L7oVPVtTHd7EeVhtG1nasIHimWOU4XfLQb09OHuFziGrG89Lft7uGjvxlDAf1tyEyjcp0oyzsBX4S9FtVwbIMe/m5yjz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=LXmHeZts; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECAB743B89;
	Mon, 25 Aug 2025 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1756141904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMo2y2Ps82gDSLjiJPHhyCa90JmOJ2n5TM25aj/Um84=;
	b=LXmHeZtsK8wr4K/IiyAn4SJAPa+uL8uoMIgmAsc0F33AvLWNloGLIwEsygD0+sqUkpwSe+
	Rg5GuWcJv9WiGkuOy0YAftHc+/HjtrDctl01bljVpsTL785cJjAIvqXzhBbpVUweeHm+W4
	/p4NUM29sRCZy3LSvqhGnYm/n5d02LdoKc2GW/JG55mMw/8pojNzFlZKnk+HxIb6P/3syJ
	+IeDRf10Vb1B8AdrzMn/tb29NR7jGzuwZfxNMi93JufAJwcOCoXHtra/GiCwxYnKtKs1AW
	uAeUE211DATSt4tL5u/Xa26mD2iXbdZnJJOyhQjxEC6WTLl6YYM3v7Dcuu59dw==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Amir Goldstein <amir73il@gmail.com>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
In-Reply-To: <CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
	(Amir Goldstein's message of "Mon, 25 Aug 2025 17:45:40 +0200")
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
	<875xeb64ks.fsf@mailhost.krisman.be>
	<CAOQ4uxiHQx=_d_22RBUvr9FSbtF-+DJMnoRi0QnODXRR=c47gA@mail.gmail.com>
	<CAOQ4uxgaefXzkjpHgjL0AZrOn_ZMP=b1TKp-KDh53q-4borUZw@mail.gmail.com>
Date: Mon, 25 Aug 2025 13:11:40 -0400
Message-ID: <871poz4983.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvr
 hhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-GND-Sasl: gabriel@krisman.be

Amir Goldstein <amir73il@gmail.com> writes:

> On Mon, Aug 25, 2025 at 5:27=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
>>
>> On Mon, Aug 25, 2025 at 1:09=E2=80=AFPM Gabriel Krisman Bertazi
>> <gabriel@krisman.be> wrote:
>> >
>> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
>> >
>> > > To add overlayfs support casefold layers, create a new function
>> > > ovl_casefold(), to be able to do case-insensitive strncmp().
>> > >
>> > > ovl_casefold() allocates a new buffer and stores the casefolded vers=
ion
>> > > of the string on it. If the allocation or the casefold operation fai=
ls,
>> > > fallback to use the original string.
>> > >
>> > > The case-insentive name is then used in the rb-tree search/insertion
>> > > operation. If the name is found in the rb-tree, the name can be
>> > > discarded and the buffer is freed. If the name isn't found, it's then
>> > > stored at struct ovl_cache_entry to be used later.
>> > >
>> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>> > > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>> > > ---
>> > > Changes from v6:
>> > >  - Last version was using `strncmp(... tmp->len)` which was causing
>> > >    regressions. It should be `strncmp(... len)`.
>> > >  - Rename cf_len to c_len
>> > >  - Use c_len for tree operation: (cmp < 0 || len < tmp->c_len)
>> > >  - Remove needless kfree(cf_name)
>> > > ---
>> > >  fs/overlayfs/readdir.c | 113 ++++++++++++++++++++++++++++++++++++++=
++---------
>> > >  1 file changed, 94 insertions(+), 19 deletions(-)
>> > >
>> > > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
>> > > index b65cdfce31ce27172d28d879559f1008b9c87320..dfc661b7bc3f87efbf14=
991e97cee169400d823b 100644
>> > > --- a/fs/overlayfs/readdir.c
>> > > +++ b/fs/overlayfs/readdir.c
>> > > @@ -27,6 +27,8 @@ struct ovl_cache_entry {
>> > >       bool is_upper;
>> > >       bool is_whiteout;
>> > >       bool check_xwhiteout;
>> > > +     const char *c_name;
>> > > +     int c_len;
>> > >       char name[];
>> > >  };
>> > >
>> > > @@ -45,6 +47,7 @@ struct ovl_readdir_data {
>> > >       struct list_head *list;
>> > >       struct list_head middle;
>> > >       struct ovl_cache_entry *first_maybe_whiteout;
>> > > +     struct unicode_map *map;
>> > >       int count;
>> > >       int err;
>> > >       bool is_upper;
>> > > @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_fr=
om_node(struct rb_node *n)
>> > >       return rb_entry(n, struct ovl_cache_entry, node);
>> > >  }
>> > >
>> > > +static int ovl_casefold(struct unicode_map *map, const char *str, i=
nt len, char **dst)
>> > > +{
>> > > +     const struct qstr qstr =3D { .name =3D str, .len =3D len };
>> > > +     int cf_len;
>> > > +
>> > > +     if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, =
len))
>> > > +             return 0;
>> > > +
>> > > +     *dst =3D kmalloc(NAME_MAX, GFP_KERNEL);
>> > > +
>> > > +     if (dst) {
>> > > +             cf_len =3D utf8_casefold(map, &qstr, *dst, NAME_MAX);
>> > > +
>> > > +             if (cf_len > 0)
>> > > +                     return cf_len;
>> > > +     }
>> > > +
>> > > +     kfree(*dst);
>> > > +     return 0;
>> > > +}
>> >
>> > Hi,
>> >
>> > I should just note this does not differentiates allocation errors from
>> > casefolding errors (invalid encoding).  It might be just a theoretical
>> > error because GFP_KERNEL shouldn't fail (wink, wink) and the rest of t=
he
>> > operation is likely to fail too, but if you have an allocation failure=
, you
>> > can end up with an inconsistent cache, because a file is added under t=
he
>> > !casefolded name and a later successful lookup will look for the
>> > casefolded version.
>>
>> Good point.
>> I will fix this in my tree.
>
> wait why should we not fail to fill the cache for both allocation
> and encoding errors?
>

We shouldn't fail the cache for encoding errors, just for allocation errors.

Perhaps I am misreading the code, so please correct me if I'm wrong.  if
ovl_casefold fails, the non-casefolded name is used in the cache.  That
makes sense if the reason utf8_casefold failed is because the string
cannot be casefolded (i.e. an invalid utf-8 string). For those strings,
everything is fine.  But on an allocation failure, the string might have
a real casefolded version.  If we fallback to the original string as the
key, a cache lookup won't find the entry, since we compare with memcmp.

>
>>
>> >
>> > > +
>> > >  static bool ovl_cache_entry_find_link(const char *name, int len,
>> > >                                     struct rb_node ***link,
>> > >                                     struct rb_node **parent)
>> > > @@ -79,10 +103,10 @@ static bool ovl_cache_entry_find_link(const cha=
r *name, int len,
>> > >
>> > >               *parent =3D *newp;
>> > >               tmp =3D ovl_cache_entry_from_node(*newp);
>> > > -             cmp =3D strncmp(name, tmp->name, len);
>> > > +             cmp =3D strncmp(name, tmp->c_name, len);
>> > >               if (cmp > 0)
>> > >                       newp =3D &tmp->node.rb_right;
>> > > -             else if (cmp < 0 || len < tmp->len)
>> > > +             else if (cmp < 0 || len < tmp->c_len)
>> > >                       newp =3D &tmp->node.rb_left;
>> > >               else
>> > >                       found =3D true;
>> > > @@ -101,10 +125,10 @@ static struct ovl_cache_entry *ovl_cache_entry=
_find(struct rb_root *root,
>> > >       while (node) {
>> > >               struct ovl_cache_entry *p =3D ovl_cache_entry_from_nod=
e(node);
>> > >
>> > > -             cmp =3D strncmp(name, p->name, len);
>> > > +             cmp =3D strncmp(name, p->c_name, len);
>> > >               if (cmp > 0)
>> > >                       node =3D p->node.rb_right;
>> > > -             else if (cmp < 0 || len < p->len)
>> > > +             else if (cmp < 0 || len < p->c_len)
>> > >                       node =3D p->node.rb_left;
>> > >               else
>> > >                       return p;
>> > > @@ -145,6 +169,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_da=
ta *rdd,
>> > >
>> > >  static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readd=
ir_data *rdd,
>> > >                                                  const char *name, i=
nt len,
>> > > +                                                const char *c_name,=
 int c_len,
>> > >                                                  u64 ino, unsigned i=
nt d_type)
>> > >  {
>> > >       struct ovl_cache_entry *p;
>> > > @@ -167,6 +192,14 @@ static struct ovl_cache_entry *ovl_cache_entry_=
new(struct ovl_readdir_data *rdd,
>> > >       /* Defer check for overlay.whiteout to ovl_iterate() */
>> > >       p->check_xwhiteout =3D rdd->in_xwhiteouts_dir && d_type =3D=3D=
 DT_REG;
>> > >
>> > > +     if (c_name && c_name !=3D name) {
>> > > +             p->c_name =3D c_name;
>> > > +             p->c_len =3D c_len;
>> > > +     } else {
>> > > +             p->c_name =3D p->name;
>> > > +             p->c_len =3D len;
>> > > +     }
>> > > +
>> > >       if (d_type =3D=3D DT_CHR) {
>> > >               p->next_maybe_whiteout =3D rdd->first_maybe_whiteout;
>> > >               rdd->first_maybe_whiteout =3D p;
>> > > @@ -174,48 +207,55 @@ static struct ovl_cache_entry *ovl_cache_entry=
_new(struct ovl_readdir_data *rdd,
>> > >       return p;
>> > >  }
>> > >
>> > > -static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
>> > > -                               const char *name, int len, u64 ino,
>> > > +/* Return 0 for found, 1 for added, <0 for error */
>> > > +static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
>> > > +                               const char *name, int len,
>> > > +                               const char *c_name, int c_len,
>> > > +                               u64 ino,
>> > >                                 unsigned int d_type)
>> > >  {
>> > >       struct rb_node **newp =3D &rdd->root->rb_node;
>> > >       struct rb_node *parent =3D NULL;
>> > >       struct ovl_cache_entry *p;
>> > >
>> > > -     if (ovl_cache_entry_find_link(name, len, &newp, &parent))
>> > > -             return true;
>> > > +     if (ovl_cache_entry_find_link(c_name, c_len, &newp, &parent))
>> > > +             return 0;
>> > >
>> > > -     p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
>> > > +     p =3D ovl_cache_entry_new(rdd, name, len, c_name, c_len, ino, =
d_type);
>> > >       if (p =3D=3D NULL) {
>> > >               rdd->err =3D -ENOMEM;
>> > > -             return false;
>> > > +             return -ENOMEM;
>> > >       }
>> > >
>> > >       list_add_tail(&p->l_node, rdd->list);
>> > >       rb_link_node(&p->node, parent, newp);
>> > >       rb_insert_color(&p->node, rdd->root);
>> > >
>> > > -     return true;
>> > > +     return 1;
>> > >  }
>> > >
>> > > -static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
>> > > +/* Return 0 for found, 1 for added, <0 for error */
>> > > +static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
>> > >                          const char *name, int namelen,
>> > > +                        const char *c_name, int c_len,
>> > >                          loff_t offset, u64 ino, unsigned int d_type)
>> > >  {
>> > >       struct ovl_cache_entry *p;
>> > >
>> > > -     p =3D ovl_cache_entry_find(rdd->root, name, namelen);
>> > > +     p =3D ovl_cache_entry_find(rdd->root, c_name, c_len);
>> > >       if (p) {
>> > >               list_move_tail(&p->l_node, &rdd->middle);
>> > > +             return 0;
>> > >       } else {
>> > > -             p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_t=
ype);
>> > > +             p =3D ovl_cache_entry_new(rdd, name, namelen, c_name, =
c_len,
>> > > +                                     ino, d_type);
>> > >               if (p =3D=3D NULL)
>> > >                       rdd->err =3D -ENOMEM;
>> > >               else
>> > >                       list_add_tail(&p->l_node, &rdd->middle);
>> > >       }
>> > >
>> > > -     return rdd->err =3D=3D 0;
>> > > +     return rdd->err ?: 1;
>> > >  }
>> > >
>> > >  void ovl_cache_free(struct list_head *list)
>> > > @@ -223,8 +263,11 @@ void ovl_cache_free(struct list_head *list)
>> > >       struct ovl_cache_entry *p;
>> > >       struct ovl_cache_entry *n;
>> > >
>> > > -     list_for_each_entry_safe(p, n, list, l_node)
>> > > +     list_for_each_entry_safe(p, n, list, l_node) {
>> > > +             if (p->c_name !=3D p->name)
>> > > +                     kfree(p->c_name);
>> > >               kfree(p);
>> > > +     }
>> > >
>> > >       INIT_LIST_HEAD(list);
>> > >  }
>> > > @@ -260,12 +303,36 @@ static bool ovl_fill_merge(struct dir_context =
*ctx, const char *name,
>> > >  {
>> > >       struct ovl_readdir_data *rdd =3D
>> > >               container_of(ctx, struct ovl_readdir_data, ctx);
>> > > +     struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
>> > > +     const char *c_name =3D NULL;
>> > > +     char *cf_name =3D NULL;
>> > > +     int c_len =3D 0, ret;
>> > > +
>> > > +     if (ofs->casefold)
>> > > +             c_len =3D ovl_casefold(rdd->map, name, namelen, &cf_na=
me);
>> > > +
>> > > +     if (c_len <=3D 0) {
>> > > +             c_name =3D name;
>> > > +             c_len =3D namelen;
>> > > +     } else {
>> > > +             c_name =3D cf_name;
>> > > +     }
>> > >
>> > >       rdd->count++;
>> > >       if (!rdd->is_lowest)
>> > > -             return ovl_cache_entry_add_rb(rdd, name, namelen, ino,=
 d_type);
>> > > +             ret =3D ovl_cache_entry_add_rb(rdd, name, namelen, c_n=
ame, c_len, ino, d_type);
>> > >       else
>> > > -             return ovl_fill_lowest(rdd, name, namelen, offset, ino=
, d_type);
>> > > +             ret =3D ovl_fill_lowest(rdd, name, namelen, c_name, c_=
len, offset, ino, d_type);
>> > > +
>> > > +     /*
>> > > +      * If ret =3D=3D 1, that means that c_name is being used as pa=
rt of struct
>> > > +      * ovl_cache_entry and will be freed at ovl_cache_free(). Othe=
rwise,
>> > > +      * c_name was found in the rb-tree so we can free it here.
>> > > +      */
>> > > +     if (ret !=3D 1 && c_name !=3D name)
>> > > +             kfree(c_name);
>> > > +
>> >
>> > The semantics of this being conditionally freed is a bit annoying, as
>> > it is already replicated in 3 places. I suppose a helper would come in
>> > hand.
>>
>> Yeh.
>>
>> I have already used ovl_cache_entry_free() in my tree.
>>
>> Thanks,
>> Amir.
>>
>> >
>> > In this specific case, it could just be:
>> >
>> > if (ret !=3D 1)
>> >         kfree(cf_name);
>> >
>> >
>> > > +     return ret >=3D 0;
>> > >  }
>> > >
>> > >  static int ovl_check_whiteouts(const struct path *path, struct ovl_=
readdir_data *rdd)
>> > > @@ -357,12 +424,18 @@ static int ovl_dir_read_merged(struct dentry *=
dentry, struct list_head *list,
>> > >               .list =3D list,
>> > >               .root =3D root,
>> > >               .is_lowest =3D false,
>> > > +             .map =3D NULL,
>> > >       };
>> > >       int idx, next;
>> > >       const struct ovl_layer *layer;
>> > > +     struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>> > >
>> > >       for (idx =3D 0; idx !=3D -1; idx =3D next) {
>> > >               next =3D ovl_path_next(idx, dentry, &realpath, &layer);
>> > > +
>> > > +             if (ofs->casefold)
>> > > +                     rdd.map =3D sb_encoding(realpath.dentry->d_sb);
>> > > +
>> > >               rdd.is_upper =3D ovl_dentry_upper(dentry) =3D=3D realp=
ath.dentry;
>> > >               rdd.in_xwhiteouts_dir =3D layer->has_xwhiteouts &&
>> > >                                       ovl_dentry_has_xwhiteouts(dent=
ry);
>> > > @@ -555,7 +628,7 @@ static bool ovl_fill_plain(struct dir_context *c=
tx, const char *name,
>> > >               container_of(ctx, struct ovl_readdir_data, ctx);
>> > >
>> > >       rdd->count++;
>> > > -     p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
>> > > +     p =3D ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_=
type);
>> > >       if (p =3D=3D NULL) {
>> > >               rdd->err =3D -ENOMEM;
>> > >               return false;
>> > > @@ -1023,6 +1096,8 @@ int ovl_check_empty_dir(struct dentry *dentry,=
 struct list_head *list)
>> > >
>> > >  del_entry:
>> > >               list_del(&p->l_node);
>> > > +             if (p->c_name !=3D p->name)
>> > > +                     kfree(p->c_name);
>> > >               kfree(p);
>> > >       }
>> >
>> > --
>> > Gabriel Krisman Bertazi

--=20
Gabriel Krisman Bertazi

