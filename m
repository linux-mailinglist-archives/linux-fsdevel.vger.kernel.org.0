Return-Path: <linux-fsdevel+bounces-5630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723880E716
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8DB1C213BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1215812F;
	Tue, 12 Dec 2023 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p8dxLXJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82703B7;
	Tue, 12 Dec 2023 01:09:37 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231212090934euoutp02d3eef28b8cf6a98597c5af816b6d2852~gCnkLCbm-2159121591euoutp02O;
	Tue, 12 Dec 2023 09:09:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231212090934euoutp02d3eef28b8cf6a98597c5af816b6d2852~gCnkLCbm-2159121591euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1702372174;
	bh=q4EEUekBdihC5jDBnn0jqjxa3SWoy9RXAeHNZigK24o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=p8dxLXJJLRaKEJ2pKMWuto/bs+iANeBz8r9YSfv8wtRcURba8OdZuYmwbGF/AwvrS
	 OvJuJxVkqCQqmS2IVYaUs17FawWFORldRdThngB49mXcTNcb2uaKZ1PcUSCB+pL3A8
	 vrnq7KSL96JvQbOgca+yV8pvp0GZ79RFawI9NmiI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231212090933eucas1p2596f15dba79d3259c991fc0abb1cdbf4~gCnj2hF6B2252022520eucas1p2g;
	Tue, 12 Dec 2023 09:09:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id F7.C3.09539.D4328756; Tue, 12
	Dec 2023 09:09:33 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231212090933eucas1p2abd4e1d5c44a63d8a3f64d7a423db75b~gCnjQw_hz0105101051eucas1p2O;
	Tue, 12 Dec 2023 09:09:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231212090933eusmtrp2a67242fc2e4d8827827115fc6342c3a7~gCnjQAdTi1168511685eusmtrp2W;
	Tue, 12 Dec 2023 09:09:33 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-97-6578234dfac5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id FA.9D.09146.C4328756; Tue, 12
	Dec 2023 09:09:32 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231212090932eusmtip21e63205a507d93e0b50044f019f4be80~gCni-VbA50118601186eusmtip2U;
	Tue, 12 Dec 2023 09:09:32 +0000 (GMT)
Received: from localhost (106.210.248.229) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 12 Dec 2023 09:09:32 +0000
Date: Tue, 12 Dec 2023 10:09:30 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <20231212090930.y4omk62wenxgo5by@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="bajep7m7q7cnatws"
Content-Disposition: inline
In-Reply-To: <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djPc7q+yhWpBjO+qlk0L17PZvHr4jRW
	izPduRZ79p5ksZi3/iejxeVdc9gsfv94xmRxY8JTRotlO/0cOD1mN1xk8ViwqdRj06pONo/9
	c9ewe3zeJOfR332MPYAtissmJTUnsyy1SN8ugSvjWqNkwZKQivZPvg2M9126GDk5JARMJLon
	v2fuYuTiEBJYwSgxa3MbE4TzhVFiUesiqMxnRon3l6+xw7Sc2/KZESKxnFFiZd92Friq7i0d
	UJmtjBInbj1gAWlhEVCVeHh6GZjNJqAjcf7NHWYQW0TARmLlt8/sIA3MAruYJB4/nAu0nYND
	WMBBYluTJEgNr4C5xNe+B2wQtqDEyZlPwOYwC1RI9HzpYQYpZxaQllj+jwMkzAk08vysFUwQ
	lypL9C+dwwph10qc2nIL7DcJgdWcEi9/gRwKknCR+Hv0NhuELSzx6vgWqDdlJP7vnA/VMJlR
	Yv+/D+xQ3YwSyxq/Qq2wlmi58gSqw1Fi3dylrCAXSQjwSdx4KwhxKJ/EpG3TmSHCvBIdbUIQ
	1WoSq++9YZnAqDwLyWuzkLw2C+E1iLCexI2pU9gwhLUlli18zQxh20qsW/eeZQEj+ypG8dTS
	4tz01GLDvNRyveLE3OLSvHS95PzcTYzAFHf63/FPOxjnvvqod4iRiYPxEKMKUPOjDasvMEqx
	5OXnpSqJ8J7cUZ4qxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvE
	wSnVwGTtvnPvj7n7WNYo3y5qrmWrjohg3FbyalbN8eVtU0w+Fi6vvfT4+amS3sabe9XM5p04
	bOl371SCcJ2BclJp2z/zVadenVwpxfdEUXHC8mP32HQsLD94eWbcnRj5ul9SxP/Yt5DAhYpf
	zD91rnTM3ThX4eS/XLPnEaeWHVT25JVsmWOgGF1Ud+3+fauXC7d+rE/dfDL7sdZr2/AHU1Z6
	6fSrBqyQMfmUk7trApPLBt640h1rLVq+hwmxHd/Gx5gnHSE5t0lhoRV3n53BEd2pfZ+XuTxs
	O++XPbvmtKmZlX/2ytnT1feGd93/oW8w48m85595Hlgynhb5Up/+PaR362qPb+z2Tv99/ftv
	t8TOP6/EUpyRaKjFXFScCAD+VRV57AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsVy+t/xe7o+yhWpBu2fbSyaF69ns/h1cRqr
	xZnuXIs9e0+yWMxb/5PR4vKuOWwWv388Y7K4MeEpo8WynX4OnB6zGy6yeCzYVOqxaVUnm8f+
	uWvYPT5vkvPo7z7GHsAWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
	kpqTWZZapG+XoJfx4N9D5oJFIRW3p85gbmC869LFyMkhIWAicW7LZ8YuRi4OIYGljBKH72xm
	g0jISGz8cpUVwhaW+HOtiw2i6COjxPydp1khnK2MEr8OPWICqWIRUJV4eHoZC4jNJqAjcf7N
	HWYQW0TARmLlt8/sIA3MAruYJB4/nAvUwMEhLOAgsa1JEqSGV8Bc4mvfA6gNN5gkrmw7zASR
	EJQ4OfMJ2FBmgTKJJfv62UF6mQWkJZb/4wAJcwLNPz9rBRPEpcoS/UvnQF1dK/H57zPGCYzC
	s5BMmoVk0iyESRBhHYmdW++wYQhrSyxb+JoZwraVWLfuPcsCRvZVjCKppcW56bnFhnrFibnF
	pXnpesn5uZsYgbG+7djPzTsY5736qHeIkYmD8RCjClDnow2rLzBKseTl56UqifCe3FGeKsSb
	klhZlVqUH19UmpNafIjRFBiKE5mlRJPzgUkoryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2x
	JDU7NbUgtQimj4mDU6qBaUamimYM8wOJorfucZ4/48+yvrY7drDO22TThdnNF9cHtHE8YN0T
	JPrJpvXPxZuFa29riLRvtsv9d53D/8T56/mdyTXXN03kiT6x8d3xpLbj23fO42S9eujPFi81
	0RJuL14lruZatiAXI+dkhp05VTrXprkudhaLDlzd8UDYxbZ6gopUo2bHwVVHLdLMPwlOf+A7
	X5Etc8la38ITtly/NRVnWZ6fWNJrv6fk4dr5ro6ClYzadzJsd+j+9WoP761ue1tXcNztCuvc
	swcmP2x8pLg/9NaEtHV7V2SxdJT6yR43eFszy+qvhEO25P33QZ/OzF/k9pQv42tazjI1zufP
	DF5P3LZ0u9/6qa8dY7zfKbEUZyQaajEXFScCAAraxC2KAwAA
X-CMS-MailID: 20231212090933eucas1p2abd4e1d5c44a63d8a3f64d7a423db75b
X-Msg-Generator: CA
X-RootMTR: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
	<20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
	<20231207104357.kndqvzkhxqkwkkjo@localhost>
	<fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
	<20231208095926.aavsjrtqbb5rygmb@localhost>
	<8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>

--bajep7m7q7cnatws
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:25:10PM +0100, Thomas Wei=DFschuh wrote:
> On 2023-12-08 10:59:26+0100, Joel Granados wrote:
> > On Thu, Dec 07, 2023 at 08:19:43PM +0100, Thomas Wei=DFschuh wrote:
> > > On 2023-12-07 11:43:57+0100, Joel Granados wrote:
>=20
> > [..]
>=20
> > > > I suggest you chunk it up with directories in mind. Something simil=
ar to
> > > > what I did for [4] where I divided stuff that when for fs/*, kernel=
/*,
> > > > net/*, arch/* and drivers/*. That will complicate your patch a tad
> > > > because you have to ensure that the tree can be compiled/run for ev=
ery
> > > > commit. But it will pay off once you push it to the broader public.
> > >=20
> > > This will break bisections. All function signatures need to be switch=
ed
>=20
> > I was suggesting a solution without breaking bisections of course. I can
> > think of a couple of ways to do this in chunks but it might be
> > premature. You can send it and if you get push back because of this then
> > we can deal with chunking it down.
>=20
> I'm curious about those ways. I don't see how to split the big commit.
My idea was to do something similar to your originl RFC, where you have
an temporary proc_handler something like proc_hdlr_const (we would need
to work on the name) and move each subsystem to the new handler while
the others stay with the non-const one. At the end, the old proc_handler
function name would disapear and would be completely replaced by the new
proc_hdlr_const.

This is of course extra work and might not be worth it if you don't get
negative feedback related to tree-wide changes. Therefore I stick to my
previous suggestion. Send the big tree-wide patches and only explore
this option if someone screams.
>=20
> > I'm still concerned about the header size for those mails. How does the
> > mail look like when you run the get maintainers script on it?
>=20
> The full series has 142 recipients in total,
> the biggest patch itself has 124.
This seems low. might just be enough to make into the lists that have
the check.

In any case it depends on the size of the header; if it is greater than
8912 you get a message back similar to this one:
"linux-raid-owne ( 22K) BOUNCE linux-raid@vger.kernel.org: Header field too=
 long (>8192)"

>=20
> Before sending it I'd like to get feedback on the internal rework of the
> is_empty detection from you and/or Luis.
Yep, this is still on my todo. With holidays just around the corner,
I'll be a bit slower to get to it. I'll eventually get to it if someone
else does not beat me to it :)

Thx for reminding me.
>=20
> https://git.sr.ht/~t-8ch/linux/commit/ea27507070f3c47be6febebe451bbb88f6e=
a707e
> or the attached patch.
>=20
> > [..]

> From ea27507070f3c47be6febebe451bbb88f6ea707e Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Thomas=3D20Wei=3DC3=3D9Fschuh?=3D <linux@weissschuh.net>
> Date: Sun, 3 Dec 2023 21:56:46 +0100
> Subject: [PATCH] sysctl: move permanently empty flag to ctl_dir
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Simplify the logic by always keeping the permanently_empty flag on the
> ctl_dir.
> The previous logic kept the flag in the leaf ctl_table and from there
> transferred it to the ctl_table from the directory.
>=20
> This also removes the need to have a mutable ctl_table and will allow
> the constification of those structs.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_sysctl.c  | 74 +++++++++++++++++++-----------------------
>  include/linux/sysctl.h | 13 ++------
>  2 files changed, 36 insertions(+), 51 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 35c97ad54f34..33f41af58e9b 100644
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
> -static struct ctl_table sysctl_mount_point[] =3D {
> -	{.type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY }
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
> -	(hptr->ctl_table[0].type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
> -#define sysctl_set_perm_empty_ctl_header(hptr)		\
> -	(hptr->ctl_table[0].type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
> -#define sysctl_clear_perm_empty_ctl_header(hptr)	\
> -	(hptr->ctl_table[0].type =3D SYSCTL_TABLE_TYPE_DEFAULT)
> -
>  void proc_sys_poll_notify(struct ctl_table_poll *poll)
>  {
>  	if (!poll)
> @@ -226,17 +201,9 @@ static int insert_header(struct ctl_dir *dir, struct=
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
> @@ -252,8 +219,6 @@ fail:
>  	erase_header(header);
>  	put_links(header);
>  fail_links:
> -	if (header->ctl_table =3D=3D sysctl_mount_point)
> -		sysctl_clear_perm_empty_ctl_header(dir_h);
>  	header->parent =3D NULL;
>  	drop_sysctl_table(dir_h);
>  	return err;
> @@ -440,6 +405,7 @@ static struct inode *proc_sys_make_inode(struct super=
_block *sb,
>  		struct ctl_table_header *head, struct ctl_table *table)
>  {
>  	struct ctl_table_root *root =3D head->root;
> +	struct ctl_dir *ctl_dir;
>  	struct inode *inode;
>  	struct proc_inode *ei;
> =20
> @@ -473,7 +439,9 @@ static struct inode *proc_sys_make_inode(struct super=
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
> @@ -1211,8 +1179,7 @@ static bool get_links(struct ctl_dir *dir,
>  	struct ctl_table_header *tmp_head;
>  	struct ctl_table *entry, *link;
> =20
> -	if (header->ctl_table_size =3D=3D 0 ||
> -	    sysctl_is_perm_empty_ctl_header(header))
> +	if (header->ctl_table_size =3D=3D 0 || dir->permanently_empty)
>  		return true;
> =20
>  	/* Are there links available for every entry in table? */
> @@ -1533,6 +1500,33 @@ void unregister_sysctl_table(struct ctl_table_head=
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
> index ada36ef8cecb..57cb0060d7d7 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -137,17 +137,6 @@ struct ctl_table {
>  	void *data;
>  	int maxlen;
>  	umode_t mode;
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
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;
>  	void *extra1;
> @@ -194,6 +183,8 @@ struct ctl_dir {
>  	/* Header must be at the start of ctl_dir */
>  	struct ctl_table_header header;
>  	struct rb_root root;
> +	/* Permanently empty directory target to serve as mount point. */
> +	bool permanently_empty;
>  };
> =20
>  struct ctl_table_set {
> --=20
> 2.38.5
>=20


--=20

Joel Granados

--bajep7m7q7cnatws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmV4I0gACgkQupfNUreW
QU+iHQv/Qmc2pTVbDBQSukmNb6rfi+NDjiw7YWYgUHfyO+LRxDrYuFAwRAd0qMKd
R7+SoOeGfQNq/65lQczZMOZVKd5WLXnjaixeheymNTseMgZY97kxICO+YJWPNn0z
omBTJYd7RMQXrNgu7e5nA0vRWkaltzjEbntyqcbdlnpKgw0kqoWzb9mdZww+jy5c
h9rMXFSI6bnY8kEzmVZIMDeSKXROxwKqI/gMUece9SlzqwUC3atZVHDnDGLNTjXq
3r28QEHOEJVRH2i4FnWz+ruYxt7XITpRvU7Z6e/jHmulfnbtLffDvFRgkwOEl0PL
/k/+RQ3H6wcrjFLTd9M1vMTUYElwxE5sKyvJ79ZPQTptoRgXL4pwPnWs6na9IxI0
kQXSs8UTqznDAU2D/HMLitf54hlVJJ7sjHoWWDUEzJlqnPSM5gMj3mLvbYOrTxPk
0/eY1OuEzl1/7ogBfApqBA9H77r3NaUEe2hnNSkpUb2oNhVNIKzuqAiDJ+AcGCbO
XOD8wDOJ
=hkDK
-----END PGP SIGNATURE-----

--bajep7m7q7cnatws--

