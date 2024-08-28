Return-Path: <linux-fsdevel+bounces-27667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C7796357E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9883F1C224E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C0D1B012D;
	Wed, 28 Aug 2024 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dch4Alwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D601AE05F;
	Wed, 28 Aug 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887741; cv=none; b=nIOpDz6ZCRDNw7CfHi4az2ZCgVnTrn44iKc/Qz5AzaXVgGCo2cXBoUOiSJ+8uLvATFa+sP2wV1T1kEDSfbqvpd93GnULhv5zJNew/J6ecmR2itAvUyBWmGxLpyzwco6je+Z81ctVWlJPPyLr9hMtwVZeW+hddWz641sNVTWJ3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887741; c=relaxed/simple;
	bh=/QxGsZ7kGu5gcX/2Pir/IdpixOHnIz8YHhHUjvvkxmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WypS1YnlZnCMKpsklrajAvfnnnk0XCpT1YQMG36u2FAS5/WxnT3RXV3fm9zsWFjL6RSV9lAHXhugT7KMktumx2R8zAKd6W3D3moOA84+jdHUH6Nj9opipgBn0baoyitRCsKDXCYSftgPPON+Qk9aUyPggW3QHdh+jqsQis+n5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dch4Alwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C9CC4CEC8;
	Wed, 28 Aug 2024 23:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887741;
	bh=/QxGsZ7kGu5gcX/2Pir/IdpixOHnIz8YHhHUjvvkxmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dch4AlwnMww3ej5URFeoT7x7Lev1k7H8PfLuNI+LwoCFNneQnjJs9vb2zt1U2QD8/
	 5vK1WYnGpyFj4up78NnltxMwusYylMmyfidRDyUV+1KYcmZTcg+xubKzz9RZeb6TFv
	 bXoBF/l2tieBJefKx+VWOAEn+ZfXH1EfArtxYqcPtu0HzIDqpgPTL/R5NCzwQVoGWn
	 f4whxK1TPfVIsaZSn36OosZSHprlsnO109lDpcFTlt0o/Jgb4WZ5Nn/ZapHfXI1S8N
	 aZsgbTKsIvTNWrzeCuFTo/G23qMdKgHVaSOjB/ArekHEj1mdH+XWOl27UXr/fOGEAK
	 9PCdsbrpdwQWg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:20 +0100
Subject: [PATCH v12 04/39] mman: Add map_shadow_stack() flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-4-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/QxGsZ7kGu5gcX/2Pir/IdpixOHnIz8YHhHUjvvkxmA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7J7DhuYvgHPWvnQp5L8SSC8eApPBM4bB5f2073J
 OnOxkUWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yewAKCRAk1otyXVSH0CSnB/
 0UYRHqMOQvkJ6ZhOUS+LmaFsZNTO8rFSfgNqHMjXQFWl7ziyzoBWr1U1wbZMbFddsopgmWMSYcf0rw
 YwpLd9I2lcZqjq3FHDCWwh8SOg+fQ6fVjdfuHVlmu5z5JzU8YZZoyeA31dX2oZMuHbD+9aZO2LD20g
 kvsn+DNpCft1yj2u4nwLU3gIapk/kI/+xG+ekt4s2whveyu3aa6X0vaIVrlAdi8sS9zLDr2278O/9h
 PCnTnh+PHA9SCW3aSKj/vMsjPAqZ944hBvr2zYb4oDlIdWaiik3UBpDqqGozZoQkoqyzgi5IAL+nlX
 sY/TPmQVG7qwODzTybUjKTTE+3LaAk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for adding arm64 GCS support make the map_shadow_stack()
SHADOW_STACK_SET_TOKEN flag generic and add _SET_MARKER. The existing
flag indicates that a token usable for stack switch should be added to
the top of the newly mapped GCS region while the new flag indicates that
a top of stack marker suitable for use by unwinders should be added
above that.

For arm64 the top of stack marker is all bits 0.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/include/uapi/asm/mman.h | 3 ---
 include/uapi/asm-generic/mman.h  | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 46cdc941f958..ac1e6277212b 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -5,9 +5,6 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 #define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
-/* Flags for map_shadow_stack(2) */
-#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
-
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 57e8195d0b53..5e3d61ddbd8c 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -19,4 +19,8 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack marker in the shadow stack */
+
+
 #endif /* __ASM_GENERIC_MMAN_H */

-- 
2.39.2


