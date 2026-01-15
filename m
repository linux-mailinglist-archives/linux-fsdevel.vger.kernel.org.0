Return-Path: <linux-fsdevel+bounces-73990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94060D27C42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF61B30146E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEEA3C1974;
	Thu, 15 Jan 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwfO90dr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3D3624AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502736; cv=none; b=Lz+eyBplYbzz/4AcD3KMhTXRl3no1q8M015xZi2Q8Y1lCukUxzd1wG4iyuTN9rCAjI4WibkRCAAEVDJ9nU+APMBT2c5uVC7LTNfLr3uMPmVZQKPDiZ17/5kFQ5EhAEe+u1ThJYxN27Q6fpkP9sYyAh78f4zimKzD/P6IkJat428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502736; c=relaxed/simple;
	bh=w1Vj8qHAEnA5QAG21ZJWEKJRh9+kbTjA2GDGlgG2chU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8yVgWA3a0tKklnoy1Xb0mLHZHDNO6Fp1rMexI2aFbAvvGN7Fbh8hxamimgwc579/ZlL1IX4AaTMUcD3oBCOjLyu7SwFa/jeMsuWxQ0eORYfKbniqUqYZPxnwtpLl41ObubYMJbh0Axx/XFVQtzyT8eEqKl772LI5v6wm0G/5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwfO90dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A38C16AAE;
	Thu, 15 Jan 2026 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768502735;
	bh=w1Vj8qHAEnA5QAG21ZJWEKJRh9+kbTjA2GDGlgG2chU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TwfO90drENo5jbFJVdaiSZo89C7Vr73mdbYYWSupjIHaRyz8ptxOoO3kW3Y75CV2L
	 Xxu+fjOGUfTTGjbAZaJCtbMxxQndbym/Zc2Ui2NmJA7Z7KbhMT2CZH+IVcBaw+epLk
	 eWoVnh2CDd0CmlwlPcxmHWz5yCCK3i2MEASYKWSwF4WgWlAtfevEf2XIkDD+qHnNPC
	 H8kxFPe/jA63WbWdJEGSR93qHmmgECnthmmR1363cxODG9G8UVThXIDCKr27kIfpdQ
	 UgJ+VIFldKgA59rC6AFqp0CjyFbws5RNilzPm/doaygzlMNKQw5kNI8fEyJe6hxMrr
	 sJvvFCskVr8Ag==
Message-ID: <998f6d6819c2e0c3745599d61d8452c3bc478765.camel@kernel.org>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
From: Trond Myklebust <trondmy@kernel.org>
To: Johannes =?ISO-8859-1?Q?Sch=FCth?= <j.schueth@jotschi.de>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>,
 linux-fsdevel@vger.kernel.org,  "gregkh@linuxfoundation.org"	
 <gregkh@linuxfoundation.org>, Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 Jan 2026 13:45:34 -0500
In-Reply-To: <CA+zj3DKAraQASpyVfkcDyGXu_oaR9SnYY18pDkN+jDgi54kRMQ@mail.gmail.com>
References: 
	<32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
	 <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
	 <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
	 <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org>
	 <CA+zj3DKAraQASpyVfkcDyGXu_oaR9SnYY18pDkN+jDgi54kRMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-15 at 17:18 +0100, Johannes Sch=C3=BCth wrote:
> Here are the two requested dumps:
> https://www.jotschi.de/files/fuse_nfs_mount_6_18_5.pcap
> https://www.jotschi.de/files/fuse_nfs_setfattr_6_18_5.pcap
>=20
> I see XAW (xattr write?) being denied on nfs mount:
> Opcode: ACCESS (3), [Access Denied: MD XT DL XAW], [Allowed: RD LU
> XAR XAL]
>=20
> Testing system/security xattr was just a test. My userland code only
> uses user.* xattr.
>=20

If you look at frame #103, when the client is querying the properties
of the filesystem mounted under "merged": it asks for the value of the
attribute "Xattr_support", and the server responds with a value "0"
(i.e. "No").

So as far as I can see, the client behaviour you are observing is the
correct one, given the response from the server.

Now as to the question about why the server is reporting "No", it looks
as if it bases that information on the reply from the VFS call to
xattr_supports_user_prefix() on the root inode for that filesystem. I
guess in this case, FUSE is disallowing setting a "user" xattr on that
inode.

So this is not a regression from the point of view of the NFS client,
but rather that commit a8ffee4abd8e ("NFS: Fix the setting of
capabilities when automounting a new filesystem") fixed the bug that
was masking the actual server response for this FUSE filesystem.

>=20
--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

