Return-Path: <linux-fsdevel+bounces-31800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879399B240
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 10:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288E01F211FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 08:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488A614A084;
	Sat, 12 Oct 2024 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPIdILaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDD610D;
	Sat, 12 Oct 2024 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728722998; cv=none; b=EPPCOCC0PePGkax0A9LtbU/OC3WFPz11yFx7fT7I6433qblPgtpiG0Re4/seoIj2YNe3nf/KA9qQACwxcuwUGS+EltQRBmJVJ4j+rd89rWO2On4smDfNA2anBcB01HwNvm0p+e7rh97WQ5KCpalhZqMzL6MYnbUx9cl1KuWGAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728722998; c=relaxed/simple;
	bh=OOjwuSsXKcaVSQkqd4xe3YjH96WX/1YMJsInDhIMV20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR0hxQYqCSLq/dhK2JUXi+7swhG8g+W6mCaTOab5JywKPk2mixp4D9u3NT5QKW5/VK2h0Z4pQlVx8DOPW7OlLeuVIr/ci1IU9Rf7UFCvZwBTExQ+3jbGbLZ4LgRPNCgP/u+UO0Avo5sKurbaDYb0KOeK8c8uT6fiTUIjxWIyqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPIdILaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF9FC4CEC6;
	Sat, 12 Oct 2024 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728722998;
	bh=OOjwuSsXKcaVSQkqd4xe3YjH96WX/1YMJsInDhIMV20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPIdILaFDoFz1wtZKlCJkMwn9k8kqfb8KQmrE3F6bmZpTeM6VitmPm5YPC6XQ582O
	 BOEAoFqwvScxkQFM11+kaji12SQsG5J0ej5l7sXywv62HcHej4RY143kzNmVR9gOMf
	 DIkFfBbOfFyl+8ZTPMU0orC7Jr7rwTJkEWO9a+HxQD5uig9/XHm0XCDIvw1C83YrCw
	 KB5pFsJ0saTbeim1M1DtzBJmhBba7aZp9SkDBbAO8e1kO53+sbbLjb0Tzre+OLdB42
	 39Q0OMHvA7DcvAGr2U+QeH+18UXUlI17bI252XzyWiRhqFLAZtkWbVA8AJV6b6XAHp
	 m2Pc1HufRfj+Q==
Date: Sat, 12 Oct 2024 09:49:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH RFC/RFT 3/3] kernel: converge common shadow stack flow
 agnostic to arch
Message-ID: <Zwo4MtxBpmtXzSnx@finisterre.sirena.org.uk>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
 <20241010-shstk_converge-v1-3-631beca676e7@rivosinc.com>
 <ZwkbAauYGhtldtW6@finisterre.sirena.org.uk>
 <Zwla7gBxyPOK0yBC@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A9LOoEE0MvFaC/2H"
Content-Disposition: inline
In-Reply-To: <Zwla7gBxyPOK0yBC@debug.ba.rivosinc.com>
X-Cookie: Editing is a rewording activity.


--A9LOoEE0MvFaC/2H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 10:05:50AM -0700, Deepak Gupta wrote:
> On Fri, Oct 11, 2024 at 01:33:05PM +0100, Mark Brown wrote:
> > On Thu, Oct 10, 2024 at 05:32:05PM -0700, Deepak Gupta wrote:

> > > +unsigned long alloc_shstk(unsigned long addr, unsigned long size,
> > > +				 unsigned long token_offset, bool set_res_tok);
> > > +int shstk_setup(void);
> > > +int create_rstor_token(unsigned long ssp, unsigned long *token_addr);
> > > +bool cpu_supports_shadow_stack(void);

> > The cpu_ naming is confusing in an arm64 context, we use cpu_ for
> > functions that report if a feature is supported on the current CPU and
> > system_ for functions that report if a feature is enabled on the system.

> hmm...
> Curious. What's the difference between cpu and system?

Like I say above cpu_ is for the current CPU and system_ is for the
system as a whole.  On a big.LITTLE system it's common to have a mix of
implementations which don't have consistent feature sets.

> We can ditch both cpu and system and call it
> `user_shstk_supported()`. Again not a great name but all we are looking f=
or
> is whether user shadow stack is supported or not.

That avoids the confusion so works for me.

> > > +void set_thread_shstk_status(bool enable);
> >=20
> > It might be better if this took the flags that the prctl() takes?  It
> > feels like

> hmm we can do that. But I imagine it might get invoked from other flow as=
 well.

I'd expect that any other contexts would be either copying an existing
set of flags or disabling either of which should be managable.

> Although instead of `bool`, we can take `unsigned long` here. It would wo=
rk for now
> for `prctl` and future users get options to chisel around it.
> I'll do that.

Sounds good.

> > > +void set_thread_shstk_status(bool enable)
> > > +{
> > > +	arch_set_thread_shstk_status(enable);
> > > +}

> > arm64 can return an error here, we reject a bunch of conditions like 32
> > bit threads and locked enable status.

> Ok.
> You would like this error to be `bool` or an `int`?

An int seems safer (eg, differentiating not supported, invalid arguments
and permission failures).

> > > +	unsigned long addr, size;

> > > +	/* Already enabled */
> > > +	if (is_shstk_enabled(current))
> > > +		return 0;

> > > +	/* Also not supported for 32 bit */
> > > +	if (!cpu_supports_shadow_stack() ||
> > > +		(IS_ENABLED(CONFIG_X86_64) && in_ia32_syscall()))
> > > +		return -EOPNOTSUPP;

> > We probably need a thread_supports_shstk(),

> `is_shstk_enabled(current)` doesn't work?

No, we just checked that immediately above - this is checking we're not
trying to enable shadow stack on a 32 bit task so it's a per task
property separate to the task already being enabled.

--A9LOoEE0MvFaC/2H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcKOC4ACgkQJNaLcl1U
h9Aq1gf9FGtFo9pI8j1iQUKz51kY2q9c2SAfvTPuu1QBa/hHhmOY8K4YqSfptDUv
Xft/cmnd55SA9F97UrIMJoksLr1FozS9XcR0JADnsL3RHJp5TWAgycMpXanTpBud
SAXKvT4IoBQHy2hv+IxPauTvYezO37joqcesOmtD0afiEFmkLn1aD6G02pf2GPHV
NV14Tkav62eAZRsfh7W7HwzkZDDATiDeK60u+bruzqpDYUhfbMZt2gk+jiD2lPoZ
LHAA2MZNultkQHQmrrbvaIp5/BzKUcVncSoqOI0yVHBe7w3WLxuwK5if1rFsOmBQ
BgJxw0uQ6RNh99CVJ2Wmos3pQrKY2g==
=Vhxs
-----END PGP SIGNATURE-----

--A9LOoEE0MvFaC/2H--

