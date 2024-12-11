Return-Path: <linux-fsdevel+bounces-37055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8439ECB9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 12:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5DC286036
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF94225A3C;
	Wed, 11 Dec 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+TbqgQC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAE1DA634;
	Wed, 11 Dec 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918259; cv=none; b=On1FVhxYh4E13rYS7oDfynj7JG8xcC8XvcsB4oEw4yMSJ4LAvFyufiWqnpjQ7YFMFhUr8ixkJMCOCAwJiigxYNY9+J4rw3XGXZ3CbdviKQSwQgHz8HHzmC/JrtL7q6EdUteOsI5mLZgUCizmB/reyOwQaA2rHH7fL6l1KtIwnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918259; c=relaxed/simple;
	bh=dneghv6loQ5U+SXkgktB72Tmq3utNISUvQRuKuSfFMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9AOVyUdMw20Zi/yVKbpy4ggARBnsL0ykzOYG4DfDFfIOGStFDmQLByZSudSWXR6eAcYQOBn9t8laJkJHJ2PsdsDQIEuHCAnkLedECrslHHpMV9KkkJvLhDyuncKnWad0f+VnvDiVCxC8HKfYtfudKP4TX32DgdMeE8PYPb6lN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+TbqgQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A26CC4CED2;
	Wed, 11 Dec 2024 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733918259;
	bh=dneghv6loQ5U+SXkgktB72Tmq3utNISUvQRuKuSfFMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+TbqgQCbrb/j/wnaZuMqei32/+bZaXrWhTmPJRiXZDo5l1oDTBnBy8BZKNUPzanX
	 0DTipxmCduSSvo5AmhUjRZc6L0EiIT3Qme3cp5oU4wFTgYdVgghzASOuCOXtUVhjz0
	 uwwlq2LBcNIigKZFVjHuWm/jQaiWyQ2S63npCfz4EKbXjp8ME1b31y15JEnI6uHE78
	 KqXItBOX5TddV/ypMEeMLKr23tZZzXcrkua9Hv9bbFOSPV1nt7U6lJOFKTa+usoAu2
	 9URgiWKlUBOp8umAQvc4anRmk1NdXTfhMd1X6v1Wz5IVG5AzRrbDe7Nrj14uzUPIJb
	 feAVuH5EA9XlQ==
Date: Wed, 11 Dec 2024 11:57:17 +0000
From: Lee Jones <lee@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
Message-ID: <20241211115717.GC7139@google.com>
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
 <20241210-miscdevice-file-param-v3-2-b2a79b666dc5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210-miscdevice-file-param-v3-2-b2a79b666dc5@google.com>

On Tue, 10 Dec 2024, Alice Ryhl wrote:

> Providing access to the underlying `struct miscdevice` is useful for
> various reasons. For example, this allows you access the miscdevice's
> internal `struct device` for use with the `dev_*` printing macros.
> 
> Note that since the underlying `struct miscdevice` could get freed at
> any point after the fops->open() call (if misc_deregister is called),
> only the open call is given access to it. To use `dev_*` printing macros
> from other fops hooks, take a refcount on `miscdevice->this_device` to
> keep it alive. See the linked thread for further discussion on the
> lifetime of `struct miscdevice`.
> 
> Link: https://lore.kernel.org/r/2024120951-botanist-exhale-4845@gregkh
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)

Reviewed-by: Lee Jones <lee@kernel.org>

> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 0cb79676c139..75a9d26c8001 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -97,14 +97,14 @@ fn drop(self: Pin<&mut Self>) {
>  
>  /// Trait implemented by the private data of an open misc device.
>  #[vtable]
> -pub trait MiscDevice {
> +pub trait MiscDevice: Sized {
>      /// What kind of pointer should `Self` be wrapped in.
>      type Ptr: ForeignOwnable + Send + Sync;
>  
>      /// Called when the misc device is opened.
>      ///
>      /// The returned pointer will be stored as the private data for the file.
> -    fn open(_file: &File) -> Result<Self::Ptr>;
> +    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<Self::Ptr>;
>  
>      /// Called when the misc device is released.
>      fn release(device: Self::Ptr, _file: &File) {
> @@ -182,24 +182,38 @@ impl<T: MiscDevice> VtableHelper<T> {
>  /// The file must be associated with a `MiscDeviceRegistration<T>`.
>  unsafe extern "C" fn fops_open<T: MiscDevice>(
>      inode: *mut bindings::inode,
> -    file: *mut bindings::file,
> +    raw_file: *mut bindings::file,
>  ) -> c_int {
>      // SAFETY: The pointers are valid and for a file being opened.
> -    let ret = unsafe { bindings::generic_file_open(inode, file) };
> +    let ret = unsafe { bindings::generic_file_open(inode, raw_file) };
>      if ret != 0 {
>          return ret;
>      }
>  
> +    // SAFETY: The open call of a file can access the private data.
> +    let misc_ptr = unsafe { (*raw_file).private_data };
> +
> +    // SAFETY: This is a miscdevice, so `misc_open()` set the private data to a pointer to the
> +    // associated `struct miscdevice` before calling into this method. Furthermore, `misc_open()`
> +    // ensures that the miscdevice can't be unregistered and freed during this call to `fops_open`.
> +    let misc = unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>() };
> +
>      // SAFETY:
> -    // * The file is valid for the duration of this call.
> +    // * This underlying file is valid for (much longer than) the duration of `T::open`.
>      // * There is no active fdget_pos region on the file on this thread.
> -    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
> +    let file = unsafe { File::from_raw_file(raw_file) };
> +
> +    let ptr = match T::open(file, misc) {
>          Ok(ptr) => ptr,
>          Err(err) => return err.to_errno(),
>      };
>  
> -    // SAFETY: The open call of a file owns the private data.
> -    unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };
> +    // This overwrites the private data with the value specified by the user, changing the type of
> +    // this file's private data. All future accesses to the private data is performed by other
> +    // fops_* methods in this file, which all correctly cast the private data to the new type.
> +    //
> +    // SAFETY: The open call of a file can access the private data.
> +    unsafe { (*raw_file).private_data = ptr.into_foreign().cast_mut() };
>  
>      0
>  }
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

-- 
Lee Jones [李琼斯]

