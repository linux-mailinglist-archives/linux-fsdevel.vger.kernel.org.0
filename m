Return-Path: <linux-fsdevel+bounces-26600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB795A96D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657951F2235B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10BF134A0;
	Thu, 22 Aug 2024 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biXWX8Vm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28521134A8;
	Thu, 22 Aug 2024 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289373; cv=none; b=HIzvHubdRt7p8rnJPGaMqoK3y6iydb2NhoCA0AWOjf3/u3+9e6ayxKif+y2/vLAcsaQftkdgYkyig8nqtLTQQF64DDEYkhmXncEZOa20d/GfknDEct7b+1s2MpNsuM2+kzuegZOYgejsPxTBnNZUDLrXXvJzlkY0DCuS332HLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289373; c=relaxed/simple;
	bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3BYNuh0FD5RJiKiXQI1W+nANftgRu7A3nJunCq7V4pv6rGJALzB9ErwJ7UcxJKKYDd1JaGH60b1abtyeMwbASleqW4mV15R/LIRV0nAyjQ44eQiAzDNkkvaWN/nKAFAdQHLt6nx7Uf4hSPZNocoleyqAeq1BikgXCdVsDNgAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biXWX8Vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E568C4AF0E;
	Thu, 22 Aug 2024 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289372;
	bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=biXWX8Vmk/JOEerWjDB74EBnxWrPoMhMtVTPsc2ex00mX3Z4WCLkak9FasSKXhtvB
	 Cdt5EJvv4aDcPjTOAawQHHFe/z63sQ8CdjGvk+wYlTUnC6MkVNvJGX/iYIPsj1W2I6
	 TJfatKx11NUzQZwL/1bGaCwx3TswneR9v4SaF95YOG4s8cznuYv6vsLeshxrwoByHx
	 luNNZfvHuyrW+0Z5Q4Hnr4j2WAfiPLrc8TG857PL/s/veslHmJA2UnmbYK27PxYtdc
	 +HpqFlIFxEkK9rzy/SjB/KjVFUznD3lLHW88rr1NGLDV2n/elQf6LN7gnsFUpmqSe1
	 UBxqZua1NkrFA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:04 +0100
Subject: [PATCH v11 01/39] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-1-41b81947ecb5@kernel.org>
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
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>, 
 David Hildenbrand <david@redhat.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aXGeSW3grtLdSnTdx5+gSzbAczg0duMe8mDGJOGSfWQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpEkLhJIQbUOFiiEto8Mgop3OIshQ8p27HPLildg
 xhM8QJmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRJAAKCRAk1otyXVSH0GjtB/
 9JsDwl0HJhR1EO6wLHU8IcpvE5PJh892zoiYHI0bPT3Bqx28uTpDmZgrddnfXDarHeczPXMd4IzEA9
 f9MX3Rkf6ODFlmACfOskT6PjN46ZBEDacxl4/smys5l/OdwpESjek5/CKD3p+viOUmeZ2uzzWQk8BD
 q1ElW83iGLq0MJokj0H/TrrJLg0+YkeeFCI3luZhQ/3IgYVYsn/pKcfKFMANnnfujKqAbTgR5dXsiw
 e+MSvPJLkhTHKnJKTNkQ8wyJlIjd3vyfzF+JyU6q0Eq59YN8GJ6TIpmvaDbmt4OqCKaiIYX6QVSjzt
 atiZSvCiUkNgacnNllTEUuU71/HB5v
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/Kconfig   | 1 +
 fs/proc/task_mmu.c | 2 +-
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 6 ++++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..320e1f411163 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1957,6 +1957,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5f171ad7b436..0ea49725f524 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -984,7 +984,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 #ifdef CONFIG_64BIT
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..3357625c1db3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -342,7 +342,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
  * support core mm.
diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f78..3167be663bca 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1263,6 +1263,12 @@ config IOMMU_MM_DATA
 config EXECMEM
 	bool
 
+config ARCH_HAS_USER_SHADOW_STACK
+	bool
+	help
+	  The architecture has hardware support for userspace shadow call
+          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
+
 source "mm/damon/Kconfig"
 
 endmenu

-- 
2.39.2


