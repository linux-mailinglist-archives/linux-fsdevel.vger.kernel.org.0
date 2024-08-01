Return-Path: <linux-fsdevel+bounces-24781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB0B944C89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF961C2707A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C271BB6B5;
	Thu,  1 Aug 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chYxdKgK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581971A38EC;
	Thu,  1 Aug 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517264; cv=none; b=Bobklhu+Km61tRzO1jTIhNHB5/Qdo65gge9a9rOHrjXtJ+T50uiQW1xkjw5QlcIleVrI6nYpDH7yV550xo9gSVdDO5zQYVCpLT9UhaMURZuZE/qFOFn3Z4EJub9gGERBi7rh/R6EW8Vgfnj3Qw2tdJRRQXOl06IvHy+sl9Ypzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517264; c=relaxed/simple;
	bh=+guAOBhRmIfgEVfzNIbxa5iAcbQBA9Aonxf7B+eDgYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQWRuWlpl/RF1SB6k1TwuHSmwP53vaE88z8mbQ9sfJYJ97qXL/v3sT3lQ2Nc2uZVtqhjvV0xXO4fzHCJN1nPOSfEnM5r++LMIdGQK6jEv5OinQXwtykpKWPy4eXecpWdWYZnuTvOrnoaeaLH/B4pfZGYg9toQx6g6h2agmirWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chYxdKgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CD2C4AF0A;
	Thu,  1 Aug 2024 13:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517264;
	bh=+guAOBhRmIfgEVfzNIbxa5iAcbQBA9Aonxf7B+eDgYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=chYxdKgKEN/P6WhtjSlCRHRkRW2Bij5hb+Y7VAQJKyCvKoPomyYMt8eArd/MVWIK8
	 61GY9dsmfiCU5Jys/qtBCj6COundf1HHTWMcw143MpEsvQEW5kNgUxBEhy7QxfbBp1
	 l5nVQ1KwuENodPcsuuvbuCUzld7ZZ0nlWbrzovrigtEAjwpSaB1Le0b6wP1F7Bl2aw
	 hSuxIPdajC4F0ApEoZI98nrjUc94Q5ofvfoAg+78wxlkVvsJ4DU/7ibQoPGPURV7sn
	 yAzCuvwyZFbXTbWSoScHdaLvR4B1W51AYxojkTbz41SdPUFXkfsDk+kMlXfOIRnphm
	 hpY62eQpLtzuA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:59 +0100
Subject: [PATCH v10 32/40] kselftest/arm64: Allow signals tests to specify
 an expected si_code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-32-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+guAOBhRmIfgEVfzNIbxa5iAcbQBA9Aonxf7B+eDgYE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YeUXoUQw/9I7ybFQmVQ8h2lcPYkdDrKBsETSxM
 MBjWXMSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGHgAKCRAk1otyXVSH0KVCB/
 4gRjlP4/lp0JabZj5jZ4yViyk5smTqzwWsY4ENeCSjsgUO8f9bx1pGhzfjIQTxvGmkdsS5tQ7QhxIN
 fIPGi7IZXlzFmZa9T8S9M9tMgZrfDWs/9RohnqVFwJZ8HosQgIvEx041S4+1/z52tEYmC7GHKvM/Cx
 c9iY8K4DddJGJMT0l7dlRvXBwOLTXRf2E1rRcUa/yZsOFS1rCP05axTuU6MaC5yvT96WZL58hYdvn8
 RdBPuIl7oV8XA40gGkZAshXYW5ICmSFqcw+SwiPHGqGSScN5TFR8tt/1J+hpoTLzX5V/O8H2gCzK2p
 1qmfLZxLZVb6xcXZEc/UB9a4Qfow3n
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


