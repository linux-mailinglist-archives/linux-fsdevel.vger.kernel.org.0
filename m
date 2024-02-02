Return-Path: <linux-fsdevel+bounces-9992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCA4846E6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967922913E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86944140790;
	Fri,  2 Feb 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KaDpZSN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D3F13BEA1
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871367; cv=none; b=c7o4bRN50UUl9BNVWDBO1GgatDPsR4i2Kfblm49WJR3qCu8/QnCkCbjo+EpaGuNn29qasg9BdyrxQNXvvrr3Em9ncy0GR2KEHC/ll+FH0mwQEXmsgQu3C+5KQqgWWuTQfClyg1ZziFo1gmLsrMIgOIDx/sTIOfdc3xMg/r2RHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871367; c=relaxed/simple;
	bh=rtE/oxepQqksMoR2qP3TYN4awGZUE7hR5gf+H0B+bNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrH8OTv1GmS7HidXlqHOrmosOWGgrdupE5XvHg6we82Xbx6YPaK9JsxpReab8P60GctPosETFclU0xI4I0jnxhZZFfT+Dd0JPHAE6u7vhD4g7Z+ZgR824jsKaF3IRg0d5JIhKQx20iKKfhZgAkTFrwvkQ3uvTapkRPSUzMAy+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KaDpZSN4; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d07d743553so13113281fa.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871363; x=1707476163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0kQAYir3oZEIRDEnXelicKinA6h+DIjN/X4cL6IApI=;
        b=KaDpZSN4pKxnXUYxuj5/iF+QNSfN3yj5BUM5H9r7TXd2anKAOCvvNU79Y4Q6pNdI2c
         LFOmXYnut1BSr/M46c2xaB+cEMamMaEWh1XoGo8rN/sXZCuy69LxpkvU+HezDem+wgk5
         L/VyPf+bwRIsjocpuHucBmtGAJm6mf6MqFqTEQ1JmzM8WgvqtdGo8LSLNIgQaW7WQ/5n
         BQ+PlZ/tq1tMe5utYIzc3tjVnBgu+4CQoeeXJP8vNbOtINx81icRqA1ZU6HEgLAXdUZP
         cfGZqsksaVGOoJ9ASytsqaTLl8V4FMFUZHiNIcH1aDAqMYwBmyKrBhnF8Bv+ybZxYmSg
         Spgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871363; x=1707476163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0kQAYir3oZEIRDEnXelicKinA6h+DIjN/X4cL6IApI=;
        b=rqnLeGG8+oDdXRg50ZYqFqaskqr/XAkSRghaBRpNzgsN/yrtrXPuTpLu5tvI14e6f0
         PgWxFB2K1VWmBRRp5viVqxFOXulZWgH0zkJgCQr/aroWfZCkvaLwPypb4/JaVtoFQTtH
         r00jsaribNfWs3UZLkont8kzfuLuo3Cjk09OhpoYtzqTeqdQBV43Q71u9/RZyM0Pw9i/
         mseCfSiRR7RzMDu8kYcu2hJDyeemG7J/tAUVhYPSLXS8DC8l/IUyaMvjdtEbzbKVLQ2d
         yTlZ+1ofXZNamj4FYWVrU9MVsQFAuZQxtqx3pXdTee+gjLNgELSqxuj1F6qnXvV6ORRO
         FVMA==
X-Gm-Message-State: AOJu0YzvN2mOVCWP0qebCc0+qNiTW2VLjvkFUnLAfEsYx1UAK0RaGhzZ
	07hVrUxQ3krvDIChek2RmPzzAIx2sPlxWabsrVDLE+Q6MloXh1dza/kZ7fH5lydlzlZ3BrLtUmY
	bcsbjY25GvfuEXQ==
X-Google-Smtp-Source: AGHT+IFdIdI8Pg4pezC1btcZASnSbwn7g/uXGcslngO5eHDNMD0Ag8hhS+SkK+P/b1c89UbD188O9Yxdq96DbtM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b74c:0:b0:2d0:8445:ed0 with SMTP id
 k12-20020a2eb74c000000b002d084450ed0mr1642ljo.1.1706871363112; Fri, 02 Feb
 2024 02:56:03 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:40 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5020; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=YCd8Lz4NQ7loX+ZbPkzyOHKKxufRjuF+zON1dgx0uqI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJbqrZjLJl6uR5Bkp5+R171uPaIU6vFld2j
 bMoKBaFa+KJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 RrkLD/9+HcI/n4ZPrDD3BILD8zoSicDxCF9ACdPWFuJApsidYxMhtaI/iA9uM1hzg1MoAiotNr/
 un7kzqyv0CyRf/+GkI9BVhxDjfsmc3vdKX9KwMHs/8UJ2/LYQX644ERm//D/Nc9av81/PEMIyj2
 yUygfbPmRF13ridgReF6P+Bjj7F/aQJyP5GRewBhymFkRt4NFw51lS+PDqtTXQ99lHrp2xQLVOz
 MpUdSJKRlxnHJDVEX+tcgSJs3ffDLknbvXegWJ296c0gJZz1w2xpN5yslfrhfeYWXBuYbF53O7c
 ktdmltlm0EZfGyKvi+cvcOyh6TZHEoePWuAIw5NHJIYXC+4UzR0oXuXb3Gx9yyMz/zNjU0YA+lF
 BZTgxlbBCSExKmQJgEgJ56HQblQYqUnQnSQ9ZieDRGoOWPcS5hINxO16yYPxWMhJWK/6KzhNQXp
 tqDBH2pxmLHHhndhlXDq7BCtkB0hCIrdc8WGBbk/rzOCuLBkP0Vz5/Op/Z2xFzYWTFgNjlB+6Pj
 UbLlXkG9iJew2C9h4KnwsCLKTcz8uhppbqztkMuSxfqY9uRR42re2iwTi2Nc1sXrji4/+p/E8r4
 uqeMOUneKKvT6whbLAFHT8GaqazYU6NvxjLfmL4aBKnxeVHaxIsbzeI4jfCFSKFXs5cb3kUhBbe TJ0DQpOlv8/5MjQ==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-6-fc9c2080663b@google.com>
Subject: [PATCH v4 6/9] rust: file: add `FileDescriptorReservation`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/file.rs | 72 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 095775411979..2004270a661c 100644
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
 
@@ -243,6 +243,76 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
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
2.43.0.594.gd9cf4e227d-goog


