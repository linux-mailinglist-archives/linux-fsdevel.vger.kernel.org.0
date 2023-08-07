Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B2C773299
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 00:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjHGWHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjHGWGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBF530FC;
        Mon,  7 Aug 2023 15:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 612F4622AF;
        Mon,  7 Aug 2023 22:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFA2C433C9;
        Mon,  7 Aug 2023 22:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445860;
        bh=Go+3eKanODPQVKnV1QnMIrC75/lXwO2PkPnkMfOn2oA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QIDi3nsa+DsRCeYHoIoIcbELawp+4+it0GlgaT4DvjDnJ7Q4Zgh2cigRtqYXHnqfp
         gd+gElF+qj3RCwCvHIbU65ZgMewQqoPl4YfQ7vYMdVcLxczbcBGpLHGfh4CmkYnXhv
         8/l8bM8Xlqr3yQlX4mIgX0B7oPvpZs9LfkZNJyMKRFWKF7aTFw4dVLAO8HeS/drUgC
         vLMc4sEpVAUH90ZDLMnnfdQQXvAkj/bh6XKobw6ybeTUZ1amhV2GqyiRm7uTQvLiof
         uvx1uB0SNsJcmlu3W5NxSDelhmC7wPWeQTptCwE+EXZuzBIhExfPJGANqB5KtQjxdr
         vdlQK7UaDUIkQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 07 Aug 2023 23:00:32 +0100
Subject: [PATCH v4 27/36] kselftest/arm64: Add GCS as a detected feature in
 the signal tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-arm64-gcs-v4-27-68cfa37f9069@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Go+3eKanODPQVKnV1QnMIrC75/lXwO2PkPnkMfOn2oA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk0WmtHdDxBWVvmzkYAUf6uUsjA/rziBCuAYQ+QZzI
 679QmoaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZNFprQAKCRAk1otyXVSH0BDfB/
 0cvKNXfnPZ6BOOjIAiA1MSHXH2H5yBCzaglGgIll198tjsunG8/G6A+HI/RDAXXiRIjvcYqu3qV5QC
 V/Dvj7ODSDEsohFNtO14yt1OplCxE+MVflQMtxtEr1pTIPFKH7Tn6K5w5hF8Qxyj5YoLearg5iTTX1
 8D+LnTNTaPKI2QKUQt8QqebBWSeyTw24FLNPRpn4wfQ1aStwtUUXEJzlp7J/zb7icrsBXBSYicmFE0
 FIJfsxE9o5oJkXGP25MnVQoIogdmUzVPWuMGAbZ1qITZOxi/El+6gC5D3azmYMJ62ioj4rWLy8TngN
 K2c8cElGsuO/QnqfNBSvUxITecp5Kv
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

In preparation for testing GCS related signal handling add it as a feature
we check for in the signal handling support code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals.h       | 2 ++
 tools/testing/selftests/arm64/signal/test_signals_utils.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
index 1e6273d81575..7ada43688c02 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.h
+++ b/tools/testing/selftests/arm64/signal/test_signals.h
@@ -35,6 +35,7 @@ enum {
 	FSME_BIT,
 	FSME_FA64_BIT,
 	FSME2_BIT,
+	FGCS_BIT,
 	FMAX_END
 };
 
@@ -43,6 +44,7 @@ enum {
 #define FEAT_SME		(1UL << FSME_BIT)
 #define FEAT_SME_FA64		(1UL << FSME_FA64_BIT)
 #define FEAT_SME2		(1UL << FSME2_BIT)
+#define FEAT_GCS		(1UL << FGCS_BIT)
 
 /*
  * A descriptor used to describe and configure a test case.
diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index 0dc948db3a4a..89ef95c1af0e 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -30,6 +30,7 @@ static char const *const feats_names[FMAX_END] = {
 	" SME ",
 	" FA64 ",
 	" SME2 ",
+	" GCS ",
 };
 
 #define MAX_FEATS_SZ	128
@@ -329,6 +330,8 @@ int test_init(struct tdescr *td)
 			td->feats_supported |= FEAT_SME_FA64;
 		if (getauxval(AT_HWCAP2) & HWCAP2_SME2)
 			td->feats_supported |= FEAT_SME2;
+		if (getauxval(AT_HWCAP2) & HWCAP2_GCS)
+			td->feats_supported |= FEAT_GCS;
 		if (feats_ok(td)) {
 			if (td->feats_required & td->feats_supported)
 				fprintf(stderr,

-- 
2.30.2

