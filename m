Return-Path: <linux-fsdevel+bounces-21124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FF8FF3D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 19:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B32A28BF1A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0311991DA;
	Thu,  6 Jun 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzqZudFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EE19597A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695214; cv=none; b=JKykheEyPThMIKAOMh6lJ9lH/UZzstZ3CrpCumB1CsJXPj40KX0OiSsI33Z0z7oKmNqjuthfTn4a68gPG4wjucoXbFWCuDiZ0C/Kd7PnnzkWnGsxJyUN82O5gBCsyWqv5dRCWOMO0na4Ratajk3yzNaeZcmwG5uVd3EQoO3TvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695214; c=relaxed/simple;
	bh=h1tqxHRn3WgNeWV2vLYb7cxRGZEBkeJFRUmZJQW8XRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNJy/6WEq2hR4rDShTZmFW0wAXCp41NNHzLXYy8tAg1sbtlpPHChQFzZcAoH1EN8sHwpScAheiFCQUSWL846MOTVML1VXfwDQ0KQmZ6X4H6CIn5Z1c6et6SVERbkcE/eMR1hJNJuCE/0HAfLB3mdR0mmTtGOLUmdZvQ3qn4Zwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzqZudFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E2BC32782;
	Thu,  6 Jun 2024 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717695214;
	bh=h1tqxHRn3WgNeWV2vLYb7cxRGZEBkeJFRUmZJQW8XRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzqZudFJms6501j4hwgdvSV3MltabAuSvPm10ihlnx5zqZOphWZ4lOkl6/AUqSgcE
	 rlOPre6b8lnW8jyOzJ4UWSTHPm85nE39OJ1/J4yPdRSV4aMPpxwZTwpszRVBVB+bfV
	 7du7cgaQXo8yZFtvWbb1LdvdCmWfqJOuGLjisfisHo1BMQMYQpeplhzcr8t+tkkxgV
	 TiqhlZuhh9qZMx1Vnt2zAZRfTE0w+3N52q7Im6XEOeUmS3xrC2manQPQl8nGaYd7lE
	 4wdd0Hu6DSEjSV0FIy/YV3EIQLleN7CX5ZVS2/IxCiIW2tvSC8moNoh1KgsVqTATw8
	 B9f60WwAp5TLA==
Date: Thu, 6 Jun 2024 18:33:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, david@fromorbit.com, hch@lst.de,
	Linus Torvalds <torvalds@linux-foundation.org>, amir73il@gmail.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>, ltp@lists.linux.it
Subject: Re: [PATCH] fs: don't block i_writecount during exec
Message-ID: <1eaedeba-805b-455e-bb2f-ed70b359bfdc@sirena.org.uk>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
 <f8586f0c-f62c-4d92-8747-0ba20a03f681@arm.com>
 <9bfb5ebb-80f4-4f43-80af-e0d7d28234fc@sirena.org.uk>
 <20240606165318.GB2529118@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oMXMubHVV+7Mjl7S"
Content-Disposition: inline
In-Reply-To: <20240606165318.GB2529118@perftesting>
X-Cookie: Simulated picture.


--oMXMubHVV+7Mjl7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2024 at 12:53:18PM -0400, Josef Bacik wrote:
> On Thu, Jun 06, 2024 at 04:37:49PM +0100, Mark Brown wrote:
> > On Thu, Jun 06, 2024 at 01:45:05PM +0100, Aishwarya TCV wrote:

> > > LTP test "execve04" is failing when run against
> > > next-master(next-20240606) kernel with Arm64 on JUNO in our CI.

> > It's also causing the LTP creat07 test to fail with basically the same
> > bisection (I started from next/pending-fixes rather than the -rc so the
> > initial phases were different):

> > tst_test.c:1690: TINFO: LTP version: 20230929
> > tst_test.c:1574: TINFO: Timeout per run is 0h 01m 30s
> > creat07.c:37: TFAIL: creat() succeeded unexpectedly
> > Test timeouted, sending SIGKILL!
> > tst_test.c:1622: TINFO: Killed the leftover descendant processes
> > tst_test.c:1628: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> > tst_test.c:1630: TBROK: Test killed! (timeout?)

> > The code in the testcase is below:

> These tests will have to be updated, as this patch removes that behavior.

Adding the LTP list - looking at execve04 it seems to be trying for a
similar thing to creat07, it's looking for an ETXTBUSY.

--oMXMubHVV+7Mjl7S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZh8ucACgkQJNaLcl1U
h9DEWAgAg3Bd8SpcTSwXuQwwASRPGQIPTo+bVyj9IIo+tah4pwnwQBfyuVRikWii
LLgx2IfuwuMgp8PkXmX7cLNqDJYVr9MArdGoZsJX7yUnv3Lfo7wY0lCBwskqz4RO
EBD9c1LhhAZaKmlMlj2O6CTSZsdzIDhOaHdPa86Mj372FLhm9UzSD2PoFFYpG5wg
t9iQ0t0bA31xjjM2VK7TAnTWxs2jt97Oz+Ml5Lhx+Iqy9NiEBq2mTMshU4QmZ4Yc
tG5hryjzWk1Rwzz176/L+dK0V9iIiRc6io+VRrA3xcnvYH5oSKKc+YFrqcIXKrDE
cKTyu4gb0RbM3z7GSgRs4juKXPRXAw==
=8jus
-----END PGP SIGNATURE-----

--oMXMubHVV+7Mjl7S--

