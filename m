Return-Path: <linux-fsdevel+bounces-28788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D072796E366
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D194B2134D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71AB189523;
	Thu,  5 Sep 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3EYiWiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFFA1FAA
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565541; cv=none; b=ssdCopeJ214IUaV3TvnMPjPQZlRWBsSIKONMJ+q3kRVqMPqJpIW6NRFiUru8qNhuyLYQzEf1K2/GNmPrqPqimRWGKsUSa/4bYWNBaHU536aSCtFMZGkTCGRygZJ2zK9b8I11FDa/H0kA99lU22nk0gEsBfNXF9yjSSoUk7F/6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565541; c=relaxed/simple;
	bh=Jf1uKQt3/Tm4VobIr8b8H4IxFcOU6MDzUXxplh8vvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCBfIQ35Ne8Cd25PPvKQ8XufxbgB+tBnqrIvjtLxq0n8+t/OLANdDnqBA/yuf3te0GFd/zVRxla5VMGnTVScsZQ7cmhYMfy6d5QUon60tTKlpRNpQBEVkd0IxfwN/vwTETQy0ETXbCH/pteiMNG0jFmdIO+1geaF44kmjCrg70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3EYiWiQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725565538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AGacaxAAjakpmdXm9R3HfKpJuXEtd6/YrI0SAmI7STY=;
	b=M3EYiWiQtdQqNIiUpeRcuXoUUl9wYDqfFJ/VQiuw3R5fuHah1W4DsaxGWtt3H4H4A+S43g
	PYaO3scKk5RDdeEGgvQSx/YyKjvj1x3ed07nKduzvMCVf1AiSUQqJqxOxqc0D6/GCMa8EB
	GLs0qNWYKxip9Hu8w1x/YnlqNnT4ZU8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-rWxJIJ5UNDek0ANz_SC1xQ-1; Thu,
 05 Sep 2024 15:45:33 -0400
X-MC-Unique: rWxJIJ5UNDek0ANz_SC1xQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2073D19560AD;
	Thu,  5 Sep 2024 19:45:29 +0000 (UTC)
Received: from localhost (unknown [10.2.16.181])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81BCF30001AB;
	Thu,  5 Sep 2024 19:45:27 +0000 (UTC)
Date: Thu, 5 Sep 2024 15:45:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, brauner@kernel.org, stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 15/15] fs/fuse/virtio_fs: allow idmapped mounts
Message-ID: <20240905194526.GK1922502@fedora>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
 <20240903151626.264609-16-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sLDZW+lg1RmL754X"
Content-Disposition: inline
In-Reply-To: <20240903151626.264609-16-aleksandr.mikhalitsyn@canonical.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--sLDZW+lg1RmL754X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2024 at 05:16:26PM +0200, Alexander Mikhalitsyn wrote:
> Allow idmapped mounts for virtiofs.
> It's absolutely safe as for virtiofs we have the same
> feature negotiation mechanism as for classical fuse
> filesystems. This does not affect any existing
> setups anyhow.
>=20
> virtiofsd support:
> https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Bernd Schubert <bschubert@ddn.com>
> Cc: <linux-fsdevel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> ---
> v3:
> 	- this commit added
> ---
>  fs/fuse/virtio_fs.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sLDZW+lg1RmL754X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmbaClYACgkQnKSrs4Gr
c8goNwf/aGE/W1jDrdVyA+3Z1vhmrUO3CFYvrGbajyRVS49tliBpRB1s9qPyFw4p
sT3twUpa/TzrHsBL2XTfMl2XiPfVNpZ6Sk6+NY2+L9ZNvh6psg09OqCOClZ5WIgs
7QdQJN7Hyhlby4LlZcFE32GGN4LSf2+C4dJ0IwG40TOd4naqEus+c8wzzhzFFKrD
wVCst7tQN7iJeIA5OaX7yYEDk/zw+ZbQ1NbV9wQNiWECSTYFZynZB2fKf4GvEgGb
/+MOipok6NGuMkLJVqZE0SxQz2AWC1uWA68KGfheKEsp9hvAvEqapambNnrdNB2h
47jH8dnpQYzYiqq7QzAQOzs1D+c/rA==
=D/CS
-----END PGP SIGNATURE-----

--sLDZW+lg1RmL754X--


