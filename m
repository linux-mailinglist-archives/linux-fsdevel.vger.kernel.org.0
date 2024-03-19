Return-Path: <linux-fsdevel+bounces-14820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D68800EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E69B21D38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24DC657D2;
	Tue, 19 Mar 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E+ow/cwt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BC2E400;
	Tue, 19 Mar 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863092; cv=none; b=lujnrtt5AcHBJfmeAmVAwMNn7AAFZltPwhE2m+OkjECdFgLTXuqL+pNY4CCQD46IT0cEQF26mxc8TGpK8DRES7lqI/eEhD9BnFp8EQ8KcYW+keeafMn8pvaHkFZMCSrT5suoX6z0yah/Jr+tXtYtUrV5n9jBKnFd91PWfUn3V7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863092; c=relaxed/simple;
	bh=1+/B8Un/cn9W3oC1K+Qer3zRsiVXWK25MTlnqh3cJ2Q=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=qJD7ODegpwJzlIJlH/ywiQoJEAklmQboxIV2TtNr0Mq8CGBGu+KoASNoMceYfEqMlmMydy3+Qd3w34qXQuTc1qwN6Ci1/jTMpLto3IYhOHu9tGbd0S7sibgtfr3hACZafBgbK9bXWQRbpSwN2AqXotkqv20wqa/OAbfSpYkFTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E+ow/cwt; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240319154448euoutp02fc1abb2b1e28a1f2922f59092e0d9a6a~_NOoDgQVl0279302793euoutp02c;
	Tue, 19 Mar 2024 15:44:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240319154448euoutp02fc1abb2b1e28a1f2922f59092e0d9a6a~_NOoDgQVl0279302793euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710863088;
	bh=QAJxnVSdhCOYOBKuvvvp87CCwedHp7UufWZtCssqJPQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=E+ow/cwthTCixP+MfH4WTT9TOuyFtJwJRcgFb/aVhAVWULfFn4dzo15yqnpWHrnfr
	 yhUQtFBchEAojFLWSBbSZG4fxKk097ie0NUNr2w0Bs05QBIgtzg9SR3NRHtV1tdi/6
	 NKA7cl2C3/pAk0PGu54NcfNaMvSCfBA9y6Nveqxg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240319154447eucas1p2cbe94008acb27d760657de7c63b1603f~_NOn4FpcO2761227612eucas1p2X;
	Tue, 19 Mar 2024 15:44:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id C4.5C.09552.FE2B9F56; Tue, 19
	Mar 2024 15:44:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240319154447eucas1p196eb8c607f40cb1a12b66a3909202dfe~_NOnYElPL1694716947eucas1p1K;
	Tue, 19 Mar 2024 15:44:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240319154447eusmtrp253e12c255cc7fefa394253448fc4d227~_NOnXgo3t1754317543eusmtrp2N;
	Tue, 19 Mar 2024 15:44:47 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-8f-65f9b2efd3f9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C6.5F.10702.FE2B9F56; Tue, 19
	Mar 2024 15:44:47 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240319154447eusmtip1f0cfe96b51675879190ab08d7374f8e3~_NOnIYle33135931359eusmtip1e;
	Tue, 19 Mar 2024 15:44:47 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Mar 2024 15:44:46 +0000
Date: Tue, 19 Mar 2024 16:44:44 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/4] sysctl: drop sysctl_is_perm_empty_ctl_table
Message-ID: <20240319154444.gjdg33aa6px7kmkc@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="rhjcpktngvcxuw73"
Content-Disposition: inline
In-Reply-To: <20240222-sysctl-empty-dir-v1-1-45ba9a6352e8@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSa0xSYRjH98LhnANFHYnmozYtvHQnnV3Y8tIFi6gPtbV1W8tTnswloCDd
	3WyZltZySTMps8tKk80pKV0wKNoktallM3Nmd2uaUZEV1SzwaLX17fe8z/N73+e/vSRX5OQF
	kinqDEarplMluACz1HtaZrrMHiby0+0o2S9LNiG7l6+S1d1swGRtN07jsh/fejiyjoLXaAGu
	OJV1H1OYKw7jCrc5WHEsv55QGBy52EreekFMEpOasoPRzopLFGwbcJaitHr/XdYXZ7EsVCvO
	Q3wSqNlgvFqI5yEBKaLKEfzs6eWwxWcEz+vsPLZwI+hxd/FGlO8NBRjbKEOQtf8A8Weq5Nb5
	4U4tgpayIsKnYFQ42A82Ix/j1AxoedfF9bGYioHLX9xDNpe6icD4tnRIGEfJwdp5FfexkFoA
	1u6vGMt+0FD8ysukV9gFFtsGFoOgbJD0TfCpZfCy6QiH3TQUHtku4CxnQmNN51A2oAr50Pvw
	/HBDDp7X9uFo46DXWUOwPAF+XS8dERDYBz8QbGFCcGn/wPAT8yH74SvCtwVQC8F4KpXFMdDR
	7+eb4HrxuKWIyx4L4VCOiBUjwNT9DitAocZ/ghn/BjP+DWYcukcKHScM+H/H0+HSuT4uy7FQ
	WenCziKiAvkzep0qmdFFq5mdUh2t0unVydItGpUZef9X06Bz4Boq7/0odSAOiRwozCu/qDK1
	okBMrVEzErGQGOVhRMIkevceRqvZpNWnMjoHCiIxib8wPCmEEVHJdAaznWHSGO1Il0PyA7M4
	4vK+VWUBNZnXUrYqhZq8xlu5aWvFT+gYx9Oj3d/z96jT9WsfH5Y8SEhULgncPLW8sn+Doan7
	dkZkgqF/TMxmmyciY/rCnOb46vix5sh2/YrCp2fsUVNsyhJreljO1OBG4Fcr5yRGzVZKeQGZ
	kuj+dtg4/vHKOJsoNDfoeDLfVKV1DbQLI1zLnPIwpdUwrVXgV5hYnV40q3Ze7OS70L5lVAjX
	JL88WmRYU1cckC3szJz0fHWDarE7XNMXCzPe7wvBPG3P9F3xV06uppcGTVxX4djeVkO2PMvf
	t9djiV+xNLqEXqyMvWjzd557Iv+2qMdSV8WBO5riCtemI28WzV0uwXTb6KhpXK2O/g0AhGt0
	2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7rvN/1MNZi0WMji/7YWdosz3bkW
	e/aeZLG4vGsOm8XvH8+YLG5MeMrowOYxu+Eii8emVZ1sHp83yXn0dx9j95hyqJ0lgDVKz6Yo
	v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PH2zPsBUfE
	K+7v2svewLhZpIuRk0NCwETi18kJLF2MXBxCAksZJdbM/8ICkZCR2PjlKiuELSzx51oXG0TR
	R0aJm5M3MUI4WxklLraeButgEVCV2N96jhHEZhPQkTj/5g4ziC0iYCOx8ttndpAGZoG9jBKz
	XsxnB0kIC7hI7L61nQ3E5hVwkNh97zvUHbcZJbZvfgGVEJQ4OfMJ2AZmgTKJG52fgDZwANnS
	Esv/cYCEOQU8JR6f7mGCOFVZ4vq+xWwQdq3E57/PGCcwCs9CMmkWkkmzECZBhHUkdm69w4Yh
	rC2xbOFrZgjbVmLduvcsCxjZVzGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG8rZjP7fsYFz5
	6qPeIUYmDsZDjCpAnY82rL7AKMWSl5+XqiTCy879M1WINyWxsiq1KD++qDQntfgQoykwGCcy
	S4km5wNTTF5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA9Payg1r
	3v9n46rVTp7izVDSxSbKuE33851b+5hZJ2k3q317vsCHOa8orOfowhtTPlRu/2v6yN/H/9C3
	W4umJMZsjzb6/SBqlckmlSVFGunrFUwv5s/QPs7qtU+Ge55n463E5N29lg7GS/KV9ppOkTzt
	YdYi5DAzOnnSi/NLOndufMWzf2OqasXsN1ZXTkbMO+o7y1A2lz1uAvfJedKbeI5dEgjIauTe
	ufWAC0f9eoO/axdIr/OcteDiy4ajZecM5Hn8LnbtfX81PqFA0EGwYsvabdq/C61erpN4svXK
	8XVzCltipDJufWUreWvjULwkvWjixz2zf1myhS0qsl29zsWqaeLc+TdjH4hEi994td5WiaU4
	I9FQi7moOBEAJ9TR5XkDAAA=
X-CMS-MailID: 20240319154447eucas1p196eb8c607f40cb1a12b66a3909202dfe
X-Msg-Generator: CA
X-RootMTR: 20240222070825eucas1p2dc50c8ef29cae3e43bee012773a19824
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240222070825eucas1p2dc50c8ef29cae3e43bee012773a19824
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
	<CGME20240222070825eucas1p2dc50c8ef29cae3e43bee012773a19824@eucas1p2.samsung.com>
	<20240222-sysctl-empty-dir-v1-1-45ba9a6352e8@weissschuh.net>

--rhjcpktngvcxuw73
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 08:07:36AM +0100, Thomas Wei=DFschuh wrote:
> It is used only twice and those callers are simpler with
> sysctl_is_perm_empty_ctl_header().
> So use this sibling function.
Can you please add a comment relating this to the constification effort.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_sysctl.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 37cde0efee57..2f4d4329d83d 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -48,10 +48,8 @@ struct ctl_table_header *register_sysctl_mount_point(c=
onst char *path)
>  }
>  EXPORT_SYMBOL(register_sysctl_mount_point);
> =20
> -#define sysctl_is_perm_empty_ctl_table(tptr)		\
> -	(tptr[0].type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
>  #define sysctl_is_perm_empty_ctl_header(hptr)		\
> -	(sysctl_is_perm_empty_ctl_table(hptr->ctl_table))
> +	(hptr->ctl_table[0].type =3D=3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
>  #define sysctl_set_perm_empty_ctl_header(hptr)		\
>  	(hptr->ctl_table[0].type =3D SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY)
>  #define sysctl_clear_perm_empty_ctl_header(hptr)	\
> @@ -233,7 +231,7 @@ static int insert_header(struct ctl_dir *dir, struct =
ctl_table_header *header)
> =20
>  	/* Am I creating a permanently empty directory? */
>  	if (header->ctl_table_size > 0 &&
> -	    sysctl_is_perm_empty_ctl_table(header->ctl_table)) {
> +	    sysctl_is_perm_empty_ctl_header(header)) {
>  		if (!RB_EMPTY_ROOT(&dir->root))
>  			return -EINVAL;
>  		sysctl_set_perm_empty_ctl_header(dir_h);
> @@ -1204,7 +1202,7 @@ static bool get_links(struct ctl_dir *dir,
>  	struct ctl_table *entry, *link;
> =20
>  	if (header->ctl_table_size =3D=3D 0 ||
> -	    sysctl_is_perm_empty_ctl_table(header->ctl_table))
> +	    sysctl_is_perm_empty_ctl_header(header))
>  		return true;
> =20
>  	/* Are there links available for every entry in table? */
>=20
> --=20
> 2.43.2
>=20

--=20

Joel Granados

--rhjcpktngvcxuw73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX5suwACgkQupfNUreW
QU911Qv/XUtVU47NJ2TAOrmjM/9rBCJk43tJ6uNgBE4JrVTXaXV3hyT/bGtEX99m
H5hMHgKyJR2CRBqS8gaHKgYT53qEXsr8YBtF3xO3rtX/PtCXd4jwVO93wL6eQb8I
BKufeqOY69mzB2omwA8JzWeHH8u2dEY/R95ZGSMFPQeG4ennAUWQG2wAaw+BFoph
A2oJWZ7s6t1ue5/Suf75BeLY/40dOkGTXbvQ+slR41/dQMUvWYEx7Ho/WDcvDM7Y
HB8UV7izm61UPpzEWUPjvJFAI0LnNB6CLAgCZFMuUJ9LIZdoLbU5zctyXTBthy//
N5ku13pVSteJtI5clFwmnjALIVQ8zneS6s2BHB2VlYOlECJ9O/PmfBGZszB8AMA1
zOu4UYzJsIJax7PdAWMG75ZZok+tebPhc+LFSRY/aOtUcAX/bVroZflhhZWApoKH
zORCcxFq0E78tsw+cTSk4S2oFx3eM7q8L248Du0v8/zmMbTJ3ojL+c5euo++k+jN
DJiNNVWR
=70js
-----END PGP SIGNATURE-----

--rhjcpktngvcxuw73--

