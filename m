Return-Path: <linux-fsdevel+bounces-18905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42648BE4EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446BD1F23616
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721A015ECD5;
	Tue,  7 May 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcAOmYu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87A161902
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090076; cv=none; b=uGWbCwpIVn6RKZcBhjv+6aQqumM+I9+pFJUBmqaQv7LHRZvN52IXsdcpZIMyxlxefB8sV/gY18txSTKdELv5EITgkSJnIdozeVYCEG+vcfCsKULVe34GXqXHqlCiWHEF0drBV8LAEVQRNxBxQicz6+s8Kjqnh6yEFmMdUYJY/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090076; c=relaxed/simple;
	bh=yyJxObKOAPxvrLe8uwdtf2/JfAl1PJSbyG/kOEUNzC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmLrhJFqALy7LnSL+0zfF3yEOiPGUWjfxWeCo7HKqbD+XQHAC1fjsw6tu6vmtVG5rh+c3j/t+yPSiODr6Ym1SoFKik+JDhGfSTOOX/1ec9MpjIS9rUM7HJgjeRJhr6/qQe6Jd9i6LDKkyjnVNP0st8m7p/IoM7S9an5jYbkvqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcAOmYu8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715090071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0imT2gu8FwFPEs6eREVoHmvoP31aEX/ubPvNn826Eo=;
	b=RcAOmYu8Aqv+Vw7dGTOXNvrUUWARHXDtHXw2AHwe48D3ez9mayogxZqt0z03zkW2YIyrcW
	LY9TDi7Cd7w68ALR48O5XanFw+jaIntbaqQPcF4d5YbelQ8V/1KIJ/BkUvAVrcX9btGm7/
	rG6ZJJqTa7ib2EKAavsLkxfwMeHLXxc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-9iXKYi4rNuC-PZ2w1DkORg-1; Tue,
 07 May 2024 09:54:29 -0400
X-MC-Unique: 9iXKYi4rNuC-PZ2w1DkORg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 297071C0C642
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 13:54:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8360F1C00B17;
	Tue,  7 May 2024 13:54:28 +0000 (UTC)
Date: Tue, 7 May 2024 09:54:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	vgoyal@redhat.com
Subject: Re: [PATCH v2] virtiofs: use string format specifier for sysfs tag
Message-ID: <20240507135426.GC105913@fedora.redhat.com>
References: <20240506185713.58678-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FpWHDssK5rWsSVdZ"
Content-Disposition: inline
In-Reply-To: <20240506185713.58678-1-bfoster@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


--FpWHDssK5rWsSVdZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 02:57:13PM -0400, Brian Foster wrote:
> The existing emit call is a vector for format string injection. Use
> the string format specifier to avoid this problem.
>=20
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>=20
> v2:
> - Drop newline.
> v1: https://lore.kernel.org/linux-fsdevel/20240425104400.30222-1-bfoster@=
redhat.com/
>=20
>  fs/fuse/virtio_fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FpWHDssK5rWsSVdZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY6MpIACgkQnKSrs4Gr
c8gTFAgAutKUh+fpkhbxhxw5ozVu8XtKHyJGVjYrug7d84mBOhqfN/IPOcrjSA2u
T3DhJgofVtk6B6BnB+tINBtYLF9dQ4jLCL2yRtKvwMAR7F4uJ5sR4Pe6qezZc85B
NxmeSzaEsCUn1PMqUzAD5plwsBke2sZBQwkbDkFoxDRN6t/1E48JiHPBmrsqupDp
AcIuitOv4FrSUq3EhLMHJdoyGmTdeFbqrEBdMhQvTup1V0fwJvA+csRV6ke99gpc
Flo8vhEPdstzKWj7hNbuyH8NO3jt0D0StZCWIPB60tO6vFEo8JvFazFkHAN55EEV
6M3Y1xDYud26rNYi3g5ul5/Y5fwWeg==
=pJS7
-----END PGP SIGNATURE-----

--FpWHDssK5rWsSVdZ--


