Return-Path: <linux-fsdevel+bounces-71221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C48CB9FCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D1B30977CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 22:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD532F25E4;
	Fri, 12 Dec 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv1v4DiC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130DE25F96D;
	Fri, 12 Dec 2025 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579792; cv=none; b=H6L1t5rtDiyO3JWCbXv4vPB1fOH/00f9C6bcXvVVxLU/SDZGRH7x3Uv4sPjZSBS+qpZt7wogt1OYapKZ/GGjElfHfXm0evIzoYWJ1U4DctZNsQLnOIk3h+DPRxlEsH3wUDiWe8ytF/ov5HndXlLqFj02jzYPCfYNBI042zk3Ok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579792; c=relaxed/simple;
	bh=P0Y5TK9Wu/ozC2MD5RKZ6z2mbfz20Rzqskxyj6gGZ+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VIv6EUaBTTbAdf8cO/VdOLNiK7C/39Eujrwvun1czV+IXi3hiBJw9skZ+rRUZwefYIsUH25UXXbHSspplt5C09feYmqQMiiUDNJ0LPt4DR424WUbWcMLCWijcTe4Z4c5WpnIfENl1jQWoZuJKLvApXkM9ZIBRBd+gnb8IhXvDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv1v4DiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D4AC4CEF1;
	Fri, 12 Dec 2025 22:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765579791;
	bh=P0Y5TK9Wu/ozC2MD5RKZ6z2mbfz20Rzqskxyj6gGZ+E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mv1v4DiCvSBWS9Zlo6kVTU7RMeu/9jF1ESpXPyUskTmslv/8Y131LZ4piYe9+85WQ
	 s5NU0845NZApXlbTDQXECc4fgCmxNnKod8hQuLpPgfgI4qHdjgQezSpYoqnacO9gMt
	 /cZ45dFvpvIJIV/CIu9YRQoWjT0wNPGDY1tvwkFS/rFnT9LDIIrdYofWHoN8x8HSKs
	 rgtZd2gKzGaY3QvqQEiX8Gbv/EywMCrgPNiiOscuEHbMr4g6xrHCIl4x3n2jxms5y+
	 xA1i+LOVqouFupKbVZOOdu1n+mUN4eBRXPZXYitDm3hYy6oPKPVTSme3WUFLAgyaM/
	 AyJv4WtzdiVnA==
Message-ID: <19c25641f3915007ce7ec00746d31325945a137d.camel@kernel.org>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
From: Trond Myklebust <trondmy@kernel.org>
To: Theodore Tso <tytso@mit.edu>, Chuck Lever <cel@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner	 <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hirofumi@mail.parknet.co.jp, almaz.alexandrovich@paragon-software.com, 
	adilger.kernel@dilger.ca, Volker.Lendecke@sernet.de, Chuck Lever	
 <chuck.lever@oracle.com>
Date: Fri, 12 Dec 2025 17:49:48 -0500
In-Reply-To: <20251212212354.GA88311@macsyma.local>
References: <20251211152116.480799-1-cel@kernel.org>
	 <20251211152116.480799-2-cel@kernel.org>
	 <20251211234152.GA460739@google.com>
	 <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>
	 <20251212021834.GB65406@macsyma.local>
	 <ed9d790a-fea8-4f3e-8118-d3a59d31107b@app.fastmail.com>
	 <20251212212354.GA88311@macsyma.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-13 at 06:23 +0900, Theodore Tso wrote:
> On Fri, Dec 12, 2025 at 10:08:18AM -0500, Chuck Lever wrote:
> > The unicode v. ascii case folding information was included just as
> > an example. I don't have any use case for that, and as I told Eric,
> > those specifics can be removed from the API.
> >=20
> > The case-insensitivity and case-preserving booleans can be consumed
> > immediately by NFSD. These two booleans have been part of the NFSv3
> > and NFSv4 protocols for decades, in order to support NFS clients on
> > non-POSIX systems.
>=20
> I was worried that some clients might be using this information so
> they could do informed caching --- i,e., if they have "makefile"
> cached locally because the user typed "more < makefile" into their
> Windows Command.exe window, and then later on some program tries to
> access "Makefile" the client OS might decide that they "know" that
> "makefile" and "Makefile" are the same file.=C2=A0 But if that's the case=
,
> then it needs to have more details about whether it's ASCII versus
> Unicode 1.0 vs Unicode 17.0 case folding that be in use, or there
> might be "interesting" corner cases.

The Linux NFSv4 client has no clue about how to fold cases so, as Chuck
indicated, it uses the case insensitivity flag only to know when to be
more aggressive about revalidating cached positive dentries and/or
evicting cached negative dentries after the directory contents are seen
to change.

As of now, I'm aware of no plans to try to implement anything like the
"informed caching" you describe above.

> Which is why I've gotten increasingly more sympathetic to Linus's
> position that case folding is Hot Trash.=C2=A0 If it weren't for the fact
> that I really wanted to get Android out of using wrapfs (which is an
> even greater trash fire), I'd be regretting the fact that I helped to
> add insensitive file name support to Linux...
>=20
> 						- Ted

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

