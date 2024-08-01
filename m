Return-Path: <linux-fsdevel+bounces-24782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2891944C8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582812841A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7932D1BBBE5;
	Thu,  1 Aug 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiQC9tfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0361A08A4;
	Thu,  1 Aug 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517272; cv=none; b=FH72NiLb1VcWNECbnvEYALo0rtqB6ndAiZuapYK8Pwp/Wh3V7Q798nwDxHcOLmmPxHILbHjzfUGfwZWPFee35yDMLDnTWPDTyyyLk1tMDsuEBG2CgUx/POXtmxSQwR4Ir8id6kTZqOAGRypEiXoDqVPuwPsC9qzrUnHNRXqQN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517272; c=relaxed/simple;
	bh=LmUMQLV4QzyWbEviejJtcrr2Je4DeKbVGxPr/Gcjy80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQO2n2GMe/S5NriEBLdgzhibFtjUSFkjd16pxLqk0Aib/LHGaG3L5bbc5suyq1W8oeG6ZyYIzq9yHDqHqWUnFJehY/SCxxlS35mxtaTotglAFlsSU8XA00HUT3wfSIBndNkT9ou23zGc07km7g1nE2Cx5CpzAVFOpLo21tMnQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiQC9tfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760D5C4AF09;
	Thu,  1 Aug 2024 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517272;
	bh=LmUMQLV4QzyWbEviejJtcrr2Je4DeKbVGxPr/Gcjy80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eiQC9tfEj2yzbkQUVXuEHA5FOCUQHlZsCNGDpYBeDhIZahyslRfPpjWdlSGLz6loU
	 S4s88Lq5J29Pt50M3T98bU6+aWK7vhZwQgr3yZ3Y7UsrlpN5arpGSPNb5Rk99niNo/
	 TgsAQutH5c759cE6VN50T/zDAEZwjnkXlQWXW6N8AZRTv1i0lVUaPYG7bnMjaD/AXJ
	 0dv7guXmbq8WvESmD5D3celWtH45rjAsGVMPjiHlxN/IJUvQKYAQsJrv/XWHTRNgNH
	 Kw3X9fCFajCuE/P7ul7zOiyesfJYpFAl3j/nUk4Ji/lEVLP+EYu+9URKrgefd5yVn6
	 Ui0PXtb0gB6gQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:07:00 +0100
Subject: [PATCH v10 33/40] kselftest/arm64: Always run signals tests with
 GCS enabled
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-33-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LmUMQLV4QzyWbEviejJtcrr2Je4DeKbVGxPr/Gcjy80=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YfZHSTRLe1W0pE6ZV+ChRvx8M1mI3slzwhZw3O
 nR/3G/6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGHwAKCRAk1otyXVSH0Da/B/
 kBN10pM9iQ0M7RJ7DnXB/XtakgurlZID9xXfbmSA521fi6o3bzBiw7Aib7wVwjLCx7C7kZevZNYB0D
 gUkpZv4ysXJ78OKkGw3ePtUD+gbK/YXk+qfsu6aqiNBo/6kIPlInroTz76OU30v5XYBRtv0qGjr8z4
 HKl65vUzC/F7YW5uYWYbJg5qIroL3CNndMIbnKDTDBg/YYNpY993oea/y8Y3HxOCrMESy0p4Yhv+hi
 o4cUmtfZidJsNsh8Eu7WMIaoGJosFAcaEAgp/x6nFlkooNF89WsuySwLaR+t2/ZDSMyAcbBL8OKKR1
 /7etPpNbJS7ZWvNxQ6rNYNZ2bSQUvo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since it is not possible to return from the function that enabled GCS
without disabling GCS it is very inconvenient to use the signal handling
tests to cover GCS when GCS is not enabled by the toolchain and runtime,
something that no current distribution does. Since none of the testcases
do anything with stacks that would cause problems with GCS we can sidestep
this issue by unconditionally enabling GCS on startup and exiting with a
call to exit() rather than a return from main().

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/signal/test_signals.c  | 17 ++++++++++++-
 .../selftests/arm64/signal/test_signals_utils.h    | 29 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
index 00051b40d71e..30e95f50db19 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.c
+++ b/tools/testing/selftests/arm64/signal/test_signals.c
@@ -7,6 +7,10 @@
  * Each test provides its own tde struct tdescr descriptor to link with
  * this wrapper. Framework provides common helpers.
  */
+
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+
 #include <kselftest.h>
 
 #include "test_signals.h"
@@ -16,6 +20,16 @@ struct tdescr *current = &tde;
 
 int main(int argc, char *argv[])
 {
+	/*
+	 * Ensure GCS is at least enabled throughout the tests if
+	 * supported, otherwise the inability to return from the
+	 * function that enabled GCS makes it very inconvenient to set
+	 * up test cases.  The prctl() may fail if GCS was locked by
+	 * libc setup code.
+	 */
+	if (getauxval(AT_HWCAP2) & HWCAP2_GCS)
+		gcs_set_state(PR_SHADOW_STACK_ENABLE);
+
 	ksft_print_msg("%s :: %s\n", current->name, current->descr);
 	if (test_setup(current) && test_init(current)) {
 		test_run(current);
@@ -23,5 +37,6 @@ int main(int argc, char *argv[])
 	}
 	test_result(current);
 
-	return current->result;
+	/* Do not return in case GCS was enabled */
+	exit(current->result);
 }
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 762c8fe9c54a..1e80808ee105 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -18,6 +18,35 @@ void test_cleanup(struct tdescr *td);
 int test_run(struct tdescr *td);
 void test_result(struct tdescr *td);
 
+#ifndef __NR_prctl
+#define __NR_prctl 167
+#endif
+
+/*
+ * The prctl takes 1 argument but we need to ensure that the other
+ * values passed in registers to the syscall are zero since the kernel
+ * validates them.
+ */
+#define gcs_set_state(state)					\
+	({								\
+		register long _num  __asm__ ("x8") = __NR_prctl;	\
+		register long _arg1 __asm__ ("x0") =  PR_SET_SHADOW_STACK_STATUS; \
+		register long _arg2 __asm__ ("x1") = (long)(state);	\
+		register long _arg3 __asm__ ("x2") = 0;			\
+		register long _arg4 __asm__ ("x3") = 0;			\
+		register long _arg5 __asm__ ("x4") = 0;			\
+	                                                                      \
+		__asm__  volatile (					\
+			"svc #0\n"					\
+			: "=r"(_arg1)					\
+			: "r"(_arg1), "r"(_arg2),			\
+			  "r"(_arg3), "r"(_arg4),			\
+			  "r"(_arg5), "r"(_num)				\
+			: "memory", "cc"				\
+			);						\
+		_arg1;							\
+	})
+
 static inline bool feats_ok(struct tdescr *td)
 {
 	if (td->feats_incompatible & td->feats_supported)

-- 
2.39.2


