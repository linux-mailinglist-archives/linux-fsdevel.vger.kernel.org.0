Return-Path: <linux-fsdevel+bounces-40217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F1A2089D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805181887D1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE419F40A;
	Tue, 28 Jan 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXqxE6d4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6F19F135
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060450; cv=none; b=V6dWwHKeIRKErdprDwOpvVT+R9EdIjVEy5Spi+9h6rMap/sTr3avxdeQ/0HYuSVKBNUVqsh5f69nJgKUqrEOSJbPODGOzj7DfC2+56u6esHGhNR1CLhk8xB0oeiuAJa1lQWPkpI9imB+2/4oFLTvOhZAbLLWQWqQ5BaquYM/4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060450; c=relaxed/simple;
	bh=l5Skrm9EWdfc/SzE8hRuoLDcjPQDcYV42cNxO/WZkf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNat/yvGsCxg/N6E730S+II9hEYCSs1dyzn21VwUJHW8HlLQlIJaWBENja7+CGLpMjbMpZPloJJzMGkZ3Q7DfPcYcUcIcDvHkw3RS5i32FZBPFDVym3ZsF+7Cod8+VNiwHbYvghfWgF8AEBfrGq7drQH7J0mwT3o8P1h5m32yUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXqxE6d4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410F9C4CEE3;
	Tue, 28 Jan 2025 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738060449;
	bh=l5Skrm9EWdfc/SzE8hRuoLDcjPQDcYV42cNxO/WZkf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SXqxE6d4Qw85zBEPp5AzknRPzZZRgFnDe1ttYjtLKV7kk0QNKKG1HlLqOsXG1Wt/5
	 jqL69t0SbEePiOL2rMW7FSeibfRXGgZYUBI9DGeZzx6K0LQmHOMvGCEmUTOeVJTzRj
	 My/n+wMYqg+pm8gpxPq+Uvs+cEbZPbbpFUgdDyrg3aRuXGC1/Nsl2UEIhl3K4rewSw
	 oaF0G/pNhOi2cmxu8k3anJ8qFCQJ3nRMOP6fPLd4xcUUbIlY8qjLOFEFCh2UyL1Zza
	 oFEos4dTPoLwvYzOUhsJllTSVxl328yQ0jU+K3dya/fUXncybfcXLzSXXugM/OulBB
	 BDd9ikXTFMl0g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jan 2025 11:33:41 +0100
Subject: [PATCH 3/5] fs: add open_tree_attr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-work-mnt_idmap-update-v2-v1-3-c25feb0d2eb3@kernel.org>
References: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
In-Reply-To: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=12503; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l5Skrm9EWdfc/SzE8hRuoLDcjPQDcYV42cNxO/WZkf8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2DTt0JpNFmtP+an4mP/uT3fYbyP5cq3o/+aNBQeDy
 sQ9QxjjOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayuYuR4dXs2pL+Y1rJ6l9y
 bUXrb0sGH9n5uIfTZfmsLn6HClkGV4a/EsXXV93n+n448yTb9ApNm38H76rs/HD0H3uXZVz5BCk
 DXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add open_tree_attr() which allow to atomically create a detached mount
tree and set mount options on it. If OPEN_TREE_CLONE is used this will
allow the creation of a detached mount with a new set of mount options
without it ever being exposed to userspace without that set of mount
options applied.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/tools/syscall_32.tbl             |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/namespace.c                              | 39 +++++++++++++++++++++++++++++
 include/linux/syscalls.h                    |  4 +++
 include/uapi/asm-generic/unistd.h           |  4 ++-
 scripts/syscall.tbl                         |  1 +
 20 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index c59d53d6d3f3490f976ca179ddfe02e69265ae4d..2dd6340de6b4efddc406f0c235701c15cf02f650 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -506,3 +506,4 @@
 574	common	getxattrat			sys_getxattrat
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
+577	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 49eeb2ad8dbd8e074c6240417693f23fb328afa8..27c1d5ebcd91c8c296dc6676307f66bfdf4ab78d 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -481,3 +481,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 69a829912a05eb8a3e21ed701d1030e31c0148bc..0765b3a8d6d600d7b9f83182d401d9f80c03476c 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -478,3 +478,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f5ed71f1910d09769c845c2d062d99ee0449437c..9fe47112c586f152662af38a9a7f90957cb96cf8 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -466,3 +466,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 680f568b77f2cbefc3eacb2517f276041f229b1e..7b6e97828e552d4da90046ddfcd4a55723e522bb 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -472,3 +472,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0b9b7e25b69ad592642f8533bee9ccfe95ce9626..aa70e371bb54ab5d9c8dd8923b6ecf9693ee914d 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -405,3 +405,4 @@
 464	n32	getxattrat			sys_getxattrat
 465	n32	listxattrat			sys_listxattrat
 466	n32	removexattrat			sys_removexattrat
+467	n32	open_tree_attr			sys_open_tree_attr
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c844cd5cda620b2809a397cdd6f4315ab6a1bfe2..1e8c44c7b61492eabf00c777831e457a7a6e579c 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -381,3 +381,4 @@
 464	n64	getxattrat			sys_getxattrat
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
+467	n64	open_tree_attr			sys_open_tree_attr
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index e8a57c2067580618f4635f9582bcec4c4b2a92c5..dbbba6c4465f6af5124c8c9f1ade4da8c5407ca6 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -454,3 +454,4 @@
 464	o32	getxattrat			sys_getxattrat
 465	o32	listxattrat			sys_listxattrat
 466	o32	removexattrat			sys_removexattrat
+467	o32	open_tree_attr			sys_open_tree_attr
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index d9fc94c869657fcfbd7aca1d5f5abc9fae2fb9d8..94df3cb957e9d547d192e8732c0cf23ef2b5ce5d 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -465,3 +465,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index d8b4ab78bef076bd50d49b87dea5060fd8c1686a..9a084bdb892694bc562f514b55212d167cbac12f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -557,3 +557,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e9115b4d8b635b846e5c9ad6ce229605323723a5..a4569b96ef06c54ce7aa795d039541c90a38284f 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 464  common	getxattrat		sys_getxattrat			sys_getxattrat
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
+467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c8cad33bf250ea110de37bd1407f5a43ec5e38f2..52a7652fcff6394b96ace1f3b0ed72250ee5e669 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -470,3 +470,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 727f99d333b304b3db0711953a3d91ece18a28eb..83e45eb6c095a36baaf749927628e6052fe900e6 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -512,3 +512,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4d0fb2fba7e208ae9455459afe11e277321d9f74..3f0ec87d5db4e290c62e2ffa6391a431a00dd36a 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -472,3 +472,4 @@
 464	i386	getxattrat		sys_getxattrat
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
+467	i386	open_tree_attr		sys_open_tree_attr
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5eb708bff1c791debd6cfc5322583b2ae53f6437..cfb5ca41e30de1a4e073750096f5b51a2ec137d2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -390,6 +390,7 @@
 464	common	getxattrat		sys_getxattrat
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
+467	common	open_tree_attr		sys_open_tree_attr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 37effc1b134eea061f2c350c1d68b4436b65a4dd..f657a77314f8667fa019a01e10c84ea270024adc 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/fs/namespace.c b/fs/namespace.c
index ef7db39c8776ab13da968d7f69c56698e3846914..2a188a6c8df2bceed61c86877e91b87fd154c5a0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4902,6 +4902,45 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	return err;
 }
 
+SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
+		unsigned, flags, struct mount_attr __user *, uattr,
+		size_t, usize)
+{
+	struct file __free(fput) *file = NULL;
+	int fd;
+
+	if (!uattr && usize)
+		return -EINVAL;
+
+	file = vfs_open_tree(dfd, filename, flags);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	if (uattr) {
+		int ret;
+		struct mount_kattr kattr = {
+			.recurse = !!(flags & AT_RECURSIVE),
+		};
+
+		ret = copy_mount_setattr(uattr, usize, &kattr);
+		if (ret)
+			return ret;
+
+		ret = do_mount_setattr(&file->f_path, &kattr);
+		if (ret)
+			return ret;
+
+		finish_mount_kattr(&kattr);
+	}
+
+	fd = get_unused_fd_flags(flags & O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+
+	fd_install(fd, no_free_ptr(file));
+	return fd;
+}
+
 int show_path(struct seq_file *m, struct dentry *root)
 {
 	if (root->d_sb->s_op->show_path)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c6333204d45130eb022f6db460eea34a1f6e91db..079ea1d09d85e60bd87fbbe66e1b2f551705c56d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -951,6 +951,10 @@ asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
 			 int flags, uint32_t sig);
 asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
+asmlinkage long sys_open_tree_attr(int dfd, const char __user *path,
+				   unsigned flags,
+				   struct mount_attr __user *uattr,
+				   size_t usize);
 asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
 			       int to_dfd, const char __user *to_path,
 			       unsigned int ms_flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 88dc393c2bca38c0fa1b3fae579f7cfe4931223c..2892a45023af6d3eb941623d4fed04841ab07e02 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -849,9 +849,11 @@ __SYSCALL(__NR_getxattrat, sys_getxattrat)
 __SYSCALL(__NR_listxattrat, sys_listxattrat)
 #define __NR_removexattrat 466
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
+#define __NR_open_tree_attr 467
+__SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 467
+#define __NR_syscalls 468
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index ebbdb3c42e9f74613b003014c0baf44c842bb756..580b4e246aecd5f07d542943ba68fc4ed5961660 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -407,3 +407,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr

-- 
2.45.2


