Return-Path: <linux-fsdevel+bounces-8940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83CD83C7FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B221F27AF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24A129A9B;
	Thu, 25 Jan 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb4xOyMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BD129A7B;
	Thu, 25 Jan 2024 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200158; cv=none; b=VfE2L+dYFSLRoaZhjjGdb1S0VM59Myov+bu13oZ8KH39AQJXYYMrbWKrSTjXwxb+pp6pObKHjZjRLD63ffha41uuo0INt0bbRk5f3I34dFYQGQfAV1NhND/dz6FsFKEKmbi7Qw01ftDO7rRtI4f8hKpqiH/XZ0cRrM8jvuY+QZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200158; c=relaxed/simple;
	bh=Th54+FEss3yvc0MHAxty/rPDiJ+gfgV+uR9PbKg7RTE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFjKfAVi40bIwhjsIcQNMF74Qziq+Jv4C03sNEFdGi8Dp0NeGPXUXyXEWdJzNuip9nQiEODIFI6xI/40PvPzUDFTibjb1ZPOOCUp6pMhVRaLg1a92MoUBcip5NE651jYu0ReXZelT6fHk5Ov4pT1pNbSXSQM8sgj0FYruLom9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb4xOyMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFF3C43399;
	Thu, 25 Jan 2024 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200158;
	bh=Th54+FEss3yvc0MHAxty/rPDiJ+gfgV+uR9PbKg7RTE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Mb4xOyMjXky18b8TXSdbKK3XNB/c7vSy2sMPIqlxWvMgDAzivOcatLyE635dNMvDf
	 N7pVrTpWIK3DeN42Pt4iCxeeYtmtynOHhbWm0Uh7cZ7ysF68jmYvfhSAYues65Ils9
	 ya980OMav4HETKWZQni0JmP4CuTywmXeYtocERPD4gUN62C9ITSQKZ6ToDnoVBiipK
	 dfEi5pcZkoWGDjbuJqPD5jofvKAtgjE6zrGTxboS/Rrl5/DkNMH+EK9YbBehML17r7
	 ktCE+M48JK1iCi+y3E5flV4Zm6yexkaLAQzBbNn7yehb9gJ1YJq+wN/b+tahhT1I+3
	 QpD2zeX9ze6nQ==
Message-ID: <0b18ba6299d7cf54a96a3aa6641b9f883efb8bd2.camel@kernel.org>
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Gao Xiang <xiang@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>,  Eric Sandeen <esandeen@redhat.com>,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
 ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-nfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:15 -0500
In-Reply-To: <520668.1706191347@warthog.procyon.org.uk>
References: <520668.1706191347@warthog.procyon.org.uk>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 14:02 +0000, David Howells wrote:
> Here's a roadmap for the future development of netfslib and local caching
> (e.g. cachefiles).
>=20
> Netfslib
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [>] Current state:
>=20
> The netfslib write helpers have gone upstream now and are in v6.8-rc1, wi=
th
> both the 9p and afs filesystems using them.  This provides larger I/O siz=
e
> support to 9p and write-streaming and DIO support to afs.
>=20
> The helpers provide their own version of generic_perform_write() that:
>=20
>  (1) doesn't use ->write_begin() and ->write_end() at all, completely tak=
ing
>      over all of of the buffered I/O operations, including writeback.
>=20
>  (2) can perform write-through caching, setting up one or more write
>      operations and adding folios to them as we copy data into the pageca=
che
>      and then starting them as we finish.  This is then used for O_SYNC a=
nd
>      O_DSYNC and can be used with immediate-write caching modes in, say, =
cifs.
>=20
> Filesystems using this then deal with iov_iters and ideally would not dea=
l
> pages or folios at all - except incidentally where a wrapper is necessary=
.
>=20
>=20
> [>] Aims for the next merge window:
>=20
> Convert cifs to use netfslib.  This is now in Steve French's for-next bra=
nch.
>=20
> Implement content crypto and bounce buffering.  I have patches to do this=
, but
> it would only be used by ceph (see below).
>=20
> Make libceph and rbd use iov_iters rather than referring to pages and fol=
ios
> as much as possible.  This is mostly done and rbd works - but there's one=
 bit
> in rbd that still needs doing.
>=20
> Convert ceph to use netfslib.  This is about half done, but there are som=
e
> wibbly bits in the ceph RPCs that I'm not sure I fully grasp.  I'm not su=
re
> I'll quite manage this and it might get bumped.
>=20
> Finally, change netfslib so that it uses ->writepages() to write data to =
the
> cache, even data on clean pages just read from the server.  I have a patc=
h to
> do this, but I need to move cifs and ceph over first.  This means that
> netfslib, 9p, afs, cifs and ceph will no longer use PG_private_2 (aka
> PG_fscache) and Willy can have it back - he just then has to wrest contro=
l
> from NFS and btrfs.
>=20
>=20
> [>] Aims for future merge windows:
>=20
> Using a larger chunk size than PAGE_SIZE - for instance 256KiB - but that
> might require fiddling with the VM readahead code to avoid read/read race=
s.
>=20
> Cache AFS directories - there are just files and currently are downloaded=
 and
> parsed locally for readdir and lookup.
>=20
> Cache directories from other filesystems.
>=20
> Cache inode metadata, xattrs.
>=20
> Add support for fallocate().
>=20
> Implement content crypto in other filesystems, such as cifs which has its=
 own
> non-fscrypt way of doing this.
>=20
> Support for data transport compression.
>=20
> Disconnected operation.
>=20
> NFS.  NFS at the very least needs to be altered to give up the use of
> PG_private_2.
>=20
>=20
> Local Caching
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> There are a number of things I want to look at with local caching:
>=20
> [>] Although cachefiles has switched from using bmap to using SEEK_HOLE a=
nd
> SEEK_DATA, this isn't sufficient as we cannot rely on the backing filesys=
tem
> optimising things and introducing both false positives and false negative=
s.
> Cachefiles needs to track the presence/absence of data for itself.
>=20
> I had a partially-implemented solution that stores a block bitmap in an x=
attr,
> but that only worked up to files of 1G in size (with bits representing 25=
6K
> blocks in a 512-byte bitmap).
>=20
> [>] An alternative cache format might prove more fruitful.  Various AFS
> implementations use a 'tagged cache' format with an index file and a bunc=
h of
> small files each of which contains a single block (typically 256K in Open=
AFS).
>=20
> This would offer some advantages over the current approach:
>=20
>  - it can handle entry reuse within the index
>  - doesn't require an external culling process
>  - doesn't need to truncate/reallocate when invalidating
>=20
> There are some downsides, including:
>=20
>  - each block is in a separate file
>  - metadata coherency is more tricky - a powercut may require a cache wip=
e
>  - the index key is highly variable in size if used for multiple filesyst=
ems
>=20
> But OpenAFS has been using this for something like 30 years, so it's prob=
ably
> worth a try.
>=20
> [>] Need to work out some way to store xattrs, directory entries and inod=
e
> metadata efficiently.
>=20
> [>] Using NVRAM as the cache rather than spinning rust.
>=20
> [>] Support for disconnected operation to pin desirable data and keep
> track of changes.
>=20
> [>] A user API by which the cache for specific files or volumes can be
> flushed.
>=20
>=20
> Disconnected Operation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I'm working towards providing support for disconnected operation, so that=
,
> provided you've got your working set pinned in the cache, you can continu=
e to
> work on your network-provided files when the network goes away and resync=
 the
> changes later.
>=20
> This is going to require a number of things:
>=20
>  (1) A user API by which files can be preloaded into the cache and pinned=
.
>=20
>  (2) The ability to track changes in the cache.
>=20
>  (3) A way to synchronise changes on reconnection.
>=20
>  (4) A way to communicate to the user when there's a conflict with a thir=
d
>      party change on reconnect.  This might involve communicating via sys=
temd
>      to the desktop environment to ask the user to indicate how they'd li=
ke
>      conflicts recolved.
>=20
>  (5) A way to prompt the user to re-enter their authentication/crypto key=
s.
>=20
>  (6) A way to ask the user how to handle a process that wants to access d=
ata
>      we don't have (error/wait) - and how to handle the DE getting stuck =
in
>      this fashion.
>=20
> David
>=20

This is all great stuff, David! Would it be reasonable to request a slot
to talk about the state of all of this at LSF/MM in May?

--=20
Jeff Layton <jlayton@kernel.org>

