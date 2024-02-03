Return-Path: <linux-fsdevel+bounces-10156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C18485B4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024D51C21A75
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC21160EDE;
	Sat,  3 Feb 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ+FVrta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A315E5B5;
	Sat,  3 Feb 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963455; cv=none; b=BgLUkyZbeu0TYYGFR1n6Wh9+u9JNNRQPtE+mjvUSHy3O8nuK5zGcB/9YnlMKH+USWgyHS3JnmrhYwSwsr9rm/cr8UuYEgWQxk2ulyzVXzOAureaTLgk6zviplRJiKte87NqBh0pmUgm85+a5CmNPjqiDzIQfmSxQ7a8nhXJZQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963455; c=relaxed/simple;
	bh=noIMiNXXaRbZmSrB1LMm4LQSI3w8gaJJhGiAy9NbIgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XN7FcJzNfKYDK2SxHJozTdfUtwYbYhtIqFnosku5tTOnVXmVnRZpV3yHxQIqpITmdjr++/HOSGRG5I7yDaWk124XQDcByVlsWNoXij2S2imXfZ8Ou5/ilHgObvo4VwbAVQztbzBmPOr+hCqe04U5RsFXyfcWVjbnINCMWWxr8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ+FVrta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBDEC433F1;
	Sat,  3 Feb 2024 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963454;
	bh=noIMiNXXaRbZmSrB1LMm4LQSI3w8gaJJhGiAy9NbIgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nZ+FVrtarYuPfV2QgPHzVDN1mdXXrUA/eCIkI0+jD+9lmq8AK1SrIHQkP+okJ5xIf
	 Nrtap97nj/w0mCOq2XBkzeEft1WmagOP1qx9TFRd7EBruLsj53cPf7oLI70WJMf2MQ
	 dMWZcj6emLEFTlJCV/Yxh7bjw5A6lQLRrkdBfnfN/U4F2NkeGs3HNfZoP1yPp8rSJL
	 VlptsEVCXxOwPpctcB+HH0ogyB4/oAE/pVEWNyqU0lHP8t821iVQKCaDfz3W3uU9m5
	 AOL2G84ZrXkvUQOBBwDNufzWgILEjqVWtfYDLJgzCbrfg21DlUhhzOPjJVMkEgy4Fh
	 1cwCvG9ZSMVbQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:37 +0000
Subject: [PATCH v8 11/38] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-11-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
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
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=broonie@kernel.org;
 h=from:subject:message-id; bh=noIMiNXXaRbZmSrB1LMm4LQSI3w8gaJJhGiAy9NbIgk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDZ2Io6GgPo7IKBDhinOWnY04tvqYzF/2M4PbR8
 tBVQvoaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w2QAKCRAk1otyXVSH0FoMB/
 489Ce9yGOrMf8qmH57w0iu49g2q5ScfPLlvHIGHqIG2PImWln+Xihqvl1m9KbzdISpWJxeNsTTO2XF
 aJDD06/nq2t7tQverEzEP7/LK2GVlDIYoue95rUKVV2+43+ztP2j03uGGCbBzlhTZphrchLv+3O2ul
 +HEP0ncnuw1ybRxXFNlo3BHi/OXXeFTRf3CYFPyr+vcf1TxJd/SCdsXeogobq3zH+dHSWskU+6/doU
 tTsPKvaiitj/K4V2ScTqfmaf40lD8CCSQszd9G5pPMgQYd9N2FC6aVOoLa9MLanU9pHtBoiWh4Tnew
 iIOq6LPE9HIfe5k2+L9fZIvT/kWhuG
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
index 104c6d047d9b..0392c3b74650 100644
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
index ff2c601f7d1c..fb0633d8e309 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -702,6 +702,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
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
index 0b1139c5df60..6cc304c90c63 100644
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
2.30.2


