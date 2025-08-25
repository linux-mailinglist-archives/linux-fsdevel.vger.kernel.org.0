Return-Path: <linux-fsdevel+bounces-58999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858D9B33DB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AA0205D32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7AB2E1EEB;
	Mon, 25 Aug 2025 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b="D5vErNKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2192D5406;
	Mon, 25 Aug 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120157; cv=none; b=dIvgzuMWMpg+zE8VuKWJSJQ9Cf39nWRc3fT9FwP3bpsBYp/03aQUSzZBU1S4nZ2eFcLgnz977aXBimDE5K0WF3atTvRbrtvNKwlMMTVasjbhc1DtJXMghX3VeOIUAXkTO/rrvphM3hkMiWvJ2Wi37n5nx67Iq+7QfxG2ujDDi7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120157; c=relaxed/simple;
	bh=E/rJutjjHAOnQijuJDlErN8XamGuSWBFfQFN6zLLTDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XtbA0cFdQJezL8i58Ch4Ei+qzRdmP1iKFG+Kzj5iUKoyce3rWMcGQ6K8UztFVIZrQf/WXLNqzYWDS1a6gfUALyyM21txFNZc9a/DhkMEteVhXAZNX8Uct88q6E77yEP172YArylQG19fv14yqEmkLEPWuXq/lqYd0raygdIDV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be; spf=pass smtp.mailfrom=krisman.be; dkim=pass (2048-bit key) header.d=krisman.be header.i=@krisman.be header.b=D5vErNKa; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=krisman.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krisman.be
Received: by mail.gandi.net (Postfix) with ESMTPSA id 176614335A;
	Mon, 25 Aug 2025 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
	t=1756120152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TZWh2miVjNMMNtsl3nXpBGayog/kcpFFnfG2ACtIow=;
	b=D5vErNKafppXWWBOBlYIVIdTLzRbPMOrAxfaXtyov9Kf0dwdPu1or+5sypFCTYuxsIqhEx
	b6O93tBullTXXbXaMPBkRrEvBIN1mFIhTONryC/X3996tiLOtp6o4CBRASPnDXjUeSZWq3
	PhzbV9PUuskan5IgFPuRxv+UPe/DsDc3E3D5ULdt9o8NvuXIa8ETy15g31s2sJfa9bIiIT
	xiXLMKLsjAqWSjD2rVk+aFLVOqZZvAbtEsItNPl32LYoeWNHvv7ZJGMaOll07jyz+qvFh/
	m63P2K7vnDsMjvQLofg744IsSz0lRwZd4rCkXdQ37q0bvjsgOhRFj5St5FJ//w==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Theodore Tso <tytso@mit.edu>,
  linux-unionfs@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
  kernel-dev@igalia.com
Subject: Re: [PATCH v6 4/9] ovl: Create ovl_casefold() to support casefolded
 strncmp()
In-Reply-To: <20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 22 Aug 2025 11:17:07 -0300")
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
	<20250822-tonyk-overlayfs-v6-4-8b6e9e604fa2@igalia.com>
Date: Mon, 25 Aug 2025 07:09:07 -0400
Message-ID: <875xeb64ks.fsf@mailhost.krisman.be>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthhqredttderjeenucfhrhhomhepifgrsghrihgvlhcumfhrihhsmhgrnhcuuegvrhhtrgiiihcuoehgrggsrhhivghlsehkrhhishhmrghnrdgsvgeqnecuggftrfgrthhtvghrnhepfedtvdehffevtddujeffffejudeuuefgvdeujeduhedtgfehkeefheegjefgueeknecukfhppeejtddrkedvrddukedvrdeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeejtddrkedvrddukedvrdeikedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghgrsghrihgvlheskhhrihhsmhgrnhdrsggvpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrnhgurhgvrghlmhgvihgusehighgrlhhirgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvr
 hhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhk
X-GND-Sasl: gabriel@krisman.be

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

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
>  	bool is_upper;
>  	bool is_whiteout;
>  	bool check_xwhiteout;
> +	const char *c_name;
> +	int c_len;
>  	char name[];
>  };
>=20=20
> @@ -45,6 +47,7 @@ struct ovl_readdir_data {
>  	struct list_head *list;
>  	struct list_head middle;
>  	struct ovl_cache_entry *first_maybe_whiteout;
> +	struct unicode_map *map;
>  	int count;
>  	int err;
>  	bool is_upper;
> @@ -66,6 +69,27 @@ static struct ovl_cache_entry *ovl_cache_entry_from_no=
de(struct rb_node *n)
>  	return rb_entry(n, struct ovl_cache_entry, node);
>  }
>=20=20
> +static int ovl_casefold(struct unicode_map *map, const char *str, int le=
n, char **dst)
> +{
> +	const struct qstr qstr =3D { .name =3D str, .len =3D len };
> +	int cf_len;
> +
> +	if (!IS_ENABLED(CONFIG_UNICODE) || !map || is_dot_dotdot(str, len))
> +		return 0;
> +
> +	*dst =3D kmalloc(NAME_MAX, GFP_KERNEL);
> +
> +	if (dst) {
> +		cf_len =3D utf8_casefold(map, &qstr, *dst, NAME_MAX);
> +
> +		if (cf_len > 0)
> +			return cf_len;
> +	}
> +
> +	kfree(*dst);
> +	return 0;
> +}

Hi,

I should just note this does not differentiates allocation errors from
casefolding errors (invalid encoding).  It might be just a theoretical
error because GFP_KERNEL shouldn't fail (wink, wink) and the rest of the
operation is likely to fail too, but if you have an allocation failure, you
can end up with an inconsistent cache, because a file is added under the
!casefolded name and a later successful lookup will look for the
casefolded version.

> +
>  static bool ovl_cache_entry_find_link(const char *name, int len,
>  				      struct rb_node ***link,
>  				      struct rb_node **parent)
> @@ -79,10 +103,10 @@ static bool ovl_cache_entry_find_link(const char *na=
me, int len,
>=20=20
>  		*parent =3D *newp;
>  		tmp =3D ovl_cache_entry_from_node(*newp);
> -		cmp =3D strncmp(name, tmp->name, len);
> +		cmp =3D strncmp(name, tmp->c_name, len);
>  		if (cmp > 0)
>  			newp =3D &tmp->node.rb_right;
> -		else if (cmp < 0 || len < tmp->len)
> +		else if (cmp < 0 || len < tmp->c_len)
>  			newp =3D &tmp->node.rb_left;
>  		else
>  			found =3D true;
> @@ -101,10 +125,10 @@ static struct ovl_cache_entry *ovl_cache_entry_find=
(struct rb_root *root,
>  	while (node) {
>  		struct ovl_cache_entry *p =3D ovl_cache_entry_from_node(node);
>=20=20
> -		cmp =3D strncmp(name, p->name, len);
> +		cmp =3D strncmp(name, p->c_name, len);
>  		if (cmp > 0)
>  			node =3D p->node.rb_right;
> -		else if (cmp < 0 || len < p->len)
> +		else if (cmp < 0 || len < p->c_len)
>  			node =3D p->node.rb_left;
>  		else
>  			return p;
> @@ -145,6 +169,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data *r=
dd,
>=20=20
>  static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_da=
ta *rdd,
>  						   const char *name, int len,
> +						   const char *c_name, int c_len,
>  						   u64 ino, unsigned int d_type)
>  {
>  	struct ovl_cache_entry *p;
> @@ -167,6 +192,14 @@ static struct ovl_cache_entry *ovl_cache_entry_new(s=
truct ovl_readdir_data *rdd,
>  	/* Defer check for overlay.whiteout to ovl_iterate() */
>  	p->check_xwhiteout =3D rdd->in_xwhiteouts_dir && d_type =3D=3D DT_REG;
>=20=20
> +	if (c_name && c_name !=3D name) {
> +		p->c_name =3D c_name;
> +		p->c_len =3D c_len;
> +	} else {
> +		p->c_name =3D p->name;
> +		p->c_len =3D len;
> +	}
> +
>  	if (d_type =3D=3D DT_CHR) {
>  		p->next_maybe_whiteout =3D rdd->first_maybe_whiteout;
>  		rdd->first_maybe_whiteout =3D p;
> @@ -174,48 +207,55 @@ static struct ovl_cache_entry *ovl_cache_entry_new(=
struct ovl_readdir_data *rdd,
>  	return p;
>  }
>=20=20
> -static bool ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> -				  const char *name, int len, u64 ino,
> +/* Return 0 for found, 1 for added, <0 for error */
> +static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
> +				  const char *name, int len,
> +				  const char *c_name, int c_len,
> +				  u64 ino,
>  				  unsigned int d_type)
>  {
>  	struct rb_node **newp =3D &rdd->root->rb_node;
>  	struct rb_node *parent =3D NULL;
>  	struct ovl_cache_entry *p;
>=20=20
> -	if (ovl_cache_entry_find_link(name, len, &newp, &parent))
> -		return true;
> +	if (ovl_cache_entry_find_link(c_name, c_len, &newp, &parent))
> +		return 0;
>=20=20
> -	p =3D ovl_cache_entry_new(rdd, name, len, ino, d_type);
> +	p =3D ovl_cache_entry_new(rdd, name, len, c_name, c_len, ino, d_type);
>  	if (p =3D=3D NULL) {
>  		rdd->err =3D -ENOMEM;
> -		return false;
> +		return -ENOMEM;
>  	}
>=20=20
>  	list_add_tail(&p->l_node, rdd->list);
>  	rb_link_node(&p->node, parent, newp);
>  	rb_insert_color(&p->node, rdd->root);
>=20=20
> -	return true;
> +	return 1;
>  }
>=20=20
> -static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
> +/* Return 0 for found, 1 for added, <0 for error */
> +static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
>  			   const char *name, int namelen,
> +			   const char *c_name, int c_len,
>  			   loff_t offset, u64 ino, unsigned int d_type)
>  {
>  	struct ovl_cache_entry *p;
>=20=20
> -	p =3D ovl_cache_entry_find(rdd->root, name, namelen);
> +	p =3D ovl_cache_entry_find(rdd->root, c_name, c_len);
>  	if (p) {
>  		list_move_tail(&p->l_node, &rdd->middle);
> +		return 0;
>  	} else {
> -		p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
> +		p =3D ovl_cache_entry_new(rdd, name, namelen, c_name, c_len,
> +					ino, d_type);
>  		if (p =3D=3D NULL)
>  			rdd->err =3D -ENOMEM;
>  		else
>  			list_add_tail(&p->l_node, &rdd->middle);
>  	}
>=20=20
> -	return rdd->err =3D=3D 0;
> +	return rdd->err ?: 1;
>  }
>=20=20
>  void ovl_cache_free(struct list_head *list)
> @@ -223,8 +263,11 @@ void ovl_cache_free(struct list_head *list)
>  	struct ovl_cache_entry *p;
>  	struct ovl_cache_entry *n;
>=20=20
> -	list_for_each_entry_safe(p, n, list, l_node)
> +	list_for_each_entry_safe(p, n, list, l_node) {
> +		if (p->c_name !=3D p->name)
> +			kfree(p->c_name);
>  		kfree(p);
> +	}
>=20=20
>  	INIT_LIST_HEAD(list);
>  }
> @@ -260,12 +303,36 @@ static bool ovl_fill_merge(struct dir_context *ctx,=
 const char *name,
>  {
>  	struct ovl_readdir_data *rdd =3D
>  		container_of(ctx, struct ovl_readdir_data, ctx);
> +	struct ovl_fs *ofs =3D OVL_FS(rdd->dentry->d_sb);
> +	const char *c_name =3D NULL;
> +	char *cf_name =3D NULL;
> +	int c_len =3D 0, ret;
> +
> +	if (ofs->casefold)
> +		c_len =3D ovl_casefold(rdd->map, name, namelen, &cf_name);
> +
> +	if (c_len <=3D 0) {
> +		c_name =3D name;
> +		c_len =3D namelen;
> +	} else {
> +		c_name =3D cf_name;
> +	}
>=20=20
>  	rdd->count++;
>  	if (!rdd->is_lowest)
> -		return ovl_cache_entry_add_rb(rdd, name, namelen, ino, d_type);
> +		ret =3D ovl_cache_entry_add_rb(rdd, name, namelen, c_name, c_len, ino,=
 d_type);
>  	else
> -		return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_type);
> +		ret =3D ovl_fill_lowest(rdd, name, namelen, c_name, c_len, offset, ino=
, d_type);
> +
> +	/*
> +	 * If ret =3D=3D 1, that means that c_name is being used as part of str=
uct
> +	 * ovl_cache_entry and will be freed at ovl_cache_free(). Otherwise,
> +	 * c_name was found in the rb-tree so we can free it here.
> +	 */
> +	if (ret !=3D 1 && c_name !=3D name)
> +		kfree(c_name);
> +

The semantics of this being conditionally freed is a bit annoying, as
it is already replicated in 3 places. I suppose a helper would come in
hand.

In this specific case, it could just be:

if (ret !=3D 1)
        kfree(cf_name);


> +	return ret >=3D 0;
>  }
>=20=20
>  static int ovl_check_whiteouts(const struct path *path, struct ovl_readd=
ir_data *rdd)
> @@ -357,12 +424,18 @@ static int ovl_dir_read_merged(struct dentry *dentr=
y, struct list_head *list,
>  		.list =3D list,
>  		.root =3D root,
>  		.is_lowest =3D false,
> +		.map =3D NULL,
>  	};
>  	int idx, next;
>  	const struct ovl_layer *layer;
> +	struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>=20=20
>  	for (idx =3D 0; idx !=3D -1; idx =3D next) {
>  		next =3D ovl_path_next(idx, dentry, &realpath, &layer);
> +
> +		if (ofs->casefold)
> +			rdd.map =3D sb_encoding(realpath.dentry->d_sb);
> +
>  		rdd.is_upper =3D ovl_dentry_upper(dentry) =3D=3D realpath.dentry;
>  		rdd.in_xwhiteouts_dir =3D layer->has_xwhiteouts &&
>  					ovl_dentry_has_xwhiteouts(dentry);
> @@ -555,7 +628,7 @@ static bool ovl_fill_plain(struct dir_context *ctx, c=
onst char *name,
>  		container_of(ctx, struct ovl_readdir_data, ctx);
>=20=20
>  	rdd->count++;
> -	p =3D ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
> +	p =3D ovl_cache_entry_new(rdd, name, namelen, NULL, 0, ino, d_type);
>  	if (p =3D=3D NULL) {
>  		rdd->err =3D -ENOMEM;
>  		return false;
> @@ -1023,6 +1096,8 @@ int ovl_check_empty_dir(struct dentry *dentry, stru=
ct list_head *list)
>=20=20
>  del_entry:
>  		list_del(&p->l_node);
> +		if (p->c_name !=3D p->name)
> +			kfree(p->c_name);
>  		kfree(p);
>  	}

--=20
Gabriel Krisman Bertazi

