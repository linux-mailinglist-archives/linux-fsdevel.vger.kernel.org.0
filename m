Return-Path: <linux-fsdevel+bounces-22403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6CB916C55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6916C28A3DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D7D18733F;
	Tue, 25 Jun 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8cjstF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF694171E64;
	Tue, 25 Jun 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327874; cv=none; b=Hm4ayXyqtEN7GmzIfd1z63mI5r1m1Ycx8CGKY00llK/2gvVeBwix2CIlng2CbntEmn9MD5lXVkWLVsYzPMTkBzYRV5BfkIqNtrkewg//A43dSKpKrdd4J14rw4u62Rnac/TliTAUXSaPu16eu+JJMHpwKuyeSMc20q7GXlAh+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327874; c=relaxed/simple;
	bh=+guAOBhRmIfgEVfzNIbxa5iAcbQBA9Aonxf7B+eDgYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmEzAtHsk3PBdN5ubqxNPI6EAnXpAzFChirWRNFwh2NoK8YXkWPEdF5Dsrnt7HJ69vtcnL1gtGGAbxWc2DeVSiWIdTwxVmbfMW8TTQve9YWVKNZ45LABHOSLHLHLAfhXgHsOWr4uQmaHDhXQoeq+hJbIPTJLh0Q0yUYnmwnJ9cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8cjstF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEFBC32781;
	Tue, 25 Jun 2024 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327873;
	bh=+guAOBhRmIfgEVfzNIbxa5iAcbQBA9Aonxf7B+eDgYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8cjstF/mgdTleo91qpC2f9tAA/APzDt3Ah/q506dJUs0NQK+MXiE8V/fP5BCNkd5
	 Uf4W1coDnlv9pX3xUikhGXVgudO0JzfOSomv7iOEJ9A8Gu60ZKHBcJI1xjPXhI/Rv0
	 1aYOm8OusCZ7nGtXfrq1fELmm40/kYT1qscr8JN+IebV+/6CIfBWCyck6Ldf59XR1A
	 dRplzCv9+2bZFT/fYGD+/K4FqWmRHnGaN2vVZW/d1TDjjxuTXz3PZ2TT0SimG1H5HK
	 uwW3uhXxbjDIpdhpxfs+8LIziAdfH4byOMVg+XXs6e6wCqsqe8P4MgCdOrfKci99YW
	 1aCO84B2UXtjQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:58:00 +0100
Subject: [PATCH v9 32/39] kselftest/arm64: Allow signals tests to specify
 an expected si_code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-32-0f634469b8f0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+guAOBhRmIfgEVfzNIbxa5iAcbQBA9Aonxf7B+eDgYE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuLHhc9eoiFwa2wgiNY9NyD96L8JKN8REd40ykS
 +Qp3x3SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbiwAKCRAk1otyXVSH0JywB/
 4xJOFMt9ir0tkNA9PxrFv9eJTeMLvSLxhqLsveF3LAyd3Uu/yVbBgFU+5FTFqGi+4sJ9m/NlnTFVx1
 N5bIEo9e9/46Xb1lRUnO8Tl7P6bUAhlPC5QVqvWY3Rndee2MvV6APAc3Wjktm9tJiPAoCYYAEFKGHy
 N6hegX+FVqJZpNIav+9enZxpWZendOqihOSq/kI73pEBvUsE59IygNpO3oF1R2R1cW2nWrM367aaLJ
 oZKU663P9entBZ0rNz/KVgbW4BobG8tcdSbsFY4jz8lRZfeeNL8M1UBHH6E+SmacoLvWdwdI+/7sq4
 QrdXN0MS7m2o3ZTNBuMEjofJd08Dsp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we ignore si_code unless the expected signal is a SIGSEGV, in
which case we enforce it being SEGV_ACCERR. Allow test cases to specify
exactly which si_code should be generated so we can validate this, and
test for other segfault codes.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/signal/test_signals.h  |  4 +++
 .../selftests/arm64/signal/test_signals_utils.c    | 29 ++++++++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 7ada43688c02..ee75a2c25ce7 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -71,6 +71,10 @@ struct tdescr {
 	 * Zero when no signal is expected on success
 	 */
 	int			sig_ok;
+	/*
+	 * expected si_code for sig_ok, or 0 to not check
+	 */
+	int			sig_ok_code;
 	/* signum expected on unsupported CPU features. */
 	int			sig_unsupp;
 	/* a timeout in second for test completion */
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 89ef95c1af0e..63deca32b0df 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -143,16 +143,25 @@ static bool handle_signal_ok(struct tdescr *td,
 			"current->token ZEROED...test is probably broken!\n");
 		abort();
 	}
-	/*
-	 * Trying to narrow down the SEGV to the ones generated by Kernel itself
-	 * via arm64_notify_segfault(). This is a best-effort check anyway, and
-	 * the si_code check may need to change if this aspect of the kernel
-	 * ABI changes.
-	 */
-	if (td->sig_ok == SIGSEGV && si->si_code != SEGV_ACCERR) {
-		fprintf(stdout,
-			"si_code != SEGV_ACCERR...test is probably broken!\n");
-		abort();
+	if (td->sig_ok_code) {
+		if (si->si_code != td->sig_ok_code) {
+			fprintf(stdout, "si_code is %d not %d\n",
+				si->si_code, td->sig_ok_code);
+			abort();
+		}
+	} else {
+		/*
+		 * Trying to narrow down the SEGV to the ones
+		 * generated by Kernel itself via
+		 * arm64_notify_segfault(). This is a best-effort
+		 * check anyway, and the si_code check may need to
+		 * change if this aspect of the kernel ABI changes.
+		 */
+		if (td->sig_ok == SIGSEGV && si->si_code != SEGV_ACCERR) {
+			fprintf(stdout,
+				"si_code != SEGV_ACCERR...test is probably broken!\n");
+			abort();
+		}
 	}
 	td->pass = 1;
 	/*

-- 
2.39.2


