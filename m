Return-Path: <linux-fsdevel+bounces-31488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56349976E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386C228787C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF161E2853;
	Wed,  9 Oct 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwwzqOcs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EDD191473;
	Wed,  9 Oct 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506947; cv=none; b=AMQi7SVMrcf+KNrvZoW7l5ukbdxjexC0vmGBtlxp8JYGntGXKRU72l/Z8jn25s1pmexgsrNVWaA5pIMro0D9a588NFpcp+qY7S5e/v+73N2GYzy+EUkhyJfrKBepotRToo8ijBjOQYooDmLcdWDjvQ0DdrBzkAmAWpwt7QqpNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506947; c=relaxed/simple;
	bh=OFXVpQgisC9iUKGKv5IwiYtmzwJhlFDr4RbKRl3vukg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idFqj2QqDMAk3J1S6HW7Bk9lpvbnwKBbI6GA6QF0I+/ILjCYfNitnr/hhaojdBQ9o/uzaUlsIu+B9s3ZKfM1iRzILZHx0xy1mlkDoIgAg7iRjODqfGEBwScJodIEnQO1Zxl09lQg49QK84jjAY/pmu1OW4AN+YweG4cCLai0aJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwwzqOcs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265F0C4CEC3;
	Wed,  9 Oct 2024 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728506947;
	bh=OFXVpQgisC9iUKGKv5IwiYtmzwJhlFDr4RbKRl3vukg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwwzqOcsIgLrThOk8MIptc37fnC8WhDVG/Ifwy2LQsuL0Z4HqID9q3xo5GmNvlMWw
	 eNl92ym/ChcRd1xr8+UyxVIbPr10zOFe2v1P26pHi8j4KqfQyFTCtdCTtFkYDvoNCn
	 88RqmptFKK8mFSlpJ/NIdqjRbl+D0uHhq6eywBIxXm9OdZjAQYAt25M4X1nG2Vsv2K
	 iLRcywG3rMMJHxFwy+hAioNwJTf5J1HHiOHMA8h9kEwkXiiZg8fdreE92CqvaoCeOu
	 aIqJ9lyhQQPATY+NFOgQp6C5iagTBhJ3J8KAevnqDwaRN2s7JeRpB7lhsFX2JgZc0M
	 kTUhwSaWl5MMA==
Date: Wed, 9 Oct 2024 13:49:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 11/40] arm64/gcs: Provide basic EL2 setup to allow
 GCS usage at EL0 and EL1
Message-ID: <20241009204903.GA3353168@thelio-3990X>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
 <20241001-arm64-gcs-v13-11-222b78d87eee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-arm64-gcs-v13-11-222b78d87eee@kernel.org>

Hi Mark,

On Tue, Oct 01, 2024 at 11:58:50PM +0100, Mark Brown wrote:
> There is a control HCRX_EL2.GCSEn which must be set to allow GCS
> features to take effect at lower ELs and also fine grained traps for GCS
> usage at EL0 and EL1.  Configure all these to allow GCS usage by EL0 and
> EL1.
> 
> We also initialise GCSCR_EL1 and GCSCRE0_EL1 to ensure that we can
> execute function call instructions without faulting regardless of the
> state when the kernel is started.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

I just bisected a build failure from a failed linker script assertion
that I see with allmodconfig to this change in -next as commit
ff5181d8a2a8 ("arm64/gcs: Provide basic EL2 setup to allow GCS usage at
EL0 and EL1"):

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- mrproper allmodconfig vmlinux
  aarch64-linux-ld: HYP init code too big
  make[4]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
  ...

I see this with both GCC 14 and clang 19, in case toolchain version
matters. Bisect log included as well.

Cheers,
Nathan

# bad: [b6270c3bca987530eafc6a15f9d54ecd0033e0e3] Add linux-next specific files for 20241009
# good: [75b607fab38d149f232f01eae5e6392b394dd659] Merge tag 'sched_ext-for-6.12-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext
git bisect start 'b6270c3bca987530eafc6a15f9d54ecd0033e0e3' '75b607fab38d149f232f01eae5e6392b394dd659'
# bad: [76d36603db22f0f0774c19147b25f5a0bcac64e6] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad 76d36603db22f0f0774c19147b25f5a0bcac64e6
# bad: [e90a3e76b4b8080f633a167179f3a76b93077270] Merge branch 'renesas-clk' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
git bisect bad e90a3e76b4b8080f633a167179f3a76b93077270
# good: [dd60a5d8b8ac2e7dc6810182a6dbc251a746f09e] Merge branch 'perf-tools-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
git bisect good dd60a5d8b8ac2e7dc6810182a6dbc251a746f09e
# bad: [fa74fd4773673726bfa8f89d15805d8a1b26f855] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
git bisect bad fa74fd4773673726bfa8f89d15805d8a1b26f855
# bad: [a7833d5793f83512f1fb6f36fa7588ea03da6b1b] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
git bisect bad a7833d5793f83512f1fb6f36fa7588ea03da6b1b
# bad: [c9c0de66c9b5f295f09a116f15401465bdd13263] Merge branch 'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad c9c0de66c9b5f295f09a116f15401465bdd13263
# bad: [506496bcbb4204c9ff5cfe82b1b90e1f14366992] arm64/gcs: Ensure that new threads have a GCS
git bisect bad 506496bcbb4204c9ff5cfe82b1b90e1f14366992
# good: [d0aa2b4351862cc2ce8d97e00c96bffc02ea16af] arm64/gcs: Provide put_user_gcs()
git bisect good d0aa2b4351862cc2ce8d97e00c96bffc02ea16af
# bad: [6497b66ba6945f142902c7e8fce86e47016ead1c] arm64/mm: Map pages for guarded control stack
git bisect bad 6497b66ba6945f142902c7e8fce86e47016ead1c
# bad: [6487c963083c24ede289d4267ffa60a9db668cd4] arm64/cpufeature: Runtime detection of Guarded Control Stack (GCS)
git bisect bad 6487c963083c24ede289d4267ffa60a9db668cd4
# bad: [ff5181d8a2a82c982276a7e035896185c390e856] arm64/gcs: Provide basic EL2 setup to allow GCS usage at EL0 and EL1
git bisect bad ff5181d8a2a82c982276a7e035896185c390e856
# first bad commit: [ff5181d8a2a82c982276a7e035896185c390e856] arm64/gcs: Provide basic EL2 setup to allow GCS usage at EL0 and EL1

