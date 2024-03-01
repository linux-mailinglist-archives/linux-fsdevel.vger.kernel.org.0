Return-Path: <linux-fsdevel+bounces-13291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B9D86E34F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E20283D5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C36D6F514;
	Fri,  1 Mar 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5tAPOpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924DB6EB6A;
	Fri,  1 Mar 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303250; cv=none; b=RaQdwGiaRiZOG0KisOMjTx9oTKq/BuJsT+78vFXhDeusmpnCosFJz8pUFRjYX7vPQGuMay6GamIWsy+Ol8U+tKQI1ZkDl4G/JujDgsDLF4/mB/D53izjj+uDLpCxhH4kbU7wLFRcdYOhdRtveOgFkFcXqTR50OGoqnOMyUM9+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303250; c=relaxed/simple;
	bh=sc89POi212PZePf8zzE7T9FFfzy+HFO2YO3kSU1uARI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muAz4c2nu+g3pP35yOK1ovrxFkzb40tt2SxIKG4h/tgvKnrTHgJ3E52HmgrcEd67o380xq4GbyoP1SMZED/QeIThet/ooBkX7XqPqfE5d9i7mPuWBUb2zin5OJ9C4e459Cac8F3zoW4yAls6+KbKhbC3JWBhpAcTsLSEr41boWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5tAPOpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A58C433F1;
	Fri,  1 Mar 2024 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709303250;
	bh=sc89POi212PZePf8zzE7T9FFfzy+HFO2YO3kSU1uARI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5tAPOpJm1jBDvbI7aixTRJtVuNlC7TpO+r+jnig6hOk+Om6cenqjJq9Hq2EIHkv1
	 cOvjS2jQ3U5Ba7ZqekNxUeLR5X+mJsviETbR4uyhxyWiwRTHsqRIVJAwVnQRmSZ8gT
	 hGMyOuf6GWzGvK9ZllFk/obpMBVoNY5dr7/FO2OWfvH33gshcOTbz789fTPu81Hg8t
	 WvgaT3SooanyV9tp9ZjX7OhwneN0wyXcBOu4gNYabeUbCKxuyYcBYxfe8cRp5EWQvX
	 OcBygi9jeVPFjovIJ7GXQcxEvtfy/sDGgkwduQKf8BW9yZGFZzfvs9EcJu4WhWYqX7
	 yQE7QQH56Sk5g==
Date: Fri, 1 Mar 2024 14:27:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>, Aishwarya TCV <aishwarya.tcv@arm.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Message-ID: <dda99ee0-87a2-482d-bf28-bd5e5a97b46e@sirena.org.uk>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
 <08703C70-DD6E-446A-9ABC-BC2C8E33B8CD@nvidia.com>
 <f7a3d07d-290b-46d6-884e-fa288901c3c6@arm.com>
 <3D5A5D18-0A20-4BB3-B667-0CB5799BA665@nvidia.com>
 <6003865f-2c85-4dd4-9803-6204f9018f50@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aDClwSPU2dBmedls"
Content-Disposition: inline
In-Reply-To: <6003865f-2c85-4dd4-9803-6204f9018f50@arm.com>
X-Cookie: Schizophrenia beats being alone.


--aDClwSPU2dBmedls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 02:18:16PM +0000, Ryan Roberts wrote:

> Although I agree it might be a tall order create and mount an XFS fs in
> run_vmtests.sh. Perhaps it might be good enough to add an optional param =
to the
> test to pass a path when running the test manually, and if that's not pro=
vided,
> just try to create a temp file in the current dir and skip if its not the=
 right
> sort of fs?

Yeah, if it needs to be a specific kind of on disk filesystem then that
needs a lot more integration with CI systems (a lot of them run entirely
=66rom nfsroot by default!).  Being able to specify the location via an
environment variable would also be good, it could fall back to the
current directory if one isn't set up.

--aDClwSPU2dBmedls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXh5coACgkQJNaLcl1U
h9Cthgf/exhZvamNaMdDUbiaQJt1suzTxtR0iwMIkyoGG+QcsGZHPhG2OGAVrqfK
T+xYRWrqxRQWqc+NZqTGq08iAoFkQZCKv6VUn2jlxL7o8PNPLkYRA69XyYXCYnwN
UzQU2I9lSef/UbFmAIv/BaceerTOO3XD7GfGPn1H852j7jA4t9VlRO2jPbfG++7I
0j4cl9L2Xvhun+JDcykwIwazFQpBQxZShf2rPKfxZz3cg/UozNjpTSIUAoNZdKUP
YSFL0/fzXxsRdri8Ud3P3xWsSxPNrVWAxMUgkzCL4uqerD+kikdiAGgpq4QsmMF3
cHoBcF80Yg+Ft1V0ZSk4f15ZgvxbYw==
=UD/W
-----END PGP SIGNATURE-----

--aDClwSPU2dBmedls--

