Return-Path: <linux-fsdevel+bounces-26372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF063958B44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1241C21DF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C75194137;
	Tue, 20 Aug 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUHjXyZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE9192B79;
	Tue, 20 Aug 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167712; cv=none; b=Wlt8mNVL7suFyw9uY3nEAIyejhpSV9aWbKMdlaKRf3G9RIBwTqO0mlUpZJ44C0E2klzxO85K/UORwA68u8H5/BgPOFfrNdtU3dF3XVqL1oZ3Qlc0HUpSDo7upbhX7U7iSjWoosAem2atRPQArRnjRStGO0ZViaMwLs9xJGgCcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167712; c=relaxed/simple;
	bh=xOjQogCtboiaDEhhAKTxRH8bKSHT1uounx3l9TGETkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucknl9L1tszzlP7Wrr6/gtl/+udJuYaD+PTIGOcZ7+RpEzU+K3Z5ae1TmofJHQzVSW9ZQrpW8A5Hsci+T5GjyJgAtRBTOSiEYitM+4BelMaa4KWCH0YKBJMBSlcuUqjb9Ph0/CsYHrdTOF+Bs7kWaXFv46582dYtOpG+3jINVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUHjXyZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A68C4AF15;
	Tue, 20 Aug 2024 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724167711;
	bh=xOjQogCtboiaDEhhAKTxRH8bKSHT1uounx3l9TGETkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUHjXyZ2cuMRwBZU5drzIzAGHafYcOZVbd1dCQIvRqjL+mp8tIA7XyiFy2cCb1lAg
	 shLO3+WN20Pzstfw7TIY2Fm2/7O7P4rPMgRslOFF8FRrg5Tw2W6K9hg6CDeDyr8s2Z
	 dKLgO9QioVdce5HjIPnrHbA9CcZr9rhwfYiWAECOhm3Baxn+aET9P9N/7KW01x8G0S
	 /YxbQ0SJf9JMPYzBsRG29MU+0Jcbf2gF1OwWZVEZ7C4nAiUP1XjAknZZ1nqJiNVWhj
	 kyX3Qc98DJ/Vu/F5kkqrEn7yAsqfSZ1u+3FxpVBchfgoZTJgonBtBTHqFWeoKMXyEt
	 2C+GLM3zIUHtg==
Date: Tue, 20 Aug 2024 16:28:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 13/40] arm64/mm: Map pages for guarded control stack
Message-ID: <ec999bf5-6273-4a3c-b1df-f8594d7bb228@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-13-699e2bd2190b@kernel.org>
 <ZsMMDNIp6Pkfbg1e@arm.com>
 <d43f8036-cc06-430c-9e9e-b938037fc64c@sirena.org.uk>
 <ZsSvSeE303LGtk4b@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RmO2vT/CXaa26vbH"
Content-Disposition: inline
In-Reply-To: <ZsSvSeE303LGtk4b@arm.com>
X-Cookie: You are false data.


--RmO2vT/CXaa26vbH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2024 at 03:59:21PM +0100, Catalin Marinas wrote:
> On Mon, Aug 19, 2024 at 05:33:24PM +0100, Mark Brown wrote:
> > On Mon, Aug 19, 2024 at 10:10:36AM +0100, Catalin Marinas wrote:

> > > At a quick look, do_mmap() seems to always set VM_MAYEXEC but discard it
> > > for non-executable file mmap. Last time I looked (when doing MTE) there
> > > wasn't a way for the arch code to clear specific VM_* flags, only to
> > > validate them. But I think we should just clear VM_MAYEXEC and also
> > > return an error for VM_EXEC in the core do_mmap() if VM_SHADOW_STACK. It
> > > would cover the other architectures doing shadow stacks.

> > Yes, I think adding something generic would make sense here.  That feels
> > like a cleanup which could be split out?

> It can be done separately. It doesn't look like x86 has such checks.
> Adding it generically would be a slight ABI tightening but I doubt it
> matters, no sane software would use an executable shadow stack.

OK.

> > > Is there any arch restriction with setting BTI and GCS? It doesn't make
> > > sense but curious if it matters. We block the exec permission anyway
> > > (unless the BTI pages moved to PIE as well, I don't remember).

> > As you say BTI should be meaningless for a non-executable page like GCS,
> > I'm not aware of any way in which it matters.  BTI is separate to PIE.

> My thoughts were whether we can get rid of this hunk entirely by
> handling it in the core code. We'd allow BTI if one wants such useless
> combination but clear VM_MAYEXEC in the core code (and ignore VM_SHARED
> since you can't set it anyway).

I have to admit that the BTI because I was shoving _EXEC in there rather
than because it specifically needed to be blocked.  So change the check
for VM_SHARED to a VM_WARN_ON(), and leave the _EXEC check for now
pending the above core change?

--RmO2vT/CXaa26vbH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbEthQACgkQJNaLcl1U
h9C1gwf+L79Si923x11LZKfwuy0dQkE7LpTPSafOEhNGVDQZTOrYQW9x1homrSt5
28vBitZZV/TtBmLO+HSzt1fq5JM76Q0BaPH3ngunEJ0umUMkZwC3r59YzFHNXhQL
THzCh+B05luDGr58Ay6K29M/I8JVGiXNBd+Ag+/LYQTq2HXOPC7lJimbZAU0aS+Q
mV43kq/p+Ipazr6Bymd4tGQI5HjdMgMp2dhKT0bLH06aGJhif8691f8t9ZTp4lGX
1PqWpOuyg0qYDA8JAraUHsc+4FaMyygUqV1ZRC+aTjL/EVsIFwhvqeZzESS+C+/p
C9zocGnFLEdepXWg3jQHODDOF+LxiQ==
=8nDO
-----END PGP SIGNATURE-----

--RmO2vT/CXaa26vbH--

