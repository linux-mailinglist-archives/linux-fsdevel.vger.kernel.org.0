Return-Path: <linux-fsdevel+bounces-19423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74878C56C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EE01F2268F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79608145324;
	Tue, 14 May 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPZ/+k1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A91448FA;
	Tue, 14 May 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692656; cv=none; b=cdPJdGWpLhOFw+skeMuucJuYVNP3N8llzD+5ubgMynJr1bOdegu0PHKHanLcrthAABcGRkXybiTpvZMQScq3cSnx4hP/BO4cD7Di0ZrBGYoRCsM0RQ3urnwYcm9FyDA1F74GNsJIvaQfYBoK130482mAU8ISIFLPDsBp2/v2pNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692656; c=relaxed/simple;
	bh=ulT/s5cX3j0svT95px7lkL8CsGhoceWqlVXavAXUDtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p1zlYIhVjPefvIG0Jx77L71N9VdauPcHvo2tWTlBDu+3sqD3GoXpglOsEou8oplXVzO+/p9k9q1EcPB26NBGymUAvo21fPpaBNhBnF88ikd3dEzwf88pfWPKov3QMo6mTvsMbH8qd25RRJF2QF3fk81yd8OTJMuKlaaHprWM2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPZ/+k1F; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec4b2400b6so46101265ad.3;
        Tue, 14 May 2024 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692655; x=1716297455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxXuPD4yM3GcJ9ABIVPjOPrjHsRflgIYjf+iCopwXMY=;
        b=TPZ/+k1Fo0NFxBhGFcSzq0ZoKO4dF3UGvHX7CLJXeueGHehDFxrSbtGVJA3xXetNKG
         /G4dsWSNPlkOGFo7D4B7dLJEzZZ0oZvA7kLeu1060773ay5V/XAwpsbTOLA9dAKOX6Lr
         lWUU7hB7sIC8Qd8G3teeF6KpceWGm98w5WvWXJvqSaYUpPIERf68oCC4EWJcAdqGxNm/
         DJk5rDMIxtChdOD96In+mIucaj8y5jD+uahC01+FWSZ+EaxsjvQw2sRMp9x5j/G2CEcA
         FFLc9J/nCVhJy4fweH7sKfzSS/qHprNTMsn5KCk91G0YHwT8a4+q0zuhl3t1++VSUMSL
         1ssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692655; x=1716297455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxXuPD4yM3GcJ9ABIVPjOPrjHsRflgIYjf+iCopwXMY=;
        b=sT7XBkEbbeGStmk2j5TvBY1aaWhgm4lwVdyRRbWJDtZYg4OA+f/pMRjbOQo4AN7ryP
         dvJFvAEJq1xM86PXUW4lRJX2VE6t6cFq+C9RM25BMBky5e6XjeYs3PlhHf3sIzIyvuUz
         crZrJq843lbnRdHCLsHIqtF14LmYb70u0ALJtsTF5n3/q6dXEIj/Mrbom6E7XsEzXTHG
         GNKxno2l+n4sZ1yqBgssi4jC8g+Ou4LrzfD+3yZ6vynp6PCbdChSIq5ADkQfD0bvEV/E
         lwIROvW/Ox9+c5zQih+cQA/MW6VdDZqLfqt2cqndjMUpNf9lWU2UIawlg0l692Ktnbow
         HEfg==
X-Forwarded-Encrypted: i=1; AJvYcCVZXTp4E8R2SY7nV2xhkEM3D0gipHL48GBaboipEnPRC4VqC+uB2KuMSQQvRylIDHuciI8FMz4Fms1yHHWor7LUgmbHNSQmBtEbM+RAk7gREsFlajs/j0sMwSWssyc9Zl4WuS3li8jIiIwieVFfnrhZVC5PBiDw03uiF5GrEVfybEJsQJppTjB0W1yV
X-Gm-Message-State: AOJu0YyjJTTLHDcJrVV8LX92yh9iucARHVLOBxWFddLwuKWgdBqgxwsS
	ttabhP5dqhuxENOEi2oh63AkyQlfXcqS6xCAOJ7px0Ir7lmn2R83
X-Google-Smtp-Source: AGHT+IFxVcCYWwJhDo8hWiX/8GuxvpmQzY3PlTbvlhuiaypmP9HyXTHk6tHmOXY1QMWi3EBtWm06Ug==
X-Received: by 2002:a17:902:8e8b:b0:1e6:7700:1698 with SMTP id d9443c01a7336-1ef43e231f7mr116523535ad.35.1715692654698;
        Tue, 14 May 2024 06:17:34 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:34 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH v2 01/30] rust: fs: add registration/unregistration of file systems
Date: Tue, 14 May 2024 10:16:42 -0300
Message-Id: <20240514131711.379322-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514131711.379322-1-wedsonaf@gmail.com>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Allow basic registration and unregistration of Rust file system types.
Unregistration happens automatically when a registration variable is
dropped (e.g., when it goes out of scope).

File systems registered this way are visible in `/proc/filesystems` but
cannot be mounted yet because `init_fs_context` fails.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/error.rs |  2 --
 rust/kernel/fs.rs    | 75 ++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |  1 +
 3 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/fs.rs

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index b248a4c22fb4..f4fa2847e210 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -308,8 +308,6 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
 ///     })
 /// }
 /// ```
-// TODO: Remove `dead_code` marker once an in-kernel client is available.
-#[allow(dead_code)]
 pub(crate) fn from_result<T, F>(f: F) -> T
 where
     T: From<i16>,
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
new file mode 100644
index 000000000000..cc1ed7ed2f54
--- /dev/null
+++ b/rust/kernel/fs.rs
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel file systems.
+//!
+//! This module allows Rust code to register new kernel file systems.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
+
+use crate::error::{code::*, from_result, to_result, Error};
+use crate::types::Opaque;
+use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
+use core::{ffi, pin::Pin};
+use macros::{pin_data, pinned_drop};
+
+/// A file system type.
+pub trait FileSystem {
+    /// The name of the file system type.
+    const NAME: &'static CStr;
+}
+
+/// A registration of a file system.
+#[pin_data(PinnedDrop)]
+pub struct Registration {
+    #[pin]
+    fs: Opaque<bindings::file_system_type>,
+}
+
+// SAFETY: `Registration` doesn't provide any `&self` methods, so it is safe to pass references
+// to it around.
+unsafe impl Sync for Registration {}
+
+// SAFETY: Both registration and unregistration are implemented in C and safe to be performed
+// from any thread, so `Registration` is `Send`.
+unsafe impl Send for Registration {}
+
+impl Registration {
+    /// Creates the initialiser of a new file system registration.
+    pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            fs <- Opaque::try_ffi_init(|fs_ptr: *mut bindings::file_system_type| {
+                // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is valid for write.
+                unsafe { fs_ptr.write(bindings::file_system_type::default()) };
+
+                // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is valid for write, and it has
+                // just been initialised above, so it's also valid for read.
+                let fs = unsafe { &mut *fs_ptr };
+                fs.owner = module.0;
+                fs.name = T::NAME.as_char_ptr();
+                fs.init_fs_context = Some(Self::init_fs_context_callback);
+                fs.kill_sb = Some(Self::kill_sb_callback);
+                fs.fs_flags = 0;
+
+                // SAFETY: Pointers stored in `fs` are static so will live for as long as the
+                // registration is active (it is undone in `drop`).
+                to_result(unsafe { bindings::register_filesystem(fs_ptr) })
+            }),
+        })
+    }
+
+    unsafe extern "C" fn init_fs_context_callback(_fc: *mut bindings::fs_context) -> ffi::c_int {
+        from_result(|| Err(ENOTSUPP))
+    }
+
+    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_block) {}
+}
+
+#[pinned_drop]
+impl PinnedDrop for Registration {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: If an instance of `Self` has been successfully created, a call to
+        // `register_filesystem` has necessarily succeeded. So it's ok to call
+        // `unregister_filesystem` on the previously registered fs.
+        unsafe { bindings::unregister_filesystem(self.fs.get()) };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 4b629aa94735..e664f80b8141 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -31,6 +31,7 @@
 mod build_assert;
 pub mod error;
 pub mod file;
+pub mod fs;
 pub mod init;
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
-- 
2.34.1


