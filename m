Return-Path: <linux-fsdevel+bounces-57111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA9B1EC70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5B67AC790
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF98D286887;
	Fri,  8 Aug 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Ep6a0MBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C428641C;
	Fri,  8 Aug 2025 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668326; cv=none; b=Lpp+9cN9/vVjIKjkuGtJEcMwZNxrA97kUVZs8tc6Lx2elr8B1nZQusy36fAyQscuxHV7+zZlUfbkldhgHMR9Q6g81qXSXUedE4W+p5x9fYWr+XgLolNnyP0jbmtOJGNQb9EFTWpOQUPNO999cHlxHyomzfRIfLREx8K32wI67R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668326; c=relaxed/simple;
	bh=pYCBVar2Qgp91JmbjTgfnekAUVrStY3Rlqlrla+YtiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMgC9WxxToiGW48gzJCUpxRz+ufuYoCj78v+QKbcKAI32x9zO0Ap5QXt4/96RTXb9DOIS5Emz2d23fqAAM2805M4n2lvnOnY7poGC3++8S1mJbG5/mon4s1TKQuEqpZn9Qua8F9mh0ZJLNuxcX44hm7JyUDLprjQlhCkayeEtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Ep6a0MBW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bz7nP4wqCz9tyC;
	Fri,  8 Aug 2025 17:51:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754668313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPbABI21FplK/n38p82xe73WQkYhJfnB/7CRIW2+A20=;
	b=Ep6a0MBWINk40s0WdGXokLOcrarxu+ue41L5QEXX/Mrf8wpZTeS9uBO3NyVUDOFOvqKkhv
	Zub+7ytArkri001DJI7Lo/Po2Rh9Xu/2IV+rwjoFtqoxsNNgFOdMdESXVRGx4NCysxgq0k
	0F8nXc24/Dr8iFbl4iXvBX25hPT7WBnQKI+e2LhgIqM+IR/UaFMdZ//f5ffT255qVlD0UF
	qLV4sRzvc6dDM38dyTdw4ttatEpZRd9KVWWSCqjELhiUNV4DtMA/UFZQJmiJq8hlk8CFag
	wl5tAkpp9KlD49RsP+OS7lffuglC3CibVcCIDQJ0UObrr6u/ol/A86LPs5LVEQ==
Date: Sat, 9 Aug 2025 01:51:44 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Askar Safin <safinaskar@zohomail.com>, amir73il@gmail.com, 
	corbet@lwn.net, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, luto@amacapital.net, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
Message-ID: <2025-08-08.1754667211-eroded-secure-codex-earthworm-EK9kTK@cyphar.com>
References: <2025-08-05.1754378656-steep-harps-muscled-mailroom-lively-gosling-VVGNTP@cyphar.com>
 <20250806102501.75104-1-safinaskar@zohomail.com>
 <2025-08-06.1754489257-elated-baubles-defiant-growls-beloved-jewelry-9Ofm2b@cyphar.com>
 <2025-08-07.1754550206-glad-sneeze-upstate-sorts-swank-courts-YKmj7E@cyphar.com>
 <20250808-kurswechsel-angekauft-ec6bfc2efa79@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3clzvts2ovf5w7wk"
Content-Disposition: inline
In-Reply-To: <20250808-kurswechsel-angekauft-ec6bfc2efa79@brauner>


--3clzvts2ovf5w7wk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
MIME-Version: 1.0

On 2025-08-08, Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Aug 07, 2025 at 05:17:56PM +1000, Aleksa Sarai wrote:
> > On 2025-08-07, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > On 2025-08-06, Askar Safin <safinaskar@zohomail.com> wrote:
> > > > > I just realised that we probably also want to support FSCONFIG_SE=
T_PATH
> > > >=20
> > > > I just checked kernel code. Indeed nobody uses FSCONFIG_SET_PATH.
> > > > Moreover, fsparam_path macro is present since 5.1. And for all this
> > > > time nobody used it. So, let's just remove FSCONFIG_SET_PATH. Nobody
> > > > used it, so this will not break anything.
> > > >=20
> > > > If you okay with that, I can submit patch, removing it.
> > >=20
> > > I would prefer you didn't -- "*at()" semantics are very useful to a l=
ot
> > > of programs (*especially* AT_EMPTY_PATH). I would like the pidns=3D s=
tuff
> > > to support it, and probably also overlayfs...
> > >=20
> > > I suspect the primary issue is that when migrating to the new mount A=
PI,
> > > filesystem devs just went with the easiest thing to use
> > > (FSCONFIG_SET_STRING) even though FSCONFIG_SET_PATH would be better. I
> > > suspect the lack of documentation around fsconfig(2) played a part to=
o.
> > >=20
> > > My impression is that interest in the minutia about fsconfig(2) is qu=
ite
> > > low on the list of priorities for most filesystem devs, and so the ne=
at
> > > aspects of fsconfig(2) haven't been fully utilised. (In LPC last year,
> > > we struggled to come to an agreement on how filesystems should use the
> > > read(2)-based error interface.)
> > >=20
> > > We can very easily move fsparam_string() or fsparam_file_or_string()
> > > parameters to fsparam_path() and a future fsparam_file_or_path(). I
> > > would much prefer that as a user.
> >=20
> > Actually, fsparam_bdev() accepts FSCONFIG_SET_PATH in a very roundabout
> > way (and the checker doesn't verify anything...?). So there is at least
> > one user (ext4's "journal_path"), it's just not well-documented (which
> > I'm trying to fix ;]).
> >=20
> > My plan is to update fs_lookup_param() to be more useful for the (fairly
> > common) use-case of wanting to support paths and file descriptors, and
> > going through to clean up some of these unused fsparam_* helpers (or
> > fsparam_* helpers being abused to implement stuff that the fs_parser
> > core already supports).
> >=20
> > At the very least, overlayfs, ext4, and this procfs patchset can make
> > use of it.
>=20
> I've never bothered with actually iplementing FSCONFIG_SET_PATH
> semantics because I think it's really weird to allow *at semantics when
> setting filesystem parameters. I always thought it's better to force
> userspace to provide a file descriptor for the final destination instead
> of doing some arcane lookup variant for mount configuration. But I'm
> happy to be convinced of its usefulness...

I do think it's useful, and here's my thought process...

Most filesystems have to take string path parameters in order to support
mount(2) and work with mount(8). Yes, fsparam_fd() will accept
FSCONFIG_SET_STRING by parsing it as a decimal string, but there are
only two users of fsparam_fd() and honestly I'm not convinced this is a
particularly sane API for anything other than strict backcompat reasons
(the API only makes sense as a file descriptor and you want mount(8) to
be able to use it).

So you end up with most parameters supporting paths set using
FSCONFIG_SET_STRING anyway, meaning in-kernel lookups can't be taken off
the table. And if we accept paths for lookup, then (for the same reason
we have *at(2) syscalls) it is preferable to allow specifying dirfds. So
FSCONFIG_SET_PATH should also be supported.

And as there is no infrastructure to block FSCONFIG_SET_PATH_EMPTY
arguments (yes, you can do it manually, but the *only* user of
fs_lookup_param() doesn't), then anything that accepts FSCONFIG_SET_PATH
currently also accepts FSCONFIG_SET_PATH_EMPTY which is "morally
equivalent" to FSCONFIG_SET_FD. So unless you block
FSCONFIG_SET_PATH_EMPTY then FSCONFIG_SET_FD should probably also be
supported (there is the re-opening distinction, of course, but that is
not relevant if you use filename_lookup() -- which is what filesystems
will do in practice).

So my impression is that most users (if they had an fsconfig(2) man page
to read...) would expect parameters that accept paths to either:

* Work with FSCONFIG_SET_STRING and FSCONFIG_SET_PATH only; or
* Work with FSCONFIG_SET_STRING, FSCONFIG_SET_PATH,
  FSCONFIG_SET_PATH_EMPTY, and FSCONFIG_SET_FD.

Currently, none of our parameters work that way.

 * ext4's journal_path takes FSCONFIG_SET_STRING, FSCONFIG_SET_PATH, and
   FSCONFIG_SET_PATH_EMPTY.
 * overlayfs takes FSCONFIG_SET_FD and FSCONFIG_SET_STRING.

I only fully realised how inconsistent this is while working on the
fsconfig(2) man pages -- at the moment I have a very long paragraph
explaining that there is this distinction in-kernel, but this really
doesn't seem intentional to me. I would be very confused as a user that
FSCONFIG_SET_PATH is useless for most filesystem *path* parameters, even
though the filesystem accepts them as FSCONFIG_SET_STRING.

As for practical uses, it would be nice to not have to open 500 files in
order to create a 500-layer overlayfs.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--3clzvts2ovf5w7wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJYdEAAKCRAol/rSt+lE
b1xUAQCgQs7zgeTpR8rJQbJS59UIDD/xsFDXZFLV+Qt1jHO97gEA6H+q1NQqY5r+
LqvLvlmnGibWFyVIOnQq+vtDUUPd+Q8=
=q67u
-----END PGP SIGNATURE-----

--3clzvts2ovf5w7wk--

