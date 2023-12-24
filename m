Return-Path: <linux-fsdevel+bounces-6875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E681DC00
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 19:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5C21C21147
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23621D2E2;
	Sun, 24 Dec 2023 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oQcEQYMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F66DDA8;
	Sun, 24 Dec 2023 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231224185128euoutp02de7af0a96e7dd2a3ea3299551be7769e~j2TEZ-mCF2270122701euoutp02P;
	Sun, 24 Dec 2023 18:51:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231224185128euoutp02de7af0a96e7dd2a3ea3299551be7769e~j2TEZ-mCF2270122701euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703443889;
	bh=2ZowdMw1MLw2+lZXKpbVWU89GqQM9EF8adeiHlNZmGY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oQcEQYMOqJxdiPqlvC5n0WXfjAbhSLlJYkNIYEyiKOFPUv8OGfyPVdlO2ntIhNAk2
	 YAUqY43iMF8bbzKPtMEPL7VEm9GuU6QmAPxCQ9yNDwI2u1S+iwx4O/57NIt8gzs4x6
	 pZMoMRurkObVImvDp1m0G1Ac7WHUAvCFi2+65Q/U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231224185127eucas1p231352640890ff5f47dc1c8e69bc9fe38~j2TDJhd3a1178711787eucas1p2m;
	Sun, 24 Dec 2023 18:51:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.3C.09539.FAD78856; Sun, 24
	Dec 2023 18:51:27 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231224185126eucas1p19a00b3bdb709b46603ca0068c7372daf~j2TCT_wtg1215212152eucas1p1t;
	Sun, 24 Dec 2023 18:51:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231224185126eusmtrp17e33e99eb56128cd1a6b46bf4cb03944~j2TCTZEvI2061620616eusmtrp1O;
	Sun, 24 Dec 2023 18:51:26 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-9d-65887daf0a48
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.63.09274.EAD78856; Sun, 24
	Dec 2023 18:51:26 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231224185126eusmtip2db07a668298f86ad40714f4b470ac109~j2TCF8N6j3209832098eusmtip2c;
	Sun, 24 Dec 2023 18:51:26 +0000 (GMT)
Received: from localhost (106.210.248.246) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 24 Dec 2023 18:51:25 +0000
Date: Sun, 24 Dec 2023 19:51:21 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Iurii Zaikin
	<yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <20231224185121.kzb3a2ceuaygvw45@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="4kzvc3bji6c3orpp"
Content-Disposition: inline
In-Reply-To: <930d06d4-ece0-4b75-b7ce-dba486a0d404@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87rraztSDe5dU7BoXryezeLXxWms
	Fme6cy327D3JYjFv/U9Gi8u75rBZ/P7xjMnixoSnjBbLdvo5cHrMbrjI4rFgU6nHplWdbB77
	565h9/i8Sc6jv/sYewBbFJdNSmpOZllqkb5dAlfG58WfmApmZFX8/LybrYFxS0gXIyeHhICJ
	xLFXexhBbCGBFYwSE+dodTFyAdlfGCW2XLzCDuF8ZpSY37OeCabjfdNEqMRyRoneXwsZ4aru
	zpwLldnKKLFtwydmkBYWAVWJ/Z9awWw2AR2J82/ugNkiAjYSK799BmtgFtjFJHFt33UWkISw
	gJfEjWnLwa7iFTCX+Ln0NDOELShxcuYTsBpmgQqJC5vPAt3EAWRLSyz/xwES5gSauf5tOyPE
	qcoSN3+9Y4awayVObbnFBLJLQmA1p8T6nlaoIheJow/72SBsYYlXx7ewQ9gyEqcn97BANExm
	lNj/7wM7VDejxLLGr9DQsJZoufIEqsNR4sHEj6wgF0kI8EnceCsIcSifxKRt05khwrwSHW1C
	ENVqEqvvvWGZwKg8C8lrs5C8NgvhNQhTU2L9Ln0UUZBibYllC18zQ9i2EuvWvWdZwMi+ilE8
	tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzDJnf53/NMOxrmvPuodYmTiYDzEqALU/GjD6guM
	Uix5+XmpSiK8soodqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5VVPkU4UE0hNLUrNTUwtSi2Cy
	TBycUg1MeiwnxVfeNM/ja2K4sGeLvYhhkO8E4yWXN78s7kqZW93swZaQE3jyQFVPusRTTv2b
	+7beFNQ3erv1eX1J0l2P5oZZS5tenHSQ//K7dMP7HQFcVdztkqUCPu/fSCt8vOL+T2/+w3/L
	NNeFLrzy4fFJ9tOvfpz8OF/CSN3434Tu11vWHJ3Ou1OTh2nFDEnLLuYjRQb88Tcb5GZEaR5s
	rBVv/2dW6Bg56efv4MjVxxg0FquULn1Rd3CFssQf2S/R99sy9Jzfc925UyCZNfmfu2p25aU3
	jS8DHyV1CVy71MF+ZfbuRRs0jJkEL9s1v29iVdW78Cei9MJF174ZEaynmC4emFTP9evVn5UL
	Vs8s5rD8qMRSnJFoqMVcVJwIAJjw+KXtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7rrajtSDaY3qFk0L17PZvHr4jRW
	izPduRZ79p5ksZi3/iejxeVdc9gsfv94xmRxY8JTRotlO/0cOD1mN1xk8ViwqdRj06pONo/9
	c9ewe3zeJOfR332MPYAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
	JTUnsyy1SN8uQS9j/7ZO5oJpWRVzdh1naWDcFNLFyMkhIWAi8b5pInsXIxeHkMBSRommbVNY
	IRIyEhu/XIWyhSX+XOtigyj6yCjxdVkvE4SzlVFia9tZRpAqFgFVif2fWplBbDYBHYnzb+6A
	2SICNhIrv30GW8EssItJ4tq+6ywgCWEBL4kb05aDNfMKmEv8XHqaGWJqN4vE8cfLmCASghIn
	Zz4Ba2AWKJP4feYYUAMHkC0tsfwfB0iYE2jB+rftjBCnKkvc/PWOGcKulfj89xnjBEbhWUgm
	zUIyaRbCJIiwusSfeZeYMYS1JZYtfM0MYdtKrFv3nmUBI/sqRpHU0uLc9NxiI73ixNzi0rx0
	veT83E2MwGjfduznlh2MK1991DvEyMTBeIhRBajz0YbVFxilWPLy81KVRHhlFTtShXhTEiur
	Uovy44tKc1KLDzGaAoNxIrOUaHI+MA3llcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGan
	phakFsH0MXFwSjUwqb/hLvnVvEvslQBboejs/xdMOH4eEmCavuPnNwVXqX6T7k+reL99UpXz
	6M3UtGJQXTuTpXDWmY3J204eDVy55NxP4YoLfl6FCdd0Hp9ZEWJ/zHLL3rR1LLMMdy18zSjD
	/1VTco/pcd1fpt+92j7ZJK3WLngwY6uwxLL0wB//QuMPNAi5L715bsmarY+efQ1s79f5cvSo
	VO47Sda9q5brvXgj0CW341+QfW/rLW0nfq2sTZPEVO/Z9k/rSPjew3slaOO+pwXBPM0fZ5if
	WfV3f/UUI47Ej7dirIXerhOymr50jvw73seCr24qrm1S4VyyjNmBYd6GhX2cz1z/bvzl7jP7
	xaUTkxRyDWP328coP1RiKc5INNRiLipOBACJLldUiwMAAA==
X-CMS-MailID: 20231224185126eucas1p19a00b3bdb709b46603ca0068c7372daf
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
	<20231221120919.pz3xhbzh7c57cjsb@localhost>
	<930d06d4-ece0-4b75-b7ce-dba486a0d404@t-8ch.de>

--4kzvc3bji6c3orpp
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 02:04:27PM +0100, Thomas Wei=C3=9Fschuh wrote:
> Hi Joel,
>=20
> On 2023-12-21 13:09:19+0100, Joel Granados wrote:
> > I had some available cycles today and wanted to look at the patch that
> > you sent. I could not apply it on top of 6.7-rc6. Have you thought about
> > taking this out of your "constification" series and posting it as
> > something that comes before the const stuff?
>=20
> Yes, I am planning to submit this standalone. But I need to do some more
> investigation to properly handle the existing comments.
Understood.

>=20
> FYI this out-of-series patch is meant to be applied on top of the rest
> of the series.
Ok.

>=20
>=20
> Another question:
>=20
> When did you write this mail?
>=20
> The Date header says it's from the 21st but I only received it today
> (the 23rd). All other mail headers also say that it was only sent on
> 23rd. The same seems to happen with your other mails, too.
Sometimes I do the review even if I don't have connection. Everything
goes out once I get back on the network.

So there is the timestamp of when I "sent" but was on standby in my
outgoing mails 21st. And then the actual sending occurred some days
later when I was back on the network.

>=20
> Thomas
>=20
> > On Wed, Dec 06, 2023 at 06:53:10AM +0100, Thomas Wei=C3=9Fschuh wrote:
> > > On 2023-12-05 14:50:01-0800, Luis Chamberlain wrote:
> > > > On Tue, Dec 5, 2023 at 2:41=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux=
@weissschuh.net> wrote:
> > > > >
> > > > > On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> > > > > > On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Wei=C3=9Fschuh=
 wrote:
> > > > > > > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *=
dir, struct ctl_table_header *header)
> > > > > > >             return -EROFS;
> > > > > > >
> > > > > > >     /* Am I creating a permanently empty directory? */
> > > > > > > -   if (sysctl_is_perm_empty_ctl_header(header)) {
> > > > > > > +   if (header->ctl_table =3D=3D sysctl_mount_point ||
> > > > > > > +       sysctl_is_perm_empty_ctl_header(header)) {
> > > > > > >             if (!RB_EMPTY_ROOT(&dir->root))
> > > > > > >                     return -EINVAL;
> > > > > > >             sysctl_set_perm_empty_ctl_header(dir_h);
> > > > > >
> > > > > > While you're at it.
> > > > >
> > > > > This hunk is completely gone in v3/the code that you merged.
> > > >=20
> > > > It is worse in that it is not obvious:
> > > >=20
> > > > +       if (table =3D=3D sysctl_mount_point)
> > > > +               sysctl_set_perm_empty_ctl_header(head);
> > > >=20
> > > > > Which kind of unsafety do you envision here?
> > > >=20
> > > > Making the code obvious during patch review hy this is needed /
> > > > special, and if we special case this, why not remove enum, and make=
 it
> > > > specific to only that one table. The catch is that it is not
> > > > immediately obvious that we actually call
> > > > sysctl_set_perm_empty_ctl_header() in other places, and it begs the
> > > > question if this can be cleaned up somehow.
> > >=20
> > > Making it specific won't work because the flag needs to be transferred
> > > from the leaf table to the table representing the directory.
> > >=20
> > > What do you think of the aproach taken in the attached patch?
> > > (On top of current sysctl-next, including my series)
> > >=20
> > > Note: Current sysctl-next ist still based on v6.6.
> >=20
> > > From 2fb9887fb2a5024c2620f2d694bc6dcc32afde67 Mon Sep 17 00:00:00 2001
> > > From: =3D?UTF-8?q?Thomas=3D20Wei=3DC3=3D9Fschuh?=3D <linux@weissschuh=
=2Enet>
> > > Date: Wed, 6 Dec 2023 06:17:22 +0100
> > > Subject: [PATCH] sysctl: simplify handling of permanently empty direc=
tories
> > >=20
> > > ---
> > >  fs/proc/proc_sysctl.c  | 76 +++++++++++++++++++---------------------=
--
> > >  include/linux/sysctl.h | 13 ++------
> > >  2 files changed, 36 insertions(+), 53 deletions(-)
> > >=20
> > > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > index c92e9b972ada..c4d6d09b0e68 100644
> > > --- a/fs/proc/proc_sysctl.c
> > > +++ b/fs/proc/proc_sysctl.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/bpf-cgroup.h>
> > >  #include <linux/mount.h>
> > >  #include <linux/kmemleak.h>
> > > +#include <linux/cleanup.h>
> > >  #include "internal.h"
> > > =20
> > >  #define list_for_each_table_entry(entry, header)	\
> > > @@ -29,32 +30,6 @@ static const struct inode_operations proc_sys_inod=
e_operations;
> > >  static const struct file_operations proc_sys_dir_file_operations;
> > >  static const struct inode_operations proc_sys_dir_operations;
> > > =20
> > > -/* Support for permanently empty directories */
> > > -static const struct ctl_table sysctl_mount_point[] =3D {
> > > -	{ }
> > > -};
> > > -
> > > -/**
> > > - * register_sysctl_mount_point() - registers a sysctl mount point
> > > - * @path: path for the mount point
> > > - *
> > > - * Used to create a permanently empty directory to serve as mount po=
int.
> > > - * There are some subtle but important permission checks this allows=
 in the
> > > - * case of unprivileged mounts.
> > > - */
> > > -struct ctl_table_header *register_sysctl_mount_point(const char *pat=
h)
> > > -{
> > > -	return register_sysctl(path, sysctl_mount_point);
> > > -}
> > > -EXPORT_SYMBOL(register_sysctl_mount_point);
> > > -
> > > -#define sysctl_is_perm_empty_ctl_header(hptr)		\
> > > -	(hptr->type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
> > > -#define sysctl_set_perm_empty_ctl_header(hptr)		\
> > > -	(hptr->type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
> > > -#define sysctl_clear_perm_empty_ctl_header(hptr)		\
> > > -	(hptr->type =3D SYSCTL_TABLE_TYPE_DEFAULT)
> > > -
> > >  void proc_sys_poll_notify(struct ctl_table_poll *poll)
> > >  {
> > >  	if (!poll)
> > > @@ -199,8 +174,6 @@ static void init_header(struct ctl_table_header *=
head,
> > >  	head->set =3D set;
> > >  	head->parent =3D NULL;
> > >  	head->node =3D node;
> > > -	if (table =3D=3D sysctl_mount_point)
> > > -		sysctl_set_perm_empty_ctl_header(head);
> > >  	INIT_HLIST_HEAD(&head->inodes);
> > >  	if (node) {
> > >  		const struct ctl_table *entry;
> > > @@ -228,17 +201,9 @@ static int insert_header(struct ctl_dir *dir, st=
ruct ctl_table_header *header)
> > > =20
> > > =20
> > >  	/* Is this a permanently empty directory? */
> > > -	if (sysctl_is_perm_empty_ctl_header(dir_h))
> > > +	if (dir->permanently_empty)
> > >  		return -EROFS;
> > > =20
> > > -	/* Am I creating a permanently empty directory? */
> > > -	if (header->ctl_table_size > 0 &&
> > > -	    sysctl_is_perm_empty_ctl_header(header)) {
> > > -		if (!RB_EMPTY_ROOT(&dir->root))
> > > -			return -EINVAL;
> > > -		sysctl_set_perm_empty_ctl_header(dir_h);
> > > -	}
> > > -
> > >  	dir_h->nreg++;
> > >  	header->parent =3D dir;
> > >  	err =3D insert_links(header);
> > > @@ -254,8 +219,6 @@ static int insert_header(struct ctl_dir *dir, str=
uct ctl_table_header *header)
> > >  	erase_header(header);
> > >  	put_links(header);
> > >  fail_links:
> > > -	if (header->ctl_table =3D=3D sysctl_mount_point)
> > > -		sysctl_clear_perm_empty_ctl_header(dir_h);
> > >  	header->parent =3D NULL;
> > >  	drop_sysctl_table(dir_h);
> > >  	return err;
> > > @@ -442,6 +405,7 @@ static struct inode *proc_sys_make_inode(struct s=
uper_block *sb,
> > >  		struct ctl_table_header *head, const struct ctl_table *table)
> > >  {
> > >  	struct ctl_table_root *root =3D head->root;
> > > +	struct ctl_dir *ctl_dir;
> > >  	struct inode *inode;
> > >  	struct proc_inode *ei;
> > > =20
> > > @@ -475,7 +439,9 @@ static struct inode *proc_sys_make_inode(struct s=
uper_block *sb,
> > >  		inode->i_mode |=3D S_IFDIR;
> > >  		inode->i_op =3D &proc_sys_dir_operations;
> > >  		inode->i_fop =3D &proc_sys_dir_file_operations;
> > > -		if (sysctl_is_perm_empty_ctl_header(head))
> > > +
> > > +		ctl_dir =3D container_of(head, struct ctl_dir, header);
> > > +		if (ctl_dir->permanently_empty)
> > >  			make_empty_dir_inode(inode);
> > >  	}
> > > =20
> > > @@ -1214,8 +1180,7 @@ static bool get_links(struct ctl_dir *dir,
> > >  	struct ctl_table_header *tmp_head;
> > >  	const struct ctl_table *entry, *link;
> > > =20
> > > -	if (header->ctl_table_size =3D=3D 0 ||
> > > -	    sysctl_is_perm_empty_ctl_header(header))
> > > +	if (header->ctl_table_size =3D=3D 0 || dir->permanently_empty)
> > >  		return true;
> > > =20
> > >  	/* Are there links available for every entry in table? */
> > > @@ -1536,6 +1501,33 @@ void unregister_sysctl_table(struct ctl_table_=
header * header)
> > >  }
> > >  EXPORT_SYMBOL(unregister_sysctl_table);
> > > =20
> > > +/**
> > > + * register_sysctl_mount_point() - registers a sysctl mount point
> > > + * @path: path for the mount point
> > > + *
> > > + * Used to create a permanently empty directory to serve as mount po=
int.
> > > + * There are some subtle but important permission checks this allows=
 in the
> > > + * case of unprivileged mounts.
> > > + */
> > > +struct ctl_table_header *register_sysctl_mount_point(const char *pat=
h)
> > > +{
> > > +	struct ctl_dir *dir =3D sysctl_mkdir_p(&sysctl_table_root.default_s=
et.dir, path);
> > > +
> > > +	if (IS_ERR(dir))
> > > +		return NULL;
> > > +
> > > +	guard(spinlock)(&sysctl_lock);
> > > +
> > > +	if (!RB_EMPTY_ROOT(&dir->root)) {
> > > +		drop_sysctl_table(&dir->header);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	dir->permanently_empty =3D true;
> > > +	return &dir->header;
> > > +}
> > > +EXPORT_SYMBOL(register_sysctl_mount_point);
> > > +
> > >  void setup_sysctl_set(struct ctl_table_set *set,
> > >  	struct ctl_table_root *root,
> > >  	int (*is_seen)(struct ctl_table_set *))
> > > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > > index 7c96d5abafc7..329e68d484ed 100644
> > > --- a/include/linux/sysctl.h
> > > +++ b/include/linux/sysctl.h
> > > @@ -177,23 +177,14 @@ struct ctl_table_header {
> > >  	struct ctl_dir *parent;
> > >  	struct ctl_node *node;
> > >  	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
> > > -	/**
> > > -	 * enum type - Enumeration to differentiate between ctl target types
> > > -	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considera=
tions
> > > -	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permane=
ntly
> > > -	 *                                       empty directory target to =
serve
> > > -	 *                                       as mount point.
> > > -	 */
> > > -	enum {
> > > -		SYSCTL_TABLE_TYPE_DEFAULT,
> > > -		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
> > > -	} type;
> > >  };
> > > =20
> > >  struct ctl_dir {
> > >  	/* Header must be at the start of ctl_dir */
> > >  	struct ctl_table_header header;
> > >  	struct rb_root root;
> > > +	/* Permanently empty directory target to serve as mount point. */
> > > +	bool permanently_empty;
> > >  };
> > > =20
> > >  struct ctl_table_set {
> > >=20
> > > base-commit: a6fd07f80ab7bd94edb4d56c35e61117ffb9957e
> > > prerequisite-patch-id: 0000000000000000000000000000000000000000
> > > prerequisite-patch-id: 13932e9add940cb65c71e04b5efdfcd3622fd27e
> > > prerequisite-patch-id: 2e4d88f7b8aaa805598f0e87a3ea726825bb4264
> > > prerequisite-patch-id: 674a680d9cb138cd34cfd0e1a4ec3a5d1c220078
> > > prerequisite-patch-id: e27c92582aa20b1dfb122c172b336dbaf9d6508a
> > > prerequisite-patch-id: 9b409a34ab6a4d8d8c5225ba9a72db3116e3c8b3
> > > prerequisite-patch-id: 86ff15a81d850ebda16bb707491251f4b705e4fd
> > > prerequisite-patch-id: b7ab65512ac9acfb2dd482b0271b399467afc56d
> > > prerequisite-patch-id: 0354922fbf2508a89f3e9d9a4e274fc98deb2e93
> > > prerequisite-patch-id: b71389e82026ffc19cbb717bba1a014ad6cab6da
> > > prerequisite-patch-id: fbb0201f89bf6c41d0585af867bdeec8d51649b2
> > > prerequisite-patch-id: e3b4b5b69b4eadf87ed97beb8c03a471e7628cb9
> > > prerequisite-patch-id: 3fbc9745cf3f28872b3e63f6d1f6e2fd7598be8a
> > > prerequisite-patch-id: ba2b190c2e54cfb505a282e688c2222712f0acd7
> > > prerequisite-patch-id: 47e5ca730748bb7bf9248a9e711045d8c1028199
> > > prerequisite-patch-id: dcd9f87f00290d2f9be83e404f8883eb90c5fb1c
> > > prerequisite-patch-id: d4629be1a61585ab821da2d2850f246761f72f25
> > > prerequisite-patch-id: f740190f4b94e57cbf3659f220d94483713341a1
> > > prerequisite-patch-id: 301c2e530e2af4568267e19247d4a49ac2a9871d
> > > --=20
> > > 2.43.0
> > >=20
> >=20
> >=20
> > --=20
> >=20
> > Joel Granados
>=20
>=20

--=20

Joel Granados

--4kzvc3bji6c3orpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWIfakACgkQupfNUreW
QU98Zgv/T0dEFxaqOrcoxD6Bd1b4gkCZHQnsm4r3TwewXhBjCemlpFLMViyYR7au
xd0vMuTlcepXK0NJIjpjTJ6cG5gW5Sq4/YiLdgk7NClYMjBX6PLTs1/nhC9FwSPh
HMh7OTP+AjXijRRHGWfDzehp0u+Vp9b/evSgkldjtOwejnfgUYIiPNmn4XEXYmMV
PPidlw0K9QHU+tSPvnVbzfriAqyzUsybrCUDMKM2a6EcTWb4SpHbUP5pog+tn1tp
M6f9tipsTf//tm1dxFNwLa0eWzj3kh0BcAYlY0TZ/Q4e+AwSXRZRtP3/Bh8ZcHoQ
BrapcBuK9ZRNn0eEFptgbxR1eZxNNjq2GoJyaVzjxxuzAorh6wHgUY2+aZRd4E00
q+zi1WgbbgjvThlNFfYIamj+qGhsP9gYnqoaMFHwksKaemT6Fl2wTijA/kYz7Twn
xw2VoPdmYyLJUk2sTpoplkAbhQajmGhnktUJU1fxudOPq8nFKDlq2dkCxaZ/qz1y
fcv1Jg10
=YqTv
-----END PGP SIGNATURE-----

--4kzvc3bji6c3orpp--

