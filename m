Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7AE75577C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGPVxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjGPVxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476FDE57;
        Sun, 16 Jul 2023 14:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E1460EC6;
        Sun, 16 Jul 2023 21:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852F6C433C7;
        Sun, 16 Jul 2023 21:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544382;
        bh=rwg+AaLrST64GPi/dleRneXGKtoIqRfwuUuxqMEvRY8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=UgtraBJIty53nrQbpln20X+ZgVVvVELrRtvAd3QMCrhZZLG55JU40/WRKPzyulIdC
         rdaTs7g0cGf13IEO6plkV5jWgs4u4tUGQRUFb5f/AeXP5SfGfRw0tYRLfzzgSw4dtG
         KtwongQnS58FCtWJ0962kRMsMbeN2Qn9fsmL5Kkkot6uH6w79KuboVGwU8n+84WVcY
         eRR3pYAnAajGivQocVIeEN0cuXoC0qluSb/xC6LqxKAIDzD6bRG2MLIR9U8J/EKH0D
         IJSZ/fzQSra/qECPc29Ob+7i1aufZgNDfzPrEFxMKKU8nRrIHTidvx8ycUaL8qHEWP
         IpAj+kjOE1FBQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:50:58 +0100
Subject: [PATCH 02/35] prctl: Add flag for shadow stack writeability and
 push/pop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-2-bf567f93bba6@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rwg+AaLrST64GPi/dleRneXGKtoIqRfwuUuxqMEvRY8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGaQrba4c87fXI/DIs9b8uMvYL0mZkMhwI/2a8dl
 /uECOa+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmkAAKCRAk1otyXVSH0Mz2B/
 0Qse7s2seNh0TDAnfYabaiAlsKHmw1NQH/pAIsYkJNq1lwhtVLDvni0GlFFI5Iy4xaXcvNqYLflNIN
 JB8WxsYfarT9t79wGVEVsXLhN+//YY1W7vIKO7J4qV6OS2zy6xDzLqKUegxjSm1ZzWrLAUmxVvhRTn
 rdAoifqTz2kttVaBZVk3b2vjudnWDDO1+MV/WXlfbytVw59XLti4le9LkQpNUou/8h3n87mJ3aderr
 ghHhsnAWYpe/P3JeZi2bHfg9prLFsn0sN6umDfODDRdURGFtk7VPJR/4qEHIpbPDzgcun6Q0ENfn3D
 fgvdczW1gaU0aCK0NKAnMefJZ1CwOA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On arm64 and x86 the kernel can control if there is write access to the
shadow stack via specific instructions defined for the purpose, useful
for things like userspace threading at the expense of some security.
Add a flag to allow this to be selected when changing the shadow stack
status.

On arm64 the kernel can separately control if userspace is able to pop
and push values directly onto the shadow stack via GCS push and pop
instructions, supporting many scenarios where userspace needs to write
to the stack with less security exposure than full write access.  Add a
flag to allow this to be selected when changing the shadow stack status.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/linux/prctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 9fdc77fa2bfe..e88d2ddcdb2d 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -321,5 +321,7 @@ struct prctl_mm_map {
 #define PR_SET_SHADOW_STACK_STATUS      72
 # define PR_SHADOW_STACK_LOCK           (1UL << 0)
 # define PR_SHADOW_STACK_ENABLE         (1UL << 1)
+# define PR_SHADOW_STACK_WRITE		(1UL << 2)
+# define PR_SHADOW_STACK_PUSH		(1UL << 3)
 
 #endif /* _LINUX_PRCTL_H */

-- 
2.30.2

