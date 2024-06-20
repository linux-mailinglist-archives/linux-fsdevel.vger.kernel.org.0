Return-Path: <linux-fsdevel+bounces-22002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE77910CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD196B279E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821821B3F2B;
	Thu, 20 Jun 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abvyrJ/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91131BB6BD;
	Thu, 20 Jun 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900699; cv=none; b=X81D0J7FNrlO5i3uFmn+m22zd80bqWzWrU8fPjn9S96dTkFGW7cElD/m8Ah265RVqglzHppy8WBPj5v/GMO26nB2XSuRXF85yVv4Lvmx1/OJkoXDyxG0+ey0u7aFNDGCkfg4lmAyGjAy45Cb0XODRwyD2VdzG3RRUibsQaRfh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900699; c=relaxed/simple;
	bh=9tNBDm896BjzUxmnfvW1e6haCDwe3E/atZfPgTf6dvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QBBQ1iVdB5EZrxJW/JuDGNjAhY1UBiWoaBA5Gr0oYizEBqvB6nyXgXLpDitvXtIn36f0bpGDu4tVDV3sZA0D9QOhnfxNAoWwwbziIH0PQojKxXfohUnukzKb/wvViUVBRt0ORaitdj+dbQ2g0dHcevKXKy3/8Wx46cuvjjRfJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abvyrJ/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB57C4AF07;
	Thu, 20 Jun 2024 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900698;
	bh=9tNBDm896BjzUxmnfvW1e6haCDwe3E/atZfPgTf6dvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abvyrJ/X+WgKBcKLB26W63xGzrJswPTiNJDtrvePABOWadxaiMVdFVIIrjjZH7EMt
	 i3yfbG9sxIhKzIMCfECn8jajIwt5EnHTKwWgtPNsnEm6eH5VPX4iHwPOT/KLGXygLR
	 Y8UtKQhQMTPuDEykuGSASDGG1jSbMq6hu59HuuOGBaXNiJXkV1zooHon61XOPITCpE
	 SFmK3OLp8gXcumhP0tivnIEFTlCHa7lpiLvSg28jj4kABCTLi6W7v8y4Et1OD6DAcD
	 5NN8lrWx/ZkRbGl97bKzVpQphPBlvW7EqUaJZymCAafGjzXa4xCR+daUY33mNKb8As
	 9i6pj/PklBLgw==
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
Subject: [PATCH 12/15] s390: remove native mmap2() syscall
Date: Thu, 20 Jun 2024 18:23:13 +0200
Message-Id: <20240620162316.3674955-13-arnd@kernel.org>
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

The mmap2() syscall has never been used on 64-bit s390x and should
have been removed as part of 5a79859ae0f3 ("s390: remove 31 bit
support").

Remove it now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/kernel/syscall.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index dc2355c623d6..50cbcbbaa03d 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -38,33 +38,6 @@
 
 #include "entry.h"
 
-/*
- * Perform the mmap() system call. Linux for S/390 isn't able to handle more
- * than 5 system call parameters, so this system call uses a memory block
- * for parameter passing.
- */
-
-struct s390_mmap_arg_struct {
-	unsigned long addr;
-	unsigned long len;
-	unsigned long prot;
-	unsigned long flags;
-	unsigned long fd;
-	unsigned long offset;
-};
-
-SYSCALL_DEFINE1(mmap2, struct s390_mmap_arg_struct __user *, arg)
-{
-	struct s390_mmap_arg_struct a;
-	int error = -EFAULT;
-
-	if (copy_from_user(&a, arg, sizeof(a)))
-		goto out;
-	error = ksys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset);
-out:
-	return error;
-}
-
 #ifdef CONFIG_SYSVIPC
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls.
-- 
2.39.2


