Return-Path: <linux-fsdevel+bounces-65458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24990C05C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A245189331F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45333218D8;
	Fri, 24 Oct 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdzFdWkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87A31354F;
	Fri, 24 Oct 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303273; cv=none; b=UJV5KzlshoEC2pAROTHZ2UDSxsDHwZICRZsYq1wKY96oXzJqO9Q8reFBc4tD4VPP3PlAm1kfOyK+8sztUt5a2Lv2GsLrcMnHHGPFPECQIfDi7+wUtMAX5GY1s8RU7lRHvAdakwo9FalgeSbq8k9eK8R6m9/Pu+Nlfy8KK28evPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303273; c=relaxed/simple;
	bh=tRwqy5SwFVniPr5V+qBsta76Evy4Uws4vCbVqOZukQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kv4IVqvol1MaIuKj6tn3+47XuFoqzH486f2uFIfqk/PLpOH7N7OrGqn+zYrOSxbVWsnYYKlwN6nkPSHZ+fy0NJXnT4qYGiIRzDVdMEhHsGgiKs/r2zAGVsB7mysC1YJiaP86HkvZPgsMgiaBNydYFIF4AIHeHTLnbkqJ1NX8enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdzFdWkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE190C4CEFF;
	Fri, 24 Oct 2025 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303272;
	bh=tRwqy5SwFVniPr5V+qBsta76Evy4Uws4vCbVqOZukQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AdzFdWkq4KA20SWQb2Hf8Gz4qIVvV/RPNAL0gZ/OjAWF8yEdSBi5MYYPFJTI9C/EI
	 axfb8obGUZvcO9RLjYw53hnjrMxiQ7a2xIYi90KvAqNYbLtbktQzjZPmprPd6mWfsK
	 D2v40PzMUZufSvitLIaJ998lFwLN+1KcOVK8PgpVgYBl1uzgLxBEc9Ddhb9Kz1gI0R
	 K3LonFIXtk1MJ3XgbEIZhlu5kQ3oUCSlh8youjeVMnHwaUpBgwpR6wQgU882nFdqwY
	 qWbNldMucOtqyT4mIwbAhZlKr/5/gPlhnvNghp5+NYglbzhyvmj5EmeGGzxTpsrUWu
	 OYHfyI6A2evPw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:47 +0200
Subject: [PATCH v3 18/70] arch: hookup listns() system call
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-18-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=8895; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tRwqy5SwFVniPr5V+qBsta76Evy4Uws4vCbVqOZukQo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmr9Mb/SYdpUjpplCypPWcyNaooJdvvimHOna/G1f
 Nf+x343O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCb8zwP3y66DTWiSoTizy3
 +P1oaV4TrOrpu7k0edoEC6fliXxewQx/ZYP2hTenblWZ48TFZ/Nx+8YDnAovlqY0zJH7U+q/ro+
 BGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add the listns() system call to all architectures.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/tools/syscall_32.tbl             | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 include/uapi/asm-generic/unistd.h           | 4 +++-
 scripts/syscall.tbl                         | 1 +
 18 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 16dca28ebf17..3fed97478058 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -509,3 +509,4 @@
 577	common	open_tree_attr			sys_open_tree_attr
 578	common	file_getattr			sys_file_getattr
 579	common	file_setattr			sys_file_setattr
+580	common	listns				sys_listns
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index b07e699aaa3c..fd09afae72a2 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -484,3 +484,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 8d9088bc577d..8cdfe5d4dac9 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -481,3 +481,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f41d38dfbf13..871a5d67bf41 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 580af574fe73..022fc85d94b3 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index d824ffe9a014..8cedc83c3266 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -408,3 +408,4 @@
 467	n32	open_tree_attr			sys_open_tree_attr
 468	n32	file_getattr			sys_file_getattr
 469	n32	file_setattr			sys_file_setattr
+470	n32	listns				sys_listns
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 7a7049c2c307..9b92bddf06b5 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -384,3 +384,4 @@
 467	n64	open_tree_attr			sys_open_tree_attr
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
+470	n64	listns				sys_listns
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index d330274f0601..f810b8a55716 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -457,3 +457,4 @@
 467	o32	open_tree_attr			sys_open_tree_attr
 468	o32	file_getattr			sys_file_getattr
 469	o32	file_setattr			sys_file_setattr
+470	o32	listns				sys_listns
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 88a788a7b18d..39bdacaa530b 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -468,3 +468,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index b453e80dfc00..ec4458cdb97b 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -560,3 +560,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 8a6744d658db..5863787ab036 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -472,3 +472,4 @@
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
 468  common	file_getattr		sys_file_getattr		sys_file_getattr
 469  common	file_setattr		sys_file_setattr		sys_file_setattr
+470  common	listns			sys_listns			sys_listns
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 5e9c9eff5539..969c11325ade 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index ebb7d06d1044..39aa26b6a50b 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -515,3 +515,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4877e16da69a..e979a3eac7a3 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -475,3 +475,4 @@
 467	i386	open_tree_attr		sys_open_tree_attr
 468	i386	file_getattr		sys_file_getattr
 469	i386	file_setattr		sys_file_setattr
+470	i386	listns			sys_listns
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ced2a1deecd7..8a4ac4841be6 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -394,6 +394,7 @@
 467	common	open_tree_attr		sys_open_tree_attr
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
+470	common	listns			sys_listns
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 374e4cb788d8..438a3b170402 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 04e0077fb4c9..942370b3f5d2 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 __SYSCALL(__NR_file_getattr, sys_file_getattr)
 #define __NR_file_setattr 469
 __SYSCALL(__NR_file_setattr, sys_file_setattr)
+#define __NR_listns 470
+__SYSCALL(__NR_listns, sys_listns)
 
 #undef __NR_syscalls
-#define __NR_syscalls 470
+#define __NR_syscalls 471
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index d1ae5e92c615..e74868be513c 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -410,3 +410,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns

-- 
2.47.3


