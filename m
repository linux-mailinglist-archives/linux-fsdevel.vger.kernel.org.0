Return-Path: <linux-fsdevel+bounces-36763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F129E91AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0CC165A1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3D21B1A1;
	Mon,  9 Dec 2024 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpwH2Uja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D221A945;
	Mon,  9 Dec 2024 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742439; cv=none; b=UyKjz/P0icmeV++ES5/cjtlknxmy2qvtPG7z7BuiuY2A5Xa/ru6d/tLo+2X6o7Fr5MvJAn4MJYf3t+kjRSBgNlBNQCDb0xQOg+nieR82ZRu8/GfiU77fQS31hjlWxOKX6PNWfxnB2tJJ7KGOU2j80dosjNbley7zA9jQ3e59NDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742439; c=relaxed/simple;
	bh=BeCQDKFietl7V0MQfR9Sx3qFkwHtJtXFWZXqjmQfg9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW+mpMuKwixP3SWiI/YLW+wBan99awGooOEjzW9tsPd8K8mTtg4+lHsHmtmgYwq3T/zQx/NnvlBU5nTzARQJ8CL+DQjB5msUMxOn3WoPGVo507zbDvi8f5YeMtFei43qOZOomIv9vdfntnuE2ZuhYSwJND4VOHkSrZoKxVnFJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpwH2Uja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06896C4CED1;
	Mon,  9 Dec 2024 11:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733742439;
	bh=BeCQDKFietl7V0MQfR9Sx3qFkwHtJtXFWZXqjmQfg9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpwH2Uja5OL2NUkxGt4v2NjQjXng/8HhngQ4AYYVL811buyhy/W4lhSGQgKU8Vq+0
	 KbCVwtVMmWH52Dz4onyZwhlcCksF1WwZ9CMayeeBe5r5ceEctY974lqx2yku7qpd18
	 R1AnrNBWupNHDW3okuS0SOwsvdB8gpHB8tM757Z2GUgDzusEc63FWPGdzprGMbTj6I
	 3iQUb40NBP1GqP17m607+pPE1LOWtl+N4fpsYBwL9GhAcvVXbV287Tta4hLKp2CefX
	 W7sxNVmxJPgRrrKzjCEoUMXVMTOVOYTJM20+zTmSZlc7kvlVAsLAh15yOQ1t63PP8j
	 vqoj5aizoH72A==
Date: Mon, 9 Dec 2024 12:07:13 +0100
From: Danilo Krummrich <dakr@kernel.org>
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
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
Message-ID: <Z1bPYb0nDcUN7SKK@pollux.localdomain>
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>

On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> Providing access to the underlying `struct miscdevice` is useful for
> various reasons. For example, this allows you access the miscdevice's
> internal `struct device` for use with the `dev_*` printing macros.
> 
> Note that since the underlying `struct miscdevice` could get freed at
> any point after the fops->open() call, only the open call is given
> access to it. To print from other calls, they should take a refcount on
> the device to keep it alive.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 0cb79676c139..c5af1d5ec4be 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -104,7 +104,7 @@ pub trait MiscDevice {
>      /// Called when the misc device is opened.
>      ///
>      /// The returned pointer will be stored as the private data for the file.
> -    fn open(_file: &File) -> Result<Self::Ptr>;
> +    fn open(_file: &File, _misc: &MiscDeviceRegistration<Self>) -> Result<Self::Ptr>;

How is the user of this abstraction supposed to access the underlying struct
miscdevice e.g. from other fops? AFAICS, there is no way for the user to store a
device pointer / reference in their driver private data.

I also think it's a bit weird to pass the registration structure in open() to
access the device.

I think we need an actual representation of a struct miscdevice, i.e.
`misc::Device`.

We can discuss whether we want to implement it like I implemented `pci::Device`
and `platform::Device`, i.e. as an `ARef<device::Device>` or if we do it like
you proposed, but I think things should be aligned.

>  
>      /// Called when the misc device is released.
>      fn release(device: Self::Ptr, _file: &File) {
> @@ -190,14 +190,27 @@ impl<T: MiscDevice> VtableHelper<T> {
>          return ret;
>      }
>  
> +    // SAFETY: The opwn call of a file can access the private data.
> +    let misc_ptr = unsafe { (*file).private_data };
> +    // SAFETY: This is a miscdevice, so `misc_open()` set the private data to a pointer to the
> +    // associated `struct miscdevice` before calling into this method. Furthermore, `misc_open()`
> +    // ensures that the miscdevice can't be unregistered and freed during this call to `fops_open`.
> +    let misc = unsafe { &*misc_ptr.cast::<MiscDeviceRegistration<T>>() };
> +
>      // SAFETY:
> -    // * The file is valid for the duration of this call.
> +    // * The file is valid for the duration of the `T::open` call.
>      // * There is no active fdget_pos region on the file on this thread.
> -    let ptr = match T::open(unsafe { File::from_raw_file(file) }) {
> +    let file = unsafe { File::from_raw_file(file) };
> +
> +    let ptr = match T::open(file, misc) {
>          Ok(ptr) => ptr,
>          Err(err) => return err.to_errno(),
>      };
>  
> +    // This overwrites the private data from above. It makes sense to not hold on to the misc
> +    // pointer since the `struct miscdevice` can get unregistered as soon as we return from this
> +    // call, so the misc pointer might be dangling on future file operations.
> +    //
>      // SAFETY: The open call of a file owns the private data.
>      unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };
>  
> 
> -- 
> 2.47.1.545.g3c1d2e2a6a-goog
> 
> 

