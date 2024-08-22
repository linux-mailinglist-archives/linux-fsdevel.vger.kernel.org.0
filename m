Return-Path: <linux-fsdevel+bounces-26612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C695A9AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732F11F216B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEDB1F94A;
	Thu, 22 Aug 2024 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIhkv1vX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348C381B8;
	Thu, 22 Aug 2024 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289525; cv=none; b=QFFw/m0DoDr/rGkX0iWRu7MUwDYpPUkHSx3Ir+GaeA6Sqzd5kdSjPJObVAds9PSJ32rJLKTdWILOZpr4VzBds46MnedGzMtMestA4nFjPXXtJ48VCVZbLUw/oma73OwK8QaO1bPnlyTKAM1BB0qlXohY6mY10TmYzsBV2tPug1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289525; c=relaxed/simple;
	bh=yrclwp0293yC9GB/YqBAfQERM0nqbhUl6FyE+eoviK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUacKnk/eEALKMwTq6BjAGGGSvYMvEx3shAlhmG5wTGjeLMVeEkabk6JsAcRBzZ30BpMslwS5bJY6Va/weONHD1FYzDMqpbOCOWNxRsqHrXNpn/WQRSUMUfUBgywmaKPOTTpIXz8KhNOa3Ns4UISq+WEaDtc+SmxhzusFxy7Ffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIhkv1vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38943C4AF1B;
	Thu, 22 Aug 2024 01:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289524;
	bh=yrclwp0293yC9GB/YqBAfQERM0nqbhUl6FyE+eoviK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iIhkv1vXoKilgfdT7HIpB4HOZs+tLh/vFixxXmDjlkcZOklxf/MPAb1ew2Z8s+pEO
	 K9riiigrezQbjBZf8OrNt0pyEivoy7GtrdMSX6y0Us6jX8mcNcwIK9j5WlwlWY9lzv
	 9S6HtvWiw521yHF7WXQqdK3ML6TOBXmemGFmJz5w0fw2XxoBIa1ATqkCrGr2BOtarC
	 /7OLDWVT2kesr8q9MRXPrTLBgRBmVqM0sEgSvmnaDJX8zD5MuSNC/SJ8rH0m7HfBsN
	 GkDTr0PYd/Ak4qlnOiyZ0YVy9OaKQ4GOS0r6+3mFU1Se+kyYOQLFzkJe89yh+6kg7Z
	 pRi2X/R6uve+w==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:16 +0100
Subject: [PATCH v11 13/39] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-13-41b81947ecb5@kernel.org>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
In-Reply-To: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yrclwp0293yC9GB/YqBAfQERM0nqbhUl6FyE+eoviK4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEtEhQ9d687I7aOExxok/8WQuFAhrCVZiopb6w+
 BmeozzOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRLQAKCRAk1otyXVSH0E5XB/
 9eKoZTlYi2BVbXjZrWbLqWquzXlD2d+PNTXFZrH5hsQjONsDoi9Pjc6vBP2Rq+zvYcDgloXucC4+kG
 to2qv8LkOUjq+GOgrh0Z5mqVIKef7bjvQXqo06la6oQGX6nNVJGdWI/IstMcgIyCMntSbj7B7hd2GL
 nDPorXdYdtt5GeQ6TGgSk5QjUZV8zvx36gLNa8TYUF9F8FTiHnnoyQYVmf7AfQHui5ooHkDM4EaNxO
 hkuiI4xMnP6MP3nZ1YsCWflEesxR3FoEI0PgPPyTfHrYqlNbXh72h5IMT0a9Ntqj0StxJx4wOiGdJ/
 vKhAPFViGCFXtK5c9StuFJx2HxH+I7
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


