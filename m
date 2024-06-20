Return-Path: <linux-fsdevel+bounces-22003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9124910CC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629D5288B0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B31BC072;
	Thu, 20 Jun 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4I6Oy4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEE1B3F17;
	Thu, 20 Jun 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900705; cv=none; b=rL2hjtYMi7VD3/+xRno7doV4rVF/lz1Hrluizag/BrfJHHHxp7zGeo+LZS+bjcF/p+DaJQKDGOl2Rx6GjBArfmtBEskg/rFSuvtQcuvMXWXTXnwDPJNZ0xuicHBzo4UAU29IIiYD+565oXWvq8G0MH6yNzKMnduWFhWYHjkCbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900705; c=relaxed/simple;
	bh=cPi0ZjnBV1CIKlXBkpBvG5fVNflJ/ABQ595U6A2fdNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpiQYNe5s+xC3dUAIB5NRdIabTkAK67pKWZbR7RahXxxTubINQKlRgevigUaM4nmrMf9DL3XC9iyGcoEgr+FRzdo/sX/9r7ldLA8rLiDPv5YOFCKTL2zJ8zPIfwcaJy8ow7gZVYfKv+uaiKKNj2GVBiWPLKqU6Ihs7dMGcgJAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4I6Oy4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3633C32786;
	Thu, 20 Jun 2024 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900705;
	bh=cPi0ZjnBV1CIKlXBkpBvG5fVNflJ/ABQ595U6A2fdNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4I6Oy4U9Tj4R13eiK7pqNG2CXsWUIjkycJBnYKwfQOrvpBUldFWwHt5fforf8qGO
	 W7ImwPMXiKO8CaPCzUM0SFq2R8ogOIYhE4DzW2jwybln/I37fOpfNvMxVAVrrdaDoS
	 WUi8sCz8As8NoYFsujUNcySYE3BhqLiI+fdifQAzyfs9GESJFzoOrwAaRenVvMUVkG
	 XnNmh77sKBmccGcKyq697GncV2zjKoPPWOKYtfbRLPaDFIGaZyswOD5mh9kmoEczBR
	 MmqXf5vABoIwXanfGd9nvrIo6xDYMJfqhkmt6FUeNA/P7TOQqjAij0rew7x9s74LHq
	 xobiBExDOIVlg==
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
	ltp@lists.linux.it
Subject: [PATCH 13/15] syscalls: mmap(): use unsigned offset type consistently
Date: Thu, 20 Jun 2024 18:23:14 +0200
Message-Id: <20240620162316.3674955-14-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620162316.3674955-1-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Most architectures that implement the old-style mmap() with byte offset
use 'unsigned long' as the type for that offset, but microblaze and
riscv have the off_t type that is shared with userspace, matching the
prototype in include/asm-generic/syscalls.h.

Make this consistent by using an unsigned argument everywhere. This
changes the behavior slightly, as the argument is shifted to a page
number, and an user input with the top bit set would result in a
negative page offset rather than a large one as we use elsewhere.

For riscv, the 32-bit sys_mmap2() definition actually used a custom
type that is different from the global declaration, but this was
missed due to an incorrect type check.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/syscall.c              | 2 +-
 arch/loongarch/kernel/syscall.c         | 2 +-
 arch/microblaze/kernel/sys_microblaze.c | 2 +-
 arch/riscv/kernel/sys_riscv.c           | 4 ++--
 include/asm-generic/syscalls.h          | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/csky/kernel/syscall.c b/arch/csky/kernel/syscall.c
index 3d30e58a45d2..4540a271ee39 100644
--- a/arch/csky/kernel/syscall.c
+++ b/arch/csky/kernel/syscall.c
@@ -20,7 +20,7 @@ SYSCALL_DEFINE6(mmap2,
 	unsigned long, prot,
 	unsigned long, flags,
 	unsigned long, fd,
-	off_t, offset)
+	unsigned long, offset)
 {
 	if (unlikely(offset & (~PAGE_MASK >> 12)))
 		return -EINVAL;
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index b4c5acd7aa3b..8801611143ab 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -22,7 +22,7 @@
 #define __SYSCALL(nr, call)	[nr] = (call),
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long,
-		prot, unsigned long, flags, unsigned long, fd, off_t, offset)
+		prot, unsigned long, flags, unsigned long, fd, unsigned long, offset)
 {
 	if (offset & ~PAGE_MASK)
 		return -EINVAL;
diff --git a/arch/microblaze/kernel/sys_microblaze.c b/arch/microblaze/kernel/sys_microblaze.c
index ed9f34da1a2a..0850b099f300 100644
--- a/arch/microblaze/kernel/sys_microblaze.c
+++ b/arch/microblaze/kernel/sys_microblaze.c
@@ -35,7 +35,7 @@
 
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags, unsigned long, fd,
-		off_t, pgoff)
+		unsigned long, pgoff)
 {
 	if (pgoff & ~PAGE_MASK)
 		return -EINVAL;
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 64155323cc92..d77afe05578f 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -23,7 +23,7 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 #ifdef CONFIG_64BIT
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags,
-	unsigned long, fd, off_t, offset)
+	unsigned long, fd, unsigned long, offset)
 {
 	return riscv_sys_mmap(addr, len, prot, flags, fd, offset, 0);
 }
@@ -32,7 +32,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 #if defined(CONFIG_32BIT) || defined(CONFIG_COMPAT)
 SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags,
-	unsigned long, fd, off_t, offset)
+	unsigned long, fd, unsigned long, offset)
 {
 	/*
 	 * Note that the shift for mmap2 is constant (12),
diff --git a/include/asm-generic/syscalls.h b/include/asm-generic/syscalls.h
index 933ca6581aba..fabcefe8a80a 100644
--- a/include/asm-generic/syscalls.h
+++ b/include/asm-generic/syscalls.h
@@ -19,7 +19,7 @@ asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 #ifndef sys_mmap
 asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
-			unsigned long fd, off_t pgoff);
+			unsigned long fd, unsigned long off);
 #endif
 
 #ifndef sys_rt_sigreturn
-- 
2.39.2


