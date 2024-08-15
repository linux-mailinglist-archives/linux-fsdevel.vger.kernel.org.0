Return-Path: <linux-fsdevel+bounces-26075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBF795372F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB071C23503
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53461B1427;
	Thu, 15 Aug 2024 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psefFyFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB321AD9E8;
	Thu, 15 Aug 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735608; cv=none; b=WB+5R7LwF42YEazsx7N/wvLP3wac/GW+Xw+84Y0qalwLWEkqVmMMAvHT8y7cI7r65MtANDNh49VRYV1f7BWFolxUJF1eXmOlarLrD0kUZQ09Hbv2kHP1InQ0aIaWEnLcIYInWaheUXuSpjATwW+y5dAeh65wB7HIxIf3F7/nEss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735608; c=relaxed/simple;
	bh=Wv1kQ8mBOvNs2q3MqL2TJnvCXLTai7JxFQflhk6OGQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg//R7WFypvQLdlCpOGBqFsmdjbzC6tz2UQSZ55dvFJgIMTITpA0KttVJ8vpOF/U+3n1WH8SsCDv8bwKg10fZfW+cJKO4lDGXCkuIh3FgWb1mu+P2PLbCWRb1yDg5qiQeXRswIPoacvM6wlsBJssvLDHgWn2pmy2T0P3iyX77hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psefFyFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714D9C4AF0D;
	Thu, 15 Aug 2024 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735607;
	bh=Wv1kQ8mBOvNs2q3MqL2TJnvCXLTai7JxFQflhk6OGQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=psefFyFwcCSMM704n/PghElOSiJNvILlJNI0F9AWzTMwXrebRp5JcacIDypratT/1
	 0v73e8fN2mho163LqjEJtpaHXOuGAR1msR4cfx917H+frORBPL41NHpr7hKJ52tLV7
	 DDOLTfoES26QUqTBCR6Mi7zHCAZM1FdO91OOgnmLXfhnmLymP+AKnXqRXuJisb/8Hn
	 CaiF+u1pKyKBUNTe8jpwL11FVRnO6ahy5qNXExYGGIF7OEKCfLzQ+wkytqH2lktzeM
	 Fx7GWcm+n0dGpb7ocTZSESpLstlhljmUetVxXd/Y7BbrABrVO2e8I9L4aakKxQ2CHg
	 1Xn27J8A2inAw==
Date: Thu, 15 Aug 2024 16:26:38 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"ross.burton@arm.com" <ross.burton@arm.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Message-ID: <3a7d9b69-e9df-4271-a3f0-8e8683c2654f@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-12-699e2bd2190b@kernel.org>
 <34f7a5378447b1a8d5a9561594b37cfeaa6bd2b1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MksM19X6NXlfICdi"
Content-Disposition: inline
In-Reply-To: <34f7a5378447b1a8d5a9561594b37cfeaa6bd2b1.camel@intel.com>
X-Cookie: -- Owen Meredith


--MksM19X6NXlfICdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 03:20:52PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2024-08-01 at 13:06 +0100, Mark Brown wrote:
> > Use VM_HIGH_ARCH_5 for guarded control stack pages.

> FYI - If you want to have more complete guard gaps, you need to do this for arm
> too:
> https://lore.kernel.org/linux-mm/20240326021656.202649-14-rick.p.edgecombe@intel.com/

> Using VM_SHADOW_STACK only gets you part of the way there.

Oh, thanks for the heads up - I'd missed that.

--MksM19X6NXlfICdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma+Hi4ACgkQJNaLcl1U
h9Doewf/XswNKQ3VlzKzKEKNyYD5iFma82uwYhlhHv9Nqsb6eiF4zUSOOgbna6xT
Cq8p3DS/Im1Fgx/SaMcGP6tNihKE5DGkEufWy+6GIiS5SsrxhPlnzDtY0F4cJ4a5
AELeMm6OD9wZFwcAwnuUJraMRY6olKHlI+cfrFcncvwLNwLkaVE0JlcB1dOxMNSR
OqvnO/G0VM25OdY7SV+tJKRi/U5eIa+chRhV0i+qaQOu8oRJfEo6BqkFxz+ZHF19
Dwr/HiGZa663RJVxgdp7mhrotkqK/nCoNksP+gjuEt6z2TIFNdcxPg0BK6mfgN+0
qAKWzvjayIQ9j400dGkkiwuj5/+SNw==
=TSgi
-----END PGP SIGNATURE-----

--MksM19X6NXlfICdi--

