Return-Path: <linux-fsdevel+bounces-31876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C89F99C70E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 12:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0243B1F23330
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D0156676;
	Mon, 14 Oct 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4XX4nhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F410B1487F4;
	Mon, 14 Oct 2024 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901358; cv=none; b=DEhnEWxTvscrTi0CXoRXPjBuvB4dufGvnCHu+K5hA5yLn/erJwsFjmUFsbxRKIVYejyyircmUfsLImL6Cm+iEqJttmdW+ax6nhaP3S4m3JYZ7zl0A1kzooQek36j/m3fD+1WbUa1pN1wP5AjinbSm/yL4IjWxbMlAe5TBrbRhTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901358; c=relaxed/simple;
	bh=fJBK7xC6vL4wVKirgCqItgrOhlFxqJoc/2uSQhscN0U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbCrHWd1/JxzzNJwBxcC53brbl3YgMfSqAfnx3ymq7BlvvdBg186U8fdxH3ydms8VVoDAllhd1w1ufWefKE7z4RvOJzIBqsdf90U2+nIUd2cjEsw8E7fqgYyLJgv8Ma8xozhHfaoCuqBGKn96/W3JYaD5lo9S8zaldHgic3e1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4XX4nhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A92C4CEC3;
	Mon, 14 Oct 2024 10:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728901357;
	bh=fJBK7xC6vL4wVKirgCqItgrOhlFxqJoc/2uSQhscN0U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P4XX4nhP0HoUlfeZVIZ3+BLVJSXqSTwYzxVJmV+y3xalGbkMCWLppQDVdWwPUuXg/
	 r/a38ei+fSBpMTqoFi3R1or0p7g9OGpsmvFo+HeqWn1zlrezsBAYmaPOfCB2rjvwWF
	 M8EeoACgL+DPiX89KN5NRaJe9elNXAetH/dGdJPJNCpdTKE0lkyFT9dtna8bjvBEX4
	 rofy7dKJlWv11y9ZXPpz171SM57hygXDUgm//PrRLQaQHG+mKzKOFjphvcWXAOBXIT
	 eWu1I67ILtFtE8M8UaGsDZVMrK+mcRYHjvpOj08UagEWGh9yztrvkDgXfNUoo3gyjA
	 C66OBGmG8w8Jg==
Message-ID: <f2f0ff2bdb999ce10ae52cc1ffd44cee92444d1a.camel@kernel.org>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
From: Jeff Layton <jlayton@kernel.org>
To: Burn Alting <burn.alting@iinet.net.au>, 
 =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
	 <mic@digikod.net>, Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Paul Moore
 <paul@paul-moore.com>,  linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org,  linux-security-module@vger.kernel.org,
 audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>
Date: Mon, 14 Oct 2024 06:22:35 -0400
In-Reply-To: <9c3bc3b7-2e79-4423-b8eb-f9f6249ee5bf@iinet.net.au>
References: <20241010152649.849254-1-mic@digikod.net>
	 <ZwkaVLOFElypvSDX@infradead.org> <20241011.ieghie3Aiye4@digikod.net>
	 <ZwkgDd1JO2kZBobc@infradead.org> <20241011.yai6KiDa7ieg@digikod.net>
	 <Zwkm5HADvc5743di@infradead.org> <20241011.aetou9haeCah@digikod.net>
	 <Zwk4pYzkzydwLRV_@infradead.org> <20241011.uu1Bieghaiwu@digikod.net>
	 <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
	 <9c3bc3b7-2e79-4423-b8eb-f9f6249ee5bf@iinet.net.au>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 17:44 +1100, Burn Alting wrote:
> =C2=A0
>=20
>=20
>=20
>=20
> =C2=A0
>=20
>=20
>=20
> =C2=A0
>=20
>=20
>=20
> On 13/10/24 21:17, Jeff Layton wrote:
> =C2=A0
>=20
>=20
>=20
> =C2=A0
>=20
>=20
>=20
> > =C2=A0
> >=20
> >=20
> >=20
> > On Fri, 2024-10-11 at 17:30 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > =C2=A0
> >=20
> >=20
> >=20
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > > On Fri, Oct 11, 2024 at 07:39:33AM -0700, Christoph Hellwig wrote:
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > > > =C2=A0
> > > >=20
> > > >=20
> > > >=20
> > > > On Fri, Oct 11, 2024 at 03:52:42PM +0200, Micka=C3=ABl Sala=C3=BCn =
wrote:
> > > > =C2=A0
> > > >=20
> > > >=20
> > > >=20
> > > > > =C2=A0
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > > =C2=A0
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > > =C2=A0
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > Yes, but how do you call getattr() without a path?
> > > > > > > =C2=A0
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > =C2=A0
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > You don't because inode numbers are irrelevant without the path=
.
> > > > > > =C2=A0
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > =C2=A0
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > They are for kernel messages and audit logs.  Please take a look =
at the
> > > > > use cases with the other patches.
> > > > > =C2=A0
> > > > >=20
> > > > >=20
> > > > >=20
> > > > =C2=A0
> > > >=20
> > > >=20
> > > >=20
> > > > It still is useless.  E.g. btrfs has duplicate inode numbers due to
> > > > subvolumes.
> > > > =C2=A0
> > > >=20
> > > >=20
> > > >=20
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > > At least it reflects what users see.
> > >=20
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > > > =C2=A0
> > > >=20
> > > >=20
> > > >=20
> > > > If you want a better pretty but not useful value just work on makin=
g
> > > > i_ino 64-bits wide, which is long overdue.
> > > > =C2=A0
> > > >=20
> > > >=20
> > > >=20
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > > That would require too much work for me, and this would be a pain to
> > > backport to all stable kernels.
> > >=20
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > =C2=A0
> >=20
> >=20
> >=20
> > Would it though? Adding this new inode operation seems sub-optimal.
> >=20
> > Inode numbers are static information. Once an inode number is set on an
> > inode it basically never changes.  This patchset will turn all of those
> > direct inode->i_ino fetches into a pointer chase for the new inode
> > operation, which will then almost always just result in a direct fetch.
> >=20
> > A better solution here would be to make inode->i_ino a u64, and just
> > fix up all of the places that touch it to expect that. Then, just
> > ensure that all of the filesystems set it properly when instantiating
> > new inodes. Even on 32-bit arch, you likely wouldn't need a seqcount
> > loop or anything to fetch this since the chance of a torn read there is
> > basically zero.
> >=20
> > If there are places where we need to convert i_ino down to 32-bits,
> > then we can just use some scheme like nfs_fattr_to_ino_t(), or just
> > cast i_ino to a u32.
> >=20
> > Yes, it'd be a larger patchset, but that seems like it would be a
> > better solution.
> > =C2=A0
> >=20
> >=20
> >=20
> =C2=A0
>=20
>=20
>=20
> As someone who lives in the analytical user space of Linux audit,  I take=
 it that for large (say >200TB) file systems, the inode reported in audit P=
ATH records is no longer forensically defensible and it's use as a correlat=
ion item is of questionable value now?
> =C2=A0
>=20
>=20
>=20

It's been a while since I worked in audit, but if audit is only
reporting 32-bit inode numbers in its records, then that could be
ambiguous. It's easily possible on larger filesystems to generate more
than 2^32 inodes.

--=20
Jeff Layton <jlayton@kernel.org>

