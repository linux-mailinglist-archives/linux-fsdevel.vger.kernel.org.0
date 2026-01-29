Return-Path: <linux-fsdevel+bounces-75882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPN2C5GTe2nOGAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:06:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE731B2A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1066305BFE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA88336ED2;
	Thu, 29 Jan 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="JZdY2rk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9434346A05;
	Thu, 29 Jan 2026 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706199; cv=none; b=BUWjZs2oubBFR2PjuAmNHeUmxLHqktCWgaOA7wqNwcmekKAd4jHQJkosKTDHSbxVe9QYovRyLB62NQX8NvA5SXPLlGbjUwUoyGjuoXbCAzLsZRlgg7O38FqutlcGfpk1o5D/8dPHSCN/CLd9uuTG0YWURoqXFtBnPEXJAXCeiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706199; c=relaxed/simple;
	bh=LLY9FMvE3IKpeY/UAfch3tuVebRQbaET+HE/mN4Na4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxf8atkrPocoEyZTX6PSq8u9p6z1UGLzlYhyF77dEW40V58B59CAdesBRYYhCwOSIVuuEo49tG+FVIi28AKbS5QPONFqv9IfarAO+PU7R+BIBlbJWVnr6pSB6Ny2/+G6VXSZD5M4aVikehV931PHnYIq3IVEhY2asyDHBXoNRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=JZdY2rk4; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f257N6gBSz9slj;
	Thu, 29 Jan 2026 18:03:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1769706193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LLY9FMvE3IKpeY/UAfch3tuVebRQbaET+HE/mN4Na4E=;
	b=JZdY2rk4DNkwSkqsmQii3snS+nxfCj37W1VfcAoZK2Rj1aLw9GVRpy9VXpyf4N2aj4mTaa
	cCJ1z5UrBqIYkbj3exdJfkhEz/F4NJUV2wh2/eONQhaETwhQE1TfqncCka8ROSt5APR38c
	EqjezKN03TSa3zyl6VsnCr2tf0B93EbUDgRl+ON0MMs6OC7JkhlapEi4iXReEoka+QGnW4
	sROApbw7l7BgNSXioooW5U/6jAxW4XK61k8BwmqkzIhTwXcaJmOOCN2ml1Xh/PK6W5MxHj
	vH3Y+LuiTqryKEuVa66+6Gzg7o4PV8oC1wwCPFdx5sGAVGD/QHUZAXD7h99wBw==
Date: Thu, 29 Jan 2026 18:03:06 +0100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
Message-ID: <2026-01-29-shifty-aquatic-tyrant-gypsy-9XYQeE@cyphar.com>
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com>
 <20260129-siebzehn-adler-efe74ff8f1a9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yyf7z2ndeqzchudc"
Content-Disposition: inline
In-Reply-To: <20260129-siebzehn-adler-efe74ff8f1a9@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,arndb.de,dilger.ca];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75882-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[cyphar.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE731B2A19
X-Rspamd-Action: no action


--yyf7z2ndeqzchudc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
MIME-Version: 1.0

On 2026-01-29, Christian Brauner <brauner@kernel.org> wrote:
> On Tue, Jan 27, 2026 at 11:58:17PM +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being tricked
> > into opening device nodes with special semantics while thinking they
> > operate on regular files.
> >=20
> > A corresponding error code ENOTREG has been introduced. For example, if
> > open is called on path /dev/null with O_REGULAR in the flag param, it
> > will return -ENOTREG.
> >=20
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -ENOTREG is returned.
> >=20
> > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> > part of O_TMPFILE) because it doesn't make sense to open a path that
> > is both a directory and a regular file.
> >=20
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
>=20
> Yeah, we shouldn't add support for this outside of openat2(). We also
> shouldn't call this OEXT_* or O2_*. Let's just follow the pattern where
> we prefix the flag space with the name of the system call
> OPENAT2_REGULAR.
>=20
> There's also no real need to make O_DIRECTORY exclusive with
> OPENAT2_REGULAR. Callers could legimitately want to open a directory or
> regular file but not anything else. If someone wants to operate on a
> whole filesystem tree but only wants to interact with regular files and
> directories and ignore devices, sockets, fifos etc it's very handy to
> just be able to set both in flags.
>=20
> Frankly, this shouldn't be a flag at all but we already have O_DIRECTORY
> in there so no need to move this into a new field.

You could even say O_NOFOLLOW is kinda like that too.

In my other mail I proposed a bitmask of S_IFMT to reject opening (which
would let you allow FIFOs and regular files but block devices, etc).
Unfortunately I forgot that S_IFBLK is S_IFCHR|S_IFDIR. This isn't fatal
to the idea but it kinda sucks. Grr.

> Add EFTYPE as the errno code. Some of the bsds including macos already
> have that.

--=20
Aleksa Sarai
https://www.cyphar.com/

--yyf7z2ndeqzchudc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaXuSyRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG9V2gEA6TpotriP26saChHOqN1t
gVDa8rDNakIpZ4ItAHkaDQAA/1wNNzDQ/lL6v2YgOCvKlf8clNlXPbsMiMgmpAV7
lysN
=UK3c
-----END PGP SIGNATURE-----

--yyf7z2ndeqzchudc--

