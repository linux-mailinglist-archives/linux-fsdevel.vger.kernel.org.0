Return-Path: <linux-fsdevel+bounces-30605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48898C92B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03891C20B76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9E1D0F7D;
	Tue,  1 Oct 2024 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWWWef7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6B1CFEAD;
	Tue,  1 Oct 2024 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823954; cv=none; b=DQQ9QKLgDuJN/ulr+VngChhQIerQH4wkaDFCfqMWMzHdJaF1O1B0UWgGlJq5f3tHl9Fe1qRdI/At6kIxoVtTNJHOZWJfhyFyjbi4HO5VuRuZRmhW1mCi6bCkOe+uLeP8SZYStP3/ZYRbQt7pdEsaB9dJWD9FvepnmF9fyXbcubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823954; c=relaxed/simple;
	bh=HmmAMUZllaI31DzUS2UptX/TOKKFhFSrPJJKYwJO4R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1X8e1a92VMYAPCquAOziGzK4OFkvfLinr0rJn50JuOYOmVXPSVfzTXagWoXgMgc65fuJKBc9Jsa7YIhakEOU63XAB4HV6L+/K3I4KZBcjGW2ZtY1hY0J5QsTQiQgziTJ341mVNu0jBZjDpP4zhajnOzIB+3YJLFr236l2TwmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWWWef7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5472C4CEC6;
	Tue,  1 Oct 2024 23:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823954;
	bh=HmmAMUZllaI31DzUS2UptX/TOKKFhFSrPJJKYwJO4R8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oWWWef7qAoDsa3O284WmbA0+4gtsVF9fQGw5bErbwRfW/G/3F2SnO82AUhRfOPPKp
	 8iSUpwDGzBViwQtHsL3bQEW8BkhBnpj9tsYQ9f2AEG1HMszClmQxtjptGjzvfdp9TR
	 2tnBMAP2zHB7RwsCEnx1Q9Jw/Er87rPJHsfadtyl3WUB9Qp8Z5LArX/rxGdsCM4okJ
	 AwQM6Sb3okhzC6Iz/NkZ7AYbUJHbyTX09NUjSYuyaWLQV++JhEiAu5b3rjgLU71fgb
	 Qm6GFQeB2KZVXCXH7y0lGxAjEK9TD15YOJxqXZCZHRmKZNCIA0RDT7Xp5ibX4kyD39
	 l4XZfCeHsT78w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:11 +0100
Subject: [PATCH v13 32/40] kselftest/arm64: Allow signals tests to specify
 an expected si_code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-32-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HmmAMUZllaI31DzUS2UptX/TOKKFhFSrPJJKYwJO4R8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7d5yGKXzr5saRN3DNRkwpkNhqMTqqjdMk4lgiz
 LOIonX6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+3QAKCRAk1otyXVSH0JaKB/
 91iK7iv9R+ueyloiMWoxyPRjComH147TYmfbIX9Ykm8qRaL4igLeAchB/ATQueCmLNC6Pxpeowl4QZ
 NYwqAhZdyqAlYXQZc7c4+Rg4CRUKUKUsWKWX7sfqAgnoXhUYaitLkAb34xofi2MRlJ6FLRrENO1XVf
 DSLs8fbdKAurGonLAbqeHFbVzI5LfwqHtakqeDAH8dvk2F9Tmt7xxdlnRP3qt8APEzJfneZp5Vf5io
 QROYJbPR8axNhug6Vn8nmgIjd6adwj+/ZoxkkVwwNWTu6IcwnjuV7KdVL6Z0H1siVkldER5/d0RtbK
 j4xQwxJqxUFu2TYrOofQwMa8i38WEN
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
index dcc49e3ce1eb..5d3621921cfe 100644
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


