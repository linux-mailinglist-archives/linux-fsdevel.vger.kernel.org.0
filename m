Return-Path: <linux-fsdevel+bounces-22789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B78F91C1ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F2E281DB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5A1CB324;
	Fri, 28 Jun 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EaZ0pUsP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21531C9EBE
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586687; cv=none; b=Jlc93MHSgRcCjOK0LAX9M6MhImNcbvvDEFstn3A4u8IIx6Yd1NxCxplhJIBXfkQiR2FThyuiHlPFatF8QpQy8eEVJGSbjGgh3+qFpl57QSIWRTBkxvaadwfJPA/5d3vee2x+Psq4dHnUqXB2saIFA4PGvy7Y2H/F6Jf1KqWefcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586687; c=relaxed/simple;
	bh=RpuLWvo82s8TWdt4dzVRvAC2nWpD5vwuzxyl0uUxMAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aIJbUROtqRlCBcOPIHhPqv6lBr8hFlEfoW5h9hXdMD11G1/S5NLwNSFvmkiDiiXoEgDsj8SNjq6c4H1H4/Rg4gMeaMD4XqFRa+ajYoAXtA4KaOGLFXhp6u7tq0w6DpxfMyXkOOCmcgyE3WyuWz5/1MfikByNMwSp9Cakgjpl0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EaZ0pUsP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so1285498276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586684; x=1720191484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hYI08GA2i4xEDZ8Hp5EFD5V+jUYcMnVH1W8tB5qQts=;
        b=EaZ0pUsP/Xu67xbVz3OISrdXO0j8/qcDi5XJ2fX3i0qe/6OZInVudimheXwN2f6Pt+
         Xka9pVGi+AZms9Fm9JvoSGK/1p7ci/JCLlg/bWa+S4AwZfs4nQWnLWygTDH/C+nkXBVm
         MkKpAPT3CmRhr4E3jCOGcUU4dxLg/jXlHq8r2culZDDCjn4zthWm7QT7BmZryh9YaDGw
         oIs7z+hLV27LQVNeVQAEkoIqJT6au8Oep4A5aX2ZibhqhXz/6n2WRhr1iIZHbrBYC7vS
         j796/Sm/dE2v2LWMdnzfIIIYYrOypHOq4Jk+dVtd1EzEN3ro81PMpybTOS0gSLdACliD
         HQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586684; x=1720191484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hYI08GA2i4xEDZ8Hp5EFD5V+jUYcMnVH1W8tB5qQts=;
        b=mZh0sQTrbik7Oj9SuwKY+nQEaebMS8iQ7VJwvbfK8xcYJLlHzPdGeVc1x3L9/2Dezf
         CrtGUC6ZISWX5nMq9jFjwVsyT/r2b/6E6bFzWhRQ/SrIkwjxwBsEIV7LoD+Px1TBXdCJ
         tXDwxCuAOXyd+qus1SY7VY7ebmBo+BxLZ1gP4Kj5oBZewm5StJKCLz3e3BJ71ONUZhlT
         7YPF+vxyuMKOeMl/zEQaQR3iXTDkXzLdfcLo4HEGLtp52SKOGVWDNd0v89yYc1EGmcEp
         /a2js9mDTRJcLZugfk4JJR4ICsueGDDQtDqqG06wBKUecU6BzKnaMEMcSx0PkpbJcWY5
         YOvA==
X-Forwarded-Encrypted: i=1; AJvYcCWE2jHl52tm2XC15J80QDvLwvzDf4pY1PGSmpaOt+/ixjVm/daSdsHXDuCxWVyLS+twiXEO0stYB5dMpggSNB1/Ks16fCUAcjz3cJMk2g==
X-Gm-Message-State: AOJu0YxpD+cmxVHXMufUYMLGnDmuCub4QI2+pRp6Tsk3qOS7aD023GYw
	NoXvzbuwYwG+Q+EvypvUcCR8CMkJddltPMv1v40kHgY2stXmcSx/XrnUayWGvrZxCvEKkJpKIY0
	Stti03dxyU8vz8w==
X-Google-Smtp-Source: AGHT+IHKyYoOe4AxidxDSigY6PwMoldRCCF4iGFJ6lCu10o8NsAZ8cwGmDKRzVWg/f5P0ZNs4+HzbvdFsBTjaqo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:20c1:b0:de5:3003:4b64 with SMTP
 id 3f1490d57ef6-e0300ee84cbmr86203276.1.1719586683732; Fri, 28 Jun 2024
 07:58:03 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:19 +0000
In-Reply-To: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5369; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=V6+J74sGMyRyUt7D0+Pd9EiFg1YsZr9BwywFGD0FbrA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9lBwKNl5aXUzjcdzlqpya4fAu6NujlHAcZx
 SkUZWqRZmiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PZQAKCRAEWL7uWMY5
 RmcID/9J1eSntnwsntAYaxMpEigxFlfai6K0hjgitTT9homAa6oIKpntGZwSTG5zXZvEN/qd6ie
 Qc7XPfWKF/xCKwr9V+2ctjou7OAzOEetINuDE2GDQ14LdpFKKtYATRsL7UOhTIi0uC03lnYOTnm
 F5aKTmXlBQZ4u6aoajAzFDr+oDAYJEexg9XiE4S6JI7HMNF0dsu68/QpmvfjbO7tf1Zvyn/dpTr
 8wnNRKNWv16QxCZfySpe0WeN3Edetbq1WMy7jAhW31AXO+hxgM/dMKh0kpvjw8AXu44S2EtGAUM
 faAbi2sjLZwrGT0O1jTsnnuWEAfgOCHD/eu6eyGx7OjZW9D67osPG5xGa9ce2NTsy+eUycTyWuB
 Mg7Wnyfkv8CPAu4csWFuhDqDuLEqOHHZnHfBpJguQPCwsd5rPnvgi2IWUGX8zM1cAJqEwakK8VF
 PnJMKbvlSIS/LaqhnMcHUfu+nRlqLDp9gRYcnTOwlaVWFfknEp8ROx2N3xtUiy3w2kOhqEyBTwk
 olR25WGneGYpt02mDPY3CtLNK14QSz8FsbDJ1VwATdmn8ZS6D0VdRKejNURgwajjdDmJ6Ac58Aw
 HRWZGCxp5SK+s4mEld60kvidIC5UUM9g06SlyIyBP4/H4NtWgoVgWY69OH4XRy5h2tFFIps4wGH sbp8eR2B4Zvokpw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-6-4d701f6335f3@google.com>
Subject: [PATCH v7 6/8] rust: file: add `FileDescriptorReservation`
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
index 91113f844981..1b2645d36e36 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -9,7 +9,7 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
-    types::{ARef, AlwaysRefCounted, Opaque},
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::ptr;
 
@@ -366,6 +366,79 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
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
2.45.2.803.g4e1b14247a-goog


