Return-Path: <linux-fsdevel+bounces-56984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DABB1D816
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C842118C33DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F1253B42;
	Thu,  7 Aug 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="kM9UQQHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F324728B;
	Thu,  7 Aug 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570336; cv=none; b=IOrVDfhJ+FWXteAL2BeeFGHZWMv402knvAIETm+Hekio+lFGMisE+RTiHjIvk5E0b7s1rRgaj90kmqcqXqZVFTqDvEV0zdwDYrVs/ysmvwhBjoHTm3We1G25aYrsIBCqogT+H6pmsXWsRQdWkZOx2etoGVxP2QnNcFJpUlHsiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570336; c=relaxed/simple;
	bh=YFLcIo16OfvzbGgpVCXltFxog7lFpdvAFZs0xLw95kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcwlMpR/fjH0CTdnoTlI6cQI/ptELTFjrTbwok+v3rHtZ0ueLOZ9HonQ6V9sOZEYJ/tUweTvPxPTBqQNHsIiNr2hhp0vWoyefJGokDJVBdAaPQ2l28EfY+RSHyJAHlcxTxvzoRUsweZ8GqrZSZavdmTnhT0pX62/1WuGmr2v2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=kM9UQQHD; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4byRY52lVvz9sQ0;
	Thu,  7 Aug 2025 14:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754570329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bU/y9MWFa6B0gIwG3PfeO00P0lRWaDiO5X7C9N+oo0U=;
	b=kM9UQQHDjzAmp/xrv3atJndAWsdCCFR7mMfP78QqFoplx1+Pdy6bZTKmOAuFlTRRql3qYi
	tCXfgoRYSq/7XDRh86GZyVycpkfdHaDGPP9AauOWFsrgH7iMXlLoSx0cSSErElxCPG/7C2
	6IkTzjYdqcXc8qHDulI52eFFG9/+lipLRXQWT1BHRBIUqTS/OE9+bgo1NcTRe62BPkoIfe
	J371X18elF2EvVAJpI7CGXojf26F1uP+giUxASD5o2T8r9nN7tLUosLY3XPD71toDhO0vy
	ZIsCB+Z2bWFUyaISC6dQVa3ucKtY5FX8m26cp8NO9j56ldMarOdhJuiCTc42Zw==
Date: Thu, 7 Aug 2025 22:38:36 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 02/11] mount_setattr.2: move mount_attr struct to
 mount_attr.2type
Message-ID: <2025-08-07.1754570250-rented-dazzler-furry-proton-robust-diamonds-Kgpe2w@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-2-558a27b8068c@cyphar.com>
 <cselxzuadkkf4cfx45fm3cm77mkq7gxrbzg7idr5726p52w5qa@sarhby7scgp6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2efsv5i2maco22bu"
Content-Disposition: inline
In-Reply-To: <cselxzuadkkf4cfx45fm3cm77mkq7gxrbzg7idr5726p52w5qa@sarhby7scgp6>


--2efsv5i2maco22bu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 02/11] mount_setattr.2: move mount_attr struct to
 mount_attr.2type
MIME-Version: 1.0

On 2025-08-07, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Aleksa,
>=20
> On Thu, Aug 07, 2025 at 03:44:36AM +1000, Aleksa Sarai wrote:
> > As with open_how(2type), it makes sense to move this to a separate man
> > page.  In addition, future man pages added in this patchset will want to
> > reference mount_attr(2type).
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  man/man2/mount_setattr.2      | 17 ++++---------
> >  man/man2type/mount_attr.2type | 58 +++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 63 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
> > index c96f0657f046..d44fafc93a20 100644
> > --- a/man/man2/mount_setattr.2
> > +++ b/man/man2/mount_setattr.2
> > @@ -114,18 +114,11 @@ .SH DESCRIPTION
> >  .I attr
> >  argument of
> >  .BR mount_setattr ()
> > -is a structure of the following form:
> > -.P
> > -.in +4n
> > -.EX
> > -struct mount_attr {
> > -    __u64 attr_set;     /* Mount properties to set */
> > -    __u64 attr_clr;     /* Mount properties to clear */
> > -    __u64 propagation;  /* Mount propagation type */
> > -    __u64 userns_fd;    /* User namespace file descriptor */
> > -};
> > -.EE
> > -.in
> > +is a pointer to a
> > +.I mount_attr
> > +structure,
> > +described in
> > +.BR mount_attr (2type).
> >  .P
> >  The
> >  .I attr_set
> > diff --git a/man/man2type/mount_attr.2type b/man/man2type/mount_attr.2t=
ype
> > new file mode 100644
> > index 000000000000..b7a3ace6b3b9
> > --- /dev/null
> > +++ b/man/man2type/mount_attr.2type
> > @@ -0,0 +1,58 @@
> > +
>=20
> Please remove this blank.  It is not diagnosed by groff(1), but I think
> it should be diagnosed (blank lines are diagnosed elsewhere).  I've
> reported a bug to groff(1) (Branden will be reading this, anyway).
>=20
> > +.\" Copyright, the authors of the Linux man-pages project
> > +.\"
> > +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> > +.\"
> > +.TH mount_attr 2type (date) "Linux man-pages (unreleased)"
> > +.SH NAME
> > +mount_attr \- what mount properties to set and clear
> > +.SH LIBRARY
> > +Linux kernel headers
> > +.SH SYNOPSIS
> > +.EX
> > +.B #include <sys/mount.h>
> > +.P
> > +.B struct mount_attr {
> > +.BR "    __u64 attr_set;" "     /* Mount properties to set */"
> > +.BR "    __u64 attr_clr;" "     /* Mount properties to clear */"
> > +.BR "    __u64 propagation;" "  /* Mount propagation type */"
> > +.BR "    __u64 userns_fd;" "    /* User namespace file descriptor */"
> > +    /* ... */
> > +.B };
> > +.EE
> > +.SH DESCRIPTION
> > +Specifies which mount properties should be changed with
> > +.BR mount_setattr (2).
> > +.P
> > +The fields are as follows:
> > +.TP
> > +.I .attr_set
> > +This field specifies which
> > +.BI MOUNT_ATTR_ *
> > +attribute flags to set.
> > +.TP
> > +.I .attr_clr
> > +This fields specifies which
> > +.BI MOUNT_ATTR_ *
> > +attribute flags to clear.
> > +.TP
> > +.I .propagation
> > +This field specifies what mount propagation will be applied.
> > +The valid values of this field are the same propagation types describe=
d in
> > +.BR mount_namespaces (7).
> > +.TP
> > +.I .userns_fd
> > +This fields specifies a file descriptor that indicates which user name=
space to
>=20
> s/fields/field/
>=20
> > +use as a reference for ID-mapped mounts with
> > +.BR MOUNT_ATTR_IDMAP .
> > +.SH VERSIONS
> > +Extra fields may be appended to the structure,
> > +with a zero value in a new field resulting in
> > +the kernel behaving as though that extension field was not present.
> > +Therefore, a user
> > +.I must
> > +zero-fill this structure on initialization.
>=20
> I think this would be more appropriate for HISTORY.  In VERSIONS, we
> usually document differences with the BSDs or other systems.
>=20
> While moving this to HISTORY, it would also be useful to mention the
> glibc version that added the structure.  In the future, we'd document
> the versions of glibc and Linux that have added members.

Sure, though I just copied this section from open_how(2type).

> > +.SH STANDARDS
> > +Linux.
> > +.SH SEE ALSO
> > +.BR mount_setattr (2)
>=20
> Have a lovely day!
> Alex
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--2efsv5i2maco22bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJSeTAAKCRAol/rSt+lE
byfSAQCqNmxfPk92j1CnM3+qclM4UB915txEO/XP3YjHlJP/CwD/X3E5g69iOsxF
cZoG8TIXEQwoU/gIa8AeFIat7yb+7wA=
=FiKS
-----END PGP SIGNATURE-----

--2efsv5i2maco22bu--

