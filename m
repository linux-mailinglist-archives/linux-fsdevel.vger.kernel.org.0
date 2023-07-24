Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C904275F6D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGXMsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjGXMsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7A719B3;
        Mon, 24 Jul 2023 05:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A5B6113A;
        Mon, 24 Jul 2023 12:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDFAC433C9;
        Mon, 24 Jul 2023 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690202863;
        bh=BppDdcqjtJzUfuzafP5lgvHCeya4NknqM0BAXJ7ap7w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Jc4/plLJv7KYhQYVKckcQWOhhYiujYOQTa41utc9aW4Cpr99u0i4Rk90wl8V28aqY
         4vB0Ip/vhexWo/OnchyZc/oJQDlGKty8KiYoskIPPFsirPZ/W7ArTF+IfcY3BV+QhF
         lLqGWKC3cLAyPfIpmGz/0P5RjeQHmc/NKaTEjz289ovvafHa9DRC4p1aQojxO+It6y
         1u5IPnbo+1Ir+8+5FoOK0iuccBV7tCljK/ncbi1C5j6ooQa6A8lMqn41g1Kx7t5clW
         1rOiiESlmTRz6HUfJS3lZFKUbgO8NSo+bILf/ipUUnrDraHP1HMxMjGggwGxb5Ch/C
         QV/1AO/rbKb3w==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 24 Jul 2023 13:45:54 +0100
Subject: [PATCH v2 07/35] arm64/gcs: Provide copy_to_user_gcs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-arm64-gcs-v2-7-dc2c1d44c2eb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BppDdcqjtJzUfuzafP5lgvHCeya4NknqM0BAXJ7ap7w=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhpR9Rd195ox7IqUD6pIltzCHNsX+jjS5e0s2dtPkAMYPWaKN
 wa6djMYsDIxcDLJiiixrn2WsSg+X2Dr/0fxXMINYmUCmMHBxCsBEvp7kYGitcf/AXWglHldUWygtdT
 y4cWNmh7OzfP6Dhoff5QUK7Oc1yH2Y9u6HB+exNJ0bOVxV1/V+XXeX2z7NclNxZ+S1l6waK1cWqktx
 eXx+d05N0J+n80exesCnPwKtpWzLnDx10j5zuF+3KZ/fnH8g7K/h8yTB5/uWJSgKWIR2sCiXbX/IP/
 VKUtKzA5o9cxj2hF0IfrfWc9Oq327mhTxPMo/f1naICZtmk8wqe6Z4qZjGlO8t+3+IrpsWcPSV/ltJ
 ze/3jmqK6P9fP6lCevXZhMfTH9/un3Ts454nqlq9kVoSLvmfjGWTFq4Jy3Z+tsuP/8iKDdV2NV8v9T
 5x9fwXo2wYINbppXcvcPbjA9eiAQ==
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

