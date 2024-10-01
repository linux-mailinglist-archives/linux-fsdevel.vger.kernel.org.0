Return-Path: <linux-fsdevel+bounces-30442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F19998B6D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC701C221F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14A19CD17;
	Tue,  1 Oct 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPIJx5Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612619C56E
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770982; cv=none; b=AxRQVUP6Oe8TVxNtiawq1a4+2c5vWV6pzzPxY4oIErjs3gqGbP2rCk7muV/+yoJmnQ+jtA3SBMJ6Gcik/DaZ4oDoRXms/2W4VIwnkqig8z7mrdM4ecdo9G93zFn0vxMgqP5j7rkOdGxZWWzVfv+bH0Uc0XV+rgQxCxd/97FSYtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770982; c=relaxed/simple;
	bh=3VyRonBCJVjK5hj6nYbxWH10b75C5wDKm0/8vUkO9uY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h0veI4zk2OX/ORCBeSEd8fvB1fR/lK5wlocGx11jL4Y+qV8RB75F7dU1GIE3X1eKPZSqHJLzKZ4+bebyJDaOEIUhZBwj3rs6F0DDvUOywFOsAmqeHcAZPWtG2SIQfWxjnKBdK8mmzFwuaT4HiykO3YSfqbd+FKpXOvb9u5c0YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPIJx5Ls; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37cc9b5e533so2112820f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727770979; x=1728375779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3FZn52H9O8F+yOf60yqUxuDYPyvQ608t9F+r6MmgRc=;
        b=TPIJx5LsWMsjhETBDqVCjTCf+wRf8DKs/Qek70NuZeimPKAfXiLfOvdEM4KBMTDMoe
         rSuoljUxMtMz8xFVRZyz7OYYHjoB0/Xr9JSbVY4AjPoUaF5yLretRnHDoI2ygdXuZF03
         j3u/ZlW75bgh46O+CzrW6dVbeyb+IZszM3hL72w9TcjdgxfsFj4Dq9gMWBUCFapaJOyV
         N/YwJLxxJZg18apiK4VvGEzVmZVlOejRvv5f3tY0ibb3gGl7r81yR93PMqvDCs96BxHs
         vBODnCHE6Kts4lTfqTaQgUyZoA/AJ5rDgg6h9P4fAu93broAlYsWAsIL0ltJrF7mS3o2
         /drA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770979; x=1728375779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3FZn52H9O8F+yOf60yqUxuDYPyvQ608t9F+r6MmgRc=;
        b=BR6XM6Tj+SfrHdGF/AYFSimsQptd99ulMfnMQ2H3AqjsCjNm+5w+zseFRh0GrzODvH
         z1GJXtUvHB18u5RNq90pCa0voUFw791xNNGuW0LtwhLV6kpb5/sOiPZUGSm+7BvG25o1
         B4YIIN7MX8OaFvqEGx1/BijEyviVK5U7CpA//IhPS+mGb/35DMzeCjrQ/BQIkCItvn0K
         T79HMoKN0xgAZfKAdZuUgSoBTL4aGb7Sl8Z7tUDRDNJwDfpeF+KTSalFaig/W/ZxZsd+
         gaNv2mX8p5wOFCxnD9Xi/CQ1SOzyQQ62wvs+9q779QNnJMDgGEVPmA5hES4W630fZwle
         jEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAjzVhrpHPViS7UEB0Ks+WYmxVbaCuNxqGDIJcAu4HWBzITLNAXZHenQNUAvOmn+mECWZL92hreiRlc09Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14WkFEHHYPmMQaW2h3JZlBqGV1VELymqPkRMNBbQylTlZz/rG
	qtaiOOqM0O38/0g6bM+IzlAhPgJcQr85PcqSnVjbgTBIsUEhu8F7FyckI1ehOvWQ6skkg3kX+ah
	2NsHw4l5GwaqGXA==
X-Google-Smtp-Source: AGHT+IHpK+MaMjGg3iunzco3p6gSgwx7hU4pG4yd89Mn5+bw2OyXM+54l3wap13mwr+yym6F7IFddnAWJogvi+w=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6000:88:b0:376:89e0:7b72 with SMTP
 id ffacd0b85a97d-37cd5b1b5ccmr9814f8f.8.1727770978942; Tue, 01 Oct 2024
 01:22:58 -0700 (PDT)
Date: Tue, 01 Oct 2024 08:22:22 +0000
In-Reply-To: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10556; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=3VyRonBCJVjK5hj6nYbxWH10b75C5wDKm0/8vUkO9uY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+7Fb3wqX6uQGUAddVnUHiAfZi14kjbYSuWFQY
 G3dvwX40OKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvuxWwAKCRAEWL7uWMY5
 Rhb1EACkC9obOPUnU7Rf6FWMvgJO1DXkTTEHGYIRuHGFXNlNaBQupG9IHeuG+7URG8KqzETYn7d
 LkHJzlUJ9JUBpl8PXj+u33qwGNNLShqVTDeOBUcbqhn4GLyLGFmavrfg05wj+hqWt4e+XeZZKcF
 Lwv+cxIReGrWbmYDfOkDorRnLMISN4V8QUzl0HDWO5sFD4B93nAePT9UXvM7fMZWBNoGKK0ufUf
 6r2R6Cr5ko85DfGb6HaM0uBicBwUcrAMtALKq0rPtBvlE6PliDjspyKdGw5iesWS/82htC/6Did
 1EsMdCIZTXevkpYZP/oHqoz5PMG5JQQ9XoVe3sAw0F79kFspjFxeSXgUWUwCa6psK2+RQWHz7jW
 2o/qBhnvdtgyFwdQZyiz2SpyMzm5sgapb5yE/O7GV0DeBkjh2dKAnN4TYbb9KnT4M+mBlrPPUed
 EgdFsidmgqMdtKGVv0XL6yDoHKp4rzYjmHRFnhPsQtlZsCMCtZguRdolEIclTjipaZZdylXfg/s
 Ny6Pnj8uUQnP6mjnnLWxneUnec5P9Z1pUGe+Y/qcDkvONCWrcHyssEjtvzOgTn8/5sYmXKvPkhW
 iIavjRCuSrVwLvbGUOJT9sguznntAhVYZkVj2y4alyAik50i1uOm+mizDgbxmYUAH7Lx1Mzsjan 1mmXt80nn8yFY3w==
X-Mailer: b4 0.13.0
Message-ID: <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
Subject: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Provide a `MiscDevice` trait that lets you specify the file operations
that you wish to provide for your misc device. For now, only three file
operations are provided: open, close, ioctl.

These abstractions only support MISC_DYNAMIC_MINOR. This enforces that
new miscdevices should not hard-code a minor number.

When implementing ioctl, the Result type is used. This means that you
can choose to return either of:
* An integer of type isize.
* An errno using the kernel::error::Error type.
When returning an isize, the integer is returned verbatim. It's mainly
intended for returning positive integers to userspace. However, it is
technically possible to return errors via the isize return value too.

To avoid having a dependency on files, this patch does not provide the
file operations callbacks a pointer to the file. This means that they
cannot check file properties such as O_NONBLOCK (which Binder needs).
Support for that can be added as a follow-up.

To avoid having a dependency on vma, this patch does not provide any way
to implement mmap (which Binder needs). Support for that can be added as
a follow-up.

Rust Binder will use these abstractions to create the /dev/binder file
when binderfs is disabled.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       | 241 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..84303bf221dd 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/miscdevice.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22a3bfa5a9e9..e268eae54c81 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,7 @@
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;
+pub mod miscdevice;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
new file mode 100644
index 000000000000..cbd5249b5b45
--- /dev/null
+++ b/rust/kernel/miscdevice.rs
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Miscdevice support.
+//!
+//! C headers: [`include/linux/miscdevice.h`](srctree/include/linux/miscdevice.h).
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/driver-api/misc_devices.html>
+
+use crate::{
+    bindings,
+    error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    prelude::*,
+    str::CStr,
+    types::{ForeignOwnable, Opaque},
+};
+use core::{
+    ffi::{c_int, c_long, c_uint, c_ulong},
+    marker::PhantomData,
+    mem::MaybeUninit,
+    pin::Pin,
+};
+
+/// Options for creating a misc device.
+#[derive(Copy, Clone)]
+pub struct MiscDeviceOptions {
+    /// The name of the miscdevice.
+    pub name: &'static CStr,
+}
+
+impl MiscDeviceOptions {
+    /// Create a raw `struct miscdev` ready for registration.
+    pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
+        // SAFETY: All zeros is valid for this C type.
+        let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
+        result.minor = bindings::MISC_DYNAMIC_MINOR as _;
+        result.name = self.name.as_char_ptr();
+        result.fops = create_vtable::<T>();
+        result
+    }
+}
+
+/// A registration of a miscdevice.
+///
+/// # Invariants
+///
+/// `inner` is a registered misc device.
+#[repr(transparent)]
+#[pin_data(PinnedDrop)]
+pub struct MiscDeviceRegistration<T> {
+    #[pin]
+    inner: Opaque<bindings::miscdevice>,
+    _t: PhantomData<T>,
+}
+
+// SAFETY: It is allowed to call `misc_deregister` on a different thread from where you called
+// `misc_register`.
+unsafe impl<T> Send for MiscDeviceRegistration<T> {}
+// SAFETY: All `&self` methods on this type are written to ensure that it is safe to call them in
+// parallel.
+unsafe impl<T> Sync for MiscDeviceRegistration<T> {}
+
+impl<T: MiscDevice> MiscDeviceRegistration<T> {
+    /// Register a misc device.
+    pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            inner <- Opaque::try_ffi_init(move |slot: *mut bindings::miscdevice| {
+                // SAFETY: The initializer can write to the provided `slot`.
+                unsafe { slot.write(opts.into_raw::<T>()) };
+
+                // SAFETY: We just wrote the misc device options to the slot. The miscdevice will
+                // get unregistered before `slot` is deallocated because the memory is pinned and
+                // the destructor of this type deallocates the memory.
+                // INVARIANT: If this returns `Ok(())`, then the `slot` will contain a registered
+                // misc device.
+                to_result(unsafe { bindings::misc_register(slot) })
+            }),
+            _t: PhantomData,
+        })
+    }
+
+    /// Returns a raw pointer to the misc device.
+    pub fn as_raw(&self) -> *mut bindings::miscdevice {
+        self.inner.get()
+    }
+}
+
+#[pinned_drop]
+impl<T> PinnedDrop for MiscDeviceRegistration<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: We know that the device is registered by the type invariants.
+        unsafe { bindings::misc_deregister(self.inner.get()) };
+    }
+}
+
+/// Trait implemented by the private data of an open misc device.
+#[vtable]
+pub trait MiscDevice {
+    /// What kind of pointer should `Self` be wrapped in.
+    type Ptr: ForeignOwnable + Send + Sync;
+
+    /// Called when the misc device is opened.
+    ///
+    /// The returned pointer will be stored as the private data for the file.
+    fn open() -> Result<Self::Ptr>;
+
+    /// Called when the misc device is released.
+    fn release(device: Self::Ptr) {
+        drop(device);
+    }
+
+    /// Handler for ioctls.
+    ///
+    /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
+    ///
+    /// [`kernel::ioctl`]: mod@crate::ioctl
+    fn ioctl(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _cmd: u32,
+        _arg: usize,
+    ) -> Result<isize> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Handler for ioctls.
+    ///
+    /// Used for 32-bit userspace on 64-bit platforms.
+    ///
+    /// This method is optional and only needs to be provided if the ioctl relies on structures
+    /// that have different layout on 32-bit and 64-bit userspace. If no implementation is
+    /// provided, then `compat_ptr_ioctl` will be used instead.
+    #[cfg(CONFIG_COMPAT)]
+    fn compat_ioctl(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _cmd: u32,
+        _arg: usize,
+    ) -> Result<isize> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+const fn create_vtable<T: MiscDevice>() -> &'static bindings::file_operations {
+    const fn maybe_fn<T: Copy>(check: bool, func: T) -> Option<T> {
+        if check {
+            Some(func)
+        } else {
+            None
+        }
+    }
+
+    struct VtableHelper<T: MiscDevice> {
+        _t: PhantomData<T>,
+    }
+    impl<T: MiscDevice> VtableHelper<T> {
+        const VTABLE: bindings::file_operations = bindings::file_operations {
+            open: Some(fops_open::<T>),
+            release: Some(fops_release::<T>),
+            unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
+            #[cfg(CONFIG_COMPAT)]
+            compat_ioctl: if T::HAS_COMPAT_IOCTL {
+                Some(fops_compat_ioctl::<T>)
+            } else if T::HAS_IOCTL {
+                Some(bindings::compat_ptr_ioctl)
+            } else {
+                None
+            },
+            ..unsafe { MaybeUninit::zeroed().assume_init() }
+        };
+    }
+
+    &VtableHelper::<T>::VTABLE
+}
+
+unsafe extern "C" fn fops_open<T: MiscDevice>(
+    inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_int {
+    // SAFETY: The pointers are valid and for a file being opened.
+    let ret = unsafe { bindings::generic_file_open(inode, file) };
+    if ret != 0 {
+        return ret;
+    }
+
+    let ptr = match T::open() {
+        Ok(ptr) => ptr,
+        Err(err) => return err.to_errno(),
+    };
+
+    // SAFETY: The open call of a file owns the private data.
+    unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };
+
+    0
+}
+
+unsafe extern "C" fn fops_release<T: MiscDevice>(
+    _inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> c_int {
+    // SAFETY: The release call of a file owns the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: The release call of a file owns the private data.
+    let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
+
+    T::release(ptr);
+
+    0
+}
+
+unsafe extern "C" fn fops_ioctl<T: MiscDevice>(
+    file: *mut bindings::file,
+    cmd: c_uint,
+    arg: c_ulong,
+) -> c_long {
+    // SAFETY: The ioctl call of a file can access the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Ioctl calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+
+    match T::ioctl(device, cmd as u32, arg as usize) {
+        Ok(ret) => ret as c_long,
+        Err(err) => err.to_errno() as c_long,
+    }
+}
+
+#[cfg(CONFIG_COMPAT)]
+unsafe extern "C" fn fops_compat_ioctl<T: MiscDevice>(
+    file: *mut bindings::file,
+    cmd: c_uint,
+    arg: c_ulong,
+) -> c_long {
+    // SAFETY: The compat ioctl call of a file can access the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Ioctl calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+
+    match T::compat_ioctl(device, cmd as u32, arg as usize) {
+        Ok(ret) => ret as c_long,
+        Err(err) => err.to_errno() as c_long,
+    }
+}

-- 
2.46.1.824.gd892dcdcdd-goog


