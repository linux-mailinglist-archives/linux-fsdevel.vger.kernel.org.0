Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1A75F75D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGXMzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjGXMyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E7D3ABC;
        Mon, 24 Jul 2023 05:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E5C61149;
        Mon, 24 Jul 2023 12:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4924BC433CA;
        Mon, 24 Jul 2023 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690203004;
        bh=JCh6BoCIOxePO8zZIr/FO/CERnc7ZRYHEz9dpM/Qpg4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=vPogTPE7pn/eaLc1MLdLSnGzfK7e+qVHTabZTHFSfxz6HliE0BH1pG5PDlDUzuDmb
         beY99UheZbTiz2uERhIQDBYfxuYno+jK6SkSlbZgKa/5Z047gySjPbkHVNVy6eRKea
         HjBYCtZnGmA1kVDtB1kBFGMeY5yfNlYMgXnfcrsKOXkV2D4Nyb3eM5wCxbwohGye+N
         cYF/WAN//zkKeXtwvSJk+CJOgiZoU4a4DA787pMXlCj8EBPn89LGoATR5gS7JMCBIa
         z+FHiUgJNJsdia956Y2JjEf72fgjekqO/7Wou1aVuelMHGCBPsMEcNLXdpEOB7oNU7
         nIHTk+dMnJ1qQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 24 Jul 2023 13:46:16 +0100
Subject: [PATCH v2 29/35] kselftest/arm64: Allow signals tests to specify
 an expected si_code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-arm64-gcs-v2-29-dc2c1d44c2eb@kernel.org>
References: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
In-Reply-To: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
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
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JCh6BoCIOxePO8zZIr/FO/CERnc7ZRYHEz9dpM/Qpg4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvnKxCmMiMdhZ55NKopiDM0r9ZQ4wmAhmq+eZQSJj
 d19Q+peJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZL5ysQAKCRAk1otyXVSH0EVEB/
 4nxFWGm+gXQOIhXJVYuK0f3dUSAR7Bc9QE+ZgLV1xZYsUw9rdQ+FRPm8tgprWJ5tCezWNODAjchO7w
 RbO98ak1+XbucVtrbXPIhBwq6JR8bgzhTcFR+5eFK64P1KAIGi6KohoGJfOY5XLWfKByYrAWCEQTtY
 pCOdeMOkZ6juiWfUZfFOU5hOeKQSn801k7VO53fkUElSuPSLStInTIUydM3vktPmiamCjKcL0SxMHx
 HP9Bca0RkTIh7h5y0mFPwWn7QVGtny5W9w5YqD1/aXrng2cRBalkOKd0WNgZXNoukNJRYOfG9RTR+D
 gklcYUyK19lEEQGpHUtsYGtfWuoeUL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

