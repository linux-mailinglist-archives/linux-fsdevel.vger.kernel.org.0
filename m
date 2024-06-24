Return-Path: <linux-fsdevel+bounces-22264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF72291546C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 18:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C41C20B30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706611A00CA;
	Mon, 24 Jun 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL3MGier"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9731D53C;
	Mon, 24 Jun 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247092; cv=none; b=SB2D1KNhVP/f10ycDdKhgO+RMRcx/3O/Of7pDDT+O6MHSRaHEl16ubUa9sbkvXlJL/zuyniYJaCFLx2zGynEvwzsJK46kgQqWfl5dK/U9o4rgtOv4SNzDXQAx9CLjSFfhwdkRTzqSCD36WCMF6VABIHfISVXCuSyiH/j4cuYiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247092; c=relaxed/simple;
	bh=IgP0M8xmd5rjKhDPUrYgB64lu58oqh0y0crOb4BZD9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faAdyZFzSKeZCIW4NbV/SCjFkibdeKOXCVKCNUd1eKQJsvjFg1hfllZMRn04LbmsYyaay3mOthXzcbWnnOvD2wVAYKP2DHky5zcVm7sk1k/mgjpNXt3LNRWAuwzTmYU/kfvSMFCFugUYFMVw2urMi/oyRWYGh5JsLA2pRJxQuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL3MGier; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A628C32786;
	Mon, 24 Jun 2024 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247092;
	bh=IgP0M8xmd5rjKhDPUrYgB64lu58oqh0y0crOb4BZD9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uL3MGier3znplmaR7ZT6dWU/wpMoIe4gnslzma/NaCokwco6hNNz/242/pTrmZOnN
	 4+wIbkcqyl/+nWHsL0pDj8yUnBc1srg2b1tkEQOhMgZsgAfiqSysXcAabbIc6PqjLB
	 W58PkXZvWU6v4pKUO7S+b/c83SFUzAmR3qQdGO4WdA8Cj04KVUFj4pJZ/vguuTwqXJ
	 XVQzo8MhTcluDAglatkg1lY1q27QSmzXYOZq7NErvn0v2tJfhwmD46fByBV5VQh52r
	 Meb9HdgzdfdnxkPDa/ongCQL8TK5a/lXXQtjPtmxTRxxTPI7hjInVaJq2O/gyGnV1/
	 otrEBJFQ1xLOQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	libc-alpha@sourceware.org,
	musl@lists.openwall.com,
	stable@vger.kernel.org
Subject: [PATCH v2 08/13] sh: rework sync_file_range ABI
Date: Mon, 24 Jun 2024 18:37:06 +0200
Message-Id: <20240624163707.299494-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624163707.299494-1-arnd@kernel.org>
References: <20240624163707.299494-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The unusual function calling conventions on SuperH ended up causing
sync_file_range to have the wrong argument order, with the 'flags'
argument getting sorted before 'nbytes' by the compiler.

In userspace, I found that musl, glibc, uclibc and strace all expect the
normal calling conventions with 'nbytes' last, so changing the kernel
to match them should make all of those work.

In order to be able to also fix libc implementations to work with existing
kernels, they need to be able to tell which ABI is used. An easy way
to do this is to add yet another system call using the sync_file_range2
ABI that works the same on all architectures.

Old user binaries can now work on new kernels, and new binaries can
try the new sync_file_range2() to work with new kernels or fall back
to the old sync_file_range() version if that doesn't exist.

Cc: stable@vger.kernel.org
Fixes: 75c92acdd5b1 ("sh: Wire up new syscalls.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/kernel/sys_sh32.c           | 11 +++++++++++
 arch/sh/kernel/syscalls/syscall.tbl |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
index 9dca568509a5..d6f4afcb0e87 100644
--- a/arch/sh/kernel/sys_sh32.c
+++ b/arch/sh/kernel/sys_sh32.c
@@ -59,3 +59,14 @@ asmlinkage int sys_fadvise64_64_wrapper(int fd, u32 offset0, u32 offset1,
 				 (u64)len0 << 32 | len1, advice);
 #endif
 }
+
+/*
+ * swap the arguments the way that libc wants them instead of
+ * moving flags ahead of the 64-bit nbytes argument
+ */
+SYSCALL_DEFINE6(sh_sync_file_range6, int, fd, SC_ARG64(offset),
+                SC_ARG64(nbytes), unsigned int, flags)
+{
+        return ksys_sync_file_range(fd, SC_VAL64(loff_t, offset),
+                                    SC_VAL64(loff_t, nbytes), flags);
+}
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index bbf83a2db986..c55fd7696d40 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -321,7 +321,7 @@
 311	common	set_robust_list			sys_set_robust_list
 312	common	get_robust_list			sys_get_robust_list
 313	common	splice				sys_splice
-314	common	sync_file_range			sys_sync_file_range
+314	common	sync_file_range			sys_sh_sync_file_range6
 315	common	tee				sys_tee
 316	common	vmsplice			sys_vmsplice
 317	common	move_pages			sys_move_pages
@@ -395,6 +395,7 @@
 385	common	pkey_alloc			sys_pkey_alloc
 386	common	pkey_free			sys_pkey_free
 387	common	rseq				sys_rseq
+388	common	sync_file_range2		sys_sync_file_range2
 # room for arch specific syscalls
 393	common	semget				sys_semget
 394	common	semctl				sys_semctl
-- 
2.39.2


