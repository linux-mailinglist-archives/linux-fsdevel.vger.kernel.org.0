Return-Path: <linux-fsdevel+bounces-54596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF89B015D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566106479D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3C217730;
	Fri, 11 Jul 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfBctm63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AD212FB7;
	Fri, 11 Jul 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222140; cv=none; b=nQcxi+PuWrsukNq8o+EhIo3ETGEdTNbLqi9/wlrerOAGHJCeJVSDmmFJGJeO+TMBmcH40ENI+WPK4sdVID+5VLmTTFI1OpUciYnOlD37SWdl7L9H3hFCzYIO98bJO7fpTFOwo8OiJItn7p8M4pj29ywmThBbMeZuabLlag3Ahrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222140; c=relaxed/simple;
	bh=aCQDIoBEG6rh0a3y1ZmSE3HCA5dPK8KA75u2/Txqr5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJe83LRJEllcu3ph3V80kyDx5+hWvNSZP/2XHp4JnG6WDTW8vaXyUZiYapGSneTJ3xRDQJsNnCW+KwpoeBVluGzKfS6VUfFak3seEOFC9cOCAsGDq/i0330inKTeXvroWq96FQj6s9Lw4HJyp0DITAK8a2Pb7G9t5mzFSG+wCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfBctm63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B99C4CEED;
	Fri, 11 Jul 2025 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222137;
	bh=aCQDIoBEG6rh0a3y1ZmSE3HCA5dPK8KA75u2/Txqr5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfBctm63Kyo+CDz3SuG/5U7ROei5M4ZUmnvu4C+hzkcjWNRxQ8espyI/WHu0x1+28
	 IGDNmcTA/pxEdhyQwxgvwT/yIdvmSz6dwJiJLn35Kol94qFNA0TQg158SH/ZOeWUvV
	 YlL0aLYeXjCpjq4+fEEDt6xZ0TW4aj1l51d3wuomeuzMy3rHfD8l/u5zqoVznrmnZq
	 eUGl7+e/vHovzw9YdeQJGLbYXWTtmK7zlc+tiyKKRqEtJU3iJLGHwKcDNCRypBcXPk
	 WSJod2GHB2tDK/6Lbr4tXEd3z0+aVl68+NcqiQvGh/HneldR2e693e64hG7+y7L3qu
	 wkBRWx3pDwRBQ==
Date: Fri, 11 Jul 2025 09:22:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <aHDJtSKEGWJlMnzz@finisterre.sirena.org.uk>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <6797c4613e2b65f64def79acc4621e0fe42ef311.1751865330.git.lorenzo.stoakes@oracle.com>
 <aHDIk6bKzI5kf_be@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OhsYcJ1yAk6xwHgs"
Content-Disposition: inline
In-Reply-To: <aHDIk6bKzI5kf_be@finisterre.sirena.org.uk>
X-Cookie: Q:	How do you keep a moron in suspense?


--OhsYcJ1yAk6xwHgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 09:17:27AM +0100, Mark Brown wrote:
> On Mon, Jul 07, 2025 at 06:27:52AM +0100, Lorenzo Stoakes wrote:
> > Historically we've made it a uAPI requirement that mremap() may only
> > operate on a single VMA at a time.
> >=20
> > For instances where VMAs need to be resized, this makes sense, as it
> > becomes very difficult to determine what a user actually wants should t=
hey
> > indicate a desire to expand or shrink the size of multiple VMAs (trunca=
te?
> > Adjust sizes individually? Some other strategy?).
>=20
> I'm seeing failures in the mremap_dontunmap test in -next on Rasperry Pi
> 4 which bisect down to this patch.  The test logging isn't super helpful
> here sadly:

Same thing on Orion O6 (a more modern ARM v9 system with more RAM than
my Pi):

    https://lava.sirena.org.uk/scheduler/job/1556807

and Avenger 96 (which is 32 bit arm):

    https://lava.sirena.org.uk/scheduler/job/1556479

--OhsYcJ1yAk6xwHgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhwybQACgkQJNaLcl1U
h9CJpQgAgwLVjCZS3Zxeo/jZ4NJ0PdxS0hy14AwBM5bRiO2fCk1sPgX/GEqzDv/a
wp5mPbf6/jhVV9/M0JEXqnMehC5p5WJznGMJiLFwgLiHTlYvcu+qe/oZUob5sl0V
33dIUIAvF+AO3oIs2bzdso5GlVXpbHNRIb76GDFDODymYAxoH1HE7BtmHyOJFqgR
BHwatpv7Ex+XTnKH0wTEfqQBEBNYOW4d9zyOagt9mD8aPvFmGm+VlutybFey7NLj
3z085gylNeffmKAXGLFycaO/SxJduPNyYPVZ81PigoXwOvDUT5FkFBagc/C58I1M
9pJiJK5SD6YkxHn52TQR7IRiFNgq/g==
=DJar
-----END PGP SIGNATURE-----

--OhsYcJ1yAk6xwHgs--

