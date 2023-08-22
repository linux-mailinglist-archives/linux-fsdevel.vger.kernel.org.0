Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAAB7842BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 16:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjHVODO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 10:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbjHVODK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A7CD5;
        Tue, 22 Aug 2023 07:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E90465726;
        Tue, 22 Aug 2023 14:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9638EC433CC;
        Tue, 22 Aug 2023 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712987;
        bh=pFAvrTvTUMO0xGKH/cMXrv1R9nlyUOOKoHgSKri2XFo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qTm9XTGvcYh+Br8eJUAeGbO/I6+6TObGxYTwfAxErZq7Ntyj+r+ZjZ36mVjjS7fby
         MGJHkozGMXiQgElJ1L/hdHWK5jS6K1IdwfgG9KFB0cPquHiAoreyGmmIaE94d5auZT
         rjpYop2VCduatHJPECR0bjHwBO9GubtNMy0N/6iGoLAWZEN1/T1a/pZ56+uoTSGifm
         wnKHoGJpjPpQVFEbG7W8LrY+Y/HsoFR9s1p6c//axRtaZ4h28qBqfFbSfM57TLqGYm
         bBjhEAgEE4xe1eR1F9baQN7ZtJmG9EQIaDzevsFHbvH7o4lc5g6GpvtWWOhLpiaI8I
         5jsTDl5jo/oGQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 22 Aug 2023 14:56:34 +0100
Subject: [PATCH v5 01/37] arm64/mm: Restructure arch_validate_flags() for
 extensibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-arm64-gcs-v5-1-9ef181dd6324@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pFAvrTvTUMO0xGKH/cMXrv1R9nlyUOOKoHgSKri2XFo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk5L/wf8ItiVhhsjU1U1pKaopo/uh7rIWP4I7WMtBO
 inLmxduJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZOS/8AAKCRAk1otyXVSH0AV6B/
 9NgV9lhw6oHPGtixcm5V3lAr7z+o9fWsFcBTBXWxSurUlb0XFjc+t7fDH7SvXhVDsM3caWcvDpNysc
 rUzR8kRdWUsc2c9LvqoaTcUMfW7SZ4LidddLAhjU+PCa1JGQoP92n9jN6TStbJ85YIH9l9KVVshmVZ
 XiPc6ANN4NmBzgKj9JGYlITGz4YnTicnXsOeD1e2p0e45JZx9f0hBIkU/lKRzsyIRzwpsY90K00Qz9
 YGG3gusgb5P00L14xVRHrVAbuNMepnYq7a4rPyLGjenQCUiv8inCi9K4DWKE0JohN+V9sSbORNNply
 wIdHzUINXrAPZmj+TfHarlSM6uY9B7
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

Currently arch_validate_flags() is written in a very non-extensible
fashion, returning immediately if MTE is not supported and writing the MTE
check as a direct return. Since we will want to add more checks for GCS
refactor the existing code to be more extensible, no functional change
intended.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/mman.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 5966ee4a6154..c21849ffdd88 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -52,11 +52,17 @@ static inline bool arch_validate_prot(unsigned long prot,
 
 static inline bool arch_validate_flags(unsigned long vm_flags)
 {
-	if (!system_supports_mte())
-		return true;
+	if (system_supports_mte()) {
+		/*
+		 * only allow VM_MTE if VM_MTE_ALLOWED has been set
+		 * previously
+		 */
+		if ((vm_flags & VM_MTE) && !(vm_flags & VM_MTE_ALLOWED))
+			return false;
+	}
+
+	return true;
 
-	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
-	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
 }
 #define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
 

-- 
2.30.2

