Return-Path: <linux-fsdevel+bounces-24761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912AD944C18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EE11C25C90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202281A6174;
	Thu,  1 Aug 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMtPH0QQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50F1A0B00;
	Thu,  1 Aug 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517122; cv=none; b=PqZLqW3Rj/B7Rv5XyAwM+H9bzIhESXJ4PcYOoD5Nd9l/036k9UdjaLCGNeaCeD9ikvVU02+ZcrYr2VTJJFbmtm7aDLhXHylJLJowchotGJ5nx7x0k+HutGJ861hPuq+S0j1VHVdZ36UC20nBQJWLtTQ0q3qxbXBJHmA9IPayBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517122; c=relaxed/simple;
	bh=yrclwp0293yC9GB/YqBAfQERM0nqbhUl6FyE+eoviK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pS7K2ypTL+3b9wdfnipnR7N+gg19Bdj6WoPL0jEBpoZ2CB+S3Dawq3CKfcV/8TiDQ89dHukwz5IpsMskn1e/OX/+TWNUFrjgWin3uDMyYkayShyhp2ASV6qlX98t4z+C1iBm4mjG4uaIPC6wUblIktaiWRlkNWNuhOPo+q4zAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMtPH0QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC6DC32786;
	Thu,  1 Aug 2024 12:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517121;
	bh=yrclwp0293yC9GB/YqBAfQERM0nqbhUl6FyE+eoviK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OMtPH0QQtyjuzyGFLmvxodnUhI1RcowGJgcVcqpXjp4OIMCKEYXxKeS0Zloiu6ACe
	 7Y0zfhO07G3VFrL/o+SIq6MmOl0CJLDz3Wt6U0/2E55zxehJVMzg68p8qQVBCwdKiZ
	 anTd5o27Tlj8IjZenRvzKlL3K8DnhbnStCp2mm7Aj+m14jz3gCWAaY0P1ghrYK8ThN
	 sZ0TjouWrlUahzC6QOq8d3RjUdUdVoo6Dt9TxzB077E65bzGk5bzRo6b5CF553uAV/
	 6ys2f9aLFBLXha2iCi5+SRM03qQNBGQHs4Y6nVLW37PCjew/gusoTL2CruWyy1GzK8
	 6+IyQV6Ac1uTQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:39 +0100
Subject: [PATCH v10 12/40] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-12-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yrclwp0293yC9GB/YqBAfQERM0nqbhUl6FyE+eoviK4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YPVQ6/NKZ2FgJD9BDBgenwO3uVt2vwx+JEk7wS
 a+dSp5eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGDwAKCRAk1otyXVSH0PO9B/
 9FjPI6PZJke3DvcVt+TVF5+jjcO2FhunyyoZQBXwVwx0e14Z0TzTQv+M+eqDtAdVaXxEw+nVpGUhKj
 Rzyuud84uh5DfziIcGXe0HGokGGysRLk9OSG+dbJcWvI929qOFL/U5T2T/nCAnz61Mop8929qqKQFV
 W6vCejrk+xyxch2pG67qESCQw8vVyb6VAx2Z4PRuLxokX1bbhCX6+vRKt8Fv1dw01bV0RUfa8/6NsL
 vrLpbU65aCMhK4yG3IA5211146YV98aCoLl9L2ka2dgkMxupbf+n9aISI9eXd5SlWhJZBx2craAReK
 S2fhv2FZ2s1iixEVEAAABxmUNJ0aCK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Use VM_HIGH_ARCH_5 for guarded control stack pages.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/filesystems/proc.rst |  2 +-
 include/linux/mm.h                 | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e834779d9611..6a882c57a7e7 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -579,7 +579,7 @@ encoded manner. The codes are the following:
     mt    arm64 MTE allocation tags are enabled
     um    userfaultfd missing tracking
     uw    userfaultfd wr-protect tracking
-    ss    shadow stack page
+    ss    shadow/guarded control stack page
     sl    sealed
     ==    =======================================
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 96faf26b6083..c6c7454ce4e0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -353,7 +353,17 @@ extern unsigned int kobjsize(const void *objp);
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


