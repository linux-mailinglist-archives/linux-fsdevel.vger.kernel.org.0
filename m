Return-Path: <linux-fsdevel+bounces-24634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD1F942127
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 21:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43B4B22BC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3818CBF4;
	Tue, 30 Jul 2024 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="O+P8dBOV";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="S1d/U/Hc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FB83A17;
	Tue, 30 Jul 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369529; cv=pass; b=AfHRkA1p7FUUWRyHlC5vf9e+vqwZbfedEAiqk13nhaivJhefwLAE1II+HkeAVxpG3l+LRplBDHmoLrt1gBjWS3PFOKBihtvgeFwwzrT57+gbLA6vWFFLI4TQyNzLqcYNKcVR7YRc4mPgPhMFyCyU1L2xXGgxglZY9hmLDe89HWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369529; c=relaxed/simple;
	bh=rXllNwgPg9V8TBY10KyD+qXKZdw2EfkkClgM1/RQCZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTNg7zuzd3mFXur1WvHBpivtdHATnbWP/Bxltl7LrGrxqZeOaJ1KNcWPxn9Aco+hkW8+/xFB1UBphNtZwkptZVcPO2C8c8lq63+FEQAG4/0UGOrO+irDSpzfvwVvrMMFJZARo7W26IR/SpEqyIAYwIHWPCdwm0LD7LgRDNC/eto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de; spf=none smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=O+P8dBOV; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=S1d/U/Hc; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1722369518; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=B2vVThl62f1Q0+3QFP+0zZ2iFfaajdC9qylZqbYAQ543Qx9yn656ClO3VtitjllClr
    CIfH1HKXEcCYUKrZBG4CG/wtcuNisb9vYiUPg7GayCBWIqmp+chl8vdGQnvYdG7Ohm9c
    SCzvXqq5A4cy3cQM71Hnfxwk3Xpiy8aq9OhHWQGzcWUb692HL70CyPEEUD0Oqg53eV96
    rAF69suhfjiw4eszIYJdI+uuQVPfOQv0Oo37DV4q2YR3bbxbO0FWpFD0fNGas7yZx6Cu
    GEQQqD+UUzdA1rwRaoUDEHDkxXN7+pw1gRJ4bbVjvWXXIIpHU9i4tsZ4cuza26bUf+6N
    GX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1722369518;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rXllNwgPg9V8TBY10KyD+qXKZdw2EfkkClgM1/RQCZk=;
    b=RTPLXjE0Ymjfl3sMVpOLDJRtMd8/gNry2u05R1HziVHzZSEBt7Q/foI4IHZ7FfhpnK
    ZxIYcBzQXbmws/mNOQ6t/AMc/JOHTGWJPXt6VmuccnzaD6GFGZadKH8BWJhGO0LZ2Xlt
    e5d9hptw9Txs3mY3QA2VkU4NrbX9hTihie8HZvBxZYrvDnpMFlJYt2Bw13FvbV289lUa
    4OT5iWcLTIHRgAUHMG/5SZmG9P+1h608AcB2sznnCHgnVZ9v9hz7iov4/PUl1h7N3YpZ
    puRnd+BS3UOC8DTuIDk5s0DVluqM4LZkZqtSOSrXBcDQAvVjavpjug9XeKTAav6O7Dl5
    lMrQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1722369517;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rXllNwgPg9V8TBY10KyD+qXKZdw2EfkkClgM1/RQCZk=;
    b=O+P8dBOVZpEMXNQBMHfelGXi2QhLXZ6BN0ak9thtUW5Tj2H536dqHwtfqszF9tTW+m
    jrTFcNkjiRXsJoOpPSQGhc6qcW5F9kvhON66j69Z2tkDGg6pdk3dXu3LtXvbaThvD8Q6
    fmYns72yOUu3CZIZuTvI1v27cAnBn76BTGH6sHGqqtqPulsSDB7CDm0JB6ILYmHz3QS5
    UVlKgV0V1LrgKN/n+xjUQjj4L39/qzw8aXY0ukGv61P1w8K5g+MZRwPmxgGKeSKaBoPP
    AtdUR5e+J7itM5PciUyhptLStXoZTFEHrDNa63xKp2BeUsM8cQ0USNnFcvEQ9t1gLRrl
    3c9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1722369517;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=rXllNwgPg9V8TBY10KyD+qXKZdw2EfkkClgM1/RQCZk=;
    b=S1d/U/Hc2aD3qoFv7iaecmh1MJz5KpiLtamCujQ3hkr9zUhwDHPmEb7VzeSPAMLCcj
    2fnCXxfFKCazL0lw7rCA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR5WhGIY03sl8P3E8+0INaYkLbLK6amJ4tjV9TKUg=="
Received: from sender
    by smtp.strato.de (RZmta 51.1.0 AUTH)
    with ESMTPSA id Da26f206UJwbPFT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 30 Jul 2024 21:58:37 +0200 (CEST)
Date: Tue, 30 Jul 2024 21:58:27 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>
Subject: Re: [PATCH v1] mount: handle OOM on mnt_warn_timestamp_expiry
Message-ID: <20240730215827.77b90c8a.olaf@aepfle.de>
In-Reply-To: <20240730154924.GF5334@ZenIV>
References: <20240730085856.32385-1-olaf@aepfle.de>
	<20240730154924.GF5334@ZenIV>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZiFKxp.EPGj5=M_RD=QwsTu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/ZiFKxp.EPGj5=M_RD=QwsTu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Tue, 30 Jul 2024 16:49:24 +0100 Al Viro <viro@zeniv.linux.org.uk>:

> d_path() is *NOT* going to return NULL.

The existing documentation does not state that fact.


Olaf

--Sig_/ZiFKxp.EPGj5=M_RD=QwsTu
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmapReMACgkQ86SN7mm1
DoCBQQ//YkTVdDlvslQv03pTYTIg+dKeFTXz/SA2mQjxGAHWmHr9m8PHoVgj26JM
Lzj+WMErLr6ooPKjCqCN7Fs5iWkhKWZaXZVXPweLF03Q/dy+uCSB5FIeXgClkyWz
d8BzzVO5OKenAmHoM2GK6IL82UaTJoTCYk3SUEdTD9yurrGrb8STh4mTEoZ6dYIe
KKzASwLqx2yFisB8vXU0KPjr9X0DHX8jUa7WiEo5HnT/yc1WPD1GpEpgb1gMILs/
4QdtDzHXwte58cTtLivj4jHmllelF565pBIw785eWR7cXc/PcGAp7NTFaEnNjgUt
Z5vYoBTdMzQCPyvohzr7budI/hJ2apDLlObxOidF0B+DX8/xq9MAr2837S7C5xiI
urK+I1x1cAT0AkxqUlxLnDykMFiTNqtA7XZ8+qbsGmHD90PaYU9snUljJaEHJStf
U3J6qR4HzMY3vbjCfWO4j4R3ZkZCJVh4BRkJv6+kPkwKZ5slG8B6Y5eXkuf3gsYK
wNBb1tIaVQIlyOIrh13b3fVSPj/l1GV4hIfvUQSzD/ufCPrJySPeub43kurQ0tYN
D7UV7G8kFLhjj6XYQqaRLmyEictbqum281dMzJN0YObL/B+GDG++69swY7sO5fmd
E6XCzBce1PYPm0ai2O0vm32mDJnIz/SO3gyvrsqPewlYxQJVNx0=
=/miM
-----END PGP SIGNATURE-----

--Sig_/ZiFKxp.EPGj5=M_RD=QwsTu--

