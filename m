Return-Path: <linux-fsdevel+bounces-30181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09102987628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD3C8B260C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC27158A09;
	Thu, 26 Sep 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmwL22I1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB7156F23
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362785; cv=none; b=ecK4q8GmfDVFkBksKRnrZzjuLs44jfddH2wwJvnpgOPwGMguLOC1mrjkfaKcpQAiV3BC7wbFdTaa1ut2pG+lSONAdKfj96MGtLOILafbWAUm5wlpd99GUz0T/maLphpewH6hcwPf7yuQaklSWgIwJPkWSyEYHbpAHIaQli85ubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362785; c=relaxed/simple;
	bh=J6EBGaktQEIu0VpIbJIaFWXDXCR1uIR4hNwqEN2XYQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aoYOIpNIpQnMkOAWsFdi+d4+AnEW4xWlZq0p6808bkNwk/m2dyilBZRdpmHkNB12q/wVLgI8URNP334OgR0ZHLNhh7Wc/FJr09zx8JhsRfH1Yiv/F6OBm5SEONMmdcCMkrIk9mXcIn5/xF3OgFtUAgIySij8JbiXAeSstDNvpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmwL22I1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso1892259276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727362783; x=1727967583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2HODxaqAHzELuUx1xsYuulIg8XkoDAyXEK+wa7uqt4=;
        b=XmwL22I1mJFkLG67JEuvnupFkmYajuENO0j/jiDBzAVJZvsxhE9xMEbHfN68R60MYP
         T6/f1BSjumfCfdclzFn0OHdUmfzX26vZjD/YaYEcW7auDhzn+n3LFNV9/5CaPftqew+L
         ZhDAERRFoGRSVPEh8C5FIhn6z664rJ7DNCeFqHj7Lyjea99AKhtmnIHJsbQn6yu5bIFE
         Kc1SGuYyN7/aoMVG9Ak42Jlk0QS0GM9u0x/RQc8MnUuQ47bWR5O94P6aXUjZDxilB+S3
         NWFt9S2uVkm1yhPwzewzXiUXebLQFl9BULlpmwmlOCrgHKiy+ynZ7JcFEPAXrghHUpAX
         M2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362783; x=1727967583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2HODxaqAHzELuUx1xsYuulIg8XkoDAyXEK+wa7uqt4=;
        b=qVVrSTtZvSI3hXdqGCr6NRu2Qft9Fam9SnJR/ryLlQJc2rJO3jj6mDNsP3HHQEz+96
         iHXgG8uE8CQko5rYYebhgEZHN7YMQZ5RXs3zRVb7WYTFlKDqY+8T0SN8gXYc5k/JUY4h
         q9Zchk5WucuOhOx4N0JBtnaCiymOyRE/QQEfd8P/FWislgyEXZz0Dw9ZiAekKWL92gkU
         SvVeAjVmD2AnVuMPvimP4CHNzWU/LJDl1+LWexnTF35+hyQHjIop8A40j9t4LXPv4hZi
         PDUaU9/ylti6fYrZ3xxS998jqdlD9zb8xlsqx957677S++NuTWkOPfWlnXblam4JSlBp
         q/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUb08hARPOZ04p5zSKnwSydFOWKLLZUqY73hm0fFuHykNS4MP1JMX5JWuqQpcOWQyNXplp/d8uJRhbt3yNi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7W3PEBh0VfQpgktcsEsKsSWhj2F4rY4wvsJWMFWk54UULB6wL
	ZrvpuraJkMBdk2CjDMlBP5YE63lX1jU5oHuU6EXJA9YUJMUWxdn42uuYbDelaVu2yYXtBuXxB2Y
	DQiFXCmEALk/jeg==
X-Google-Smtp-Source: AGHT+IEguqZ3KMFd8ePo88MXCzgONy3nQRtjG18qWhiIa6RhW90LDIg8vul7ERYQkvCgYgZUJSpHwfUb7nLAmd8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:d608:0:b0:e11:6a73:b0d with SMTP id
 3f1490d57ef6-e24d9dc640bmr4525276.6.1727362782693; Thu, 26 Sep 2024 07:59:42
 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:58:57 +0000
In-Reply-To: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15628; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=J6EBGaktQEIu0VpIbJIaFWXDXCR1uIR4hNwqEN2XYQ4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm9XbTMB2KXt4UicQ0jDm5xwwbVCabQZr4BkEFY
 G+JfbmA8GCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvV20wAKCRAEWL7uWMY5
 RnILD/9UysiU1PquvE+YXTDIrG86uR5k55PO2MPQSYCrwvrjFIoFvx2f+sFshxNXOtdnA1XmkeT
 JlGw1ZthZ/FbTSJM0uOwW4fgCm7Gy7pN2ds1djZaFkD4Wt02JZMfmoM4ornCXKHgbMu062Ckgd1
 S+lcFoxQ4CQqgsOu8B87HGWzShtQCQoaBDl60rer1zQzFDoRKsvrKTeuNGVQtWDl7cOkFhr81Qr
 e+KuGWjUkuIMaszHhUChEr1YJSlV3CEdfBhPoV3Tdv808Hhox56OpCSi5WKM7o/U89o+InwUwnY
 SnG2bDb40XJdVRLeotBMhO2vJOfXVl0clZ8TT83vtBXe7soImDsSsqHRCje3laAzEV4YgARZSKF
 pc7zrBBhYNJLs2GPOwyITfdGe9U8p1pE6vcoUEEKrMbYBN/jsYjF1Y0w4nVW03e9g0FkNUrpp6T
 qRKAsolW7XgMaQRXVMbdm4d442wxShcg0D6sPBsfK3YgEfmu/NlyIJCNLC6IkWouoPoC9ERWDmK
 zwm1F7D/EJKsSmyWLulT1H9St9fawTcPZaMiKekIXMp1ZyAAXXaAIlOhi1pNgzGVvGKXaT9AjHs
 aFgy0TfXjsC+VOroGrtRnL6Wrtv0rtbc+IFw93ccRFykS1qVSDXPELb+BjX0MnKyhxdBxmhDG19 vDWNemNzdD4kBwA==
X-Mailer: b4 0.13.0
Message-ID: <20240926-b4-miscdevice-v1-3-7349c2b2837a@google.com>
Subject: [PATCH 3/3] rust: miscdevice: add abstraction for defining miscdevices
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
that you wish to provide for your misc device. Most operations are
optional.

In the future, the file operations in the `MiscDevice` can be moved to a
general `FileOperations` trait so that it is useful for other file
systems too.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       | 401 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 403 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ca13659ded4c..ec2e28ef6568 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/miscdevice.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
 #include <linux/poll.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 819126fc2d89..bf97817842c9 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -41,6 +41,7 @@
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod list;
+pub mod miscdevice;
 pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
new file mode 100644
index 000000000000..6c4e33d77c58
--- /dev/null
+++ b/rust/kernel/miscdevice.rs
@@ -0,0 +1,401 @@
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
+    fs::{File, LocalFile},
+    mm::virt::VmArea,
+    prelude::*,
+    str::CStr,
+    types::{ForeignOwnable, Opaque},
+};
+use core::{
+    ffi::{c_int, c_long, c_uint, c_ulong},
+    marker::PhantomData,
+    mem::MaybeUninit,
+    pin::Pin,
+    ptr::NonNull,
+};
+
+/// The kernel `loff_t` type.
+#[allow(non_camel_case_types)]
+pub type loff_t = bindings::loff_t;
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
+unsafe impl<T> Send for MiscDeviceRegistration<T> {}
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
+    /// Returns the private data associated with the provided file.
+    ///
+    /// Returns `None` if the file is not associated with this misc device.
+    pub fn try_get_private_data<'a>(
+        &self,
+        file: &'a LocalFile,
+    ) -> Option<<T::Ptr as ForeignOwnable>::Borrowed<'a>> {
+        // SAFETY: `fops` of a miscdevice is immutable after initialization.
+        let fops_this = unsafe { (*self.as_raw()).fops };
+        // SAFETY: `f_op` of a file is immutable after initialization.
+        let fops_file = unsafe { (*file.as_ptr()).f_op };
+
+        if core::ptr::eq(fops_this, fops_file) {
+            // SAFETY: We know that `file` is associated with a `MiscDeviceRegistration<T>`, so
+            // `private_data` is immutable.
+            let private_data = unsafe { (*file.as_ptr()).private_data };
+            // SAFETY:
+            // * The fops match, so the file's private date has the right type.
+            // * The returned borrow cannot outlive the file.
+            Some(unsafe { <T::Ptr as ForeignOwnable>::borrow(private_data) })
+        } else {
+            None
+        }
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
+    fn open(_file: &File) -> Result<Self::Ptr>;
+
+    /// Called when the misc device is released.
+    fn release(device: Self::Ptr, _file: &File) {
+        drop(device);
+    }
+
+    /// Handle for mmap.
+    fn mmap(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _vma: Pin<&mut VmArea>,
+    ) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Seeks this miscdevice.
+    fn llseek(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &LocalFile,
+        _offset: loff_t,
+        _whence: c_int,
+    ) -> Result<loff_t> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Read from this miscdevice.
+    fn read_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIter) -> Result<usize> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Handler for ioctls
+    ///
+    /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
+    ///
+    /// [`kernel::ioctl`]: mod@crate::ioctl
+    fn ioctl(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &File,
+        _cmd: u32,
+        _arg: usize,
+    ) -> Result<c_long> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Handler for ioctls
+    ///
+    /// Used for 32-bit userspace on 64-bit platforms.
+    #[cfg(CONFIG_COMPAT)]
+    fn compat_ioctl(
+        device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        file: &File,
+        cmd: u32,
+        arg: usize,
+    ) -> Result<c_long> {
+        Self::ioctl(device, file, cmd, arg)
+    }
+}
+
+/// Wrapper for the kernel's `struct kiocb`.
+///
+/// The type `T` represents the private data of the file.
+pub struct Kiocb<'a, T> {
+    inner: NonNull<bindings::kiocb>,
+    _phantom: PhantomData<&'a T>,
+}
+
+impl<'a, T: ForeignOwnable> Kiocb<'a, T> {
+    /// Get the private data in this kiocb.
+    pub fn private_data(&self) -> <T as ForeignOwnable>::Borrowed<'a> {
+        // SAFETY: The `kiocb` lets us access the private data.
+        let private = unsafe { (*(*self.inner.as_ptr()).ki_filp).private_data };
+        // SAFETY: The kiocb has shared access to the private data.
+        unsafe { <T as ForeignOwnable>::borrow(private) }
+    }
+
+    /// Gets the current value of `ki_pos`.
+    pub fn ki_pos(&self) -> loff_t {
+        // SAFETY: The `kiocb` can access `ki_pos`.
+        unsafe { (*self.inner.as_ptr()).ki_pos }
+    }
+
+    /// Gets a mutable reference to the `ki_pos` field.
+    pub fn ki_pos_mut(&mut self) -> &mut loff_t {
+        // SAFETY: The `kiocb` can access `ki_pos`.
+        unsafe { &mut (*self.inner.as_ptr()).ki_pos }
+    }
+}
+
+/// Wrapper for the kernel's `struct iov_iter`.
+pub struct IovIter {
+    inner: Opaque<bindings::iov_iter>,
+}
+
+impl IovIter {
+    /// Gets a raw pointer to the contents.
+    pub fn as_raw(&self) -> *mut bindings::iov_iter {
+        self.inner.get()
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
+            mmap: maybe_fn(T::HAS_MMAP, fops_mmap::<T>),
+            llseek: maybe_fn(T::HAS_LLSEEK, fops_llseek::<T>),
+            read_iter: maybe_fn(T::HAS_READ_ITER, fops_read_iter::<T>),
+            unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
+            #[cfg(CONFIG_COMPAT)]
+            compat_ioctl: maybe_fn(T::HAS_IOCTL || T::HAS_COMPAT_IOCTL, fops_compat_ioctl::<T>),
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
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
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
+    // SAFETY: We are taking ownership of the private data, so we can drop it.
+    let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    T::release(ptr, unsafe { File::from_raw_file(file) });
+
+    0
+}
+
+unsafe extern "C" fn fops_mmap<T: MiscDevice>(
+    file: *mut bindings::file,
+    vma: *mut bindings::vm_area_struct,
+) -> c_int {
+    // SAFETY: The release call of a file owns the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Ioctl calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+    // SAFETY: The caller ensures that the vma is valid.
+    let area = unsafe { kernel::mm::virt::VmArea::from_raw_mut(vma) };
+
+    match T::mmap(device, file, area) {
+        Ok(()) => 0,
+        Err(err) => err.to_errno() as c_int,
+    }
+}
+
+unsafe extern "C" fn fops_llseek<T: MiscDevice>(
+    file: *mut bindings::file,
+    offset: loff_t,
+    whence: c_int,
+) -> loff_t {
+    // SAFETY: The release call of a file owns the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Ioctl calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * We are inside an fdget_pos region, so there cannot be any active fdget_pos regions on
+    //   other threads.
+    let file = unsafe { LocalFile::from_raw_file(file) };
+
+    match T::llseek(device, file, offset, whence) {
+        Ok(res) => res as loff_t,
+        Err(err) => err.to_errno() as loff_t,
+    }
+}
+
+unsafe extern "C" fn fops_read_iter<T: MiscDevice>(
+    kiocb: *mut bindings::kiocb,
+    iter: *mut bindings::iov_iter,
+) -> isize {
+    let kiocb = Kiocb {
+        inner: unsafe { NonNull::new_unchecked(kiocb) },
+        _phantom: PhantomData,
+    };
+    let iov = unsafe { &mut *iter.cast::<IovIter>() };
+
+    match T::read_iter(kiocb, iov) {
+        Ok(res) => res as isize,
+        Err(err) => err.to_errno() as isize,
+    }
+}
+
+unsafe extern "C" fn fops_ioctl<T: MiscDevice>(
+    file: *mut bindings::file,
+    cmd: c_uint,
+    arg: c_ulong,
+) -> c_long {
+    // SAFETY: The release call of a file owns the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Ioctl calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+
+    match T::ioctl(device, file, cmd as u32, arg as usize) {
+        Ok(ret) => ret,
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
+    // SAFETY: The release call of a file owns the private data.
+    let private = unsafe { (*file).private_data };
+    // SAFETY: Ioctl calls can borrow the private data of the file.
+    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY:
+    // * The file is valid for the duration of this call.
+    // * There is no active fdget_pos region on the file on this thread.
+    let file = unsafe { File::from_raw_file(file) };
+
+    match T::compat_ioctl(device, file, cmd as u32, arg as usize) {
+        Ok(ret) => ret,
+        Err(err) => err.to_errno() as c_long,
+    }
+}

-- 
2.46.0.792.g87dc391469-goog


