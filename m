Return-Path: <linux-fsdevel+bounces-23504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E131392D750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 19:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B781C20F40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37483195399;
	Wed, 10 Jul 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj3wTGeG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4034545;
	Wed, 10 Jul 2024 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631810; cv=none; b=VuVwc6igdi9i+bvt3kv1ciM0o0aAZQ/OZ16V7u8PUfYyNGFKqxpFhvZHKsorQsbQZ3YnqDziJuFugDiydgk1cqZP+2L1wI0K5fFfR8T9YmSuaM3bJHjU9QDOS6uk3BH4BT8dpIqiynzzXGG64QqlACvgvH8L+I7sNGa3IIi/J9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631810; c=relaxed/simple;
	bh=gbQbaUuiVBZ3rY0fazMfEsDsmp1EJvBByE9rwhcqv1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3ylZxPg4GPLoSzOw7X9M18OOsyb6YINupmHzIyb2sE0rspVZfMKhrMRgQUSnjkh1+48pobcTUiQ6yFsPWAp/Aq/9YXCsfR8dfLeVzNRRaej9ZBgVed2ruPPztG7O4RASCCeyfDOtSJAeLJXCYYBFOUteWlwpW7e4j7CmkiS6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj3wTGeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AEFC32781;
	Wed, 10 Jul 2024 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720631810;
	bh=gbQbaUuiVBZ3rY0fazMfEsDsmp1EJvBByE9rwhcqv1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gj3wTGeGvkQA66hJtscYz2CdurW/XaWmXT1LUad7xHcQlV6bJlMPYB6BYkarkGJzM
	 qb1fJH/GWYe++EsAN1YPqxKxmTx70mi2pArTryxpc+tBbCuVT8RugoF5J51N45APGN
	 x+ezB+0+cMxlPHdLjUWzayfTJu8mxxY70OY7vRayQ0pqy+eEScxUw5lPNBlw9PM4pl
	 gHRJ2FF3NJhmef1/MM9944Z03bUSEMfjwNa8lSQVOBXi6SLTpzX79Nj4r2tZ5j+E5e
	 PNrecmTOcerZ2rr+jDaPAfXGPZUcWnJiE7MQ+AaJcdd8y8iMm1ukZWkjVH5FmwuAtd
	 4eGDODAKNmXiA==
Date: Wed, 10 Jul 2024 18:16:46 +0100
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
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 13/39] KVM: arm64: Manage GCS registers for guests
Message-ID: <Zo7B_sRyUyxv7xmO@finisterre.sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
 <20240625-arm64-gcs-v9-13-0f634469b8f0@kernel.org>
 <86v81d2s5t.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tsBiN+tG2JsDrdFj"
Content-Disposition: inline
In-Reply-To: <86v81d2s5t.wl-maz@kernel.org>
X-Cookie: Your love life will be... interesting.


--tsBiN+tG2JsDrdFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 04:17:02PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > +	if (ctxt_has_gcs(ctxt)) {

> Since this is conditioned on S1PIE, it should be only be evaluated
> when PIE is enabled in the guest.

So make ctxt_has_gcs() embed a check of ctxt_has_s1pie()?

> > +		ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
> > +		ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
> > +		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);

> Why is this part of the EL1 context? It clearly only matters to EL0
> execution, so it could be switched in load/put on nVHE as well. And
> actually, given that the whole thing is strictly for userspace, why do
> we switch *anything* eagerly at all?

GCS can also be used independently at EL1 (and EL2 for that matter),
it's not purely for userspace even though this series only implements
use in userspace.  GCSPR_EL1 and GCSCR_EL1 control the use of GCS at
EL1, not EL0, and the guest might be using GCS at EL1 even if the host
doesn't.

GCSCRE0_EL1 is for EL0 though, it ended up here mainly because it's an
_EL1 register and we are already context switching PIRE0_EL1 in the EL1
functions so it seemed consistent to follow the same approach for GCS.
The _el1 and _user save/restore functions are called from the same place
for both VHE and nVHE so the practical impact of the placement should be
minimal AFAICT.  Unlike PIRE0_EL1 GCSCRE0_EL1 only has an impact for
code runnning at EL0 so I can move it to the _user functions.

TBH I'm not following your comments about switching eagerly too here at
all, where would you expect to see the switching done?  You've said
something along these lines before which prompted me to send a patch to
only save the S1PIE registers if they'd been written to which you were
quite reasonably not happy with given the extra traps it would cause:

   https://lore.kernel.org/r/20240301-kvm-arm64-defer-regs-v1-1-401e3de92e97@kernel.org

but I'm at a loss as to how to make things less eager otherwise.

> > @@ -2306,7 +2323,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >  		   ID_AA64PFR0_EL1_GIC |
> >  		   ID_AA64PFR0_EL1_AdvSIMD |
> >  		   ID_AA64PFR0_EL1_FP), },
> > -	ID_SANITISED(ID_AA64PFR1_EL1),
> > +	ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_RES0 |
> > +				       ID_AA64PFR1_EL1_BT)),

> I don't know what you're trying to do here, but that's not right. If
> you want to make this register writable, here's the shopping list:

> https://lore.kernel.org/all/87ikxsi0v9.wl-maz@kernel.org/

Yes, trying to make things writable.  I do see we need to exclude more
bits there and I'm not clear why I excluded BTI, looks like I forgot to
add a TODO comment at some point and finish that off.  Sorry about that.

In the linked mail you say you want to see all fields explicitly
handled, could you be more direct about what such explicit handling
would look like?  I see a number of examples in the existing code like:

	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),

	ID_WRITABLE(ID_AA64ISAR0_EL1, ~ID_AA64ISAR0_EL1_RES0),
	ID_WRITABLE(ID_AA64ISAR1_EL1, ~(ID_AA64ISAR1_EL1_GPI |
					ID_AA64ISAR1_EL1_GPA |
					ID_AA64ISAR1_EL1_API |
					ID_AA64ISAR1_EL1_APA)),

which look to my eye very similar to the above, they do not visibliy
explictly enumerate every field in the registers and given that there's
a single mask specified it's not clear how that would look.  If
ID_WRITABLE() took separate read/write masks and combined them it'd be
more obvious but it's just not written that way.

--tsBiN+tG2JsDrdFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaOwf0ACgkQJNaLcl1U
h9BiTwgAhG9qd8c+aLOWRDYY+jgC3wxTF25VtO52AztM2Y4fyGfPMHg+GgALH/zW
kZPNqJcbu5fDOfkUg3obwE/dUqdlZDlbmmJBnaP1E9p3sXWuQ9sedlO17lyf3w8h
mzzFxLDCS0j01M5YNj4ql9LmC4sTOWyuzvzKDzDnLfM93Jdj6nhT4S0si+iQdBB8
PFhjdtH6qVUmQNG3ik40q/IPe+nA4u0mgs7XpKj8PuPtVDxe4SNhB8cZ8R+pEJBZ
f3EHvbndiotEBkFARu84AC/F3XfNhGNYlaZg/fwr2yfpfpFV/1Cz0LABhH9WojA0
z7VzLkWe/+pqYeMUNAJY6H+YDudaLA==
=InCr
-----END PGP SIGNATURE-----

--tsBiN+tG2JsDrdFj--

