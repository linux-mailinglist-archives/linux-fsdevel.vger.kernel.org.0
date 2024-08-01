Return-Path: <linux-fsdevel+bounces-24771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF33C944C53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE191C25E6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514141B4C2D;
	Thu,  1 Aug 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+gcjC8U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4A1A0728;
	Thu,  1 Aug 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517190; cv=none; b=IhNjeDAa3M8SWawY01wq6Cq0AQwc++6uG3eGPN8i4l4QxGF7W0DWJ5wbNEHxaJ2DYqUpW/GaDe6u21MRUbSuB4/n6Xg5vFtrdJ4H6BB9CMOx/vJTLUaNtJA8euxPOthee/TlQ8fnWonsqnR3D9bGd4+z6PqjUQ6mZuOwc0Na9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517190; c=relaxed/simple;
	bh=sHUTBcC9ajPqHUJTppDeK0B3kuOgTQJMo9ToCm1jbwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QY87d74JcR/1rf32VIBAL9o9XELfezH/w4HgQrhZWmm1IfpsEBxxI+zZyH4aH5Hz/mHcyLH16LZjSQ1o+2f3E1lQAUcQn0b0qz7pGtREVuhtDWI1e5tNdgIh3mnwWDUhwv3VnuWvhKozwki7nSxFzCn/g/5a8/x5LJZ57vqUyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+gcjC8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C84C4AF09;
	Thu,  1 Aug 2024 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517190;
	bh=sHUTBcC9ajPqHUJTppDeK0B3kuOgTQJMo9ToCm1jbwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f+gcjC8U0DPC9CuVb9hizzrLAAK+UQ4RNTiDbO40spLPhXmrdjZh1UH7Ysws0Iy3F
	 g5XzrUnTYPXWfPP/ApA+KHfbyxXbkQq+n6ctqR8btWf77VzdJvfjokIudQYe3QObZb
	 412kswTUa4acYd4oKwR5hCgQLRPO+Is+8AGse/LeIzY1Ut5IbYqRR8U2D282SpGEbM
	 tQ5BFRkyvhxTL4MM0YegHjz7PAnmbejqSt6QVly2yZ56V2TH+3Sf2JVhxzVA7K7cOT
	 TZEmFWVliuG0+RPnKnQb/rEQ2NSVglRQ4rN0BLrR2xyeJy1K1sKZuE/e9NFD0EACWP
	 t5apF7XojBzYA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:49 +0100
Subject: [PATCH v10 22/40] arm64/mm: Implement map_shadow_stack()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-22-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sHUTBcC9ajPqHUJTppDeK0B3kuOgTQJMo9ToCm1jbwg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YXropMdlIS63qshvA6lvojkCo/oAO1adQXBQBZ
 Du9YUr6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGFwAKCRAk1otyXVSH0KkqB/
 4/6Y5UAvVw7VWYaEMICrtZg2DSoyU9nSsx2DULzGCY2jNoB49lfqczc/CSIkCdRyAuotj32onJgufj
 pKduK9m0qZx9Ob+aLo/exl96WDp0nsUmlbefih+oqecwlVtHnSbPTZTuFCpJkKDEEn9UykoGt6JthV
 O2s4dsnE5i97W3LA80/j8e4vtjd/PTN2RY2ltQ3diEG/YffcHg2W/twN1vBsbrob58yQjz2gMMaYL0
 +Fq1SA3+ujMf9iwgmhW6W90O1/FB2S9WnCTeOm18Qd2ZmoDbK1gUc7476SyQWt0lfpyxnPzEFAy/6A
 xF+nEgrw9zHLV3CAbGKtwlwTT3VH63
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

As discussed extensively in the changelog for the addition of this
syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
existing mmap() and madvise() syscalls do not map entirely well onto the
security requirements for guarded control stacks since they lead to
windows where memory is allocated but not yet protected or stacks which
are not properly and safely initialised. Instead a new syscall
map_shadow_stack() has been defined which allocates and initialises a
shadow stack page.

Implement this for arm64.  Two flags are provided, allowing applications
to request that the stack be initialised with a valid cap token at the
top of the stack and optionally also an end of stack marker above that.
We support requesting an end of stack marker alone but since this is a
NULL pointer it is indistinguishable from not initialising anything by
itself.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/gcs.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 0d39829f862e..6703c70581a4 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -140,6 +140,67 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 	return addr;
 }
 
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	unsigned long alloc_size;
+	unsigned long __user *cap_ptr;
+	unsigned long cap_val;
+	int ret = 0;
+	int cap_offset;
+
+	if (!system_supports_gcs())
+		return -EOPNOTSUPP;
+
+	if (flags & ~(SHADOW_STACK_SET_TOKEN | SHADOW_STACK_SET_MARKER))
+		return -EINVAL;
+
+	if (addr && (addr % PAGE_SIZE))
+		return -EINVAL;
+
+	if (size == 8 || size % 8)
+		return -EINVAL;
+
+	/*
+	 * An overflow would result in attempting to write the restore token
+	 * to the wrong location. Not catastrophic, but just return the right
+	 * error code and block it.
+	 */
+	alloc_size = PAGE_ALIGN(size);
+	if (alloc_size < size)
+		return -EOVERFLOW;
+
+	addr = alloc_gcs(addr, alloc_size);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	/*
+	 * Put a cap token at the end of the allocated region so it
+	 * can be switched to.
+	 */
+	if (flags & SHADOW_STACK_SET_TOKEN) {
+		/* Leave an extra empty frame as a top of stack marker? */
+		if (flags & SHADOW_STACK_SET_MARKER)
+			cap_offset = 2;
+		else
+			cap_offset = 1;
+
+		cap_ptr = (unsigned long __user *)(addr + size -
+						   (cap_offset * sizeof(unsigned long)));
+		cap_val = GCS_CAP(cap_ptr);
+
+		put_user_gcs(cap_val, cap_ptr, &ret);
+		if (ret != 0) {
+			vm_munmap(addr, size);
+			return -EFAULT;
+		}
+
+		/* Ensure the new cap is viaible for GCS */
+		gcsb_dsync();
+	}
+
+	return addr;
+}
+
 /*
  * Apply the GCS mode configured for the specified task to the
  * hardware.

-- 
2.39.2


