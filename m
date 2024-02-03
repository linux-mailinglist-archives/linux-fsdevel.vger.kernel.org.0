Return-Path: <linux-fsdevel+bounces-10176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE996848618
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F49E1F2261C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4C27CF14;
	Sat,  3 Feb 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJjcPh3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F27CF12;
	Sat,  3 Feb 2024 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963592; cv=none; b=UkCzeTvrJPp2C8jQNb5L+KN5IoaRb34+1Scurn27nekcLi8DK2bsHlfjAornhbDMtuU+blvkGjxTIgZvKAqm+Ut3dfh7s2r+s19y2W1aWHKb3gyXd4mdUPoiE9ray1Lutc8SpKIETkKhiMhfUkQ3KZAZeENtdO2C9xw1wKIl+RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963592; c=relaxed/simple;
	bh=OYaAyRMLSn6kTs6FMYnMtTS8W24+WIO4Ly8HwzP8d7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNELQ88EYKjKx5zktklU1bCUDTP5EdK28GhRbLaBShL3hOCAOUgXoqn+6lYsSqvmApdhmqktNha4TiHuitkHIW8KT9HoJq5QR7ABn1V8zRx5jx+l8U/o2sStOxleTjsJkpsrciweam6l25W787N28lEoRiFM+g/hkf1O7Bp9ZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJjcPh3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF954C43601;
	Sat,  3 Feb 2024 12:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963592;
	bh=OYaAyRMLSn6kTs6FMYnMtTS8W24+WIO4Ly8HwzP8d7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hJjcPh3up4HsDZeZdZrX84RsssLo8XHcibpiV1YYg5swoZV7KuU0a3Ji6qmRxlqdK
	 KpDz2r7cOtyULAMhEqcSBNmjSIFe20d1wwmaFV3mpzGkVJ+e9l8CV4kCrTADGyImUl
	 e/AJPrvxbIBclb9fP5qip4riNVuFxwcOvLSVQS5qMi5Lsa+M+pQ1AWIBTY4x8+JRRP
	 xOLW5BL0CYOS0Agni/T3QBOlIDn0KLyphHOPDdlkRcqLcE+nEQbGpQ3DA45lB5cu2X
	 Zh15cDH5VEWdYtGHAJxQBzXigtBSEQK5zoyUbHgKSIIzJ4axd7yoHCoATcMzq4pdZR
	 rxcvtOaJx6FrQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:57 +0000
Subject: [PATCH v8 31/38] kselftest/arm64: Always run signals tests with
 GCS enabled
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-31-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3590; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OYaAyRMLSn6kTs6FMYnMtTS8W24+WIO4Ly8HwzP8d7o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDpE03vPx+2Pd9LxDq0QKtQO89e99y0kE09Rllr
 fmbRSv6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w6QAKCRAk1otyXVSH0IW0B/
 4gWE9kc5oX8BOOeLRppL7+i6OUXVRASufGbun+oroqFRKPKT2m/bUgRvBF0DaXYGnvceLQZ8guplbg
 phtTjyQUG+o5r6ln4cRGCKr17qkiOiDDFRL3K69dvv2zkPwY6URF3rT5N9L3d73Ns1XjoNXlkcqxL4
 elVsHMFR6mfG2RbNxdMgN8UipZRDTHNuDksPeio4HFN7c4NT+G+YZxdLTW02A79uOpRUqW1ve5+Ewt
 +3xXdhBnydiJmr2UwxSlp+6qiuQZV6qfMIe6nFtS92pdjrRCMF1whN5IQpH5hT9EooZg2n1hduVsV3
 nGCvXnWeBNRHpLZDmmLL85F5MPAOnH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since it is not possible to return from the function that enabled GCS
without disabling GCS it is very inconvenient to use the signal handling
tests to cover GCS when GCS is not enabled by the toolchain and runtime,
something that no current distribution does. Since none of the testcases
do anything with stacks that would cause problems with GCS we can sidestep
this issue by unconditionally enabling GCS on startup and exiting with a
call to exit() rather than a return from main().

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
2.30.2


