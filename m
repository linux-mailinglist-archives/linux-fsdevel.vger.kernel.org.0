Return-Path: <linux-fsdevel+bounces-41255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF632A2CD8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1841639BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E747F1A00D1;
	Fri,  7 Feb 2025 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYE9jc1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E5114D43D;
	Fri,  7 Feb 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958831; cv=none; b=PfM0SWUnPsXhb1okdQ2GjhmWmNhnCh2WAt7t900t8YkhUd98N3dmNaEKnadN9MRwREObFSC8BKrGB+ua2dN/2QXO/WNab6GX5hyuTyIQsPP16WZVOfvWORfAUPFifAPNh2H5Yr6SVMFfCuVP+P85ipHasaErHCq+8eyzJWVCNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958831; c=relaxed/simple;
	bh=hilhNBJhm7gyU2xWT0l3rVwkEdmqyKYqu1PEl6FCbO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yjn/qHOFMX35E5G6VPxum9bmODJuVdmCGndBDCNA4Uldm/zaEId+6JF0w2sJ+IYc4xHpJljVwvbzgpqfvZNHkq5C6xuhOtKKufUj7WpohTq6nNln/7jNTWdrtPSYx9jpvZMsBN0ak2Loh+wTMphUi+HDLlGMFYOtpYHT7goNzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYE9jc1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035DDC4CED1;
	Fri,  7 Feb 2025 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738958830;
	bh=hilhNBJhm7gyU2xWT0l3rVwkEdmqyKYqu1PEl6FCbO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYE9jc1EsEHG8d3Is5YHp0nx/UhYWYRFgkfUk39bIcEpCx5ZBQ9+xWQ4BirLtIuAv
	 8yZudPKcjgjJqOY0q3DgF68NLWd2vr84/vtOziN+Rr6/qcE9RFRqft8e3K/Kt5ETDv
	 ZQs3gVpLsq4xZICVk7Pa6tFH79Mk/f/eLo6B8Du2YyxXN2hkbOD2womNlBKm5fqyz+
	 DecDnRHIa4bOkiWCZxXnLzD24hXO3BUXY40Ev04J0n6Pg38N3kGnRa0Z369RIW/uux
	 L7v83uJabvw4b4S5BG2sxMdQLeT7UdvoXlEGml0u0lseOPAYLna4mKfHcsTp4tdN/T
	 muTG0T0MffppQ==
Date: Fri, 7 Feb 2025 20:06:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v9 01/26] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <5708c19d-240a-466a-b17a-d51b26ab95e6@sirena.org.uk>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-1-b37a49c5205c@rivosinc.com>
 <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dNozXZgwSNh15IF2"
Content-Disposition: inline
In-Reply-To: <6543c6b6-da86-4c10-9b8c-e5fe6f6f7da9@suse.cz>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!


--dNozXZgwSNh15IF2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2025 at 10:27:10AM +0100, Vlastimil Babka wrote:
> On 2/5/25 02:21, Deepak Gupta wrote:
> > VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack

> I see that arm GCS uses VM_HIGH_ARCH_6.

That'll be bitrot in the changelog, it was originally VM_HIGH_ARCH_5 on
arm64 as well but we had to renumber due to the addition of
VM_MTE_ALLOWED while the GCS series was on the list.  The changelog just
shouldn't mention VM_HIGH_ARCH_x, it's not particularly relevant here.

--dNozXZgwSNh15IF2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmemZ+IACgkQJNaLcl1U
h9DVuAf/dyasNesjmRVNnX4CSTWgbPesYoxwpqTQgKso+9joOZPYPyLvIggnLsC1
o+R1+QnbfVTDXvm+EDZnKplHkrzc7OMlSyqoO0Jhcvho9xR9wHpNaqRTQEMg4vCm
Zg5azVK9vR2hn74CXPkTi/0R39CY3f02oIwZqD8xp7OZ4hjW7cis7E1aXqnos5Xf
ojdS0hRnNNwrxRfdgK6u2APvcBJajWPE2C2I1ogm4eZO6n3ZI2RTSez88i8bShDg
9WGWK5ghGkwKB5tkeXRra2Vvbfs3Wu8RyAY8/X1LKU/8wE2Mrbbk5Cu8E9jbuqD6
Wx+CXrnjrV+x09CkTFzkFq+DBsO2Gg==
=DOc/
-----END PGP SIGNATURE-----

--dNozXZgwSNh15IF2--

