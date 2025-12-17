Return-Path: <linux-fsdevel+bounces-71562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C3CC7806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 13:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C96773055BB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184333FE1F;
	Wed, 17 Dec 2025 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHGkerYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDA33F37D;
	Wed, 17 Dec 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973356; cv=none; b=MkxMKDW7dWLoBuSNDZNCk8LBMXGOm6y+l9PYvDhtq/fFQtoeqXUG4Qf95AcXpfe0l+Grz5c3eu8gIpK75D7UDnMP8uoJOkV/CyVBBzC64xoSCOU6V4J86s6m8zRWO+9W+6DNEsw3VvpWvTNK3jK8HlCMqd/hYoPYMah5/OJ7IHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973356; c=relaxed/simple;
	bh=XqkQNpF8ME1hBE+b0FBunoFr4flf8biZ9M+St65icok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGd3l5kUg3WznY9FbrX0ksd8ayURoWO2Hm1PZu9w2B8UW1Wx7y1mNT7hXBSVq/GcAsnnb7W+Z6+00TCdSmzYoSP7UZhq/ocwih55snaQcC2cgBy/pgUweFAW8ecOQKGi2Smtumnsz3tanCvV5sGCziG+XqM9PVfiy+uSLv7/Iho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHGkerYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ACAC4CEF5;
	Wed, 17 Dec 2025 12:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765973355;
	bh=XqkQNpF8ME1hBE+b0FBunoFr4flf8biZ9M+St65icok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHGkerYQQpCZRqgTasBEJuRZlEi95UWbFNGNAP+ikltfrpTgTNoae+CCb+NS842NR
	 Nh0XnKWmz9EMIsQdCoPdJfG5Q5T/kK0s6XEyDh/flPZQfOisnWZnn6SFQA72hCdDJS
	 /xdVx0eZvGqOR8nlI2xDCykgnwq6PRZGnu4c6S3YI6KPBT/SHA8TuIT3HhZAf7mZIg
	 JdMPAgJa4vnqu+ZRPB1UVvhgTg+i1GU+HC+N9pP+wFUI0X2Q/TFThkv2yg2IOr6xXU
	 JqdpWlyzwFkJmz90DGyFFdMJNQ24qZa4tO0NC/ijz2DZKdrSNjIonLNOGPRNXGSBFX
	 PDyWtiBxgi4Hw==
Date: Wed, 17 Dec 2025 13:09:08 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] sysctl: Remove unused ctl_table forward declarations
Message-ID: <44x5syvqsqy4bfjdc5r5hfwhppz74vxa3p74diwmnlls26yox2@xccmzuov2afw>
References: <20251215-jag-sysctl_fw_decl-v1-1-2a9af78448f8@kernel.org>
 <aUFUIfVvRcYN3_ID@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hawgbyhlcibefy4q"
Content-Disposition: inline
In-Reply-To: <aUFUIfVvRcYN3_ID@pathway.suse.cz>


--hawgbyhlcibefy4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 01:44:17PM +0100, Petr Mladek wrote:
> On Mon 2025-12-15 16:25:19, Joel Granados wrote:
> > Remove superfluous forward declarations of ctl_table from header files
> > where they are no longer needed. These declarations were left behind
> > after sysctl code refactoring and cleanup.
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
>=20
> For the printk part:
>=20
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>=20
> That said, I have found one more declaration in kernel/printk/internal.h.
> It is there because of devkmsg_sysctl_set_loglvl() declaration.
> But I think that a better solution would be:
>=20
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index dff97321741a..27169fd33231 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -4,9 +4,9 @@
>   */
>  #include <linux/console.h>
>  #include <linux/types.h>
> +#include <linux/sysctl.h>
> =20
>  #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
> -struct ctl_table;
>  void __init printk_sysctl_init(void);
>  int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
>  			      void *buffer, size_t *lenp, loff_t *ppos);
> diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
> index bb8fecb3fb05..512f0c692d6a 100644
> --- a/kernel/printk/sysctl.c
> +++ b/kernel/printk/sysctl.c
> @@ -3,7 +3,6 @@
>   * sysctl.c: General linux system control interface
>   */
> =20
> -#include <linux/sysctl.h>
>  #include <linux/printk.h>
>  #include <linux/capability.h>
>  #include <linux/ratelimit.h>
>=20
> Feel free to add this into v2. Or we could do this in a separate patch.
>=20
> Best Regards,
> Petr

Very nice, thx.=20

I believe it fits inside the current commit (no need to make two).
I'll add this and send a V2. You can then add co-developed-by &
Signed-off-by if you want.

Best

--=20

Joel Granados

--hawgbyhlcibefy4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmlCnWQACgkQupfNUreW
QU8WIAwAlXDIVtCbnzQInz9B4QixLTMB7RpOH2nNcUQUwOUdE/qfX2Kbwu/dXjAy
CGdwiVkAQIKkjCQTarmTjAdefqugLsww8q1am99VByg9gmupsvM/F2u8y0rFXzoQ
pgWaLO4o5L+U6yyp+vXV2g0GKtNZc719cyIncUOPF3Cjr9p1M2Iob3psSrkzTsGa
1W4g9MUTpRCnPCgsnQKirmCZSvjfHghg2xJPgV/nPrR7WLtT7AgV/VNjJig3mP1t
VDvkXoA0nIPfdiT9wBWDRO4UaacUIJyAglb0rXSIDarH3un2KgkoPdH3gJk0akmO
k8iquu/T9Z4ncxoyLkwuq4W1xvueV436iYn493pLhdr1qqZPsdZq6Tr42rgn/441
ccJJtwwvS2pdFlAttoOv70l1ZZAtG158VHtAOSXedkDiqWxSWnj6tuJIf9VmAndn
4Ngz8GGzJ4nj9m0LJl51YoD/1G6i2j+UQK0YV5vjhX3f4eQfiJ8nstHdNvRUWZko
AJWhoOxU
=u1jZ
-----END PGP SIGNATURE-----

--hawgbyhlcibefy4q--

