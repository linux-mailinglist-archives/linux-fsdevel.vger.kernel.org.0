Return-Path: <linux-fsdevel+bounces-21992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A8910C4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6789C1F21E55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE21B4C23;
	Thu, 20 Jun 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaWGCEH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690621B47CA;
	Thu, 20 Jun 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900636; cv=none; b=SLHvIDdJtyFoX/nTf90cdcwZXn4DdKg0qIgbvkJsP/UmCRWmtXiVQ6EzeYOKxOP77f1tauvf1HjQOX+MxTxBpGNw3GaGQwccsaZcqXtj7r4FXq7RjThds7j/1GsEElB5tHimq2jWb1R+zIdzh16EYhrZlo4lkDnkQnNTsIBIiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900636; c=relaxed/simple;
	bh=Doj0//VPfq9z758xR2+yZ79Db+NeekZ0EoHrfr9q2Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1BAVjZTkKi3r4OrxVbeVxl1T+qZ43ncBu3FboudIkrt8/tstL8hfaQvdnSgKmir2hT4mzXWvwCpo4ht7OMmz8fDACfNNoeg1gzyz6dp7FvtL8K9ii/uI6VjK+/pCCtAoNrnhV41orduMRLLN2xkyVge0Mvpzos8azUksBq6/UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaWGCEH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB5EC4AF07;
	Thu, 20 Jun 2024 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900636;
	bh=Doj0//VPfq9z758xR2+yZ79Db+NeekZ0EoHrfr9q2Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaWGCEH0FUtHpMS1MWl92zyMC/tgI55ZbXl6tZ3t5C3/D90MhQY7LMPv52sRtXgX7
	 /tDHOQ6fobnn4uVWb5vNTuBQIwEAxDas3AiEfhSop6feRAWhRnZ+da7P7VMngnhmkk
	 uKday5m0uC0pCQIfQjJmNfph+BSKsE6mupZiTK4nCMh6ev02nOQHZHAifS9GhfJcf8
	 Av2+SR2IBKxnqrqNk3UUKHECPl0wYIrYeODFjmzBUOQioGFpi7EdScbEqPk5DdwfzV
	 /j7R+AlsEtHGaZd/7u8r6X3V3OMunqnE6kTRg7ZdDsGpPmUCRt3Q2a3/R9uSNNqkgU
	 9t5D3HmhZEJ5Q==
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
Subject: [PATCH 03/15] mips: fix compat_sys_lseek syscall
Date: Thu, 20 Jun 2024 18:23:04 +0200
Message-Id: <20240620162316.3674955-4-arnd@kernel.org>
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

This is almost compatible, but passing a negative offset should result
in a EINVAL error, but on mips o32 compat mode would seek to a large
32-bit byte offset.

Use compat_sys_lseek() to correctly sign-extend the argument.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/syscalls/syscall_o32.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 85751c9b9cdb..2439a2491cff 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -27,7 +27,7 @@
 17	o32	break				sys_ni_syscall
 # 18 was sys_stat
 18	o32	unused18			sys_ni_syscall
-19	o32	lseek				sys_lseek
+19	o32	lseek				sys_lseek			compat_sys_lseek
 20	o32	getpid				sys_getpid
 21	o32	mount				sys_mount
 22	o32	umount				sys_oldumount
-- 
2.39.2


