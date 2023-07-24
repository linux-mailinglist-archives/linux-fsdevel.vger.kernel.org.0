Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DCD75F6E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGXMtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjGXMtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA72E77;
        Mon, 24 Jul 2023 05:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA0FE61166;
        Mon, 24 Jul 2023 12:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE72C433C8;
        Mon, 24 Jul 2023 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690202882;
        bh=XgAXaxiI+LNUcKtRlH2zykI6sDdksLTFFqJ3d2DlV6Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QGcM4fnx8swpQgYlAoCdgwpYJMLiVk400mojxwsQVLI9u7WmzRJGtjcGmpf1rONDi
         Xtl0CNWv/G1fjwhLgbOmsjdZGuyrmwVKXp/5dm+/vQL9JmjprgmAxj1w9oVlZOaTTX
         ofd0nIM5qeZ3BWWsFtmVr8FT6ONga/FRlNL+mdbnCRYlQGpV05t1flnZD1i4BKnzO+
         nuShnz44zVYhXhF38ilgLT0jabJMYVYktsFVB4G3zxi1wzrt5470MePGh4sNQ8PIs1
         ck/eqVSuihlN6lGd64GLZFrREDPRbgtoDzTm5R3dJtKyDCT2EkNa1yntyc8ts7GnJs
         +XXpha8iGolAg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 24 Jul 2023 13:45:57 +0100
Subject: [PATCH v2 10/35] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-arm64-gcs-v2-10-dc2c1d44c2eb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XgAXaxiI+LNUcKtRlH2zykI6sDdksLTFFqJ3d2DlV6Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvnKOdTEcLahkBp5IvWyRhmcZw9T/1AqgLdEteVGJ
 Q6Hg5S2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZL5yjgAKCRAk1otyXVSH0J4CB/
 9rhqw0udDoYi8sudj/nInZ2l8ch9RyA2y9LlyMnS5EK2PCPsTlwwDG8zCkzr2Jf//EF5g3JIkU3F+J
 XthObw2KIyQ0tYX6oE97ECWKXNidZz8FppyIjF+x/kMI9CeBzOqWvEPh8t2unhLhgWVMqR8NmNMypi
 pnXvc7tLLYYFLfJFYfdsQvaEhlRbAwtAxBJi3WlKEUh8fGTnLU004p6Csd8bW3V2rkU3ApTPpkp51M
 asuqbjt59yH0eTxwGOfrL1qj8Lui/gvJDdjlwnzphEwC/rwfKQhcy8Chgg/9rRm/hQrcawBHad4rWx
 dfQezidZRepEyWt91teiL0228x6T8k
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
index c57c5030ef6c..c6af8daceb56 100644
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

