Return-Path: <linux-fsdevel+bounces-19647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A28C8390
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAF91C208E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 09:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F043171;
	Fri, 17 May 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQmGULV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4ED3FE28
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938306; cv=none; b=AER4U9DibVe6+nBsR5m6Kl7DWz0h/6q+t2L+oWL7AzrNQuizGMDSGN7WMNKvNaAF6VdMZymiwjNhJyRsp4+sYn5quxp+qFYfpaMWadF1hylJwh5ghWHlI4Mx3mC+h/U425GFzEp5eCf/HUsrrGhIHC2+pflM+Hfwl44MJ4T2zJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938306; c=relaxed/simple;
	bh=zrnpqtimoZ37kf/nyfrTOhYa7cjwJKP4UYRJILYzUuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+fRCXaB5qUNdjl5SxXXBh5hs+L859cyXaiAAAQQ8hvY/AjGqQoNOva1c/5R73UP7kf8tVAOI2uOHW0x5EH8f7algWxBGNNHIrU2pfIM2hD0PsH/zdyHx0LPjWvW07xlfPC6TleCyy688SyTnfzExHUfd5wYcFzVUa0O1MDYUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQmGULV5; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2e3dcc3471aso64331751fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715938302; x=1716543102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pi+vb6MQ5BEJy1xNcUdMrF4dQt+71/uXPhL7pqGg3cw=;
        b=uQmGULV5dCaRC+ATnyL3c24On1WMl8uKCrzhICfAmG3OzNaxfs6Fh/hof0o+P+SxVl
         BOI5meT0WGPyIQFVQe/dwM8FxcVh2fV46TJCo+O3hlkoOMurmdrniRvZRV4tvQ11xEhD
         O+QfMxOlogwJgl/XH0sq2OW+FwgDoX9AhLj1vUwXo3bHtx4UuWoTcOELHcRGanDtgOEu
         YEYkl6PexD00l+oqTeubWfEvYNKEj5pT/99ue+wbpK4G4uB8nJu/AzJcDiHaQGMfOJ+a
         LPajLZ3FWY2JaSzgOTRPKH+/Rn2w9uH4z/XqOuwSjd8qFv6Vo2WHBHC8ZmcFalv8fgEk
         l+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715938302; x=1716543102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi+vb6MQ5BEJy1xNcUdMrF4dQt+71/uXPhL7pqGg3cw=;
        b=lBXsBAF747ANzlgSc09CJH2+GfOc8RSSxkifvlV15KDiNpiQsafMcquLVY3J86oUjL
         cEezQx5zTTgFBBn2ATsXP4rXzgxFT5ePN7+hmBYtmxpaf5AuwFbOdHxPW/favdFJIwY2
         L9IQaARR0BBsXxsf1h8vfSamPy/VAeHUklEyqQvn8KirutrJ4gupymcfRghtjnO13cR5
         GxnBP7TZTEVKyuqHbFPegZgbISl8W60CTDpuvCfZkzCct/J09gJPjq3VAGlZ2eOeMFbg
         F6U17qHJ5iBmBJ5IL+o9kmCr8P+OrhNLp7t8/HWK8JG6d5qr+l3q5BoKVr77IbqlNZM/
         lQIg==
X-Forwarded-Encrypted: i=1; AJvYcCVMg/OKQZofzjSUqPCoJ3ZrQXmEPNrbyOfz8NlNp+R4p6ixmT7i5IjoRg0a7QkdO96KqKFu5MmwYSvZIwHISX02HohJhdlYW0yIzTiS4w==
X-Gm-Message-State: AOJu0Yyz/PISRl7wyGIPsYl3uoSdgbSRp8Kzm98qDd+afr5OAQes+gkp
	ZQn3xdQpIQsurrpBJcVP/khBoLzwMx0xnYb1feZlx57pCXSDlh7gFAnHJldX7nXKBTt2xgENxOn
	Mmd9cEDxwvDmgZw==
X-Google-Smtp-Source: AGHT+IGKpRfboav2mm4OUlURp6VuCFcXdIMgVYPo4WqRQguEKMquWd4aH1LqTNcGlF2XO00OS6af/nntZE/1UMQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:988f:0:b0:2e5:59a:591e with SMTP id
 38308e7fff4ca-2e51f263fb7mr260591fa.0.1715938302687; Fri, 17 May 2024
 02:31:42 -0700 (PDT)
Date: Fri, 17 May 2024 09:30:39 +0000
In-Reply-To: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5411; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XrEHu4JLbtMUEek3iQr1jVqVytQpuj43RGhtLyO+FWc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmRyPnBEtIgqBjAxBEDiJ2/xP9/KIf2CZYSMBBi
 JFjUiZ6B2iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZkcj5wAKCRAEWL7uWMY5
 Rj03EACOZbEThWpy88bu0kgyPjHXacjxXprZlH8SqgZsVaWDb7YUIRvQ/9f9bLjOjH/s3h223Qa
 BjN7H1NrfrgfSu+o2bkOdVF4Cc4TxbjlOrosyHm1Q4EGTTuzn7bFPWfI4eheDwv7UuAoq7MXtSY
 0Z7pDsx9AIfW6X9RYs0eK9ZbYxsbyzsZlRbosUfS2RI9+PUV6/KZBwKguhXxuPJT7rc2Od/GzlC
 wxKla/WKfDrcBX3rrLihACqf2CL6RSSmgss1BStr8WLhRnoaDxfBy8/fLO94wY8V/qotenIMvWT
 K2SjwVhq5QZVHsUWf6Xi8NwYFicT4Zmk44f/Spzs0H2RHiv6WeIVm4c+ptZa4KF5VMpcu5N/hDX
 n6z/Lm45EgQ41VvddDfuAmln5Onl11bJKD02nQ00A1df7HL0gIqO6Dvbf1EVp/kJfg6PAMcfVws
 UdSRIxQArP9RBTT5+IFK+MKXb1zM61VBmc16Gu1O4/yoB0IJu/txmLPJO02JDhy9mVTLjNyyZry
 onmFyWXsesKUCoYVDBbBd2EvMipQJMEJDh/u/TrZhOVXDKDtBRpNqhnm/M2ZFa7KTcQ7xufmqG6
 zi5huvYdrqwqhfMDUAOSqUKjxSJLyiYSDg9iKOw7hPU2AaVMo5u5V8Xw5SU2PZcTJdSPNtHqpxp F1/peS9E0yWhK4Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240517-alice-file-v6-6-b25bafdc9b97@google.com>
Subject: [PATCH v6 6/8] rust: file: add `FileDescriptorReservation`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="utf-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Allow for the creation of a file descriptor in two steps: first, we
reserve a slot for it, then we commit or drop the reservation. The first
step may fail (e.g., the current process ran out of available slots),
but commit and drop never fail (and are mutually exclusive).

This is needed by Rust Binder when fds are sent from one process to
another. It has to be a two-step process to properly handle the case
where multiple fds are sent: The operation must fail or succeed
atomically, which we achieve by first reserving the fds we need, and
only installing the files once we have reserved enough fds to send the
files.

Fd reservations assume that the value of `current` does not change
between the call to get_unused_fd_flags and the call to fd_install (or
put_unused_fd). By not implementing the Send trait, this abstraction
ensures that the `FileDescriptorReservation` cannot be moved into a
different process.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/file.rs | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 755816eb38ef..d3d70df993c9 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -9,7 +9,7 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
-    types::{ARef, AlwaysRefCounted, Opaque},
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::{marker::PhantomData, ptr};
 
@@ -324,6 +324,79 @@ unsafe fn dec_ref(obj: ptr::NonNull<File<S>>) {
     }
 }
 
+/// A file descriptor reservation.
+///
+/// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
+/// then we commit or drop the reservation. The first step may fail (e.g., the current process ran
+/// out of available slots), but commit and drop never fail (and are mutually exclusive).
+///
+/// Dropping the reservation happens in the destructor of this type.
+///
+/// # Invariants
+///
+/// The fd stored in this struct must correspond to a reserved file descriptor of the current task.
+pub struct FileDescriptorReservation {
+    fd: u32,
+    /// Prevent values of this type from being moved to a different task.
+    ///
+    /// The `fd_install` and `put_unused_fd` functions assume that the value of `current` is
+    /// unchanged since the call to `get_unused_fd_flags`. By adding this marker to this type, we
+    /// prevent it from being moved across task boundaries, which ensures that `current` does not
+    /// change while this value exists.
+    _not_send: NotThreadSafe,
+}
+
+impl FileDescriptorReservation {
+    /// Creates a new file descriptor reservation.
+    pub fn get_unused_fd_flags(flags: u32) -> Result<Self> {
+        // SAFETY: FFI call, there are no safety requirements on `flags`.
+        let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
+        if fd < 0 {
+            return Err(Error::from_errno(fd));
+        }
+        Ok(Self {
+            fd: fd as u32,
+            _not_send: NotThreadSafe,
+        })
+    }
+
+    /// Returns the file descriptor number that was reserved.
+    pub fn reserved_fd(&self) -> u32 {
+        self.fd
+    }
+
+    /// Commits the reservation.
+    ///
+    /// The previously reserved file descriptor is bound to `file`. This method consumes the
+    /// [`FileDescriptorReservation`], so it will not be usable after this call.
+    pub fn fd_install(self, file: ARef<File<NoFdgetPos>>) {
+        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`. We have not yet used
+        // the fd, so it is still valid, and `current` still refers to the same task, as this type
+        // cannot be moved across task boundaries.
+        //
+        // Furthermore, the file pointer is guaranteed to own a refcount by its type invariants,
+        // and we take ownership of that refcount by not running the destructor below.
+        // Additionally, the file is known to not have any non-shared `fdget_pos` calls, so even if
+        // this process starts using the file position, this will not result in a data race on the
+        // file position.
+        unsafe { bindings::fd_install(self.fd, file.as_ptr()) };
+
+        // `fd_install` consumes both the file descriptor and the file reference, so we cannot run
+        // the destructors.
+        core::mem::forget(self);
+        core::mem::forget(file);
+    }
+}
+
+impl Drop for FileDescriptorReservation {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants of this type, `self.fd` was previously returned by
+        // `get_unused_fd_flags`. We have not yet used the fd, so it is still valid, and `current`
+        // still refers to the same task, as this type cannot be moved across task boundaries.
+        unsafe { bindings::put_unused_fd(self.fd) };
+    }
+}
+
 /// Represents the `EBADF` error code.
 ///
 /// Used for methods that can only fail with `EBADF`.

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


