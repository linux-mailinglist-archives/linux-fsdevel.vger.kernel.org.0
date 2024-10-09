Return-Path: <linux-fsdevel+bounces-31433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69F59967F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 13:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B3628A69F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3652B1917CD;
	Wed,  9 Oct 2024 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLepzEsh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F861C68F;
	Wed,  9 Oct 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471816; cv=none; b=fWDXJo471xbLcPfbgFzhiJZ4GrGwGHgbl5Mfatl5V7pQsPm6X4t7IFCk7z/hrkBZfoU2hEjTTtpdduvh4IvjLoMXlg/MEIQCJniZzNId4JMCRVEY3VkuZZ3I8qmws3xaSWhRxPKlwiub5m80NDqsla0GL2nppjoCLzwEP8KtvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471816; c=relaxed/simple;
	bh=f/EoNW04y2Nr6yAWUDCYj/76s4oDbPK3TY0FW8YOVV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsDGa01oEtVOzFVkqh7mKe4WIBmZviuOz5pE5p2gVmYAykxjo87sU/cSfmt/0kHtI/QGcl/uYBxhnaixUzBVHl80f2eFUv110gnJKp8gRyGk3KOWOlMhQBKtkvhCRG69VvYls1RQ+xU6enDeOPzqW+5IhBPVsWu0e9xlPYN/W7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLepzEsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F023C4CEC5;
	Wed,  9 Oct 2024 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728471816;
	bh=f/EoNW04y2Nr6yAWUDCYj/76s4oDbPK3TY0FW8YOVV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLepzEshP/4mXQsl2XJpjT73NbBGz9G2agwEEd6tQYz9lO+eqYxMzaMcj24H4GW81
	 Le1KkXnjJBC8MW7FflTwf5k8u62yR275mQzbLM2Xnkksng7BBXCCu3I2IsilKKuh9C
	 tn5I9gMoOPl9IR/07Z7LrDEOfMozP8crg0Ejm1/cMpecXWaC7fqbOpYoml4pkqT6KZ
	 8ErbCjP7yR0hITlFP8nBM9WRgd/ZKkYKCpiRE0HjmkZfh/VszZtHEOhp3fV+YeRcul
	 Wbp42jCJn48Au8WODEcR3T6WeTkaJD6W4x+KhVfOQYXHADlrjbnU7K+GGkOQQF13Wm
	 yEtogMwRguJXA==
Date: Wed, 9 Oct 2024 12:03:32 +0100
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
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v6 18/33] prctl: arch-agnostic prctl for indirect branch
 tracking
Message-ID: <ZwZjBO_7d2-Qq8bF@finisterre.sirena.org.uk>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-18-60d9fe073f37@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FXfO/TwhQ+C7Uak4"
Content-Disposition: inline
In-Reply-To: <20241008-v5_user_cfi_series-v6-18-60d9fe073f37@rivosinc.com>
X-Cookie: Editing is a rewording activity.


--FXfO/TwhQ+C7Uak4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 03:37:00PM -0700, Deepak Gupta wrote:
> Three architectures (x86, aarch64, riscv) have support for indirect branch
> tracking feature in a very similar fashion. On a very high level, indirect
> branch tracking is a CPU feature where CPU tracks branches which uses
> memory operand to perform control transfer in program. As part of this
> tracking on indirect branches, CPU goes in a state where it expects a
> landing pad instr on target and if not found then CPU raises some fault
> (architecture dependent)

Reviewed-by: Mark Brown <broonie@kernel.org>

--FXfO/TwhQ+C7Uak4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGYwQACgkQJNaLcl1U
h9AHsQf9H04XFe+wNJxLZrv59pAwdvHe6MP+LVVOFndbjBmbHFTN6qmAISZyqktF
SRfj1/m4yG/TwuwLWuBmwzNCYhtdu6T7NxMLpAffd830l1MTkdrF7wQ9gl7ZGRAW
hwjTCOjqQG+RiCf8msgkCaHpmTaxQyaaXKijwQLlpjse8yXFagVbB7KFfLnU3SdH
EU1KXwsGKBILqKMesYtkE6OZOORH7YEXvvPcvZD2E/I/6ZVodlxghrEiw+L2z358
AVd82hg9g4z+W4RfgoHAuzE0DM7w1omjJCy8JvknSzesQFWBmnyDm/chs8uVbfBH
GWu/B4b4XqB14HIbfiwUtTrT1OMnCw==
=cHVw
-----END PGP SIGNATURE-----

--FXfO/TwhQ+C7Uak4--

