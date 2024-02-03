Return-Path: <linux-fsdevel+bounces-10175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EF1848613
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73422821C6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A190D5FBA0;
	Sat,  3 Feb 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqkNRTd3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9D7C094;
	Sat,  3 Feb 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963584; cv=none; b=kllUY4sORyQS7GTYbVhn/GV6kFBjnkAoAld/gRnnryvy6kRaJxlMFtUG430pWszrGDH+ybhbZyeMXNsf5LUVjCDsyAgnQBAeoI9NpiiG0gnyFiomYDdoNpcwJSpzM469mHqIhUrdjx9T3/5pr7IxLn5r17IkSQ0kBiHa2pPMKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963584; c=relaxed/simple;
	bh=JCh6BoCIOxePO8zZIr/FO/CERnc7ZRYHEz9dpM/Qpg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAnnEMyda31T70R5pSi5dHyVkYgiEpQyPXiQ+5fkfgWNBPm4x01CL5DGNXMpwz0G6jQl/Px8c1Mv7BU/wzBxUFshyHGnXeb+Pq5IkWczy2PaPdOS+/Axxg7XuiSLqnkU5sLfBu+xG1eEFwOtYYudkaYuAcV7qdjxs1GIE2dJ2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqkNRTd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF52C43390;
	Sat,  3 Feb 2024 12:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963583;
	bh=JCh6BoCIOxePO8zZIr/FO/CERnc7ZRYHEz9dpM/Qpg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kqkNRTd3I3lO3QHFD5UjLkvOmXQImqFY3hWHEUllrYLLdpP6+BXaYy4YzYJpIQfiI
	 2kHLBae1c3Xq/sQpeqs2cTCFeqKAzm2GWG98antWcjX06gw7CwAcB8sGoWImSmbV/w
	 wyflXPYe7lInBio/hiz7dnB6MaDG5vFzEnie76b+PFqOpjJwi04lDvhCirR0sYEstt
	 Osi7TWKazNTZlnXlSoBwbArXQxLqLF+EcZfBxzWRLpsvG2QYf3yRTP1bdczvlPmBcF
	 FWwLyJCk+HVbPq+4OqXrI/U2oQFk8+dEj1kiPmSnxfaxgaNatAxo25FP09LCxaN/sf
	 Dd2IR+IMxzJ5g==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:56 +0000
Subject: [PATCH v8 30/38] kselftest/arm64: Allow signals tests to specify
 an expected si_code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-30-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JCh6BoCIOxePO8zZIr/FO/CERnc7ZRYHEz9dpM/Qpg4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDo38gIcK9LJf7YTIjfUSjpLDV2o1lpaAkCiIJC
 kt2+aTiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w6AAKCRAk1otyXVSH0ALzB/
 4mRIohJMqHEtEnxH9wC0dGcy1NF3GJGVuohQBQ1SeayArCc3f3SjqKV52kokunFJEEUuSE49WPF9fJ
 i1lvqhrAg971iuSllKwjK15OdqSMq8uAVlbyXSeh1UpRu978IpinABVAJmFzVeBhsxRlAdH9j88WBx
 kAF5vqmLYu3dBH1x0Lf2hMVMye0R21jtWPC2adssJAG5oI2lzq7kPZH0P2HbAvcBqegDeN0fHuVdA2
 55NxduDCGp22NvYO4Jj4QstU5qHqGmFAw/t1E7RoLgStYY9aKRX0ItbjaUV03z2h4aOqP+0Wy4Puax
 E6I7vX3cLSpZLvELwVpM5UmmmNf1rV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently we ignore si_code unless the expected signal is a SIGSEGV, in
which case we enforce it being SEGV_ACCERR. Allow test cases to specify
exactly which si_code should be generated so we can validate this, and
test for other segfault codes.

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
2.30.2


