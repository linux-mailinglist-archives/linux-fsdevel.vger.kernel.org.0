Return-Path: <linux-fsdevel+bounces-20186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5C8CF596
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 21:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B671F21166
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 19:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC112BEAB;
	Sun, 26 May 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="fkbI9bRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B171DA5F;
	Sun, 26 May 2024 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716750671; cv=none; b=iv6i8e+vgrm8otFI3+PfsvrW1XZTgB9SGPZVrYmuYMbMdnHrcEXfmouvGdcNU04MJdsRccnmaASWAsiLQYQNL/xg9ujYfe6gnGRqATZ/qtIPY7Jmhft68gYB1SvNo6Rupa78OHxevyi3sTBveUFkRpPSlRN/m+euJR7fU0nG5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716750671; c=relaxed/simple;
	bh=V6pWRl5/R829vCPQdCBHueI2AkDTCJb53fNdMCXSLVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3GNuF+4urxAL06SeE9OYaxn/IfqIr6kHwbN4PON75MzcBYjnqphSMFWqrLELWjFnrkXZwMvNEZSqaCSbkH71p5cXGDSUOHXu05Nqwo2Osmp4GepTRX4TF5zq8INLC+wCj51tTZ2JPhBf7ImlS9lMRedGuw+QobCeLielGrnnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=fkbI9bRf; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VnSmn5LbQz9srB;
	Sun, 26 May 2024 21:01:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1716750089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9cppxWmIe0VMvcGEUiv0Uu8DZiQtFpwpAKbCgnUVyg=;
	b=fkbI9bRf/v/PG60NTXoiBFnGW5PQxoNWMLCvvN7rODxFDwx6ejMnjC9KwgfkpALWziWwaR
	PDci3KZIGuSNuO/8QY+KkOQ3EDD0JSRLI2UOK7pZpOFEJx3jJAcYN9g8msXO/Zn1YK8Wt9
	ZttMp8XBMWyX44zD2lk1aTuNNEf9DBEwkxGx458+K234gn22VwJ2KLGnY34uJ9/ASqfHhH
	/Sa2c8xo3APTm4DQbujnAyZuT+1NDou7/yDDCgqpjb/83Db9rPLRB5Z3WvcW33k510oszj
	E3jo6rKtWo5vyKnIoGnTb+r6GGHr2FUuALlyN/BfjHpHwLpAU5d3+o4cHYk+fg==
Date: Sun, 26 May 2024 12:01:08 -0700
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3co2dmrrdjgd6wv5"
Content-Disposition: inline
In-Reply-To: <ZlMADupKkN0ITgG5@infradead.org>


--3co2dmrrdjgd6wv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-26, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, May 23, 2024 at 01:57:32PM -0700, Aleksa Sarai wrote:
> > Now that we provide a unique 64-bit mount ID interface in statx, we can
> > now provide a race-free way for name_to_handle_at(2) to provide a file
> > handle and corresponding mount without needing to worry about racing
> > with /proc/mountinfo parsing.
>=20
> file handles are not tied to mounts, they are tied to super_blocks,
> and they can survive reboots or (less relevant) remounts.  This thus
> seems like a very confusing if not wrong interfaces.

The existing interface already provides a mount ID which is not even
safe without rebooting.

The purpose of the mount ID (in the existing API) is to allow userspace
to make sure they know which filesystem mount the file handle came from
so they can store the relevant information (fsid, etc) to make sure they
know which superblock the mount came from when it comes to doing
open_by_handle_at(2). However, there is a race between getting the mount
ID from name_to_handle_at() and parsing /proc/self/mountinfo, which
means that userspace cannot ever be sure that they know the correct
mount the file handle came from (the man page for open_by_handle_at
mentions this issue explicitly).

Getting the ability to get a 64-bit mount ID would allow userspace to
use statmount(2) directly, avoiding this race. You're quite right that
obviously you wouldn't want to just store the mount ID.

An alternative would be to return something unique to the filesystem
superblock, but as far as I can tell there is no guarantee that every
Linux filesystem's fsid is sufficiently unique to act as a globally
unique identifier. At least with a 64-bit mount ID and statmount(2),
userspace can decide what information is needed to get sufficiently
unique information about the source filesystem.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3co2dmrrdjgd6wv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZlOG8AAKCRAol/rSt+lE
b8uGAP9d019CDlw84s9QU6/eCUdNT1w0Lk0Ce3UIIdsD8vPxHgD/Xj44w2qaMngH
r0EgXJWO83ghM64/Bg7QGygzx48oNQU=
=/g8f
-----END PGP SIGNATURE-----

--3co2dmrrdjgd6wv5--

