Return-Path: <linux-fsdevel+bounces-13286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DF86E31E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DE91F23008
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5433F6FB80;
	Fri,  1 Mar 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyR827m/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F868386;
	Fri,  1 Mar 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302507; cv=none; b=CIt0svq9xoeWoW6myeWva4cLlgd4E2B+5Sv0Hch7oKl4dhtejhLVx68GxYOJbfJ9AIKkCEJ5/eveJxKRIDfZWjlFUf2YPAydYCqsnTwWvSsNRdoM6yp/5rreAGpLpVnHe1NrLBsxTZbfYOxGPEFu/H2Mp97jcWwSDmvV8bK5csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302507; c=relaxed/simple;
	bh=JIXzLAORlf/H2xW5vxSRKmDySPyQWf8dhQInZ3rGNf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHOSbz+cP7OTxSO58znOq4h//j/EIDbhh+PGxNuX4M8dqvOO6o5wo0bUxD8YOeevD1ixeGtdPed6OT7v1QrU1pUAFg5ImrZ4gL/EFCQcLiGcinaoeP0AzL1+sFqDuijvmjTCgdCtkpOblxXDL3EjsxBbaBF289dAfFvfSiWXKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyR827m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13263C433F1;
	Fri,  1 Mar 2024 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709302507;
	bh=JIXzLAORlf/H2xW5vxSRKmDySPyQWf8dhQInZ3rGNf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyR827m/mlOkF1an3v3hXv/YYVZT4pUmx0svUQRF3dhp2Hf3e5DhLC4r/7m0KxV9c
	 P1qibBkP26GPUQ4qjP2FFZGKb7SH/KY4vXMPbMD+tWmeSA6jPG6ta/6/jLNXnHn3bA
	 jVFoFvPwpzTQuB8l5V8hP6svjXhUBX1WYU4pu6rZoDlmxxWOqejE9VsjnWTo9Fcria
	 XUVaLZ9+fdkLHY38Hup2iteaZBwpSWmcCGyMP5I/GqYPI0n0tti4SedETFTSkN79/7
	 kW1Ucme9iQSC2Wcq7UgjwcNq18BFfYjgIPyHzp/qmVZ35dk8h1wKjlQvP9X16MI6hR
	 sHfqMDcmXBjvA==
Date: Fri, 1 Mar 2024 14:14:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	"\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
	linux-mm@kvack.org,
	"\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
	"\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
	=?iso-8859-1?B?Ik1pY2hhbCBLb3V0bv0i?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"\"Zach O'Keefe\"" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 8/8] mm: huge_memory: enable debugfs to split huge
 pages to any order.
Message-ID: <7837dc6e-b756-4717-8da0-155f5a6e7ed7@sirena.org.uk>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
 <2d5f9cd5-a2c2-453e-aa52-a84a86107d1f@sirena.org.uk>
 <86C93A15-30F6-405C-A877-909B3E12C52C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8HKD/+cRw7vyiqX1"
Content-Disposition: inline
In-Reply-To: <86C93A15-30F6-405C-A877-909B3E12C52C@nvidia.com>
X-Cookie: Schizophrenia beats being alone.


--8HKD/+cRw7vyiqX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 07:56:41AM -0500, Zi Yan wrote:
> On 1 Mar 2024, at 7:11, Mark Brown wrote:

> > Mounting on /mnt would also be a bit of an issue, that's something
> > people are relatively likely to have used for something so could be
> > disruptive.  If the test is going to do a new mount it's probably better
> > to do something like make a temporary directory then mount on top of that.

> To move it to a temp folder for mounting, the test needs to do the mount.
> But it is impossible to know if the running environment has the required FS or not
> and where the FS is. Should I add that as a parameter to the test binary?

You can check the supported filesystem types in /proc/filesystems
(possibly also elsewhere, that's just my first thought).  There's some
standard APIs for getting/naming a temporary file or directory which
should pay attention to any system settings - mktemp() is a generally
available one for C code IIRC.

--8HKD/+cRw7vyiqX1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXh4uIACgkQJNaLcl1U
h9Cj3Af/QuKVVeiD4ZCwMgyH3OXP56WC8qmwxKdF6qvGFLEaw1Dvj/9adSEryb/X
UE/VXMVBQlBgc+6h72c5k2213+Lbwu/apncq6g+VcpT/bNBR07y8KrVwt7FrNUMD
0yDhPn23Bxh6+fxbkJ/ZwbcYxj0tlB3qDL2O1ZDe0K9aPD+NQ1s1ex62g7VKySFo
Ye+Wi3z95F8YOBagb0La4hP1fLOqbHPYM5UeT1N5sFBZAqRLiDf9xKBBjEHokkxK
+1SA2juhHjTSHoaG/IOB0r+Cfipz3Ckj718+/PirbbdbgQm6SsStKXimEuHyy7z/
we+qsXy9z3fueh4MTupwm7UpJnIBcQ==
=tizq
-----END PGP SIGNATURE-----

--8HKD/+cRw7vyiqX1--

