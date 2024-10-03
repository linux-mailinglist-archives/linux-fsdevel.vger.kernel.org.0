Return-Path: <linux-fsdevel+bounces-30894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE998F1D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0BA1C211A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67BA1A08A0;
	Thu,  3 Oct 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SozEYIMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E81E52C;
	Thu,  3 Oct 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967062; cv=none; b=TM4Rc2uAhBet7HBW+6ObcM61SW/+oKNpivI3LrGTrt76jgg3yGmmsoacfj8cOY2n2p5YV05o2avwGl4Uy3lJv0IFxqsYzdD+kC7quHBHVu6OVdzUp+9P9q6pDDqsA/sauCa7InCfeuewF2fAo5IiE7CYkvTNJrtRMvBTOPM+ZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967062; c=relaxed/simple;
	bh=84mxqz11Cs3IrhMMq/BoLGimGyYEOQcc4TuOpIDegpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAQGUBI7arMhkQd2/JSBXZQJ8ZWp4giunLbB0QyuOdHprQ+9Gu50iqD0D2GXpWFd+C6IXGsNqr/L+VahvNTOXLxKDhRq7l+Xh+R5Y0z/71W3iLIK5rUcsC7QIgLXGAHW5rsskQxFiHktSfwMQUR5neaZZl9y/0KD8/sP2QXldUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SozEYIMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E93DC4CEC5;
	Thu,  3 Oct 2024 14:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967061;
	bh=84mxqz11Cs3IrhMMq/BoLGimGyYEOQcc4TuOpIDegpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SozEYIMNfQdA08ap8zdn8koBK0e5WTFzbIvCrwSxzNz2okoVA4Jx2ISGiwZcQMrUP
	 /TLWP6uF2cb6g0RNpjG4GheIE3lAb32d74kKnEgOKsiDOPJe0zDlVAmWLdr2dGh8lk
	 U9TRTmA/9PqNPDvOaDo7Szldk08hT7tOyKoM0RvAYRBqtvmtNRpoEhRJ1vTST8kSbp
	 8kePx2BdLGQOLdH2pvbKe5TaKxhNT1zvBzqboN5sDp6/ze1cLtrOXfBr55ZZAuxDw0
	 xK/xXsog4yA9O6+RT0K+o4ID+cG6v8tIPPKVpIDa0N4xb6B6bS3JHGF5xok5wdLF1A
	 +oqqmKo+tGMiw==
Date: Thu, 3 Oct 2024 15:50:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 16/40] KVM: arm64: Manage GCS access and registers
 for guests
Message-ID: <1ec14d13-7db6-4642-a14b-db8ae362e594@sirena.org.uk>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
 <20241001-arm64-gcs-v13-16-222b78d87eee@kernel.org>
 <86bk0373nq.wl-maz@kernel.org>
 <86a5fm7b4i.wl-maz@kernel.org>
 <37fbc082-6bda-46e3-9ee7-9240b41f26fd@sirena.org.uk>
 <868qv6717r.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hfl6icctJG+FIkDo"
Content-Disposition: inline
In-Reply-To: <868qv6717r.wl-maz@kernel.org>
X-Cookie: I'm into SOFTWARE!


--Hfl6icctJG+FIkDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2024 at 08:29:28PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > They are, though really they should UNDEF if GCS isn't there (which I
> > had thought was what you were referencing here).  Equally we only have
> > traps for a subset of GCS instructions and it's not like there aren't a
> > whole bunch of untrappable extensions anyway so it's not clear it's
> > worth the effort just for that.

> If the encodings UNDEF when GCS is not implemented (i.e. they are not
> in the NOP space), then all trapable instructions should absolutely
> UNDEF (and yes, it is worth the effort, even if it is only to
> demonstrate that the architecture is sub-par).

Yes, see DDI0487 K.a C5.9.  If you're concerned about being unable to
generate UNDEFs there's a rather large set of existing extensions where
that's not possible, most of the hwcaps in the hwcap selftest that don't
set sigill_reliable but do have a SIGILL generator for a start.

> So I expect the next version to handle traps for GCSPUSHX, GCSPOPX,
> GCSPUSHM, GCSSTR and GCSSTTR when GCS isn't enabled.

OK, I already had that change locally after your first message.

> I'm also pretty sure this is missing some form of sanitisation for
> PSTATE.EXLOCK, and looking at the pseudocode, you seem to be missing
> the handling of that bit on exception injection.

Ah, yes - I think I see the missing exception injection handling in
enter_exception64().  I'm not seeing what you're referencing with
sanitisation though, could you give me some more specific pointers
please?

--Hfl6icctJG+FIkDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb+r0YACgkQJNaLcl1U
h9CPnwf/RsvoCd86wK5IpYW+I+BQekRext2o88ILr987SA+imxBsKq7L8n9hdvkg
XOQxpyooxGUM9SkA9nuEFp0h5XNzoKf9AgiI+7lypHe0Nr07zzVdh4oq/A5WuiKB
v231xK6ewa2AEAEvwwYxzafSbmn7fU0Cbjg1+ioSRCNWAa5XVA8rEFJX8ND6TVff
pzx8UKtoFPltnc8jZHY/cPDTnXHvugmZiz/FC/9KDy/hCmuTCkYJBstD1zP9g3f0
1e3X2QZ804cZ5n6MGJSpU3ReexcVxbVoXsdiZiV017zmN6qUMnjJnQJ/NknLUWdK
80HXbpm8hN30vdK0zT5J7KSqtxLkzQ==
=8W1g
-----END PGP SIGNATURE-----

--Hfl6icctJG+FIkDo--

