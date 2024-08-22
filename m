Return-Path: <linux-fsdevel+bounces-26637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56A95AA2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6651C22D6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535F170A18;
	Thu, 22 Aug 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9zzjzMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5720211712;
	Thu, 22 Aug 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289831; cv=none; b=rta2EKHvqiUBqHDM+Qftej+wCEnolZHg/xjApVP4dcydULxuE/RcYD+7tLJLH5pz18vpk4NNmTUhCieTav6ZF3B7mq/s+ySWl7vMzKk0CWKWaIJ5wxRRtxuhtp7Wr8eZr1kMqt0xEePCGF8q4iKpzYdqutUquUiFteQiALcj3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289831; c=relaxed/simple;
	bh=YYz6vJzvFivBjzQl/oYVfPbzMadH/24Qr7CyuKANnYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exEhhupk0AX7GKuHzyUNkb2P4mrb2PHL2Awbri9+TZwFR8Y/yL6c0DExMnLgAYIPsr0EQmfjohTWdC7l82kFCXGdlPHh325Sb8Op8DW4eOIJmeT0F0hOs1rBY1WxEFe5Opvg4Pe7kVGWethNPhr5LUzpsnSsl0AOKpvc/wqzOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9zzjzMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599F6C4AF11;
	Thu, 22 Aug 2024 01:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289830;
	bh=YYz6vJzvFivBjzQl/oYVfPbzMadH/24Qr7CyuKANnYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R9zzjzMV70LpzGfyvhuJYpabIKzUcvQf9MHXQHntpuj1/nRe8ImXDZhtco4U+GIWD
	 H/L1Qr3+s6la2xkwMiwv798l3hafjyZcYnb5FNpK192mgBXdYzu+Bz8JO+OMCH0tl0
	 71TA36KOD9qaSkQfQoJhVnSvi5LbUD0bV8A8LPKdlGPGXVs18IJe6gCLyZ7N9g0SOe
	 EFr4BQDg2i2AW1eBJ2U1sOPB0uc5gGjI9YFKmUdRUTppOPzjjYeyns0b5abb8cLyWy
	 YIgowAAhiLYAlPnSvCEV/7XHRUHMT9JceVGBH/s3O9yv9jhRwLAHZX5xJ7XjUNeJGF
	 5LICH7Hd2wa/g==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:41 +0100
Subject: [PATCH v11 38/39] kselftest/arm64: Enable GCS for the FP stress
 tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-38-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YYz6vJzvFivBjzQl/oYVfPbzMadH/24Qr7CyuKANnYA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpFB+A0WlwPqvXouPNNAgEUHNQxzIPyeeifSv05V
 CgED102JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRQQAKCRAk1otyXVSH0IFqB/
 9O2YNN8PESOQ8WpkX3izDmeZcNEc1mXsl6dcYRSuYE00J6cl60UTAoBD2c+1iffUZZvHYOq08x9TYH
 NkZIB/U7bSX8x3OqTPM6omT3YbnF/GLaFbmWaz+J246wqay/dsccm5RWIqd7KpL36dESEg81pFOePd
 iMbsQP0jR6Oy9Pr/a8zLX0C8z851QwxecQ2bDMezJ8pTuATnSOHt8TymMguDghQvxihb/rrd9XsoE6
 OYyEldzAk187hNE56iYGryyL5b+P6sxtmplrhEfvR7kdK1liKjgs9r35hP5hRyhEJPyfpoJqyfcIYb
 cpqV42uhrlGB8tPJHDynJyu4CRAyZ2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While it's a bit off topic for them the floating point stress tests do give
us some coverage of context thrashing cases, and also of active signal
delivery separate to the relatively complicated framework in the actual
signals tests. Have the tests enable GCS on startup, ignoring failures so
they continue to work as before on systems without GCS.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/assembler.h   | 15 +++++++++++++++
 tools/testing/selftests/arm64/fp/fpsimd-test.S |  2 ++
 tools/testing/selftests/arm64/fp/sve-test.S    |  2 ++
 tools/testing/selftests/arm64/fp/za-test.S     |  2 ++
 tools/testing/selftests/arm64/fp/zt-test.S     |  2 ++
 5 files changed, 23 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/assembler.h b/tools/testing/selftests/arm64/fp/assembler.h
index 9b38a0da407d..1fc46a5642c2 100644
--- a/tools/testing/selftests/arm64/fp/assembler.h
+++ b/tools/testing/selftests/arm64/fp/assembler.h
@@ -65,4 +65,19 @@ endfunction
 	bl	puts
 .endm
 
+#define PR_SET_SHADOW_STACK_STATUS      75
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+
+.macro enable_gcs
+	// Run with GCS
+	mov	x0, PR_SET_SHADOW_STACK_STATUS
+	mov	x1, PR_SHADOW_STACK_ENABLE
+	mov	x2, xzr
+	mov	x3, xzr
+	mov	x4, xzr
+	mov	x5, xzr
+	mov	x8, #__NR_prctl
+	svc	#0
+.endm
+
 #endif /* ! ASSEMBLER_H */
diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
index 8b960d01ed2e..b16fb7f42e3e 100644
--- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
+++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
@@ -215,6 +215,8 @@ endfunction
 // Main program entry point
 .globl _start
 function _start
+	enable_gcs
+
 	mov	x23, #0		// signal count
 
 	mov	w0, #SIGINT
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index fff60e2a25ad..2fb4f0b84476 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -378,6 +378,8 @@ endfunction
 // Main program entry point
 .globl _start
 function _start
+	enable_gcs
+
 	mov	x23, #0		// Irritation signal count
 
 	mov	w0, #SIGINT
diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 095b45531640..b2603aba99de 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -231,6 +231,8 @@ endfunction
 // Main program entry point
 .globl _start
 function _start
+	enable_gcs
+
 	mov	x23, #0		// signal count
 
 	mov	w0, #SIGINT
diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index b5c81e81a379..8d9609a49008 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -200,6 +200,8 @@ endfunction
 // Main program entry point
 .globl _start
 function _start
+	enable_gcs
+
 	mov	x23, #0		// signal count
 
 	mov	w0, #SIGINT

-- 
2.39.2


