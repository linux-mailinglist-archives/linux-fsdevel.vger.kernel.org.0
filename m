Return-Path: <linux-fsdevel+bounces-30690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8298D58B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906531F22D3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C779D1D04B4;
	Wed,  2 Oct 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M64Dl86y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2839929CE7;
	Wed,  2 Oct 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875886; cv=none; b=SAjxLpzwEkSwpj/TBEoNft7XcbPiJHSAenym05UWKpF+W9h0XsFsRtBNGVWvCIoPmC9KTX0CfmQoYkEFIPQzFHXPuvCCt3OPOksir1lR+fXJjMJ7ffUdQfNSn2Zzd1JL1v1r79iL16EWjyMrn+x42lVy/oX1SX+6+MngBZv/Y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875886; c=relaxed/simple;
	bh=dbHVhc5miFMGVMct4G18/XyFLEGQzTYhNMFhntihlLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtxEsJY6Lc9Hr2u30E87VoRcDmPM/eZtkXsENfj0YTKoVJ0Lhy6uMji8FFtfPZ/4Xbzo10pJi11KzqA4DbNEUSj7voiYjQeipQT88xUXAo2OZV68aZEH8skb4GIZHTMGdNp7+ZoSx2LYIqiPdE8AtMpA44prnbB+p9gFU6EX2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M64Dl86y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA02DC4CECF;
	Wed,  2 Oct 2024 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727875886;
	bh=dbHVhc5miFMGVMct4G18/XyFLEGQzTYhNMFhntihlLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M64Dl86yCE0So4Q42FdKx59W9AINkUwcvDIYYD6tIOrmhy9MB10c743qYUhnqCWtH
	 E1Kw3bWHcTUWNlyv7ISsr9kt4+bgaN+yrwYq0jwCM9eqR6fj8SNWrkEYYRfpJYmz0s
	 SoR55/3JytGv8GK8feWKTQXzXwLLBdma3SmQWwLG9/UizcmlUD2PZ9LLOFoDe/AH5c
	 rYV/lz77u1N2odLPrW1H1iKDReweKxB07d/Q/a3MNG76JO6JnkynZ619gdAOm5XtSj
	 ffv9wbw1evLju6mel/yFPlfws3VA9Szd54GuOMbsnCp4BkVP9xb2aflADCJ6xS9gdV
	 X6d0Q6SBGFioQ==
Date: Wed, 2 Oct 2024 15:31:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Message-ID: <20241002-abfragen-bestzeit-fbc5701387a9@brauner>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>

On Tue, Oct 01, 2024 at 08:22:22AM GMT, Alice Ryhl wrote:
> Provide a `MiscDevice` trait that lets you specify the file operations
> that you wish to provide for your misc device. For now, only three file
> operations are provided: open, close, ioctl.
> 
> These abstractions only support MISC_DYNAMIC_MINOR. This enforces that
> new miscdevices should not hard-code a minor number.
> 
> When implementing ioctl, the Result type is used. This means that you
> can choose to return either of:
> * An integer of type isize.
> * An errno using the kernel::error::Error type.
> When returning an isize, the integer is returned verbatim. It's mainly
> intended for returning positive integers to userspace. However, it is
> technically possible to return errors via the isize return value too.
> 
> To avoid having a dependency on files, this patch does not provide the
> file operations callbacks a pointer to the file. This means that they
> cannot check file properties such as O_NONBLOCK (which Binder needs).
> Support for that can be added as a follow-up.
> 
> To avoid having a dependency on vma, this patch does not provide any way
> to implement mmap (which Binder needs). Support for that can be added as
> a follow-up.
> 
> Rust Binder will use these abstractions to create the /dev/binder file
> when binderfs is disabled.

Do you really need to expose both CONFIG_BINDERFS and the hard-coded
device creation stuff in the Kconfig that was done before that? Seems a
bit pointless to me.

> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/miscdevice.rs       | 241 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 243 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ae82e9c941af..84303bf221dd 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -15,6 +15,7 @@
>  #include <linux/firmware.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
> +#include <linux/miscdevice.h>
>  #include <linux/phy.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 22a3bfa5a9e9..e268eae54c81 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -39,6 +39,7 @@
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  pub mod list;
> +pub mod miscdevice;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod page;
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> new file mode 100644
> index 000000000000..cbd5249b5b45
> --- /dev/null
> +++ b/rust/kernel/miscdevice.rs
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Miscdevice support.
> +//!
> +//! C headers: [`include/linux/miscdevice.h`](srctree/include/linux/miscdevice.h).
> +//!
> +//! Reference: <https://www.kernel.org/doc/html/latest/driver-api/misc_devices.html>
> +
> +use crate::{
> +    bindings,
> +    error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> +    prelude::*,
> +    str::CStr,
> +    types::{ForeignOwnable, Opaque},
> +};
> +use core::{
> +    ffi::{c_int, c_long, c_uint, c_ulong},
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    pin::Pin,
> +};
> +
> +/// Options for creating a misc device.
> +#[derive(Copy, Clone)]
> +pub struct MiscDeviceOptions {
> +    /// The name of the miscdevice.
> +    pub name: &'static CStr,
> +}
> +
> +impl MiscDeviceOptions {
> +    /// Create a raw `struct miscdev` ready for registration.
> +    pub const fn into_raw<T: MiscDevice>(self) -> bindings::miscdevice {
> +        // SAFETY: All zeros is valid for this C type.
> +        let mut result: bindings::miscdevice = unsafe { MaybeUninit::zeroed().assume_init() };
> +        result.minor = bindings::MISC_DYNAMIC_MINOR as _;
> +        result.name = self.name.as_char_ptr();
> +        result.fops = create_vtable::<T>();
> +        result
> +    }
> +}
> +
> +/// A registration of a miscdevice.
> +///
> +/// # Invariants
> +///
> +/// `inner` is a registered misc device.
> +#[repr(transparent)]
> +#[pin_data(PinnedDrop)]
> +pub struct MiscDeviceRegistration<T> {
> +    #[pin]
> +    inner: Opaque<bindings::miscdevice>,
> +    _t: PhantomData<T>,
> +}
> +
> +// SAFETY: It is allowed to call `misc_deregister` on a different thread from where you called
> +// `misc_register`.
> +unsafe impl<T> Send for MiscDeviceRegistration<T> {}
> +// SAFETY: All `&self` methods on this type are written to ensure that it is safe to call them in
> +// parallel.
> +unsafe impl<T> Sync for MiscDeviceRegistration<T> {}
> +
> +impl<T: MiscDevice> MiscDeviceRegistration<T> {
> +    /// Register a misc device.
> +    pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
> +        try_pin_init!(Self {
> +            inner <- Opaque::try_ffi_init(move |slot: *mut bindings::miscdevice| {
> +                // SAFETY: The initializer can write to the provided `slot`.
> +                unsafe { slot.write(opts.into_raw::<T>()) };
> +
> +                // SAFETY: We just wrote the misc device options to the slot. The miscdevice will
> +                // get unregistered before `slot` is deallocated because the memory is pinned and
> +                // the destructor of this type deallocates the memory.
> +                // INVARIANT: If this returns `Ok(())`, then the `slot` will contain a registered
> +                // misc device.
> +                to_result(unsafe { bindings::misc_register(slot) })
> +            }),
> +            _t: PhantomData,
> +        })
> +    }
> +
> +    /// Returns a raw pointer to the misc device.
> +    pub fn as_raw(&self) -> *mut bindings::miscdevice {
> +        self.inner.get()
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T> PinnedDrop for MiscDeviceRegistration<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: We know that the device is registered by the type invariants.
> +        unsafe { bindings::misc_deregister(self.inner.get()) };
> +    }
> +}
> +
> +/// Trait implemented by the private data of an open misc device.
> +#[vtable]
> +pub trait MiscDevice {
> +    /// What kind of pointer should `Self` be wrapped in.
> +    type Ptr: ForeignOwnable + Send + Sync;
> +
> +    /// Called when the misc device is opened.
> +    ///
> +    /// The returned pointer will be stored as the private data for the file.
> +    fn open() -> Result<Self::Ptr>;
> +
> +    /// Called when the misc device is released.
> +    fn release(device: Self::Ptr) {
> +        drop(device);
> +    }
> +
> +    /// Handler for ioctls.
> +    ///
> +    /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
> +    ///
> +    /// [`kernel::ioctl`]: mod@crate::ioctl
> +    fn ioctl(
> +        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        _cmd: u32,
> +        _arg: usize,
> +    ) -> Result<isize> {
> +        kernel::build_error(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Handler for ioctls.
> +    ///
> +    /// Used for 32-bit userspace on 64-bit platforms.
> +    ///
> +    /// This method is optional and only needs to be provided if the ioctl relies on structures
> +    /// that have different layout on 32-bit and 64-bit userspace. If no implementation is
> +    /// provided, then `compat_ptr_ioctl` will be used instead.
> +    #[cfg(CONFIG_COMPAT)]
> +    fn compat_ioctl(
> +        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        _cmd: u32,
> +        _arg: usize,
> +    ) -> Result<isize> {
> +        kernel::build_error(VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +const fn create_vtable<T: MiscDevice>() -> &'static bindings::file_operations {
> +    const fn maybe_fn<T: Copy>(check: bool, func: T) -> Option<T> {
> +        if check {
> +            Some(func)
> +        } else {
> +            None
> +        }
> +    }
> +
> +    struct VtableHelper<T: MiscDevice> {
> +        _t: PhantomData<T>,
> +    }
> +    impl<T: MiscDevice> VtableHelper<T> {
> +        const VTABLE: bindings::file_operations = bindings::file_operations {
> +            open: Some(fops_open::<T>),
> +            release: Some(fops_release::<T>),
> +            unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
> +            #[cfg(CONFIG_COMPAT)]
> +            compat_ioctl: if T::HAS_COMPAT_IOCTL {
> +                Some(fops_compat_ioctl::<T>)
> +            } else if T::HAS_IOCTL {
> +                Some(bindings::compat_ptr_ioctl)
> +            } else {
> +                None
> +            },
> +            ..unsafe { MaybeUninit::zeroed().assume_init() }
> +        };
> +    }
> +
> +    &VtableHelper::<T>::VTABLE
> +}
> +
> +unsafe extern "C" fn fops_open<T: MiscDevice>(
> +    inode: *mut bindings::inode,
> +    file: *mut bindings::file,
> +) -> c_int {
> +    // SAFETY: The pointers are valid and for a file being opened.
> +    let ret = unsafe { bindings::generic_file_open(inode, file) };
> +    if ret != 0 {
> +        return ret;
> +    }
> +
> +    let ptr = match T::open() {
> +        Ok(ptr) => ptr,
> +        Err(err) => return err.to_errno(),
> +    };
> +
> +    // SAFETY: The open call of a file owns the private data.
> +    unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };
> +
> +    0
> +}
> +
> +unsafe extern "C" fn fops_release<T: MiscDevice>(
> +    _inode: *mut bindings::inode,
> +    file: *mut bindings::file,
> +) -> c_int {
> +    // SAFETY: The release call of a file owns the private data.
> +    let private = unsafe { (*file).private_data };
> +    // SAFETY: The release call of a file owns the private data.
> +    let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
> +
> +    T::release(ptr);
> +
> +    0
> +}
> +
> +unsafe extern "C" fn fops_ioctl<T: MiscDevice>(
> +    file: *mut bindings::file,
> +    cmd: c_uint,
> +    arg: c_ulong,
> +) -> c_long {
> +    // SAFETY: The ioctl call of a file can access the private data.
> +    let private = unsafe { (*file).private_data };
> +    // SAFETY: Ioctl calls can borrow the private data of the file.
> +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +
> +    match T::ioctl(device, cmd as u32, arg as usize) {
> +        Ok(ret) => ret as c_long,
> +        Err(err) => err.to_errno() as c_long,
> +    }
> +}
> +
> +#[cfg(CONFIG_COMPAT)]
> +unsafe extern "C" fn fops_compat_ioctl<T: MiscDevice>(
> +    file: *mut bindings::file,
> +    cmd: c_uint,
> +    arg: c_ulong,
> +) -> c_long {
> +    // SAFETY: The compat ioctl call of a file can access the private data.
> +    let private = unsafe { (*file).private_data };
> +    // SAFETY: Ioctl calls can borrow the private data of the file.
> +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +
> +    match T::compat_ioctl(device, cmd as u32, arg as usize) {
> +        Ok(ret) => ret as c_long,
> +        Err(err) => err.to_errno() as c_long,
> +    }
> +}
> 
> -- 
> 2.46.1.824.gd892dcdcdd-goog
> 

