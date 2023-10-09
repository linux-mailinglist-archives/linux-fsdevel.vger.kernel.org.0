Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A417BDABB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 14:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbjJIMLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 08:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbjJIMK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:10:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0A1F7;
        Mon,  9 Oct 2023 05:10:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26B1C43395;
        Mon,  9 Oct 2023 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696853445;
        bh=pFAvrTvTUMO0xGKH/cMXrv1R9nlyUOOKoHgSKri2XFo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Wvv+8fQiJLsDyPC0NnM1Q8ZyuLIaTwYxmV4/n6iYyTSFm2c3s/lXYiIujtfqegWR5
         i+6r97yeEFEr4SuiSg43kWLmH09n7ZR/ZCXoWJasjIzJx+djDmQqsidBxXjLgKIpdW
         USEzih2i0SA+mKWoVY+bWCbYYsuCJH+HUplm5UojKv0lL6UF4DGA5SDT+CacuA1WA4
         oSm8tkPSZp0qife0Ths/W9nGm12sWcn2q+T/WK1q5JrOai/DPDX9Umpa7nqzfrVypG
         J6NVP/nkQzGEuN9PqjtaHLmak3br43uZpGnq2WynrJw6MMDSVcTWuk4mRX6DuUaqiF
         +7pCIfTCF7+SA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 09 Oct 2023 13:08:35 +0100
Subject: [PATCH v6 01/38] arm64/mm: Restructure arch_validate_flags() for
 extensibility
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-arm64-gcs-v6-1-78e55deaa4dd@kernel.org>
References: <20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org>
In-Reply-To: <20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org>
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
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pFAvrTvTUMO0xGKH/cMXrv1R9nlyUOOKoHgSKri2XFo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlI+2RRGngkj18F3uCpZZfRd1ocU0q8HRquWAvC/i8
 MLyCK6+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZSPtkQAKCRAk1otyXVSH0IgWB/
 9nEEL548GJxcwR1LGdSjepOH5kHepxay1tzf82bn7l9zh6fQGxR6ix+aOPOcIC0mVUG3uBo/OqUafc
 JHsz6EEkKKkT+8LEz51beTFl4qVhh1Ow5Rk0OEWXlvnnu8ZQObqqFwMY0PNRfSmOtzpFrAOF+7cpg3
 Sj0Yycn8U5ODSu3bIWtjprRbW0HeaYkWpU1J/rMGOVpT+VVlXY/Tac108UyzCQmmIro7sCHuaLNBpW
 UxSMVsEAelZ5K94QPG020QQcQvtmVVBOG1zhZOUIWPgeZ9WuB8xrR237xwNy7kMbaxY9AWSb7Jaazz
 bt/kuflV6ao5nlq/P4VKE/AulNOgZm
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

