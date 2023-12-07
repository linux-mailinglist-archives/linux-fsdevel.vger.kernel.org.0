Return-Path: <linux-fsdevel+bounces-5148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5258087D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 13:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E721D283CCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D02A39AE1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X8gBS4kF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE4FAC;
	Thu,  7 Dec 2023 04:14:41 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231207121440euoutp018ce731566aabaa789a4c1cd36f316ea0~ei6wR0eL91319513195euoutp01h;
	Thu,  7 Dec 2023 12:14:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231207121440euoutp018ce731566aabaa789a4c1cd36f316ea0~ei6wR0eL91319513195euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701951280;
	bh=bNgqifOrvCzR6BLjlz9t55dRqKEhpGVlmA9ZxZqLw5k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=X8gBS4kFNkv0TKGfrRhgt/AMKnhAuDTml0Zl+UV080nSX/0a6ngqr3B4cCI9CerAT
	 oCY/SaCIODIsTlxl1j2+/dq7nf/ilAgzh6X5dW22J8NrvBuaZRM86toecd01lZrI4y
	 00J7GzxaZ98gGwBUmATuWGvXnL72IVqGoUO5YG+g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231207121440eucas1p2d5cdc81f31b5545f71203cb626c86c29~ei6wBaD5F0314903149eucas1p2E;
	Thu,  7 Dec 2023 12:14:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 06.77.09539.F27B1756; Thu,  7
	Dec 2023 12:14:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231207121439eucas1p1c8f9aa8c107df1896dc6557569af7dca~ei6vebeqs0274702747eucas1p1u;
	Thu,  7 Dec 2023 12:14:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231207121439eusmtrp1c96348adb57f2e361b3d2020f9509b61~ei6vdxuS52085720857eusmtrp1I;
	Thu,  7 Dec 2023 12:14:39 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-dd-6571b72f5adc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4A.5D.09146.F27B1756; Thu,  7
	Dec 2023 12:14:39 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231207121439eusmtip2ed5aeb9528040a552e9139757fbf76dd~ei6vQ8doe0753107531eusmtip2O;
	Thu,  7 Dec 2023 12:14:39 +0000 (GMT)
Received: from localhost (106.210.248.38) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 7 Dec 2023 12:14:38 +0000
Date: Thu, 7 Dec 2023 13:14:37 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <20231207121437.mfu3gegorsyqvihf@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="d4nggmrrrvv2zcqu"
Content-Disposition: inline
In-Reply-To: <0450d705-3739-4b6d-a1f2-b22d54617de1@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87r62wtTDTY/sbRoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfGvdkzGAsuRFRsfn+XsYGxzbOLkZNDQsBE
	4v/KL2wgtpDACkaJd3+yuxi5gOwvjBLL5i1gh3A+M0os/L+QHabj25RWqMRyRom1DzYgVL3p
	28oC4WxmlPi4ZAoLSAuLgIrEiu+PmEBsNgEdifNv7jCD2CICNhIrv30G62YW2MUkcW3fdbAG
	YQEviRvTljOC2LwC5hIHnrYwQdiCEidnPgGrYRaokFix+h5rFyMHkC0tsfwfB0iYE2hmx9lr
	bBCnKkkcnvyZGcKulTi15RYTyC4JgdWcEr96v7BAJFwkrk49C1UkLPHq+BaoP2UkTk/uYYFo
	mMwosf/fB3aobmDQNH5lgqiylmi58gSqw1HiwcSPYBdJCPBJ3HgrCHEon8SkbdOZIcK8Eh1t
	QhDVahKr771hmcCoPAvJa7OQvDYL4TUIU1Ni/S59FFGQYm2JZQtfM0PYthLr1r1nWcDIvopR
	PLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwyZ3+d/zTDsa5rz7qHWJk4mA8xKgC1Pxow+oL
	jFIsefl5qUoivDnn81OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbB
	ZJk4OKUamFRKw2M2Nsi8PfOqhytz09ReTe4T6//YfvKsT3tXy93OrtvTp1oi9UNYq9WCSU9k
	XvkahXdb/G0Z5u4x+Rs8ieO27bKItG0zbhW1b/jzVunI52JRPqc8843GdxJPMP754L7XQ+7+
	I3O96enegmJr7DbkL5l0OW7pBD8WXp/nbPcuRNf8z5l1b4lQxezaXUteZfcyuf9obkuXYmUP
	X8TPYj+jZV3sDOFXs1z7fvtcfbHcm59t63dz1qm1qcWF4Vw9T7w4Jha4VpyzETRWDVN4FKXz
	qP37yhcL1I1aN6yKPiGxhfWAwrM5jPlHEmdwmYZ0rT/47Pfjn/mGf76EP/WwLRJMfNIvfLrl
	ToN79K0qJZbijERDLeai4kQAcQ8BZu0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xe7r62wtTDY70i1s0L17PZvHr4jRW
	izPduRZ79p5ksZi3/iejxeVdc9gsfv94xmRxY8JTRotlO/0cOD1mN1xk8ViwqdRj06pONo/9
	c9ewe3zeJOfR332MPYAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
	JTUnsyy1SN8uQS9j7/m1TAXnIiq6P91mbGBs8exi5OSQEDCR+Dallb2LkYtDSGApo8TO7/9Z
	IRIyEhu/XIWyhSX+XOtigyj6yCix6O4xsISQwGZGid7rySA2i4CKxIrvj5hAbDYBHYnzb+4w
	g9giAjYSK799BtvALLCLSeLavussIAlhAS+JG9OWM4LYvALmEgeetjBBbFjNLLFl7ysWiISg
	xMmZT8BsZoEyiRtdU4AaOIBsaYnl/zhAwpxACzrOXmODuFRJ4vDkz8wQdq3E57/PGCcwCs9C
	MmkWkkmzECZBhNUl/sy7xIwhrC2xbOFrZgjbVmLduvcsCxjZVzGKpJYW56bnFhvqFSfmFpfm
	pesl5+duYgTG+rZjPzfvYJz36qPeIUYmDsZDjCpAnY82rL7AKMWSl5+XqiTCm3M+P1WINyWx
	siq1KD++qDQntfgQoykwGCcyS4km5wOTUF5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklq
	dmpqQWoRTB8TB6dUA1Oq1ktpBeVnn1w1sqdtOdo0oW+/lQcHL9cbGUPuy3KlaZOt3zQLHI6f
	uV2rc+fEiKdzjV+51H14wV5uef6qIY/kb8WP9iuD3362k5PbkHdn7xuhe7UiT4/d1DaXfC/l
	lWv13E4q+/rW/tiFmY829KRnzqmNEb76nUd26mEB24VHbu18/e5/zW6LmOuveF6JmkzO1pwa
	dDq4M5+j+9iMvcu4Tu+dyGwyr9ZOaPeR4jnGO92O7d4yi2HehJRcZuenAnHCq57V7v0pb7OO
	c+4rbl2hbnGhECP+oqsTZj83vf7zmOkCZ8HE1tbJ9kHLNR09jwkm+H4svXU0rC44/49b4GTt
	NeaqjwtjrM8sW3VXvVmJpTgj0VCLuag4EQDYefhuigMAAA==
X-CMS-MailID: 20231207121439eucas1p1c8f9aa8c107df1896dc6557569af7dca
X-Msg-Generator: CA
X-RootMTR: 20231206055317eucas1p204b75bda8cb2fc068dea0fc5bcfcf0b2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231206055317eucas1p204b75bda8cb2fc068dea0fc5bcfcf0b2
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
	<ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
	<4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
	<CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>
	<CGME20231206055317eucas1p204b75bda8cb2fc068dea0fc5bcfcf0b2@eucas1p2.samsung.com>
	<0450d705-3739-4b6d-a1f2-b22d54617de1@t-8ch.de>

--d4nggmrrrvv2zcqu
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 06:53:10AM +0100, Thomas Wei=C3=9Fschuh wrote:
> On 2023-12-05 14:50:01-0800, Luis Chamberlain wrote:
> > On Tue, Dec 5, 2023 at 2:41=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@wei=
ssschuh.net> wrote:
> > >
> > > On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> > > > On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Wei=C3=9Fschuh wro=
te:
> > > > > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir,=
 struct ctl_table_header *header)
> > > > >             return -EROFS;
> > > > >
> > > > >     /* Am I creating a permanently empty directory? */
> > > > > -   if (sysctl_is_perm_empty_ctl_header(header)) {
> > > > > +   if (header->ctl_table =3D=3D sysctl_mount_point ||
> > > > > +       sysctl_is_perm_empty_ctl_header(header)) {
> > > > >             if (!RB_EMPTY_ROOT(&dir->root))
> > > > >                     return -EINVAL;
> > > > >             sysctl_set_perm_empty_ctl_header(dir_h);
> > > >
> > > > While you're at it.
> > >
> > > This hunk is completely gone in v3/the code that you merged.
> >=20
> > It is worse in that it is not obvious:
> >=20
> > +       if (table =3D=3D sysctl_mount_point)
> > +               sysctl_set_perm_empty_ctl_header(head);
> >=20
> > > Which kind of unsafety do you envision here?
> >=20
> > Making the code obvious during patch review hy this is needed /
> > special, and if we special case this, why not remove enum, and make it
> > specific to only that one table. The catch is that it is not
> > immediately obvious that we actually call
> > sysctl_set_perm_empty_ctl_header() in other places, and it begs the
> > question if this can be cleaned up somehow.
>=20
> Making it specific won't work because the flag needs to be transferred
> from the leaf table to the table representing the directory.
>=20
> What do you think of the aproach taken in the attached patch?
> (On top of current sysctl-next, including my series)
What would this new patch be fixing again? I could not follow ?

Additionally, this might be another reason to set this patch aside :)

>=20
> Note: Current sysctl-next ist still based on v6.6.

> From 2fb9887fb2a5024c2620f2d694bc6dcc32afde67 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Thomas=3D20Wei=3DC3=3D9Fschuh?=3D <linux@weissschuh.net>
> Date: Wed, 6 Dec 2023 06:17:22 +0100
> Subject: [PATCH] sysctl: simplify handling of permanently empty directori=
es
>=20
> ---
>  fs/proc/proc_sysctl.c  | 76 +++++++++++++++++++-----------------------
>  include/linux/sysctl.h | 13 ++------
>  2 files changed, 36 insertions(+), 53 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index c92e9b972ada..c4d6d09b0e68 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -17,6 +17,7 @@
>  #include <linux/bpf-cgroup.h>
>  #include <linux/mount.h>
>  #include <linux/kmemleak.h>
> +#include <linux/cleanup.h>
>  #include "internal.h"
> =20
>  #define list_for_each_table_entry(entry, header)	\
> @@ -29,32 +30,6 @@ static const struct inode_operations proc_sys_inode_op=
erations;
>  static const struct file_operations proc_sys_dir_file_operations;
>  static const struct inode_operations proc_sys_dir_operations;
> =20
> -/* Support for permanently empty directories */
> -static const struct ctl_table sysctl_mount_point[] =3D {
> -	{ }
> -};
> -
> -/**
> - * register_sysctl_mount_point() - registers a sysctl mount point
> - * @path: path for the mount point
> - *
> - * Used to create a permanently empty directory to serve as mount point.
> - * There are some subtle but important permission checks this allows in =
the
> - * case of unprivileged mounts.
> - */
> -struct ctl_table_header *register_sysctl_mount_point(const char *path)
> -{
> -	return register_sysctl(path, sysctl_mount_point);
> -}
> -EXPORT_SYMBOL(register_sysctl_mount_point);
> -
> -#define sysctl_is_perm_empty_ctl_header(hptr)		\
> -	(hptr->type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
> -#define sysctl_set_perm_empty_ctl_header(hptr)		\
> -	(hptr->type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
> -#define sysctl_clear_perm_empty_ctl_header(hptr)		\
> -	(hptr->type =3D SYSCTL_TABLE_TYPE_DEFAULT)
> -
>  void proc_sys_poll_notify(struct ctl_table_poll *poll)
>  {
>  	if (!poll)
> @@ -199,8 +174,6 @@ static void init_header(struct ctl_table_header *head,
>  	head->set =3D set;
>  	head->parent =3D NULL;
>  	head->node =3D node;
> -	if (table =3D=3D sysctl_mount_point)
> -		sysctl_set_perm_empty_ctl_header(head);
>  	INIT_HLIST_HEAD(&head->inodes);
>  	if (node) {
>  		const struct ctl_table *entry;
> @@ -228,17 +201,9 @@ static int insert_header(struct ctl_dir *dir, struct=
 ctl_table_header *header)
> =20
> =20
>  	/* Is this a permanently empty directory? */
> -	if (sysctl_is_perm_empty_ctl_header(dir_h))
> +	if (dir->permanently_empty)
>  		return -EROFS;
> =20
> -	/* Am I creating a permanently empty directory? */
> -	if (header->ctl_table_size > 0 &&
> -	    sysctl_is_perm_empty_ctl_header(header)) {
> -		if (!RB_EMPTY_ROOT(&dir->root))
> -			return -EINVAL;
> -		sysctl_set_perm_empty_ctl_header(dir_h);
> -	}
> -
>  	dir_h->nreg++;
>  	header->parent =3D dir;
>  	err =3D insert_links(header);
> @@ -254,8 +219,6 @@ static int insert_header(struct ctl_dir *dir, struct =
ctl_table_header *header)
>  	erase_header(header);
>  	put_links(header);
>  fail_links:
> -	if (header->ctl_table =3D=3D sysctl_mount_point)
> -		sysctl_clear_perm_empty_ctl_header(dir_h);
>  	header->parent =3D NULL;
>  	drop_sysctl_table(dir_h);
>  	return err;
> @@ -442,6 +405,7 @@ static struct inode *proc_sys_make_inode(struct super=
_block *sb,
>  		struct ctl_table_header *head, const struct ctl_table *table)
>  {
>  	struct ctl_table_root *root =3D head->root;
> +	struct ctl_dir *ctl_dir;
>  	struct inode *inode;
>  	struct proc_inode *ei;
> =20
> @@ -475,7 +439,9 @@ static struct inode *proc_sys_make_inode(struct super=
_block *sb,
>  		inode->i_mode |=3D S_IFDIR;
>  		inode->i_op =3D &proc_sys_dir_operations;
>  		inode->i_fop =3D &proc_sys_dir_file_operations;
> -		if (sysctl_is_perm_empty_ctl_header(head))
> +
> +		ctl_dir =3D container_of(head, struct ctl_dir, header);
> +		if (ctl_dir->permanently_empty)
>  			make_empty_dir_inode(inode);
>  	}
> =20
> @@ -1214,8 +1180,7 @@ static bool get_links(struct ctl_dir *dir,
>  	struct ctl_table_header *tmp_head;
>  	const struct ctl_table *entry, *link;
> =20
> -	if (header->ctl_table_size =3D=3D 0 ||
> -	    sysctl_is_perm_empty_ctl_header(header))
> +	if (header->ctl_table_size =3D=3D 0 || dir->permanently_empty)
>  		return true;
> =20
>  	/* Are there links available for every entry in table? */
> @@ -1536,6 +1501,33 @@ void unregister_sysctl_table(struct ctl_table_head=
er * header)
>  }
>  EXPORT_SYMBOL(unregister_sysctl_table);
> =20
> +/**
> + * register_sysctl_mount_point() - registers a sysctl mount point
> + * @path: path for the mount point
> + *
> + * Used to create a permanently empty directory to serve as mount point.
> + * There are some subtle but important permission checks this allows in =
the
> + * case of unprivileged mounts.
> + */
> +struct ctl_table_header *register_sysctl_mount_point(const char *path)
> +{
> +	struct ctl_dir *dir =3D sysctl_mkdir_p(&sysctl_table_root.default_set.d=
ir, path);
> +
> +	if (IS_ERR(dir))
> +		return NULL;
> +
> +	guard(spinlock)(&sysctl_lock);
> +
> +	if (!RB_EMPTY_ROOT(&dir->root)) {
> +		drop_sysctl_table(&dir->header);
> +		return NULL;
> +	}
> +
> +	dir->permanently_empty =3D true;
> +	return &dir->header;
> +}
> +EXPORT_SYMBOL(register_sysctl_mount_point);
> +
>  void setup_sysctl_set(struct ctl_table_set *set,
>  	struct ctl_table_root *root,
>  	int (*is_seen)(struct ctl_table_set *))
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 7c96d5abafc7..329e68d484ed 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -177,23 +177,14 @@ struct ctl_table_header {
>  	struct ctl_dir *parent;
>  	struct ctl_node *node;
>  	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
> -	/**
> -	 * enum type - Enumeration to differentiate between ctl target types
> -	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
> -	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
> -	 *                                       empty directory target to serve
> -	 *                                       as mount point.
> -	 */
> -	enum {
> -		SYSCTL_TABLE_TYPE_DEFAULT,
> -		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
> -	} type;
>  };
> =20
>  struct ctl_dir {
>  	/* Header must be at the start of ctl_dir */
>  	struct ctl_table_header header;
>  	struct rb_root root;
> +	/* Permanently empty directory target to serve as mount point. */
> +	bool permanently_empty;
>  };
> =20
>  struct ctl_table_set {
>=20
> base-commit: a6fd07f80ab7bd94edb4d56c35e61117ffb9957e
> prerequisite-patch-id: 0000000000000000000000000000000000000000
> prerequisite-patch-id: 13932e9add940cb65c71e04b5efdfcd3622fd27e
> prerequisite-patch-id: 2e4d88f7b8aaa805598f0e87a3ea726825bb4264
> prerequisite-patch-id: 674a680d9cb138cd34cfd0e1a4ec3a5d1c220078
> prerequisite-patch-id: e27c92582aa20b1dfb122c172b336dbaf9d6508a
> prerequisite-patch-id: 9b409a34ab6a4d8d8c5225ba9a72db3116e3c8b3
> prerequisite-patch-id: 86ff15a81d850ebda16bb707491251f4b705e4fd
> prerequisite-patch-id: b7ab65512ac9acfb2dd482b0271b399467afc56d
> prerequisite-patch-id: 0354922fbf2508a89f3e9d9a4e274fc98deb2e93
> prerequisite-patch-id: b71389e82026ffc19cbb717bba1a014ad6cab6da
> prerequisite-patch-id: fbb0201f89bf6c41d0585af867bdeec8d51649b2
> prerequisite-patch-id: e3b4b5b69b4eadf87ed97beb8c03a471e7628cb9
> prerequisite-patch-id: 3fbc9745cf3f28872b3e63f6d1f6e2fd7598be8a
> prerequisite-patch-id: ba2b190c2e54cfb505a282e688c2222712f0acd7
> prerequisite-patch-id: 47e5ca730748bb7bf9248a9e711045d8c1028199
> prerequisite-patch-id: dcd9f87f00290d2f9be83e404f8883eb90c5fb1c
> prerequisite-patch-id: d4629be1a61585ab821da2d2850f246761f72f25
> prerequisite-patch-id: f740190f4b94e57cbf3659f220d94483713341a1
> prerequisite-patch-id: 301c2e530e2af4568267e19247d4a49ac2a9871d
> --=20
> 2.43.0
>=20


--=20

Joel Granados

--d4nggmrrrvv2zcqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmVxty0ACgkQupfNUreW
QU8yGwwAk7ywHUwwRfGWs21cjRCLdI5T1NnOx2lAHXEcgNlI8TfUlpyLib5YFdjL
1yCiAGv/KvdA89ubShvM6MFAwLPxbI4eGcBHjYJ/Y8FN04UG8ofXVaCETl0BD1Pv
YZVc/hOoa+CSWUzE3n2wl2TGhMJX5ErHP/+DMBWifWKhrJGtTnZaU+8dysM4QwBx
7Skisvwod83MOzWtfujgs0ZcQ6PENPVdtIpM+IS5Q0ju1F/hNp1K/SpgDXNe/xi2
UewuK5L9kOTE0YheqBek9RRc7aRLrbG7H0Gs1i9doeLVMXkqbN0rffoH9KkeJpsz
WEIpoGqDlxCwyPoNsZkETfriC9f+s7kXwcFIma8OS0s/TyJRnVeDghPofud8n5d1
u3uzckVkC739tgzNO/RenQNeQ/E4QTbF1Bh7FwbOAfiSM8g8uYLpoAbhvvxFB3qw
D3Hetx2byg5ONe3SamHqk2mAzGYtGTIjUU4XV7YsUeqTUbFluAQTpCVGUjrrycX0
fphlgwq4
=MduN
-----END PGP SIGNATURE-----

--d4nggmrrrvv2zcqu--

