Return-Path: <linux-fsdevel+bounces-10083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F938479D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CAE287769
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D79B80608;
	Fri,  2 Feb 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpDr/jIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435915E5DA;
	Fri,  2 Feb 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902985; cv=none; b=Gh/dGYJL1P6lmWcliMNO1FFwPyfq16yj8QAhfcvCYY2Jh8dsyVN05PynKeYgGee/d66PN5X4RckKMYv86O8FUUPBXH8oZnS2F0CTs7v2mVWHOpDlpQjTssP9CztIn166IPmJ4JNRFlKDnK1qd/AWHBurSsknD8kQHqhY7dhg0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902985; c=relaxed/simple;
	bh=ZwrgXHe3wneQypj3Dc4bf/lJKHWeRZdQb8qhTrh4M5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4gzg5vNkfb7WV4aOX8JdHwLaNxLXDgDW8YlYE0XiXPbR0WNjF8WHOaJISO13v0sTiImTsahbJcfdKJdxhoJtcD++d2uR5LBgq0zYayhk5uDSt/SuVKm3KFX8Ry0rl/Lo+NXuDRuFVRc3HhVgUCACHakJHfjgPUwshWmBjMd2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpDr/jIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23E1C433C7;
	Fri,  2 Feb 2024 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706902984;
	bh=ZwrgXHe3wneQypj3Dc4bf/lJKHWeRZdQb8qhTrh4M5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpDr/jIGnKGsGpiIqxEkGwO5QRX44YnioBJP5jAu4/eXq5DBe9xAuGNNELCpLD7kq
	 +wJNNAqksWRpk4f46mxTI5MfKKahQM37DWqTG+rUe64NW1E0DnCTmhwdxbXLHulhrh
	 KJfEApVOmLIAihRN1NZsj7M8S2jxmqk+XritSl7sbkFivXBSkgtkbmuiYPAXRaNnfD
	 AUUS3aNnBHaBTjPqxDdF4e+u8vg6QyHrOozmVZUixNfIyOlIfIuItVGod/dQZKzGA2
	 Kni3bp/3QOsyz6fB7+ZTqfahBC8hAY+Zhtn6zsChSc47sjXTDNra5G49yaijHrVJKq
	 nsqmjGNzMoZTQ==
Date: Fri, 2 Feb 2024 19:42:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Doug Anderson <dianders@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Oleg Nesterov <oleg@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <d7154f86-d185-495d-aa84-63d4561f1e47@sirena.org.uk>
References: <20240202012249.GU2087318@ZenIV>
 <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV>
 <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV>
 <20240202040503.GX2087318@ZenIV>
 <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
 <20240202164947.GC2087318@ZenIV>
 <20240202165524.GD2087318@ZenIV>
 <Zb0vem7KC28gmT5U@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5nsJ0jp73mUS/QGW"
Content-Disposition: inline
In-Reply-To: <Zb0vem7KC28gmT5U@e133380.arm.com>
X-Cookie: Do not write in this space.


--5nsJ0jp73mUS/QGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 02, 2024 at 06:07:54PM +0000, Dave Martin wrote:

> So, if the only reason for trying to migrate to vmalloc() is to cope
> with an insanely sized regset on arm64, I think somehow or other we can
> avoid that.

With SME we do routinely see the full glory of the 64K regset for ZA in
emulated systems so I think we have to treat it as an issue.

> Options:

>  a) bring back ->get_size() so that we can allocate the correct size
> before generating the regset data;

>  b) make aarch64_regsets[] __ro_after_init and set
> aarch64_regsets[REGSET_SVE].n based on the boot-time probed maximum size
> (which will be sane); or

Either of those seems sensible to me, a function would minimise the size
of allocations based on the process configuration which would be nice
and given that we're doing allocations it's probably reasonable
overhead.

>  c) allow membufs to grow if needed (sounds fragile though, and may be
> hard to justify just for one arch?).

I'm having a hard time getting enthusiastic about that one for the
reasons you mention.

We can also just lower the maximum size we tell the ptrace core to the
actual architectural maximum since AFAICT we don't expose that anywhere
external, I've got a patch in CI for that.  We'd still be allocating
more memory than we need for practical systems but less extravagantly
so.  It seems more suitable for an immediate fix for people to pick up
for production.

It did occur to me at some point in the past that we should avoid
telling the core about regsets that aren't physically supported on the
current system, I didn't get round to looking at that yet.

--5nsJ0jp73mUS/QGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW9RcEACgkQJNaLcl1U
h9DOywf/cw76/6sNzpR8nrtANUPfbOuMMe64FuF7iDSV4ZCC0X9SfJ5hHe1GwfQv
MzT2r2wocWZbrmhBcxb8YOJoU2uSbI2nc7UdMDMd9PL0UE8RmkEcrIWWFGMClwz4
++aSfY2e7wiQ9a6X/IrM3jj+lDhx7BY3MGtfkvOqrE88g4yUEU6HS1rjaAzTUW84
WfgsyYRLs7m0SE90x6in8OR5Cdfts2AvqadR6EA4nwpwWOxUsIcw6o/wBpPxd05t
gFfYutiSWuHMLlFzxO8VdRBbW69tZRj8xvpnKJ6R2xS1nIzxzZkCNpn88kgLpZP9
ROsCwgB8JM57McXHJCqXOyMxjxfTCA==
=Rpx9
-----END PGP SIGNATURE-----

--5nsJ0jp73mUS/QGW--

