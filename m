Return-Path: <linux-fsdevel+bounces-6821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CB481D3EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 13:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB0CB22E66
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 12:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15863D270;
	Sat, 23 Dec 2023 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QoAIVzbu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07688D263;
	Sat, 23 Dec 2023 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231223120856euoutp0199843cc172190c3baf0ba6a09203f4c2~jdKUkFGxT1016910169euoutp01l;
	Sat, 23 Dec 2023 12:08:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231223120856euoutp0199843cc172190c3baf0ba6a09203f4c2~jdKUkFGxT1016910169euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703333336;
	bh=PH+ZHU8Hn9lGG3o5Mi4CcaPVnxbpZopTzc4ek+K8mow=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QoAIVzbuf/HUF2TO8ZtNF/ZA1Pi6GS2X8HyNz4uG89ffVIoyDmmj3jDCxvg51MA1E
	 UiI+sqoVk/5UReQ/vg4bWi5joYU7UmPiizDoMvtDTuDQI2eJGHM5ibGJnaQ0HKOt3/
	 lTrJ7xu//ozkBMMK7xuZ+QveESJvGBqE1UePlBEA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231223120856eucas1p23144cb3b33604fed0fdc27652576ffe1~jdKUU_jJQ1288912889eucas1p2f;
	Sat, 23 Dec 2023 12:08:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id D2.53.09552.8DDC6856; Sat, 23
	Dec 2023 12:08:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231223120855eucas1p29f87830277caa577a176a84569d892c5~jdKTu6sKv0090500905eucas1p2f;
	Sat, 23 Dec 2023 12:08:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231223120855eusmtrp2a08aab3962fff0ccb568a45c1849d3e3~jdKTuUv9w1783217832eusmtrp2i;
	Sat, 23 Dec 2023 12:08:55 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-de-6586cdd8516b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 75.DC.09146.7DDC6856; Sat, 23
	Dec 2023 12:08:55 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231223120855eusmtip2b5fb0260e558ec4a90c55e77719d3306~jdKTc1ki63146931469eusmtip2c;
	Sat, 23 Dec 2023 12:08:55 +0000 (GMT)
Received: from localhost (106.210.248.246) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 23 Dec 2023 12:08:53 +0000
Date: Thu, 21 Dec 2023 13:09:19 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <20231221120919.pz3xhbzh7c57cjsb@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="mz7q3ojtw2mpusxe"
Content-Disposition: inline
In-Reply-To: <0450d705-3739-4b6d-a1f2-b22d54617de1@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87o3zralGuzfKWTRvHg9m8Wvi9NY
	Lc5051rs2XuSxWLe+p+MFpd3zWGz+P3jGZPFjQlPGS2W7fRz4PSY3XCRxWPBplKPTas62Tz2
	z13D7vF5k5xHf/cx9gC2KC6blNSczLLUIn27BK6MVQtb2QseRFasPPSNtYHxu2cXIyeHhICJ
	xPFpr9i7GLk4hARWMEqc6j/EBuF8YZS4PuMxM4TzmVHi3+LD7DAt/x7fYoVILGeU2HznDAtc
	1a6HtxkhnK2MEssXNLGAtLAIqErM//MazGYT0JE4/+YOM4gtImAjsfLbZ7DtzAK7mCSu7bsO
	ViQs4CVxY9pyRhCbV8BconXRX3YIW1Di5MwnYDXMAhUSL6dtB4pzANnSEsv/cYCEOYFmdpy9
	xgZxqrLEzV/vmCHsWolTW24xgeySEFjOKdGxZRnUPy4ST9rvQNnCEq+Ob4GyZST+75wP1TCZ
	UWL/vw/sEM5qRolljV+ZIKqsJVquPIHqcJR4MPEjK8hFEgJ8EjfeCkIcyicxadt0Zogwr0RH
	mxBEtZrE6ntvWCYwKs9C8tosJK/NQngNwtSUWL9LH0UUpFhbYtnC18wQtq3EunXvWRYwsq9i
	FE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITHOn/x3/uoNxxauPeocYmTgYDzGqADU/2rD6
	AqMUS15+XqqSCG++TkuqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQi
	mCwTB6dUA1ONWpiqi9ip17wvjCfzNZxZ/mddzKcNPPbnO+KfzXkQXMdXc7av5/gno2mXstd+
	5a/9ezJPaInt0pa0rWxBSXsDGd1T113asuX0wkDDqM2xuqIFTnrqWSu/xez6b9shcHTPRCHj
	XfJcTCEqARnez4qsj4Yafle6U3P40/N/VaVf3R4/EDVf6rPjfuq+mRNX7QsT3zvRc8fp3UVa
	u869dNXOteVUUOafYztnFq/lzI0+016eDjI/d6GQebpklPHWzS7fGu/qiATsYFHa4Xzby8Lz
	7plT6go5p6sii/mChO9WOz+bxv58x/QM3oun/d7oyTfGW9vzC/5QuHVKW/zzdKbbEw3LvF79
	447Rbr6YdlmJpTgj0VCLuag4EQAEpVcS7gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsVy+t/xe7rXz7alGsw6ombRvHg9m8Wvi9NY
	Lc5051rs2XuSxWLe+p+MFpd3zWGz+P3jGZPFjQlPGS2W7fRz4PSY3XCRxWPBplKPTas62Tz2
	z13D7vF5k5xHf/cx9gC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
	lNSczLLUIn27BL2Ml0dPshXci6xY8Te3gfGrZxcjJ4eEgInEv8e3WEFsIYGljBIn2tIg4jIS
	G79cZYWwhSX+XOti62LkAqr5yCixZ3srK4SzlVGi4/5uZpAqFgFVifl/XrOA2GwCOhLn39wB
	i4sI2Eis/PaZHaSBWWAXk8S1fdfBioQFvCRuTFvOCGLzCphLtC76yw4xdTWzxJa9r1ggEoIS
	J2c+AbOZBcokHlwGaeYAsqUllv/jAAlzAi3oOHuNDeJUZYmbv94xQ9i1Ep//PmOcwCg8C8mk
	WUgmzUKYBBFWl/gz7xIzhrC2xLKFr5khbFuJdevesyxgZF/FKJJaWpybnltsqFecmFtcmpeu
	l5yfu4kRGOnbjv3cvINx3quPeocYmTgYDzGqAHU+2rD6AqMUS15+XqqSCG++TkuqEG9KYmVV
	alF+fFFpTmrxIUZTYDBOZJYSTc4HpqC8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU
	1ILUIpg+Jg5OqQamja0Oh/Jv2jJtf766Y8Um449LwyQO6Gib5C9way6Vtvsy/UrxeSPmkI2d
	v+N2auiLX/3+dU/flccrIiJnNLG1v9H8vP/bGf4unw2xhswz73Wt/viWqUXUR/LnO/nFlirl
	cdsvZzAa+HOa37xptlXcZfK3mXU5DFuf6py8nrw9bPajpe+dExhmndg050TRYe3ADke+ZbnN
	gYaB9QlR99/P8NvBHVKT+u2jvH58DfNCvjhOnjmzgpkMLbwtzGZtezbx5Jy/xs9nntnAYNzk
	/zn8r3nkkcqgV3N/P6idvPmCzU92pROlrIYfTl5Y3cH6Vuf6lEzfTxPKgp/2ZTyMuXPNnIPD
	Iu3olVt6f5/bVT7fosRSnJFoqMVcVJwIAFuld2WJAwAA
X-CMS-MailID: 20231223120855eucas1p29f87830277caa577a176a84569d892c5
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

--mz7q3ojtw2mpusxe
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas.

I had some available cycles today and wanted to look at the patch that
you sent. I could not apply it on top of 6.7-rc6. Have you thought about
taking this out of your "constification" series and posting it as
something that comes before the const stuff?

Best

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

--mz7q3ojtw2mpusxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWEKucACgkQupfNUreW
QU/VIwv+MGbslYz3hF3smV7xbNBvh4QygWCUiRSwbjVj2uWTgV7xRLIZjh9nGp40
NCB9jJ5ToA9PGX/O/iAv2Hq0wCA16uAfg5/T9375NDpfbqIP35DvcK2GE49VH1KL
p7WrId5h2Y8bZm8VotxGQ0QuD5ZXKtTCFkeh+pwZ6UOvk07NK33+rcCJLTzIJss6
zENfbU+SPgi72Y7welB+Va1wLwOc2gdxDcECSLKOM9ggJViJUycE15USxB82XCZp
WYXeLUV9qGikZYcCef2waX7ie5a9H85X3/zAjIdGl5+DsXv4TsQuieMmrP6mvZ5p
H4xc6XEbNw7VJ5cMzjZbZoBbH7C9aZzjak+g7qgDb7SuQAVIV3/B7RSeKZKfMB8Q
Y8lQk/ToCcYEGLV2gPeslIxIKjxnWhL51UGi0AZp+QkWsqdBQLHBNaFsbAyiYcsJ
SkbZAVjGY5uuYoxeaC/zT/v9i52C8hfHp3xJvNRMXQyCKuii8M6f1qESs0FZBCCT
omM98lGV
=yTh+
-----END PGP SIGNATURE-----

--mz7q3ojtw2mpusxe--

