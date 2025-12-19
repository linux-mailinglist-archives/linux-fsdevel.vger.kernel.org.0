Return-Path: <linux-fsdevel+bounces-71725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8762CCF85C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37E6530382B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA930274B;
	Fri, 19 Dec 2025 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E962sNsG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729D25DB12;
	Fri, 19 Dec 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142213; cv=none; b=KE/oeGPN2PukxYzsXN53wcRZVEz1/9wfJBywBqsE1RmeDSViwwmQgShrCeM58K950wdI6ZkRfFWFh4fdoGPwGrGaZJLfEV69QbwqYILB+ZNxsHD3YO1m5wDYlss0gePyZlFO6AeFtREdlGCeqekvBLtykcJdPT40u6sFKC5MMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142213; c=relaxed/simple;
	bh=g14yl9i9+AK6qWvA6aeqtfF+c/gqKut5NJOpYy6/dws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifPYBBg9OwQY+32a3iIfIrMBBpHarYVUyGXmymxgUclKXZopn6XXYDqOBshaFw+hSLmdJS8g8pKmarbruABhFyYzxQMWUllZdqGrjbWw8NWFBz30wxXZJALJd9cV3OWu0dyIFfo2YFAD2/NUvpauQ3OExEQ2hS50TW/1LjrmgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E962sNsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA33C4CEF1;
	Fri, 19 Dec 2025 11:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766142212;
	bh=g14yl9i9+AK6qWvA6aeqtfF+c/gqKut5NJOpYy6/dws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E962sNsG7HqmES7DwgBTkN28N+PdGLU4AtYL7zi/A15/UrK1O6Hn9d+TIfGujwL4A
	 L7SD+X1AgujRqtFHYjuVEpivXXRXSHjI7MH7uPNSJt3/ORBECb0Kzd8MrfnfvFunRm
	 Xzq8J5Ru0YiWvE05wjl8rm+y4crWywZpJd1Qel3nkCPDh1Un667nZa1KxaOCzd/kbi
	 e8toKnXzFDztY0xg9vdlHFU/fj+aq+zV8nD3IPb9z9pw/csnY+eb/nYrifFctxJra7
	 5hHcC/4Buui4ZRMV9gjEVg11DupMHJnOQpswsw55bov9KCptGYLnUuzwznDyjIxkEq
	 47TQFs5jjL8fg==
Date: Fri, 19 Dec 2025 12:03:26 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: Remove unused ctl_table forward declarations
Message-ID: <warv3zwcd4o3rbowav7bhziz6w6lzsuqeeiq4ekpqyj76jwuxf@jmodw3stxult>
References: <20251217-jag-sysctl_fw_decl-v2-1-d917a73635bc@kernel.org>
 <1491a7c7-3ff8-4aea-a6ee-4950f65c756f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fod3fa63ejffuubd"
Content-Disposition: inline
In-Reply-To: <1491a7c7-3ff8-4aea-a6ee-4950f65c756f@redhat.com>


--fod3fa63ejffuubd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 10:28:31AM +0100, Paolo Abeni wrote:
> On 12/17/25 1:16 PM, Joel Granados wrote:
> > Remove superfluous forward declarations of ctl_table from header files
> > where they are no longer needed. These declarations were left behind
> > after sysctl code refactoring and cleanup.
> >=20
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Acked-by: Muchun Song <muchun.song@linux.dev>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> > Apologies for such a big To: list. My idea is for this to go into
> > mainline through sysctl; get back to me if you prefer otherwise. On the
> > off chance that this has a V3, let me know if you want to be removed
> > from the To and I'll make that happen
>=20
> For the net bits:
>=20
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>=20
> I'm ok with merging this via the sysctl tree, given that we don't see
> much action happening in the ax25 header (and very low chances of
> conflicts). But I would be also ok if you would split this into multiple
> patches, one for each affected subsystem.
I'll separate it, if I send a V3

Thx for the feedback.

--=20

Joel Granados

--fod3fa63ejffuubd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmlFMP4ACgkQupfNUreW
QU9qUwwAlmPvfPWAZXoczrqNX10TSmK+zcMEjDLQKvStlSwsGocQUBWnB/M8tJtm
1DYS6640oD5VprVd6eSw19rI/ahQRB6T0o8DoW2iwUN7wzaIMCEdIUtp1Zorr1fh
UWhAlu1GdFI78+PucFOwbvHuwdNpRNkyUT4lumBWNaXVijjDlq2hz9wlXPoB3deU
KsOQ+FfX2H/Znoeml2GduNPeWKXZU1kU+qi4XrAX/WHyYb6h+1Ez9CU59xvngKxL
kWKWpPc5rHlB+FoPsMiwuktdZhn0ThIIAhYTTe31QAfydLFPY8wtWRQ9XnE/jAuA
UZaGmli8UP0y38Id5gV8/mjXYyB2ovQLK5XT5XkFW6ohJscZGZ8l5EIWkHsLUInK
0/k97WE179oY00w9IBJdxO+xs5RdQvqpciXOeuAjj25vRUS4LZg2h1qlOiw16T7P
sZnkXjrb7rcUXaeM0WdpblGdKtYwKA8VATOffK6wgXLDe+gf3ISdZM8LVPmc21wK
ECPWoOA2
=E/xk
-----END PGP SIGNATURE-----

--fod3fa63ejffuubd--

