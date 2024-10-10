Return-Path: <linux-fsdevel+bounces-31596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB8998B38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF911C20E05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C475C1CC16A;
	Thu, 10 Oct 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJJWVitm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAE1CBEB4;
	Thu, 10 Oct 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573500; cv=none; b=dL9sUzoGJDvfjmOwHBBte6bHZ1RJYkxcIfhH1gYUMpkSznuYd2RIOqo7FutAVllcnm0u3ymIsgblAsBUaTltmwulxukUckDIHG+GbbpcXvUWellETCyzG/QI33KiQmmaWg2cEpgArvJo83rIkSYfp2rBaFphgqEHHfJVMtycQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573500; c=relaxed/simple;
	bh=6dvKTY2cy/sodJ8sieN7BO/TIIO+P82VgqdOgk5UcTA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7ggdgHGKuJAsAZgdMRHhpBQZA9bbNX3EB6HfypLuzJxpXMM5BtZmHGw0KIUzclVxuU6GsMk2qVgnrKLpiZIpRHRHLHp3BAlBvqIqkTwSw+b4lfCAl2GDJ7cqjWYp5ShzXCdNSjqehX88jkeZ/0QTS2v7Qeoggjo7MIPfMMRwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJJWVitm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D004C4CEC5;
	Thu, 10 Oct 2024 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728573497;
	bh=6dvKTY2cy/sodJ8sieN7BO/TIIO+P82VgqdOgk5UcTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JJJWVitmpvLvarMUPZUkuoB8gP29XOw0sXNcXNa5kByyDAx7zTpXCXE3HAPvwucIc
	 nqKSjxxqVqe/grf/6yTnmqZ60aylmorsMhYnLl/p7veN8L+6Z6UpBle4GJuML4f7xb
	 i4kReeFAE20WpHLaj8KfSAKT2u3eSPxMo5z1CNQJcQfr/ga40kbvqrkDBDHrIhHoXF
	 Fx9jWKSkz74XO4oqeZAS85rWP/9HC/v2M1aUJUQw6PW1C+qyBOnY/aeVO+soSpZuga
	 63WABLS/bqHPf7/DMKi/vZmUVhEJ5IYzs9ZH3gGYScj5D1kIistrSeFfZCohaujqqN
	 f91Lx8662bKcA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1syuve-002Eqs-J7;
	Thu, 10 Oct 2024 16:18:14 +0100
Date: Thu, 10 Oct 2024 16:18:13 +0100
Message-ID: <86msjc56mi.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	Kees Cook <kees@kernel.org>,
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
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 11/40] arm64/gcs: Provide basic EL2 setup to allow GCS usage at EL0 and EL1
In-Reply-To: <20241009204903.GA3353168@thelio-3990X>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
	<20241001-arm64-gcs-v13-11-222b78d87eee@kernel.org>
	<20241009204903.GA3353168@thelio-3990X>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: nathan@kernel.org, broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, kees@kernel.org, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, ross.burton@arm.com, david.spickett@arm.com, yury.khrustalev@arm.com, wilco.dijkstra@arm.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 09 Oct 2024 21:49:03 +0100,
Nathan Chancellor <nathan@kernel.org> wrote:
>=20
> Hi Mark,
>=20
> On Tue, Oct 01, 2024 at 11:58:50PM +0100, Mark Brown wrote:
> > There is a control HCRX_EL2.GCSEn which must be set to allow GCS
> > features to take effect at lower ELs and also fine grained traps for GCS
> > usage at EL0 and EL1.  Configure all these to allow GCS usage by EL0 and
> > EL1.
> >=20
> > We also initialise GCSCR_EL1 and GCSCRE0_EL1 to ensure that we can
> > execute function call instructions without faulting regardless of the
> > state when the kernel is started.
> >=20
> > Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
>=20
> I just bisected a build failure from a failed linker script assertion
> that I see with allmodconfig to this change in -next as commit
> ff5181d8a2a8 ("arm64/gcs: Provide basic EL2 setup to allow GCS usage at
> EL0 and EL1"):
>=20
>   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux- mrpro=
per allmodconfig vmlinux
>   aarch64-linux-ld: HYP init code too big
>   make[4]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
>   ...
>=20
> I see this with both GCC 14 and clang 19, in case toolchain version
> matters. Bisect log included as well.

Grmbl... 16 bytes too big. The hack below buys us about ~600 bytes by
removing some duplication, but we're losing half of the space to the
vectors.

Anyway, this is very lightly tested and it may eat your box.

Thanks,

	M.

=46rom 20c98d2647c11db1e40768f92c5998ff5d764a3a Mon Sep 17 00:00:00 2001
From: Marc Zyngier <maz@kernel.org>
Date: Thu, 10 Oct 2024 16:13:26 +0100
Subject: [PATCH] KVM: arm64: Shave a few bytes from the EL2 idmap code

Our idmap is becoming too big, to the point where it doesn't fit in
a 4kB page anymore.

There are some low-hanging fruits though, such as the el2_init_state
horror that is expanded 3 times in the kernel. Let's at least limit
ourselves to two copies, which makes the kernel link again.

At some point, we'll have to have a better way of doing this.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20241009204903.GA3353168@thelio-3990X
---
 arch/arm64/include/asm/kvm_asm.h   |  1 +
 arch/arm64/kernel/asm-offsets.c    |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 52 +++++++++++++++++-------------
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_=
asm.h
index b36a3b6cc0116..67afac659231e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -178,6 +178,7 @@ struct kvm_nvhe_init_params {
 	unsigned long hcr_el2;
 	unsigned long vttbr;
 	unsigned long vtcr;
+	unsigned long tmp;
 };
=20
 /*
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offset=
s.c
index 27de1dddb0abe..b21dd24b8efc3 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -146,6 +146,7 @@ int main(void)
   DEFINE(NVHE_INIT_HCR_EL2,	offsetof(struct kvm_nvhe_init_params, hcr_el2)=
);
   DEFINE(NVHE_INIT_VTTBR,	offsetof(struct kvm_nvhe_init_params, vttbr));
   DEFINE(NVHE_INIT_VTCR,	offsetof(struct kvm_nvhe_init_params, vtcr));
+  DEFINE(NVHE_INIT_TMP,		offsetof(struct kvm_nvhe_init_params, tmp));
 #endif
 #ifdef CONFIG_CPU_PM
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/h=
yp-init.S
index 401af1835be6b..fc18662260676 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -24,28 +24,25 @@
 	.align	11
=20
 SYM_CODE_START(__kvm_hyp_init)
-	ventry	__invalid		// Synchronous EL2t
-	ventry	__invalid		// IRQ EL2t
-	ventry	__invalid		// FIQ EL2t
-	ventry	__invalid		// Error EL2t
+	ventry	.			// Synchronous EL2t
+	ventry	.			// IRQ EL2t
+	ventry	.			// FIQ EL2t
+	ventry	.			// Error EL2t
=20
-	ventry	__invalid		// Synchronous EL2h
-	ventry	__invalid		// IRQ EL2h
-	ventry	__invalid		// FIQ EL2h
-	ventry	__invalid		// Error EL2h
+	ventry	.			// Synchronous EL2h
+	ventry	.			// IRQ EL2h
+	ventry	.			// FIQ EL2h
+	ventry	.			// Error EL2h
=20
 	ventry	__do_hyp_init		// Synchronous 64-bit EL1
-	ventry	__invalid		// IRQ 64-bit EL1
-	ventry	__invalid		// FIQ 64-bit EL1
-	ventry	__invalid		// Error 64-bit EL1
+	ventry	.			// IRQ 64-bit EL1
+	ventry	.			// FIQ 64-bit EL1
+	ventry	.			// Error 64-bit EL1
=20
-	ventry	__invalid		// Synchronous 32-bit EL1
-	ventry	__invalid		// IRQ 32-bit EL1
-	ventry	__invalid		// FIQ 32-bit EL1
-	ventry	__invalid		// Error 32-bit EL1
-
-__invalid:
-	b	.
+	ventry	.			// Synchronous 32-bit EL1
+	ventry	.			// IRQ 32-bit EL1
+	ventry	.			// FIQ 32-bit EL1
+	ventry	.			// Error 32-bit EL1
=20
 	/*
 	 * Only uses x0..x3 so as to not clobber callee-saved SMCCC registers.
@@ -76,6 +73,13 @@ __do_hyp_init:
 	eret
 SYM_CODE_END(__kvm_hyp_init)
=20
+SYM_CODE_START_LOCAL(__kvm_init_el2_state)
+	/* Initialize EL2 CPU state to sane values. */
+	init_el2_state				// Clobbers x0..x2
+	finalise_el2_state
+	ret
+SYM_CODE_END(__kvm_init_el2_state)
+
 /*
  * Initialize the hypervisor in EL2.
  *
@@ -102,9 +106,12 @@ SYM_CODE_START_LOCAL(___kvm_hyp_init)
 	// TPIDR_EL2 is used to preserve x0 across the macro maze...
 	isb
 	msr	tpidr_el2, x0
-	init_el2_state
-	finalise_el2_state
+	str	lr, [x0, #NVHE_INIT_TMP]
+
+	bl	__kvm_init_el2_state
+
 	mrs	x0, tpidr_el2
+	ldr	lr, [x0, #NVHE_INIT_TMP]
=20
 1:
 	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
@@ -199,9 +206,8 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
=20
 2:	msr	SPsel, #1			// We want to use SP_EL{1,2}
=20
-	/* Initialize EL2 CPU state to sane values. */
-	init_el2_state				// Clobbers x0..x2
-	finalise_el2_state
+	bl	__kvm_init_el2_state
+
 	__init_el2_nvhe_prepare_eret
=20
 	/* Enable MMU, set vectors and stack. */
--=20
2.39.2

--=20
Without deviation from the norm, progress is not possible.

