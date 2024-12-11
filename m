Return-Path: <linux-fsdevel+bounces-37054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AFA9ECB9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 12:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A480D168123
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC0225A3C;
	Wed, 11 Dec 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch988awG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57498211A04;
	Wed, 11 Dec 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918223; cv=none; b=b5iKCeO6hRpfMJ0JogXlDkz/3ofCKX2u9sJw87e14rqU3P9NDymDtLv7AaB1qGhmTrBVLSL+OCYFjy41YZK4qT1ivZ45xPrT81iG6OkSuZdqHiiR7Hpo7q+VdW+4ujzzOazgEMUEVV+1ggG3V5Bs7M6AKI2a0bOEgIpxLZYsul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918223; c=relaxed/simple;
	bh=6Qml5Us7FcPtXdADtLX3fKVw9uCBrm4Ero459Rct8mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgxELI2zyGvv/zBLWxKtG524wCj0yH/NsQ9BuKfG2Mo23vw0obOdzm9ZyuAgmEE0EAJJvY6D36/UiBL4LjdcHktJsapTXtt2Xpz00PpxQ6Umnz88ZOPOC1I6czr9yvhsDaeSdg/ntVJRkfivbFXa1L0bHcJEGe9SDHs9wF4KW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch988awG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0164C4CED2;
	Wed, 11 Dec 2024 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733918222;
	bh=6Qml5Us7FcPtXdADtLX3fKVw9uCBrm4Ero459Rct8mY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ch988awGmOLD86fsfrnQM/mFaaHEJLPM8kucybjM6KID4Cm3TMqOsdFlAqw4MIKrV
	 Xu8fby/eEuHMdV4JErP/9t4I8v2LE/OdTPXi8ztpXIM07PZZe87WJHoLY2iG1BB7hG
	 UUTBprGwBqtFD4cAT/XZUGRPGk2653MMH7DY0t1VeiIbHXAmn3UBIcEISPl1g4PFJI
	 j290gz+diBlcFLqOJbS10GxD1oGsqQhvGG3tZOCy5+zkpGQ5l/rct2Q/6F4J8Z1W9u
	 GArkR8Q0AA0IJFXXvMBbzKen/lrowlKhQqn+LrCZCGbbIQQjjn5qOAXKDM58tO7Msb
	 DOasjzmYMeFHA==
Date: Wed, 11 Dec 2024 11:56:51 +0000
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
Subject: Re: [PATCH v3 1/3] rust: miscdevice: access file in fops
Message-ID: <20241211115651.GB7139@google.com>
References: <20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com>
 <20241210-miscdevice-file-param-v3-1-b2a79b666dc5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210-miscdevice-file-param-v3-1-b2a79b666dc5@google.com>

On Tue, 10 Dec 2024, Alice Ryhl wrote:

> This allows fops to access information about the underlying struct file
> for the miscdevice. For example, the Binder driver needs to inspect the
> O_NONBLOCK flag inside the fops->ioctl() hook.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Lee Jones <lee@kernel.org>

> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 7e2a79b3ae26..0cb79676c139 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -11,6 +11,7 @@
>  use crate::{
>      bindings,
>      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> +    fs::File,
>      prelude::*,
>      str::CStr,
>      types::{ForeignOwnable, Opaque},
> @@ -103,10 +104,10 @@ pub trait MiscDevice {
>      /// Called when the misc device is opened.
>      ///
>      /// The returned pointer will be stored as the private data for the file.
> -    fn open() -> Result<Self::Ptr>;
> +    fn open(_file: &File) -> Result<Self::Ptr>;
>  
>      /// Called when the misc device is released.
> -    fn release(device: Self::Ptr) {
> +    fn release(device: Self::Ptr, _file: &File) {
>          drop(device);
>      }
>  
> @@ -117,6 +118,7 @@ fn release(device: Self::Ptr) {
>      /// [`kernel::ioctl`]: mod@crate::ioctl
>      fn ioctl(
>          _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        _file: &File,
>          _cmd: u32,
>          _arg: usize,
>      ) -> Result<isize> {
> @@ -133,6 +135,7 @@ fn ioctl(
>      #[cfg(CONFIG_COMPAT)]
>      fn compat_ioctl(
>          _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        _file: &File,
>          _cmd: u32,
>          _arg: usize,
>      ) -> Result<isize> {
> @@ -187,7 +190,10 @@ impl<T: MiscDevice> VtableHelper<T> {
>          return ret;
>      }
>  
> -    let ptr = match T::open() {
> +    // SAFETY:
> +    // * The file is valid for the duration of this call.
> +    // * There is no active fdget_pos region on the file on this thread.
> +    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
>          Ok(ptr) => ptr,
>          Err(err) => return err.to_errno(),
>      };
> @@ -211,7 +217,10 @@ impl<T: MiscDevice> VtableHelper<T> {
>      // SAFETY: The release call of a file owns the private data.
>      let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
>  
> -    T::release(ptr);
> +    // SAFETY:
> +    // * The file is valid for the duration of this call.
> +    // * There is no active fdget_pos region on the file on this thread.
> +    T::release(ptr, unsafe { File::from_raw_file(file) });
>  
>      0
>  }
> @@ -229,7 +238,12 @@ impl<T: MiscDevice> VtableHelper<T> {
>      // SAFETY: Ioctl calls can borrow the private data of the file.
>      let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
>  
> -    match T::ioctl(device, cmd, arg as usize) {
> +    // SAFETY:
> +    // * The file is valid for the duration of this call.
> +    // * There is no active fdget_pos region on the file on this thread.
> +    let file = unsafe { File::from_raw_file(file) };
> +
> +    match T::ioctl(device, file, cmd, arg as usize) {
>          Ok(ret) => ret as c_long,
>          Err(err) => err.to_errno() as c_long,
>      }
> @@ -249,7 +263,12 @@ impl<T: MiscDevice> VtableHelper<T> {
>      // SAFETY: Ioctl calls can borrow the private data of the file.
>      let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
>  
> -    match T::compat_ioctl(device, cmd, arg as usize) {
> +    // SAFETY:
> +    // * The file is valid for the duration of this call.
> +    // * There is no active fdget_pos region on the file on this thread.
> +    let file = unsafe { File::from_raw_file(file) };
> +
> +    match T::compat_ioctl(device, file, cmd, arg as usize) {
>          Ok(ret) => ret as c_long,
>          Err(err) => err.to_errno() as c_long,
>      }
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

-- 
Lee Jones [李琼斯]

