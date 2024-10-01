Return-Path: <linux-fsdevel+bounces-30578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19498C89E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863DB1F2259D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561A1CFEC0;
	Tue,  1 Oct 2024 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9BEblIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFEC19AD89;
	Tue,  1 Oct 2024 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823654; cv=none; b=MmWcn+PP37zjRkqSlQQ2flkncLWMO4ioFOeOCqDVH/LXUiETHZZbg2b38mJ09CzkFH+yuQiAl3wsldgL4JRYceygBojdNYz/KE1n58gCL4fvIU17QGmpmsjIrNM97E1nSqYR4ZUsiMinwqUjOBAuZ+YSy1D+zdKI7DIaIWafYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823654; c=relaxed/simple;
	bh=vL+b/h3WOPYO7SwFl92JA9c0VbV77YwkdcIPJjlNFTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANbPldvrG5bbpLFI9vwZZ1hQZiKIyiC79x38vo7LORZyXFeQDq4CC+x6pfIaR6DDQRRdQFGS2ew+wb5C6zyht2b43krNARmR7NPfwz7P8jVuTE24GtTEShfY3PWdbaCwiPmCM0Y/Z6/Cl3ZtepadDs4v5u6cU4dIWpFDVYrPV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9BEblIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BCEC4CECD;
	Tue,  1 Oct 2024 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823653;
	bh=vL+b/h3WOPYO7SwFl92JA9c0VbV77YwkdcIPJjlNFTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q9BEblIa6MmA5Xaow7wFPzfAM9zttSOUnO+EtJzN/PX7Huf9lzr++3lNcVEnhbBqz
	 6dMkhlxPMElbdJeNlV158SBKPlOnHk5LQmhwlqFXihJgYSoqGxl3GLqUDM7DzAG5zc
	 lvLDejujVe26CNwqEFjY9RC9WxGXrSNkF5G9RyuOCrURHXGYY7+8AA1BJ1SMrCIjZt
	 BJvDkqRMfZF1cudVdwGq4CDhB5w9OLNa4NOrghTmOJJzwygsOzNNOFDRDlXzt7kKtH
	 IpBNBwRkNrS1h0eaDjRqb0/mVRIcjwZiyqBZn+jatUlWQ0I77tCcOgDFflvH0cvLXI
	 3XrtVqCX11mdg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:58:44 +0100
Subject: [PATCH v13 05/40] mman: Add map_shadow_stack() flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-5-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1935; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vL+b/h3WOPYO7SwFl92JA9c0VbV77YwkdcIPJjlNFTs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7Ig3nICM+W9H3bCT71LrQPx0TmwN2XrzWIKusU
 qfRtVgmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+yAAKCRAk1otyXVSH0EIMB/
 9VAnLOcjD+99k7ouK69WkUZZje02S2hR6fRnCSftnhm+4bz+XAyRnRMAjPkiv0ecgHaTuBtP+MmN6L
 M1BTqr15gkX62ORCMeKqgMig0l5Zm08WyrOD4f/Vf4Zb4phDfeQkEhHthQYNAOzPiw9zjQIJGaypMM
 PJHFuO2ykfazrzqINBCj0D1SCeQt3+5cESSO4XqcDnyaOrpnKPqwWdoWVkNzB98GHx999EQw2iWsOp
 pEi9Zg8ZJFAhJSTayVv1NDY9QzD6ngW3nJCCx7rD/3cbiZd2/Whg25ERj0YbAqlldQVHJfqrX3RCBL
 guH+PVB5PQbczVYykW+F+llt/dznd7
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
Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
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


