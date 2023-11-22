Return-Path: <linux-fsdevel+bounces-3400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523017F42AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E17B212AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D125811E;
	Wed, 22 Nov 2023 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZVDPcKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3056476;
	Wed, 22 Nov 2023 09:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB795C433C9;
	Wed, 22 Nov 2023 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646492;
	bh=+DcIGbRVvw60QaNepPSRFBnETXstp9aOb5bVveLOaFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uZVDPcKFka+wlMJXjfzajobqpM6EaIscRoqp8YtTGuiZLIBclLh/18h+beyzfCCak
	 O611N3cFEGc9ooTue7jvmAjHduLzlohXVD9CMIjCWn79H/TlnFbuXsNc8sX94PgzpD
	 CziDJmtJS4Lxr7Q90BN45O6K7RZDp60OhWbeVYOizHCAv+pOxqIKTxJVflyNZ+J6XH
	 /WFEwQWOydbHD+eyzieR8s/u37khmup0ORNwiLjGPrd5KdyWHwd+12K9tNSjVXsVMU
	 h4yc9Yk3hd0sUoKwmILtXr0+4rKmOlfPSNZJELuR9deSXlQR1au1DbSTFSMH3s0Dw3
	 UjGBYMzpNCEaQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:49 +0000
Subject: [PATCH v7 39/39] kselftest/clone3: Enable GCS in the clone3
 selftests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-39-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
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
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2416; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+DcIGbRVvw60QaNepPSRFBnETXstp9aOb5bVveLOaFg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0Uf5JbJdKOG4lKmXzlRMK5DRWagk6L/dGG+
 23SAtCf39uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NFAAKCRAk1otyXVSH
 0HKwB/44qmjC2meQurJ74cEJ5LyDpr1HY6Y1uWSWnrnkSyRi8ifcJAyyiipIeWWT2m2p19Mpf+V
 5qrOSTOZdbGPeoAgIKaULvFGqHP/ksUE8h92lW7xsOkWWWvpcMBPOCkmhlsIYyaWpVOSMobVII8
 PBDQf7mV3cJuvY8YfCMIkBz3Ul6mwtxdu9vNby4YUtXDRU9U3cGAcL6XtW3KntS2xI0+aDTcs7i
 YX48MJ+hv3H+CYavScUNHVuNSx8y1Q3eta1i1xV3wGLOaAAxBPAvtoCuwkfsLCOAy6jNqbmbBPU
 2P7pVrY78UsvDTA8mvMcJrJSnASVS4HY2NdgEMkZbCxKMCbn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In order to allow testing without full userspace support for shadow stacks
the clone3() selftests open code enabling them at runtime, hook up arm64
support.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index dbe52582573c..6114a33d6ec2 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -432,6 +432,43 @@ static inline void enable_shadow_stack(void)
 
 #endif
 
+#ifdef __aarc64__
+#define PR_SET_SHADOW_STACK_STATUS      72
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = 0;                               \
+	register long _arg4 __asm__ ("x3") = 0;                               \
+	register long _arg5 __asm__ ("x4") = 0;                               \
+	                                                                      \
+	__asm__  volatile (                                                   \
+		"svc #0\n"                                                    \
+		: "=r"(_arg1)                                                 \
+		: "r"(_arg1), "r"(_arg2),                                     \
+		  "r"(_arg3), "r"(_arg4),                                     \
+		  "r"(_arg5), "r"(_num)					      \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define ENABLE_SHADOW_STACK
+static inline void enable_shadow_stack(void)
+{
+	int ret;
+
+	ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+			  PR_SHADOW_STACK_ENABLE);
+	if (ret == 0)
+		shadow_stack_enabled = true;
+}
+
+#endif
+
 #ifndef ENABLE_SHADOW_STACK
 static void enable_shadow_stack(void)
 {

-- 
2.39.2


