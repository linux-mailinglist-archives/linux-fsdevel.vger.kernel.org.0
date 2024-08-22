Return-Path: <linux-fsdevel+bounces-26622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63995A9DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33C71F22549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA6376F1;
	Thu, 22 Aug 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaYbf4co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5771311B6;
	Thu, 22 Aug 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289645; cv=none; b=KiMSuGGGJU4yig9hOh4zarZwNXI64Us9ymgt8JOUAfJB5lIrqgjEw6WynSXOE6Eyg3+HCEvMOJVZsGBwzPHkaG/gFG33h19knz1FoKyu0haZ9pcXmD31noRyTcDTQxPszhRZbpwtaLld6PBwjcdA6o1glj719Mn/UvK+mPoJrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289645; c=relaxed/simple;
	bh=kXO2GCPjz2S4M/TO1zkwKAs7nkqAlyHosyHP175ZITc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pghZwfs3WspCBKmNSi2j2RFJmdyhg8DgMRub5ibsnD5OLlpF6czyLNpvXEv5fxjDIE1HSMaPik4ULzLBgyi+SiJM+QhcfmyHPUWsnQpwWRSPq4VqU4wYCH2okxV1JiEd6N320eC10GloS4U3NeTGwAriP6G2DXs22wVncAdeJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaYbf4co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5837FC32781;
	Thu, 22 Aug 2024 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289644;
	bh=kXO2GCPjz2S4M/TO1zkwKAs7nkqAlyHosyHP175ZITc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NaYbf4coFOlLrG2dAibV7pBvMyx4JDv93vJ1RN5yZgKnTsT0LKjizxRQFsnLXc7ni
	 3c6Ka9YUXWQzYr7aYO41AkVGYgEFPS+NQLfFED+bGqnnWcPy704vjGLzr/l9kFfXrm
	 KbBBPl00BgaD3OunTXUjrXZYzhmCinTKWhJrinLoPlACm7cPMNUBKZ7APxHOuq1vTq
	 K9bz41XRDSzyQE0Y04SmBZiEmIMo6LQSseYY4rUAEhDxMVeB9Q6GZGUvPwqKUgR2Z0
	 wRVW+/BLnVdlG0MZrY17HLJoX7GrW4vjHQ9PX5g3FqZcmDN1b+3i/WgbAi+23MuJzY
	 0yC/Aj21Bh+YQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:26 +0100
Subject: [PATCH v11 23/39] arm64/mm: Implement map_shadow_stack()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-23-41b81947ecb5@kernel.org>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
In-Reply-To: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kXO2GCPjz2S4M/TO1zkwKAs7nkqAlyHosyHP175ZITc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpE1uApeg/OZxbiMhFHBoLLG5SrajXWXBeA40vR0
 FCpWfjaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRNQAKCRAk1otyXVSH0HXKB/
 0dMGFWwbkX4Z9sEwfB0dY/XOaKUlKCCMaPAx1bkgitG6AntCY2Kli+mJ2dVrlsJiiUuOtKpgm2upC/
 gAkHa6Qz6FCwyehhZGr3MKK51DmUkjlCYkZv42cAn0qdft6eCTceFbLwHpGhfbtmuoHLWsvBemKz7g
 bquAPwNz1oLJQtKSHYXnuCFVboTAJ45j7tCfsXIAEQvBKAcKyxt4CZ6uf3R0H1+X+B8Rj9VhKP30tb
 QvinvkgvrTuEsazsCcV6TDz6yGerenIMpfRa2ff/BSMxGJGaws6R1VIaoOepqTODXo2vjVoavLksF/
 dZQVmPYzpTvliSCTAB846/Xjk3IcAK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As discussed extensively in the changelog for the addition of this
syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
existing mmap() and madvise() syscalls do not map entirely well onto the
security requirements for guarded control stacks since they lead to
windows where memory is allocated but not yet protected or stacks which
are not properly and safely initialised. Instead a new syscall
map_shadow_stack() has been defined which allocates and initialises a
shadow stack page.

Implement this for arm64.  Two flags are provided, allowing applications
to request that the stack be initialised with a valid cap token at the
top of the stack and optionally also an end of stack marker above that.
We support requesting an end of stack marker alone but since this is a
NULL pointer it is indistinguishable from not initialising anything by
itself.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/gcs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 5eb746fdd872..d9614900c910 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -67,6 +67,70 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 	return addr;
 }
 
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	unsigned long alloc_size;
+	unsigned long __user *cap_ptr;
+	unsigned long cap_val;
+	int ret = 0;
+	int cap_offset;
+
+	if (!system_supports_gcs())
+		return -EOPNOTSUPP;
+
+	if (flags & ~(SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER))
+		return -EINVAL;
+
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	if (size == 8 || !IS_ALIGNED(size, 8))
+		return -EINVAL;
+
+	/*
+	 * An overflow would result in attempting to write the restore token
+	 * to the wrong location. Not catastrophic, but just return the right
+	 * error code and block it.
+	 */
+	alloc_size = PAGE_ALIGN(size);
+	if (alloc_size < size)
+		return -EOVERFLOW;
+
+	addr = alloc_gcs(addr, alloc_size);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	/*
+	 * Put a cap token at the end of the allocated region so it
+	 * can be switched to.
+	 */
+	if (flags & SHADOW_STACK_SET_TOKEN) {
+		/* Leave an extra empty frame as a top of stack marker? */
+		if (flags & SHADOW_STACK_SET_MARKER)
+			cap_offset = 2;
+		else
+			cap_offset = 1;
+
+		cap_ptr = (unsigned long __user *)(addr + size -
+						   (cap_offset * sizeof(unsigned long)));
+		cap_val = GCS_CAP(cap_ptr);
+
+		put_user_gcs(cap_val, cap_ptr, &ret);
+		if (ret != 0) {
+			vm_munmap(addr, size);
+			return -EFAULT;
+		}
+
+		/*
+		 * Ensure the new cap is ordered before standard
+		 * memory accesses to the same location.
+		 */
+		gcsb_dsync();
+	}
+
+	return addr;
+}
+
 /*
  * Apply the GCS mode configured for the specified task to the
  * hardware.

-- 
2.39.2


