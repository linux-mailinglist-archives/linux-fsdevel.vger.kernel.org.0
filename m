Return-Path: <linux-fsdevel+bounces-58749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE1B3120C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251E81CC7137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222412ED85F;
	Fri, 22 Aug 2025 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHGEX1jO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772DB2ECD35
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852176; cv=none; b=AbxlMlwa8p2uFiHgr9UH8KWm+I+Pa6u93GyTBnh2IS23j+giWAE0PuTkDrTv6waEAv+6cKI/9JT5JLidSxvsj2T1u0KRxwAHM7r80dzXeAIIMigYkVeINh/NW05Pilz3ArACFFEAn5DsBxN9RXMc8akxW1Rr5rNbB0glvE7/AVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852176; c=relaxed/simple;
	bh=pEFhG0haAU3GTGryN2WieVcKPQ715Oa917yCHNmiuvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tV4lOXPZ//V3i4UsSHPvxWhsWLuW2tQSlteuanJ6/GNnUiRFgSUfxygEt4Sin9S3woJxYcAxxePLniE6cgPOvQi7HPWFxULyznHLVBfLBoogsBCdmz0kPf4RvmN5r3/QCC6c9LUWtouePAlAhvkTi0XWXLiTjmeLz3DHWItRKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHGEX1jO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1ba17bbcso9544045e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755852172; x=1756456972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjj30volqfs6w7L9vkmy/27FL2MqFj9qU1x6ao4EmPI=;
        b=WHGEX1jOZxZtkELQiJrt61F8xZKWglR60cTGY4ggHiamOVjhPRLuZqkdrrEYA3T6hq
         DVSduN8arok6ZTD0XqFmQqFHOSV7YL7gxVbknBRzSOf276ljOBceW76E/tYeEk4Pm/av
         Iz5eJXOVxDfihWHp2R71udM2Z7lVou3ofIpRjF8QaeoTy8cbFIQv2A4jt2olRCgN4z23
         xMSpPa4TXaEr5tpVfGjqBqlYUFEaTIAqJtTh/6DmNHDzlUQpSJiuH1eHmqNaWT0RZrFM
         XSz/4p0Te+ZCirM2s1xudmkm9xNROdI+7B1Xf3vaHqjo9QcezAvWPqHFfYAs9qLJaNWq
         f9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852172; x=1756456972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjj30volqfs6w7L9vkmy/27FL2MqFj9qU1x6ao4EmPI=;
        b=dE6743YVgXDvp+i2/PQlNHizZHF+j1HdgrPzlOZ/0RABKnUAQwvmlWsV2hNM4RwLg/
         B2tuyoRMhScSF6JVjFwM1aKfCiHBs+u+fZoZJDPEtYLHrWSiqGHxZgVYNyt0ZXGOXKsa
         1PVSMg+ZsJCjA5SicmhF2+h0Ep2Yw//mHq4SGuxnkpC7lKN//aEtXLFAzGaWZZUlvcD+
         GNpNB0pvWuxFLHRJR4SS1naN/aes6NOBsKkMQiyiDgBfmNmP93hROk6IWpcQmsNzXwYP
         pcGRMos5o2gjo5GXgqDQlmSplU9NLVhUywGHISwLlGYIvqsYDR5res1RQ3oU1mgweDK6
         ex2g==
X-Forwarded-Encrypted: i=1; AJvYcCXtqJQVpKLm4RHPaBtoKGs6A3xMrYdqXOrTsZG7BnSRcVVWTXzjsiaeL959PlJ6v+1IO0gAmHvRNegDFeQb@vger.kernel.org
X-Gm-Message-State: AOJu0YweNJ2W/bnDaX7NzHYZBQnWvxt7YDzUK/JoDKGrBP/6lrmHfNlX
	TpnGoMRa2SvUfJS8junDQNnYi6AoHxnIZN1vutSfqJxPbf0/0EPoo6Ygsd6s8lXJSFRnp6qJcm9
	ojryR0B22QmIneD9M3A==
X-Google-Smtp-Source: AGHT+IHxHQFqWDULQYicIlutHzD9qOw+A69Wxr2UrhdnZx18qXPqIyxmWSW/+I752DN8ZrWOOX9rLabeqfTz+2s=
X-Received: from wmox22.prod.google.com ([2002:a05:600c:1796:b0:459:dbaa:93aa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:314c:b0:45b:43cc:e55a with SMTP id 5b1f17b1804b1-45b517cca69mr11960315e9.37.1755852171849;
 Fri, 22 Aug 2025 01:42:51 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:42:34 +0000
In-Reply-To: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822-iov-iter-v5-0-6ce4819c2977@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3559; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pEFhG0haAU3GTGryN2WieVcKPQ715Oa917yCHNmiuvA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBoqC2FrtlThqcOSRNsIBpt3SBxjJlChXDoE5MX/
 Z0qjh7A8iOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKgthQAKCRAEWL7uWMY5
 Rr9XD/4hIWjTh4NRA9TG7NZx0jJFcqPCUg2D2dCla9YcILf6jp8Oja4o3k/O1mTB5QXzgxlZCxC
 HGM0Uw0WLbwtciMXD+Z/yJBCN7WutdGdsw7xMlW2TYa3vmLuE0jEM20LcnGg5OrICQW8JvlQ4GG
 I6sBoNu/D9G8X/QW9c7+U6Js4iG8MwVcSEjb2vJ9fOFuHh/+4gnIL9gA4VtOftDZg5X1K+XqH83
 GSL6kfTiDC1o5ZkJlOfyQ59s9vj73Yy0oXpmstIX5CRkY8xrQZStLyeV/dORliKUBcgzk4h1f/8
 TNe+m+sUUoHfpFXRv6SfzmqqRZsaT48FJZn94mNQ335CC+Pnz2pE7ypb7JM+L+JSOiOdpc2VE1D
 1sgpNcX0OClBZ54/f7f0sSlymGL4nZYi8OFWCZRhBNTov3610Yk22mjG/dDqE7lJiFLZ2JcTTr1
 DgmkF4c1GVvDJERN29KIXZkStlX5budcF3y9aG06O5jjtK4hE3EDqnpLbU3lwhmtagdCslqGFDT
 GSHidoSQFxp02+DiBbXiK2wsefcDSFNxT5k2+n0AomBQ8h1KJY4YYl6/OTs9x0/7YsCbbELIByJ
 dvjgp8LhBgS33XJsx2IBZx4n4GicXbBiwqxQSRLZB2T1Vyvu0Xig8v+GOE7i39/4hUiP3PUlJly sKR+4GFmCOO/NhA==
X-Mailer: b4 0.14.2
Message-ID: <20250822-iov-iter-v5-3-6ce4819c2977@google.com>
Subject: [PATCH v5 3/5] rust: fs: add Kiocb struct
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, 
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

This adds a very simple Kiocb struct that lets you access the inner
file's private data and the file position. For now, nothing else is
supported.

Cc: Christian Brauner <brauner@kernel.org>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/fs.rs       |  3 +++
 rust/kernel/fs/kiocb.rs | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 0121b38c59e63d01a89f22c8ef6983ef5c3234de..6ba6bdf143cb991c6e78215178eb585260215da0 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -6,3 +6,6 @@
 
 pub mod file;
 pub use self::file::{File, LocalFile};
+
+mod kiocb;
+pub use self::kiocb::Kiocb;
diff --git a/rust/kernel/fs/kiocb.rs b/rust/kernel/fs/kiocb.rs
new file mode 100644
index 0000000000000000000000000000000000000000..84c936cd69b0e9b490d54c87d8c7279b27d4476a
--- /dev/null
+++ b/rust/kernel/fs/kiocb.rs
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Kernel IO callbacks.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
+
+use core::marker::PhantomData;
+use core::ptr::NonNull;
+use kernel::types::ForeignOwnable;
+
+/// Wrapper for the kernel's `struct kiocb`.
+///
+/// Currently this abstractions is incomplete and is essentially just a tuple containing a
+/// reference to a file and a file position.
+///
+/// The type `T` represents the filesystem or driver specific data associated with the file.
+///
+/// # Invariants
+///
+/// `inner` points at a valid `struct kiocb` whose file has the type `T` as its private data.
+pub struct Kiocb<'a, T> {
+    inner: NonNull<bindings::kiocb>,
+    _phantom: PhantomData<&'a T>,
+}
+
+impl<'a, T: ForeignOwnable> Kiocb<'a, T> {
+    /// Create a `Kiocb` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must reference a valid `struct kiocb` for the duration of `'a`. The private
+    /// data of the file must be `T`.
+    pub unsafe fn from_raw(kiocb: *mut bindings::kiocb) -> Self {
+        Self {
+            // SAFETY: If a pointer is valid it is not null.
+            inner: unsafe { NonNull::new_unchecked(kiocb) },
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Access the underlying `struct kiocb` directly.
+    pub fn as_raw(&self) -> *mut bindings::kiocb {
+        self.inner.as_ptr()
+    }
+
+    /// Get the filesystem or driver specific data associated with the file.
+    pub fn file(&self) -> <T as ForeignOwnable>::Borrowed<'a> {
+        // SAFETY: We have shared access to this kiocb and hence the underlying file, so we can
+        // read the file's private data.
+        let private = unsafe { (*(*self.as_raw()).ki_filp).private_data };
+        // SAFETY: The kiocb has shared access to the private data.
+        unsafe { <T as ForeignOwnable>::borrow(private) }
+    }
+
+    /// Gets the current value of `ki_pos`.
+    pub fn ki_pos(&self) -> i64 {
+        // SAFETY: We have shared access to the kiocb, so we can read its `ki_pos` field.
+        unsafe { (*self.as_raw()).ki_pos }
+    }
+
+    /// Gets a mutable reference to the `ki_pos` field.
+    pub fn ki_pos_mut(&mut self) -> &mut i64 {
+        // SAFETY: We have exclusive access to the kiocb, so we can write to `ki_pos`.
+        unsafe { &mut (*self.as_raw()).ki_pos }
+    }
+}

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


