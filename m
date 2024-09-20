Return-Path: <linux-fsdevel+bounces-29733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E9F97CFFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 04:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F80B1F247E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1471F949;
	Fri, 20 Sep 2024 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="ZcZSdQbp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C70182B4;
	Fri, 20 Sep 2024 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726800589; cv=none; b=tr01dgHiezttoQN21mbGrZVMNU2DlOpuPU5svLBx/9Z4bc/Tod1gxfDq+gN+ATtKOWpLcv2AVeWymwR6JRQEP8Ak9amN1wUItzTQvd6s+KB1MPv3tw257nKw4FjpK2jTZb+01rk6Qshlv+/gpS4LtMDlDu800DdYE14AzrUOpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726800589; c=relaxed/simple;
	bh=7s7z8s8PYFj605b0pz69iQfPrDeoExUDO/ymT/8WqlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bojl0zcGnptwQNw7mpFbo4MlP/Md88t6nmWfKu/V/t/eFEMiaUnZlitsfKbzO5PsSa9iXXZtiWqdvdhj2TtS5hvvtsWrtM4hAvNzFJ5vKHT4DvpcWe5ru2Cw+y0U560hc57AbfDa3lsf/G4bqK5s61sPsIXbFvZqSo59TY55wwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=ZcZSdQbp; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E02B36983F;
	Thu, 19 Sep 2024 22:49:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726800584; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kqk81g7cDt96LcsILwVIIivCeMHJdyCwfxcWpXlbjK8=;
	b=ZcZSdQbp0VIvi0hfV0+927P1+M62iDNMPEz8UWh77he1IbyVS8s/xfcerNU97WMcSpe4It
	R1kVb/4LL5o9xetugpbqxLTEZN4aS7SAknhy4/zhXOdgJLfk66eLW8cLEuet/nekxGdGtE
	VNe/jAajUxhGXzCTWtAzEB4KygCCsKR4MEmBV/NANbcUiw1aW6eyoAfKFtGrBK6jdc9j/t
	OfznPOPYLnnXj8aRGZZobGAeY43OmcdTNKwZG3PMqhv/UXZLLPRGmLEuJbtwb9uVMvDr1Y
	c3xZ0GuAZkcmDtSR7g3pfZ7mjEjwvxr4CMZ6ixa0xKIFJX0AX3fSho3Zu58Aog==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: rust-for-linux@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	xiang@kernel.org,
	gary@garyguo.net,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND 1/1] rust: error: auto-generate error declarations
Date: Fri, 20 Sep 2024 10:49:19 +0800
Message-ID: <20240920024920.215842-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240920024920.215842-1-toolmanp@tlmp.cc>
References: <2024091602-bannister-giddy-0d6e@gregkh>
 <20240920024920.215842-1-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch adds a new cmd_errno to convert the include/linux/errno.h
content into declare_err! macros for better maintainability and readability.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 rust/.gitignore      |  1 +
 rust/Makefile        | 14 ++++++++++-
 rust/kernel/error.rs | 58 +++-----------------------------------------
 3 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/rust/.gitignore b/rust/.gitignore
index d3829ffab80b..ba71ef4a9239 100644
--- a/rust/.gitignore
+++ b/rust/.gitignore
@@ -5,6 +5,7 @@ bindings_helpers_generated.rs
 doctests_kernel_generated.rs
 doctests_kernel_generated_kunit.c
 uapi_generated.rs
+errno_generated.rs
 exports_*_generated.h
 doc/
 test/
diff --git a/rust/Makefile b/rust/Makefile
index dd76dc27d666..f5a1680fe59c 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -22,6 +22,8 @@ always-$(CONFIG_RUST) += exports_alloc_generated.h exports_helpers_generated.h \
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
 obj-$(CONFIG_RUST) += uapi.o
 
+always-$(CONFIG_RUST) += kernel/errno_generated.rs
+
 ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
 obj-$(CONFIG_RUST) += build_error.o
 else
@@ -289,6 +291,15 @@ $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
 
+quiet_cmd_errno = EXPORTS $@
+      cmd_errno = \
+	$(CC) $(c_flags) -E -CC -dD $< \
+	| sed -E 's/\#define\s*([A-Z0-9]+)\s+([0-9]+)\s+\/\*\s*(.*)\s\*\//declare_err!(\1, "\3.");/' \
+	| grep -E '^declare_err.*$$' > $@
+
+$(obj)/kernel/errno_generated.rs: $(srctree)/include/linux/errno.h FORCE
+	$(call if_changed,errno)
+
 # See `CFLAGS_REMOVE_helpers.o` above. In addition, Clang on C does not warn
 # with `-Wmissing-declarations` (unlike GCC), so it is not strictly needed here
 # given it is `libclang`; but for consistency, future Clang changes and/or
@@ -420,7 +431,8 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
 
 $(obj)/kernel.o: private rustc_target_flags = --extern alloc \
     --extern build_error --extern macros --extern bindings --extern uapi
-$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
+$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/kernel/errno_generated.rs \
+    $(obj)/alloc.o $(obj)/build_error.o \
     $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6f1587a2524e..bb16b40a8d19 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -23,60 +23,10 @@ macro_rules! declare_err {
             pub const $err: super::Error = super::Error(-(crate::bindings::$err as i32));
         };
     }
-
-    declare_err!(EPERM, "Operation not permitted.");
-    declare_err!(ENOENT, "No such file or directory.");
-    declare_err!(ESRCH, "No such process.");
-    declare_err!(EINTR, "Interrupted system call.");
-    declare_err!(EIO, "I/O error.");
-    declare_err!(ENXIO, "No such device or address.");
-    declare_err!(E2BIG, "Argument list too long.");
-    declare_err!(ENOEXEC, "Exec format error.");
-    declare_err!(EBADF, "Bad file number.");
-    declare_err!(ECHILD, "No child processes.");
-    declare_err!(EAGAIN, "Try again.");
-    declare_err!(ENOMEM, "Out of memory.");
-    declare_err!(EACCES, "Permission denied.");
-    declare_err!(EFAULT, "Bad address.");
-    declare_err!(ENOTBLK, "Block device required.");
-    declare_err!(EBUSY, "Device or resource busy.");
-    declare_err!(EEXIST, "File exists.");
-    declare_err!(EXDEV, "Cross-device link.");
-    declare_err!(ENODEV, "No such device.");
-    declare_err!(ENOTDIR, "Not a directory.");
-    declare_err!(EISDIR, "Is a directory.");
-    declare_err!(EINVAL, "Invalid argument.");
-    declare_err!(ENFILE, "File table overflow.");
-    declare_err!(EMFILE, "Too many open files.");
-    declare_err!(ENOTTY, "Not a typewriter.");
-    declare_err!(ETXTBSY, "Text file busy.");
-    declare_err!(EFBIG, "File too large.");
-    declare_err!(ENOSPC, "No space left on device.");
-    declare_err!(ESPIPE, "Illegal seek.");
-    declare_err!(EROFS, "Read-only file system.");
-    declare_err!(EMLINK, "Too many links.");
-    declare_err!(EPIPE, "Broken pipe.");
-    declare_err!(EDOM, "Math argument out of domain of func.");
-    declare_err!(ERANGE, "Math result not representable.");
-    declare_err!(ERESTARTSYS, "Restart the system call.");
-    declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
-    declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-    declare_err!(ENOIOCTLCMD, "No ioctl command.");
-    declare_err!(ERESTART_RESTARTBLOCK, "Restart by calling sys_restart_syscall.");
-    declare_err!(EPROBE_DEFER, "Driver requests probe retry.");
-    declare_err!(EOPENSTALE, "Open found a stale dentry.");
-    declare_err!(ENOPARAM, "Parameter not supported.");
-    declare_err!(EBADHANDLE, "Illegal NFS file handle.");
-    declare_err!(ENOTSYNC, "Update synchronization mismatch.");
-    declare_err!(EBADCOOKIE, "Cookie is stale.");
-    declare_err!(ENOTSUPP, "Operation is not supported.");
-    declare_err!(ETOOSMALL, "Buffer or request is too small.");
-    declare_err!(ESERVERFAULT, "An untranslatable error occurred.");
-    declare_err!(EBADTYPE, "Type not supported by server.");
-    declare_err!(EJUKEBOX, "Request initiated, but will not complete before timeout.");
-    declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
-    declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
-    declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    include!(concat!(
+        env!("OBJTREE"),
+        "/rust/kernel/errno_generated.rs"
+    ));
 }
 
 /// Generic integer kernel error.
-- 
2.46.0


