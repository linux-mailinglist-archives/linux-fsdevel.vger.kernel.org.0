Return-Path: <linux-fsdevel+bounces-22001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D4910CAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B611F21676
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6950B1BB6AE;
	Thu, 20 Jun 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liP+clW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B21B3729;
	Thu, 20 Jun 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900691; cv=none; b=i3ACRjmRWf29GGC2GHjz8Ae/AZnZnoECiqW4Fu7QBcvB5cRNHbP055ZX1HdEJBGr3lyv/EED/JrAVmwaF91M4h0fz8iZiqPuKP3kfOqSQQN5g67ltCysYo9VSaeNTVj6519BjZfarzsV1YkRpluZuuDsSTHdFiGQ8ok+NDeu+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900691; c=relaxed/simple;
	bh=CTMiij8diPtp23L47nQHWXQrj3MX4OJNEzgig287ZPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVF7SW2v3U6BH3Ik4J5rkvO0rRwd1Lg+YxxXuOnUTH5dOr9viDMz/jLjs5QrQ8iRwx7n3KrHw7jQzKI6C4fQXeJ7Y7/cW6BEN3NftvGvDqaUYUbGDDFZk+dxW55VDGCpmHEfjTQhvMmfimfl+U7WW4SXzNrtVNftk0tu42dCcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liP+clW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEAEC2BD10;
	Thu, 20 Jun 2024 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900691;
	bh=CTMiij8diPtp23L47nQHWXQrj3MX4OJNEzgig287ZPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liP+clW/FYJDMFwHv7e2XTi4LYa5eTnDyL47NLmiZ3cdTxaeJVM6WiqLSOvjZXten
	 pE6JYMMTtK2vXsP1OXrG0X/wzRuupXj07RgRMay50dms6iT69PyESvm8MZAALUCwW6
	 ScElgo7HBzd1he0cQvkNBktxqXYA3+ZQp+4j7Eyi0zUX6iTS+26CH6314rMnHOCsxp
	 2GZ0MxgqvDjTVnlva8n8/w9P6j9/14JsdOE3xslLC/hd1U15iSxzjY7Gdw5OPMjGTi
	 FxE0zxbrXL4hhuRiBxV9AFKTmJuqA88W9aUdlZqe/hk7lAm9X+hHNtXkp5bF7KXdDP
	 LnYwGSfr5+nRQ==
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
	ltp@lists.linux.it,
	stable@vger.kernel.org
Subject: [PATCH 11/15] hexagon: fix fadvise64_64 calling conventions
Date: Thu, 20 Jun 2024 18:23:12 +0200
Message-Id: <20240620162316.3674955-12-arnd@kernel.org>
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

fadvise64_64() has two 64-bit arguments at the wrong alignment
for hexagon, which turns them into a 7-argument syscall that is
not supported by Linux.

The downstream musl port for hexagon actually asks for a 6-argument
version the same way we do it on arm, csky, powerpc, so make the
kernel do it the same way to avoid having to change both.

Link: https://github.com/quic/musl/blob/hexagon/arch/hexagon/syscall_arch.h#L78
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/hexagon/include/asm/syscalls.h | 6 ++++++
 arch/hexagon/kernel/syscalltab.c    | 7 +++++++
 2 files changed, 13 insertions(+)
 create mode 100644 arch/hexagon/include/asm/syscalls.h

diff --git a/arch/hexagon/include/asm/syscalls.h b/arch/hexagon/include/asm/syscalls.h
new file mode 100644
index 000000000000..40f2d08bec92
--- /dev/null
+++ b/arch/hexagon/include/asm/syscalls.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <asm-generic/syscalls.h>
+
+asmlinkage long sys_hexagon_fadvise64_64(int fd, int advice,
+	                                  u32 a2, u32 a3, u32 a4, u32 a5);
diff --git a/arch/hexagon/kernel/syscalltab.c b/arch/hexagon/kernel/syscalltab.c
index 0fadd582cfc7..5d98bdc494ec 100644
--- a/arch/hexagon/kernel/syscalltab.c
+++ b/arch/hexagon/kernel/syscalltab.c
@@ -14,6 +14,13 @@
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
 
+SYSCALL_DEFINE6(hexagon_fadvise64_64, int, fd, int, advice,
+		SC_ARG64(offset), SC_ARG64(len))
+{
+	return ksys_fadvise64_64(fd, SC_VAL64(loff_t, offset), SC_VAL64(loff_t, len), advice);
+}
+#define sys_fadvise64_64 sys_hexagon_fadvise64_64
+
 void *sys_call_table[__NR_syscalls] = {
 #include <asm/unistd.h>
 };
-- 
2.39.2


