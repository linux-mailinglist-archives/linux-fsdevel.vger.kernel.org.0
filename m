Return-Path: <linux-fsdevel+bounces-10338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA9184A015
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 17:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46651C218AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1141770;
	Mon,  5 Feb 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdAa96kD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191B3EA9C;
	Mon,  5 Feb 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152307; cv=none; b=JsrA9ydtCvLudb2n3F06VgTddG5RWE6HeESpLmtr/hcRvJihEPb/835Ao0wh1GRwe/iDrg2aEXHzScAGAQxqcKbEq+d8+5avgQ5zOrXUY734ljyrc6v/HewKt+2ry20O6Vf89+KLXeMrT6WJdDo6Rgd6JLTxSH3uUzTupon+UZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152307; c=relaxed/simple;
	bh=9FpafEGlyrNhPgZJkrgRLS7U6aCYTe6Poar4f0Fu86c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNX2AZ2loPzImhL2BHBwDYF++BgtrPHACT87etOZ+8o3NWj4+bPKrc6VbR4GO2P3ME3pv2tt3Xr38bF69f5AYUQ3qteh+jTXBuqAZsjliJo8IDzS552nPk1kYsEECngwnrQrNrzielmarhz5eWNXSbHxduGkpB040xBesVJlBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdAa96kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EE0C433C7;
	Mon,  5 Feb 2024 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707152306;
	bh=9FpafEGlyrNhPgZJkrgRLS7U6aCYTe6Poar4f0Fu86c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdAa96kD60IeV9lxQp0ubdqOgUSHcdsjtge2WP6mvoDwpwOe+Rw7nwcU7ORKlVlgr
	 8Z6UYcfu0rXRgY6H147qPvpixPmJkpZDmWrIwgKeNqmHE5Dyf5eNNmQ5bBvWaONUZO
	 0/G6+v/VmTdZm/r0jhWTvEEg+oGSkpJiB3YYAtdV41ad/d4EyHHPk7vnDwmNhbZO9W
	 xGQCvUQAyZvm+DIKz7D+cBrAtQbQgXkRRwM6jx1tMc0pifYl3BcJGyd0M/p6YJjmTK
	 m/3/iDifHMb1SIEd4HlIJDGTt/kOZPRgXRKA/sGbloE3oJcO4SJAp50Cw6wGa0iRnt
	 6WaVOdTjOW2yA==
Date: Mon, 5 Feb 2024 16:58:20 +0000
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
	Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 13/38] KVM: arm64: Manage GCS registers for guests
Message-ID: <ZcETrPAFFfgAy/PT@finisterre.sirena.org.uk>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <20240203-arm64-gcs-v8-13-c9fec77673ef@kernel.org>
 <868r3z6y6v.wl-maz@kernel.org>
 <825d2b35-fa10-43ad-b3b3-b29a77f3fed0@sirena.org.uk>
 <8634u76i36.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CPooLl9HGmOME8a3"
Content-Disposition: inline
In-Reply-To: <8634u76i36.wl-maz@kernel.org>
X-Cookie: You might have mail.


--CPooLl9HGmOME8a3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2024 at 03:34:05PM +0000, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Feb 05, 2024 at 09:46:16AM +0000, Marc Zyngier wrote:

> > > We have had this discussion in the past. This must be based on the
> > > VM's configuration. Guarding the check with the host capability is a
> > > valuable optimisation, but that's nowhere near enough. See the series
> > > that I have posted on this very subject (you're on Cc), but you are
> > > welcome to invent your own mechanism in the meantime.

> > Right, which postdates the version you're replying to and isn't merged
> > yet - the current code was what you were asking for at the time.

> v1 and v2 predate it. And if the above is what I did ask, then I must
> have done a very poor job of explaining what was required. For which I
> apologise profusely.

To be clear it's what was asked for prior to the switch to the
forthcoming switch to the parsing idregs scheme, I haven't pulled in
your idregs work yet since it's being rapidly iterated and this is an
already large series with dependencies.

> > I'm
> > expecting to update all these feature series to work with that once it
> > gets finalised and merged but it's not there yet, I do see I forgot to
> > put a note in v9 about that like I did for dpISA - sorry about that, I
> > was too focused on the clone3() rework when rebasing onto the new
> > kernel.

> > This particular series isn't going to get merged for a while yet anyway
> > due to the time it'll take for userspace testing, I'm expecting your
> > series to be in by the time it becomes an issue.

> Right. Then I'll ignore it for the foreseeable future.

Actually now I think about it would you be open to merging the guest
context switching bit without the rest of the series (pending me fixing
the issues you raise of course)?  If so I'll split that bit out in the
hope that we can reduce the size of the series and CC list for the
userspace support which I imagine would make people a bit happier.

> > > > +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
> > > > +			       SYS_GCSCRE0_EL1);
> > > > +	}

> > > For the benefit of the unsuspecting reviewers, and in the absence of a
> > > public specification (which the XML drop isn't), it would be good to
> > > have the commit message explaining the rationale of what gets saved
> > > when.

> > What are you looking for in terms of rationale here?  The KVM house
> > style is often very reliant on reader context so it would be good to
> > know what considerations you'd like to see explicitly addressed.

> Nothing to do with style, everything to do with substance: if nothing

The style I'm referring to there is the style for documentation.

> in the host kernel makes any use of these registers, why are they
> eagerly saved/restored on nVHE/hVHE? I'm sure you have a reason for
> it, but it isn't that obvious. Because these two modes need all the
> help they can get in terms of overhead reduction.

Ah, I see - yes, they should probably be moved somewhere else.  Though
I'm not clear why some of the other registers that we're saving and
restoring in the same place are being done eagerly?  The userspace
TPIDRs stand out for example, they're in taken care of in
__sysreg_save_user_state() which is called in the same paths.  IIRC my
thinking there was something along the lines of "this is where we save
and restore everything else that's just a general system register, I
should be consistent".

Am I right in thinking kvm_arch_vcpu_load()/_put() would make sense?
Everything in there currently looked like it was there more due to doing
something more complex than simple register save/restore and we weren't
worrying too much about what was going on with just the sysregs.

> > These
> > registers shouldn't do anything when we aren't running the guest so
> > they're not terribly ordering sensitive, the EL2 ones will need a bit
> > more consideration in the face of nested virt.

> The EL2 registers should follow the exact same pattern, specially once
> you fix the VNCR bugs I pointed out.

Great, that's what I'd thought thanks - I hadn't checked yet.

--CPooLl9HGmOME8a3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXBE6sACgkQJNaLcl1U
h9AxYAgAgiMyW4DrBuI2SbKKpBxTNqFWS6hwvL/pz27nGc2T9cgR2P2ODSG3A9Cv
MJh2K7irI4JHl/jj/8GLJLH5IVMOVyVYPtTxauHvCVu+I6RM92hSfVey9I7clK40
Lxhri2n3D8Tj89RvRi90LvEgM0pJKqGBYYpc+lZBuUVhpsHDx1rwBsuMmryxpbyX
U9xvwhFc+lNUfrCUYIVp0VThb8QBJzBYs0SSVyM1ggHARaP+t64DzE+vrtI9h5QN
CQo6qN+H0ojTvx9E0MGZhqBPtNnGOs3jafSq88emxX431D+3kZSJwY4npbfFNQd3
Il677REj9RoCNO5cSTKMWWb27EzOxg==
=xxbo
-----END PGP SIGNATURE-----

--CPooLl9HGmOME8a3--

