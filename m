Return-Path: <linux-fsdevel+bounces-22257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99270915421
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 18:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AF31F234D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7A319E7F5;
	Mon, 24 Jun 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhTmssAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E726419DFAD;
	Mon, 24 Jun 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247047; cv=none; b=hNQY1t5zYUgY+1RR767N4NYBsk9kBE57VApuSRqC7CmR6+s+E1fcNMYksic7ZVRb8ulYcd7q6YBFaaf3zSVRRakM2BKaZo6Y0RMIfu3M/aD2ZA7O87lKs7iz4jbnDxcSlnFpVYwwBhaJHyUh6Rh66GOFTzKXxMsS+6QDXrN0AVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247047; c=relaxed/simple;
	bh=EwPpX0S1DTr+6EvIenNObE+xZCXTGGAFxEeI1J4w98A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=narmM+bHjVFqvjqiIo4RmzwxCI8QmrDCM+SDQ7LHFSC1BuB5fLY2msZQAPmxuQorc5qXbE5kOMYP80hRjp23yXtZDZ3q6WXbQb59Jn2lBLbMrorDeeKklVRpfF8knrlVv902ExY8UEXAEds/z4CZMocQTxCOPqFURwyTANFiYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhTmssAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B69CC32782;
	Mon, 24 Jun 2024 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247046;
	bh=EwPpX0S1DTr+6EvIenNObE+xZCXTGGAFxEeI1J4w98A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhTmssAmbe2m7XIZuY8gNTeVo+Lkit5BxwKeUJVUTZwbQDs+G38+66PslSvzLgbPX
	 5VKaiDIhlfUucsc4cjoE7TqvsIBTcMhplYbPShFl5s9bpnQzl7TNnyubJlrQWYBJtL
	 +/n0rSYNeyLLM8kjj7zO4V6y9CBf8tcSacuRTYHi/44G5yRnMmt4Ieqoj6GlBy9sPc
	 dZ2nLCKQKHprpGR0yeVZy2oKdDUOIcxuh6Y4DBO8vU3exBZJH7F0XMADo/asFimmTq
	 sKPNph/E2CBt9PEnVWdZ6rFALDcWj8IxJTdgWx9kRIgFVlh8ERnRYJV9VwZ/nU3ne/
	 suhAPd1WlO1Pw==
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
Subject: [PATCH v2 01/13] ftruncate: pass a signed offset
Date: Mon, 24 Jun 2024 18:36:59 +0200
Message-Id: <20240624163707.299494-2-arnd@kernel.org>
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

The old ftruncate() syscall, using the 32-bit off_t misses a sign
extension when called in compat mode on 64-bit architectures.  As a
result, passing a negative length accidentally succeeds in truncating
to file size between 2GiB and 4GiB.

Changing the type of the compat syscall to the signed compat_off_t
changes the behavior so it instead returns -EINVAL.

The native entry point, the truncate() syscall and the corresponding
loff_t based variants are all correct already and do not suffer
from this mistake.

Fixes: 3f6d078d4acc ("fix compat truncate/ftruncate")
Reviewed-by: Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/open.c                | 4 ++--
 include/linux/compat.h   | 2 +-
 include/linux/syscalls.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 89cafb572061..50e45bc7c4d8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -202,13 +202,13 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	return error;
 }
 
-SYSCALL_DEFINE2(ftruncate, unsigned int, fd, unsigned long, length)
+SYSCALL_DEFINE2(ftruncate, unsigned int, fd, off_t, length)
 {
 	return do_sys_ftruncate(fd, length, 1);
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_ulong_t, length)
+COMPAT_SYSCALL_DEFINE2(ftruncate, unsigned int, fd, compat_off_t, length)
 {
 	return do_sys_ftruncate(fd, length, 1);
 }
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 233f61ec8afc..56cebaff0c91 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -608,7 +608,7 @@ asmlinkage long compat_sys_fstatfs(unsigned int fd,
 asmlinkage long compat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
 				     struct compat_statfs64 __user *buf);
 asmlinkage long compat_sys_truncate(const char __user *, compat_off_t);
-asmlinkage long compat_sys_ftruncate(unsigned int, compat_ulong_t);
+asmlinkage long compat_sys_ftruncate(unsigned int, compat_off_t);
 /* No generic prototype for truncate64, ftruncate64, fallocate */
 asmlinkage long compat_sys_openat(int dfd, const char __user *filename,
 				  int flags, umode_t mode);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 9104952d323d..ba9337709878 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -418,7 +418,7 @@ asmlinkage long sys_listmount(const struct mnt_id_req __user *req,
 			      u64 __user *mnt_ids, size_t nr_mnt_ids,
 			      unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
-asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
+asmlinkage long sys_ftruncate(unsigned int fd, off_t length);
 #if BITS_PER_LONG == 32
 asmlinkage long sys_truncate64(const char __user *path, loff_t length);
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length);
-- 
2.39.2


