Return-Path: <linux-fsdevel+bounces-26129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF857954C9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACEAB24B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D563B1BD039;
	Fri, 16 Aug 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayq31Px+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B457191473;
	Fri, 16 Aug 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819247; cv=none; b=CsxkRbk0fWTnICmDhA8J5dh5KcvlSbBQ8uxMb3WuWVIDtjfhRqPegNw4JUp2h+XI0XEh5p7Qj/fpImyVfV9P8OyOObWO3EIOIWfKEyt1T15xhlsMnRCY050UkWzixo0SoRjtZ9iAOV2xAjhnQJrpycOqHHqgqfsGcLlvD+V6dfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819247; c=relaxed/simple;
	bh=UzDJBf86ETc8UZTa5b4UELQHYAFgRcESJ7jTnyf0ZwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wa4lt09QjCwh29D7k4ViAY2ntbyfiVUyvQo/OB1764AEqX5hVriPIU65kq0LYoL5fYdHZl1m66WKC3a3MRZXzR9CivEerPxSA/VEjvCQ3bAbsC+yg4V3B2GD9kd2Z0M7WtfVDAP30v2ovSErKLbVPp343K9J6u4jNhhnd8xtZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayq31Px+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19210C32782;
	Fri, 16 Aug 2024 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723819246;
	bh=UzDJBf86ETc8UZTa5b4UELQHYAFgRcESJ7jTnyf0ZwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ayq31Px++sqKgYH6KIIEfzP9t8l7YzSD7GuJ5qmVc4DKeok71ex+gt8p6GXQrin0A
	 FMv1eKs/V3igtiQsqzoKNRGY+vydPlJjsnnKO+K1utHrSAE5nJ47/kWP2P3hXvjhOw
	 8vEjWx/dU/C0TnCX962O46QCERiC7GU9AJryrZV+7/2dJDsGItKkMAj7UaHl47sl4W
	 v9sA63+/ybob+fDBXeRr2eiO0MIYZ5vbql1dY6Q5I+ccEVg2igJ9JkeO501cnqMHKH
	 GjTuEJ//TuTnk5PuY4xNxD9ZEeux/z7OctdL2wDddo21XP0TYtjEzdJy6qH/qPzfQc
	 cKnhkuzu5vfhA==
Date: Fri, 16 Aug 2024 15:40:33 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, joey.gouly@arm.com
Subject: Re: [PATCH v10 14/40] KVM: arm64: Manage GCS access and registers
 for guests
Message-ID: <8c1e8fb6-0152-42f7-ab6d-93f6fe70b4aa@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-14-699e2bd2190b@kernel.org>
 <86h6bkzh8o.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DUpDdNL7GPA6ROUr"
Content-Disposition: inline
In-Reply-To: <86h6bkzh8o.wl-maz@kernel.org>
X-Cookie: A Smith & Wesson beats four aces.


--DUpDdNL7GPA6ROUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 03:15:19PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > +	{ SYS_DESC(SYS_GCSCR_EL1), NULL, reset_val, GCSCR_EL1, 0 },
> > +	{ SYS_DESC(SYS_GCSPR_EL1), NULL, reset_unknown, GCSPR_EL1 },
> > +	{ SYS_DESC(SYS_GCSCRE0_EL1), NULL, reset_val, GCSCRE0_EL1, 0 },

> Global visibility for these registers? Why should we expose them to
> userspace if the feature is neither present nor configured?

...

> > +	if (!kvm_has_feat(kvm, ID_AA64PFR1_EL1, GCS, IMP))
> > +		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nGCS_EL0 |
> > +						HFGxTR_EL2_nGCS_EL1);

> How can this work if you don't handle ID_AA64PFR_EL1 being written to?
> You are exposing GCS to all guests without giving the VMM an
> opportunity to turn it off. This breaks A->B->A migration, which is
> not acceptable.

This was done based on your positive review of the POE series which
follows the same pattern:

   https://lore.kernel.org/linux-arm-kernel/20240503130147.1154804-8-joey.gouly@arm.com/
   https://lore.kernel.org/linux-arm-kernel/864jagmxn7.wl-maz@kernel.org/

in which you didn't note any concerns about the handling for the
sysregs.

If your decisions have changed then you'll need to withdraw your review
there, I'd figured that given the current incompleteness of the
writability conversions and there being a bunch of existing registers
exposed unconditionally you'd decided to defer until some more general
cleanup of the situation.

--DUpDdNL7GPA6ROUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/ZOAACgkQJNaLcl1U
h9AqVAf+My4ZnSnvRQhvDgit0vtodchlwobno2H2GE7edIRFmlg3k4goJ7BXcmJp
HS9AzX6BzfrFZrvDxZIfwrvfIp3wCTp95dOSfLGENuWQV7IByIKHIHZdU4DYr/Xt
3xJTwzDiJx19EK8R6usMaaQDarxQ9gozKbteWUt761o+iCKU6SGOvoN+2TkScTkA
jmS+wMgm75FpHNpFm/wUixbuKoldXbagTgo9Wgly4xIW+11Rzpz/btXniVTM07BR
XrnBaW2kdCXjr2C71bZGVBmg14aQCRh72D4xikY8k214GwuzeQbQber+iLP4io82
23ty1aim7XcdSmNPpDiJfoiXcJ1yYw==
=CjJp
-----END PGP SIGNATURE-----

--DUpDdNL7GPA6ROUr--

