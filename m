Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED14B64FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 09:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiBOICF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 03:02:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiBOICE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:02:04 -0500
X-Greylist: delayed 318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 00:01:52 PST
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004591D316;
        Tue, 15 Feb 2022 00:01:52 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id C7A1F58958B; Tue, 15 Feb 2022 07:56:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from [10.88.129.190] (obninsk.basealt.ru [217.15.195.17])
        by air.basealt.ru (Postfix) with ESMTPSA id 12D0C589436;
        Tue, 15 Feb 2022 07:56:27 +0000 (UTC)
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
To:     NeilBrown <neilb@suse.de>, Ian Kent <raven@themaw.net>
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
 <164444398868.27779.4643380819577932837@noble.neil.brown.name>
From:   Stanislav Levin <slev@altlinux.org>
Message-ID: <c1c21e74-85b0-0040-deb7-811a6fa7b312@altlinux.org>
Date:   Tue, 15 Feb 2022 10:56:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <164444398868.27779.4643380819577932837@noble.neil.brown.name>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pD5O09yoODx1alNwerPtyi6o7EC1qi5Ab"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pD5O09yoODx1alNwerPtyi6o7EC1qi5Ab
Content-Type: multipart/mixed; boundary="6zcs3mLrVsX7jMaOke8gYrDQxKCsFuysk";
 protected-headers="v1"
From: Stanislav Levin <slev@altlinux.org>
To: NeilBrown <neilb@suse.de>, Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <c1c21e74-85b0-0040-deb7-811a6fa7b312@altlinux.org>
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>
 <164444398868.27779.4643380819577932837@noble.neil.brown.name>
In-Reply-To: <164444398868.27779.4643380819577932837@noble.neil.brown.name>

--6zcs3mLrVsX7jMaOke8gYrDQxKCsFuysk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



10.02.2022 00:59, NeilBrown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Tue, 19 Oct 2021, Ian Kent wrote:
>> Hi all,
>>
>> It's time for a release, autofs-5.1.8.
>>
> ...
>> - also require TCP_REQUESTED when setting NFS port.
>=20
> Unfortunately that last patch is buggy.  TCP_REQUESTED is masked out in=

> the caller.
>=20
> Maybe the following is best.
>=20
> NeilBrown
>=20
> From: NeilBrown <neilb@suse.de>
> Subject: [PATCH] Test TCP request correctly in nfs_get_info()
>=20
> The TCP_REQUESTED flag is masked out by the caller, so it never gets to=

> nfs_get_info().
> We can test if TCP was requested by examining the 'proto' parameter.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
>=20
> diff --git a/modules/replicated.c b/modules/replicated.c
> index 09075dd0c1b4..3ac7ee432e73 100644
> --- a/modules/replicated.c
> +++ b/modules/replicated.c
> @@ -291,7 +291,7 @@ static unsigned int get_nfs_info(unsigned logopt, s=
truct host *host,
> =20
>  	rpc_info->proto =3D proto;
>  	if (port < 0) {
> -		if ((version & NFS4_REQUESTED) && (version & TCP_REQUESTED))
> +		if ((version & NFS4_REQUESTED) && (proto =3D=3D IPPROTO_TCP))
>  			rpc_info->port =3D NFS_PORT;
>  		else
>  			port =3D 0;
>=20


This seems duplicate of https://www.spinics.net/lists/autofs/msg02389.htm=
l


--6zcs3mLrVsX7jMaOke8gYrDQxKCsFuysk--

--pD5O09yoODx1alNwerPtyi6o7EC1qi5Ab
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEyZWA1UChsdCFaW6bq6v+jV2aGegFAmILXKoFAwAAAAAACgkQq6v+jV2aGeiJ
/RAAx4QAOWVv70H3pf1Jzh1zWh+43sO7rXYje+lpiILwkq40XwbipMfDoPvYiLvJP8nEm0svsCMT
R8rhluLgTpRF2wLYvJmcxBWbGVkGsOms3jMVg/pBiX4JEWS8dxKtb9Xbth1vbm+rUCueKplQHtm0
ZfMCcP4tz2i7OJEzYZa98B6y0Z05dknmEm5OQwGjsKRm/2G/Q93U+SaHfSpDqHMlg4QE3AeNg39s
EjCpn33ubQSP+Y1BVCMLYRe9O+LCMMho2vxo1s5gYUHJ605erc6K27mVYm7qlJqaPAX0Lk8Fb9Py
9AfgVTjs44lPK0s0aoT8vjW5cszIjQTate/rgYJpvPdktrxU4Q0oMJDFTuR8VDtT8/qDfhvdq7Fa
Ov4Kh5s8GbSzMeWb4ojAKgUXwZxj9pMzApoB36nozo2kY3U6rSjXZRy9veiporOJd0yZ2DwSRU4g
AaBaxc4S9hIt2ijNjZy2nuSfH/IbfpGMSvqR0R1Iv3b9cbDOsgdb/EUz44sI/RAgLH/BAdnAim3e
Mz2Fwlmfuy/q71iyJ0GoeFYGmOXhMy7AjpF4VpxssF4hyQxlfGN1wN/eYHVhdrhnLN6juSKo3NNN
5bMEwYbfAUX4mhZL/xwJw5dI2Ur8VqIEGd5KgKYZrHLsMgpmOh46zXMUV3s8YfxJOxSRiWWTWWrx
Pq4=
=LkuI
-----END PGP SIGNATURE-----

--pD5O09yoODx1alNwerPtyi6o7EC1qi5Ab--
