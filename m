Return-Path: <linux-fsdevel+bounces-3373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76F27F4220
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E591C209FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E855781;
	Wed, 22 Nov 2023 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhF0C8ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955516407;
	Wed, 22 Nov 2023 09:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041B7C43397;
	Wed, 22 Nov 2023 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646262;
	bh=Df+HY0dV5R5n1ih4MqR1JvyrE5qdgwZR/dZq7PG88vE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DhF0C8obSjt9Nfr4iuhMF+MfrBzvOMHkq9LmVgyYKZnO9fIVLqs7HPAS+n3JPEKJ0
	 dLQEv4IqHz985M/9vF5RA3TEblITjIIzbNMwRKx3W4AeIrzRpwLIpvKWycDupEWd4k
	 HDnsgVbJ2E80hUb0HTiGD+TfDklzJH8Ma+jZ6ZDSObz510LSGSdIjpW/3G98VBnzUv
	 DxrYCGKBYiovBFq7e5dPgwWVI3DxTMzU2LE/Db2CvFUUPnnfx59dYtoZlztgKFgZdC
	 Xnv3q15QP1P/yyGxaz73jzcQ0IOLjraOoSEdX2zUMo2fgiDmta5EVVRM0eoUCmP1lx
	 wbCpNkVqokZ9Q==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:22 +0000
Subject: [PATCH v7 12/39] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-12-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Df+HY0dV5R5n1ih4MqR1JvyrE5qdgwZR/dZq7PG88vE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXcz/qzN33RRp1sMMsdDeIWGemytfZkpPWLo4a
 cwQK9wJLbWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3M/wAKCRAk1otyXVSH
 0CJlB/42DNRC926QZda7ZgVHwYfL0gTMCpMI6gcouqu0xgA1HTtwNrwD613VnSOoyxtfTGVzCMY
 tsVAy8UOqNqRN6Dz4Zh0A+WmkLl1I5GdvGmF54We0wD2eSV5cLIVOIbdhyzcHObAzfkNwcd8LZV
 xX6x0wVfcf5dhIKnwCSx7NL3qmoP/2RuVklEW90UpGYkcYj/L3FIb/kydQwjinq8/NYa8ybu2FI
 iPgL35MV+Ppu4QMvQxgI4+09gl+0XIjyeFDoigRWiF/oIFAz8r4t9jdHMwTU+YpNFLdNthAWQ/S
 faocMmU8q7Y6bz+9r3UGqczI7+EUjPo4aNc0Gwlh0vqeaAX/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Use VM_HIGH_ARCH_5 for guarded control stack pages.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/filesystems/proc.rst |  2 +-
 fs/proc/task_mmu.c                 |  3 +++
 include/linux/mm.h                 | 12 +++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 49ef12df631b..1dfc5cb20f28 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -570,7 +570,7 @@ encoded manner. The codes are the following:
     mt    arm64 MTE allocation tags are enabled
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
-    ss    shadow stack page
+    ss    shadow/guarded control stack page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f0a904aeee8e..29fd7d6fbeb0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -701,6 +701,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 #ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
+#endif
+#ifdef CONFIG_ARM64_GCS
+		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 	};
 	size_t i;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8b28483b4afa..3c96fc6c1128 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,7 +352,17 @@ extern unsigned int kobjsize(const void *objp);
  * for more details on the guard size.
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
2.39.2


