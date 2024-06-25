Return-Path: <linux-fsdevel+bounces-22404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B6916C5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8901C20A39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FF17C224;
	Tue, 25 Jun 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="du6vaexO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6E171E64;
	Tue, 25 Jun 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327881; cv=none; b=CQSR92Cjwugmf19vJwj6ttfWeHu+trQbe46Dnf/Ux9E1CS52+4GYHNgR0ybAMyLVUeTrhfs9hnRPXcQ82aM6iAWpsWQ/HjkS+z74/tbGvyEG0HJbAIkRS4d3ymfHWOf4A7Qcw7zdq/OrVCeKypV3a6ll/spdkx6z7rXGUqClAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327881; c=relaxed/simple;
	bh=LmUMQLV4QzyWbEviejJtcrr2Je4DeKbVGxPr/Gcjy80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iF0axdD2mUlbSrM4t3YSuYrRxAPXMkU+n1GOv9XJMjxQImjw8b5Z7Mb0C9fekjzRL+mp+Rxp3f1a5tZLwvJ/zH7tU1gDOmuo80q2NtSjMTW1Wy2YVZPee+Ce1lHyQM1cMmWUu2ANhWj/BXdkITJpscRAXwOJLssO03a0joCGino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=du6vaexO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBA6C4AF0A;
	Tue, 25 Jun 2024 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327880;
	bh=LmUMQLV4QzyWbEviejJtcrr2Je4DeKbVGxPr/Gcjy80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=du6vaexO1e9KK9PBCwvYTpxcVwePxCaXdSUymitdkY2yGi3OSvzt93iasqBU5USJL
	 Os3xr2P02ObG0fL+ZHRIELyG0Ey0MaUl/ka7TIszprjmsRHLPqjGLHWsF0AKTWepq5
	 +cJ6Yc0uyrKVQWzzBNbf6P12IsfdDXnQ0dEvfXskWqj2RJRsfHSsV74q+1VikPOssK
	 7K7fNpCc0rnJNIOuk8l6DLh6mlxszcslo3E+QCl+EEf9N65fyyednMT+3xVCwZ8DSN
	 h0LK0chSBv6Mt/xDGWyL7/kbXsWBl/FAHKC/+TIALyF+9MmGv4G7aIy8vlwp6RLGDz
	 RBe21pgE8cSpg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:58:01 +0100
Subject: [PATCH v9 33/39] kselftest/arm64: Always run signals tests with
 GCS enabled
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-33-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=3656; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LmUMQLV4QzyWbEviejJtcrr2Je4DeKbVGxPr/Gcjy80=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuMBBzEr/5fPxdn4M1kqYgyqYIDV9xPj9y1gpdq
 Dasxi4mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbjAAKCRAk1otyXVSH0NeqB/
 0eu00yVrdM0nkJRE7E10o+fE9zBjQ8yuBbBz40rjowd9RiICT6y6kzUWPLkkw5hZJ+nHhXz6wVEskQ
 iBk+cdeqVhuG80/i43LtKouhIPOB/pUPVCqOIYEG5J3pL1mVqXfMa6z+PftgDFrA50rtWgyU33qHae
 NwA17vdSsKBUmTWqD5tWpiXfJ+9BB1HbQozGKbEod8+WGNi55D9isLwEuSjA/UDUW7D5XsYg7IinXN
 FY6WXb4ZKhRlLIBj+Wp6/gOyh+Zb18GdvOjXgLqtJlRUWeEDRZ6yntwd6FzocmZYzJuFXiWYs+Foiu
 wWaVUKbXTVDAjk5bPe6wc93gzDa4WL
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


