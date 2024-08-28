Return-Path: <linux-fsdevel+bounces-27675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB89635A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DEAB24080
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DEC1B3735;
	Wed, 28 Aug 2024 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuchLGfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AF01AE04A;
	Wed, 28 Aug 2024 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887798; cv=none; b=UJSQOUG4DQjhVlB3Tx5XPx4fw70FecDT4URrbGC3CmNw7YOecMfZ3juKnuy2AWMvyZ2E0mWbCNgy7s/tHKeGvJ1As2yMrX/EdrMOFerf4AY4kYpYGcVS9d+oHsQoxp3N75/UpGR5Et0OJI689P14ymAJQ1d0X7m2JKSFm1zMOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887798; c=relaxed/simple;
	bh=HBIymMJlJf7+ITwOhb+j59rN4WPQGeznsoeJKujezak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jOhGEt/7tQpOacXr/zx7qmO+kWS7qyQkBrUog1shcsBUTneOjau0XYcZHXrih3DWyWIiHG1DCgUUQIT6SevtBalx9wJ/UnqLc4YoNZlMABl8zvYTC8ue0PesRsuKICTi1NDAqzRojihgfTA7E22lk+nmJxLGE6XbpMCrN7VO6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuchLGfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4708C4CEC4;
	Wed, 28 Aug 2024 23:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887798;
	bh=HBIymMJlJf7+ITwOhb+j59rN4WPQGeznsoeJKujezak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XuchLGfpg5OGC29+xUs4tplER41FbxWeXpPKVwAao9yigT9A0vzLu7atvegblnWF+
	 l9n0lbSiCOwQOVqWPFmMwZ1ekCxohBLhxIZlTDfvhlHMYoLVZI08jkKtMiKzUjmCyJ
	 HXaPWb7Ph7Xw++l04ZvMGyciJbqPUY2k+kTF27pDfK8ghBeiw7eTIvye3AUkkz1u78
	 6n0WaZY6WuAU6cMUUkD6py5x0AXdt7mK/+Q5nxwlcrX9FL1hWh3+RdOSLrmFC/Z+iA
	 VwV99HdP/CYpHb+hNifkAqUX+HWxIPzuli175SpswLow1sDMGQsJ6xewd1Eilts376
	 aMj66DaER4Yng==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:28 +0100
Subject: [PATCH v12 12/39] arm64/mm: Allocate PIE slots for EL0 guarded
 control stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-12-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HBIymMJlJf7+ITwOhb+j59rN4WPQGeznsoeJKujezak=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KBw7IkueYw48dG/sRyNikrfDrnQy9nMXT3KbWR
 xXEWMBqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+ygQAKCRAk1otyXVSH0CGzB/
 9FpI/8Nvj4l3e3y0PhdlgWD6cJmpnUTWZm24RKsU3fbtVsmMEvF3ODMODz0uFDiL1/lUe63cWHGkvx
 Hayy3os5dp5kOAHOGPUEn/4XN2M79ssNHm7FbaM6+IVxsHoWOQm6JNyQi2nae5oZkjwAdhs/mJ4JvI
 1cVV/RtvTwu7irvFTTH7T2lXgJsyo5nQ9CkkSoetnG0WX5MeiT5WseOUdX/Nw71e5CWMAt3FZ3WVpw
 kULf7K2sNZigyVBgAFwDqXzzJF4vlIWRJTVbnBJ2yT0BSWPHSX1nKyIQ0rCEvUO4Nycaw8vzShgwMY
 eBO4adf8kEYYhFUkeNbsu+9vEwVFE3
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

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/pgtable-prot.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index b11cfb9fdd37..545d54c88520 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -144,15 +144,23 @@ static inline bool __pure lpa2_is_enabled(void)
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
@@ -160,6 +168,8 @@ static inline bool __pure lpa2_is_enabled(void)
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW))
 
 #define PIE_E1	( \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_NONE_O) | \
+	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_NONE_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_NONE_O) | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_R)      | \
 	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RW)     | \

-- 
2.39.2


