Return-Path: <linux-fsdevel+bounces-73852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A9D21C48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 00:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D41FA30230EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC12FD1DC;
	Wed, 14 Jan 2026 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVOtEo+9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D532AAD3
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768433523; cv=none; b=pkJESAdenoFH7U7Z5kAx6EjMHJQ4CPKR558IaXAQg/3h1z9W069bnMNvorDl1+L+getPHOk+b1gXks45RiO371AfR7R9EaWveuwjnEcQnR1qxp4muV9mBh4ejW4y77/A6hitVSaNZhuJfjeCmLP8epVirnQ55agasVLvOlcGZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768433523; c=relaxed/simple;
	bh=s2S6SwaonRR1sCNihKBhdU2jKYVj30ZMw/drW+9F2Xk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UALew2g35Ib2A2rIS+8r/xpnTX2uUSqZqhapUjm/CFe57RekjZoWPUIGchW0B/YUPnLSYesRGdDBVOE81ll0DeI4vPxJkagJsADEGeM26wIEjylyMTIdpwy4EirVpa3y5yOb0LRn17YxJxVYTVdrlI0ny0xm2TQuEXVNhnLi+kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVOtEo+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D6BC4CEF7;
	Wed, 14 Jan 2026 23:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768433522;
	bh=s2S6SwaonRR1sCNihKBhdU2jKYVj30ZMw/drW+9F2Xk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pVOtEo+9gwZvMGDTEBhH7bNJnZZvdWmTDN0xNbYKvC8aFLzCKfP8l3gOYi9dtWfG+
	 lfW+/PnTYNmpYy5k7p8rzjnvRZzxMgNqxlecXnedGD/5mJxTeStc9S/T6fGUdvgn8Q
	 c7jhXteFTn14WVYtFmto+jaTkNJpUPKg23iB+aIzvKiMP4f6Jw+MNm6ZTiHuSe3SPG
	 lTZqEqkfGOupXHWCJ0MFjbHSFBPxQjjlaaQ4Lo4zCv0Hbw/fqJgvnubuPUjKiGDEp5
	 LcuotOag1g7b6d3YrxGVr0CHI4IAWMFZPKvdjC+vdnmDCLQWLeqATmhFt19HecGehl
	 mn3Ihg/eYet+w==
Message-ID: <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
From: Trond Myklebust <trondmy@kernel.org>
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: linux-fsdevel@vger.kernel.org, "gregkh@linuxfoundation.org"
	 <gregkh@linuxfoundation.org>, Miklos Szeredi <miklos@szeredi.hu>, 
 "j.schueth@jotschi.de"
	 <j.schueth@jotschi.de>
Date: Wed, 14 Jan 2026 18:32:00 -0500
In-Reply-To: <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
References: 
	<32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
	 <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
	 <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-14 at 22:45 +0000, Antonio SJ Musumeci wrote:
> The user (cc'ed) said they have tested numerous recent releases
> including 6.18.5 (on both client and server.)
>=20
>=20

Can you supply a wireshark/tcpdump trace taken on the client that shows
the mount process and an example of a failed setfattr of a user xattr
on the 6.18.5 kernel?

Note that trying to access system level xattrs (I see your github issue
tracker notes trying to read "system.nfs4_acl") has never been allowed.
The NFSv4.2 xattr protocol extension explicitly bans the practice of
using xattrs to construct private filesystem APIs.

IOW: Reading, writing and listing of user xattrs on the remote server
is the only mode that is supported by the NFSv4.2 protocol extension.

>=20
> On Wednesday, January 14th, 2026 at 1:27 PM, Trond Myklebust
> <trondmy@kernel.org> wrote:
>=20
> >=20
> >=20
> > On Wed, 2026-01-14 at 19:18 +0000, Antonio SJ Musumeci wrote:
> >=20
> > > You don't often get email from trapexit@spawn.link.
> > > Learn why this is important
> > >=20
> > > Forgive me but I've not had the chance to investigate this in
> > > detail
> > > but according to a user of mine[0] after a commit[1] between
> > > 6.15.10
> > > and 6.15.11 user namespaced xattr requests now return EOPNOSUPP
> > > when
> > > the FUSE filesystem is exported via NFS. It was replicated with
> > > other
> > > FUSE filesystems.
> > >=20
> > > Was this intentional? If "yes", what would be the proper way to
> > > support this?
> > >=20
> > > -Antonio
> > >=20
> > > [0] https://github.com/trapexit/mergerfs/issues/1607
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm
> > > it/?id=3Da8ffee4abd8ec9d7a64d394e0306ae64ba139fd2
> >=20
> >=20
> > You should upgrade to a newer stable kernel.
> >=20
> > This issue has already been reported and fixed by commit
> > 31f1a960ad1a
> > ("NFSv4: Don't clear capabilities that won't be reset").
> >=20
> >=20
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trondmy@kernel.org, trond.myklebust@hammerspace.com

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

