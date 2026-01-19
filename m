Return-Path: <linux-fsdevel+bounces-74538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED6D3B91A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 22:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5FED30C8255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9267E2F6577;
	Mon, 19 Jan 2026 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="YgQQN8dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAgr+J8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D02ECD2A;
	Mon, 19 Jan 2026 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856795; cv=none; b=IJtqWGAxylzIhGKrVBy7dEBCdKd3bThy9Tm5uAOROR30uJOoU6+cP6pnlSnEacfd9VBnHa2M35jTX1n/DD72cbINr8asWb1ouPNwrh85gwa+QzzGRHblRa1z4Qups/kHZJZPRP1gwKTXRXZ9eWZEYmISkCOGn3lahktt6vvGCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856795; c=relaxed/simple;
	bh=N/9LcEHsyFI/CSMH88ICdSbqRtErfRHvO+R71eZcEI8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hsTVhrrVMsFPoL6BvYo1mE5/4yvAQs4Fcq0MtliR6IMq+pMEh1rLN3gTzI1cOAwBjCaah9PY1DEZmpzAtYfbSUKgc5Q32+Sx+CnH0iCPBgFCRtEO3vLPZS5rNoHf7XzJxJfR+3b3iFs88ZhTODbuN7BbbfKOJtXStnpkUTO00SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=YgQQN8dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAgr+J8Z; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C2EE1D003E8;
	Mon, 19 Jan 2026 16:06:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 19 Jan 2026 16:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768856792; x=1768943192; bh=DvWhVhjreP12gt2nm8MIZSJ/NQFSx5xqtka
	eT2CXIlw=; b=YgQQN8dqXygxoM2Xgp37YmuX/0qaOpoyMDHdJlChLSP4MLcyAiM
	rvTIsiVu+1lEqkYyvI5pcmel8iEUDULB1ec7dltIFpsZpUzS1KI6oxDw0pbitTW3
	neci3ad/CxpmTxWEFZv6YHmVROO0HIETO+GgZBNPLgS5dzojh1/e0CPWOZFtRPQ2
	vGupIoukIbScGTUgCyCOlgfGgyMiJm+KYMNAXo/L3CjkcYMrOnR5Ixzub1/dJ4Hc
	DghPNjEcrIaGxZNLy9Eo3eZrfcgSgQpL3P4fOTbfM2OJPjLLVTrZZFrDfy9QrKWd
	7XsAAEPqrXN0qHm9KBZszEqmG/SN/0d7/9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768856792; x=
	1768943192; bh=DvWhVhjreP12gt2nm8MIZSJ/NQFSx5xqtkaeT2CXIlw=; b=M
	Agr+J8ZJeRf17KPhkoT7treRGVgHQEYqtAZcUziStT4/F8RP30FPYZBwV4fFHzWV
	Wqc/HrR+twYIXjoCJk1r6cnFeqriVotNoD3Nchx2rGEfAp1jb6JqrBlFMfH2Q1X3
	At85jz02Td5i5HV+N/p2eKHCEkcbRENwTldbDe3Humjc7GX0VJTYVZE4uZ1PPg6K
	NrYMtLhkrW5hzDBC4dEpEpsc9tmD3P0/SLiGqh8wL2etZcqCW1bLQerrWqsR5Okf
	1omU8WUnqbLA/Irnw3cClAsDFH2Tx0rjpr2DTkZq5WbWrDRI7SLYPtr7WxAl+re0
	1mzTk3iCgSv1Sr3r9UVow==
X-ME-Sender: <xms:15xuaa8kyF79FSubz_ebAQLnWZZEoCZ2G6-Y_O7jgzteNdUFx6KxXg>
    <xme:15xuaS2qf-oyZVeymZyPJBK4wqAaNge-EMdvSn2YpgtFCmzHjD7z-5EXYYnVJNdWw
    iYQfhvPy4SF4d9-Xhb6CKJqZWQE4d_n0G-d71lvLhFugngCKw>
X-ME-Received: <xmr:15xuafjwVDwNPx8Q11INka6Nvr2XX13RzZTJ2xjl4wuFCIUvcc2F2QJuR2o3oowtNzVjyycbrI3vsXpQE5HSlZp8zyWkXnUxg80MDMDgqmbW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlvghnnhgrrhhtsehpohgvthhtvghrihhnghdrnhgvthdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:15xuaSbos4ep8YOd3B908_XZKskaLceq9BHg0z6SIf9XFUFzStjwYA>
    <xmx:15xuabUdJN5cIPu1bytGvBJtm7N7A3HA5ijXZDfuEMjPkQO61bLqtA>
    <xmx:15xuaaHjWsZXZShcFwfMpxqzQhADlgwl3BpVU9asrE3cFNpdEEeLLw>
    <xmx:15xuaVaciyzGCnND4NDNJYG27dTpl-EFCnmqTEffLTKyVYMcL5jiTQ>
    <xmx:2JxuaZHHivyS2HXmol5vIZDffl789r-CzhipcRLw2LRJx6N0fh5umcwm>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 16:06:28 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org, "Lennart Poettering" <lennart@poettering.net>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
In-reply-to: <20260119-reingehen-gelitten-a5e364f704fa@brauner>
References: <cover.1768573690.git.bcodding@hammerspace.com>,
 <20260119-reingehen-gelitten-a5e364f704fa@brauner>
Date: Tue, 20 Jan 2026 08:06:26 +1100
Message-id: <176885678653.16766.8436118850581649792@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 19 Jan 2026, Christian Brauner wrote:
> On Fri, Jan 16, 2026 at 09:32:10AM -0500, Benjamin Coddington wrote:
> > The following series enables the linux NFS server to add a Message
> > Authentication Code (MAC) to the filehandles it gives to clients.  This
> > provides additional protection to the exported filesystem against filehan=
dle
> > guessing attacks.
> >=20
> > Filesystems generate their own filehandles through the export_operation
> > "encode_fh" and a filehandle provides sufficient access to open a file
> > without needing to perform a lookup.  An NFS client holding a valid
> > filehandle can remotely open and read the contents of the file referred to
> > by the filehandle.
> >=20
> > In order to acquire a filehandle, you must perform lookup operations on t=
he
> > parent directory(ies), and the permissions on those directories may
> > prohibit you from walking into them to find the files within.  This would
> > normally be considered sufficient protection on a local filesystem to
> > prohibit users from accessing those files, however when the filesystem is
> > exported via NFS those files can still be accessed by guessing the correc=
t,
> > valid filehandles.
> >=20
>=20
> I really like this concept (I think Lennart has talked about support for
> this before?).
>=20
> Fwiw, I would really like if nsfs and pidfs file handles were signed
> specifically because they're not supposed to persist across reboot. But
> we can't do that in a backward compatbile way because userspace accesses
> the file handle directly to get e.g., the inode number out of it.

You don't need signing to ensure a filehandle doesn't persist across
reboot.  For that you just need a generation number.  Storing a random
number generated at boot time in the filehandle would be a good solution.

The only reason we need signing is because filesystems only provide
32bits of generation number.  If a filesystem stored 64 bits, and used a
crypto-safe random number for the generation number, then we wouldn't
need signing or a key.

We need a key, effectively, to turn a 32bit number that can be iterated
into a 64bit number which cannot, in a non-reversible way.

Does userspace refuse the extract the inode number if the filehandle
size changes?  It it can cope with size change, then adding a random
number to the end of the filehandle should not be a problem.

>=20
> But for new types of file handles for such pseudo-fses I think this
> would be very lovely to have. It would probably mean generating a
> per-boot key that is used to sign such file handles.

For new fses I recommend including a 64bit random number.  No signing.

>=20
> For nfs I understand that you probably outsource the problem to
> userspace how to generate and share the key.
>=20
> > Filehandles are easy to guess because they are well-formed.  The
> > open_by_handle_at(2) man page contains an example C program
> > (t_name_to_handle_at.c) that can display a filehandle given a path.  Here=
's
> > an example filehandle from a fairly modern XFS:
> >=20
> > # ./t_name_to_handle_at /exports/foo=20
> > 57
> > 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
> >=20
> >           ^---------  filehandle  ----------^
> >           ^------- inode -------^ ^-- gen --^
> >=20
> > This filehandle consists of a 64-bit inode number and 32-bit generation
> > number.  Because the handle is well-formed, its easy to fabricate
> > filehandles that match other files within the same filesystem.  You can
> > simply insert inode numbers and iterate on the generation number.
> > Eventually you'll be able to access the file using open_by_handle_at(2).
> > For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, wh=
ich
> > protects against guessing attacks by unprivileged users.
>=20
> Fyi, it's not so simple. For some filesystems like pidfs and nsfs they
> have custom permission checks and are available to unprivileged users.
> But they also don't do any path lookup ofc.

I didn't know that.....
Oh, there is a "permission" operation now:

 * permission:
 *    Allow filesystems to specify a custom permission function.

Not the most useful documentation I have ever read.
Not documented in Documentation/filesystems/exporting.rst

Not used in fs/exportfs/.
Ahhh.. used in fs/fhandle.c to bypass may_decode_fh()

Fair enough - seems sane for a special-purpose filesystem to give away
different access.

Thanks for the info.

I wonder if nfsd should refuse to export filesystems which have a
.permission function, as they clearly are something special.

NeilBrown

