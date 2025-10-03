Return-Path: <linux-fsdevel+bounces-63339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA185BB5E53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 06:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4721E426FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 04:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719D1DF247;
	Fri,  3 Oct 2025 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="eTQQxV7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4313A3ED;
	Fri,  3 Oct 2025 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759465357; cv=none; b=bvIfDZ0m3ZmYyHstgrYjgvDXlOW+rOKFvd5MrioPDFPIjkV6FrkW0dIZFUPLH5dLwAIvWi0Z7Sff1PDwbQu9SOO5uj9V+/QOxjZRNFuSUoghq0Dae3rQtEBnRU8aYlNUm8Vj4GwHfigQclemMgDapw7EsYpcZjUrILtOdWHVza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759465357; c=relaxed/simple;
	bh=BXBFE0zEH+OZh3PToClWUyja4fEYE0kkxq/gjiSlJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJkibh7uqX8dqWYpTccT19/cchBUfVGHI7n6rUjkV/+AoNbze4HlQ0xrHzHV0txPly9QQ38X8TO/mv/zQ3wDhBLM/ss68hC1Z1Dj1DJEHLW0lSwN1nW1/03yeL1oYRu2Nhr5LK6j9b2HBW8yWRrtK1tTj09ryxRjcTH4vkxKo0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=eTQQxV7C; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cdFr14RHLz9tdV;
	Fri,  3 Oct 2025 06:22:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1759465345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfjajPgEwVLh4oTw1tl5i3Qwbh9BXtm5rODawyfaF28=;
	b=eTQQxV7Cz6Zn3ryUrERVS4yq5ujsCo1hGdrYn+LQE/4HeM9IxZOaOoJWV8uOYIG8sDbGmn
	XXEAqo8Bt9rTbvQw84t0LR80s0IUu85LKusdEYIm3HYX6dOlGIvUDQY/d7N1OwRaIJKGQL
	22G8fVxTW55uSaM8YdkUkiGCS+IvMHCSK2Ytj4iscuvLpTxmErI4JvC2AXQsEhZllKasLI
	b3UFlui+wFlTp8eZEJ8XMW4P7qNsBhnutRYOa/xqG3nOPWELDcPCnmGkg2Rs1Bk7WZyMkR
	1BFH/x2X513K06iS6iP1tyzWTYdIMnSG+C+vfO+zHqcHcE7TwJnZg+2NKtFMOQ==
Date: Fri, 3 Oct 2025 14:22:11 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org, 
	dhowells@redhat.com, g.branden.robinson@gmail.com, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org, mtk.manpages@gmail.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <2025-10-03-chosen-flabby-plunder-premises-hrf07h@cyphar.com>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
 <20251001003841.510494-1-safinaskar@gmail.com>
 <2025-10-01-brawny-bronze-taste-mounds-zp8G2b@cyphar.com>
 <5ukckeqipdkz6aigdy7rmtsmy5zav5x4rw2hrgbxiwfflrcmgb@jy7yr34cwyat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wybfpsl2p34qcvgm"
Content-Disposition: inline
In-Reply-To: <5ukckeqipdkz6aigdy7rmtsmy5zav5x4rw2hrgbxiwfflrcmgb@jy7yr34cwyat>


--wybfpsl2p34qcvgm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
MIME-Version: 1.0

On 2025-10-01, Alejandro Colomar <alx@kernel.org> wrote:
> Hi Aleksa,
>=20
> On Wed, Oct 01, 2025 at 05:35:45PM +1000, Aleksa Sarai wrote:
> > On 2025-10-01, Askar Safin <safinaskar@gmail.com> wrote:
> > > Aleksa Sarai <cyphar@cyphar.com>:
> > > > +mntfd2 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > > > +                   &attr, sizeof(attr));
> > >=20
> > > Your whole so-called "open_tree_attr example" doesn't contain any ope=
n_tree_attr
> > > calls. :)
> > >=20
> > > I think you meant open_tree_attr here.
> >=20
> > Oops.
> >=20
> > >=20
> > > > +\&
> > > > +/* Create a new copy with the id-mapping cleared */
> > > > +memset(&attr, 0, sizeof(attr));
> > > > +attr.attr_clr =3D MOUNT_ATTR_IDMAP;
> > > > +mntfd3 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> > > > +                   &attr, sizeof(attr));
> > >=20
> > > And here.
> >=20
> > Oops x2.
> >=20
> > > Otherwise your whole patchset looks good. Add to whole patchset:
> > > Reviewed-by: Askar Safin <safinaskar@gmail.com>
>=20
> I've applied the patch, with the following amendment:
>=20
> 	diff --git i/man/man2/open_tree.2 w/man/man2/open_tree.2
> 	index 8b48f3b78..f6f2fbecd 100644
> 	--- i/man/man2/open_tree.2
> 	+++ w/man/man2/open_tree.2
> 	@@ -683,14 +683,14 @@ .SS open_tree_attr()
> 	 .\" Using .attr_clr is not strictly necessary but makes the intent clea=
rer.
> 	 attr.attr_set =3D MOUNT_ATTR_IDMAP;
> 	 attr.userns_fd =3D nsfd2;
> 	-mntfd2 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> 	-                   &attr, sizeof(attr));
> 	+mntfd2 =3D open_tree_attr(mntfd1, "", OPEN_TREE_CLONE,
> 	+                        &attr, sizeof(attr));
> 	 \&
> 	 /* Create a new copy with the id-mapping cleared */
> 	 memset(&attr, 0, sizeof(attr));
> 	 attr.attr_clr =3D MOUNT_ATTR_IDMAP;
> 	-mntfd3 =3D open_tree(mntfd1, "", OPEN_TREE_CLONE,
> 	-                   &attr, sizeof(attr));
> 	+mntfd3 =3D open_tree_attr(mntfd1, "", OPEN_TREE_CLONE,
> 	+                        &attr, sizeof(attr));
> 	 .EE
> 	 .in
> 	 .P
>=20
>=20
> (Hopefully I got it right.)

That looks correct -- thanks!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--wybfpsl2p34qcvgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaN9PcxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG841QD/aQiZQdLpxxn1Be+21pvf
bXC7K4m0Tl12JBmevAxkfhAA/3deU7Zt6PHKGPssSrsI4P6icJWoYcVBvunm3LjI
doEP
=yX5i
-----END PGP SIGNATURE-----

--wybfpsl2p34qcvgm--

