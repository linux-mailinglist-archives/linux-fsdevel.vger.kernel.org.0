Return-Path: <linux-fsdevel+bounces-21998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB7910C8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C221C20F8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737181BA090;
	Thu, 20 Jun 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBOAGVRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E21B3745;
	Thu, 20 Jun 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900671; cv=none; b=TaTXlbQxy3tU0Ff485rGUPQfKKeXW3UTeeFw+C+ZcKFF/jk7AfKhcZgZiH/6iLPcNO+bRB+Iy+UGlI2m6vEi9dYeWkBc7+ldhiv3uvpZGUyN4fjtmUslaAdQjStFU9/UKOaWv+S7uVe70KdaXP0520G4MjPfvJYxw6yUJl3UGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900671; c=relaxed/simple;
	bh=aE1IzWXJE8K8MWEf5402uO3TqcAk8oC7+4/q1IycgIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APXFSesPK1VqwjK+DhyMWrl23eHCnmwDH+fgDz471KZGT2/4pItH60c35ye/8JmoH+7jzM52qwgBjnCfGAN1xpteqj3XbAV86ZaLh3rrDsn2fxEu9DMa+VVIznCJTOKM81ViJ0eEJroLnabnOxo1Ln6i9R1A2tK48MRkVo67tak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBOAGVRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B879C2BD10;
	Thu, 20 Jun 2024 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900670;
	bh=aE1IzWXJE8K8MWEf5402uO3TqcAk8oC7+4/q1IycgIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mBOAGVRPDuIIDgzz9N9Wv9tq+6O7qehvtt3NqwZRKXAaX81ur91IhS/ySqZEVjXHH
	 8BNFcwQVOPD4kEHDjxawmwom1Bs6tusGWzCs9fCVUZ5OUF0O+OvH0CVa5kGnOTFmzL
	 GEI5mB0QcswRpgi+tdI9ziS4nTh/FR/VW8c0NX2qlhuCSCCrTcDCQVCXPAkfLukmZ5
	 NbYsw1oxfrsZ7X0U4eoXex0ehnrVGHOa2jbo8WScSWXnj3rfEAKY0S8c3gzpWgOSDy
	 tnXuUgL8P3jSsl4vGY4W7kZjzDQ42iBfVb9+jcuFzGcY1/joadJbP3jiKaE7bYpngQ
	 8HwoNYMbd4hYQ==
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
Subject: [PATCH 08/15] powerpc: restore some missing spu syscalls
Date: Thu, 20 Jun 2024 18:23:09 +0200
Message-Id: <20240620162316.3674955-9-arnd@kernel.org>
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

A couple of system calls were inadventently removed from the table during
a bugfix for 32-bit powerpc entry. Restore the original behavior.

Fixes: e23750623835 ("powerpc/32: fix syscall wrappers with 64-bit arguments of unaligned register-pairs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/syscalls/syscall.tbl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index c6b0546b284d..ebae8415dfbb 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -230,8 +230,10 @@
 178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 179	32	pread64				sys_ppc_pread64			compat_sys_ppc_pread64
 179	64	pread64				sys_pread64
+179	spu	pread64				sys_pread64
 180	32	pwrite64			sys_ppc_pwrite64		compat_sys_ppc_pwrite64
 180	64	pwrite64			sys_pwrite64
+180	spu	pwrite64			sys_pwrite64
 181	common	chown				sys_chown
 182	common	getcwd				sys_getcwd
 183	common	capget				sys_capget
@@ -246,6 +248,7 @@
 190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
 191	32	readahead			sys_ppc_readahead		compat_sys_ppc_readahead
 191	64	readahead			sys_readahead
+191	spu	readahead			sys_readahead
 192	32	mmap2				sys_mmap2			compat_sys_mmap2
 193	32	truncate64			sys_ppc_truncate64		compat_sys_ppc_truncate64
 194	32	ftruncate64			sys_ppc_ftruncate64		compat_sys_ppc_ftruncate64
@@ -293,6 +296,7 @@
 232	nospu	set_tid_address			sys_set_tid_address
 233	32	fadvise64			sys_ppc32_fadvise64		compat_sys_ppc32_fadvise64
 233	64	fadvise64			sys_fadvise64
+233	spu	fadvise64			sys_fadvise64
 234	nospu	exit_group			sys_exit_group
 235	nospu	lookup_dcookie			sys_ni_syscall
 236	common	epoll_create			sys_epoll_create
-- 
2.39.2


