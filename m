Return-Path: <linux-fsdevel+bounces-10155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FFF8485B0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0007B232AE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D3605DB;
	Sat,  3 Feb 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF7nqRrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C52663519;
	Sat,  3 Feb 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963448; cv=none; b=tI+K4rnUPPX2flGRybDpUC0h3ghk6qpDwvc6xrKfMxHm6q98gDj+ExsIV7sCrS42MHL91IQ4vipouzsvihCqTFGFeLI++0PtT7cLu+C3ILhBXdvAju2vZWRHYeP0e95fjJywQ6nOKH51TwttX5TgJA3s1JkVZFlH1vU+flFu3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963448; c=relaxed/simple;
	bh=+xprcrSIR+r2HgpXmJPi2lCD7uV8JeEsPkL8Hbk9EMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6gKRAMsCPGwVTZ/EV9KDrE3PETMH0buObkiDDUY1yrSr7idRuFyV4LYabfipHSKTBdsiaWaKvbR+NsltYbMFPqnRbcpuBK8Lavu9VYV8+nPi3MCDrI1TtBAmDwc8YRWCns8JhHnxN5tv5o+lVHy2CUn+EHgBF/wS+sbLCHDbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF7nqRrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C475C43390;
	Sat,  3 Feb 2024 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963448;
	bh=+xprcrSIR+r2HgpXmJPi2lCD7uV8JeEsPkL8Hbk9EMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pF7nqRrZUhMqdiSGGPRZ4lQFV9LAa39nD4GPEx2pS4SHjfN3SyIUFZR2Ncyf50pbK
	 gcUitWiq8R081mUDfpLYs8f83JqvKeJhtIYHomgIenfRIpeZGr7t37qfR5e7P242C0
	 yAjJTLv8+DHI2+tBewBy5RlcRObbJsIrkJboK8hy1jh+m5+qlZIdQ01Rx7JyO7FzxB
	 UpP7vAxry8k/EdaVxXUk987ecA9dYoJUu0tj+eqXMr6gkgokd72MQj+oCkT4ExaRqf
	 2j3DD+Oti0+xH7uSt2T4aXnMyCPvtZRwVl+4ynyOwbpwYTQxarJNo6RxomoQcVoFC1
	 Cd//sQHU5hr8A==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:36 +0000
Subject: [PATCH v8 10/38] arm64/mm: Allocate PIE slots for EL0 guarded
 control stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-10-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2936; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+xprcrSIR+r2HgpXmJPi2lCD7uV8JeEsPkL8Hbk9EMs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDY6r7GyBRKw7wUgsZ+3nfEbNbAsesepgDtEw2w
 f6AWxyWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w2AAKCRAk1otyXVSH0KszCA
 CFSKuiESPpOpCspjr7eC4F35RG5kiLJP0HvJZjycPYcFxtl9dvbsnp0qpk9kwV3sdW0jN2LHxK77XV
 +PCEGj/fKNBU75dICtXgs2uLlQW8DBTzCDw5TAQzsQIDZwbATaaXD6dwqA2jFnExw/StImkNDeij0B
 ZRWxF2yKfgGJ1MmZzmUJi94IQSLO3DGmVwXC4q3LN/vT/aVbx9GjC+2f5aNBkpaJgkSsZhpp3nT0Uy
 qr6/+LduI3OPyrsVtXMpp0GLZ8qhasqr5QNlNBn1LeEEPVIiUmbbNx2PEogj2m82LLNAD5aw0zqR/N
 Relyii0MDbUbCWfD6Vk60iGQtQM3Vi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Pages used for guarded control stacks need to be described to the hardware
using the Permission Indirection Extension, GCS is not supported without
PIE. In order to support copy on write for guarded stacks we allocate two
values, one for active GCSs and one for GCS pages marked as read only prior
to copy.

Since the actual effect is defined using PIE the specific bit pattern used
does not matter to the hardware but we choose two values which differ only
in PTE_WRITE in order to help share code with non-PIE cases.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/pgtable-prot.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 483dbfa39c4c..14a33e0bece3 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -129,15 +129,23 @@ extern bool arm64_use_ng_mappings;
 /* 6:                                PTE_PXN | PTE_WRITE            */
 /* 7: PAGE_SHARED_EXEC               PTE_PXN | PTE_WRITE | PTE_USER */
 /* 8: PAGE_KERNEL_ROX      PTE_UXN                                  */
-/* 9:                      PTE_UXN |                       PTE_USER */
+/* 9: PAGE_GCS_RO          PTE_UXN |                       PTE_USER */
 /* a: PAGE_KERNEL_EXEC     PTE_UXN |           PTE_WRITE            */
-/* b:                      PTE_UXN |           PTE_WRITE | PTE_USER */
+/* b: PAGE_GCS             PTE_UXN |           PTE_WRITE | PTE_USER */
 /* c: PAGE_KERNEL_RO       PTE_UXN | PTE_PXN                        */
 /* d: PAGE_READONLY        PTE_UXN | PTE_PXN |             PTE_USER */
 /* e: PAGE_KERNEL          PTE_UXN | PTE_PXN | PTE_WRITE            */
 /* f: PAGE_SHARED          PTE_UXN | PTE_PXN | PTE_WRITE | PTE_USER */
 
+#define _PAGE_GCS	(_PAGE_DEFAULT | PTE_NG | PTE_UXN | PTE_WRITE | PTE_USER)
+#define _PAGE_GCS_RO	(_PAGE_DEFAULT | PTE_NG | PTE_UXN | PTE_USER)
+
+#define PAGE_GCS	__pgprot(_PAGE_GCS)
+#define PAGE_GCS_RO	__pgprot(_PAGE_GCS_RO)
+
 #define PIE_E0	( \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_GCS)  | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_R)   | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX)  | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX) | \
@@ -145,6 +153,8 @@ extern bool arm64_use_ng_mappings;
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW))
 
 #define PIE_E1	( \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_NONE_O) | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_NONE_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_R)      | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW)     | \

-- 
2.30.2


