Return-Path: <linux-fsdevel+bounces-73840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE61D21A5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E50043007530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C533EB0C;
	Wed, 14 Jan 2026 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="eFUj2+SZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch [109.224.244.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6B34217C
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430772; cv=none; b=SYPjhYdcubUh+UKoe25S6PtCgRP59m9IUsqlZ07cEXwWEBbI+0j6AT91xrEH0BsfL/bzqk3aJPxqA0N7Q7mG/Fo8w2rvvAbq8zsmi8tdx7gK9ixkYnwZ1o7YTwm21NEvrmwgC5rF+6i0MykdtfvMtX42rcLXX1EWHFcdd1eq39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430772; c=relaxed/simple;
	bh=rjUINxRg3lij1vjSj2qQ2xhM44Ragv9fEYuNPxN3ll8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+Qe1G4n6dKxztFeeRiYTkMCRT4x02kI2/JkoQZYADrbBSelq2aR8V5mKyLLondnOsE8mXZn+QAJpJp+6f8+wbTGHRlK0XKYI+eFjaX8lQACW+by7wS8zBWSiAlw51lj9NqUU/9SL6SGuFZdbJNp0LfJcn1jtfn/utAkViDGCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=eFUj2+SZ; arc=none smtp.client-ip=109.224.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1768430754; x=1768689954;
	bh=rjUINxRg3lij1vjSj2qQ2xhM44Ragv9fEYuNPxN3ll8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eFUj2+SZtQLEg353szH9QR5TwPcaqEm0Uw8aJO+jAP0aANErktl7Mzte24oGp9C6k
	 8MK8FtVCfX6Hxp1Gl5vDL+PvkkkuM5kE6eMIkeW79kK880PVJOjFRVpOU9mRfomdD5
	 oEg64l42TcRO2B0o2TfsiR8d399eG9E3BFvXjd2d6164e6TLb0TU7UKXsGqpXNy7J2
	 7Rnhc3DkkycXzoUTdslM71Q37Py91zQvLvi8U3mIzTLuqzMgE2STLyirEB/yWEJKIo
	 87SVDUudLu+o7acn6n0dR2VwzYtpMidLbQDF3M/omjpKx1SG8Azrip6jFv2CskjQ2a
	 MZUK4rzrGqObw==
Date: Wed, 14 Jan 2026 22:45:52 +0000
To: Trond Myklebust <trondmy@kernel.org>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: linux-fsdevel@vger.kernel.org, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Miklos Szeredi <miklos@szeredi.hu>, "j.schueth@jotschi.de" <j.schueth@jotschi.de>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
Message-ID: <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
In-Reply-To: <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
References: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link> <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: fa18c74e426bd7f87776fc9df0629b8f8443b585
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The user (cc'ed) said they have tested numerous recent releases including 6=
.18.5 (on both client and server.)



On Wednesday, January 14th, 2026 at 1:27 PM, Trond Myklebust <trondmy@kerne=
l.org> wrote:

>=20
>=20
> On Wed, 2026-01-14 at 19:18 +0000, Antonio SJ Musumeci wrote:
>=20
> > You don't often get email from trapexit@spawn.link.
> > Learn why this is important
> >=20
> > Forgive me but I've not had the chance to investigate this in detail
> > but according to a user of mine[0] after a commit[1] between 6.15.10
> > and 6.15.11 user namespaced xattr requests now return EOPNOSUPP when
> > the FUSE filesystem is exported via NFS. It was replicated with other
> > FUSE filesystems.
> >=20
> > Was this intentional? If "yes", what would be the proper way to
> > support this?
> >=20
> > -Antonio
> >=20
> > [0] https://github.com/trapexit/mergerfs/issues/1607
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm
> > it/?id=3Da8ffee4abd8ec9d7a64d394e0306ae64ba139fd2
>=20
>=20
> You should upgrade to a newer stable kernel.
>=20
> This issue has already been reported and fixed by commit 31f1a960ad1a
> ("NFSv4: Don't clear capabilities that won't be reset").
>=20
>=20
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

