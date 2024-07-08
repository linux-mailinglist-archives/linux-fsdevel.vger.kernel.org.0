Return-Path: <linux-fsdevel+bounces-23337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF11792AC29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489FAB21E04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7B15216A;
	Mon,  8 Jul 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dpwvwY/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9247BA46;
	Mon,  8 Jul 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478431; cv=none; b=IZ6Y1DunAGYN+qQCXlxivL+STO0B528d3fL65/BrkV0oxvoKcs/Wf9nb+4hHIIilO7QZlTuDLWZ42TIQDIY4slccxsmnA9IkamCWkVbW+oTN07D25w+ByU4ZF5oncWWs8Vjf4ncoNv8ofvkIn+G2GlMk3AXbZbWd6gaTmTRua+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478431; c=relaxed/simple;
	bh=Y+fx4fpIucpE9e+Cawa83tszGtQwTDdtG4YO9idMM2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDRfo5QZb/sWx1rEhWGyXQM+FHxnTqfkWk5Oi2WVMyy2SOWMH53uk3GkWxW11aOXIMf1a+Uf5EuXpQZ14E5WkTmFg9gEW8Sg44PY5jla3L/j4fITCakn7W5BqgPgPlMiTCbqHVpXlB57PoBE2oh8TcOni5G3jmzP0awNhPbdK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dpwvwY/U; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1720478426;
	bh=QQAQQkdk8Jaqn94wbZ45muQhBVLtRyyS92LUavUzSI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dpwvwY/Uckp8RCxdV3v3xlCsEoznj31uOKBJ0RuxXvtKzimrsYSed9Dkduzhhur2Y
	 Yf9RWVvZEJQp/KIIgS994y/6SL6VgNyaAuRscJICWOpjFsJce1bIBQXc+oM7cDOAWJ
	 CzFwzxKZ7DICiM4+XTZRxY9dOWhWGvqwLJhOGsSieudl9nr4CfDnmHZIqvi0atTqhS
	 t4gPkYkIFwmseelHYKh2A9d7xtMVOyPUyZxVf7H6+pBuI/PaVMyKr5WPJHY+Jex6D2
	 2xSEAp2c/+5J1DFdXwQDTf2UeO2LWTLkx7baL2cuB6cMZUpgqPz4fWj0w1yo72HrVI
	 ViBB1tS2xLH0Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WHzbX3TQXz4w2R;
	Tue,  9 Jul 2024 08:40:24 +1000 (AEST)
Date: Tue, 9 Jul 2024 08:40:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Chandan Babu R
 <chandan.babu@oracle.com>, djwong@kernel.org, david@fromorbit.com,
 willy@infradead.org, Christian Brauner <brauner@kernel.org>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, akpm@linux-foundation.org,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
 hare@suse.de, p.raghav@samsung.com, gost.dev@samsung.com,
 cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan
 <ziy@nvidia.com>
Subject: Re: [PATCH v9 00/10] enable bs > ps in XFS
Message-ID: <20240709084023.585109fe@canb.auug.org.au>
In-Reply-To: <Zoxkap1DtwZ-1tjI@bombadil.infradead.org>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
	<Zoxkap1DtwZ-1tjI@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4M_36_MgTLNnz/OVpJR=2TC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4M_36_MgTLNnz/OVpJR=2TC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Mon, 8 Jul 2024 15:12:58 -0700 Luis Chamberlain <mcgrof@kernel.org> wrot=
e:
>
> On Thu, Jul 04, 2024 at 11:23:10AM +0000, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> >=20
> > This is the ninth version of the series that enables block size > page =
size
> > (Large Block Size) in XFS. =20
>=20
> It's too late to get this in for v6.11, but I'd like to get it more expos=
ure
> for testing. Anyone oppose getting this to start being merged now into
> linux-next so we can start testing for *more* than a kernel release cycle?

Yes :-)

The rules for linux-next look like this:

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

We don't want code that is not going into the next merge window
creating conflicts and possible run time problems wasting time for
people who are trying to stabilise code that is destined for the next
merge window.

--=20
Cheers,
Stephen Rothwell

--Sig_/4M_36_MgTLNnz/OVpJR=2TC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaMatcACgkQAVBC80lX
0GzrKQgAon1mNs85HS22XfZW+bm6lIq/viWGZS/25DNtt88oTXKK/u943VepJ9p5
ROeymG6GQZvOH3WOj2zclQDnw6QwcuY4hW6QpSNB4+Hebl8h8QIxysYheQvv0m8I
lP0t4TzSbXgjHWfEtAj1pNSo9eknneN/4AxE+8I+IQCT4ZnUzc0ay72bbUM5/RQo
IY+eQP9sDSnWa6pb7ts7Q7VaoXZExOms4wBLWsPUIel87l74Xnq7Eh0v/OgII/6v
6yN0oovtRSsMlh26F0u9vFraZJer3ku7bAGVJdsYeT8cVx2U3bhumc6tNPRUh76a
f1gq9HK7WAaroxb4nr8ZJy9KztDLxQ==
=EBTm
-----END PGP SIGNATURE-----

--Sig_/4M_36_MgTLNnz/OVpJR=2TC--

