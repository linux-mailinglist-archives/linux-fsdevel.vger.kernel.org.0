Return-Path: <linux-fsdevel+bounces-23541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044E92DFD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 08:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4168B20C5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 06:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D08003F;
	Thu, 11 Jul 2024 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpWY7Xcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE526ACA
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720677781; cv=none; b=frrw0mhIgxhEI7L+XdQINhcTMTTku+t/aeKkbrFWXce7eIZ/kS8NHCeuflzGKgiMZE1MfkPY3h72CcaN4M3O7+zkVRX2zt6zSagbE8PlyLPd4cbYquKl5TauJd7BGoPh1ienSznxBd3Zs4MRwcwk6o7w/672YdWvPX7PgMHWph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720677781; c=relaxed/simple;
	bh=OJDxVa88prjxVZxlf+yX+pkkczuHpKChdRl8w5Yw/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONFVXPmExnZI7YT96pzEwY1P2K1gpjDxDx3XPqNTvGJwkmNsDRFqSL2tzS++P4GQ0LuvXjPUSsgLEUUvjq5LNuxRG1YfVnnep2S4heRQ9o+f/3L2KdZbjYeHOSSG5jh28S5Zk4Fvca0jQql9aaR7ulKq9KJDY3Z+WDsqpOKMjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpWY7Xcp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720677777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OJDxVa88prjxVZxlf+yX+pkkczuHpKChdRl8w5Yw/rE=;
	b=CpWY7XcpEWfcDShlJWPz0brhUnDu7o7WmrMJgv2xWpN0U7RGQdkwwTt2X3CAV/qCGhdJFB
	rOfys+I4FJxwV04oIH1xUweztXNMU+4LxlzFQYVjE5HmSyD/vz4Z8X/nkzNTvndJlqdZPj
	tpsNKrTw7WYCg6NYlNaTG1DQouY8FWc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-f4bv4FJ-MwCfIqdwvLK8Dg-1; Thu,
 11 Jul 2024 02:02:50 -0400
X-MC-Unique: f4bv4FJ-MwCfIqdwvLK8Dg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEE671955F3C;
	Thu, 11 Jul 2024 06:02:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02C1B3000182;
	Thu, 11 Jul 2024 06:02:47 +0000 (UTC)
Date: Thu, 11 Jul 2024 08:02:46 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: dverkamp@chromium.org, linux-fsdevel@vger.kernel.org,
	takayas@chromium.org, tytso@mit.edu, uekawa@chromium.org
Subject: Re: virtio-blk/ext4 error handling for host-side ENOSPC
Message-ID: <20240711060246.GA563880@dynamic-pd01.res.v6.highway.a1.net>
References: <CAD90Vcbt-GE6gP3tNZAUEd8-eP4NVUfET51oGA-CVvcH4=EAAA@mail.gmail.com>
 <20240619135732.GA57867@fedora.redhat.com>
 <CAD90VcbVFm7YVsrubQs_B_baDHp432v4BuaAZ382VfT2XQ-hHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QcROM0+Hhn5cPHpR"
Content-Disposition: inline
In-Reply-To: <CAD90VcbVFm7YVsrubQs_B_baDHp432v4BuaAZ382VfT2XQ-hHQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--QcROM0+Hhn5cPHpR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:29:05PM +0900, Keiichi Watanabe wrote:
> Hi Stefan,
>=20
> Thanks for sharing QEMU's approach!
> We also have a similar early notification mechanism to avoid low-disk
> conditions.
> However, the approach I would like to propose is to prevent pausing
> the guest by allowing the guest retry requests after a while.
>=20
> On Wed, Jun 19, 2024 at 10:57=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
=2Ecom> wrote:
> >
> > > What do you think of this idea? Also, has anything similar been attem=
pted yet?
> >
> > Hi Keiichi,
> > Yes, there is an existing approach that is related but not identical to
> > what you are exploring:
> >
> > QEMU has an option to pause the guest and raise a notification to the
> > management tool that ENOSPC has been reached. The guest is unable to
> > resolve ENOSPC itself and guest applications are likely to fail the disk
> > becomes unavailable, hence the guest is simply paused.
> >
> > In systems that expect to hit this condition, this pause behavior can be
> > combined with an early notification when a free space watermark is hit.
> > This way guest are almost never paused because free space can be added
> > before ENOSPC is reached. QEMU has a write watermark feature that works
> > well on top of qcow2 images (they grow incrementally so it's trivial to
> > monitor how much space is being consumed).
> >
> > I wanted to share this existing approach in case you think it would work
> > nicely for your use case.
> >
> > The other thought I had was: how does the new ENOSPC error fit into the
> > block device model? Hopefully this behavior is not virtio-blk-specific
> > behavior but rather something general that other storage protocols like
> > NVMe and SCSI support too. That way file systems can handle this in a
> > generic fashion.
> >
> > The place I would check is Logical Block Provisioning in SCSI and NVMe.
> > Perhaps there are features in these protocols for reporting low
> > resources? (Sorry, I didn't have time to check.)
>=20
> For scsi, THIN_PROVISIONING_SOFT_THRESHOLD_REACHED looks like the one.
> For NVMe, NVME_SC_CAPACITY_EXCEEDED looks like this.
>=20
> I guess we can add a new error state in ext4 layer. Le'ts say it's
> "HOST_NOSPACE" in ext4. This should be used when virtio-blk returns
> ENOSPACE or virtio-scsi returns
> THIN_PROVISIONING_SOFT_THRESHOLD_REACHED. I'm not sure if there is a
> case where NVME_SC_CAPACITY_EXCEEDED is translated to this state
> because we don't have virito-nvme.
> If ext4 is in the state of HOST_NOSPACE, ext4 will periodically try to
> write to the disk (=3D virtio-blk or virtio-scsi) several times. If this
> fails a certain number of times, the guest will report a disk error.
> What do you think?

I'm sure virtio-blk can be extended if you can work with the file system
maintainers to introduce the concept of logical block exhaustion. There
might be complications for fsync and memory pressure if pages cannot be
written back to exhausted devices, but I'm not an expert.

Stefan

--QcROM0+Hhn5cPHpR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaPdYYACgkQnKSrs4Gr
c8j9SAf/TaabQRNW9s5PbRVoJXK+yCkL/Hc+MGr6uE0uRh+4WxAdAVejJLJxYlGH
3Y5XzxPP38yMQA86ZJxiGj9VSH/xFOpdjGxJdZkUVz5RRR+7EqxpeUZVvA8JB0RD
Je5Lp1P7g1kUQSQjBM9UZKdgjZ6DyjiH3wsFRWEYiMIuLUykmg6qmAgwwBX/JOCq
364ia73JWwI9NeQe344RunmBkrPf5fs6QIFnMN0MgvDsy2HM25AIuVSzQjW7lC37
Z93wv1MEhxTxBrrQmMkCOC0jG07mxrzOh8g77e78wiiO9sDp9wog4wWVM/vXg0VT
nHCitidnVQJ6wV9rjw1VJM8kKHLVOA==
=GfGQ
-----END PGP SIGNATURE-----

--QcROM0+Hhn5cPHpR--


