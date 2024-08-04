Return-Path: <linux-fsdevel+bounces-24949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1F946F25
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA01F20F44
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86056766;
	Sun,  4 Aug 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="VO5GPWW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0DAD55;
	Sun,  4 Aug 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722779895; cv=none; b=A6Hd4mWA+5ejYxSP5pqc5AOyF8tsm6gKd816yB3a9cdqRkgHR6dtmgfOxU8l+ocyTZXtJ8QLjlWirubtCo6iAYFFwZ06q23rdKNNF2UpKrJk4Ul6gTuimla+LtHlmpvqWNqD7wFaQHPdSMyYvdNxIBHRdFSEuyyqzCYVQjkfAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722779895; c=relaxed/simple;
	bh=ETnqFYAnoHQIpW7ILDV1tL4TbB923ixWcTBW6ZXtE7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5kxwdDi4hHR9pGYMP44GMV/WSaQ6a98a4en13Zayacb3+FIdL+Whq2c9cy33X1+znioZqUxNlIUzDjjK4XU8SFM0BZEMf+/xfB7O+5ivj5rQyQnNJEFkOKpyCENKKd8AjSaJOWTdgFEjmrzk017CgpwK4/M9ODSRzflje7BXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=VO5GPWW6; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Type:Date:To:From:Subject:Message-ID:
	Content-Transfer-Encoding:Reply-To:Sender;
	bh=2BHCBiQNbBm/UXW3qyZfWY7r56zwJfCgAUwdjP+slDw=; b=VO5GPWW6bNLuaZhCNhpRgEmY8m
	vK+pXGaKWYYUuxFZ1jI3m1Df2oKtLE8+ZfuEjbzS5p6hslaayQoREf/7Qbq2pVQxPTNauLjFtfJl5
	fBLzQu+FMh3bn0yGQd4anBjYmE9uQudZUK87Lit1w5Z8mqfTSEAHzcSFSdY7bO9rQf4yLjxiiOnm9
	gGQEgsp7APlOTmg4cmN8nmoO1SsGcEXOepO0BClZgb3TJdPmfh/fE3ISgbkyoReiFxj6mZDpuLOm7
	Mhtq1wwOeLtsQFsT3STlSHR1ZVYKbUaEagkS4xO+qSGjKqDRqC4DMYtAf33l9ah1NW7d3/EAOICIC
	68a1Z82AVV60aLRhMsbA+S+Rf9gQGLdrbZmDHSq2xsNya6wN3nVxHxTkS0glPJtIBm+49YItUvk0O
	RoECRWB1kJsYHCJ0XORFc+t8qQIbDl4baVd8CLv/6Ik3BGC42A9fhyZXq8YurDNDho1i06cgSEzLg
	kWABAL8erDUajjNZD5pwDYUNSrh7/5gYUCrpev4UhqQI577HwD1/hXKCxz6d0oHMygTlA0Yj5A4ym
	lIFZslQlxyKxasf1oSSNpA3dAWq7x5hxwL5lIlmHigAVwoneGVxOoPPFsBGqcwSdAiXwzv+9fgIO+
	G4QNVe8Ek1ol0AdynLOhL/q71xMBuI6x7FCBG2pJM=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1sabkD-00000003j2d-3j0q
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Sun, 04 Aug 2024 13:57:57 +0000
Received: from a1-bg02.venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id ISajK+WIr2Y8jQ0AT9YxdQ
	(envelope-from <hristo@venev.name>); Sun, 04 Aug 2024 13:57:57 +0000
Message-ID: <845520c7e608c31751506f8162f994b48d235776.camel@venev.name>
Subject: [PATCH] netfs: Set NETFS_RREQ_WRITE_TO_CACHE when caching is
 possible
From: Hristo Venev <hristo@venev.name>
To: Max Kellermann <max.kellermann@ionos.com>, David Howells
	 <dhowells@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff
 Layton <jlayton@kernel.org>, willy@infradead.org,
 ceph-devel@vger.kernel.org,  netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, blokos <blokos@free.fr>,  Trond Myklebust
 <trondmy@hammerspace.com>, "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>
Date: Sun, 04 Aug 2024 16:57:38 +0300
In-Reply-To: <CAKPOu+-4LQM2-Ciro0LbbhVPa+YyHD3BnLL+drmG5Ca-b4wmLg@mail.gmail.com>
References: <20240729091532.855688-1-max.kellermann@ionos.com>
	 <3575457.1722355300@warthog.procyon.org.uk>
	 <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
	 <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com>
	 <3717298.1722422465@warthog.procyon.org.uk>
	 <CAKPOu+-4LQM2-Ciro0LbbhVPa+YyHD3BnLL+drmG5Ca-b4wmLg@mail.gmail.com>
Autocrypt: addr=hristo@venev.name; prefer-encrypt=mutual;
 keydata=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
 AjQ6o01lu
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qzV6eqKdREc03lDMjxSa"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-qzV6eqKdREc03lDMjxSa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In addition to Ceph, in NFS there are also some crashes related to the
use of 0x356 as a pointer.

`netfs_is_cache_enabled()` only returns true when the fscache cookie is
fully initialized. This may happen after the request has been created,
so check for the cookie's existence instead.

Link: https://lore.kernel.org/linux-nfs/b78c88db-8b3a-4008-94cb-82ae08f0e37=
b@free.fr/T/
Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio->private a=
nd marking dirty")
Cc: linux-nfs@vger.kernel.org <linux-nfs@vger.kernel.org>
Cc: blokos <blokos@free.fr>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: dan.aloni@vastdata.com <dan.aloni@vastdata.com>
Signed-off-by: Hristo Venev <hristo@venev.name>
---
 fs/netfs/objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index f4a6427274792..a74ca90c86c9b 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -27,7 +27,6 @@ struct netfs_io_request *netfs_alloc_request(struct addre=
ss_space *mapping,
 	bool is_unbuffered =3D (origin =3D=3D NETFS_UNBUFFERED_WRITE ||
 			      origin =3D=3D NETFS_DIO_READ ||
 			      origin =3D=3D NETFS_DIO_WRITE);
-	bool cached =3D !is_unbuffered && netfs_is_cache_enabled(ctx);
 	int ret;
=20
 	for (;;) {
@@ -56,8 +55,9 @@ struct netfs_io_request *netfs_alloc_request(struct addre=
ss_space *mapping,
 	refcount_set(&rreq->ref, 1);
=20
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	if (cached) {
-		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
+	if (!is_unbuffered && fscache_cookie_valid(netfs_i_cookie(ctx))) {
+		if(netfs_is_cache_enabled(ctx))
+			__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
 		if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags))
 			/* Filesystem uses deprecated PG_private_2 marking. */
 			__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);


--=-qzV6eqKdREc03lDMjxSa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJGBAABCgAwFiEEb/2s7vGPWBH9BOGpSkmD6rj9B8sFAmaviNISHGhyaXN0b0B2
ZW5ldi5uYW1lAAoJEEpJg+q4/QfLPM8QAMlcnpejkhomlkis4nCVv0M5EBzHsPIo
YWJIrylG81BSH9p2adxgqmzq17G4uYScKEm961qyFyIo8uZNLKWA/5tzCnjeC8sx
dkyqAnMFuxoG2oEWC++6Z8F45NPxFKrKzIKXB6Fq8JObXHlKV2VXdNDEHCgZFV6d
AadswPY/YLQi1hc/akw7TAht3IcSUdPCcfWifeOXcGcCoNqEz+D8Gi6VKRJmJkh/
KDF2MpM4sX3w3R3sTBnhIeM+PTLBvV65N/Brqty3UM4HFAEdwPhksIiOTaoUwXXh
VNMjifa335G8XPTa8PI2zi9vmO2yzwLzrhdvfWnE8q2LaiAMnPVYiYnP/xs3FdsZ
GVgCWXEVXRcC1c/CyObEO3muwhFcD3eYo93yDw9nUmD/Zh4PMYqxeiL/C3j9EMHb
Mc/wamhFQToRa3gZcORi3Bg94dRWPGLuWsBPGP3o04VaOHzveF5aW9oLZtcRedsp
NQP2nsO7OuTcecCwPihmwWYE2JW1ygyj3Pp0NwdF1Ttn+HG7+Gj6V7Psraoq8IRL
+wNKdzC4+bbdCnefQukR6JF1olapLWvuBYzkfDRtebFE3x8zpvbWYpihw82rM81a
pvsmHVcQSfPbShpjOxFfcLCYhBmUzgDXgwbWk6hvY5pX3GWnXcOae713wodUbHD8
3/q6OoLkyoOl
=/GFb
-----END PGP SIGNATURE-----

--=-qzV6eqKdREc03lDMjxSa--

