Return-Path: <linux-fsdevel+bounces-24247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0798193C429
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C791F227D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9219EEAE;
	Thu, 25 Jul 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPrXwkLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C119E819
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917682; cv=none; b=SfOBkp26U3J1TLcYI3wRzAwIUNtBut3ky8LGAFHe1VToIoduOhzJBk7Lyahx4rRRCKZNPzpMmSZOIfoH69t1Ky7oeB19lxK8lg2tGvGLziMYAB5oqM+jBTm/MO9Is5FhJxDw1D3mJU0CaznRYNuGs3mRCUcGwnxzMEcjwv+qIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917682; c=relaxed/simple;
	bh=J91Gx6MIvC8NeTYkxxFTLjHgsB7/VaJDgCuCqcQNtJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HRPs09UuXc6YB6JrfV95KaDNYoPSmxcCZ1lcmS0bL+yZ6aVsMxs8yCTwRmyFgnAhVcsknV5POGAPjXd3WtCDaqUHEu3ANUFfFvN7S6OCDFdzXRbcE5JfccgEwtGxEVy/VBNhOfO2j3q623jnhW/wABXtZIoar+pHQzx2G9siVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPrXwkLJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b2fb62a07so1060828276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917680; x=1722522480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCadNj0kmUPw3EC6sSlLJ1QlRyEDEjrL02Pe/kDxaDs=;
        b=bPrXwkLJoIrLh1rvK/CCkiLssEQ/o9ItzZnJwwNt5wZWM479fSyWibRYVZBP0RNIoJ
         2cJFiD3JZDtEjYRvls0wlyoCe3Y2oJbx4Hj1yTp5pMWgePb+YwjZBP5ZopFG/UaUR0qp
         nlIkHA6xVlGtftOGl136E04WF3WfGJGlmU67kd/j/OYg1EUTeI3C/wfSmTi1KRIekyI2
         I/ev7QN+gc/drD7Cr25YhwfcCoTf0XULYY6b+bj3VzgYoMr6wW5Vnv7xdRYTgupFlfy8
         FUe1A6QxPFCTOCqrvcVU/j8oJW7x656filQiBtob6RYKGUXlsgLtjkHM/UrydXq1SO61
         qEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917680; x=1722522480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCadNj0kmUPw3EC6sSlLJ1QlRyEDEjrL02Pe/kDxaDs=;
        b=PBOVr/creM96ocmuBiiQqAsAfRFJf6pAiJk+fWS3UipwkP29iBjattnkqyeiUnpsnW
         AiKGk1d/I4YPiDyxofT/rXa91f5wcdePFoeXRtAUiYMyUioQ8MrLm3UG8VMl1D/9Txu+
         k6nVGItzjhUJUsdUUT6waG5X4Ba6va5061PEfZYmF71kF45aoxkrQaxg7s6+3UnNtVFR
         Y8gWJMOJmhs+qudRMuGwQic1tX3iFXJiqJcHSthzzIz1p50MfQyAqnf6eYGRHLgRxR+P
         cXgQL64xEBGlQBd4B/NClPWwc3tMNXsh5d46ugByX8thCPdBqiU68mRTixnWcEKiqzVA
         aOaw==
X-Forwarded-Encrypted: i=1; AJvYcCV2zpGZd846QlBOlLZjT4vPj12O2w1Xc+HoKTgB92pFWkaq12JOiHceb79GFBmPpHJHrHa0aXnL7CWMNBearPLXm5UDuIuLkN1sW0U4Rw==
X-Gm-Message-State: AOJu0Yw8R1ovGzDOscoA9RTwTAXcPcxEsOUUmIRPJ9w5a4FcMocodNRp
	Gw/NHCf918xmmB0du+BKlbhAZfSEKgzuUALBYvl+HfU05smyflhsvR6YNJMwWSv/lQJioj+RFXK
	ClSPVIM2U0u9xyw==
X-Google-Smtp-Source: AGHT+IFKYihlbOoX4iJsmGs9EfswZcG8G7huPM/Kp+v9+uVgvno5FkEt+tRzpYzNQMus2OCOcCPmt1f5OwY66Ig=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2b0f:b0:e05:65b7:32d9 with SMTP
 id 3f1490d57ef6-e0b2ca7734cmr22335276.6.1721917679919; Thu, 25 Jul 2024
 07:27:59 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:39 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5384; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Dwps4ysAMwtCKIr0qbQaLdxg6EG+tQNeQs65V1osc9I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDa+P7LzNE+jmX+/kQHXyXhbz5uo1UajGv8c
 3SDDziX8GaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg2gAKCRAEWL7uWMY5
 Rv1wD/9yIpYyp+1FzfVlXK5fro/+UN5sDKFyuVNC75IP8CLT6XcV3QknwbTAR23Jh05FQpF7+Pf
 jrz1iMF6MGxEu7dHpd+Cl+DYCvXcj0lLCya+ACthV9pGo7t8njodU8iIWPX5iWBDv8LqTNX+kft
 mKhg5iHuvAmi8RwVkEUQfiS1OspLzSSX6D3sO86RygZNpbKq8GhAd7b3J341plPPzDRq1N0mE9a
 ZK80uLJEYIdmdQisnranp/36sHgVvxreXbZyUx0DDVQktnaPU70yRHqgylgJcTQ25YpfvGPSdIw
 68XWOIct7/yqFDfkFO9IbqWMZjWjRIyZkwmDrQ+J1aJ2gty5eHQfCSDjzsVy2xpdvMJZMBXqyoh
 zcOm7ohj2DqwATIzS82N0tXEYt5X5egNQ49Oy9uiWFrmdw6NEXNBXwCC0JzHQ1O+RrRPpbEHAfc
 UFrD9y4QhyV4axUSVWfyFEmShVg4naOomjnaZKHj9WoTqxroCvhPtXbMpIEoZL1RtXXx3s28m5g
 TQGTrj68xvKhQERJ0mrtk9mzDlV/K4v1m7FrikEh3Ltr8MkyfBdTaBcKcwIz29uNVG262QRQHfr
 FKq9qPioWU5Kx+f5qgLUrHkipdtPhEiGiOO1awCA6Q/9vdRSIhrHPft8exKcqcJdHqMHKaZoGNU pj6yiYSwGLvsqtA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-6-55a2e80deaa8@google.com>
Subject: [PATCH v8 6/8] rust: file: add `FileDescriptorReservation`
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
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
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
 rust/kernel/fs/file.rs | 75 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 8bed7bebcc43..af98513bb2ee 100644
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
 
@@ -368,6 +368,79 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
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
2.45.2.1089.g2a221341d9-goog


