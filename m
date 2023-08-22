Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC067842FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjHVOEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 10:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbjHVOEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836ACF8;
        Tue, 22 Aug 2023 07:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 134AF657A9;
        Tue, 22 Aug 2023 14:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719F4C43397;
        Tue, 22 Aug 2023 14:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713051;
        bh=38AeaFL37vV9MyUQ5JVKuM1gVCMvtkdVnDbNL3TTQpU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=C2V2h4ZMUb4/yIQ3iF4pkkKKmtU4/E6fRrZuRXM33jlq1hr6SN6ejz4mxenV7X1Jr
         U+onmrTsLfkkpQpaEXEcyrvLP7fzgiBNoMxosAkMImE34jQmwD6Ovlm1y3amxqUkzl
         Ll5vlPk9amIBHqRAoBgskyZpEHxksqC5DZc4Z2ddzNvSLHgEmsnd/05/wV8+N4fIUY
         fcX4IKHMZnMKseDwZyVhqt5QNo6S8CbTvRamNYyrPI34PQd7ncLiXjtoHSkKiycL4i
         3dxx3GftFphs29Eji8NRk+6GlXTRp1SCoC497PbX7DRl6mdzlnlG8nlA7V35Vi+D/l
         Vjt7r4Fdh0gsQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 22 Aug 2023 14:56:44 +0100
Subject: [PATCH v5 11/37] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-arm64-gcs-v5-11-9ef181dd6324@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=broonie@kernel.org;
 h=from:subject:message-id; bh=38AeaFL37vV9MyUQ5JVKuM1gVCMvtkdVnDbNL3TTQpU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk5L/4ZJsqmGb1X2dCbItsrFTFc1P5N8xGgUrelX10
 oTah15WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZOS/+AAKCRAk1otyXVSH0PF5B/
 9luG6SSt9+4Y5FAc9atvniGOqSRYcVxYKP7QbUR1Sq1iUJjqg3/M4Wn+CX4Nv22NQDpAWlu9HjbZ90
 YxMRnOcaSD2lEoY19Wkoa7c+YXPo0XWzyI4CHMmNZvnQlyMAN5j9GdxHWbAOSNUT9nSPTxtr5KfhjJ
 ISoFniLihLHatV5qsS5JtyyHveV2BDxmv1yFDqw27OPnIdbojwQKMIxZ7eqmZ6qrC37tXHw9kHsZTT
 ZbKlr0egnDADq4BrX9prP33ZB7tiKZUrucZNNfYqmMNS+ccDZecIaC+utmvHrKQsr8827KFAuqN/wA
 Eyog4Ods4IOsTYqB7mmP0odn37Dy+V
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

Use VM_HIGH_ARCH_5 for guarded control stack pages.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/filesystems/proc.rst |  2 +-
 fs/proc/task_mmu.c                 |  3 +++
 include/linux/mm.h                 | 12 +++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 6ccb57089a06..086a0408a4d7 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -566,7 +566,7 @@ encoded manner. The codes are the following:
     mt    arm64 MTE allocation tags are enabled
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
-    ss    shadow stack page
+    ss    shadow/guarded control stack page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cfab855fe7e9..e8c50848bb16 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
+#ifdef CONFIG_ARM64_GCS
+		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 43fe625b85aa..3f939ae212e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -372,7 +372,17 @@ extern unsigned int kobjsize(const void *objp);
  * having a PAGE_SIZE guard gap.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
-#else
+#endif
+
+#if defined(CONFIG_ARM64_GCS)
+/*
+ * arm64's Guarded Control Stack implements similar functionality and
+ * has similar constraints to shadow stacks.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
+#ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 

-- 
2.30.2

