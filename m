Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3916076982C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjGaNwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjGaNvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046DF1FC4;
        Mon, 31 Jul 2023 06:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 662BE6115B;
        Mon, 31 Jul 2023 13:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191C2C433C8;
        Mon, 31 Jul 2023 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690811493;
        bh=BppDdcqjtJzUfuzafP5lgvHCeya4NknqM0BAXJ7ap7w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=khHWcmOuBjaxE6JfX6GKCY29ifsNWk4hwBIAjFtpU0ZtoFnNnO8HiOedg/p0qOS+X
         QjvPxW7wdCDJ0bV8bocXa05z28tQRD5qC4cFot7/G6Wfk+xgFnSWI+YrJ0NxGhUhzd
         5946m10rse8O7jOZXXbv+bi4k+tJIL8D8PP/zZJrecrTo9/aj6s7j8bYufzh3fCH7K
         PMyf1ypqSVvSaFDjRlqwjA7yAx+B4+SMjsDTDSqQlY0NkwQjLQuM02V5ei14rww0Yi
         0mPL6O8tAmmPckdqBUeFaxSCb8XvkuMs02vXYdQBdPm/dd5DDKRtOuQ0lrc5S86gQO
         IMaMlrmbjBYeQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 31 Jul 2023 14:43:16 +0100
Subject: [PATCH v3 07/36] arm64/gcs: Provide copy_to_user_gcs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-arm64-gcs-v3-7-cddf9f980d98@kernel.org>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
In-Reply-To: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BppDdcqjtJzUfuzafP5lgvHCeya4NknqM0BAXJ7ap7w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx7wZKQDFG7EFJkc2bMF4eSCe/iZHqCnXTSHwFYE6
 WnETetqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMe8GQAKCRAk1otyXVSH0CjAB/
 9j+3rmzIjlTy5tKEIChK3iUWQnC1T22r1pFnN8c4M5Nd8WsaibvRYbBF3EbhUZyJQdmsvQpZeY5AJ9
 xiHNOnUw+b+9wwioD+caREB9fc5TaEqYGg22UEz786dKDsCbB93fknph1PD0ZW4CnqiRRvboDNuf9f
 +zfadgAbTpHSArpqN83t6fsLk3mVbGb8owzBVY+WoUxUIk8Mun3G3aQV1Xy5ArSNe0Swks3x9a9xb2
 dwVkdmtzGhd9ihuKD1ex2bjSFy38IQFidmvngCD/KC5Ws4H8zF110fSGWDzVJ1ivGTpLOecnPtkBKv
 Mf0goLJ09W8M+KNU6Mc0G5FsKGd5C7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order for EL1 to write to an EL0 GCS it must use the GCSSTTR instruction
rather than a normal STTR. Provide a copy_to_user_gcs() which does this.
Since it is not possible to store anything other than a 64 bit value the
interface is presented in terms of 64 bit values, using unsigned long
rather than u64 due to sparse.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/uaccess.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 22e10e79f56a..24aa804e95a7 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -445,6 +445,26 @@ static inline int gcssttr(unsigned long __user *addr, unsigned long val)
 	return err;
 }
 
+static inline int copy_to_user_gcs(unsigned long __user *addr,
+				   unsigned long *val,
+				   int count)
+{
+	int ret = -EFAULT;
+	int i;
+
+	if (access_ok((char __user *)addr, count * sizeof(u64))) {
+		uaccess_ttbr0_enable();
+		for (i = 0; i < count; i++) {
+			ret = gcssttr(addr++, *val++);
+			if (ret != 0)
+				break;
+		}
+		uaccess_ttbr0_disable();
+	}
+
+	return ret;
+}
+
 #endif /* CONFIG_ARM64_GCS */
 
 #endif /* __ASM_UACCESS_H */

-- 
2.30.2

