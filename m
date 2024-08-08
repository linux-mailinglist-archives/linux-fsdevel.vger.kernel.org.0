Return-Path: <linux-fsdevel+bounces-25439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB194C278
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83731C209AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41199192B60;
	Thu,  8 Aug 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztzTMgdQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44C1922D0
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133807; cv=none; b=EfDYm+daFM2iDKBjqGJnx2gNvmKtPH6Nz+mMPAvbHJdL3hNSOslOqGPQBSffeXpTR5+9AaR/GtcST9p5emIcGuvyekivE63t8hlkXLPyvFTiWA/ZAyufWahvEmFBj7HXVrxufqhJ3i1Y/7BdWdMx/iPo6kL2FCuvmnJzwKb6u/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133807; c=relaxed/simple;
	bh=o4fdN4iiM2NHJu7SVfr6hNJGqcKh3Q2Q/FWBdOzigcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QATLMXXtNJGbjFEiKdWTrJA6a83blc94pyKbpCbxmHCmgqVLY6hc2LYdqFGkdH9qrUNNifMHZMrAG7wCki72OlRtMrlMR3FteB236LEmAGH772qSpJ3Be0qLnKUmThpckWirESigimls8Df7+zhZE+KFWTb3yVts9+IzeYu7I0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztzTMgdQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so6198765e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723133804; x=1723738604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRdYl09LMpZTMrOYeLLNLi8v/UCPdJZixG/jjg1ujqE=;
        b=ztzTMgdQfQTlSQvtvL7oEg4ibw4oYkWXhkx59/46tjO7UxbBO4L+R9Jin6GUquCXE2
         Cjteo1fhRFsc/zfeWuiu/OPIc2q9Hk1lmTU1cR/+x9y4OCyowVmfvcJrTBfsJmFiNWy5
         wLrKE6ShQunk4vaCTMByNyr6ahTv0w4zJLaQeoRtz8zTwwFfPkmsn6MLOgkNm4H3GMti
         4//yz5Py5D9aq532OQoK/W/JHWinD21O5PzjkVNJQvuP13JgvCakAkcTt1BUdc3JFQwG
         vlAsIyVs7BpKNpTt01MFM/feVsJRjcth4AQKnEVoiN9U16eE+rp2H2lp6n+uWJpdF0Kt
         eOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133804; x=1723738604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRdYl09LMpZTMrOYeLLNLi8v/UCPdJZixG/jjg1ujqE=;
        b=Wr3RYvAhNXYLmQNlgjpazpRfAO7U9bsqc1f5Bp6xKGVNgkn45vb+O4H2pC3yrAHT1f
         DpKWw5JubwW0B602tpQyAJHyYdj4vSECIJmbQc4gI+1GQ9ZvCQUEe3we1AAPTnlGVGiw
         /RV3pMlRpTKlDOOJmoFbTWHOy0rEP3X7rkvMGh43Sx67OIc1m9rsKoU944XwFdle7iwB
         rwPI5uf8XzvRPDnYYFQqeAddnXzWhjVm3mXxMdhfMLONi2P878fDrbTq9gznPTH5BpIC
         il5t+t/uyYn0peqioKubBi7puxiCw1boE2/jzp/vziP8D5ex3HyalQ2Vfv70S2/F9vgk
         5VbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzaOVjvHEJq3L95BERSkUFU/QiZMMF0WCrWYb8sE+zQr2FqOMyMDolnBveHVLo49TL1N26QfBZhjBkQE/0StCjYAj0hbFHaGIoZLa1YQ==
X-Gm-Message-State: AOJu0YxeXHVGLbXPSaYT89ZPyzaYm7aLizdvTHDLbJLtON8/wXbzhLsc
	4VumbxMTh8BdS7rdQEw1N5mSa0BZJE8AeIufbT0kJ4cBEhOTn+a2uVCbiE7bJkzhFYw8pRsgIJK
	VWf9P4HVp/xNelQ==
X-Google-Smtp-Source: AGHT+IECg/sQRjETdVvzKEP5dRt/k0bA5sulOXJhTYE8v5Pt4bxT7HL2chjqadIa7M8YAoRslvvKWPDU43T2PT0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:3b26:b0:426:6761:2fea with SMTP
 id 5b1f17b1804b1-4290b8de60amr56835e9.3.1723133804245; Thu, 08 Aug 2024
 09:16:44 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:15:49 +0000
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5416; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2l8fk9VFbHJWEQ4c3bFrbmnrmdDQcuL4l7ltM9XZJ/4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtO9Y7js5TBN7uMGNGA1y+AXxE8YDhWLMabQJB
 gkoF2iiQYyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrTvWAAKCRAEWL7uWMY5
 RvgJEAC6x68XniObP5m76P8gtROP92jacQX4OHz0AK8oD23GdKE5CcVd3eRH8FMjA3E32Mgg/+m
 wYE1aWPJzMouKGvwfD5DszIWFTxMsapEjSnpbh/upkgMDCOk9BjGE9fSIdi+N07fFUtOyWgjx1g
 +sv67HLm789OHud9ip7R0sIGoZTIENCWqEA9A5Jj/CtllTPVAh2iF8nJMOIRDLlcPZ3CtMNMZ+O
 c0WaoVmslGJ0Rql5/4SxSzv1DvHmazUTi0Qtx2bo3Exe7+gx7LIWLgftLNU+jvHNSCsmmpSfZ89
 VeaC1LRs2wMFooqRWkIPRq1qJofFAYsWCgbsJM4H4puWuQRYnuakASRAW6ywwZ7MWAweUqNVi3D
 OZNFRia+7PesbljqkySamJ2s3yZSBwMSUXfg561SnUc1IaCzoVQp+rqzJNedX5kUwV3kYRL/SFF
 xM2u/nTqrR/5U5RYvDwLSHsCi75rarv7agP3jEvejepFQjHzKl4prf4NdTOP1aInBi9gOsuYcQ/
 McNpfsTGBm9XI7+FFJXsleVqsjpyWUw7sHac2tudG7QjwMkBxIsW8abKVEJ+eBzOYX4Zk2HOQpn
 ogqiuRL3xKbs+O5vdEfrD6GjbBXTDVb5VYajk3LWIl8+jrCUu45C+CIwhD4eLdBvaU+OL4a5JKx zsuFx/eccCKmzTA==
X-Mailer: b4 0.13.0
Message-ID: <20240808-alice-file-v9-6-2cb7b934e0e1@google.com>
Subject: [PATCH v9 6/8] rust: file: add `FileDescriptorReservation`
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
2.46.0.rc2.264.g509ed76dc8-goog


