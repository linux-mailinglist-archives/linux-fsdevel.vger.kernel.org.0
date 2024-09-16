Return-Path: <linux-fsdevel+bounces-29471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7A97A327
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 15:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935B6B20D83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67A6156887;
	Mon, 16 Sep 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b="gyk0nQmk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E1155A59;
	Mon, 16 Sep 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.135.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494970; cv=none; b=RY7w8D92Wco6PJsq72zP3iT0u9zcZy3GNh31nX29MyWCvRZjg++FtvBe9Nz7fmSuMdj4k8rgF0PjBfBcuz3VNUC6+2waiwCbyrSE7Qr/W8BxEJ2RxyN6uM20G+bCR/m24/zto2pHKQ7rYM4VAR666y8+fAp6BYGgOpGymCpvRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494970; c=relaxed/simple;
	bh=vQLgpg+Uh6AnmzozA6msIhCQdsV7m8apo306xrKuq7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcoJ5A7960sbi8wmIYOD3p/o2l0+E5xsqXKNyqe1JoYx4EGviG7IIPp0ysCD4C2XwKxdvG8gHPobY0ck41QleTHQ+hrQtu5uo4y3RybK8338AwcSIM/t+eWWak0ZiXo5WEn135EZ3hz+KQxmHYBE+PmfLrDSXECueq0wdqCI5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; spf=pass smtp.mailfrom=tlmp.cc; dkim=pass (2048-bit key) header.d=tlmp.cc header.i=@tlmp.cc header.b=gyk0nQmk; arc=none smtp.client-ip=148.135.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tlmp.cc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EAF26997C;
	Mon, 16 Sep 2024 09:56:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494966; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZuP3bujGZDBP75xkwLAFw1ksH6b/fY1knDKclkC/wOs=;
	b=gyk0nQmkxsEqOOxgE8ynnJjvoHp7k6fjXxzCvSyGQOfo+h9L0F5KJATkjaAn0pWRdTQET5
	Ue3ZEkO9CNHy3yU0EEktidTpqs37MehOPJvMo1OfE+r8OWe6W5R1FAYIvXTk5R8vhMjngK
	/kFb/8wgj2A7qaVWEbHumKFTmOLw8Tx8NoSubGjhKlKjao3eo63ffH2xIeH5/GERY/SBwX
	I6N6IBG8vCe67HLzkEbYvzW3UmEaM+97jK8Ojlckv7G71Hyh54Ug2Ny5UMibB1ln0qr6yg
	tfFRmmQzVy8oFe/9IV0xkW75hEIocoxCZQWudbMlxHk8N6O/NkaKhZcC7gKfqQ==
From: Yiyang Wu <toolmanp@tlmp.cc>
To: linux-erofs@lists.ozlabs.org
Cc: rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 03/24] erofs: add Errno in Rust
Date: Mon, 16 Sep 2024 21:55:20 +0800
Message-ID: <20240916135541.98096-4-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135541.98096-1-toolmanp@tlmp.cc>
References: <20240916135541.98096-1-toolmanp@tlmp.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Introduce Errno to Rust side code. Note that in current Rust For Linux,
Errnos are implemented as core::ffi::c_uint unit structs.
However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.

Since the errno_base hasn't changed for over 13 years,
This patch merely serves as a temporary workaround for the missing
errno in the Rust For Linux.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs        |   6 +
 fs/erofs/rust/erofs_sys/errnos.rs | 191 ++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/errnos.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 0f1400175fc2..2bd1381da5ab 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -19,4 +19,10 @@
 pub(crate) type Nid = u64;
 /// Erofs Super Offset to read the ondisk superblock
 pub(crate) const EROFS_SUPER_OFFSET: Off = 1024;
+/// PosixResult as a type alias to kernel::error::Result
+/// to avoid naming conflicts.
+pub(crate) type PosixResult<T> = Result<T, Errno>;
+
+pub(crate) mod errnos;
 pub(crate) mod superblock;
+pub(crate) use errnos::Errno;
diff --git a/fs/erofs/rust/erofs_sys/errnos.rs b/fs/erofs/rust/erofs_sys/errnos.rs
new file mode 100644
index 000000000000..40e5cdbcb353
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/errnos.rs
@@ -0,0 +1,191 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+#[repr(i32)]
+#[non_exhaustive]
+#[allow(clippy::upper_case_acronyms)]
+#[derive(Debug, Copy, Clone, PartialEq)]
+pub(crate) enum Errno {
+    NONE = 0,
+    EPERM,
+    ENOENT,
+    ESRCH,
+    EINTR,
+    EIO,
+    ENXIO,
+    E2BIG,
+    ENOEXEC,
+    EBADF,
+    ECHILD,
+    EAGAIN,
+    ENOMEM,
+    EACCES,
+    EFAULT,
+    ENOTBLK,
+    EBUSY,
+    EEXIST,
+    EXDEV,
+    ENODEV,
+    ENOTDIR,
+    EISDIR,
+    EINVAL,
+    ENFILE,
+    EMFILE,
+    ENOTTY,
+    ETXTBSY,
+    EFBIG,
+    ENOSPC,
+    ESPIPE,
+    EROFS,
+    EMLINK,
+    EPIPE,
+    EDOM,
+    ERANGE,
+    EDEADLK,
+    ENAMETOOLONG,
+    ENOLCK,
+    ENOSYS,
+    ENOTEMPTY,
+    ELOOP,
+    ENOMSG = 42,
+    EIDRM,
+    ECHRNG,
+    EL2NSYNC,
+    EL3HLT,
+    EL3RST,
+    ELNRNG,
+    EUNATCH,
+    ENOCSI,
+    EL2HLT,
+    EBADE,
+    EBADR,
+    EXFULL,
+    ENOANO,
+    EBADRQC,
+    EBADSLT,
+    EBFONT = 59,
+    ENOSTR,
+    ENODATA,
+    ETIME,
+    ENOSR,
+    ENONET,
+    ENOPKG,
+    EREMOTE,
+    ENOLINK,
+    EADV,
+    ESRMNT,
+    ECOMM,
+    EPROTO,
+    EMULTIHOP,
+    EDOTDOT,
+    EBADMSG,
+    EOVERFLOW,
+    ENOTUNIQ,
+    EBADFD,
+    EREMCHG,
+    ELIBACC,
+    ELIBBAD,
+    ELIBSCN,
+    ELIBMAX,
+    ELIBEXEC,
+    EILSEQ,
+    ERESTART,
+    ESTRPIPE,
+    EUSERS,
+    ENOTSOCK,
+    EDESTADDRREQ,
+    EMSGSIZE,
+    EPROTOTYPE,
+    ENOPROTOOPT,
+    EPROTONOSUPPORT,
+    ESOCKTNOSUPPORT,
+    EOPNOTSUPP,
+    EPFNOSUPPORT,
+    EAFNOSUPPORT,
+    EADDRINUSE,
+    EADDRNOTAVAIL,
+    ENETDOWN,
+    ENETUNREACH,
+    ENETRESET,
+    ECONNABORTED,
+    ECONNRESET,
+    ENOBUFS,
+    EISCONN,
+    ENOTCONN,
+    ESHUTDOWN,
+    ETOOMANYREFS,
+    ETIMEDOUT,
+    ECONNREFUSED,
+    EHOSTDOWN,
+    EHOSTUNREACH,
+    EALREADY,
+    EINPROGRESS,
+    ESTALE,
+    EUCLEAN,
+    ENOTNAM,
+    ENAVAIL,
+    EISNAM,
+    EREMOTEIO,
+    EDQUOT,
+    ENOMEDIUM,
+    EMEDIUMTYPE,
+    ECANCELED,
+    ENOKEY,
+    EKEYEXPIRED,
+    EKEYREVOKED,
+    EKEYREJECTED,
+    EOWNERDEAD,
+    ENOTRECOVERABLE,
+    ERFKILL,
+    EHWPOISON,
+    EUNKNOWN,
+}
+
+impl From<i32> for Errno {
+    fn from(value: i32) -> Self {
+        if (-value) <= 0 || (-value) > Errno::EUNKNOWN as i32 {
+            Errno::EUNKNOWN
+        } else {
+            // Safety: The value is guaranteed to be a valid errno and the memory
+            // layout is the same for both types.
+            unsafe { core::mem::transmute(value) }
+        }
+    }
+}
+
+impl From<Errno> for i32 {
+    fn from(value: Errno) -> Self {
+        -(value as i32)
+    }
+}
+
+/// Replacement for ERR_PTR in Linux Kernel.
+impl From<Errno> for *const core::ffi::c_void {
+    fn from(value: Errno) -> Self {
+        (-(value as core::ffi::c_long)) as *const core::ffi::c_void
+    }
+}
+
+impl From<Errno> for *mut core::ffi::c_void {
+    fn from(value: Errno) -> Self {
+        (-(value as core::ffi::c_long)) as *mut core::ffi::c_void
+    }
+}
+
+/// Replacement for PTR_ERR in Linux Kernel.
+impl From<*const core::ffi::c_void> for Errno {
+    fn from(value: *const core::ffi::c_void) -> Self {
+        (-(value as i32)).into()
+    }
+}
+
+impl From<*mut core::ffi::c_void> for Errno {
+    fn from(value: *mut core::ffi::c_void) -> Self {
+        (-(value as i32)).into()
+    }
+}
+/// Replacement for IS_ERR in Linux Kernel.
+#[inline(always)]
+pub(crate) fn is_value_err(value: *const core::ffi::c_void) -> bool {
+    (value as core::ffi::c_ulong) >= (-4095 as core::ffi::c_long) as core::ffi::c_ulong
+}
-- 
2.46.0


