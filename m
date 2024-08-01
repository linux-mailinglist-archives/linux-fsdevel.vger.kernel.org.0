Return-Path: <linux-fsdevel+bounces-24752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6D944BE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7191C2444D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB011A38E8;
	Thu,  1 Aug 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9EWh0gX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666C1A01B7;
	Thu,  1 Aug 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517061; cv=none; b=nSy4LkNfBWwFcbUztFzi4FrOI5fZT8Jt/QCKMUXwfYHTW0PmmdXMSEbGvRH2cFo0Ya58oIUO39UFDdxP03Xe4AhDxjEQ0y1O7pdfT5wfBez7hJ/cKSVaTAWrqaiGacrW4CysMuYhCebs9fgNeNkMh1dKohZXuEl1KSz6jLiloPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517061; c=relaxed/simple;
	bh=2jWl08+8re+Jbyu9WlYwMAOos2oJrw5SQjRGnUXuA4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BaElBmpYwA6UTwEPh7aIbnLhqVib2QoiqNoBSTHf9xMANy3bd+g6+ma099toLsy0DdOLvUHJ0y8GFIpQIkob6hprWr4GoDynpbTsvIe/I+TnEYXPLfmN9Cj4apN8HCyslpgijVszrhE1VRi0rNxCjffzhIPeCcOnqrn3B+zL1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9EWh0gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC12C32786;
	Thu,  1 Aug 2024 12:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517060;
	bh=2jWl08+8re+Jbyu9WlYwMAOos2oJrw5SQjRGnUXuA4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k9EWh0gXg6rjx7kV1lB1Gmt38FbXgl6/I7ewuvHjZKZKsi0Ra/eNEDb4+nkaWeebY
	 5fo+KHzl2gVZT5y4QEi94AFCr3yy8q0Y3qfsKo4MUU8ZvEpLuaXTE+gJP1/QJAFy6b
	 ZFESzXLHeTvuf0gbP+smJF5PdWb79uTbdLNbHoM7qIVEW52ay89XQq3Sh1JchzEOGn
	 vJeZOlSSSY5GbPB2qtoVLFB9VX16JELscHgpRYVwyYdxXfoIRQv+2ArLna84PZ0pA/
	 DxpPvqcJ3zRpN1CX47iKOu5nvE+8eTswjAlK6Uc34hqiDr+Esbw3xgOrUR21qH2t9A
	 3O+OwqSvPl7qg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:30 +0100
Subject: [PATCH v10 03/40] mman: Add map_shadow_stack() flags
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-3-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2jWl08+8re+Jbyu9WlYwMAOos2oJrw5SQjRGnUXuA4U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YID0+m+ZzdQpJGH0gtPDP+bAsXULUCyyq8/y2t
 MduEdEmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGCAAKCRAk1otyXVSH0Ot1B/
 4jaebyV1tIrvOIYxQh5wDbypCmbpdfYnw84eR5kyJZqQIRjZ+dK0lQJngqeHe4n89q7hMI4OUDMfSr
 Otel0Z609ebmO09EfOX6sKZzZ2/uru4+YnSoeGjvRZZsYsr1B+7FWG3o5mVY91e4Sdd+6ukU+qHmzS
 axuQgqxevf/x3L67X0UZGMdmC5B8jQ2x6Gu99RAzuYELIUE2nPQ1wCneKnvlyC+FPrLbjWdkIDKVN8
 wmGHe42BNZh62DU3scRZYxWf6RdwGbFcR9PlKRfpI7Ocuez5/KqBYFTD1YXpI3HGD35BhAYcpFTswG
 yKHazykP6dg1NzH0pTMC7LYphwlbfE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for adding arm64 GCS support make the map_shadow_stack()
SHADOW_STACK_SET_TOKEN flag generic and add _SET_MARKER. The existing
flag indicats that a token usable for stack switch should be added to
the top of the newly mapped GCS region while the new flag indicates that
a top of stack marker suitable for use by unwinders should be added
above that.

For arm64 the top of stack marker is all bits 0.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
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
index 57e8195d0b53..d6a282687af5 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -19,4 +19,8 @@
 #define MCL_FUTURE	2		/* lock all future mappings */
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack merker in the shadow stack */
+
+
 #endif /* __ASM_GENERIC_MMAN_H */

-- 
2.39.2


