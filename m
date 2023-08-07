Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8197732A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 00:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjHGWHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 18:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHGWHR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1D1BF3;
        Mon,  7 Aug 2023 15:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3E07622B3;
        Mon,  7 Aug 2023 22:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE1AC433D9;
        Mon,  7 Aug 2023 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445873;
        bh=JCh6BoCIOxePO8zZIr/FO/CERnc7ZRYHEz9dpM/Qpg4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=rN8ckZmrZF6DP3DK1z17DQ4UborvhLXmgwp7RrVi8uGDap3g8szsq50Rygvctk4qs
         6H7VCOahw2VukqHOypigyE2FBB3kyVXySW5qZZTDz0mjJpmM+skJU+keh+xObcRMFg
         lMJVp6BPDBl7ZavFsN96Z/9wCnZUCCx5tGuOvD/jrPe+IBHftICjQwpsP942jd/p/G
         RUBXdVM8m1+18B/u7IOhLk6JIgh2A5I+xiPF+d2uA2va9EVlqVMx+ydohM0jj0ZcC0
         pfEHorYN+PE6oaON5Cz+lJ9LNMu+s7qegjXwVBmjWaxMih4nc/V4pNxYIuzVcWbZrM
         YD7BfTXH+0Ybg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Aug 2023 23:00:34 +0100
Subject: [PATCH v4 29/36] kselftest/arm64: Allow signals tests to specify
 an expected si_code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-arm64-gcs-v4-29-68cfa37f9069@kernel.org>
References: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
In-Reply-To: <20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JCh6BoCIOxePO8zZIr/FO/CERnc7ZRYHEz9dpM/Qpg4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk0Wmvgj7+0Dl3dBMUzy5osqtFltpvLjCBs0jiIIcl
 T/WAIVWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNFprwAKCRAk1otyXVSH0HLzB/
 9aj1GvMDbc50DdhzBKgei7+9lJmBts7z3e55GSTyEGh7mW2QSHPeDZmHTd2vMR2pspdUwkQEenPJdi
 uuAUCeC8uv79EFoE33H8M17We3UnjGGZlekCrS+H2q/tLk6UOEOa5tN2H+EsEEt2391WwHlUPdmRc7
 raOxBtWEZp4sSUFS6YpHns7d5kWppmv7WZEVTQd6osLBGQ/OWVH1DJngsg2F4U/AQYqmx87GHLtChe
 65A/7/WOFjXvjbU7ShL/aoNHl3HJaZCEX7fMYJ1Wv+XVrM3LbHqJ3o/1czI3tACsmA55jjBJ5SiK6G
 erIVmi7Hb353T0gVoFU6xOZK5hAU/W
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

