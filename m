Return-Path: <linux-fsdevel+bounces-28279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ABA968E0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 20:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB2B1C222F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CAF19CC38;
	Mon,  2 Sep 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLS5G3t8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A51A3A81;
	Mon,  2 Sep 2024 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303519; cv=none; b=Q0pzfT+oViOWSnerFs3RN6ODNWMPwG3Dz5QWVooYtNklwjVEvtiSVqv0CQd3yiBRWXSzZ4IFIliJF6NW9DEYZSrC+UH4louhvMomcUrqaU0j0HwIEKXL6jAycs3THTCe9TiOy3YfUJTJTLoaP4FepOSvBdPplXH6G7kCZgHWNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303519; c=relaxed/simple;
	bh=ULrqyQWdlaDEvu7Vyso62JavGFrUpmdzyVL+0CBH7so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykg3v6PzyW9LYPh7i2WrC7yrzASV+WmJfGBuf4AKgXjgKUUMhoG/oXUfWUShdSrtmLZxc6VkwsdX8U2sr2JIwoO5cFA8KTFnN0f2FBsF97ywuvuL0YnTCgy2eV/589JZxkdbxIyKx25RFwGemz9NcvHOES62kNibhNjBaFrvloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLS5G3t8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A43C4CEC2;
	Mon,  2 Sep 2024 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725303518;
	bh=ULrqyQWdlaDEvu7Vyso62JavGFrUpmdzyVL+0CBH7so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLS5G3t85OMO13hHHnYkkx2VI1EzZofzNuR7RtwpFRSrkExvUuhqyjWfxTjBZdI19
	 wnPGiW23Vo5VNg1x6aaYhJcQpHDclMU+RpkGNZz3xmDPCBjpb/oPt1OwVS7P6p4fvB
	 oR1fwnov4vHwiSmclQ+X+GtNUmcl4MCutCC7QA8JkcRk5GSr3KHa3qC00P7pWS1twL
	 BDw8t90jYBbt3SDfjAoOSuYgtfwLJ5ITvwfAw9bSSbUmHRjIuu+NbmCa2KIhh6r6hf
	 Me1TGHipaVgQleQ+v9HWr/Q9yU8EScqC1IqrtxmsBkM7AHjXkuhu6tEd0cCYddddtP
	 HCpWDxyQcpX7A==
Date: Mon, 2 Sep 2024 19:58:28 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 26/39] arm64/ptrace: Expose GCS via ptrace and core
 files
Message-ID: <3f190f54-477e-48dd-8a57-8d61ea20413b@sirena.org.uk>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
 <20240829-arm64-gcs-v12-26-42fec947436a@kernel.org>
 <ZtYKYMWjApRxFO_-@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TKHSXDJ9uQiaLUmP"
Content-Disposition: inline
In-Reply-To: <ZtYKYMWjApRxFO_-@arm.com>
X-Cookie: You are fairminded, just and loving.


--TKHSXDJ9uQiaLUmP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 02, 2024 at 07:56:32PM +0100, Catalin Marinas wrote:
> On Thu, Aug 29, 2024 at 12:27:42AM +0100, Mark Brown wrote:

> > +static int gcs_get(struct task_struct *target,
> > +		   const struct user_regset *regset,
> > +		   struct membuf to)

> > +	if (target == current)
> > +		gcs_preserve_current_state();

> What's the use-case where target == current and do we need something
> similar for gcs_set()?

IIRC core file generation so no.

--TKHSXDJ9uQiaLUmP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbWCtQACgkQJNaLcl1U
h9A+eAf/U5iAiXuQK5f4MKYdawDbRNGb3EC6UsdEskrkjdlquMqu3jXyVPTU2Pj/
8tK8mveoLmqU29r6fnrYxLffDNp7k9VTr+r1fi3ezQosSJyMep+Dar2mmeRh/dz2
VcJsvymrKNdz3BE2FMGnAUNkJWGw/b4Lqio3XfjDexX0p/ZvD00cjvaZ/1wEJ1VV
uOKEhpylc8LgQrfLJO4dMFJncqo6GBePUhoqaEPG/0fgS0jJlrDhtUluuITVhwWt
rqzDcT1ryxvNqG1urOShrMnBTvsUsAOW0G1JDjI6nL8Y35Sx+nSHiYOZkVwpBhpR
oFa8/2ferdCftHGVLV3CQ0AXR9jn1Q==
=loiY
-----END PGP SIGNATURE-----

--TKHSXDJ9uQiaLUmP--

