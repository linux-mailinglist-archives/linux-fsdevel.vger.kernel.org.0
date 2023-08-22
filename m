Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6A7843D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjHVOUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjHVOUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B571B1BE;
        Tue, 22 Aug 2023 07:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B3C664451;
        Tue, 22 Aug 2023 14:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D76C433CA;
        Tue, 22 Aug 2023 14:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713158;
        bh=Go+3eKanODPQVKnV1QnMIrC75/lXwO2PkPnkMfOn2oA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gP9A+b1HzhHJiT1F4bdDZzJB+Kw0p+eXo0v/P+dPIVFOsxYSgHcC0CP9RO6rXtxWR
         hMKxtPAnwCepSywokGXiKPaFD05t8txpPLEP64kXEVWLBqUvUjJRy9oUPmIFRia1r4
         b+uutZgItL7Z5SFOuIQynsUG5fILGtGaqNntU04ub0rJ3bQxNrF8WprpJzNyzlFdv6
         /9lRarB/6pp5xQ2/ef9T8/uTNBwOqyVmBimCA6JBAfH13lvzeoPZf6jkVFTEZBUM8/
         N/VijmrLALPIiriMal7i4Ilox18fjOQl0dhXD4e/jA75oFmKWm+RhgrRKFkQLUQTFa
         32TBOYqFOhLzg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 22 Aug 2023 14:57:01 +0100
Subject: [PATCH v5 28/37] kselftest/arm64: Add GCS as a detected feature in
 the signal tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-arm64-gcs-v5-28-9ef181dd6324@kernel.org>
References: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
In-Reply-To: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk5MAFQYUTz//x5ckqwC2O/FhWGiN1vKBvthv6xsqS
 x0RUTwqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZOTABQAKCRAk1otyXVSH0EgYB/
 93+Qd6TuAOmA1X1TNTKSnDg5urc26kXvTXggBZyppzFFhBTKiFjvBnXDxlq6IbK0FnJIHL9Stz+fqh
 MTf6riUSqW1bQkCHuGFXXtKwq4P7Nv4qAeJOXoj2gtuDfnQNzBuLHvewcxbyUpaH74WocVn4s5k53F
 a29PA6NMFb3UsfeH0k+h3WehfkJe6ph8o7uHn0h2lgRjEfWdN8BFLOsY69BIpulERd0AToy1zxOVlB
 1vMEq71vTGn446QjiJPAR5nDEOxfYBU3KUcsTUOUMCWPYHp+hYlTLMcF+NeKiLoqv1/4I+NKaD0NO/
 xNrl5pV/0cJ8ej3Lc5v+Fxqw7JOK9A
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

