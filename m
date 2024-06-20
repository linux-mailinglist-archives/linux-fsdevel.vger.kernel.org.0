Return-Path: <linux-fsdevel+bounces-22005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB80910CDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 18:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5202F1F2104C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269651BD026;
	Thu, 20 Jun 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mgf3e1Fh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830A1B3F17;
	Thu, 20 Jun 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900719; cv=none; b=AcnVL7KjTNAyp8NWMOaq/B2bsvl8Bg6kZeYBQlED2ugDYc/qyOWCRNe8lJX4H8e8v/AZdpKmNzM1MtcLPHz/6IviDF580QQ5f3IBdrZ/AhJiEtp4Lee8XKr8PClmUlaFh9PmnPg+4zJiik6OuaHms20ypRkawjRQuDgtH1zhQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900719; c=relaxed/simple;
	bh=kDUL0eQ/6YSJ1bK+6Lr69ZdPp0RU2xbPAfoz6UW7TTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+TxOH9W4/vMJbE0pwqQ1uU74mnkGkbKEWqTzvl+I/1HWgzoAi2UEoD99fIEay3FT2rfa2MnZ6x/q0dbrnaIPVdYVc+9UCo3dKs915Pca/MQ4+iadBW77MGz3JwG6NXOSgvMLr+ctDx1a+P+ePIwEHb623BkrWnYgz70syw/sUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mgf3e1Fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1817C32786;
	Thu, 20 Jun 2024 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900719;
	bh=kDUL0eQ/6YSJ1bK+6Lr69ZdPp0RU2xbPAfoz6UW7TTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mgf3e1FhIJ34BxmZFn82Ln9S0Qv6QXhxwCJKDARqYjkFgu+PeLy+HbQQiPNlRIlpH
	 CJPg8GeMhGdXNWnFJ7rs6CxgQTJgS3aIOdECU1hUTPI3GTqq1wFPc1n7ygAUyYEwl9
	 +8r+PlwF95EJ6Ir8u8mktZFBaZpsQVlPwxTyDXM7TdcPf38yXtOg8ExYgy0jNH9ePX
	 1ViSkxDmMk4r4dOWXWQ9/QUe8Zx98JIfQyCBmd0SwBnHw1BZMRTpQwEpjMClIy+kE/
	 qhRXIrGZpKimne/UDkbRtj9V6uWojsT4fcxvIhFSPeJGeHucTaUEAfjbySdUDB53iI
	 PtNJzQd1HEs7A==
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
Subject: [PATCH 15/15] linux/syscalls.h: add missing __user annotations
Date: Thu, 20 Jun 2024 18:23:16 +0200
Message-Id: <20240620162316.3674955-16-arnd@kernel.org>
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

A couple of declarations in linux/syscalls.h are missing __user
annotations on their pointers, which can lead to warnings from
sparse because these don't match the implementation that have
the correct address space annotations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/syscalls.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index ba9337709878..63424af87bba 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -322,13 +322,13 @@ asmlinkage long sys_io_pgetevents(aio_context_t ctx_id,
 				long nr,
 				struct io_event __user *events,
 				struct __kernel_timespec __user *timeout,
-				const struct __aio_sigset *sig);
+				const struct __aio_sigset __user *sig);
 asmlinkage long sys_io_pgetevents_time32(aio_context_t ctx_id,
 				long min_nr,
 				long nr,
 				struct io_event __user *events,
 				struct old_timespec32 __user *timeout,
-				const struct __aio_sigset *sig);
+				const struct __aio_sigset __user *sig);
 asmlinkage long sys_io_uring_setup(u32 entries,
 				struct io_uring_params __user *p);
 asmlinkage long sys_io_uring_enter(unsigned int fd, u32 to_submit,
@@ -441,7 +441,7 @@ asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
 asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
 			   umode_t mode);
 asmlinkage long sys_openat2(int dfd, const char __user *filename,
-			    struct open_how *how, size_t size);
+			    struct open_how __user *how, size_t size);
 asmlinkage long sys_close(unsigned int fd);
 asmlinkage long sys_close_range(unsigned int fd, unsigned int max_fd,
 				unsigned int flags);
@@ -555,7 +555,7 @@ asmlinkage long sys_get_robust_list(int pid,
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
-asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
+asmlinkage long sys_futex_waitv(struct futex_waitv __user *waiters,
 				unsigned int nr_futexes, unsigned int flags,
 				struct __kernel_timespec __user *timeout, clockid_t clockid);
 
@@ -907,7 +907,7 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
-asmlinkage long sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
+asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
 			const char __user *const __user *argv,
 			const char __user *const __user *envp, int flags);
@@ -960,11 +960,11 @@ asmlinkage long sys_cachestat(unsigned int fd,
 		struct cachestat_range __user *cstat_range,
 		struct cachestat __user *cstat, unsigned int flags);
 asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
-asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
-				      u32 *size, u32 flags);
-asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
+				      u32 __user *size, u32 flags);
+asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
 				      u32 size, u32 flags);
-asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);
+asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
 
 /*
  * Architecture-specific system calls
-- 
2.39.2


