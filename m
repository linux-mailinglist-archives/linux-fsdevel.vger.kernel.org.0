Return-Path: <linux-fsdevel+bounces-27686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83959635E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA322826CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686201B14F4;
	Wed, 28 Aug 2024 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fovBxTdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4B1AE87B;
	Wed, 28 Aug 2024 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887882; cv=none; b=P4ypdjDEZjTMhWe+MsA3t3mqwoGAhg2Z2/0KBBarkZDh7628T1mSdDJ2mcNprHCyFxGZnhST9idhu6Ge8smetJAGgy1fe+VBgRwuCMdXeyfGtavMEWYZXjlclQCjS0exW7vhXcaQO3q08N1Z06Z6erUyNQv/wtxMtZiLVqu0Gkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887882; c=relaxed/simple;
	bh=QZaW0hCLawS24gfsrOh/tioIJLs0ZSMp+GQyLn6Fkyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TE3NJBv+Rz8raUXHROBKiOyDd70pzI4FmS0WMstIlTXvllOJ6kQXwt6tX4WSeRjG8/l9knR8XI3NRq5UlsZlVh9iM/tlM2n4QfG2+sRrDN/EYt85KktWV5rDj2DMPZbe6YjN8RbcvaW34l27QG9RomBWb50vCWen4X2Cq9YNCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fovBxTdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38069C4CEC4;
	Wed, 28 Aug 2024 23:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887882;
	bh=QZaW0hCLawS24gfsrOh/tioIJLs0ZSMp+GQyLn6Fkyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fovBxTdhiD2VqYg10EgfUytuiZHI0AoPc/51GcFsjNd40/y9kJ89gK5C6JqZ+uXAk
	 J+9y0SvG8fBAf/r9+hJeLKROupJ0IvBIkJAmdSRG/VSulTsQPHsmOBhhvWIF0BSAkV
	 gIT5XmBo1uMl0Datb23vtxSiWJnKrQrKC/ygiCngnSY2HD5bLDu5dPhSVnUoebrmvD
	 bULwgQ8WOce3MUoBxGlGZb4vz36yk/xjlSVuKzvFWtLJPXgIdN97N78FQkMXQSlqt7
	 vRJhZFShmSy8+aV/L3BWwCytVYSKv3zdGbg24IFfjFYvbauMbS5mMMYT4Xtghrg0C4
	 2lrilOvILazxw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:39 +0100
Subject: [PATCH v12 23/39] arm64/mm: Implement map_shadow_stack()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-23-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QZaW0hCLawS24gfsrOh/tioIJLs0ZSMp+GQyLn6Fkyg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KKThZ/6LRaIIP82jKaeHi/u1K7PI3KtMSJ/Eyu
 a0lLpT2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yigAKCRAk1otyXVSH0PJmB/
 9UdvhfrTKb0KEJxHdMW577qcwze1tFePB+X559s8pp/SgfIA+XNNhYVab1hTQHpVx/ibLczLzsUhgf
 qtIoJ8wh9/MPww97uUH1ALY8ZN+OM3AuUyEVSIVawsSdoZJgKfehXQ4tSjW5pHxmsFJk0pDVUCtKD6
 zMjRggMvXV95HoUi1TX4UJWldJLrzu+TIcN2ZuRcMBZtDsfaRMwr2I+icr/ctzLoUv//gGO/xR8OvU
 eLtv0qDsbSE2+fny8IODbznNRjeCa+RSX156PyHJYffrFGge9CTM1MKO8yJorXsiu7DsHjW6QuDGb7
 PUuXQqdl47bIqXIaufxHO1zjbaiEv1
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/mm/gcs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 979e02cece93..cdd4a9d7ff7d 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -68,6 +68,70 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
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
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	if (size == 8 || !IS_ALIGNED(size, 8))
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
+		/*
+		 * Ensure the new cap is ordered before standard
+		 * memory accesses to the same location.
+		 */
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


