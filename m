Return-Path: <linux-fsdevel+bounces-27676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAB9635AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A571C22998
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C371B3B0D;
	Wed, 28 Aug 2024 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6shQglC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B161AD40E;
	Wed, 28 Aug 2024 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887807; cv=none; b=BeFFUuIH3q1smtdxDFbI5s/kQM8MgQZo5nRafzR7VmXZl1sKLu3zwdzLJwfcvl/67NdNYe7q9aGfOYnAoKohpVUx1jhYKFYRvvPDjSYVTbcummkiF4aXmdtzMRzIe7wJz28k/Oe2vEAt85AumzCmkf/an/Ao+hoH8W4jFE+EpRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887807; c=relaxed/simple;
	bh=DQ+/lIqnw5gAspETmMxguFP3SMk6gUYbh+baBR7FnZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KeTzbBcXi7OpAKw//AuUVdyVGqYFzMEOwvsAsuCKyMRVUu+ynljrbHdPAcbdmF+XVmzU/UPLBCTGtFl7nrTvRT1lvV2Q7WYuyZ+iolQ7S2D67JfB6jYTvzPCk1ti9z5nAh2BTSsQR20YUVKlb8lfMsr7n+IGzdLo4Q19horIcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6shQglC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F6FC4CEC8;
	Wed, 28 Aug 2024 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887806;
	bh=DQ+/lIqnw5gAspETmMxguFP3SMk6gUYbh+baBR7FnZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h6shQglCaEjIfYuTEJECgLX7lmS4cLVxZ5/7WqVoFrdb5D7Ce/hcrxVEtQrj4rVR4
	 CjkXTzUFDxo3k+MP3kYXPiF7Zf6LlOF5zOTZRxyUc6CiD4BGk9Gqkj2tLEQNuY/CWj
	 tVZgYMNHmu1h3WH8kPaRHrEbMwcjJJSHNuOc/HcThupy0uWzseDVB8df6mki4sEV6A
	 dKs8K77IC57vsS7LZTM88azbG+E3gESpYvAIZwASo9QVP+Q5NW/DinIeBkMl1sx7zK
	 o7h6mnPdVrzJBvvAj1oKUMiMLJYm5WiXjkPTu47uIBshlBzAA9biECrUn/MX1JEOok
	 vU57fRaLMiLjg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:29 +0100
Subject: [PATCH v12 13/39] mm: Define VM_SHADOW_STACK for arm64 when we
 support GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-13-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DQ+/lIqnw5gAspETmMxguFP3SMk6gUYbh+baBR7FnZg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KC/Rhk/py2u3sq1Sq6IyAa28H/JCkWwuYqk/+i
 WZjmPvmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yggAKCRAk1otyXVSH0JK4B/
 0c7CeQWbofgjSYjTY0ueVTYCsxmNGC9m3r7+5bju4v637iOCojsNlg3DLCUWyOw3YXzrrbNW9zZ0dH
 0kmVCJ+uifdZ3TJcp7w/fXoNJAyQjJV0aBj0a9Qv9B3oIpvQU9NZMkfeVwQ5+zkVI/u13qRDDpeYUP
 gIDHJXKhQ/cj1Rnz45LHx/uGssDgemHZkNA7x47Ku8ce4ltskMLY955Df6RLOnG98MGgE59Jc0uHbN
 Ox8V5SLtKLryDkZiQfOsUX/zOoZkqlqhox/0UBfebCkjWZJ9NRh7d8nl7j/BGcIZnav+h1LVscipli
 t53+wNbtpeU5VBt7BRlrgDb2TyZMRM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Use VM_HIGH_ARCH_5 for guarded control stack pages.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
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


