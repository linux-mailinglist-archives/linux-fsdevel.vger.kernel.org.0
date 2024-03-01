Return-Path: <linux-fsdevel+bounces-13261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301786E0E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042B01F22D3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3B6E2BE;
	Fri,  1 Mar 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrYw+K7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D56BFC9;
	Fri,  1 Mar 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295123; cv=none; b=QiyugEzq3nME/MlN4P6p3Nr9nzl075/NmdoUb0nagQqjynr/b/zCSKOTpwJzDce2yNqdrp6DIZTnLEF1WVtQLDxzI3j/p0GX0r/7GOJoMXE4LPm+D9YqW+G9bgYlMZZjUe7Surqn3pW49MQm65LBGA6HsX9wJ38KN+h1Ghkk8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295123; c=relaxed/simple;
	bh=WfddGTTxOxrioIY8/wcsdzeHOCxjcPKVGeQVl66RUsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbuJ8WNclMfG/rHD5+PO/R1gyzSVKtqk17S5lfkd/bjlJQEshMAaMSfK0HA8UV1QgbEBaCLPlVYCGp6PkZ3gtKfnZSm1qLrQZTF7LdxUtR5jXn3v/9XLYYnpZGhFYqpyC+S+OPctxcNGKzil5nViZcZGiycPl/YVFR55QNL2cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrYw+K7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEA8C433F1;
	Fri,  1 Mar 2024 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709295122;
	bh=WfddGTTxOxrioIY8/wcsdzeHOCxjcPKVGeQVl66RUsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrYw+K7fnHTaJUP4LWmas0DizEtD7fbGrk+TcYhHHi6hHTegtRNZRntjBYRvUF+2L
	 c5NCYfNPwJUqkK4tklnaR3Asg7YCy4R/+9YshVAf/BcDC2MLGPo3Q6vFJk/5uhPcAH
	 HljkJCAJ0FbRO/jHKYH5txVgtuBlw1uJj6cMDKCdJVswWMjZ/s8fWVh1Df/DWLUtkY
	 wbn/V2cx/s/f29t057+sjQfev9+HTXkdWKkO713vfG8ZLT3LxDuTU/BLgE6zmYRq9g
	 BiUr/6p8pX7H0G+DLp0fyoxNQCo0IqRR0ZZgthEoUWKBul3Eqaa2i8VBfixYbR7rZG
	 vyL2A7sU/tmbw==
Date: Fri, 1 Mar 2024 12:11:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>, Zi Yan <ziy@nvidia.com>,
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
Message-ID: <2d5f9cd5-a2c2-453e-aa52-a84a86107d1f@sirena.org.uk>
References: <20240226205534.1603748-1-zi.yan@sent.com>
 <20240226205534.1603748-9-zi.yan@sent.com>
 <082e48c8-71b7-4937-a5da-7a37b4be16ba@arm.com>
 <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghaC36SALgS50dQQ"
Content-Disposition: inline
In-Reply-To: <0dab0c69-2eac-4e65-9efe-e0b037499abc@arm.com>
X-Cookie: Schizophrenia beats being alone.


--ghaC36SALgS50dQQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 10:33:15AM +0000, Ryan Roberts wrote:

>   - In create_pagecache_thp_and_fd() you do *fd = open(testfile, O_CREAT ...);
>     where testfile is /mnt/thp_fs/testfile. So if /mnt/thp_fs doesn't exist,
>     then the open will fail I think? I'm pretty sure that's what's happening on
>     our CI. Suggest the test needs to setup this dir itself. Is thp_fs a mounted
>     fs or just a dir? If the latter can you just mktemp()?

Mounting on /mnt would also be a bit of an issue, that's something
people are relatively likely to have used for something so could be
disruptive.  If the test is going to do a new mount it's probably better
to do something like make a temporary directory then mount on top of that.

--ghaC36SALgS50dQQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXhxgsACgkQJNaLcl1U
h9CNLgf9HnhxProx3fA8CTE/KbjX2kFnC4nKYaXEmu4hIqNDt7YEDJ3tb98zw/Sj
bTFxhX7W1MPl3iqo8ylB7H8Lkx87AgriD1Z1Dx7ejr4VuFG7wY+yee81LuIL9p9K
YCRKeb8PXzdPitkpVupwFmf3HxNLkpOnPYnZz3e5J6UNthFxxBHkcDKXxNGxa3v2
JE4LuVmQ+tSw442i4gNHrcmIuaSIIdlcGX5GcNFRGvIpR+UshuCxz3nW3E++9Yoa
3V+ueMu756haaNJActL1liljR0Q6JMp934EuvNJ+o6XWl48aGkuXQ4dUabvm7Qn1
LwbKuFeIM2JiK9dS6EWSVyiPTPvS1w==
=Rx7H
-----END PGP SIGNATURE-----

--ghaC36SALgS50dQQ--

