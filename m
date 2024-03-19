Return-Path: <linux-fsdevel+bounces-14817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE9A88008D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D0D2812E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA88003D;
	Tue, 19 Mar 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SzBE4zCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42765BAA;
	Tue, 19 Mar 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862064; cv=none; b=V2qP5VmsoAG6hLkR/Vi7JOyagX8XFdfkymZ8Y+42rFJ1XhRHQK1oVi2UfO5vfkpC7QnbsVkCqmwB6MPdwSR8x18/D5iM9v9DCakcQ9iCAknQ6ouVA37CRhrX3J2sGDL2n23T0Xubr77hdUfKFItJKbYh0TOM7KEacbe1ZkBb2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862064; c=relaxed/simple;
	bh=yYxBMzxQS7ecwoKcaBzTn6vMn/9fgHsyovHqn5/3m+0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=MrV4fz/LiUe0rSeueHcYNltFK4+Byo/ZLeO2lfZsRUy9UqB2klMs7ngpega8yrsltq2lbKpGQnmKoLxCG2ByRtQPZJhne3SusWl9QLtzXmws7e+MBxBLFapmvjH7Paa54fql+YlqkQj+v6xl7v1snUeT47B9+9/iLyM/y2249bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SzBE4zCi; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240319152740euoutp02fd9bfab4df50fc1f7a4746cda7d5f3d8~_M-qsezTM1709817098euoutp02N;
	Tue, 19 Mar 2024 15:27:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240319152740euoutp02fd9bfab4df50fc1f7a4746cda7d5f3d8~_M-qsezTM1709817098euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710862060;
	bh=KNm5LklWUS6y5OIUd+Sm7HGhI9RSGs9Fb5MNw0hjbVs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SzBE4zCibmzfjvPIniMWqeO96g+5FfZcC28uZQ3p53lccy58sItDhjMDu1ArWo7M6
	 hhbtRq+srshLz6RVy4gGtvnnmUF6NaZr55aix5NTHqxuZlSIqRwhPYzpZrdinxHRA4
	 oEubkmlCv15s1YkQ1JZhvl8t+RFleYfYAdXtxQZ4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240319152739eucas1p13a1ad0d4835fab35656e1f6d630874be~_M-qbwIFl0787807878eucas1p1Q;
	Tue, 19 Mar 2024 15:27:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.C6.09814.BEEA9F56; Tue, 19
	Mar 2024 15:27:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240319152739eucas1p2c682dc27730e0e3fc1df20accf9bfedb~_M-qEaj4F2786127861eucas1p2h;
	Tue, 19 Mar 2024 15:27:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240319152739eusmtrp24a101f41f9382a5e14f49430fd1135d4~_M-qDv38R0702807028eusmtrp2R;
	Tue, 19 Mar 2024 15:27:39 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-63-65f9aeeb203d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.8C.10702.BEEA9F56; Tue, 19
	Mar 2024 15:27:39 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240319152739eusmtip19975b532bb181731861131d0be6c0ec2~_M-p4LJcP1890018900eusmtip1m;
	Tue, 19 Mar 2024 15:27:39 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Mar 2024 15:27:38 +0000
Date: Tue, 19 Mar 2024 16:27:36 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sysctl: drop now unnecessary out-of-bounds check
Message-ID: <20240319152736.mpgpahyyoiaryucn@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="nlgf7jyuw2vaaq5p"
Content-Disposition: inline
In-Reply-To: <20240222-sysctl-empty-dir-v1-3-45ba9a6352e8@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSe1BMYRjGfXvOnnMq2xynHV5lmCm3Qa2osQgRY80w0zA0jEs7OqpRW84W
	lVtRqLAhQ2mEjGgps6XcjZ1RohSlCyY0ctmVsJU9xbKnsy4z/vt9z/M+873PNx+FMdVSdypS
	E8dyGnWUJ+GMl1fydd7mYp6dXKGbqvxZnkoqazKjlTdvVePKhut5hLLf+laibMnqQIGE6kTy
	Y1xlKEonVBbDSJUus5JUZRv34sHSVc4BYWxU5GaWU8wOdY44e7AEi7UwCbobVXgyOkRnICcK
	aD+40MZLMpAzxdDnEejMPBIP3Qj6aq0Ox4KgrMBA/o6k8X1S0ShEsPdVE/Fn6t4uKyZMMfQV
	BBePLhIYp8eAsTyPEJigJ0HdxxcDM3I6AC70WkghjNG3EOS+zx+4wo1eBN92t0oFltGB0G84
	Tog8BKpz3uACY3QCWJ/22XXKzh5QaKME2cke1d9IkYqbekHz7QJC5O3woOzZQB2gdU5wJqsE
	icZ8eFIivIDAbmCqKnPUHAE/r+U7AkcQ3LF9JsWDHsG5lB5HYiakNr5xJObCkduZUmEjoF2h
	pXOIuKgrHC4/homyDPbtYcTpsaBv+4hnIa/cf6rl/lMt9281UfaBlqPZ/8sT4dxpMybyLCgu
	7sJPIbIIDWPjtdHhrHaKht3io1VHa+M14T7rY6INyP7DHtqquq+iQtMXHyOSUMiIRtvD7Zf1
	9cgd18RoWE+5jHThWUYWpk5MYrmYdVx8FKs1Ig8K9xwmGxM2imXocHUcu5FlY1nutyuhnNyT
	JUFJCX47Fi/gvpbkDz9gZTqo+ubgzYN+dBd0hibwE7GuIl/r3S/ticdmNjQ1tZJ1Wq9ePgid
	b7eO3Fa6ZN30xB5vcpppRry3f+m7K+M3ZS9dkTbulaG29rqp4BETEhR7enVD2LLLvpFtZ/y8
	3z2YKlfw01rXfMoZ93JGVD9TalK/trhqBp/St5/IT6xOd0+bL8+LUWzhl55cc9G8drl1uH9c
	46Fvj/ajgM7nKo63pUgUwUm9i6e0ztsgx+d9r3fpiq3pDsw6flAf0bh1JTlidSWzSjHUvHuh
	raIrpHmO24eIfT0uRTWSjFF1FbD15Y/Bl9I5/KxHTmhvB5HqX7Ez537IMk9cG6H2nYBxWvUv
	tS0Vp9wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7qv1/1MNTh0Q8Li/7YWdosz3bkW
	e/aeZLG4vGsOm8XvH8+YLG5MeMrowOYxu+Eii8emVZ1sHp83yXn0dx9j95hyqJ0lgDVKz6Yo
	v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2NK/zW2go9C
	FednOjYw9gt0MXJySAiYSLT+/MUKYgsJLGWUmPxNFiIuI7Hxy1VWCFtY4s+1LrYuRi6gmo+M
	Ev/Pv2SGcLYySvx9epcRpIpFQFXi0LY5bCA2m4COxPk3d5hBbBEBG4mV3z6zgzQwC+xllJj1
	Yj47SEJYwFPie/NNsBW8Ag4SvzfNgFpxm1FizoTzLBAJQYmTM5+A2cwCZRLHX30GsjmAbGmJ
	5f84QMKcQHNW726EOlVZ4vq+xWwQdq3E57/PGCcwCs9CMmkWkkmzECZBhHUkdm69w4YhrC2x
	bOFrZgjbVmLduvcsCxjZVzGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG8bZjP7fsYFz56qPe
	IUYmDsZDjCpAnY82rL7AKMWSl5+XqiTCy879M1WINyWxsiq1KD++qDQntfgQoykwGCcyS4km
	5wPTS15JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1PyMu2p+brF
	TdO9zOr2M1UlzpXoCnrxfjdHyasj57MC008Ye0wMcD6+5+qNOwp9++u8vt0uXq5zU+zV7U1a
	Sc2Pme2vJtnND2eTnNA8o+rF0+BPnrHBZXYTi96eW6Upo7GnKYBx7a1fUwsv6Wfz73m62fTp
	k3cTf95VXtamFqN9qfJU+02WnbtcYllu7n51g0c68/Bhvs+7spnW2wdyT5LcXGkzl2WOmMUz
	98NuPLPPBy49XmN+8OSRthv75ghlBWz6euBNeHHnD51Zp/XuBm8p/ZbMeHjRMvvsu6EhArEd
	r0+cYb+We9hlxrmy0JOthREunrerz+kdrS53thRMDnuy6ef2x80PbpRG82smSCgosRRnJBpq
	MRcVJwIADc9RmXcDAAA=
X-CMS-MailID: 20240319152739eucas1p2c682dc27730e0e3fc1df20accf9bfedb
X-Msg-Generator: CA
X-RootMTR: 20240222070824eucas1p2e176acc2f85f341f388a900eb35f7fa0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240222070824eucas1p2e176acc2f85f341f388a900eb35f7fa0
References: <20240222-sysctl-empty-dir-v1-0-45ba9a6352e8@weissschuh.net>
	<CGME20240222070824eucas1p2e176acc2f85f341f388a900eb35f7fa0@eucas1p2.samsung.com>
	<20240222-sysctl-empty-dir-v1-3-45ba9a6352e8@weissschuh.net>

--nlgf7jyuw2vaaq5p
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 08:07:38AM +0100, Thomas Wei=DFschuh wrote:
> The type field is now part of the header so
> sysctl_is_perm_empty_ctl_header() can safely be executed even without
> any ctl_tables.

Only comments on the commit message.
1. Can you please put this and your 4/4 patch together. Since 4/4 comes
   is a result of this 3/4 patch, then they can be in one.
2. Please re-write the commit message to state what you did: Something
   like : "Remove the now unneeded check for ctl_table_size; it is safe
   to do so as it is now part of ctl_table_header.
3. Remember to mention the removal of the sentinel when you merge 3/4
   and 4/4

>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  fs/proc/proc_sysctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index fde7a2f773f0..4cdf98c6a9a4 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -232,8 +232,7 @@ static int insert_header(struct ctl_dir *dir, struct =
ctl_table_header *header)
>  		return -EROFS;
> =20
>  	/* Am I creating a permanently empty directory? */
> -	if (header->ctl_table_size > 0 &&
> -	    sysctl_is_perm_empty_ctl_header(header)) {
> +	if (sysctl_is_perm_empty_ctl_header(header)) {
>  		if (!RB_EMPTY_ROOT(&dir->root))
>  			return -EINVAL;
>  		sysctl_set_perm_empty_ctl_header(dir_h);
>=20
> --=20
> 2.43.2
>=20

--=20

Joel Granados

--nlgf7jyuw2vaaq5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX5rucACgkQupfNUreW
QU/CEwv/XMjKtYlwmQtmbNIX6XHAb/Vylqr2p/XkMeSmWICOxe+59VJGKyhVLY76
e6z9IRpS42qH+fkx7DeP4KRDa5PuYX6UsFbhYEqXIJT6ep+Sji2XdRkRCxfVjvzc
P4iAejyZEcmFEMuEQ2oVhaAk0E1ZaMCrNe1hyvJ5xZzBCSOZv700Upasd0y9HTOW
CiG+x54R93+zLzzEROpRNqRYkObDzZJ8HWoHe2DZGNKRRtgkeNPG5kkE+mRsq0Dr
AuepdMyISHtBY6FdxIcpj2bAZxfGjOO21KU28bmgtBDngu+OMhFYfApRUlJ4R3Rk
WAOkq67ttnCkx857TRVWb0MpIjUlVs/a3J7LnoC8CLQ2CpgEJ4L71L7cJEs7h6af
CbdkWp+fjZW7C4N5HyhgXGbDYiQAYNvKjrAF5q/g0L+YztU8VxTJiCdrIMjhWEdA
9ooECsSlozx2evuTDn+WdmSnZbZmdxzhLMgTgQ4nVnNJxi13D0zGuHV129k63UD+
b1wVpBpU
=a/Sv
-----END PGP SIGNATURE-----

--nlgf7jyuw2vaaq5p--

