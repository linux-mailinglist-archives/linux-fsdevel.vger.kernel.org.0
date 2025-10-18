Return-Path: <linux-fsdevel+bounces-64568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1634BED456
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41AAD4E822F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EF257858;
	Sat, 18 Oct 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGtkPBlN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1BA244EA1
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806964; cv=none; b=lBIpeR1wadYA7M/oLiLJXa+PgrmJcKQd1B3ymnxyx3ZY7f3LWekHpV5aO9UyH4ahxozEV+2ZTHmU/GBU8vjT2Ea6+BUhITmD4Ru7XVujjXdF5gLN0OKRSuA9ULLi3CcMPpz1PwcY+jip+nnCNpi9OZcljn6aiygPuKqQyLOFxNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806964; c=relaxed/simple;
	bh=K56Is2wx7UmVl17dRBrxY8Gx8J2Mj6XdngEuoaXN7is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D3UWJ9MOq5KtfZl/OlUShuVUW9I779RZOSY3+PvRMZ5YpblWxQFXDK8HZ8M85HPynkczuLqPK8FC5ehjhiD67hy+7mY0me7//egJpFV4BzuyVTmhiOluUBTxpz2w+ZIsU0E1N25HSujFagMpNteO2gyPOKtTsNEmxCqBfae4sKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGtkPBlN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471125c8bc1so33881815e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760806960; x=1761411760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcEJMCPQNzNn4Sg/+enW3pY+1OtQDQh0FQ7gWamWR/8=;
        b=rGtkPBlN65O/kO3nzZtauLZkBypZOGJZIqDcUrEkhvS8CQRrxy/5q3tnCqekG19lHT
         WqTNFbv0ABQXBB6nylY850gDZN6gpr39hgg1dSb2xaEzWABV7fk4WOr6uKcS9LZMHtEF
         R9+nbcXyrG24VEY02vb4opXaHorFhxu0+pOYKO8aT5nXjEWzeDmN8S+8PiZDazX4CK6Z
         +eroFQ2h/4AHTYMJoAWfIrTpL3Uo/wc/DngP8G9iBSU1uRaCB+nQC9n3bXho0W8wOSqs
         dU/JIJY/7e6qDGroeSwe8MwYRcv2FXCQX7fQkb/MfAlE/bpSjGa0lKOeNrTmYoG/A7k9
         4aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760806960; x=1761411760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcEJMCPQNzNn4Sg/+enW3pY+1OtQDQh0FQ7gWamWR/8=;
        b=s+uMm+1ahxJG5ZMGdqTBKN8uDIbNf3b4X3Oq9K1c63mChDvYarue9UGVpLUf+5R4ca
         SyZ/Euaef8Kpx9QMLYT6LaQX/vDZQtE5SdcWEnLktm0b2m/uq2zaAp1dJw8/bcotOTJI
         XH1At1UhBGGxJFoLImqkdSRSw7X76nzLoMDkDDXk5DQIOpAClKJcsj3jS8WL4yTRrrdS
         aeFU0zpN4gZxg9zwRbbMVQeLhGpbM+vIFO0fmJHoayRz7EjyLQ+/NUXbJpLlgVA3jcqM
         Mn7rh4RJjAod1Eu2kv4g8GNW+gm+GsO6RmIdxIvGKMYgJB0dIfoIjZPhHnpUF5gIXAUG
         NlXg==
X-Forwarded-Encrypted: i=1; AJvYcCU7i1f5AZ7wHa4j2qhh6Kzm4bCHmoWsiERQj5+hHAoaP9cJj7tx61FT6mc3xnzVLr5S2PAN6YRzJzN6L/T6@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmarbCJK8LniqbOL0TsNYGdMsDiZLBXUOyISA4eDxVgjMDOEd
	GcXDcR+fz/UazlZmWf9ihNhdhSVL+xGHijYETLB+SODdIRv2BqXGXjiwCpr+XsnfMAJW1C86Ctq
	jwpJP226RJfmE5X5m3Q==
X-Google-Smtp-Source: AGHT+IG+XONBGTsyrZA2w5nXoym2WOeMmXEjzuALKqECWR/nae42PSy1vCNDSBfzkw7eA04iBiPKoZnTCFnDy3g=
X-Received: from wmwo28.prod.google.com ([2002:a05:600d:439c:b0:46e:6605:3ac2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:6357:b0:46e:1a07:7bd5 with SMTP id 5b1f17b1804b1-47160987501mr15825585e9.29.1760806960228;
 Sat, 18 Oct 2025 10:02:40 -0700 (PDT)
Date: Sat, 18 Oct 2025 17:02:39 +0000
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
Message-ID: <aPPIL6dl8aYHZr8B@google.com>
Subject: Re: [PATCH v17 00/11] rust: replace kernel::str::CStr w/ core::ffi::CStr
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 15, 2025 at 03:24:30PM -0400, Tamir Duberstein wrote:
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
> 
> This series is intended to be taken through rust-next. The final patch
> in the series requires some other subsystems' `Acked-by`s:
> - drivers/android/binder/stats.rs: rust_binder. Alice, could you take a
>   look?
> - rust/kernel/device.rs: driver-core. Already acked by gregkh.
> - rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
> - rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
> - rust/kernel/sync/*: locking-core. Boqun, could you take a look?
> 
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vadorovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

You need a few more changes:

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 1e6c8c42fb3a..c1cfaeaa36a2 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -136,7 +136,7 @@ impl Clk {
         ///
         /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
         pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
+            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
             // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
             //
@@ -304,7 +304,7 @@ impl OptionalClk {
         /// [`clk_get_optional`]:
         /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
         pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
-            let con_id = name.map_or(ptr::null(), |n| n.as_ptr());
+            let con_id = name.map_or(ptr::null(), |n| n.as_char_ptr());
 
             // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
             //
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 10f1547ca9f1..466fb7f40762 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -157,7 +157,7 @@ pub fn new(
                     unsafe {
                         bindings::config_group_init_type_name(
                             &mut (*place.get()).su_group,
-                            name.as_ptr(),
+                            name.as_char_ptr(),
                             item_type.as_ptr(),
                         )
                     };
diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
index f99402cd3ba0..5de0ebc27198 100644
--- a/rust/kernel/debugfs/entry.rs
+++ b/rust/kernel/debugfs/entry.rs
@@ -2,8 +2,7 @@
 // Copyright (C) 2025 Google LLC.
 
 use crate::debugfs::file_ops::FileOps;
-use crate::ffi::c_void;
-use crate::str::CStr;
+use crate::prelude::*;
 use crate::sync::Arc;
 use core::marker::PhantomData;
 
diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
index b55a201e5029..65a4eb096cae 100644
--- a/rust/kernel/regulator.rs
+++ b/rust/kernel/regulator.rs
@@ -84,7 +84,7 @@ pub struct Error<State: RegulatorState> {
 pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
     // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
     // string.
-    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_ptr()) })
+    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(), name.as_char_ptr()) })
 }
 
 /// Same as [`devm_enable`], but calls `devm_regulator_get_enable_optional`
@@ -102,7 +102,9 @@ pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
 pub fn devm_enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
     // SAFETY: `dev` is a valid and bound device, while `name` is a valid C
     // string.
-    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_ptr()) })
+    to_result(unsafe {
+        bindings::devm_regulator_get_enable_optional(dev.as_raw(), name.as_char_ptr())
+    })
 }
 
 /// A `struct regulator` abstraction.
@@ -268,7 +270,8 @@ pub fn get_voltage(&self) -> Result<Voltage> {
     fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> {
         // SAFETY: It is safe to call `regulator_get()`, on a device pointer
         // received from the C code.
-        let inner = from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_ptr()) })?;
+        let inner =
+            from_err_ptr(unsafe { bindings::regulator_get(dev.as_raw(), name.as_char_ptr()) })?;
 
         // SAFETY: We can safely trust `inner` to be a pointer to a valid
         // regulator if `ERR_PTR` was not returned.
-- 

