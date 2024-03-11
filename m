Return-Path: <linux-fsdevel+bounces-14113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1715C877C92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 10:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817A3B213BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61617578;
	Mon, 11 Mar 2024 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PlahQyHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6EE1642F;
	Mon, 11 Mar 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148980; cv=none; b=qdDNqTcjEXzhqosp/b7aauR2DQ8q78C4gOkaHwmnICc2wXgAIvkwK6FBPZK6ngsN+/NzPD9BXcXQcUqVDcra71i8srqkrYbDLnt3ShchbvzRZ+6QcWpdc4PbxnpJbr3hIIORL/lDQbKRALTLE3MZyCmzB6fTSS7lthyoVNzgzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148980; c=relaxed/simple;
	bh=phZYkIknd0nHZYcSbT2BXxA4aerW6MMZ6E8pgI5K6xM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=URjytOZ4qYoDsWx0c7YrClXnUpcp+vNOIBK3CL36r/roZaavAExOo3u6MY32WSWMsOUqH42ycZDxNw1fTg+hXJ/KEURkCrCDnj92/8bIVunSqh2FcIRpQOTkayRV324rTyF9J2zr36sJWa0J9wDXS9q30nNoULYyCxQU2SFqBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PlahQyHU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240311092248euoutp02d83ea9e995a26df41b4e8565be758ee2~7q20wwHik1895718957euoutp02r;
	Mon, 11 Mar 2024 09:22:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240311092248euoutp02d83ea9e995a26df41b4e8565be758ee2~7q20wwHik1895718957euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710148969;
	bh=YFtsdWLfcCKSjn/uECWfbnvvqmea1zkF5s9WE42IsJw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PlahQyHUZhDf9L6K9Pv2Mi3p7ij2CnLsJwOd6AqQPN9Swx220DJbH8nwsMbUQeRpt
	 RM1oxFVR36UaIMVOWEJBL50Dt6QJ9lJ+UZ+rBr9SM/t3tZdfVD87jvCafLDWqtw0Is
	 MjtOielBfSaYeOpMzZi+s8wn21NH7gxmuPni5fwY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240311092248eucas1p2570548604c8828f4c4576b5cb9a88383~7q20gr3AA1286012860eucas1p2R;
	Mon, 11 Mar 2024 09:22:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A4.FD.09552.86DCEE56; Mon, 11
	Mar 2024 09:22:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240311092248eucas1p1e0211c40740f55e6e512332e985b7395~7q20Hw4o02824328243eucas1p1A;
	Mon, 11 Mar 2024 09:22:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240311092248eusmtrp2d326710dfa006fbb608d75abc771b152~7q20HHsKH2788827888eusmtrp2F;
	Mon, 11 Mar 2024 09:22:48 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-a1-65eecd68f46a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.DE.10702.86DCEE56; Mon, 11
	Mar 2024 09:22:48 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240311092248eusmtip27f4c35ce4b03bab6612762a7a98c1a39~7q2z3tqq91594415944eusmtip2a;
	Mon, 11 Mar 2024 09:22:48 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 11 Mar 2024 09:22:47 +0000
Date: Mon, 11 Mar 2024 10:22:45 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2] sysctl: treewide: constify
 ctl_table_root::permissions
Message-ID: <20240311092245.geslwjlcrufw6bsb@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="thv5sczf3yolan2y"
Content-Disposition: inline
In-Reply-To: <e3198416-4d90-4984-88ee-d2fccf96c783@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djP87oZZ9+lGpy8r2Yx53wLi8XTY4/Y
	Lc5051pc2NbHarFn70kWi8u75rBZ/P7xjMnixoSnjBbHFohZfDv9htGBy2N2w0UWjy0rbzJ5
	LNhU6rFpVSebx/t9V9k8Pm+S8+jvPsYewB7FZZOSmpNZllqkb5fAlbH02UuWghbziofXO9gb
	GNfrdDFyckgImEjMWruQvYuRi0NIYAWjROOkrUwQzhdGiYUHVrFBOJ8ZJWZN62GDaXl89xJU
	y3JGiYOv+ljgqpZNmcgM4WxmlDg3/zcLSAuLgKrEgx/HmEBsNgEdifNv7jCD2CICNhIrv30G
	G8UssI9J4uPFNnaQhLBAgMS8C0/BbF4BB4kjU09B2YISJ2c+ARvKLFAh8ezBAqA4B5AtLbH8
	HwdImBNo5rp9p1ghTlWU+Lr4HguEXStxasstsOckBLZzSsx78Z4NpFdCwEWiockSokZY4tXx
	LewQtozE/53zoeonM0rs//eBHcJZDfRm41cmiCpriZYrT6A6HCVe3p7ECDGUT+LGW0GIO/kk
	Jm2bzgwR5pXoaBOCqFaTWH3vDcsERuVZSD6bheSzWQifQYT1JG5MncKGIawtsWzha2YI21Zi
	3br3LAsY2VcxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIEpr7T/45/3cG44tVHvUOMTByM
	hxhVgJofbVh9gVGKJS8/L1VJhPe1zttUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLp
	iSWp2ampBalFMFkmDk6pBiaT/7dFU2yuPdwrNqNzxoGI0vWGN/SWbO/caz9HLPXfrtgjeraG
	D289eKfis72kumTlDs+DE7W++NnME+K9k8bnf/ki94kHd42+nduklrHXpFFixXnBmRVXWjTE
	PsRqN7LsYOQXnR0U4sdit/BK1dQdr6O2zUtuWMV7XYhpP/enW/vVW5f/ae3J2lNb/+TjCynm
	D8J7f6nnbe1mWDbvIdf55U27pJh/mV6Tvp1k9lj6RPeHRZfNH2zidOpdbv+Uy1kotd0u4ea3
	GwylKW4F2snB09UEGDf932n54ID0tSUfxB+wO9+c+8G/XtTfZMqrmcV/t8TYaypI1yjs3KGj
	IHRy3Ro5gZOPPy4wev/746ZNSizFGYmGWsxFxYkAjfen5/gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Pd2Ms+9SDe785bCYc76FxeLpsUfs
	Fme6cy0ubOtjtdiz9ySLxeVdc9gsfv94xmRxY8JTRotjC8Qsvp1+w+jA5TG74SKLx5aVN5k8
	Fmwq9di0qpPN4/2+q2wenzfJefR3H2MPYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
	NDaPtTIyVdK3s0lJzcksSy3St0vQy3h76jpzQZN5xf/FvUwNjGt1uhg5OSQETCQe373E3sXI
	xSEksJRR4s/krYwQCRmJjV+uskLYwhJ/rnWxQRR9ZJToOtDOCuFsZpSYtOI/WBWLgKrEgx/H
	mEBsNgEdifNv7jCD2CICNhIrv30GW8EssI9J4uPFNnaQhLCAn8Sr5RPAmnkFHCSOTD0FdUcv
	k8S0D8vYIRKCEidnPmEBsZkFyiTW/pwOFOcAsqUllv/jAAlzAi1Yt+8U1KmKEl8X32OBsGsl
	Pv99xjiBUXgWkkmzkEyahTAJIqwjsXPrHTYMYW2JZQtfM0PYthLr1r1nWcDIvopRJLW0ODc9
	t9hIrzgxt7g0L10vOT93EyMwAWw79nPLDsaVrz7qHWJk4mA8xKgC1Plow+oLjFIsefl5qUoi
	vK913qYK8aYkVlalFuXHF5XmpBYfYjQFBuNEZinR5HxgasoriTc0MzA1NDGzNDC1NDNWEuf1
	LOhIFBJITyxJzU5NLUgtgulj4uCUamBSj11k5GGtv+Sn04fK7r8vhDa7sKYs13mnc3N3jOJF
	zfr3WtVGTzr+Z+6X9ciLWd3BIvUhYsIl5cuTemr/qBy76Cez8eaFa+qT/086nNq+W718l2g+
	U+HC9z/7/6Z8OhF4/km1I2+2dMkhce/9gbcm/9C5o6D3b/q9s1eW6rEpc5hK/b+T0jQrN+fi
	J76dab+Evot+Tr6+1VDzre2GD+vmXJwxSc+pXTb4Y+xP7gOlOfLXi/N5a8WXh9a7bUyL55iq
	u3nam18WrqqPy1znGfJterDwCu+GgEdlRXI5hnmNn9Qfzjh5NCPx08OVM5g/bPFlF5eYvCxt
	niOncPfvuazyVk1HWidIHctU4PuUYrVIiaU4I9FQi7moOBEAQye8RpUDAAA=
X-CMS-MailID: 20240311092248eucas1p1e0211c40740f55e6e512332e985b7395
X-Msg-Generator: CA
X-RootMTR: 20240223155229eucas1p24a18fa79cda02a703bcceff3bd38c2ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240223155229eucas1p24a18fa79cda02a703bcceff3bd38c2ba
References: <CGME20240223155229eucas1p24a18fa79cda02a703bcceff3bd38c2ba@eucas1p2.samsung.com>
	<20240223-sysctl-const-permissions-v2-1-0f988d0a6548@weissschuh.net>
	<20240303143408.sxrbd7pykmyhwu5f@joelS2.panther.com>
	<e3198416-4d90-4984-88ee-d2fccf96c783@t-8ch.de>

--thv5sczf3yolan2y
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 10:18:07AM +0100, Thomas Wei=DFschuh wrote:
> Hi!
>=20
> On 2024-03-03 15:34:08+0100, Joel Granados wrote:
> > Just to be sure I'm following. This is V2 of "[PATCH] sysctl: treewide:
> > constify ctl_table_root::set_ownership". Right? I ask, because the
> > subject changes slightly.
>=20
> No, the v1 of this patch is linked in the patch log below.
>=20
> The patches for ::set_ownership and ::permissions are changing two
> different callbacks and both of them are needed.
Awesome. thx for clarifying. So the ::permissions one I have reviewed
and have added to the constification branch in sysctl repo for testing.
I'm missing the review for the set_ownership one.

Best

>=20
> The v2 for set_ownership is here:
> https://lore.kernel.org/lkml/20240223-sysctl-const-ownership-v2-1-f9ba179=
5aaf2@weissschuh.net/
>=20
> Regards
>=20
> >=20
> > Best
> >=20
> > On Fri, Feb 23, 2024 at 04:52:16PM +0100, Thomas Wei=DFschuh wrote:
> > > The permissions callback is not supposed to modify the ctl_table.
> > > Enforce this expectation via the typesystem.
> > >=20
> > > The patch was created with the following coccinelle script:
> > >=20
> > >   @@
> > >   identifier func, head, ctl;
> > >   @@
> > >=20
> > >   int func(
> > >     struct ctl_table_header *head,
> > >   - struct ctl_table *ctl)
> > >   + const struct ctl_table *ctl)
> > >   { ... }
> > >=20
> > > (insert_entry() from fs/proc/proc_sysctl.c is a false-positive)
> > >=20
> > > The three changed locations were validated through manually inspection
> > > and compilation.
> > >=20
> > > In addition a search for '.permissions =3D' was done over the full tr=
ee to
> > > look for places that were missed by coccinelle.
> > > None were found.
> > >=20
> > > This change also is a step to put "struct ctl_table" into .rodata
> > > throughout the kernel.
> > >=20
> > > Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> > > ---
> > > To: Luis Chamberlain <mcgrof@kernel.org>
> > > To: Kees Cook <keescook@chromium.org>
> > > To: Joel Granados <j.granados@samsung.com>
> > > To: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> > >=20
> > > Changes in v2:
> > > - flesh out commit messages
> > > - Integrate changes to set_ownership and ctl_table_args into a single
> > >   series
> > > - Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-permiss=
ions-v1-1-5cd3c91f6299@weissschuh.net
> > > ---
> > > The patch is meant to be merged via the sysctl tree.
> > >=20
> > > There is an upcoming series that will introduce a new implementation =
of
> > > .permission which would need to be adapted [0].
> > > The adaption would be trivial as the 'table' parameter also not modif=
ied
> > > there.
> > >=20
> > > This change was originally part of the sysctl-const series [1].
> > > To slim down that series and reduce the message load on other
> > > maintainers to a minimumble, submit this patch on its own.
> > >=20
> > > [0] https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mi=
khalitsyn@canonical.com/
> > > [1] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11=
447@weissschuh.net/
> > > ---
> > >  include/linux/sysctl.h | 2 +-
> > >  ipc/ipc_sysctl.c       | 2 +-
> > >  kernel/ucount.c        | 2 +-
> > >  net/sysctl_net.c       | 2 +-
> > >  4 files changed, 4 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > > index ee7d33b89e9e..0a55b5aade16 100644
> > > --- a/include/linux/sysctl.h
> > > +++ b/include/linux/sysctl.h
> > > @@ -207,7 +207,7 @@ struct ctl_table_root {
> > >  	void (*set_ownership)(struct ctl_table_header *head,
> > >  			      struct ctl_table *table,
> > >  			      kuid_t *uid, kgid_t *gid);
> > > -	int (*permissions)(struct ctl_table_header *head, struct ctl_table =
*table);
> > > +	int (*permissions)(struct ctl_table_header *head, const struct ctl_=
table *table);
> > >  };
> > > =20
> > >  #define register_sysctl(path, table)	\
> > > diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> > > index 8c62e443f78b..b087787f608f 100644
> > > --- a/ipc/ipc_sysctl.c
> > > +++ b/ipc/ipc_sysctl.c
> > > @@ -190,7 +190,7 @@ static int set_is_seen(struct ctl_table_set *set)
> > >  	return &current->nsproxy->ipc_ns->ipc_set =3D=3D set;
> > >  }
> > > =20
> > > -static int ipc_permissions(struct ctl_table_header *head, struct ctl=
_table *table)
> > > +static int ipc_permissions(struct ctl_table_header *head, const stru=
ct ctl_table *table)
> > >  {
> > >  	int mode =3D table->mode;
> > > =20
> > > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > > index 4aa6166cb856..90300840256b 100644
> > > --- a/kernel/ucount.c
> > > +++ b/kernel/ucount.c
> > > @@ -38,7 +38,7 @@ static int set_is_seen(struct ctl_table_set *set)
> > >  }
> > > =20
> > >  static int set_permissions(struct ctl_table_header *head,
> > > -				  struct ctl_table *table)
> > > +			   const struct ctl_table *table)
> > >  {
> > >  	struct user_namespace *user_ns =3D
> > >  		container_of(head->set, struct user_namespace, set);
> > > diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> > > index 051ed5f6fc93..ba9a49de9600 100644
> > > --- a/net/sysctl_net.c
> > > +++ b/net/sysctl_net.c
> > > @@ -40,7 +40,7 @@ static int is_seen(struct ctl_table_set *set)
> > > =20
> > >  /* Return standard mode bits for table entry. */
> > >  static int net_ctl_permissions(struct ctl_table_header *head,
> > > -			       struct ctl_table *table)
> > > +			       const struct ctl_table *table)
> > >  {
> > >  	struct net *net =3D container_of(head->set, struct net, sysctls);
> > > =20
> > >=20
> > > ---
> > > base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
> > > change-id: 20231226-sysctl-const-permissions-d7cfd02a7637
> > >=20
> > > Best regards,
> > > --=20
> > > Thomas Wei=DFschuh <linux@weissschuh.net>
> > >=20
> >=20
> > --=20
> >=20
> > Joel Granados
>=20
>=20

--=20

Joel Granados

--thv5sczf3yolan2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmXuzV8ACgkQupfNUreW
QU/cVQv9F5VIGjwE2Fe0qpaMMYA6k6vUj/CEfiKMGBs/FkTsDeLV3HdEC0mYpkjw
NSf6dUua4iun5I8D/IIATHmM5glrcvht3/bP9l5pg+QlLjOfPCqOarqq/QzMZiM0
zAI5D+wD985L0XPzyJC0Ra+kdSX3hpQbEDgOJqLmR9dQL7El6LVztjWr+D6wDuDN
o0AUjVvWFsZzLFVMT25QD7xL/3Mkt2/KC6AmSJv3rc6ULfRT9xjbW163yFk3UL8d
Yux0Qyx70oFaLlUfF+eOQv9XubkBzJPCWeJMWhCLFLejgI8pVIe9298yA6kLUrL9
9IqP/kSrOzNltC2B2wgAZ9L6QfJ/AdcHanjFQW0KHmeHlV6x1HfFM35IxzXoiZO+
jKMUG11LcuV1tqlzByVbPS284VUtzD2iWi9DtVO3wLDyou9a0g6zisd+kh7+bDpP
mdf6KFiSqus/++3Cg5pRUt03RghlHg2fIb8Ju46CZhQXaa9vdNHYH5mgYO+HzGDf
CY4kvVcI
=Lq2W
-----END PGP SIGNATURE-----

--thv5sczf3yolan2y--

