Return-Path: <linux-fsdevel+bounces-24059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DED5938D45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 12:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7929287F42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2755A16C871;
	Mon, 22 Jul 2024 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNcTvEEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5216C6BA;
	Mon, 22 Jul 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642936; cv=none; b=FPTo9/1KexsFYXc+TrSQOJlwXGfjP+DXJ8lg/MirdFuH2KYz137PTTgw/9SxvdZimaf5OUstFUituCK5JBHBq77EUxTuTMUu4ieH30FnuW4yFQZnipPtae5c3EgjRZI1ogVwyP+5UJ8m5dP6nnEapTtnHhTGjfFvCDhJzpT8Dfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642936; c=relaxed/simple;
	bh=7h5Kr+YpdYtQ4+7prp0Efe9cyc7VuT34aSYyd6+RWOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6vwXO+f8gQ7NSk+gLWCQ3o2/dqtA/1lLHeXbTv2u0Jv3kPGmzlMHmGirrEL1723weDjPVDTu/srCzpaTV540l/5pShx7tRjwZq/HOHMG20votxa9fGLgkHpmv8PgeUs5afxWeDe1wMMh8GnBoL4Dr9wvb/qU1xzH5EFlc251YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNcTvEEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921B0C116B1;
	Mon, 22 Jul 2024 10:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721642935;
	bh=7h5Kr+YpdYtQ4+7prp0Efe9cyc7VuT34aSYyd6+RWOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNcTvEENz+fFubHxaCVUTSqYq1ITDfo0ptFNNyhZiJtkY03TadBS1i+ZhqHLfVGJh
	 wejLfRGO7/MXoIRjPmgVOznu/m8as04rC7MuUcV6ZUI86ATnFB/wd9trpSHBjpMIJe
	 1zP6D6J4UnP/C2ivTwawSleVhDsGeYcY8f3s+xp8ATTVohoch6BbiYzMzCYthbAZSo
	 Ju4lBHrZm7WycGEE++o52rHSPjU2WPyxwG9PV6SYXLz5E6v92bSrMIBCRBl79m4ZZz
	 UbOhxWSEIT/Q1c55byiM2Jo3LnSq0IoSgxoIde6Xxp0OyfH8W75BVC3lhxcNX8Kqeg
	 0Slz4wCmQVXnA==
Date: Mon, 22 Jul 2024 11:08:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 38/39] kselftest/arm64: Add a GCS stress test
Message-ID: <53c98e88-b12a-40e4-8b01-d7a4394c2471@sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-38-0f634469b8f0@kernel.org>
 <875xt2xojp.fsf@linaro.org>
 <871q3qxnx6.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d44XRLGyLTUTZna7"
Content-Disposition: inline
In-Reply-To: <871q3qxnx6.fsf@linaro.org>
X-Cookie: Everything you know is wrong!


--d44XRLGyLTUTZna7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2024 at 08:47:49PM -0300, Thiago Jung Bauermann wrote:
> Thiago Jung Bauermann <thiago.bauermann@linaro.org> writes:

> > # # Totals: pass:0 fail:9 xfail:0 xpass:0 skip:0 error:0
> > ok 1 selftests: arm64: gcs-stress

> Also, Shouldn't the test report "not ok" at the end considering that
> there were fails?

It doesn't really matter either way, the per test results are captured.

--d44XRLGyLTUTZna7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaeL64ACgkQJNaLcl1U
h9DdSwf+OKUfn8laXp+yxRv2lSbOzqFMeeL5M5MmJtaH4D5q5G9SwlMCVx3e+7BW
utABRB30/1ASkvtYLdYwvPw6y+Jn9P2xtdttvx7+U/aggTBaWWW0fa6cB9YTKO+a
aRyNaxotBkWFmPUl7qa4kpMWb5FDtxX3iLlCw0GicotYaWJKGHEUQ6AFxGjmQaM5
O1eXLhARUQ8l2+k8A6a0WXVZvZJdhyLouFkswNGmAKdnfd6mYvY9DIBejxtsBJlH
M7xvo9iPSz/18Y/x4HdPAjjwGHYNRkuhYT8QMhZG5TzTpNMXwEXpKbkkKETAklkz
289HaQ9+gTL4ZnRsy1VMxkkxoqQ83g==
=SALv
-----END PGP SIGNATURE-----

--d44XRLGyLTUTZna7--

