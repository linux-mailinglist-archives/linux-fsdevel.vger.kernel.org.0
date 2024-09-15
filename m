Return-Path: <linux-fsdevel+bounces-29407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61663979733
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210B628246F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE19A1C9EB5;
	Sun, 15 Sep 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lP8c0Ltx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0FD1C9DDF
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410714; cv=none; b=uS2IVIUhP+8aCQ/kWbJX4zz3w8WKuNLMsNCsUt9Va2Si29vaNit3eWL+hxzlUvJeEFkFFwVLK53O2Tw+s1pdkVEaqR/Glowg4UIiv6vWwzADb5zOSVYmtBunVzRNSVBKQAwPveDX8I/OVOwhj3Ye7LZ1jPKN3GzHxLiO0f8AsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410714; c=relaxed/simple;
	bh=zqB7PMivLvaNHUeozQVnq1eG1vfCAIQC9md71JxVrLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b8A3hiRlcs8ZfOV/4TU62jLsIqSQHY868UuZgHt1PHAK4Tkk0gvIF2xqezRwqUoKZKbVAbOY8CiLRJWvh9XkcDOl1OPPiI1MyYscBV17x6N0MUaUur9CCZJsVfLiAdPEY2PLBRI7Unc+qjbvs017MXPUKg6GyezhMWCiFcuiQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lP8c0Ltx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb2c9027dso27097155e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726410710; x=1727015510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+9+srUDgJEOquigCBUY1zqr31yRtNobeqSqwQ52i1M=;
        b=lP8c0LtxvyXX9FUYg1x52c5qBPk8ZegLMieOr54Qi10SK57ST3JMwY3y8vBp1T0ntU
         cKOtzCgfWcc1VwSwCQQ4mwAuCgGe3tN0N0TGw4whDN41g3qmAWXNmd3BNy5ujMw7FvOq
         ch7pa3gfNrKzhKAT27bsnsuo1HYABXuXu3kgrKmb+oOovD5gHFKXHNA1hjK5q2zecHjR
         DQXR66LeMFj0je2IMea3mHAuZNRGzNC4SUySWpjYvMNVhL5AjPScfO8PiZkjPXhQH5FM
         ZC+rOXIFqI2WWW4ZG8dQcKuRbYnyc0bSrEa24BiYYloMMPaIICqwRT+w0rZM6h0F6tBb
         cRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410710; x=1727015510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+9+srUDgJEOquigCBUY1zqr31yRtNobeqSqwQ52i1M=;
        b=hbYztOcfQ0wqO5OrxWMtJhqTcbMH06t/slVtZFO/UuiiktJH5UHlz0NRUM1AWhY8uU
         y+jGnGEYuA6RoBg9fHiACAf37Gy2fLF8j4Bs912UBCzjfgXpqeUXkbW7PmSpDLcm/2L7
         Ru7vJxOj7h3ukzHFopGjiGJVGVTS9Qf5jAvTFWi/v7OO2ouFORZPj3vS687yclJ/I953
         LdCHdiJ2c9QGsgha3QKUoiug0mHwob9k8O6KpPZ42Bt1XnZSBXV/g+cFmZDuY5XssGbR
         UYS8xD4nDdSPAvnXwu6Rxut4gRmLcLomSLoKQpnMOrADJU0MgrlR7JUDGwUKponz8S3e
         GUlA==
X-Forwarded-Encrypted: i=1; AJvYcCXyS4AyvAuzFEYHgdBjqk7is2nILqauRCJA2TbJ9C4s9iw0dauG0IfNoRQKrXYn8QmwJEG1CD0B6wFgPX7h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/NgiF4GzigAKd413JTnrc0dVx/qiSUveuXadFBs+9lzKWIL0i
	8w57UnyDGna49wf3m5psyuw3H6rX8yDJvCc3LqZEJO+YbVkAZg6ho8i4NqKiwLX+zECqG/kmkHd
	JftYhreWrU1H+cA==
X-Google-Smtp-Source: AGHT+IEa4LNRUZs7U02EZPuMJYs3657T2iAsYFHpFziLsdiq+5y8nCs9e0TpPTZRP6H3NZwQoX4+Ge4se9q+Y6I=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:4984:b0:42c:acab:d090 with SMTP
 id 5b1f17b1804b1-42cdb51153emr1817035e9.2.1726410710593; Sun, 15 Sep 2024
 07:31:50 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:31:32 +0000
In-Reply-To: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5412; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UusuKczZgpbZafCOu2SHAqb0ksf74QfeTn7LXrO42A0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5u/DJeMSoYje+0B76NnFNXI/hIns7KoesrsKS
 9PwYauTUkWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubvwwAKCRAEWL7uWMY5
 RquqD/9TQ3EwSzosmOZT9P7R4KT0im5i2FrNhk8HJ76gol9DIi9UU4ScEWMCM+NFetVWf4RehPK
 LcXPxfYku7nxRS1Q0CpAKD1WXgbsImT3eD7/3DJ4wwgkMl6PXD6FSuNRb9dRmjAmjxK1Js5gG6b
 eJJ/LvGdExSCRFQ7h520CpWsagx324C7ZyuSn/xdJfaFMxCjYkxiVneQerAgqjuY5UKrqPQ+aOd
 B5EG3Hl7plv925Q7Ws7zDyAnT19mFD10H7Mj36M0C/AXt5VQbC4WmrxFt5iz+UPZVn0mT4uHRWq
 2v8/pgihao9PgKIKBSJ9VvV8wOuwIpmZcY71mfndZSL3/0AY0UEQXXCg5ql7czStjxlbmTheNL8
 8EUZ6qE3ycprb2DIg7GoLhPHblvUkFtPlp4874CNBcGyLHdfsvfvgcVDfnwt1q19ELxRZmC2zDg
 XZl7eKvZyXfQIH12aPJFCPzwGKOGxgNAEiBHCLXhIRAWiW336iLK9FH2d2wlkWTMA19/9HVN5Vk
 yvRkcHXR7Ksgd9z6DSqR0E7qBPfqtVa0X8EAOj6wsIGVRvRQ53oc4ghtapB6icS2v8MegGPHHKh
 y0QxlWRmLhKktA4SiVunzSA4WtQLGeJ0EqcADNPHXTxjg97pRfKBJCk34qJTlh0wYtEp+yaLIj1 VFIJRgUPq/BkiiQ==
X-Mailer: b4 0.13.0
Message-ID: <20240915-alice-file-v10-6-88484f7a3dcf@google.com>
Subject: [PATCH v10 6/8] rust: file: add `FileDescriptorReservation`
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
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
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/fs/file.rs | 75 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 3c1f51719804..e03dbe14d62a 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -11,7 +11,7 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
-    types::{ARef, AlwaysRefCounted, Opaque},
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::ptr;
 
@@ -368,6 +368,79 @@ fn deref(&self) -> &LocalFile {
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
+    pub fn fd_install(self, file: ARef<File>) {
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
2.46.0.662.g92d0881bb0-goog


